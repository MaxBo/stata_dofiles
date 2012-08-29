* use "C:\Sonja_Diss\KiD_2002\Einzelfahrten_100622.dta", clear

* gen entfernungsklasse=1 if F14 <=20
* replace entfernungsklasse=2 if F14 <=40 & F14 >20 
* replace entfernungsklasse=3 if F14 <=60 & F14 >40
* replace entfernungsklasse=4 if F14 <=80 & F14 >60
* replace entfernungsklasse=5 if F14 <=100 & F14 >80
* replace entfernungsklasse=6 if F14 <=120 & F14 >100
* replace entfernungsklasse=7 if F14 <=140 & F14 >120
* replace entfernungsklasse=8 if F14 >140

* ----------------------------------------------------------
use "C:\Sonja_Diss\KiD_2002\Einzelfahrten_100622.dta", clear

gen entfernungsklasse=1 if F14 <=5
replace entfernungsklasse=2 if F14 <=10 & F14 >5 
replace entfernungsklasse=3 if F14 <=15 & F14 >10
replace entfernungsklasse=4 if F14 <=20 & F14 >15
replace entfernungsklasse=5 if F14 <=25 & F14 >20
replace entfernungsklasse=6 if F14 <=30 & F14 >25
replace entfernungsklasse=7 if F14 <=35 & F14 >30
replace entfernungsklasse=8 if F14 <=40 & F14 >35
replace entfernungsklasse=9 if F14 <=45 & F14 >40
replace entfernungsklasse=10 if F14 <=50 & F14 >45
replace entfernungsklasse=11 if F14 >50 & F14 < 9999
label variable entfernungsklasse "Fahrweiten in 5km-Schritten bis 50km"

gen entfernungsklasse2=1 if F14 <=50
replace entfernungsklasse2=2 if F14 <=100 & F14 >50
replace entfernungsklasse2=3 if F14 <=150 & F14 >100
replace entfernungsklasse2=4 if F14 <=200 & F14 >150
replace entfernungsklasse2=5 if F14 <=250 & F14 >200
replace entfernungsklasse2=6 if F14 <=300 & F14 >250
replace entfernungsklasse2=7 if F14 <=350 & F14 >300
replace entfernungsklasse2=8 if F14 <=400 & F14 >350
replace entfernungsklasse2=9 if F14 <=450 & F14 >400
replace entfernungsklasse2=10 if F14 > 450 & F14 < 9999
label variable entfernungsklasse2 "Fahrweiten in 50km-Schritten bis 450km"

gen entfernungsklasse3=1 if F14 <=100
replace entfernungsklasse3=2 if F14 <=200 & F14 >100
replace entfernungsklasse3=3 if F14 <=300 & F14 >200
replace entfernungsklasse3=4 if F14 <=400 & F14 >300
replace entfernungsklasse3=5 if F14 <=500 & F14 >400
replace entfernungsklasse3=6 if F14 <=600 & F14 >500
replace entfernungsklasse3=7 if F14 <=700 & F14 >600
replace entfernungsklasse3=8 if F14 <=800 & F14 >700
replace entfernungsklasse3=9 if F14 <=900 & F14 >800
replace entfernungsklasse3=10 if F14 <=1000 & F14 >900
replace entfernungsklasse3=11 if F14 > 1000 & F14 < 9999
label variable entfernungsklasse3 "Fahrweiten in 100km-Schritten bis 1000km"
