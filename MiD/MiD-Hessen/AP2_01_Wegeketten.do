clear
set memory 700m
local path "C:\MiD_RheinMain\Daten\Rohdaten\STATA\"

use "`path'MiD_Wege_Hessen_cod_bereinig_def.dta", clear


tab Zweck, gen(Zweck_)
* rename Zweck_1 Wohnen
* rename Zweck_2 Arbeit
* rename Zweck_3 Dienstlich
* rename Zweck_4 Bilden
* rename Zweck_5 Einkauf
* rename Zweck_6 Erledigung
* rename Zweck_7 Freizeit
* rename Zweck_8 Begleitung
* rename Zweck_9 Unterkunft
* rename Zweck_10 Sonstige
* rename Zweck_11 Eink_tägl
* rename Zweck_12 Eink_allg
* rename Zweck_13 Eink_bum

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

bysort HHID PID: gen w_kette1 = "W-" + Zweck_txt if W01==1 & WSID==1
bysort HHID PID: replace w_kette1 = "A-" + Zweck_txt if W01==2 & WSID==1
bysort HHID PID: replace w_kette1 = "FW-" + Zweck_txt if W01>2 & WSID==1
bysort HHID PID: replace w_kette1 = w_kette[_n-1] +  "-" + Zweck_txt if WSID>1

bysort HHID PID: gen w_paar = "W-" + Zweck_txt if W01==1 & WSID==1
bysort HHID PID: replace w_paar = "A-" + Zweck_txt if W01==2 & WSID==1
bysort HHID PID: replace w_paar = "FW-" + Zweck_txt if W01>2 & WSID==1
bysort HHID PID: replace w_paar = Zweck_txt[_n-1] + "-" + Zweck_txt if WSID>1


* Wohnortbezug + Sortierung
gen WWID= Zweck_1 | W01==1
bysort HHID PID: replace WWID = WWID + WWID[_n-1] if WSID>1
bysort HHID PID: replace WWID = WWID - 1 if WWID>1 & Zweck_1
bysort HHID PID: replace WWID = 0  if WWID[_n-1]==0 & WSID==Anz_W
bysort HHID PID: replace WWID = 0 if Anz_W==1 & WSID==1 & W13==1
bysort HHID PID: replace WWID = 0 if Zweck_1 & WWID[_n-1]==0 & WSID>1
bysort HHID PID: replace WWID = 0 if Zweck_1 & WSID==1

bysort HHID PID WWID: gen WWSID =_n if WWID>0
bysort HHID PID WWID: replace WWSID = 0 if WWID==0


bysort HHID PID WWID: gen WW_Anz =_N
bysort HHID PID WWID: gen WW_anf = WWSID==1
bysort HHID PID WWID: gen WW_end = WWSID==_N
label var WWID "Wegkollektiv Bezug Wohnen"

* kurze Ketten mit einer Aktivität, wohnortbezogen: W-Akt-W
bysort HHID PID WWID: gen ww_kette1 = "W-" + Zweck_txt if WWSID==1
* bysort HHID PID: replace ww_kette1 = "FW-" + Zweck_txt if W01>2 & WSID==1 & WWID>0
* bysort HHID PID: replace ww_kette1 = Zweck_txt[_n-1] + "-" + Zweck_txt if WWSID==1 & WSID>1
bysort HHID PID WWID: replace ww_kette1 = ww_kette1[_n-1] +  "-" + Zweck_txt if WWID>0 & missing(ww_kette1)
* Wegekettenschluss für Wohnwege
bysort HHID PID: replace ww_kette1=ww_kette + "-W" if Anz_W==1 & WWID>0
bysort HHID PID: replace ww_kette1=ww_kette + "-W" if Anz_W==WSID & (Zweck>1 & Zweck!=8) & Anz_W>1 & WWID>0

* Anpassung der wohnortbezogenen Wegeanzahl nach tatsächlich durchgeführten Wegen
bysort HHID PID WWID: gen WW_Anz_k = _N
bysort HHID PID WWID: replace WW_Anz_k = WW_Anz_k + 1 if  (Zweck>1 & Zweck!=8 & Zweck!=10) & Anz_W>1 & WWID>0 & WW_end


* Arbeitsortbezug + Sortierung
* 263 Wegeketten mit mehr als einem Arbeitsweg
gen WAID = Zweck_2 | W01==2
bysort HHID PID: egen arbeitskette = sum (WAID)
label var arbeitskette "Wegekette mit mind. einem Arbeitsweg"

bysort HHID PID: replace WAID = 0 if arbeitskette<2

bysort HHID PID: replace WAID = WAID + WAID[_n-1] if WSID>1 & arbeitskette>1
bysort HHID PID: replace WAID = WAID - 1 if WAID>1 & Zweck_2==1

bysort HHID PID: replace WAID = 0 if Zweck==1 & WSID==1

* bysort HHID PID: replace WAID = 0 if WAID[_n-1]==0 & WSID==Anz_W
* bysort HHID PID: replace WAID = 0 if Anz_W==1 & WSID==1 & W13==2
* bysort HHID PID: replace WAID = 0 if Zweck_2 & WAID[_n-1]==0 & WSID>1
* bysort HHID PID: replace WAID = 0 if Zweck_2 & WSID==1

bysort HHID PID WAID: gen WASID =_n if WAID>0

bysort HHID PID WAID: gen WA_Anz =_N if WAID>0
bysort HHID PID WAID: gen WA_anf = WASID==1 if WAID>0
bysort HHID PID WAID: gen WA_end = WASID==_N if WAID>0
bysort HHID PID WAID: replace WA_end = 0 if Zweck_2==0 & WSID==Anz_W

* Ausschluss von Nachtschichtarbeitern (am Anfang und am Ende des Tages ein Arbeitsweg, z.B. bei HHID )
bysort HHID PID WAID: replace WA_end = 0 if Zweck_2==1 & WSID==WASID[_N]

label var WAID "Wegkollektiv Bezug Arbeit"
* kurze Ketten mit einer Aktivität, arbeitsortbezogen: A-Akt-W

bysort HHID PID WAID: gen wa_kette1="A-" + Zweck_txt if WASID==1
bysort HHID PID WAID: replace wa_kette1 = wa_kette1[_n-1] +  "-" + Zweck_txt if WAID>0 & missing(wa_kette1)

* Filter für wohn- und arbeitsortbezogene Wege:

gen filter_w = filter & WW_end & WWID>0 & (Zweck!=8 & Zweck!=1 & Zweck!=2)
gen filter_a = filter & WA_end==1 & WWID>0 

* br  HHID PID WSID W04 W04_DZW W01 W13 Zweck WWID WWSID WW_Anz WW_anf WW_end ww_kette1

* Auswertung wohnortbezogenen einfache Wegeketten 
* tabstat  wegedauer WEGKM_K TEMPO if WW_Anz_k<3 & filter_w, by(ww_kette1) stat(mean count)
* Auswertung wohnortbezogene komplexe Wegeketten
* tabstat  wegedauer WEGKM_K TEMPO if WW_Anz_k==3 & filter_w, by(ww_kette1) stat(mean count)
* tabstat  wegedauer WEGKM_K TEMPO if WW_Anz_k==4 & filter_w, by(ww_kette1) stat(mean count)
* tabstat  wegedauer WEGKM_K TEMPO if WW_Anz_k==5 & filter_w, by(ww_kette1) stat(mean count)
* tabstat  wegedauer WEGKM_K TEMPO if WW_Anz_k>5 & filter_w, by(ww_kette1) stat(mean count) labelwidth(32)


sort HHID PID WSID

* Ausgaben
* wohnortbezogene einfache Wegeketten 
* tab  ww_kette1 if filter &  WWID>0 &  WW_Anz<3 &  WW_end & WWID>0
* wohnortbezogene komplexe Wegeketten
* tab  ww_kette1 if filter &  WWID>0 &  WW_Anz>2 &  WW_end & WWID>0



* Wege in geschlossenen wohnortsbezogenen Wegeketten
gen komplex = WW_Anz_k  > 2 & WW_Anz<.
label var komplex "Weg in komplexer wohnortsbezogener Wegekette"
label value komplex jn
tab Zweck komplex if filter_w, row chi2
tab Zweck komplex [iw= W_GPV] if filter_w, row

* Wegelängen in wohnortsbezogenen Wegeketten
gen tempo =  round(WEGKM_K/(wegedauer/60),1)
* gen tempo_10 = round(tempo,10)
bysort HHID PID WWID: egen w_km_kette = sum(WEGKM_K) if WWID>0
bysort HHID PID WWID: egen w_min_kette = sum(wegedauer) if WWID>0
bysort HHID PID WWID: egen w_tempo_kette = sum(tempo) if WWID>0

* Verkehrsmittelnutzung in Wegekette

