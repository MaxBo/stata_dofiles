***Personengruppe mit Rentner***
***2002**
gen PERGRUP_AUS = PERGRUP_NEU
replace PERGRUP_AUS = 1 if PERGRUP_NEU == 2
replace PERGRUP_AUS = 2 if PERGRUP_NEU == 3
replace PERGRUP_AUS = 2 if PERGRUP_NEU == 4
replace PERGRUP_AUS = 3 if PERGRUP_NEU == 5
replace PERGRUP_AUS = 4 if PERGRUP_NEU == 6
replace PERGRUP_AUS = 5 if PERGRUP_NEU == 7
replace PERGRUP_AUS = 6 if PERGRUP_NEU == 8 & psex == 1
replace PERGRUP_AUS = 7 if PERGRUP_NEU == 8 & psex == 2


label define PERGRUP_AUS 1 "Berufstätige(r)" 2 "Nicht-Berufstätige(r)" 3 "Student/Auszubildende(r)" 4 "Kind unter 6 Jahre" 5 "Schüler(in)" 6 "Rentner" 7 "Rentnerin", modify
label values PERGRUP_AUS PERGRUP_AUS


***2011**
gen PERGRUP_AUS = PERGRUP_NEU
replace PERGRUP_AUS = 1 if PERGRUP_NEU == 2
replace PERGRUP_AUS = 2 if PERGRUP_NEU == 3
replace PERGRUP_AUS = 2 if PERGRUP_NEU == 4
replace PERGRUP_AUS = 3 if PERGRUP_NEU == 5
replace PERGRUP_AUS = 4 if PERGRUP_NEU == 6
replace PERGRUP_AUS = 5 if PERGRUP_NEU == 7
replace PERGRUP_AUS = 6 if PERGRUP_NEU == 8 & HP_SEX == 1
replace PERGRUP_AUS = 7 if PERGRUP_NEU == 8 & HP_SEX == 2


label define PERGRUP_AUS 1 "Berufstätige(r)" 2 "Nicht-Berufstätige(r)" 3 "Student/Auszubildende(r)" 4 "Kind unter 6 Jahre" 5 "Schüler(in)" 6 "Rentner" 7 "Rentnerin", modify
label values PERGRUP_AUS PERGRUP_AUS
