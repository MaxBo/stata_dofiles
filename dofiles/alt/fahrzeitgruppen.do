* Bilden von Zeitgruppen für eine bessere Auswertung

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", clear

gen fahrzeitgruppe = 1 if fahrzeit <= 5
replace fahrzeitgruppe = 2 if fahrzeit > 5 & fahrzeit <=10
replace fahrzeitgruppe = 3 if fahrzeit > 10 & fahrzeit <=15
replace fahrzeitgruppe = 4 if fahrzeit > 15 & fahrzeit <=30
replace fahrzeitgruppe = 5 if fahrzeit > 30 & fahrzeit <=45
replace fahrzeitgruppe = 6 if fahrzeit > 45 & fahrzeit <=60
replace fahrzeitgruppe = 7 if fahrzeit > 60 & fahrzeit <=75
replace fahrzeitgruppe = 8 if fahrzeit > 75 & fahrzeit <=90
replace fahrzeitgruppe = 9 if fahrzeit > 90 & fahrzeit <=105
replace fahrzeitgruppe = 10 if fahrzeit > 105 & fahrzeit <=120
replace fahrzeitgruppe = 11 if fahrzeit > 120
replace fahrzeitgruppe = .a if missing(fahrzeit)

label define fahrzeitgruppe 1 `"<=5"', modify
label define fahrzeitgruppe 2 `"<=10"', modify
label define fahrzeitgruppe 3 `"<=15"', modify
label define fahrzeitgruppe 4 `"<=30"', modify
label define fahrzeitgruppe 5 `"<=45"', modify
label define fahrzeitgruppe 6 `"<=60"', modify
label define fahrzeitgruppe 7 `"<=75"', modify
label define fahrzeitgruppe 8 `"<=90"', modify
label define fahrzeitgruppe 9 `"<=105"', modify
label define fahrzeitgruppe 10 `"<=120"', modify
label define fahrzeitgruppe 11 `">120"', modify
label define fahrzeitgruppe .a `"keine Angabe"', modify

label value fahrzeitgruppe fahrzeitgruppe
