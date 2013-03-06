use "O:\MiD-H\MiR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear


***neuer Hochrechnungsfaktor -- Wegdauer

recode WEGMIN_K (994=.a) (3301=.b)
label define WEGMIN_K .a `"unplausibler Wert"' .b `"nicht zu bestimmen"', add modify
label value WEGMIN_K WEGMIN_K



***durchschnittliche Wegedauer nach Verkehrsmittel****
tabstat WEGMIN_K HVM if HVM == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM if HVM == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM if HVM == 3 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM if HVM == 4 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM if HVM == 5 & WEGKM_K <=100 & HWZWECK !=2

***durchschnittliche Wegedauer nach Verkehrsmittel****
tabstat WEGMIN_K HVM Hann_Umland if HVM == 1 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 2 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 3 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 4 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 5 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2


***durchschnittliche Wegedauer nach Verkehrsmittel****
tabstat WEGMIN_K HVM Hann_Umland if HVM == 1 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 2 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 3 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 4 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HVM Hann_Umland if HVM == 5 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2

***Durchschnittliche Wegdauer nach HWZWECK Region insgesamt
tabstat WEGMIN_K HWZWECK  if HWZWECK == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 1
tabstat WEGMIN_K HWZWECK  if HWZWECK == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 2
tabstat WEGMIN_K HWZWECK  if HWZWECK == 3  & WEGKM_K <=100 & HWZWECK !=2 
tabstat WEGMIN_K HWZWECK  if HWZWECK == 4  & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK  if HWZWECK == 5  & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK  if HWZWECK == 6  & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK  if HWZWECK == 7 & WEGKM_K <=100 & HWZWECK !=2

***Durchschnittliche Wegdauer nach HWZWECK Stadt Hannover
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 1
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 3 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2 
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 4 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 5 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 6 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 7 & Hann_Umland == 1 & WEGKM_K <=100 & HWZWECK !=2

***Durchschnittliche Wegdauer nach HWZWECK Umland
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 1
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 1 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2 & HP_SEX == 2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 3 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2 
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 4 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 5 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 6 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2
tabstat WEGMIN_K HWZWECK Hann_Umland if HWZWECK == 7 & Hann_Umland == 2 & WEGKM_K <=100 & HWZWECK !=2

save "O:\MiD-H\MiR-2011\stata\Wege_Raumkategorien_cod_neu.dta", replace


***2002
use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear


recode wegdauer (999996=.a) (999995=.b)
label define wegdauer .a `"unplausibler Wert"' .b `"nicht zu bestimmen"', add modify
label value wegdauer wegdauer



***durchschnittliche Wegedauer nach Verkehrsmittel****
tabstat wegdauer Verkm5 if Verkm5 == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Verkm5 if Verkm5 == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Verkm5 if Verkm5 == 3 & w08 <=100 & hpzweck !=3
tabstat wegdauer Verkm5 if Verkm5 == 4 & w08 <=100 & hpzweck !=3
tabstat wegdauer Verkm5 if Verkm5 == 5 & w08 <=100 & hpzweck !=3

***durchschnittliche Wegedauer nach Verkehrsmittel****
tabstat wegdauer Hann_Umland if Verkm5 == 1 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 2 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 3 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 4 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 5 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3

***durchschnittliche Wegedauer nach Verkehrsmittel****
tabstat wegdauer Hann_Umland if Verkm5 == 1 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 2 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 3 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 4 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if Verkm5 == 5 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3



***durchschnittliche Wegedauer nach HWZWECK Region insgesamt****
tabstat wegdauer hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & psex == 1
tabstat wegdauer hpzweck if hpzweck == 1 & w08 <=100 & hpzweck !=3 & psex == 2
tabstat wegdauer hpzweck if hpzweck == 2 & w08 <=100 & hpzweck !=3 
tabstat wegdauer hpzweck if hpzweck == 4 & w08 <=100 & hpzweck !=3 
tabstat wegdauer hpzweck if hpzweck == 5 & w08 <=100 & hpzweck !=3 
tabstat wegdauer hpzweck if hpzweck == 6 & w08 <=100 & hpzweck !=3 
tabstat wegdauer hpzweck if hpzweck == 7 & w08 <=100 & hpzweck !=3 


***durchschnittliche Wegedauer nach HWZWECK Stadt Hannover****
tabstat wegdauer Hann_Umland if hpzweck == 1 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3 & psex == 1
tabstat wegdauer Hann_Umland if hpzweck == 1 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3 & psex == 2
tabstat wegdauer Hann_Umland if hpzweck == 2 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3 
tabstat wegdauer Hann_Umland if hpzweck == 4 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if hpzweck == 5 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if hpzweck == 6 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if hpzweck == 7 & Hann_Umland == 1 & w08 <=100 & hpzweck !=3


***durchschnittliche Wegedauer nach HWZWECK Umland***
tabstat wegdauer Hann_Umland if hpzweck == 1 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3 & psex == 1
tabstat wegdauer Hann_Umland if hpzweck == 1 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3 & psex == 2
tabstat wegdauer Hann_Umland if hpzweck == 2 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3 
tabstat wegdauer Hann_Umland if hpzweck == 4 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if hpzweck == 5 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if hpzweck == 6 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
tabstat wegdauer Hann_Umland if hpzweck == 7 & Hann_Umland == 2 & w08 <=100 & hpzweck !=3
