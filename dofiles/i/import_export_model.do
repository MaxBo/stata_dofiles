clear
set memory 700m
local path "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\MiD2008\Daten\STATA\STATA_Public Use File\"

use  "`path'MiD2008_PUF_Wege_label.dta", clear

sort hhid pid wsid
bysort hhid pid: gen Zweck = 2 if w04 == 1 | w13 == 2 

bysort hhid pid: replace Zweck = 11 if  w04 == 9

bysort hhid pid: replace Zweck = 2 if Zweck==11 & Zweck[_n-2]==2 & _n>1
bysort hhid pid: replace Zweck = 2 if Zweck==11 & w01[_n-1] == 2 &_n==2
bysort hhid pid: replace Zweck = 2 if w04[_n-1] == 1 | w04 == 14
bysort hhid pid: replace Zweck = 5 if w04 == 3 | w04 == 31
bysort hhid pid: replace Zweck = 1 if w04 == 8| w13 == 1
bysort hhid pid: replace Zweck = 10 if w04 == 11 | w04 == 6
bysort hhid pid: replace Zweck = 18 if w04 == 6

bysort hhid pid: replace Zweck = 7 if w04 == 7 | w04 == 5
bysort hhid pid: replace Zweck = 6 if w04 == 32

bysort hhid pid: replace Zweck = 12 if  w04_dzw == 701

bysort hhid pid: replace Zweck = 3 if w04_dzw == 501 & w04!=11
bysort hhid pid: replace Zweck = 4 if ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))& w04!=11

bysort hhid pid: replace Zweck = 8 if w04 == 10| w04 > 100
bysort hhid pid: replace Zweck = 8 if w04_dzw == 604| w04_dzw == 699 | w04_dzw == 720| w04_dzw == 799 

bysort hhid pid: replace Zweck = 9 if ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713)) & w04!=11
bysort hhid pid: replace Zweck = 14 if w04 == 2 & wsid < 100
bysort hhid pid: replace Zweck = 2 if w04_dzw==715
bysort hhid pid: replace Zweck = 10 if w04_dzw == 11 | w04_dzw == 716
bysort hhid pid: replace Zweck = 15 if w04_dzw==503 & w04!=11
bysort hhid pid: replace Zweck = 16 if w04_dzw==704
bysort hhid pid: replace Zweck = 17 if (w04_dzw>600 & w04_dzw<604) | w04_dzw==605 | w04_dzw==705 | w04_dzw==714

* bysort hhid pid: replace Zweck = 2 if Zweck==11 & (Zweck[_n-1]==9 |Zweck[_n-2]==2) & _n>2
bysort hhid pid: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==1 | w01[_n-2]==1) & _n>2
bysort hhid pid: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==9 | w01[_n-2]==1) & _n>2
bysort hhid pid: replace Zweck = 5 if Zweck==11 & Zweck[_n-2]==5 & _n>2
bysort hhid pid: replace Zweck = 12 if Zweck==11 & (w01[_n-1] >2)  &_n==2
bysort hhid pid: replace Zweck = 12 if Zweck==11 & Zweck[_n-2]==12 & _n>2
bysort hhid pid: replace Zweck = 13 if wsid > 100
bysort hhid pid: replace Zweck = Zweck[_n-2] if  _n>2 & hp_alter<7 & begleit==0 & Zweck==2

label var Zweck "ausgeführte Zielaktivität"

label define Zweck 2 `"A: Arbeit"', modify
label define Zweck 1 `"W: Wohnen"', modify
label define Zweck 3 `"E_per: Einkauf periodisch"', modify
label define Zweck 4 `"E_aper: Einkauf aperiodisch"', modify
label define Zweck 5 `"B: Bilden"', modify
label define Zweck 6 `"K: Kindergarten"', modify
label define Zweck 7 `"F: Freizeit / Erledigung"', modify
label define Zweck 8 `"S: Sonstige"', modify
label define Zweck 9 `"Ru: Rundgang (Sport, Hund, spazieren)"', modify
label define Zweck 10 `"Begl: Begleitung"', modify
label define Zweck 11 `"Rü: Rückweg"', modify
label define Zweck 12 `"FW: Besuch von Freunden/Verwandten, fremde Wohnung"', modify
label define Zweck 13 `"d_per: dienstlich per"', modify
label define Zweck 14 `"d_aper: dienstlich aper"', modify
label define Zweck 15 `"E_b: Einkaufsbummel"', modify
label define Zweck 16 `"Sp: Sport"', modify
label define Zweck 17 `"Erl: Erledigungen"', modify
label define Zweck 18 `"Br: Bringen / Holen"', modify

label value Zweck Zweck

gen arbeit = (( Zweck==2)| (w01 ==2 & wsid==1))
gen bilden = (( Zweck==5)| (w01 ==3 & wsid==1))
gen eink_ap = (Zweck==4)
gen eink_p= Zweck==3
gen frei = (Zweck == 7|Zweck == 10|Zweck == 12)
gen kg = (Zweck == 6)

foreach x in "arbeit" "bilden" "eink_ap" "eink_p" "frei" "kg" {
	bysort hhid pid: egen anz_`x' = sum(`x')
}

save "`path'MiD2008_PUF_Wege_test_opus.dta", replace

use "`path'MiD2008_PUF_Personen.dta", clear

* Label der MiD 2008 müssen noch einmal grundsätzlich überprüft und ggf. überarbeitet werden!
label define hp_sex .a `"keine Angabe"' .b `"weiß nicht"' .c `"verweigert"' , modify add
label define hp_beruf .a `"keine Angabe"' .b `"weiß nicht"' .c `"verweigert"' , modify add
label define hp_bkat .a `"keine Angabe"' .b `"weiß nicht"' .c `"verweigert"' , modify add
recode hp_sex (9=.a) (2=0)
recode hp_beruf (9=.a) (8=.b) (7=.c) (2=0)
recode hp_bkat (9=.a)
label value hp_sex hp_sex
label value hp_beruf hp_beruf
label value hp_bkat hp_bkat


* Bildung der Grundtypen der verhaltenshomogenen Gruppen gem. Protokoll vom 14.09.2011
gen verh_perg = 1 if hp_alter<8
replace verh_perg = 2 if hp_alter>4 & hp_alter<11 & hp_besch==5
replace verh_perg = 3 if hp_alter>10 & hp_alter<17 & hp_besch==5
replace verh_perg =4 if hp_alter>16 & hp_besch==5
replace verh_perg =5 if hp_alter>16 & hp_besch==4
replace verh_perg =6 if hp_besch==6
replace verh_perg =7 if hp_besch==1
replace verh_perg =8 if hp_besch==2 | hp_besch==3
replace verh_perg =9 if hp_besch==11 | hp_besch==10
replace verh_perg =10 if missing(verh_perg) & hp_beruf==0
replace verh_perg =11 if hp_alter>64 & hp_beruf==0 & hp_besch==12
replace verh_perg =12 if hp_alter>74 & hp_beruf==0 & hp_besch==12

label define verh_perg 1 `"Kleinkind"' 2 `"Grundschüler"' 3  `"Schüler-Mittelstufe"' 4  `"Schüler-Oberstufe"' 5  `"Berufsschüler"', modify
label define verh_perg 6 `"Student"' 7 `"Vollzeitbeschäftigter"' 8 `"Teilzeitbeschäftigter"' 9 `"nicht erwerbstätig: Hausfrau/-mann"' 10 `"nicht erwerbstätig: sonstige"', modify
label define verh_perg 11 `"aktiver Rentner"' 12  `"inaktiver Rentner"', modify

label value verh_perg verh_perg


merge hhid pid using "`path'MiD2008_PUF_Wege_test_opus.dta", sort uniqmaster keep(anz_*)
gen alter2 = hp_alter*hp_alter
* xi: nbreg anz_arb hp_sex hp_alter alter2 hp_beruf i.hp_bkat i.rtyp, dispersion(mean)

* Aufbereitung als Dummyvariablen, damit sie in neu erstellter Datei verwendet werden können.
qui tab verh_perg, gen(verh_perg_)
qui tab rtyp, gen(rtyp_)

foreach x in "arbeit" "bilden" "eink_ap" "eink_p"  {
	
	poisson anz_`x' hp_sex rtyp_* verh_perg_*  if stichtag<6
	* Variante mit outreg2
	outreg2 using "`path'export_postgis_`x'.txt", replace noast tstat
	* Variante mit direkter Schätzung
	estimates save "`path'anz_`x'.ster", replace
}

outreg2 using "`path'export_postgis.txt", replace noast tstat
save "`path'MiD2008_PUF_Personen_opus_test.dta", replace

clear
* In einer externen Exceldatei werden die Gruppen und ihre weiteren Ausprägungen gebildet. 
* Diese Datei dann als Textdatei speichern und nach STATA importieren.
insheet using "`path'test.txt"
* Die Dateien müssen wie im Personendatensatz als Dummyvariablen aufbereitet werden. 
qui tab verh_perg, gen(verh_perg_)
qui tab rtyp, gen(rtyp_)

foreach x in "arbeit" "bilden" "eink_ap" "eink_p"  {
	estimates use "`path'anz_`x'.ster"
	predict `x'
}

* Als nächstes kommt der Export zu PostGIS. Da wir aber noch kein STATA12 haben entfällt dieser Teil der Programmierung erst einmal.
* Hier steht erst einmal eine einfache Variante mit Speichern als Textdatei:

outsheet verh_perg hp_sex rtyp arbeit bilden eink_ap eink_p using "`path'Erzeugungsraten_export_postgis.csv", nolabel noquote replace
