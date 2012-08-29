gen entfernungsklasse_dtl = 1 if  P1016 <=100
replace entfernungsklasse_dtl = 2 if P1016 >100 & P1016 <=200
replace entfernungsklasse_dtl = 3 if P1016 >200 & P1016 <=300
replace entfernungsklasse_dtl = 4 if P1016 >300 & P1016 <=400
replace entfernungsklasse_dtl = 5 if P1016 >400 & P1016 <=500
replace entfernungsklasse_dtl = 6 if P1016 >500 & P1016 <=600
replace entfernungsklasse_dtl = 7 if P1016 >600 & P1016 <=700
replace entfernungsklasse_dtl = 8 if P1016 >700 & P1016 <=800
replace entfernungsklasse_dtl = 9 if P1016 >800 & P1016 <=900
replace entfernungsklasse_dtl = 10 if P1016 >900 & P1016 <=1000
replace entfernungsklasse_dtl = 11 if P1016 >1000

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
label define entfernungsklasse_dtl 11 `" >1000"', modifyta
label value entfernungsklasse_dtl  entfernungsklasse_dtl 
label variable entfernungsklasse_dtl  "innerdeutsche Entfernungsklassen"

-------------------------------------------------------------------------
gen entfernungsklasse_dtl = 1 if  p1016 <=100
replace entfernungsklasse_dtl = 2 if p1016 >100 & p1016 <=200
replace entfernungsklasse_dtl = 3 if p1016 >200 & p1016 <=300
replace entfernungsklasse_dtl = 4 if p1016 >300 & p1016 <=400
replace entfernungsklasse_dtl = 5 if p1016 >400 & p1016 <=500
replace entfernungsklasse_dtl = 6 if p1016 >500 & p1016 <=600
replace entfernungsklasse_dtl = 7 if p1016 >600 & p1016 <=700
replace entfernungsklasse_dtl = 8 if p1016 >700 & p1016 <=800
replace entfernungsklasse_dtl = 9 if p1016 >800 & p1016 <=900
replace entfernungsklasse_dtl = 10 if p1016 >900 & p1016 <=1000
replace entfernungsklasse_dtl = 11 if p1016 >1000

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

-----------------------------------------------------------------------

gen entfernungsklasse_dtl = 1 if  entfernung <=100
replace entfernungsklasse_dtl = 2 if entfernung >100 & entfernung <=200
replace entfernungsklasse_dtl = 3 if entfernung >200 & entfernung <=300
replace entfernungsklasse_dtl = 4 if entfernung >300 & entfernung <=400
replace entfernungsklasse_dtl = 5 if entfernung >400 & entfernung <=500
replace entfernungsklasse_dtl = 6 if entfernung >500 & entfernung <=600
replace entfernungsklasse_dtl = 7 if entfernung >600 & entfernung <=700
replace entfernungsklasse_dtl = 8 if entfernung >700 & entfernung <=800
replace entfernungsklasse_dtl = 9 if entfernung >800 & entfernung <=900
replace entfernungsklasse_dtl = 10 if entfernung >900 & entfernung <=1000
replace entfernungsklasse_dtl = 11 if entfernung >1000

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

replace entfernungsklasse_dtl = .a if entfernung  <=0
label define entfernungsklasse_dtl .a `" nicht verfügbar"', modify