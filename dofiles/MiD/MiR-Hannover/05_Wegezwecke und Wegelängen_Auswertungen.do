**Wegezwecke nach Regionen***

use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod.dta", clear
set mem 800m
set more off


tab HWZWECK Regins if HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof
tab HWZWECK Hann_Umland if HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col nof


***Wochenende**
tab HWZWECK Hann_Umland if HWZWECK != 2 & WEGKM_K <=100 & STICHTAG >5 [iw=W_GEW], col nof



***Werktags
tab HWZWECK Hann_Umland if HWZWECK != 2 & WEGKM_K <=100 & STICHTAG <=5 [iw=W_GEW], col nof


***durchschnittliche Wegelängen nach HWZWECK
*Region insgesamt
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_K HWZWECK if HWZWECK == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 1
tabstat WEGKM_K HWZWECK if HWZWECK == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 2
tabstat WEGKM_K HWZWECK if HWZWECK == 3 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK if HWZWECK == 4 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK if HWZWECK == 5 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK if HWZWECK == 6 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK if HWZWECK == 7 & WEGKM_K <=100 & HWZWECK !=2

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_K HVM if HVM == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM if HVM == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM if HVM == 3 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM if HVM == 4 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM if HVM == 5 & WEGKM_K <=100 & HWZWECK !=2

***Stadt Hannover***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 1
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 2 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 3 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2 
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 4 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 5 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 6 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 7 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_K HVM Hann_Umland if HVM == 1 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 2 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 3 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 4 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 5 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2

***Umland***
***durchschnittliche Wegelänge nach Wegzweck***
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 1
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 2 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 3 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 4 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 5 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 6 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HWZWECK Hann_Umland if HWZWECK == 7 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2

***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat WEGKM_K HVM Hann_Umland if HVM == 1 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 2 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 3 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 4 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGKM_K HVM Hann_Umland if HVM == 5 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2

***2002***

use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien.dta", clear
set mem 800m
set more off


tab hpzweck Regins if hpzweck !=8 [iw=gew_pa], col nof
tab hpzweck Hann_Umland if hpzweck !=8 & hpzweck != 3 & w08 <=100 [iw=gew_pa], col nof


***Wochenende**
tab hpzweck Hann_Umland if hpzweck !=8 & hpzweck != 3 & w08 <=100 & wtag >5 [iw=gew_pa], col nof



***Werktags
tab hpzweck Hann_Umland if hpzweck !=8 & hpzweck != 3 & w08 <=100 & wtag <=5 [iw=gew_pa], col nof


*Region insgesamt
***durchschnittliche Wegelänge nach Wegzweck***
tabstat w08 hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & psex == 1
tabstat w08 hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & psex == 2
tabstat w08 hpzweck if hpzweck == 2 & w08 <=100 & hpzweck !=3
tabstat w08 hpzweck if hpzweck == 4 & w08 <=100 & hpzweck !=3
tabstat w08 hpzweck if hpzweck == 5 & w08 <=100 & hpzweck !=3
tabstat w08 hpzweck if hpzweck == 6 & w08 <=100 & hpzweck !=3
tabstat w08 hpzweck if hpzweck == 7 & w08 <=100 & hpzweck !=3


***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat  w08 Verkm5 if Verkm5 == 1 & w08 <=100 & hpzweck !=3
tabstat  w08 Verkm5 if Verkm5 == 2 & w08 <=100 & hpzweck !=3
tabstat  w08 Verkm5 if Verkm5 == 3 & w08 <=100 & hpzweck !=3
tabstat  w08 Verkm5 if Verkm5 == 4 & w08 <=100 & hpzweck !=3
tabstat  w08 Verkm5 if Verkm5 == 5 & w08 <=100 & hpzweck !=3


*Stadt Hannover
***durchschnittliche Wegelänge nach Wegzweck***
tabstat w08 hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1 & psex == 1
tabstat w08 hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1 & psex == 2
tabstat w08 hpzweck if hpzweck == 2 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat w08 hpzweck if hpzweck == 4 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat w08 hpzweck if hpzweck == 5 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat w08 hpzweck if hpzweck == 6 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat w08 hpzweck if hpzweck == 7 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1


***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat  w08 Verkm5 if Verkm5 == 1 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat  w08 Verkm5 if Verkm5 == 2 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat  w08 Verkm5 if Verkm5 == 3 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat  w08 Verkm5 if Verkm5 == 4 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1
tabstat  w08 Verkm5 if Verkm5 == 5 & w08 <=100 & hpzweck !=3 & Hann_Umland == 1


*Umland
***durchschnittliche Wegelänge nach Wegzweck***
tabstat w08 hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2 & psex == 1
tabstat w08 hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2 & psex == 2
tabstat w08 hpzweck if hpzweck == 2 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat w08 hpzweck if hpzweck == 4 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat w08 hpzweck if hpzweck == 5 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat w08 hpzweck if hpzweck == 6 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat w08 hpzweck if hpzweck == 7 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2


***durchschnittliche Wegelänge nach Verkehrsmittel****
tabstat  w08 Verkm5 if Verkm5 == 1 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat  w08 Verkm5 if Verkm5 == 2 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat  w08 Verkm5 if Verkm5 == 3 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat  w08 Verkm5 if Verkm5 == 4 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2
tabstat  w08 Verkm5 if Verkm5 == 5 & w08 <=100 & hpzweck !=3 & Hann_Umland == 2

**Wegelängen nach Regionen***

use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod.dta", clear
set mem 800m
set more off

tab WegekmKl Raumkategorien[iw=W_GEW], col nof
tab WegekmKl REGION [iw=W_GEW], col nof
tab WegekmKl Regins [iw=W_GEW], col nof
tab WegekmKl Hann_Umland if HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], col 
tab WegekmKl Umland_Schiene [iw=W_GEW], col nof
tab WegekmKl Umland [iw=W_GEW], col nof
tab WegekmKl Regins_Schiene [iw=W_GEW], col nof
tab WegekmKl Regins_ohne_Schiene [iw=W_GEW], col nof

***durchschnittliche Wegelängen***



***2002***

use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien.dta", clear
set mem 800m
set more off


tab WegekmKl Hann_Umland if hpzweck !=8 & hpzweck !=3 & w08 <=100 [iw=gew_pa], col 



***durchschnittliche Wegelängen***
