
clear
set memory 700m
use "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.dta", clear

gen entfernungsklasse=1 if f14 <=5
replace entfernungsklasse=2 if f14 <=10 & f14 >5 
replace entfernungsklasse=3 if f14 <=15 & f14 >10
replace entfernungsklasse=4 if f14 <=20 & f14 >15
replace entfernungsklasse=5 if f14 <=25 & f14 >20
replace entfernungsklasse=6 if f14 <=30 & f14 >25
replace entfernungsklasse=7 if f14 <=35 & f14 >30
replace entfernungsklasse=8 if f14 <=40 & f14 >35
replace entfernungsklasse=9 if f14 <=45 & f14 >40
replace entfernungsklasse=10 if f14 <=50 & f14 >45
replace entfernungsklasse=11 if f14 >50 & f14 < 9999
label variable entfernungsklasse "Fahrweiten in 5km-Schritten bis 50km"

gen entfernungsklasse2=1 if f14 <=50
replace entfernungsklasse2=2 if f14 <=100 & f14 >50
replace entfernungsklasse2=3 if f14 <=150 & f14 >100
replace entfernungsklasse2=4 if f14 <=200 & f14 >150
replace entfernungsklasse2=5 if f14 <=250 & f14 >200
replace entfernungsklasse2=6 if f14 <=300 & f14 >250
replace entfernungsklasse2=7 if f14 <=350 & f14 >300
replace entfernungsklasse2=8 if f14 <=400 & f14 >350
replace entfernungsklasse2=9 if f14 <=450 & f14 >400
replace entfernungsklasse2=10 if f14 > 450 & f14 < 9999
label variable entfernungsklasse2 "Fahrweiten in 50km-Schritten bis 450km"

* gen entfernungsklasse3=1 if f14 <=100
* replace entfernungsklasse3=2 if f14 <=200 & f14 >100
* replace entfernungsklasse3=3 if f14 <=300 & f14 >200
* replace entfernungsklasse3=4 if f14 <=400 & f14 >300
* replace entfernungsklasse3=5 if f14 <=500 & f14 >400
* replace entfernungsklasse3=6 if f14 <=600 & f14 >500
* replace entfernungsklasse3=7 if f14 <=700 & f14 >600
* replace entfernungsklasse3=8 if f14 <=800 & f14 >700
* replace entfernungsklasse3=9 if f14 <=900 & f14 >800
* replace entfernungsklasse3=10 if f14 <=1000 & f14 >900
* replace entfernungsklasse3=11 if f14 > 1000 & f14 < 9999
* label variable entfernungsklasse3 "Fahrweiten in 100km-Schritten bis 1000km"
