clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_3.dta", clear

* Generierung unterschiedlicher Haushaltstypen
* 1 Anzahl Erwachsener Personen im Haushalt

gen HHGr��enklassen = 1 if HHErwachsene==1
replace HHGr��enklasse = 2 if HHErwachsene==2
replace HHGr��enklasse =3 if HHErwachsen>2
replace HHGr��enklasse =.a if HHErwachsene==0

label var HHGr��enklasse "3 HH-Gr��en: 1, 2, > 2 Erwachsene"
label define HHGr��enklasse 1 `"Alleinlebend"' 2 `"zu zweit lebend"' 3 `"mehr als 2 Erwachsene"' .a `"keine Angabe"'
label value HHGr��enklasse HHGr��enklasse

* Rentnerhaushalte, Haushalte mit Kindern

gen HHGr_Besatz = 1 if HHGr��enklasse==1

replace HHGr_Besatz = 2 if HHGr��enklasse==1 & HHRentner==1
replace HHGr_Besatz = 5 if HHGr��enklasse==1 & HHKinder>0
replace HHGr_Besatz = 4 if HHGr��enklasse==1 & HHKind0_13>0
replace HHGr_Besatz = 3 if HHGr��enklasse==1 & HHKind0_5>0

replace HHGr_Besatz = 6 if HHGr��enklasse==2
replace HHGr_Besatz = 7 if HHGr��enklasse==2 & HHRentner==2
replace HHGr_Besatz = 10 if HHGr��enklasse==2 & HHKinder>0
replace HHGr_Besatz = 9 if HHGr��enklasse==2 & HHKind0_13>0
replace HHGr_Besatz = 8 if HHGr��enklasse==2 & HHKind0_5>0

replace HHGr_Besatz = 11 if HHGr��enklasse==3
replace HHGr_Besatz = 12 if missing(HHGr_Besatz)


label define HHGR_Besatz 1 `"Alleinlebend"', modify
label define HHGR_Besatz 2 `"Rentner Alleinlebend"', modify 
label define HHGR_Besatz 3 `"Alleinerziehend mit Kind unter 6"', modify 
label define HHGR_Besatz 4 `"Alleinerziehend mit Kind unter 14"', modify
label define HHGR_Besatz 5 `"Alleinerziehend mit Kind unter 18"', modify
label define HHGR_Besatz 7 `"Zweipersonenrentnerhaushalt"', modify
label define HHGR_Besatz 6 `"Zweipersonenhaushalt"', modify
label define HHGR_Besatz 8 `"Zweipersonenhaushalt mit Kind unter 6"', modify
label define HHGR_Besatz 9 `"Zweipersonenhaushalt mit Kind unter 14"', modify
label define HHGR_Besatz 10 `"Zweipersonenhaushalt mit Kind unter 18"', modify
label define HHGR_Besatz 11 `"mind. drei Erwachsene"', modify
label define HHGR_Besatz 12 `"sonstiger Haushalt"', modify

label value HHGr_Besatz HHGR_Besatz
label var HHGr_Besatz "Unterschiedliche HH-Zusammensetzung nach Lebensphasen"


* HH Lebensphase

gen HHLeben = 1 if HHKinder==0
replace HHLeben = 2 if HHKinder>0
replace HHLeben =3 if HHKind0_13>0
replace HHLeben = 4 if HHKind0_5>0
replace HHLeben = 5 if HHRentner>0

label define HHLeben 1 `"Haushalt ohne Kinder"', modify
label define HHLeben 2 `"Haushalt mit mind. 1 Kind unter 18"', modify
label define HHLeben 3 `"Haushalt mit mind. 1 Kind unter 14"', modify
label define HHLeben 4 `"Haushalt mit mind. 1 Kind unter 6"', modify
label define HHLeben 5 `"Rentnerhaushalt"', modify
label value HHLeben HHLeben
label var HHLeben "HH-Lebensphasen"

tab HHGr_Besatz, gen(HHGR_Besatz_)
tab HHLeben, gen(HHLeben_)
tab HHGr��enklasse, gen(HHGr_)

