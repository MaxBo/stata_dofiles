***2002***
use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear
set mem 800m
set more off


***Personengruppe mit Rentner***

gen PERGRUP_NEU = PERGRUP2
replace PERGRUP_NEU = 8 if palter >=65 & lebensp == 1
replace PERGRUP_NEU = 8 if palter >=65 & lebensp == 2 & p15 ==2
replace PERGRUP_NEU = 8 if lebensp == 2 & p15 ==2
replace PERGRUP_NEU = 8 if lebensp == 1 & p15 ==2

label define PERGRUP_NEU 1 "Berufstätige(r) mit verfügbarem Pkw" 2 "Berufstätige(r) ohne Pkw" 3 "Nicht-Berufstätige(r) mit verfügbarem Pkw" 4 "Nicht-Berufstätige(r) ohne Pkw" 5 "Student/Auszubildende(r)" 6 "Kind unter 6 Jahre" 7 "Schüler(in)" 8 "Rentner(in)", modify
label values PERGRUP_NEU PERGRUP_NEU


***Modal Split Renter und NICht-Erwerbstätige***

***Nichterwerbstätige mit Pkw****

tab Verkm5 Raumkategorien if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if PERGRUP_NEU == 3 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Umland if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if PERGRUP_NEU == 3 & Verkm5 !=-9 [iw=gew_pa], col nof

***Nichterwerbstätige ohne Pkw****

tab Verkm5 Raumkategorien if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if PERGRUP_NEU == 4  & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Umland if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if PERGRUP_NEU == 4 & Verkm5 !=-9 [iw=gew_pa], col nof


***Renter****

tab Verkm5 Raumkategorien if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if PERGRUP_NEU == 8  & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Umland if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if PERGRUP_NEU == 8 & Verkm5 !=-9 [iw=gew_pa], col nof



***Nichterwerbstätige mit Pkw****
tab Fahrradnutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung REGION if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Umland if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof

***Nichterwerbstätige ohne Pkw****
tab Fahrradnutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung REGION if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Umland if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof

***Rentner****
tab Fahrradnutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung REGION if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung Regins if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung Umland if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Fahrradnutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof



***Nichterwerbstätige mit Pkw****
tab Autonutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung REGION if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung Regins if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung Umland if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Autonutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof

***Nichterwerbstätige ohne Pkw****
tab Autonutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung REGION if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung Regins if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung Umland if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Autonutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof

***Rentner****
tab Autonutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung REGION if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung Regins if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung Umland if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Autonutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof


***Nichterwerbstätige mit Pkw****
tab Bahnnutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung REGION if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung Umland if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof
tab Bahnnutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 3 [iw = gew_pa], col nof

***Nichterwerbstätige ohne Pkw****
tab Bahnnutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung REGION if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung Umland if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof
tab Bahnnutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 4 [iw = gew_pa], col nof

***Rentner****
tab Bahnnutzung Raumkategorien if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung REGION if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung Regins if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung Umland_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung Umland if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung Regins_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof
tab Bahnnutzung Regins_ohne_Schiene if palter >= 14 & PERGRUP_NEU == 8 [iw = gew_pa], col nof


****2011***
use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear
set mem 800m
set more off

***Personengruppe mit Rentner***

gen PERGRUP_NEU = PERGRUP2
replace PERGRUP_NEU = 8 if HP_ALTER >=65 & LEBENSPH == 7 


label define PERGRUP_NEU 1 "Berufstätige(r) mit verfügbarem Pkw" 2 "Berufstätige(r) ohne Pkw" 3 "Nicht-Berufstätige(r) mit verfügbarem Pkw" 4 "Nicht-Berufstätige(r) ohne Pkw" 5 "Student/Auszubildende(r)" 6 "Kind unter 6 Jahre" 7 "Schüler(in)" 8 "Rentner(in)", modify
label values PERGRUP_NEU PERGRUP_NEU



***Modal Split Renter und NICht-Erwerbstätige***
***Nichterwerbstätige mit Pkw****

tab HVM Raumkategorien if PERGRUP_NEU == 3  [iw=W_GEW], col nof
tab HVM REGION if PERGRUP_NEU == 3   [iw=W_GEW], col nof
tab HVM Regins if PERGRUP_NEU == 3  [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_NEU == 3  [iw=W_GEW], col nof
tab HVM Umland_Schiene if PERGRUP2 == 3  [iw=W_GEW], col nof
tab HVM Umland if PERGRUP_NEU == 3  [iw=W_GEW], col nof
tab HVM Regins_Schiene if PERGRUP_NEU == 3  [iw=W_GEW], col nof
tab HVM Regins_ohne_Schiene if PERGRUP_NEU == 3  [iw=W_GEW], col nof

***Nichterwerbstätige ohne Pkw****

tab HVM Raumkategorien if PERGRUP_NEU == 4  [iw=W_GEW], col nof
tab HVM REGION if PERGRUP_NEU == 4   [iw=W_GEW], col nof
tab HVM Regins if PERGRUP_NEU == 4  [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_NEU == 4  [iw=W_GEW], col nof
tab HVM Umland_Schiene if PERGRUP_NEU == 4  [iw=W_GEW], col nof
tab HVM Umland if PERGRUP_NEU == 4  [iw=W_GEW], col nof
tab HVM Regins_Schiene if PERGRUP_NEU == 4  [iw=W_GEW], col nof
tab HVM Regins_ohne_Schiene if PERGRUP_NEU == 4  [iw=W_GEW], col nof


***Rentner****

tab HVM Raumkategorien if PERGRUP_NEU == 8  [iw=W_GEW], col nof
tab HVM REGION if PERGRUP_NEU == 8   [iw=W_GEW], col nof
tab HVM Regins if PERGRUP_NEU == 8  [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_NEU == 8  [iw=W_GEW], col nof
tab HVM Umland_Schiene if PERGRUP_NEU == 8  [iw=W_GEW], col nof
tab HVM Umland if PERGRUP_NEU == 8  [iw=W_GEW], col nof
tab HVM Regins_Schiene if PERGRUP_NEU == 8  [iw=W_GEW], col nof
tab HVM Regins_ohne_Schiene if PERGRUP_NEU == 8  [iw=W_GEW], col nof



***Nutzungshäufigkeiten
***Nichterwerbstätige mit Pkw****
tab Fahrradnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fahrradnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof

***Nichterwerbstätige ohne Pkw****
tab Fahrradnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fahrradnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof

***Rentner****
tab Fahrradnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fahrradnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof


***Nichterwerbstätige mit Pkw****
tab Fußnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Fußnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof

***Nichterwerbstätige ohne Pkw****
tab Fußnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Fußnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof

***Rentner****
tab Fußnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Fußnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof


***Nichterwerbstätige mit Pkw****
tab Autonutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Autonutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof

***Nichterwerbstätige ohne Pkw****
tab Autonutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Autonutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof

***Rentner****
tab Autonutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Autonutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof


***Nichterwerbstätige mit Pkw****
tab Bahnnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof
tab Bahnnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 3 [iw = P_GEW], col nof

***Nichterwerbstätige ohne Pkw****
tab Bahnnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof
tab Bahnnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 4 [iw = P_GEW], col nof

***Rentner****
tab Bahnnutzung Raumkategorien if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung REGION if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung  Regins if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung Umland_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung  Umland if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung Regins_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
tab Bahnnutzung Regins_ohne_Schiene if HP_ALTER >= 14 & PERGRUP_NEU == 8 [iw = P_GEW], col nof
