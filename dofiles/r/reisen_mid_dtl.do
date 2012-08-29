clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD2008_PUF_Reisen.dta", clear

gen grund_aggr = 3
replace grund_aggr = 2 if p101 ==4
replace grund_aggr = 1 if p101 <= 2
label define grund_aggr 1 `"leisure"' 2 `"business"' 3 `"other"', modify
label value grund_aggr grund_aggr

gen vm_aggr = 4
replace vm_aggr = 3 if  hvm_r ==4
replace vm_aggr = 2 if  hvm_r ==2
replace vm_aggr = 1 if  hvm_r==1
label define vm_aggr 1 `"car"' 2 `"rail"' 3 `"airplane"' 4 `"other"', modify
label value vm_aggr vm_aggr

gen entfernungsklasse_dtl = 1 if p1016 <=100
replace entfernungsklasse_dtl = 2 if p1016 >100 & p1016 <=200
replace entfernungsklasse_dtl = 3 if p1016 >200 & p1016 <=300
replace entfernungsklasse_dtl = 4 if p1016 >300 & p1016 <=400
replace entfernungsklasse_dtl = 5 if p1016 >400 & p1016 <=500
replace entfernungsklasse_dtl = 6 if p1016 >500 & p1016 <=600
replace entfernungsklasse_dtl = 7 if p1016 >600 & p1016 <=700
replace entfernungsklasse_dtl = 8 if p1016 >700 & p1016 <=800
replace entfernungsklasse_dtl = 9 if p1016 >800 & p1016 <=900
replace entfernungsklasse_dtl = 10 if p1016 >900 & p1016 <=1000
replace entfernungsklasse_dtl = 11 if p1016 >1000 & p1016 <=20001

label define entfernungsklasse_dtl 1 `" <=100"', modify
label define entfernungsklasse_dtl 2 `" <=200 & > 100"', modify
label define entfernungsklasse_dtl 3 `" <=300 & > 200"', modify
label define entfernungsklasse_dtl 4 `" <=400 & > 300"', modify
label define entfernungsklasse_dtl 5 `" <=500 & > 400"', modify
label define entfernungsklasse_dtl 6 `" <=600 & > 500"', modify
label define entfernungsklasse_dtl 7 `" <=700 & > 600"', modify
label define entfernungsklasse_dtl 8 `" <=800 & > 700"', modify
label define entfernungsklasse_dtl 9 `" <=900 & > 800"', modify
label define entfernungsklasse_dtl 10 `" <=1000 & > 900"', modify
label define entfernungsklasse_dtl 11 `" >1000"', modify
label value entfernungsklasse_dtl  entfernungsklasse_dtl 
label variable entfernungsklasse_dtl  "innerdeutsche Entfernungsklassen"

