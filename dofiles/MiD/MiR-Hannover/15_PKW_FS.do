use "O:\MiD-H\MIR-2011\stata\Haushalt_Raumkategorien_cod.dta", clear

egen Anzahl_FS= rowtotal(HP_PKWFS V64_A-V70_A) 


gen PKW_FS =.
replace PKW_FS = 1 if H04_3 == 0
replace PKW_FS = 2 if H04_3 >= Anzahl_FS & H04_3 !=0
replace PKW_FS = 3 if H04_3 < Anzahl_FS & H04_3 !=0

keep HHID  Anzahl_FS PKW_FS
sort HHID 

save "O:\MiD-H\MIR-2011\stata\Haushalt_Raumkategorien_cod_PKW.dta", replace

use "O:\MiD-H\MIR-2011\stata\Haushalt_Raumkategorien_cod_PKW.dta", clear

merge HHID using "O:\MiD-H\MIR-2011\stata\Personen_Raumkategorien_cod.dta"

sort HHID
by HHID: replace PKW_FS = 4 if H04_3 >=1 & HP_PKWFS ==0

label define PKW_FS 1 `"kein Pkw im Haushalt"' 2 `"Eigener Pkw"' 3 `"geteilter Pkw"' 4 `"kein Fhs, aber HH-Pkw"', add modify
label value PKW_FS PKW_FS

***zusammenfassung der Personen je Haushalt nur noch 5 und mehr
gen H02_5 = H02
recode H02_5 (6 = 5)
recode H02_5 (7 = 5)
recode H02_5 (8 = 5)

tab PKW_FS H02_5 [iw=P_GEW], col
tab PKW_FS H02_5  if Hann_Umland == 1 [iw=P_GEW], col
tab PKW_FS H02_5  if Hann_Umland == 2 [iw=P_GEW], col


keep PKW_FS Anzahl_FS HHID PID
sort HHID PID

save "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod_PKW.dta", replace

use "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod_PKW.dta", clear

merge HHID PID using "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta"

drop if _merge == 1

tab PKW_FS Hann_Umland [iw=W_GEW],col

tab HVM  PKW_FS [iw=W_GEW], col
tab HVM  PKW_FS if Hann_Umland == 1 [iw=W_GEW], col
tab HVM  PKW_FS if Hann_Umland == 2 [iw=W_GEW], col



***2002
use "O:\MiD-H\MiR2002\Stata\HH_REGION.dta", clear

recode h1fhs (-10 = 2) (-11=.d) (-12=.e) (8=.a) (9=.b)
recode h2fhs (-10 = 2) (-11=.d) (-12=.e) (-21=.f) (8=.a) (9=.b) (7=.c)
recode h3fhs (-10 = 2) (-11=.d) (-12=.e) (-21=.f) (-22=.g) (8=.a) (9=.b) (7=.c)
recode h4fhs (-10 = 2) (-11=.d) (-12=.e) (-21=.f) (-22=.g) (-23=.h) (8=.a) (9=.b) (7=.c)
recode h5fhs (-11=.d) (-10 = 2) (-12=.e) (-21=.f) (-22=.g) (-23=.h) (-24=.i) (8=.a) (9=.b) (7=.c)
recode h6fhs (-11=.d) (-12=.e) (-10 = 2) (-21=.f) (-22=.g) (-23=.h) (-24=.i) (-25=.j)(8=.a) (9=.b) (7=.c)
recode h7fhs (-11=.d) (-12=.e) (-21=.f) (-10 = 2)(-22=.g) (-23=.h) (-24=.i) (-25=.j) (-26=.k) (-70=.m)(8=.a) (9=.b) (7=.c)
recode h8fhs (-11=.d) (-12=.e) (-21=.f) (-22=.g) (-10 = 2) (-23=.h) (-24=.i) (-25=.j) (-26=.k) (-27=.l) (-70=.m)(8=.a) (9=.b) (7=.c)


egen Anzahl_FS= rowtotal(h1fhs-h8fhs) 

keep caseid  Anzahl_FS
sort caseid 

save "O:\MiD-H\MiR2002\Stata\HH_REGION_PKW.dta", replace



use "O:\MiD-H\MiR2002\Stata\HH_REGION_PKW.dta", clear

merge caseid using "O:\MiD-H\MiR2002\Stata\P_REGION2.dta"

sort caseid


gen PKW_FS =.
replace PKW_FS = 1 if h04_3 == 0
replace PKW_FS = 2 if h04_3 >= Anzahl_FS & h04_3 !=0
replace PKW_FS = 3 if h04_3 < Anzahl_FS & h04_3 !=0

by caseid: replace PKW_FS = 4 if h04_3 >=1 & p06 != 1 | palter <= 17


label define PKW_FS 1 `"kein Pkw im Haushalt"' 2 `"Eigener Pkw"' 3 `"geteilter Pkw"' 4 `"kein Fhs, aber HH-Pkw"', add modify
label value PKW_FS PKW_FS

gen H02_5 = h02
recode H02_5 (6 = 5)
recode H02_5 (7 = 5)
recode H02_5 (8 = 5)

tab PKW_FS H02_5 [iw=gew_pa], col
tab PKW_FS H02_5  if Hann_Umland == 1 [iw=gew_pa], col
tab PKW_FS H02_5  if Hann_Umland == 2 [iw=gew_pa], col


keep PKW_FS Anzahl_FS caseid pid
sort caseid pid

save "O:\MiD-H\MiR2002\Stata\P_REGION_PKW.dta", replace

use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear
sort caseid pid
save "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", replace

use "O:\MiD-H\MiR2002\Stata\P_REGION_PKW.dta", clear
sort caseid pid

merge caseid pid using "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta"

drop if _merge == 1

tab PKW_FS Hann_Umland [iw=gew_pa],col

tab Verkm5  PKW_FS if Verkm5 !=-9 [iw=gew_pa], col
tab Verkm5  PKW_FS if Hann_Umland == 1 & Verkm5 !=-9 [iw=gew_pa], col
tab Verkm5  PKW_FS if Hann_Umland == 2 & Verkm5 !=-9 [iw=gew_pa], col
