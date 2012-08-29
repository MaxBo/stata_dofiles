clear
version 10
set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
set more off

use "`path'MiD_Wege_cod_bereinig_def.dta", clear

gen Zweck_txt = "W" if Zweck==0
replace Zweck_txt = "A" if Zweck==1
replace Zweck_txt = "d" if Zweck==2
replace Zweck_txt = "B" if Zweck==3
replace Zweck_txt = "E" if Zweck==4
replace Zweck_txt = "P" if Zweck==5 
replace Zweck_txt = "F" if Zweck==6
replace Zweck_txt = "Bgl" if Zweck==7
replace Zweck_txt = "FW" if Zweck==8
replace Zweck_txt = "S" if Zweck==9
replace Zweck_txt = "R" if Zweck==10
replace Zweck_txt = "E.p" if Zweck==11
replace Zweck_txt = "E.ap" if Zweck==12
replace Zweck_txt = "E.b" if Zweck==13

* replace Zweck_txt = "B.b" if Zweck==14
* replace Zweck_txt = "B.s" if Zweck==15
* replace Zweck_txt = "B.k" if Zweck==16
replace Zweck_txt = "Sp" if Zweck==17

bysort hhid pid: gen w_kette1 = "W-" + Zweck_txt if w01==1 & wsid==1
bysort hhid pid: replace w_kette1 = "A-" + Zweck_txt if w01==2 & wsid==1
bysort hhid pid: replace w_kette1 = "FW-" + Zweck_txt if w01>2 & wsid==1
bysort hhid pid: replace w_kette1 = w_kette[_n-1] +  "-" + Zweck_txt if wsid>1
label var w_kette1 "Wegemuster Erhebungstag"

bysort hhid pid: gen w_paar = "W-" + Zweck_txt if w01==1 & wsid==1
bysort hhid pid: replace w_paar = "A-" + Zweck_txt if w01==2 & wsid==1
bysort hhid pid: replace w_paar = "FW-" + Zweck_txt if w01>2 & wsid==1
bysort hhid pid: replace w_paar = Zweck_txt[_n-1] + "-" + Zweck_txt if wsid>1
label var w_paar "Wegepaar Erhebungstag"


* Wohnortbezug + Sortierung
gen WWID= Zweck==0 | w01==1
bysort hhid pid: replace WWID = WWID + WWID[_n-1] if wsid>1
bysort hhid pid: replace WWID = WWID - 1 if WWID>1 & Zweck==0
bysort hhid pid: replace WWID = 0  if WWID[_n-1]==0 & wsid==Anz_W
bysort hhid pid: replace WWID = 0 if Anz_W==1 & wsid==1 & w13==1
bysort hhid pid: replace WWID = 0 if Zweck==0 & WWID[_n-1]==0 & wsid>1
bysort hhid pid: replace WWID = 0 if Zweck==0 & wsid==1


bysort hhid pid WWID: gen wwsid =_n if WWID>0
bysort hhid pid WWID: replace wwsid = 0 if WWID==0
replace wwsid = . if missing(Zweck)

bysort hhid pid WWID: gen WW_Anz =_N
bysort hhid pid WWID: gen WW_anf = wwsid==1
bysort hhid pid WWID: gen WW_end = wwsid==_N
label var WWID "Wegkollektiv Bezug Wohnen"

* kurze Ketten mit einer Aktivität, wohnortbezogen: W-Akt-W
bysort hhid pid WWID: gen ww_kette1 = "W-" + Zweck_txt if wwsid==1
* bysort hhid pid: replace ww_kette1 = "FW-" + Zweck_txt if w01>2 & wsid==1 & WWID>0
* bysort hhid pid: replace ww_kette1 = Zweck_txt[_n-1] + "-" + Zweck_txt if wwsid==1 & wsid>1
bysort hhid pid WWID: replace ww_kette1 = ww_kette1[_n-1] +  "-" + Zweck_txt if WWID>0 & missing(ww_kette1)
* Wegekettenschluss für Wohnwege
bysort hhid pid: replace ww_kette1=ww_kette1 + "-W" if Anz_W==1 & WWID>0
bysort hhid pid: replace ww_kette1=ww_kette1 + "-W" if Anz_W==wsid & (Zweck>1 & Zweck!=8) & Anz_W>1 & WWID>0
bysort hhid pid: replace ww_kette1=ww_kette1 + "-W" if ww_kette1=="W-R" & w13==5
label var ww_kette1 "Wegekette wohnbasiert"

* Anpassung der wohnortbezogenen Wegeanzahl nach tatsächlich durchgeführten Wegen
bysort hhid pid WWID: gen WW_Anz_k = _N
bysort hhid pid WWID: replace WW_Anz_k = WW_Anz_k + 1 if  (Zweck>1 & Zweck!=8 & Zweck!=10) & Anz_W>1 & WWID>0 & WW_end

replace ww_kette1 = "" if missing(Zweck)


* Arbeitsortbezug + Sortierung
* 263 Wegeketten mit mehr als einem Arbeitsweg
sort hhid pid wsid
gen WAID = Zweck==1 | w01==2
bysort hhid pid: egen arbeitskette = sum (WAID)
sort hhid pid wsid
label var arbeitskette "Wegekette mit mind. einem Arbeitsweg"
bysort hhid pid: replace WAID = 0 if arbeitskette<2

bysort hhid pid: replace WAID = WAID + WAID[_n-1] if wsid>1 & arbeitskette>1
bysort hhid pid: replace WAID = WAID - 1 if WAID>1 & Zweck==1

* bysort hhid pid: replace WAID = 0 if Zweck==1
* bysort hhid pid: replace WAID = WAID - 1 if WAID>1 & Zweck[_n-1]==1

bysort hhid pid WAID: gen WASID =_n if WAID>0
* bysort hhid pid WAID: replace WAID = WAID-1  if Zweck==1


bysort hhid pid WAID: gen WA_Anz =_N if WAID>0
bysort hhid pid WAID: gen WA_anf = WASID==1 if WAID>0
bysort hhid pid WAID: gen WA_end = WASID==_N if WAID>0
bysort hhid pid WAID: replace WA_end = 0 if Zweck!=1 & wsid==Anz_W

* Ausschluss von Nachtschichtarbeitern (am Anfang und am Ende des Tages ein Arbeitsweg, z.B. bei HHID )
bysort hhid pid WAID: replace WA_end = 0 if Zweck==1 & wsid==WASID[_N] & wsid==Anz_W

label var WAID "Wegkollektiv Bezug Arbeit"
* kurze Ketten mit einer Aktivität, arbeitsortbezogen: A-Akt-W

bysort hhid pid WAID: gen wa_kette1= Zweck_txt if WASID==1 & WAID==1
* bysort hhid pid WAID: replace wa_kette1  = w_paar if WASID==1 & WAID==1 & wsid>1
bysort hhid pid WAID: replace wa_kette1 = wa_kette1[_n-1] +  "-" + Zweck_txt if WAID>0 & missing(wa_kette1) & WASID>1
* bysort hhid pid WAID: replace wa_kette1 = wa_kette1 + "-A" if WA_end==1
label var wa_kette1 "Wegekette arbeitsbasiert"
* Filter für wohn- und arbeitsortbezogene Wege:

gen filter_w = filter & WW_end & WWID>0 & (Zweck!=8 & Zweck!=1 & Zweck!=2)
gen filter_a = filter & WA_end==1 & WAID>0

label var filter_w "Filter für wohnortbasierte Wegeketten"
label var filter_a "Filter für arbeitsortbasierte Wegeketten"


sort hhid pid wsid


* Wege in geschlossenen wohnortsbezogenen Wegeketten
gen komplex = WW_Anz_k  > 2 & WW_Anz<. & WWID>0
replace komplex = . if missing(WWID) | WWID==0
label var komplex "Weg in komplexer wohnortsbezogener Wegekette"
label value komplex jn

* Wege in arbeitsortbezogenen Wegeketten
gen komplex2 = WA_Anz > 3 & WA_Anz<. 
replace komplex2 = . if WAID==0
label var komplex2 "Weg in komplexer arbeitsortbezogener Wegekette"
label value komplex2 jn




drop Zweck_txt ww_kette1 wa_kette1
* tab Zweck komplex if filter & WW_end==0, row

replace w12 = 0 if missing(w12)
replace Anz_W = 0 if wsid==0
gen Anz_W_ges = Anz_W + w12


drop arbeit



drop if missing(wsid)




* recode von Zweck nach Hierarchie
recode Zweck (1=1 "Arbeit") (3=2 "Bilden") (2=3 "dienstl.") (5=4 "Erledigung") (6=5 "Freizeit") (17=6 "Sport") (13=7 "Einkaufsbummel")/*
*/ (12=8 "allg. Einkauf") (11=9 "tägl. Einkauf") (10=10 "Freizeit ohne Zweck") (7=11 "Begleitung") (8=12 "Besuch/fremde Wohnung") (9=13 "sonstiges") (0=14 "Wohnen"), gen(zweck_rec)
sort hhid pid wsid
* min/max bilden nach hhid pid WWID
bysort hhid pid WWID: egen hz = min(zweck_rec) if filter==1 & stichtag<6

label value hz zweck_rec

save "`path'MiD_Wege_cod_bereinig_def_wegeketten.dta", replace

