***Raumkategorien erzeugen Personendatensatz****

use "O:\MiD-H\MIR-2011\stata\personen.dta", clear
set mem 800m
set more off

bysort HHID: egen min_entf = min(P054)
bysort HHID: egen max_entf = max(P054)
tab min_entf REGION,mi
recode min_entf (1/4=1) (5/8=0) (97/98=.b), gen(min_schiene)
recode max_entf (1/4=1) (5/8=0) (97/98=.b), gen(max_schiene)
tab min_schiene REGION,mi
tab min_schiene REGION,mi col
tab min_schiene REGION,col
tab max_schiene REGION,col
tab P030 REGION if HP_ALTER >= 14 [iw = P_GEW], col nof

****f�r Hannover Entfernung unter 400m***
recode min_entf (1/3=1) (4/8=0) (97/98=.b), gen(min_schiene_Hann)
recode max_entf (1/3=1) (4/8=0) (97/98=.b), gen(max_schiene_Hann)

gen Hannover_SPNV =.
replace Hannover_SPNV = 1 if REGION == 1 & min_schiene_Hann == 1
label var Hannover_SPNV "Regionen mit Schienenzugang in Hannover"

gen TZ_Umland_SPNV =.
replace TZ_Umland_SPNV = 1 if REGION == 3 & min_schiene == 1
label var TZ_Umland_SPNV "Regionen mit Schienenzugang in TZ-Umland"

gen TZ_Region_SPNV =.
replace TZ_Region_SPNV = 1 if REGION == 2 & min_schiene == 1
label var TZ_Region_SPNV "Regionen mit Schienenzugang in der TZ-Region"

gen Hannover =.
replace Hannover = 1 if REGION == 1 & min_schiene_Hann == 0
label var Hannover "Regionen ohne Schienenzugang in Hannover"

gen TZ_Umland =.
replace TZ_Umland = 1 if REGION == 3 & min_schiene == 0
label var TZ_Umland "Regionen ohne Schienenzugang in TZ-Umland"

gen TZ_Region =.
replace TZ_Region = 1 if REGION == 2 & min_schiene == 0
label var TZ_Region "Regionen ohne Schienenzugang in der TZ-Region"


gen Hann_Umland = REGION
replace Hann_Umland = 1 if REGION == 1
replace Hann_Umland = 2 if REGION > 1

label define Hann_Umland 1 "Stadt Hannover" 2 "Umland (alles au�er Hannover", modify
label values Hann_Umland Hann_Umland

gen Umland_Schiene =.
replace Umland_Schiene = 1 if Hann_Umland == 2 & min_schiene == 1
label var Umland_Schiene "Regionen mit Schienenzugang im Umland"

gen Umland =.
replace Umland = 1 if Hann_Umland == 2 & min_schiene == 0
label var Umland "Regionen ohne Schienenzugang im Umland"

gen Regins = REGION
replace Regins = 1 if REGION >= 1

gen Regins_Schiene =.
replace Regins_Schiene = 1 if min_schiene == 1
label var Regins_Schiene "Regionen mit Schienenzugang"

gen Regins_ohne_Schiene =.
replace Regins_ohne_Schiene = 1 if min_schiene == 0
label var Regins_ohne_Schiene "Regionen ohne Schienenzugang"

gen Raumkategorien =.
replace Raumkategorien = 1 if Hannover == 1
replace Raumkategorien = 2 if Hannover_SPNV == 1
replace Raumkategorien = 3 if TZ_Region == 1
replace Raumkategorien = 4 if TZ_Region_SPNV == 1
replace Raumkategorien = 5 if TZ_Umland == 1
replace Raumkategorien = 6 if TZ_Umland_SPNV == 1


label define Raumkategorien 1 "Stadt Hannover" 2 "Stadt Hannover_SPNV" 3 "TZ_Region" 4 "TZ_Region_SPNV" 5 "TZ_Umland" 6 "TZ_Umland_SPNV" , modify
label values Raumkategorien Raumkategorien

label var Raumkategorien "Raumkategorien mit und ohne SPNV"

save "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien.dta", replace



***Raumkategorien erzeugen Wegedatensatz****

use "O:\MiD-H\MIR-2011\stata\wege.dta", clear
set mem 800m
set more off

sort HHID

save "O:\MiD-H\MIR-2011\stata\wege.dta", replace


***min_schiene aus Personendatensatz mergen um Raumkategorien zu erzeugen***

use "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien.dta", clear

keep HHID min_entf max_entf min_schiene max_schiene Hannover_SPNV TZ_Umland_SPNV TZ_Region_SPNV Hannover TZ_Umland TZ_Region Hann_Umland Umland_Schiene Umland Regins Regins_Schiene Regins_ohne_Schiene Raumkategorien

sort HHID

save "O:\MiD-H\MIR-2011\stata\Raumkategorien_HHID.dta", replace

use "O:\MiD-H\MIR-2011\stata\wege.dta", clear
merge HHID using "O:\MiD-H\MIR-2011\stata\Raumkategorien_HHID.dta"

drop if _merge == 2
drop _merge


save "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien.dta", replace


****Raumkategorien erzeugen Haushaltsdatensatz***

use "O:\MiD-H\MIR-2011\stata\haushalt.dta", clear

sort HHID

save "O:\MiD-H\MIR-2011\stata\haushalt.dta", replace

use "O:\MiD-H\MIR-2011\stata\haushalt.dta", clear
merge HHID using "O:\MiD-H\MIR-2011\stata\Raumkategorien_HHID.dta"
drop if _merge == 2
drop _merge

save "O:\MiD-H\MIR-2011\stata\Haushalt_Raumkategorien.dta", replace



***Raumkategorien 2002 �ber GIS mergen***

use "O:\MiD-H\MiR2002\Stata\REGION_GIS.dta", clear

rename CASEID caseid
sort caseid

save "O:\MiD-H\MiR2002\Stata\REGION_GIS.dta", replace

use "O:\MiD-H\MiR2002\Stata\P.dta", clear
sort caseid

merge caseid using "O:\MiD-H\MiR2002\Stata\REGION_GIS.dta"

****einzelne Haushalte waren nicht geokodiert konnten aber �ber Gemeindenummer eindeutig einer REgion zugeordnet werden**

drop _merge

rename Gemname REGION
label define REGION 1 "Hannover" 2 "Region" 3 "Umland", modify
label values REGION REGION

gen Hann_Umland = REGION
replace Hann_Umland = 1 if REGION == 1
replace Hann_Umland = 2 if REGION > 1

label define Hann_Umland 1 "Stadt Hannover" 2 "Umland (alles au�er Hannover", modify
label values Hann_Umland Hann_Umland

save "O:\MiD-H\MiR2002\Stata\P_REGION.dta", replace

use "O:\MiD-H\MiR2002\Stata\P_REGION.dta", clear

set mem 800m
set more off

replace p054 = p052 if p054==96
bysort caseid: egen min_entf = min(p054)
bysort caseid: egen max_entf = max(p054)

recode min_entf (1/4=1) (5/8=0) (97/99=.e), gen(min_schiene)
recode max_entf (1/4=1) (5/8=0) (97/99=.e), gen(max_schiene)
tab min_schiene REGION,mi
tab min_schiene REGION,mi col
tab min_schiene REGION,col
tab max_schiene REGION,col

gen Hannover_SPNV =.
replace Hannover_SPNV = 1 if REGION == 1 & min_schiene == 1
label var Hannover_SPNV "Regionen mit Schienenzugang in Hannover"

gen TZ_Umland_SPNV =.
replace TZ_Umland_SPNV = 1 if REGION == 3 & min_schiene == 1
label var TZ_Umland_SPNV "Regionen mit Schienenzugang in TZ-Umland"

gen TZ_Region_SPNV =.
replace TZ_Region_SPNV = 1 if REGION == 2 & min_schiene == 1
label var TZ_Region_SPNV "Regionen mit Schienenzugang in der TZ-Region"

gen Hannover =.
replace Hannover = 1 if REGION == 1 & min_schiene == 0
label var Hannover "Regionen ohne Schienenzugang in Hannover"

gen TZ_Umland =.
replace TZ_Umland = 1 if REGION == 3 & min_schiene == 0
label var TZ_Umland "Regionen ohne Schienenzugang in TZ-Umland"

gen TZ_Region =.
replace TZ_Region = 1 if REGION == 2 & min_schiene == 0
label var TZ_Region "Regionen ohne Schienenzugang in der TZ-Region"



gen Hann_Umland = REGION
replace Hann_Umland = 1 if REGION == 1
replace Hann_Umland = 2 if REGION > 1

label define Hann_Umland 1 "Stadt Hannover" 2 "Umland (alles au�er Hannover", modify
label values Hann_Umland Hann_Umland

gen Umland_Schiene =.
replace Umland_Schiene = 1 if Hann_Umland == 2 & min_schiene == 1
label var Umland_Schiene "Regionen mit Schienenzugang im Umland"

gen Umland =.
replace Umland = 1 if Hann_Umland == 2 & min_schiene == 0
label var Umland "Regionen ohne Schienenzugang im Umland"

gen Regins = REGION
replace Regins = 1 if REGION >= 1

gen Regins_Schiene =.
replace Regins_Schiene = 1 if min_schiene == 1
label var Regins_Schiene "Regionen mit Schienenzugang"

gen Regins_ohne_Schiene =.
replace Regins_ohne_Schiene = 1 if min_schiene == 0
label var Regins_ohne_Schiene "Regionen ohne Schienenzugang"

gen Raumkategorien =.
replace Raumkategorien = 1 if Hannover == 1
replace Raumkategorien = 2 if Hannover_SPNV == 1
replace Raumkategorien = 3 if TZ_Region == 1
replace Raumkategorien = 4 if TZ_Region_SPNV == 1
replace Raumkategorien = 5 if TZ_Umland == 1
replace Raumkategorien = 6 if TZ_Umland_SPNV == 1


label define Raumkategorien 1 "Stadt Hannover" 2 "Stadt Hannover_SPNV" 3 "TZ_Region" 4 "TZ_Region_SPNV" 5 "TZ_Umland" 6 "TZ_Umland_SPNV" , modify
label values Raumkategorien Raumkategorien

label var Raumkategorien "Raumkategorien mit und ohne SPNV"

save "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", replace




***Raumkategorien erzeugen Wegedatensatz****

use "O:\MiD-H\MiR2002\Stata\W.dta", clear
set mem 800m
set more off

sort caseid

save "O:\MiD-H\MiR2002\Stata\W.dta", replace


***min_schiene aus Personendatensatz mergen um Raumkategorien zu erzeugen***

use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear

keep caseid p07 REGION min_entf max_entf min_schiene max_schiene Hannover_SPNV TZ_Umland_SPNV TZ_Region_SPNV Hannover TZ_Umland TZ_Region Hann_Umland Umland_Schiene Umland Regins Regins_Schiene Regins_ohne_Schiene Raumkategorien

sort caseid

save "O:\MiD-H\MiR2002\Stata\Raumkategorien_HHID.dta", replace

use "O:\MiD-H\MiR2002\Stata\W.dta", clear
merge caseid using "O:\MiD-H\MiR2002\Stata\Raumkategorien_HHID.dta"

drop if _merge == 2
drop _merge

save "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien.dta", replace



***Raumkategorien erzeugen Haushaltsdatensatz****

use "O:\MiD-H\MiR2002\Stata\HH.dta", clear
set mem 800m
set more off

sort caseid

save "O:\MiD-H\MiR2002\Stata\HH.dta", replace


***min_schiene aus Personendatensatz mergen um Raumkategorien zu erzeugen***

use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear

keep caseid p07 REGION min_entf max_entf min_schiene max_schiene Hannover_SPNV TZ_Umland_SPNV TZ_Region_SPNV Hannover TZ_Umland TZ_Region Hann_Umland Umland_Schiene Umland Regins Regins_Schiene Regins_ohne_Schiene Raumkategorien

sort caseid

save "O:\MiD-H\MiR2002\Stata\Raumkategorien_HHID.dta", replace

use "O:\MiD-H\MiR2002\Stata\HH.dta", clear
merge caseid using "O:\MiD-H\MiR2002\Stata\Raumkategorien_HHID.dta"

drop if _merge == 2
drop _merge

save "O:\MiD-H\MiR2002\Stata\HH_Raumkategorien.dta", replace
