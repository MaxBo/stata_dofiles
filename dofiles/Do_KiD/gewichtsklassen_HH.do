clear
set memory 700m
use "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.dta", clear

gen gew_kl_s = 1 if f12 == 0
replace gew_kl_s = 2 if f12 <=50 & f12 > 0
replace gew_kl_s = 3 if f12 <=100 & f12 > 50
replace gew_kl_s = 4 if f12 <=150 & f12 > 100
replace gew_kl_s = 5 if f12 <=200 & f12 > 150
replace gew_kl_s = 6 if f12 <=250 & f12 > 200
replace gew_kl_s = 7 if f12 <=300 & f12 > 250
replace gew_kl_s = 8 if f12 <=350 & f12 > 300
replace gew_kl_s = 9 if f12 <=400 & f12 > 350
replace gew_kl_s = 10 if f12 <=450 & f12 > 400
replace gew_kl_s = 11 if f12 <=500 & f12 > 450
replace gew_kl_s = 12 if f12  > 500 & f12 < 99999

label variable gew_kl_s "Gewichtsklassen 50er Schritte bis 500kg"


gen gew_kl_m = 1 if f12 == 0
replace gew_kl_m = 2 if f12 <=500 & f12 > 0
replace gew_kl_m = 3 if f12 <=1000 & f12 > 500
replace gew_kl_m = 4 if f12 <=1500 & f12 > 1000
replace gew_kl_m = 5 if f12 <=2000 & f12 > 1500
replace gew_kl_m = 6 if f12 <=2500 & f12 > 2000
replace gew_kl_m = 7 if f12 <=3000 & f12 > 2500
replace gew_kl_m = 8 if f12 <=3500 & f12 > 3000
replace gew_kl_m = 9 if f12 <=4000 & f12 > 3500
replace gew_kl_m = 10 if f12 <=4500 & f12 > 4000
replace gew_kl_m = 11 if f12 <=5000 & f12 > 4500
replace gew_kl_m = 12 if f12  > 5000 & f12 < 99999

label variable gew_kl_m "Gewichtsklassen 500er Schritte bis 5.000kg"


gen gew_kl_x = 1 if f12 == 0
replace gew_kl_x = 2 if f12 <=5000 & f12 > 0
replace gew_kl_x = 3 if f12 <=10000 & f12 > 5000
replace gew_kl_x = 4 if f12 <=15000 & f12 > 10000
replace gew_kl_x = 5 if f12 <=20000 & f12 > 15000
replace gew_kl_x = 6 if f12 <=25000 & f12 > 20000
replace gew_kl_x = 7 if f12 <=30000 & f12 > 25000
replace gew_kl_x = 8 if f12 <=35000 & f12 > 30000
replace gew_kl_x = 9 if f12 <=40000 & f12 > 35000
replace gew_kl_x = 10 if f12 <=45000 & f12 > 40000

label variable gew_kl_x "Gewichtsklassen 5.000er Schritte bis 45.000 kg"

save "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.dta", replace
