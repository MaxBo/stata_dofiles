
***2002
use "$MiD\H\Stata\HH_inc_dem_imputed.dta", clear

recode h?fhs (-11=.d) (-12=.e) (-21=.f) (-22=.g) (-10 = 2) (-23=.h) (-24=.i) (-25=.j) (-26=.k) (-27=.l) (-70=.m)(8=.a) (9=.b) (7=.c) (2=0)

forvalues i = 1/8 {
    rename h`i'fhs hfhs`i'
}

keep caseid  hfhs? erwb? taet?  HHErw03 hheink_imp
reshape long hfhs taet erwb, i(caseid) j(pid)
sort caseid pid
drop if hfhs>=.a & hfhs<= .g

save "$MiD\H\Stata\HH_Anzahl_Fhs.dta", replace



use "$MiD\H\Stata\HH_Anzahl_Fhs.dta", clear
merge m:1 caseid using "$MiD\H\Stata\HH_corr.dta", keepusing(h04_3) nogen

merge m:1 caseid pid using "$MiD\H\Stata\P_corr.dta"
drop if _merge==2
drop _merge
sort caseid


* nimm FHS-Frage aus HH-Interview wenn im Personeninterview keine Daten
recode p061_3 (.a .b .c .q .h .r .s .t .x .y .z = 0) if inlist(hfhs, 0 , .i)
recode p061_3 (.b .r .x .y .z = 1) if hfhs == 1
bysort caseid: egen Anzahl_FS= total(p061_3) 


* kein Fhs, kein Pkw im Haushalt
gen PKW_FS = 0
* kein Fhs aber Pkw im Haushalt
replace PKW_FS = 1 if h04_3 >=1 & (p061_3 != 1 | palter <= 17)
* kein Pkw, aber Fhs
replace PKW_FS = 2 if h04_3 == 0 & p061_3 == 1
* eigener Pkw
replace PKW_FS = 3 if h04_3 < Anzahl_FS & h04_3 !=0 & p061_3 == 1 
* geteilter Pkw
replace PKW_FS = 4 if h04_3 >= Anzahl_FS & h04_3 !=0 & p061_3 == 1


label define PKW_FS 0 "kein Fhs, kein Pkw" 1 "kein Fhs, aber HH-Pkw" 2 "Fhs, kein Pkw" 3 "geteilter Pkw" 4 "Eigener Pkw" , add modify
label value PKW_FS PKW_FS

* Taetigkeit
recode taet (1 2 = 1 "Kleinkind") (3 =2 "Schüler") (4 10 = 3 "Azubi") (5=4 "Student") (6 7 8 = 5 "Nicht Erwerbst") (9 = 6 "Rentner bis 75") (.z = 7 "Rentner über 75") (12 = 8 "Vollzeit") (13 = 9 "Teilzeit"), gen(taet2)
recode taet2 (6=7) if palter >= 75


save "$MiD\H\Stata\P_pkwverf.dta", replace

use "$MiD\H\Stata\P_pkwverf.dta", clear

merge 1:m caseid pid using "$MiD\H\Stata\MiD_W.dta", keepusing(VERKM5 w05) nogen
tab PKW_FS VERKM5, row nof
tab PKW_FS VERKM5 [iw=GEW_PA], row nof

