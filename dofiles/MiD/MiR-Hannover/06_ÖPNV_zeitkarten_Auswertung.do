***PERSONENEBENE***
***Zeitkarten auf Personenebene 2011***
use  "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod.dta", clear

set mem 800m
set more off

recode P070 .s=10

tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 [iw = P_GEW], col nof


***Zeitkarten nach Personengruppen**

***Erwerbstätig**
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 1 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 1 [iw = P_GEW], col nof

***Nicht-Erwerbstätig**
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 2 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 2 [iw = P_GEW], col nof

***Student/Azubi**
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 3 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 3 [iw = P_GEW], col nof

***Kind 0-6 Jahre**
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 4 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 4 [iw = P_GEW], col nof


***Schüler**
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 5 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 5 [iw = P_GEW], col nof


***Rentner - männlich
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 6 & HP_SEX == 1 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 6 & HP_SEX == 1 [iw = P_GEW], col nof


***Rentner - weiblich
tab P070  Regins if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof
tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & PERGRUP_AUS == 6 & HP_SEX == 2 [iw = P_GEW], col nof


***Zeitkarten auf Personenebene 2002***
use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear

set mem 800m
set more off

recode p07 (96/99=.e "keine Angabe")(8=.e), gen(Zeitkarten)
label define Zeitkarten 1 "EinzelTickets" 2 "SammelTickets" 3 "Monatskarte ohne Abo" 4 "Monatskarte mit Abo" 5 "Firmenabo/Studentenabo" 6 "anderes" 9 "keine ÖPNV Nutzung", modify
label values Zeitkarten Zeitkarten

tab Zeitkarten Raumkategorien if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten REGION if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten  Regins if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten Umland_Schiene if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten  Umland if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten Regins_Schiene if palter >= 14 [iw = gew_pa], col nof
tab Zeitkarten Regins_ohne_Schiene if palter >= 14 [iw = gew_pa], col nof


***Zeitkarten nach Personengruppen**


***Erwerbstätig**
tab Zeitkarten  Regins if palter >= 14 & PERGRUP_AUS == 1 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 & PERGRUP_AUS == 1 [iw = gew_pa], col nof

***Nicht-Erwerbstätig**
tab Zeitkarten  Regins if palter >= 14 &  PERGRUP_AUS == 2 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 &  PERGRUP_AUS == 2 [iw = gew_pa], col nof

***Student/Azubi**
tab Zeitkarten  Regins if palter >= 14 &  PERGRUP_AUS == 3 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 &  PERGRUP_AUS == 3 [iw = gew_pa], col nof


***Schüler**
tab Zeitkarten  Regins if palter >= 14 & PERGRUP_AUS == 5 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 & PERGRUP_AUS == 5 [iw = gew_pa], col nof


***Rentner  männlich
tab Zeitkarten  Regins if palter >= 14 &  PERGRUP_AUS == 6 & psex == 1 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 & PERGRUP_AUS == 6 & psex == 1 [iw = gew_pa], col nof

***Rentner weiblich
tab Zeitkarten  Regins if palter >= 14 &  PERGRUP_AUS == 6 & psex ==2 [iw = gew_pa], col nof
tab Zeitkarten Hann_Umland if palter >= 14 & PERGRUP_AUS == 6 & psex == 2 [iw = gew_pa], col nof


save "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", replace

***WEGEEBENE****
***Zeitkarten auf Wegeebene 2011**
use  "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear

set mem 800m
set more off

gen Wege_ÖPNV =.
replace Wege_ÖPNV = 1 if W05_11 == 1
replace Wege_ÖPNV = 1 if W05_12 == 1
replace Wege_ÖPNV = 1 if W05_13 == 1


tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & HWZWECK != 2 & WEGKM_K <=100 [iw = W_GEW], col nof


***Zeitkarten nach Personengruppen**
***Berufstätig**

tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & PERGRUP_AUS == 1 & HWZWECK != 2 & WEGKM_K <=100 [iw = W_GEW], col nof

***Nicht-Berufstätig**

tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & PERGRUP_AUS == 2 & HWZWECK != 2 & WEGKM_K <=100 [iw = W_GEW], col nof

***Student**

tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & PERGRUP_AUS == 3 & HWZWECK != 2 & WEGKM_K <=100 [iw = W_GEW], col nof


***Schüler**

tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & PERGRUP_AUS == 5 & HWZWECK != 2 & WEGKM_K <=100 [iw = W_GEW], col nof

***Rentner männlich**

tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & PERGRUP_AUS == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_SEX == 1 [iw = W_GEW], col nof

***rentner weiblich**

tab P070 Hann_Umland if HP_ALTER >= 14 & P070 != 6 & P070 !=98 & Wege_ÖPNV == 1 & PERGRUP_AUS == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_SEX == 2 [iw = W_GEW], col nof

save  "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", replace


***Zeitkarten auf Wegeebene 2002****
use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear

set mem 800m
set more off

gen Wege_ÖPNV =.
replace Wege_ÖPNV = 1 if w05_11 == 1
replace Wege_ÖPNV = 1 if w05_12 == 1
replace Wege_ÖPNV = 1 if w05_13 == 1

recode p07 (96/99=.e "keine Angabe")(8=.e), gen(Zeitkarten)
label define Zeitkarten 1 "EinzelTickets" 2 "SammelTickets" 3 "Monatskarte ohne Abo" 4 "Monatskarte mit Abo" 5 "Firmenabo/Studentenabo" 6 "anderes" 9 "keine ÖPNV Nutzung", modify
label values Zeitkarten Zeitkarten


tab Zeitkarten Hann_Umland if palter >= 14 & Wege_ÖPNV == 1  & Zeitkarten != 9 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof


***Zeitkarten nach Personengruppen**
***Berufstätig**

tab Zeitkarten Hann_Umland if palter >= 14  & Wege_ÖPNV == 1 & Zeitkarten != 9 & PERGRUP_AUS == 1 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof

***Nicht-Berufstätig**

tab Zeitkarten Hann_Umland if palter >= 14  & Wege_ÖPNV == 1 & Zeitkarten != 9 & PERGRUP_AUS == 2 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof

***Studenten**

tab Zeitkarten Hann_Umland if palter >= 14  & Wege_ÖPNV == 1 & Zeitkarten != 9 & PERGRUP_AUS == 3 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof

***Schüler**

tab Zeitkarten Hann_Umland if palter >= 14  & Wege_ÖPNV == 1 & Zeitkarten != 9 & PERGRUP_AUS == 5 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof

***Rentner männlich**

tab Zeitkarten Hann_Umland if palter >= 14  & Wege_ÖPNV == 1 & Zeitkarten != 9 & PERGRUP_AUS == 6 & psex == 1 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof

***Rentner weiblich**

tab Zeitkarten Hann_Umland if palter >= 14  & Wege_ÖPNV == 1 & Zeitkarten != 9 & PERGRUP_AUS == 6 & psex == 2 & hpzweck != 3 & w08 <= 100 [iw = gew_pa], col nof


save "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", replace
