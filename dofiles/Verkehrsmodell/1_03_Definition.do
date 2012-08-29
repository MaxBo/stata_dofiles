clear
version 10
set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
set more off

use "`path'MiD_auto_cod.dta", clear
bysort hhid pid: egen Anz_auto_Person = count(vmid) if pid<.
label var Anz_auto_Person "Anzahl der Pkw je Person"
save "`path'MiD_autos_cod_def.dta", replace

duplicates drop hhid pid, force

version 12
merge n:m hhid using "X:\Daten\KiD_MiD_internerGebrauch\MiD2008\Regionaldatensatz\Daten\STATA\MiD2008_Regionalfile.dta", gen(regio)


save "`path'MiD_auto_cod_def_red.dta", replace

use "`path'MiD_Personen_cod.dta", clear
merge hhid pid using "`path'MiD_HH_cod_transform.dta", sort keep(h04_1 h04_2 h04_3 h040_1 h040_2 h040_3 h040_4 h040_5 h040_6 h040_7 h040_8  anzerw hhtyp bland westost polgk rtyp rtypd7 ktyp ktyp_zsg sgtyp sgtypd hp_alter hp_sex hp_beru hp_bkat hp_taet hp_besch hp_pkwfs h02 h01 hheink oek_stat) uniqusing
* Führerscheinerwerbsalter
gen Alter_fS =   p061_3j- (stich_j  - hp_alter) if p061_3j<. | hp_alter<.
label var Alter_fS "Alter, in dem die Person den Führerschein erworben hat"
replace Alter_fS= . if Alter_fS<=16
gen fs_ew = Alter_fS < .
gen alter_fs = hp_alter if fs_ew==0 & hp_pkwfs == 0
replace alter_fs = Alter_fS if fs_ew==1 & hp_pkwfs==1


* Mobilitätswerkzeuge für Personen und Haushalte definieren

gen hh_ohne_pkw = h04_3==0
label var hh_ohne_pkw "HH ohne Pkw"
label value hh_ohne_pkw jn

gen hh_mofa = h04_1>0
label var hh_mofa "Haushalt hat mind. ein Mofa"

gen hh_rad  = h04_2>0
label var hh_rad "Haushalt hat mind. ein Fahrrad"

gen hat_zeitkarte =  p070>2 & p070<6 
label var hat_zeitkarte "Person hat Zeitkarte"

gen hh_zeitkarte = p070_a==3 | p070_a==4
bysort hhid: egen hh_zeit = sum(hh_zeitkarte)
replace hh_zeitkarte = 1 if hh_zeit > 0 & hh_zeit<.
drop hh_zeit
label var hh_zeitkarte "Haushalt verfügt über mind. eine personenunabhängige Zeitkarte"


gen zeitkarte = 1 if hat_zeitkarte==1
replace zeitkarte =2 if hat_zeitkarte==0 & hh_zeitkarte==1
replace zeitkarte = 3 if hat_zeitkarte==0 & hh_zeitkarte==0
label var zeitkarte "ÖV-Zeitkartenbesitz (Kat.)"
label define zeitkarte 1 `"personengebundene Zeitkarte"' 2 `"personenungebundene Zeitkarte"' 3 `"keine Zeitkarte im Haushalt"', modify
label value zeitkarte zeitkarte


* Imputieren von Haltestellenentfernungen für Missings und Kinder unter 14 Jahre auf HH Ebene
* Hilfe zur Erstellung einer Zufallsziehung
* Eine Zufällig generierte Kennung für alle Missings in p052 generieren: 
sort p052 hp_alter pid 
gen Random = .
replace Random = 1 if mod(_n,2) == 0 
replace Random = 0 if mod(_n,2) == 1 
replace Random = . if p052 < 9
sort hhid pid

* Kontrolle von ungleichen Antworten innerhalb von Haushalten
by hhid: gen flag_052 = 1 if p052 != p052[_n-1] & p052<97 & p052[_n-1] < 97

recode p052(.a=98) (.c=98), gen(p052_ka)
* Missings imputieren:
sort hhid pid
by hhid: replace p052_ka = p052_ka[_n-1] if p052_ka == 98 & Random == 1 | p052_ka == . & Random == 1
by hhid: replace p052_ka = p052_ka[_n+1] if p052_ka == 98 & Random == 0 | p052_ka == . & Random == 0
by hhid: replace p052_ka = p052_ka[_n-1] if p052_ka == 98 | p052_ka == . 
by hhid: replace p052_ka = p052_ka[_n+1] if p052_ka == 98 | p052_ka == . 
drop Random
label values p052_ka p052

* Kontrolle von ungleichen Antworten innerhalb von Haushalten
by hhid: gen flag_054 = 1 if p054 != p054[_n-1] & p054  <97 & p054[_n-1] < 97

sort p054 hp_alter pid 
gen Random = .
replace Random = 1 if mod(_n,2) == 0 
replace Random = 0 if mod(_n,2) == 1 
replace Random = . if p054 < 9
sort hhid pid

recode p054(.a=98) (.c=98), gen(p054_ka)
sort hhid pid
by hhid: replace p054_ka = p054_ka[_n-1] if p054_ka == 98 & Random == 1 | p054_ka == . & Random == 1
by hhid: replace p054_ka = p054_ka[_n-1] if p054_ka == 98 & Random == 0 | p054_ka == . & Random == 0
by hhid: replace p054_ka = p054_ka[_n-1] if p054_ka == 98 | p054_ka == .
by hhid: replace p054_ka = p054_ka[_n+1] if p054_ka == 98 | p054_ka == .
drop Random
label values p054_ka p052



* Variable für Ausbildungsverkehre nach Absprache mit dem Regionalverband
recode hp_besch (4=1 "Auszubildende(r)") (5=2 "Schüler(in) an einer Grundschule") (5=3 "Schüler(in) an einer weiterführenden Schule") (6=4 "Student(in)") (13=5 "Wehr- oder Zivildienstleistende(r), Freiwilligendienst") (9/14=6 "Andere")(nonmissing = .), gen(hp_ausb)
label var hp_ausb "Personengruppen nach Schulart/Ausbildungsart"
replace hp_ausb = 2 if p14b==9 & hp_alter>4 & hp_alter<13
replace hp_ausb = 3 if p14b>9 & p14b<15
replace hp_ausb = 3 if hp_besch==5 & hp_alter>12 & hp_alter<23
replace hp_ausb = . if p14b==8
replace hp_ausb = . if (p14b==9 | hp_ausb==2) & (hp_alter<5 | hp_alter>12)
replace hp_ausb = . if p14b>9 & p14b<15 & hp_alter<9

version 10
merge hhid pid using "`path'MiD_auto_cod_def_red.dta", sort uniqusing keep(Anz_auto_Person) _merge(upd_auto1)
version 12
drop if missing(pid)
gen Pkw_eigen = Anz_auto_Person
replace Pkw_eigen = 0 if missing(Anz_auto_Person)
label var Pkw_eigen "Anzahl Pkw der jeweiligen Person"
bysort hhid: egen Anz_auto_bel_HH = sum(Anz_auto_Person)
bysort hhid: gen Anz_auto_frei = h04_3 - Anz_auto_bel_HH 
drop if missing(pid)
label var Anz_auto_bel_HH "Anzahl der personengebundenen Pkw im Haushalt"
label var Anz_auto_frei "Anzahl der ungebundenen Pkw im Haushalt"

replace Anz_auto_Person=0 if h04_3==0
replace Anz_auto_Person=0 if hp_alter<17
replace Anz_auto_Person=0 if hp_pkwfs==0
replace Anz_auto_Person=0 if Anz_auto_frei==0 & missing(Anz_auto_Person)
bysort hhid pid: gen ohne_pw = missing(Anz_auto_Person)
label var ohne_pw "Personen ohne eigenen Pkw"

bysort hhid: egen anz_fS_ohne_pw=sum(hp_pkwfs) if ohne_pw==1
label var anz_fS_ohne_pw "Summe Personen mit Führerschein aber ohne eigenen Pkw im Haushalt"
bysort hhid: egen anz_fS=sum(hp_pkwfs)
label var anz_fS "Summe Personen mit Führerschein im Haushalt"
bysort hhid: egen anz_P_auto = count(Anz_auto_Person)
label var anz_P_auto "Anzahl Personen mit mindestens einen eigenen Pkw"

bysort hhid: replace Anz_auto_Person = Anz_auto_frei/ anz_fS_ohne_pw if ohne_pw==1

gen PKW_VERF_neu = 1 if Anz_auto_Person >=1 | (anz_P_auto < anz_fS & hp_pkwfs==1)
replace PKW_VERF_neu = 2 if (Anz_auto_Person < 1 & Anz_auto_Person>0) | (h04_3>=anz_fS & missing(PKW_VERF_neu) & hp_pkwfs==1)
replace PKW_VERF_neu = 3 if Anz_auto_frei==0 & h04_3<. & h04_3>0 &  hp_pkwfs==1 & missing(PKW_VERF_neu)
replace PKW_VERF_neu = 5 if h04_3==0 | missing(h04_3) & missing(PKW_VERF_neu)
replace PKW_VERF_neu = 4 if h04_3<. & h04_3>0  & (hp_pkwfs==0)

label define PKW_VERF_neu 1 `"Pkw immer verfügbar"' 2 `"Pkw teilweise als Fahrer verfügbar"' 3 `"Pkw selten als Fahrer verfügbar"' 5 `"kein Pkw im HH"' 4 `"Pkw nur als Beifahrer verfügbar"', modify
label value PKW_VERF_neu PKW_VERF_neu
label var PKW_VERF_neu "Pkw-Verfügbarkeit des HH-Teilnehmers nach neuer Definition (5 Klassen)"

gen Pkw_eigen2 = Pkw_eigen>0
label value Pkw_eigen2 jn
label var Pkw_eigen2 "mind. ein eigener Pkw vorhanden"

gen Anz_auto_frei2 = Anz_auto_frei>0
label value Anz_auto_frei2 jn
label var Anz_auto_frei2 "mind. ein Pkw personenunabhängiger Pkw im Haushalt vorhanden"

label value  p05?_ka p052

gen p05_3 = 1 if p054_ka<4 | p052_ka<4
replace p05_3 = 2 if missing(p05_3) & (p054_ka==4 | p052_ka==4) 
replace p05_3 = 3 if (p054_ka<. | p052_ka<.)  & missing(p05_3)

label var p05_3 "Entfernung zur nächsten Haltestelle (Bus/Schiene)"
label define p05_3 1 `"<=400m"' 2 `"400m - 1000m"' 3 `"> 1000m"', add modify
label value p05_3 p05_3


* generierte Variablen für die Modelle

recode hheink (2/3=1 "unter 1500") (4/5=2 "1500-2600")(6/7=3 "2600-3600")(8/9=4 "3600-4600")(10/15=5 "über4600"), gen(hheink_5)
gen hp_alter2 = hp_alter*hp_alter
recode hhtyp (2/3=1 "EPH") (4/6=2 "2PH")  (7=3 "3und mehr ERW" ) (8/11=4 "HH mit Kind") , gen(hhtyp_4)
recode hhtyp (2/3=1 "EPH") (4/7=2 "2und mehr ERW") (8/11=3 "HH mit Kind") , gen(hhtyp_3)
recode hp_besch (1=1 "Berufstätig - Vollzeit") (2/3=2 "Berufstätig - Teilzeit") (4=3 "Auszubildene") (5=4 "Schüler") (6=5 "Student") (7/8=6 "Kind") (9/11=7 "daheim") (12=8 "Rentner") (13/14=9 "andere"), gen(hp_besch_aggr)

replace hp_besch=14 if hp_alter>18 & (hp_besch==7 | hp_besch==8)
* drop verh_perg
gen verh_perg = 1 if hp_alter<7
replace verh_perg = 2 if hp_alter>4 & hp_alter<14 & (hp_besch==5 | p14b==9)
replace verh_perg = 3 if hp_alter>8 & hp_alter<17 & (hp_besch==5 | (p14b>9 & p14b<15))
replace verh_perg = 2 if hp_alter>5 & hp_alter<11 & missing(verh_perg)
replace verh_perg = 3 if hp_alter>10 & hp_alter<16 & missing(verh_perg)
replace verh_perg =4 if hp_alter>16 & hp_besch==5
replace verh_perg =5 if hp_alter>15 & hp_besch==4
replace verh_perg =6 if hp_besch==6 & hp_alter<41
replace verh_perg =7 if (hp_besch==1 | hp_besch==13) & missing(verh_perg)
replace verh_perg =8 if (hp_besch==2 | hp_besch==3)  & missing(verh_perg)
replace verh_perg =9 if (hp_besch==11 | hp_besch==10)  & missing(verh_perg)
replace verh_perg =10 if missing(verh_perg) & hp_beru==2 
replace verh_perg =11 if hp_alter>60 & hp_beru==2 & hp_besch==12
replace verh_perg =11 if hp_alter>60 & hp_alter<75 & missing(verh_perg) & hp_besch==12
replace verh_perg =12 if hp_alter>74 & hp_beru==2 & hp_besch==12
replace verh_perg =12 if hp_alter>74 & missing(verh_perg) & hp_besch==12
* label value verh_perg verh_perg

label define verh_perg 1 `"Kleinkind"' 2 `"Grundschüler"' 3  `"Schüler-Mittelstufe"' 4  `"Schüler-Oberstufe"' 5  `"Berufsschüler"', modify
label define verh_perg 6 `"Student"' 7 `"Vollzeitbeschäftigter"' 8 `"Teilzeitbeschäftigter"' 9 `"nicht erwerbstätig: Hausfrau/-mann"' 10 `"nicht erwerbstätig: sonstige"', modify
label define verh_perg 11 `"aktiver Rentner"' 12  `"inaktiver Rentner"', modify

label value verh_perg verh_perg

version 12
merge n:m hhid using "X:\Daten\KiD_MiD_internerGebrauch\MiD2008\Regionaldatensatz\Daten\STATA\MiD2008_Regionalfile.dta", gen(regio)

recode gtyp (9=12 "Kernstadt") (10=13 "OZ/MZ städtischer Raum") (11=14 "sonstige Gemeinden städtischer Raum") /*
*/ (7 12 14 16=15 "OZ/MZ in ländl. Kreise") (8 13 15 17=16 "sonstige Gemeinden in ländl. Kreise") (1/6=.a "sonstige"), gen(rtyp_tuhh)

tabout  rtyp_tuhh  verh_perg [iw=p_gew]  using "M:\Nachfragedaten\Berechnungsergebnisse\verh_besch.txt", replace c(freq row col)  layout(rb)
tabout rtyp_tuhh  verh_perg  [iw=p_gew] if hp_alter>18 & hp_alter<26  using "M:\Nachfragedaten\Berechnungsergebnisse\verh_besch_19_25.txt", replace c(freq row col)  layout(rb)
tabout rtyp_tuhh  verh_perg  [iw=p_gew] if hp_alter>15 & hp_alter<20  using "M:\Nachfragedaten\Berechnungsergebnisse\verh_besch_16_19.txt", replace c(freq row col)  layout(rb)

save "`path'MiD_Personen_cod_def.dta", replace


use "`path'MiD_Wege_cod_bereinig.dta", clear
* Wegeende, Weganfang, Anzahl dokumentierter Wege
version 10
merge hhid pid using "`path'MiD_Personen_cod_def.dta", sort uniqusing keep(verh_perg Anz_auto_Person PKW_VERF_neu ohne_pw hh_ohne_pkw hh_mofa hh_rad hh_zeitkarte p03* p04* hat_zeitkarte zeitkarte hp_ausb p05_3    hheink_5  hhtyp_4 hhtyp_3 hp_alter2 p052_ka p054_ka p01_1  hp_besch_aggr) _merge(update_PkwVerf)
* drop if missing(wsid)
version 12
* Variable w13: umkodieren zu binominaler Variable, die Außenorientierung anzeigt.
recode w13 (3=0 "innerorts") (4=1 "außerorts") (1 2 5 =.d), gen(Zielwahl)
* Labelanpassung w13
label define w13 3 `"and.Z.innerhalb der Stadt oder des Ortes"'  4 `"and.Z.außerhalb der Stadt oder des Ortes"', add modify
label value w13 w13 

bysort hhid pid: gen Anz_W =_N
label var Anz_W "Anzahl Wege Person am Stichtag (nach Bereinigung)"
replace Anz_W = 0 if missing(wsid)

* Als Filterfunktion
bysort hhid pid: gen w_ende = wsid==_N
label var w_ende "letzter Weg des Stichtages" 
bysort hhid pid: gen w_anf = wsid== 1
label var w_anf "erster Weg des Stichtages"
sort hhid pid wsid
bysort hhid pid: replace w01=1 if w01==.a & w13[_n-1]==5 & w04[_n-1]> 3 & w04[_n-1]<11 & wsid!=1
bysort hhid pid: replace w01=1 if w13[_n-1]==1
* bysort hhid pid: replace w01=1 if w01==.a &  w13[_n-1]==5 & w01[_n-1]==1
bysort hhid pid: replace w01=1 if w01==.a &  w13[_n-1]==5

* Wegezwecke anpass, Rückwege
* hwzweck eignet sich nicht für Wegekettenbildung, weil Hin- und Rückweg mit einem Wegezweck versehen sind.
* Deswegen werden die Kategorien aus hwzweck für die Variable Zweck verwendet.
label define w04 33 "Zweitunterkunft (Hotel, Pension, Zweitwohnung)" 34 "Verkehrsknoten", add modify
label value w04 w04

sort hhid pid wsid

gen Zweck = 1 if w04==1
label var Zweck "angepasster Wegezweck"
replace Zweck = 2 if w04==2
replace Zweck = 3 if w04==3 | w04==31 | w04==32 
replace Zweck = 4 if w04==4
replace Zweck = 6 if w04==7
replace Zweck = 10 if w13==5 | w04_dzw==711|w04_dzw==710|w04_dzw==712
/* Diese Zwecke implizieren, ein Rundweg zu sein, daher wird w13 angepasst */
replace w13 = 5 if Zweck == 10

replace Zweck = 5 if w04==5 | w04_dzw==504

replace Zweck = 7 if w04 ==6 | w04==11 | w04_dzw==11 | w04_dzw==716

replace Zweck = 1 if w13==2 & w04==10

replace Zweck = 8 if w04_dzw==701 | w04_dzw==707 | w04==33
replace Zweck = 11 if w04_dzw==501
replace Zweck = 12 if w04_dzw==502|w04_dzw==505
replace Zweck = 13 if w04_dzw==503
replace Zweck = 0 if w13==1 & w04==10
replace Zweck = 0 if w04 ==8

replace Zweck = 10 if w01==1 & w13==1
/* Diese Zwecke implizieren, ein Rundweg zu sein, daher wird w13 angepasst */
replace w13 = 5 if Zweck == 10

* replace Zweck = 14 if w04==3
* replace Zweck = 15 if w04==31
* replace Zweck = 16 if w04==32


* Behandlung der Rückwege
* Hintergrund: Rückwege wurden aus Befragungsökonomischen Gründen eingeführt, um die Interviewlänge zu verkürzen.
* Aus der Logik heraus werden anhand vorheriger Wege bzw. Start- und Zielorte der Wegezweck ermittelt.
* Routine zur Belegung von Rückwegen
* gen miss_akt = missing(Zweck) & w04==9
* bysort hhid pid: egen miss = sum(miss_akt)
* br hhid pid wsid Zweck w04  w04_dzw ST_STD ST_MIN  EN_STD EN_MIN w01 w13 if miss>0

* Fremde Wohnung entspricht einer Unterkunft bzw. Besuch einer fremden Wohnung oder einer sonstigen Bleibe, z.B. Hotel, Pension, Zeltplatz u.a.
* Rückwege von Begleitwegen werden als Weg in eine fremde Wohnung umkodiert.// Änderung abhängig von Begleitzweck!!!
bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & (w04_dzw[_n-2]==701 | w04_dzw[_n-2]==707 | w04_dzw[_n-2]==718 | w04[_n-2]==33)
bysort hhid pid: replace Zweck = 1 if missing(Zweck) & w04==9 & w04[_n-2]==1
bysort hhid pid: replace Zweck = 1 if missing(Zweck) & w04==9 & w01[_n-1]==2
bysort hhid pid: replace Zweck = 2 if missing(Zweck) & w04==9 & w04[_n-2]==2
bysort hhid pid: replace Zweck = 3 if missing(Zweck) & w04==9 & (w04[_n-2]==3 | w04[_n-2]==31 | w04[_n-2]==32 )
bysort hhid pid: replace Zweck = 6 if missing(Zweck) & w04==9 & (w04_dzw[_n-2]==704 | w04_dzw[_n-2]==714 | w04_dzw[_n-2]==713 | w04_dzw[_n-2]==715 | w04_dzw[_n-2]==702)
bysort hhid pid: replace Zweck = 14 if missing(Zweck) & w04==9 & w04[_n-2]==3
bysort hhid pid: replace Zweck = 15 if missing(Zweck) & w04==9 & ( w04[_n-2]==31)
bysort hhid pid: replace Zweck = 16 if missing(Zweck) & w04==9 & ( w04[_n-2]==32 )
bysort hhid pid: replace Zweck = 11 if missing(Zweck) & w04==9 & w04_dzw[_n-2]==501
bysort hhid pid: replace Zweck = 12 if missing(Zweck) & w04==9 & (w04_dzw[_n-2]==502|w04_dzw[_n-2]==505)
bysort hhid pid: replace Zweck = 13 if missing(Zweck) & w04==9 & w04_dzw[_n-2]==503
bysort hhid pid: replace Zweck = 4 if missing(Zweck) & w04==9 & w04[_n-2]==4
bysort hhid pid: replace Zweck = 5 if missing(Zweck) & w04==9 & w04[_n-2]==5
bysort hhid pid: replace Zweck = 7 if missing(Zweck) & w04==9 & Zweck[_n-2]==7
bysort hhid pid: replace Zweck = 0 if missing(Zweck) & w04==9 & w01[_n-2]==1
bysort hhid pid: replace Zweck = 0 if missing(Zweck) & w04==9 & w04[_n-2]==8
bysort hhid pid: replace Zweck = 17 if w04_dzw==704
bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & w04[_n-1]==11 & w04[_n-2]==11 & w04_dzw[_n-3]== 701
bysort hhid pid: replace Zweck = 6 if missing(Zweck) & w04==9 & w04[_n-2]==7
bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & w04[_n-2]==6

bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & (w01[_n-1]==4 |w01[_n-1]==3 | w01[_n-1]==.a) & wsid==2


* Rundweg + andere Aktivität = Freizeit
replace Zweck = 6 if missing(Zweck) & w04==10 & w13 == 5
replace Zweck = 9 if missing(Zweck) & w04==10

bysort hhid pid: replace Zweck = Zweck[_n-2] if w04==9 & w04[_n-2]==10
bysort hhid pid: replace Zweck = Zweck[_n-2] if w04==9 & w04[_n-2]==9



* Behandlung von *weiß nicht*
replace Zweck = 9 if wsid>1 & w04==.c
replace Zweck = 8 if w04==.c & wsid==1

replace Zweck=12 if Zweck==4

label copy hwzweck Zweck
label value Zweck Zweck
label define Zweck 0 `"Wohnen"' 8 `"fremde Wohnung"' 9 `"Sonstiges"' 10  `"Freizeit ohne Zweck"', add modify
label define Zweck 11 `"tägl. Einkauf"' 12 `"allg. Einkauf"' 13 `"Einkaufsbummel"', add modify
label define Zweck 14 `"Berufsschule"' 15 `"Schule"' 16 `"Kindergarten"' 17 `"Sport"', add modify


* Berufswege: Wege von und zur Arbeit + Wege von und zum Dienstgeschäft für AP 2.2
gen arbeit = Zweck==1 | Zweck==2
bysort hhid pid: replace arbeit = 1 if Zweck[_n+1]==1 | Zweck[_n+1]==2
replace arbeit = 1 if w01==2
label value arbeit jn
label var arbeit "Arbeitsweg"
* Ausbildungswege für AP 2.3
gen ausbildung = Zweck==3
bysort hhid pid: replace ausbildung = 1 if Zweck[_n+1]==3
label value ausbildung jn
label var ausbildung "Aubildungsweg"

* hwzweck angepasst
* fremde Wohnung,Rundweg -> Freizeit; Aggregation Einkaufsgründe
gen hwzweck2 = Zweck

replace hwzweck2 = 6 if hwzweck2==8 | hwzweck2==10
bysort hhid pid: replace hwzweck2 = Zweck[_n-1] if (hwzweck2==0 |hwzweck2==8) & wsid>1

replace hwzweck2 = 6 if Anz_W==1 & (s02_1==1 | s02_2==1) & (hwzweck2==0 | hwzweck2==8)
replace hwzweck2 = 6 if w01!=2 & w13!=2 & hwzweck2==0 & wsid==1
replace hwzweck2 = 9 if Anz_W==1 & (s02_5==1)  & (hwzweck2==0 | hwzweck2==8)
replace hwzweck2 = 4 if hwzweck2==11 | hwzweck2==12 |  hwzweck2==13
replace hwzweck2 = 1 if w01==2 & hwzweck2==0
replace hwzweck2 = 7 if w01==2 & w13==1
replace hwzweck2 = 4 if hwzweck2==11 | hwzweck2==12 |  hwzweck2==13
replace hwzweck2 = 6 if hwzweck2==8 | hwzweck2==10

label var hwzweck2 "Weghauptzweck überarbeitet"
label value hwzweck2 Zweck

* Problem der doppelten Heimwege.
bysort hhid pid: gen dop_home= w04==8 & w04[_n-1]==8
bysort hhid pid: egen dop_home_p = sum(dop_home)
label var dop_home "doppelter Heimweg"
label var dop_home_p "doppelter Heimweg, komplette Wegekette"

* Bildung der spezifischen Auswertungsklassen nach Projektbeschreibung
* 1) Verkehrsmittel nach vorgegebenen Verkehrsmittelklassen
* 2) Distanzklassen
* Definition der Verkehrsmittelkombinationen
gen OEV =  w05_12 | w05_13 | w05_11 |  w05_15 | w05_16 | w05_17 | w05_18
gen MIV =  (w05_4 | w05_5 | w05_7 |  w05_3)
gen  intermodal_weg = MIV + OEV +  w05_2 + w05_14  if w05_14<2 |  w05_2<2 
label var intermodal_weg "intermodaler Weg"

gen VM = 1 if  pkw_f==1 & intermodal_weg<2
replace VM = 2 if pkw_mf==1 & intermodal_weg<2
replace VM = 3 if mrad_f==1 & intermodal_weg<2
replace VM = 4 if mrad_mf==1 & intermodal_weg<2
replace VM = 5 if lkw_f==1 & intermodal_weg<2
replace VM = 6 if lkw_mf==1 & intermodal_weg<2
replace VM = 10 if (w05_15 | w05_16 | w05_17) & intermodal_weg<2
replace VM = 8 if w05_18==1 & wegkm_k>50 & intermodal_weg<2
replace VM = 7 if w05_11 | w05_12 | w05_13 & intermodal_weg<2
replace VM = 9 if w05_14==1 & intermodal_weg<2
replace VM = 11 if w05_2==1 & intermodal_weg<2
replace VM = 12 if w05_1==1 & intermodal_weg<2
replace VM = 13 if intermodal_weg>1


label define VM 1 `"Pkw-F"' 2 `"Pkw-MF"' 3 `"Mrad-F"' 4 `"Mrad-MF"' 5 `"Lkw-F"' 6 `"Lkw-MF"' 7 `"ÖPNV"', modify
label define VM 8 `"Flugzeug"' 9 `"Taxi"' 10 `"Fernverkehr"' 11 `"Rad"' 12 `"Fuß"' 13 `"Sonstige"', modify
label value VM VM


gen VM_Kombi = 1 if intermodal_weg < 2
replace VM_Kombi = 3 if intermodal_weg >1 &  OEV & MIV
replace VM_Kombi = 2 if intermodal_weg >1 &  w05_2 == 1
replace VM_Kombi = 5 if missing(VM_Kombi)
* Auf die Definition von Kiss&Ride wird aufgrund des Datensatzaufbaus der MiD verzichtet, da keine hinreichend genauen Aussagen hier getroffen werden können.
label var VM_Kombi "VM_Kombi für Sonderauswertung"

label define VM_Kombi 1 `"Monomodal"' 2 `"Bike&Ride"' 3 `"Park&Ride"' 5 `"sonstige Multimodale"', modify
label value VM_Kombi VM_Kombi

recode VM ( 12=1 "Fuß") ( 11=2 "Rad") ( 7 8 10=3 "ÖV") ( 1 3 5=4 "MIV") ( 2 4 6=5 "MIV-MF") ( 13 9=6 "Sonstige"), gen(VM_6)
replace VM_6 = 6 if intermodal_weg>1 & intermodal_weg<.
replace VM_6 =4 if w05_3==1 & intermodal_weg<2

* drop VM


gen Distanzklasse = 0.5 if  wegkm_k <=0.5
replace Distanzklasse = 1 if wegkm_k>0.5 & wegkm_k <=1
replace Distanzklasse = 2 if wegkm_k>1& wegkm_k <=2
replace Distanzklasse = 5 if wegkm_k>2 & wegkm_k <=5
replace Distanzklasse = 10 if wegkm_k>5 & wegkm_k <=10
replace Distanzklasse = 20 if wegkm_k>10 & wegkm_k <=20
replace Distanzklasse = 50 if wegkm_k>20 & wegkm_k <=50
replace Distanzklasse = 100 if wegkm_k>50 & wegkm_k <=100
replace Distanzklasse = 101 if wegkm_k>100 & wegkm_k < 9000
replace Distanzklasse = . if missing(wsid)
label var Distanzklasse "Distanzklasse für Sonderauswertung"


* Prüfung der Wegelängen zur Verkehrsmittelwahl:


* Plausibiltätsprüfung mit: tab HVM_DIFF  VM, col nofr

* Begleitwege
duplicates tag hhid st_time en_time w04 w13, gen(begl)


* Filter auf Personen mit negativer Aktivitätendauer oder 
gen filter = p_neg2==0 
replace filter = 0 if dop_home==1




* Fuß zählt als 0, Pkw-MF & Pkw-Fahrer zählen als ein Verkehrssystem => Rad, ÖV, Pkw

bysort hhid pid: gen Pkw = VM_6<3
bysort hhid pid: egen Pkw_sum = sum(Pkw)
bysort hhid pid: gen Pkw_tag = Pkw_sum>0
bysort hhid pid: gen OV = VM_6==3
bysort hhid pid: egen OV_sum = sum(OV)
bysort hhid pid: gen OV_tag = OV_sum>0
bysort hhid pid: gen Rad = VM_6==4
bysort hhid pid: egen Rad_sum = sum(Rad)
bysort hhid pid: gen Rad_tag = Rad_sum>0
bysort hhid pid: gen Sonstige = VM_6==6
bysort hhid pid: egen Sonstige_sum = sum(Sonstige)
bysort hhid pid: gen Sonstige_tag = Sonstige_sum>0

drop Pkw_sum OV_sum Rad_sum Sonstige_sum

gen multimodal_tag = (Rad_tag & Pkw_tag) | (Pkw_tag & OV_tag) | (Rad_tag & OV_tag) | (Rad_tag & Sonstige_tag) | (Pkw_tag & Sonstige_tag) | (OV_tag & Sonstige_tag) | intermodal_weg>0
label value multimodal_tag jn
gen Anz_VM_Tag = Rad_tag+Sonstige_tag+Pkw_tag+OV_tag


label var Anz_VM_Tag "Anzahl verwendeter Verkehrssysteme am Stichtag"
label var multimodal_tag "Multimodale Person am Stichtag"

foreach x in  "Pkw" "Rad" "Sonstige" "OV" {
	label var `x' "Weg mit `x'-Nutzung"
	label var `x'_tag "Person mit mind. einen `x'weg"
	label value `x' jn
	label value `x'_tag jn
}

* Bildung der Grundtypen der verhaltenshomogenen Gruppen gem. Protokoll vom 14.09.2011
* über merge in Datensatz
version 12
merge n:m hhid using "X:\Daten\KiD_MiD_internerGebrauch\MiD2008\Regionaldatensatz\Daten\STATA\MiD2008_Regionalfile.dta", gen(regio)


save "`path'MiD_Wege_cod_bereinig_def.dta", replace








