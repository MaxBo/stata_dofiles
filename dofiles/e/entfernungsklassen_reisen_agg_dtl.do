
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD2008_PUF_Reisen_porto.dta", clear

gen entfernungsklasse_agg = 1 if  p1016 <=400
replace entfernungsklasse_agg = 2 if p1016 >400 & p1016 <=800
replace entfernungsklasse_agg = 3 if p1016 >800 & p1016 <=1200
replace entfernungsklasse_agg = 4 if p1016 >1200 

label define entfernungsklasse_agg 1 `" <=400"', modify
label define entfernungsklasse_agg 2 `" <=800 & > 400"', modify
label define entfernungsklasse_agg 3 `" <=1200 & > 800"', modify
label define entfernungsklasse_agg 4 `" > 1200"', modify

label value entfernungsklasse_agg  entfernungsklasse_agg 
