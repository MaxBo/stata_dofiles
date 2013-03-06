***Vergleich Infas und GGR und Nutzungshäufigkeiten 2011***
****WEGE OHNE DIENSTLICH, WEGE UNTER 100 km ***
use "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod.dta", clear

set mem 800m
set more off


***Überprüfung Fahrradnutzung***
recode P030 (6=5 "nie/habe kein Fahrrad") (7/8=.b "keine Angabe"), gen(Fahrradnutzung)
label define Fahrradnutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie/habe kein Fahrrad", modify
label values Fahrradnutzung Fahrradnutzung


tab Fahrradnutzung  Regins if HP_ALTER >= 14 & HWZWECK != 2 & WEGKM_K <=100  [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & HWZWECK != 2 & WEGKM_K <=100 [iw = P_GEW], col nof



***Überprüfung Autonutzung***
recode P031 (7/8=.b "keine Angabe"), gen(Autonutzung)
label define Autonutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie", modify
label values Autonutzung Autonutzung


tab Autonutzung  Regins if HP_ALTER >= 14 & HWZWECK != 2 & WEGKM_K <=100 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & HWZWECK != 2 & WEGKM_K <=100 [iw = P_GEW], col nof

***Überprüfung Bahn***
recode P032 (7/8=.b "keine Angabe"), gen(Bahnnutzung)
label define Bahnnutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie", modify
label values Bahnnutzung Bahnnutzung


tab Bahnnutzung  Regins if HP_ALTER >= 14 & HWZWECK != 2 & WEGKM_K <=100 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & HWZWECK != 2 & WEGKM_K <=100 [iw = P_GEW], col nof

***Überprüfung Fuß***
recode P036 (7/8=.b "keine Angabe"), gen(Fußnutzung)
label define Fußnutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie", modify
label values Fußnutzung Fußnutzung

tab Fußnutzung  Regins if HP_ALTER >= 14 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 [iw = P_GEW], col nof


****Nutzungshäufigkeiten nach Personengruppen****
***Fahrradnutzung nach PG***
gen PERGRUP2 = .
replace PERGRUP2 = 1 if PERGRUP == 1
replace PERGRUP2 = 2 if PERGRUP == 2
replace PERGRUP2 = 3 if PERGRUP == 3
replace PERGRUP2 = 4 if PERGRUP == 4
replace PERGRUP2 = 5 if PERGRUP == 5
replace PERGRUP2 = 5 if PERGRUP == 6
replace PERGRUP2 = 6 if PERGRUP == 7
replace PERGRUP2 = 7 if PERGRUP == 8
replace PERGRUP2 = 7 if PERGRUP == 9

label define PERGRUP2 1 "Berufstätige(r) mit verfügbarem Pkw" 2 "Berufstätige(r) ohne Pkw" 3 "Nicht-Berufstätige(r) mit verfügbarem Pkw" 4 "Nicht-Berufstätige(r) ohne Pkw" 5 "Student/Auszubildende(r)" 6 "Kind unter 6 Jahre" 7 "Schüler(in)", modify
label values PERGRUP2 PERGRUP2

***Erwerbstätige****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 1  [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 1  [iw = P_GEW], col nof

***Nichterwerbstätige****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 2  [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 2 [iw = P_GEW], col nof

***Studenten/Azubis****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 3 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 3  [iw = P_GEW], col nof

***Kinder unter 6 Jahre****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 4 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 4  [iw = P_GEW], col nof

***Schüler****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 5  [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 5  [iw = P_GEW], col nof

***Rentner****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 6 &  HP_SEX == 1 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 6 &  HP_SEX == 1 [iw = P_GEW], col nof


***Rentnerin****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof


****AUTO***

***Erwerbstätige****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 1 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 1 [iw = P_GEW], col nof

***Nichterwerbstätige****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 2 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 2 [iw = P_GEW], col nof

***Studenten/Azubis****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 3 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 3 [iw = P_GEW], col nof

***Kinder unter 6 Jahre****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 4 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 4 [iw = P_GEW], col nof

***Schüler****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 5 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 5 [iw = P_GEW], col nof

***Rentner****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 6 &  HP_SEX == 1 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 6 &  HP_SEX == 1 [iw = P_GEW], col nof


***Rentnerin****
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof




***ÖPNV***

***Erwerbstätige****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 1 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 1 [iw = P_GEW], col nof

***Nichterwerbstätige****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 2 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 2 [iw = P_GEW], col nof

***Studenten/Azubis****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 3 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 3 [iw = P_GEW], col nof

***Kinder unter 6 Jahre****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 4 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 4 [iw = P_GEW], col nof

***Schüler****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 5 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 5 [iw = P_GEW], col nof


***Rentner****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 6 &  HP_SEX == 1 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 6 &  HP_SEX == 1 [iw = P_GEW], col nof

***Rentnerin****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof




save O:\MiD-H\MIR-2011\stata\Personen_Nutzungsh.dta, replace


***Vergleich und Nutzungshäufigkeiten 2002**

use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear

set mem 800m
set more off

***Überprüfung Fahrradnutzung***
recode p033 (7/9=.e "keine Angabe"), gen(Fahrradnutzung)
label define Fahrradnutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie/habe kein Fahrrad", modify
label values Fahrradnutzung Fahrradnutzung

tab Fahrradnutzung Regins if palter >= 14 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 [iw = gew_pa], col nof


***Überprüfung Autonutzung***
recode p031 (7/9=.e "keine Angabe"), gen(Autonutzung)
label define Autonutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie", modify
label values Autonutzung Autonutzung

tab Autonutzung Regins if palter >= 14 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 [iw = gew_pa], col nof

***Überprüfung Bahn***
recode p032 (7/9=.e "keine Angabe"), gen(Bahnnutzung)
label define Bahnnutzung 1 "(fast) täglich" 2 "An einem bis drei Tagen pro Woche" 3 "An einem bis drei Tagen pro Monat" 4 "Seltener als monatlich" 5 "nie", modify
label values Bahnnutzung Bahnnutzung

tab Bahnnutzung Regins if palter >= 14 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 [iw = gew_pa], col nof

***Überprüfung Fuß***
***gibt es 2002 nicht!!!***


gen PERGRUP2 = .
replace PERGRUP2 = 1 if pergrup == 1
replace PERGRUP2 = 2 if pergrup == 2
replace PERGRUP2 = 3 if pergrup == 3
replace PERGRUP2 = 4 if pergrup == 4
replace PERGRUP2 = 5 if pergrup == 5
replace PERGRUP2 = 5 if pergrup == 6
replace PERGRUP2 = 6 if pergrup == 7
replace PERGRUP2 = 7 if pergrup == 8
replace PERGRUP2 = 7 if pergrup == 9

label define PERGRUP2 1 "Berufstätige(r) mit verfügbarem Pkw" 2 "Berufstätige(r) ohne Pkw" 3 "Nicht-Berufstätige(r) mit verfügbarem Pkw" 4 "Nicht-Berufstätige(r) ohne Pkw" 5 "Student/Auszubildende(r)" 6 "Kind unter 6 Jahre" 7 "Schüler(in)", modify
label values PERGRUP2 PERGRUP2

***Fahrradnutzung nach PG***

***Erwerbstätige ****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 1  [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 1  [iw = gew_pa], col nof


***Nicht-Erwerbstätige ****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 2  [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 2 [iw = gew_pa], col nof

***Student****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 3 [iw = gew_pa], col nof

***Kinder****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 4  [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 4 [iw = gew_pa], col nof

***Schüler****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 5  [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 5 [iw = gew_pa], col nof

***Rentner****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 6 & psex == 1 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 6  & psex == 1 [iw = gew_pa], col nof

***Rentnerin****
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof


***Fahrradnutzung nach PG***

***Erwerbstätige ****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 1  [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 1  [iw = gew_pa], col nof


***Nicht-Erwerbstätige ****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 2  [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 2 [iw = gew_pa], col nof

***Student****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 3 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 3 [iw = gew_pa], col nof

***Kinder****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 4  [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 4 [iw = gew_pa], col nof

***Schüler****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 5  [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 5 [iw = gew_pa], col nof

***Rentner****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 6 & psex == 1 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 6  & psex == 1 [iw = gew_pa], col nof

***Rentnerin****
tab Autonutzung Regins if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof


***Fahrradnutzung nach PG***

***Erwerbstätige ****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 1  [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 1  [iw = gew_pa], col nof


***Nicht-Erwerbstätige ****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 2  [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 2 [iw = gew_pa], col nof

***Student****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 3 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 3 [iw = gew_pa], col nof

***Kinder****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 4  [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 4 [iw = gew_pa], col nof

***Schüler****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 5  [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 5 [iw = gew_pa], col nof

***Rentner****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 6 & psex == 1 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 6  & psex == 1 [iw = gew_pa], col nof

***Rentnerin****
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof

save "O:\MiD-H\MiR2002\Stata\P_Vergleich_Infas.dta", replace

