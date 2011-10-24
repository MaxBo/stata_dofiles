clear
set memory 700m
local path "D:\DatenMaxDiss\MiD-Hessen\MiD_2008\STATA\"

use "`path'MiD_Wege_Hessen_cod_bereinig.dta", clear
* Wegeende, Weganfang, Anzahl dokumentierter Wege
bysort HHID PID: gen Anz_W =_N
bysort HHID PID: gen w_ende = WSID==_N 
bysort HHID PID: gen w_anf = WSID== 1

* Wegezwecke anpass, Rückwege
* HWZWECK eignet sich nicht für Wegekettenbildung, weil Hin- und Rückweg mit einem Wegezweck versehen sind.
* Deswegen werden die Kategorien aus HWZWECK für die Variable Zweck verwendet.
sort HHID PID WSID

gen Zweck = 1 if W04==1
replace Zweck = 2 if W04==2
replace Zweck = 3 if W04==3 | W04==31 | W04==32 
replace Zweck = 4 if W04==4
replace Zweck = 6 if W04==7
replace Zweck = 10 if W13==5 | W04_DZW==711|W04_DZW==710|W04_DZW==712

replace Zweck = 5 if W04==5 | W04_DZW==504

replace Zweck = 7 if W04 ==6 | W04==11 | W04_DZW==11 | W04_DZW==716

replace Zweck = 1 if W13==2 & W04==10

replace Zweck = 8 if W04_DZW==701 | W04_DZW==707
replace Zweck = 11 if W04_DZW==501
replace Zweck = 12 if W04_DZW==502|W04_DZW==505
replace Zweck = 13 if W04_DZW==503
replace Zweck = 0 if W13==1 & W04==10
replace Zweck = 0 if W04 ==8

replace Zweck = 10 if W01==1 & W13==1

* replace Zweck = 14 if W04==3
* replace Zweck = 15 if W04==31
* replace Zweck = 16 if W04==32


* Behandlung der Rückwege
* Hintergrund: Rückwege wurden aus Befragungsökonomischen Gründen eingeführt, um die Interviewlänge zu verkürzen.
* Aus der Logik heraus werden anhand vorheriger Wege bzw. Start- und Zielorte der Wegezweck ermittelt.
* Routine zur Belegung von Rückwegen
* gen miss_akt = missing(Zweck) & W04==9
* bysort HHID PID: egen miss = sum(miss_akt)
* br HHID PID WSID Zweck W04  W04_DZW ST_STD ST_MIN  EN_STD EN_MIN W01 W13 if miss>0

* Fremde Wohnung entspricht einer Unterkunft bzw. Besuch einer fremden Wohnung oder einer sonstigen Bleibe, z.B. Hotel, Pension, Zeltplatz u.a.
* Rückwege von Begleitwegen werden als Weg in eine fremde Wohnung umkodiert.// Änderung abhängig von Begleitzweck!!!
bysort HHID PID: replace Zweck = 8 if missing(Zweck) & (W04==9 | W04==10) & (W04_DZW[_n-2]==701 | W04_DZW[_n-2]==707 | W04_DZW[_n-2]==718 )
bysort HHID PID: replace Zweck = 1 if missing(Zweck) & W04==9 & W04[_n-2]==1
bysort HHID PID: replace Zweck = 1 if missing(Zweck) & W04==9 & W01[_n-1]==2
bysort HHID PID: replace Zweck = 2 if missing(Zweck) & W04==9 & W04[_n-2]==2
bysort HHID PID: replace Zweck = 3 if missing(Zweck) & W04==9 & (W04[_n-2]==3 | W04[_n-2]==31 | W04[_n-2]==32 )
bysort HHID PID: replace Zweck = 6 if missing(Zweck) & W04==9 & (W04_DZW[_n-2]==704 | W04_DZW[_n-2]==714 | W04_DZW[_n-2]==713 | W04_DZW[_n-2]==715 | W04_DZW[_n-2]==702)
* bysort HHID PID: replace Zweck = 14 if missing(Zweck) & W04==9 & W04[_n-2]==3
* bysort HHID PID: replace Zweck = 15 if missing(Zweck) & W04==9 & ( W04[_n-2]==31)
* bysort HHID PID: replace Zweck = 16 if missing(Zweck) & W04==9 & ( W04[_n-2]==32 )
bysort HHID PID: replace Zweck = 11 if missing(Zweck) & W04==9 & W04_DZW[_n-2]==501
bysort HHID PID: replace Zweck = 12 if missing(Zweck) & W04==9 & (W04_DZW[_n-2]==502|W04_DZW[_n-2]==505)
bysort HHID PID: replace Zweck = 13 if missing(Zweck) & W04==9 & W04_DZW[_n-2]==503
bysort HHID PID: replace Zweck = 4 if missing(Zweck) & W04==9 & W04[_n-2]==4
bysort HHID PID: replace Zweck = 5 if missing(Zweck) & W04==9 & W04[_n-2]==5
bysort HHID PID: replace Zweck = 7 if missing(Zweck) & W04==9 & Zweck[_n-2]==7
bysort HHID PID: replace Zweck = 0 if missing(Zweck) & W04==9 & W01[_n-2]==1
bysort HHID PID: replace Zweck = 0 if missing(Zweck) & W04==9 & W04[_n-2]==8

bysort HHID PID: replace Zweck = 8 if missing(Zweck) & (W04==9 | W04==10) & W04[_n-1]==11 & W04[_n-2]==11 & W04_DZW[_n-3]== 701
bysort HHID PID: replace Zweck = 6 if missing(Zweck) & W04==9 & W04[_n-2]==7
bysort HHID PID: replace Zweck = 8 if missing(Zweck) & (W04==9 | W04==10) & W04[_n-2]==6

bysort HHID PID: replace Zweck = 8 if missing(Zweck) & (W04==9 | W04==10) & (W01[_n-1]==4 |W01[_n-1]==3 | W01[_n-1]==.a) & WSID==2


* Rundweg + andere Aktivität = Freizeit
replace Zweck = 6 if missing(Zweck) & W04==10 & W13 == 5
replace Zweck = 9 if missing(Zweck) & W04==10

bysort HHID PID: replace Zweck = Zweck[_n-2] if missing(Zweck) & W04==9 & W04[_n-2]==10
bysort HHID PID: replace Zweck = Zweck[_n-2] if missing(Zweck) & W04==9 & W04[_n-2]==9

replace Zweck = 8 if HHID== 794108 & PID==3 & WSID==4

* Behandlung von *weiß nicht*
replace Zweck = 9 if WSID>1 & W04==.c
replace Zweck = 8 if W04==.c & WSID==1

replace Zweck=12 if Zweck==4

label copy HWZWECK Zweck
label value Zweck Zweck
label define Zweck 0 `"Wohnen"' 8 `"fremde Wohnung"' 9 `"Sonstiges"' 10  `"Rundweg"', add modify
label define Zweck 11 `"tägl. Einkauf"' 12 `"allg. Einkauf"' 13 `"Einkaufsbummel"', add modify
label define Zweck 14 `"Berufsschule"' 15 `"Schule"' 16 `"Kindergarten"', add modify

* Berufswege: Wege von und zur Arbeit + Wege von und zum Dienstgeschäft für AP 2.2
gen arbeit = Zweck==1 | Zweck==2
bysort HHID PID: replace arbeit = 1 if Zweck[_n-1]==1 | Zweck[_n-1]==2
replace arbeit = 1 if W01==2
label value arbeit jn
* Ausbildungswege für AP 2.3
gen ausbildung = Zweck==3
bysort HHID PID: replace ausbildung = 1 if Zweck[_n-1]==3
label value ausbildung jn

* HWZWECK angepasst
* fremde Wohnung,Rundweg -> Freizeit; Aggregation Einkaufsgründe
gen HWZWECK2 = Zweck

replace HWZWECK2 = 6 if HWZWECK2==8 | HWZWECK2==10
bysort HHID PID: replace HWZWECK2 = Zweck[_n-1] if (HWZWECK2==0 |HWZWECK2==8) & WSID>1

replace HWZWECK2 = 6 if Anz_W==1 & (S02_1==1 | S02_2==1) & (HWZWECK2==0 | HWZWECK2==8)
replace HWZWECK2 = 6 if W01!=2 & W13!=2 & HWZWECK2==0 & WSID==1
replace HWZWECK2 = 9 if Anz_W==1 & (S02_5==1)  & (HWZWECK2==0 | HWZWECK2==8)
replace HWZWECK2 = 4 if HWZWECK2==11 | HWZWECK2==12 |  HWZWECK2==13
replace HWZWECK2 = 1 if W01==2 & HWZWECK2==0
replace HWZWECK2 = 7 if W01==2 & W13==1
replace HWZWECK2 = 4 if HWZWECK2==11 | HWZWECK2==12 |  HWZWECK2==13
replace HWZWECK2 = 6 if HWZWECK2==8 | HWZWECK2==10

label var HWZWECK2 "Weghauptzweck überarbeitet"
label value HWZWECK2 Zweck

* Problem der doppelten Heimwege.
bysort HHID PID: gen dop_home= W04==8 & W04[_n-1]==8
bysort HHID PID: egen dop_home_p = sum(dop_home)

* Bildung der spezifischen Auswertungsklassen nach Projektbeschreibung
* 1) Verkehrsmittel nach vorgegebenen Verkehrsmittelklassen
* 2) Distanzklassen

gen VM = 1 if  PKW_F==1
replace VM = 2 if PKW_MF==1
replace VM = 3 if MRAD_F==1
replace VM = 4 if MRAD_MF==1
replace VM = 5 if LKW_F==1
replace VM = 6 if LKW_MF==1
replace VM = 10 if missing(VM) &  (W05_15 | W05_16 | W05_17)
replace VM = 8 if W05_18==1 & WEGKM_K>50
replace VM = 7 if W05_11 | W05_12 | W05_13
replace VM = 9 if W05_14==1
replace VM = 11 if missing(VM) &  W05_2==1
replace VM = 12 if missing(VM) &  W05_1==1
replace VM = 13 if missing(VM)

label var VM "Verkehrsmittel für Sonderauswertung"
label define VM 1 `"Pkw-F"' 2 `"Pkw-MF"' 3 `"MRad-F"' 4 `"MRad-MF"' 5 `"Lkw-F"' 6 `"Lkw-MF"' 7 `"ÖPNV"', modify
label define VM 8 `"Flugzeug"' 9 `"Taxi"' 10 `"Fernverkehr"' 11 `"Rad"' 12 `"Fuß"' 13 `"Sonstige"', modify
label value VM VM

gen Distanzklasse = 0.5 if  WEGKM_K <=0.5
replace Distanzklasse = 1 if WEGKM_K>0.5 & WEGKM_K <=1
replace Distanzklasse = 2 if WEGKM_K>1& WEGKM_K <=2
replace Distanzklasse = 5 if WEGKM_K>2 & WEGKM_K <=5
replace Distanzklasse = 10 if WEGKM_K>5 & WEGKM_K <=10
replace Distanzklasse = 25 if WEGKM_K>10 & WEGKM_K <=20
replace Distanzklasse = 50 if WEGKM_K>20 & WEGKM_K <=50
replace Distanzklasse = 100 if WEGKM_K>50 & WEGKM_K <=100
replace Distanzklasse = 101 if WEGKM_K>100 & WEGKM_K < 9000

label var Distanzklasse "Distanzklasse für Sonderauswertung"

* Prüfung der Wegelängen zur Verkehrsmittelwahl:
* 1) Fälle mit langen Fußwegen zur Arbeit, private Erledigung -> Einzelfallprüfung!

* Plausibiltätsprüfung mit: tab HVM_DIFF  VM, col nofr

* Filter auf Personen mit negativer Aktivitätendauer oder 
gen filter = p_neg2==0 & dop_home_p==0 


save "`path'MiD_Wege_Hessen_cod_bereinig_def.dta", replace



use "`path'MiD_Personen_Hessen_cod.dta", clear
merge HHID using "`path'MiD_HH_Hessen_cod.dta", sort keep(H04_1 H04_2 H04_3 H040_1 H040_2 H040_3 H040_4 H040_5 H040_6 H040_7 H040_8 GRKPKW) uniqusing
drop _merge
recode RBW0 (2=0)
* Mobilitätswerkzeuge definieren

gen hh_ohne_pkw = H04_3==0
label var hh_ohne_pkw "HH ohne Pkw"
label value hh_ohne_pkw jn
gen hh_mofa = H04_1>0
label var hh_mofa "Haushalt hat mind. ein Mofa"
gen hh_rad  = H04_2>0
label var hh_rad "Haushalt hat mind. ein Fahrrad"
gen hh_zeitkarte = P070==3 | P070==4
label var hh_zeitkarte "Haushalt hat mind. eine Zeitkarte"
gen hat_zeitkarte =  hh_zeitkarte | P070==5
label var hat_zeitkarte "Peson hat Zeitkarte"

save "`path'MiD_Personen_Hessen_cod_def.dta", replace
