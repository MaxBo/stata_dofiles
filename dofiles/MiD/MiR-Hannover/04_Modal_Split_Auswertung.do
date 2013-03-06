**Modal Split Vergleich Infas***

use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear
set mem 800m
set more off


tab HVM Regins if HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***über 18 Jahre
tab HVM Regins if HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof


***Modal Split nach Tagen***
***Montag-Freitag***


tab HVM Regins if STICHTAG <= 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if STICHTAG <= 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
***über 18 Jahre
tab HVM Regins if STICHTAG <= 5  & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if STICHTAG <= 5  & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof



****Samstag-Sonntag***
tab HVM Regins if STICHTAG > 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if STICHTAG > 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***über 18 Jahre
tab HVM Regins if STICHTAG > 5  & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if STICHTAG > 5  & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof





****Modal Split nach Personengruppen***
***Erwerbstätige 
tab HVM Regins if PERGRUP_AUS == 1 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 1 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***Nichterwerbstätige ****

tab HVM Regins if PERGRUP_AUS == 2 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 2 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***Studenten****


tab HVM Regins if PERGRUP_AUS == 3 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 3 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof



***Kinder unter 6 Jahren****

tab HVM Regins if PERGRUP_AUS == 4 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 4  & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof


***Schüler ****
tab HVM Regins if PERGRUP_AUS == 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***Rentner ****
tab HVM Regins if PERGRUP_AUS == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_SEX == 1 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_SEX == 1  [iw=W_GEW], col nof

***Rentnerin ****
tab HVM Regins if PERGRUP_AUS == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_SEX == 2 [iw=W_GEW], col nof
tab HVM Hann_Umland if PERGRUP_AUS == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_SEX == 2 [iw=W_GEW], col nof


****Modal Split nach Wegezwecken****
***arbeit**

tab HVM Regins if HWZWECK == 1  & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 1 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof


***Ausbildung**

tab HVM Regins if HWZWECK == 3 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 3 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof


***Einkauf**

tab HVM Regins if HWZWECK == 4 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 4 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***Erledigung**

tab HVM Regins if HWZWECK == 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof


***Freizeit**

tab HVM Regins if HWZWECK == 6 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 6 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof

***Begleitung**

tab HVM Regins if HWZWECK == 7 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 7 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof


****Modal Split nach Wegezwecken - PERSONEN AB 18 Jahren****
***arbeit**

tab HVM Regins if HWZWECK == 1  & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 1 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof


***Ausbildung**

tab HVM Regins if HWZWECK == 3 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 3 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof


***Einkauf**

tab HVM Regins if HWZWECK == 4 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 4 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof

***Erledigung**

tab HVM Regins if HWZWECK == 5 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18  [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 5 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof


***Freizeit**

tab HVM Regins if HWZWECK == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 6 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof

***Begleitung**

tab HVM Regins if HWZWECK == 7 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof
tab HVM Hann_Umland if HWZWECK == 7 & HWZWECK != 2 & WEGKM_K <=100 & HP_ALTER >=18 [iw=W_GEW], col nof



****Modal Split nach Wegelänge***
recode WEGKM_K (0/0.999999=1 "unter 1 Kilometer") (1/1.999999=2 "1-2 Kilometer") (2/4.9999=5 "2-5 Kilometer") (5/9.9999=10 "5-10 Kilometer") (10/14.9999=15 "10-15 Kilometer") (15/19.9999=20 "15-20 Kilometer") (20/49.9999=50 "20-50 Kilometer") (50/max=100 "über 50 Kilometer"), gen(WegekmKl)

***0-1 km**
tab HVM Hann_Umland if WegekmKl == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof


***1-2 km**
tab HVM Hann_Umland if WegekmKl == 2 & WEGKM_K <=100 & HWZWECK != 2  [iw=W_GEW], col nof

***2-5 km**
tab HVM Hann_Umland if WegekmKl == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof

***5-10 km**
tab HVM Hann_Umland if WegekmKl == 10 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof

***10-15 km**
tab HVM Hann_Umland if WegekmKl == 15 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof

***15-20 km**
tab HVM Hann_Umland if WegekmKl == 20 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof

***20-50 km**
tab HVM Hann_Umland if WegekmKl == 50 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof

***über 50 km**
tab HVM Hann_Umland if WegekmKl == 100 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_GEW], col nof



 
save "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", replace


use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear
set mem 800m
set more off

***es gibt keinen Wege-Gewichtungsfaktor, daher wurde hier der Personen-Gewichtungsfaktor verwendet***


tab Verkm5 Regins if Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

*über 18 Jahre
tab Verkm5 Hann_Umland if Verkm5 !=-9 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof


***Modal Split nach Tagen***
***Montag-Freitag***


tab Verkm5 Regins if Verkm5 !=-9 & wtag <= 5 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if Verkm5 !=-9 & wtag <= 5 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
*über 18 Jahre
tab Verkm5 Hann_Umland if Verkm5 !=-9 & wtag <= 5 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof


****Samstag-Sonntag***

tab Verkm5 Regins if Verkm5 !=-9 & wtag > 5 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if Verkm5 !=-9 & wtag > 5 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
*über 18 Jahre
tab Verkm5 Hann_Umland if Verkm5 !=-9 & wtag > 5 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof



****Modal Split nach Personengruppen***
***Erwerbstätige ****

tab Verkm5 Regins if PERGRUP_AUS == 1 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 1 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

***Nichterwerbstätige****
tab Verkm5 Regins if PERGRUP_AUS == 2 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 2 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof



***Studenten****
tab Verkm5 Regins if PERGRUP_AUS == 3 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 3 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

***Kinder****

tab Verkm5 Regins if PERGRUP_AUS == 4 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 4 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

***Schüler****

tab Verkm5 Regins if PERGRUP_AUS == 5 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 5 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof


***Rentner****

tab Verkm5 Regins if PERGRUP_AUS == 6 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 & psex == 1 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 6 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 & psex == 1 [iw=gew_pa], col nof


***Rentnerin****

tab Verkm5 Regins if PERGRUP_AUS == 6 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 & psex == 2 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if PERGRUP_AUS == 6 & Verkm5 !=-9 & hpzweck != 3 & w08 <=100 & psex == 2 [iw=gew_pa], col nof


***Modal Split nach Wegezwecken***
***Arbeit***


tab Verkm5 Regins if hpzweck == 1 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 1 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof


***Ausbildung***

tab Verkm5 Regins if hpzweck == 2 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 2 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

***Einkauf***

tab Verkm5 Regins if hpzweck == 6 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 6 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

***Erledigung***

tab Verkm5 Regins if hpzweck == 5 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 5 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof


***Freizeit***

tab Verkm5 Regins if hpzweck == 7 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 7 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof

***Begleitung***

tab Verkm5 Regins if hpzweck == 4 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 4 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof




***Modal Split nach Wegezwecken - PERSONEN AB 18 JAHREN***
***Arbeit***


tab Verkm5 Regins if hpzweck == 1 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 1 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof


***Ausbildung***

tab Verkm5 Regins if hpzweck == 2 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 2 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof

***Einkauf***

tab Verkm5 Regins if hpzweck == 6 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 6 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof

***Erledigung***

tab Verkm5 Regins if hpzweck == 5 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 5 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof


***Freizeit***

tab Verkm5 Regins if hpzweck == 7 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 7 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof

***Begleitung***

tab Verkm5 Regins if hpzweck == 4 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if hpzweck == 4 & Verkm5 !=-9 & hpzweck !=8 & hpzweck != 3 & w08 <=100 & palter >=18 [iw=gew_pa], col nof


***Modal Split nach Wegelänge***
****0-1 Km***

tab Verkm5 Raumkategorien if WegekmKl == 1 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 1 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 1 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 1 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 1 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 1 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 1 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 1 & Verkm5 !=-9  [iw=gew_pa], col nof


***1-2 km***
tab Verkm5 Raumkategorien if WegekmKl == 2 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 2 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 2 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 2 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 2 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 2 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 2 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 2 & Verkm5 !=-9  [iw=gew_pa], col nof

***2-5 km***
tab Verkm5 Raumkategorien if WegekmKl == 5 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 5 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 5 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 5 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 5 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 5 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 5 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 5 & Verkm5 !=-9  [iw=gew_pa], col nof



***5-10 km***
tab Verkm5 Raumkategorien if WegekmKl == 10 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 10 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 10 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 10 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 10 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 10 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 10 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 10 & Verkm5 !=-9  [iw=gew_pa], col nof

***10-15 km***
tab Verkm5 Raumkategorien if WegekmKl == 15 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 15 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 15 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 15 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 15 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 15 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 15 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 15 & Verkm5 !=-9  [iw=gew_pa], col nof


***15-20 km***
tab Verkm5 Raumkategorien if WegekmKl == 20 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 20 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 20 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 20 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 20 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 20 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 20 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 20 & Verkm5 !=-9  [iw=gew_pa], col nof

***20-50 km***
tab Verkm5 Raumkategorien if WegekmKl == 50 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 50 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 50 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 50 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 50 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 50 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 50 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 50 & Verkm5 !=-9  [iw=gew_pa], col nof

***über 50 km ***
tab Verkm5 Raumkategorien if WegekmKl == 100 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 REGION if WegekmKl == 100 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Regins if WegekmKl == 100 & Verkm5 !=-9 [iw=gew_pa], col nof
tab Verkm5 Hann_Umland if WegekmKl == 100 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland_Schiene if WegekmKl == 100 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Umland if WegekmKl == 100 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_Schiene if WegekmKl == 100 & Verkm5 !=-9  [iw=gew_pa], col nof
tab Verkm5 Regins_ohne_Schiene if WegekmKl == 100 & Verkm5 !=-9  [iw=gew_pa], col nof


***mittlere Wegelänge berechnen- Durchschnitt - alle Distanzen***
gen WEGKM_D = w08
replace WEGKM_D =. if w08 >=1000

***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_D hpzweck if hpzweck == 1
tabstat WEGKM_D hpzweck if hpzweck == 2
tabstat WEGKM_D hpzweck if hpzweck == 3
tabstat WEGKM_D hpzweck if hpzweck == 4
tabstat WEGKM_D hpzweck if hpzweck == 5
tabstat WEGKM_D hpzweck if hpzweck == 6
tabstat WEGKM_D hpzweck if hpzweck == 7

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_D Verkm5 if Verkm5 == 1
tabstat WEGKM_D Verkm5 if Verkm5 == 2
tabstat WEGKM_D Verkm5 if Verkm5 == 3
tabstat WEGKM_D Verkm5 if Verkm5 == 4
tabstat WEGKM_D Verkm5 if Verkm5 == 5

****durchschnittliche Wegelänge nach Lebensph***
tabstat WEGKM_D LEBENSPH if LEBENSPH == 1
tabstat WEGKM_D LEBENSPH if LEBENSPH == 2
tabstat WEGKM_D LEBENSPH if LEBENSPH == 3
tabstat WEGKM_D LEBENSPH if LEBENSPH == 4
tabstat WEGKM_D LEBENSPH if LEBENSPH == 5
tabstat WEGKM_D LEBENSPH if LEBENSPH == 6
tabstat WEGKM_D LEBENSPH if LEBENSPH == 7

***Stadt Hannover***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 1 & Hann_Umland == 1
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 2 & Hann_Umland == 1
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 3 & Hann_Umland == 1
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 4 & Hann_Umland == 1
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 5 & Hann_Umland == 1
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 6 & Hann_Umland == 1
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 7 & Hann_Umland == 1

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 1 & Hann_Umland == 1
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 2 & Hann_Umland == 1
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 3 & Hann_Umland == 1
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 4 & Hann_Umland == 1
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 5 & Hann_Umland == 1

****durchschnittliche Wegelänge nach Lebensph***
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 1 & Hann_Umland == 1
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 2 & Hann_Umland == 1
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 3 & Hann_Umland == 1
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 4 & Hann_Umland == 1
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 5 & Hann_Umland == 1
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 6 & Hann_Umland == 1
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 7 & Hann_Umland == 1


***Umland***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 1 & Hann_Umland == 2
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 2 & Hann_Umland == 2
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 3 & Hann_Umland == 2
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 4 & Hann_Umland == 2
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 5 & Hann_Umland == 2
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 6 & Hann_Umland == 2
tabstat WEGKM_D hpzweck Hann_Umland if hpzweck == 7 & Hann_Umland == 2

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 1 & Hann_Umland == 2
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 2 & Hann_Umland == 2
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 3 & Hann_Umland == 2
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 4 & Hann_Umland == 2
tabstat WEGKM_D Verkm5 Hann_Umland if Verkm5 == 5 & Hann_Umland == 2

****durchschnittliche Wegelänge nach Lebensph***
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 1 & Hann_Umland == 2
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 2 & Hann_Umland == 2
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 3 & Hann_Umland == 2
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 4 & Hann_Umland == 2
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 5 & Hann_Umland == 2
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 6 & Hann_Umland == 2
tabstat WEGKM_D LEBENSPH Hann_Umland if LEBENSPH == 7 & Hann_Umland == 2


***mittlere Wegelänge berechnen- Durchschnitt Distanzen nur bis 100 km, nur Region***
gen WEGKM_D_R = w08
replace WEGKM_D_R =. if w08 >=100

***REGION insgesamt***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_D_R hpzweck if hpzweck == 1
tabstat WEGKM_D_R hpzweck if hpzweck == 2
tabstat WEGKM_D_R hpzweck if hpzweck == 3
tabstat WEGKM_D_R hpzweck if hpzweck == 4
tabstat WEGKM_D_R hpzweck if hpzweck == 5
tabstat WEGKM_D_R hpzweck if hpzweck == 6
tabstat WEGKM_D_R hpzweck if hpzweck == 7

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_D_R Verkm5 if Verkm5 == 1
tabstat WEGKM_D_R Verkm5 if Verkm5 == 2
tabstat WEGKM_D_R Verkm5 if Verkm5 == 3
tabstat WEGKM_D_R Verkm5 if Verkm5 == 4
tabstat WEGKM_D_R Verkm5 if Verkm5 == 5

****durchschnittliche Wegelänge nach Lebensph***
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 1
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 2
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 3
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 4
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 5
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 6
tabstat WEGKM_D_R LEBENSPH if LEBENSPH == 7


***Stadt Hannover***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 1 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 2 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 3 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 4 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 5 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 6 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 7 & Hann_Umland == 1

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 1 & Hann_Umland == 1
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 2 & Hann_Umland == 1
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 3 & Hann_Umland == 1
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 4 & Hann_Umland == 1
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 5 & Hann_Umland == 1

****durchschnittliche Wegelänge nach Lebensph***
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 1 & Hann_Umland == 1
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 2 & Hann_Umland == 1
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 3 & Hann_Umland == 1
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 4 & Hann_Umland == 1
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 5 & Hann_Umland == 1
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 6 & Hann_Umland == 1
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 7 & Hann_Umland == 1



***Umland***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 1 & Hann_Umland == 2
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 2 & Hann_Umland == 2
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 3 & Hann_Umland == 2
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 4 & Hann_Umland == 2
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 5 & Hann_Umland == 2
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 6 & Hann_Umland == 2
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 7 & Hann_Umland == 2

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 1 & Hann_Umland == 2
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 2 & Hann_Umland == 2
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 3 & Hann_Umland == 2
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 4 & Hann_Umland == 2
tabstat WEGKM_D_R Verkm5 Hann_Umland if Verkm5 == 5 & Hann_Umland == 2

****durchschnittliche Wegelänge nach Lebensph***
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 1 & Hann_Umland == 2
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 2 & Hann_Umland == 2
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 3 & Hann_Umland == 2
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 4 & Hann_Umland == 2
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 5 & Hann_Umland == 2
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 6 & Hann_Umland == 2
tabstat WEGKM_D_R LEBENSPH Hann_Umland if LEBENSPH == 7 & Hann_Umland == 2


gen HHGRue14 = h02-hhgr14
gen HHGR_gew = 1 + (HHGRue14 - 1)*0.5 + hhgr14*0.3 if HHGRue14>0


gen mittlEink = 400 if hheink==1
replace mittlEink = 750 if hheink==2
replace mittlEink = 1200 if hheink==3
replace mittlEink = 1750 if hheink==4
replace mittlEink = 2300 if hheink==5
replace mittlEink = 2800 if hheink==6
replace mittlEink = 3300 if hheink==7
replace mittlEink = 3800 if hheink==8
replace mittlEink = .a if hheink>20
replace mittlEink = .a if hheink==-61
replace mittlEink = .a if hheink==-60

label define mittlEink .a `"keine Angabe"', modify
label value mittlEink mittlEink
label var mittlEink "durchschnittliches Haushaltsnettoeinkommen, Mittelwert der Einkommensklassen"

gen aeqEink = mittlEink/HHGR_gew 

label var aeqEink "Äquivalenzeinkommen"

save "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", replace
