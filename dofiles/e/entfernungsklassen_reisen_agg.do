
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Reisen_t2.dta", clear

gen entfernungsklasse_agg = 1 if  P1016 <=400
replace entfernungsklasse_agg = 2 if P1016 >400 & P1016 <=800
replace entfernungsklasse_agg = 3 if P1016 >800 & P1016 <=1200
replace entfernungsklasse_agg = 4 if P1016 >1200 

label define entfernungsklasse_agg 1 `" <=400"', modify
label define entfernungsklasse_agg 2 `" <=800 & > 400"', modify
label define entfernungsklasse_agg 3 `" <=1200 & > 800"', modify
label define entfernungsklasse_agg 4 `" > 1200"', modify

label value entfernungsklasse_agg  entfernungsklasse_agg 