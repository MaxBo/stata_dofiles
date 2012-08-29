clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_9_1.dta", clear


gen ek = 1 if  WEGKM_K <=1
replace ek = 0.5 WEGKM_K>0 & WEGKM_K <=0.5
replace ek = 2 if WEGKM_K>1 & WEGKM_K <=2
replace ek = 5 if WEGKM_K>2 & WEGKM_K <=5
replace ek = 10 if WEGKM_K>5 & WEGKM_K <=10
replace ek = 25 if WEGKM_K>10 & WEGKM_K <=25
replace ek = 50 if WEGKM_K>25 & WEGKM_K <=50
replace ek = 51 if WEGKM_K>50 & WEGKM_K < 9000

tab ek, gen (ek_gr_)

gen aktzeitgruppe = 1 if akt_dauer <= 5 & akt_dauer>=0
replace aktzeitgruppe =  2 if akt_dauer > 5 & akt_dauer <= 10
replace aktzeitgruppe =  3 if akt_dauer > 10 & akt_dauer <= 15
replace aktzeitgruppe =  4 if akt_dauer > 15 & akt_dauer <= 30
replace aktzeitgruppe =  5 if akt_dauer > 30 & akt_dauer <= 45
replace aktzeitgruppe =  6 if akt_dauer > 45 & akt_dauer <= 60
replace aktzeitgruppe =  7 if akt_dauer > 60 & akt_dauer <= 75
replace aktzeitgruppe =  8 if akt_dauer > 75 & akt_dauer <= 90
replace aktzeitgruppe =  9 if akt_dauer > 90 & akt_dauer <= 120
replace aktzeitgruppe =  10 if akt_dauer > 120 & akt_dauer <= 150
replace aktzeitgruppe =  11 if akt_dauer > 150 & akt_dauer <= 180
replace aktzeitgruppe =  12 if akt_dauer > 180 & akt_dauer <= 210
replace aktzeitgruppe =  13 if akt_dauer > 210 & akt_dauer <= 240
replace aktzeitgruppe =  14 if akt_dauer > 240 & akt_dauer <= 270
replace aktzeitgruppe =  15 if akt_dauer > 270 & akt_dauer <= 300
replace aktzeitgruppe =  16 if akt_dauer > 300 & akt_dauer <= 330
replace aktzeitgruppe =  17 if akt_dauer > 330 & akt_dauer <= 360
replace aktzeitgruppe =  18 if akt_dauer > 360 & akt_dauer <= 390
replace aktzeitgruppe =  19 if akt_dauer > 390 & akt_dauer <= 420
replace aktzeitgruppe =  20 if akt_dauer > 420 & akt_dauer <= 450
replace aktzeitgruppe =  21 if akt_dauer > 450 & akt_dauer <= 480
replace aktzeitgruppe =  22 if akt_dauer > 480 & akt_dauer <= 510
replace aktzeitgruppe =  23 if akt_dauer > 510 & akt_dauer <= 540
replace aktzeitgruppe =  24 if akt_dauer > 540 & akt_dauer <= 570
replace aktzeitgruppe =  25 if akt_dauer > 570 & akt_dauer <= 600
replace aktzeitgruppe =  26 if akt_dauer > 600 & akt_dauer <= 630
replace aktzeitgruppe =  27 if akt_dauer > 630 & akt_dauer <= 660
replace aktzeitgruppe =  28 if akt_dauer > 660 & akt_dauer <= 690
replace aktzeitgruppe =  29 if akt_dauer > 690 & akt_dauer <= 720
replace aktzeitgruppe =  30 if akt_dauer > 720 & akt_dauer <= 750
replace aktzeitgruppe =  31 if akt_dauer > 750 & akt_dauer <= 780
replace aktzeitgruppe =  32 if akt_dauer > 780 & akt_dauer <= 810
replace aktzeitgruppe = 33 if akt_dauer > 810
replace aktzeitgruppe = .a if missing(akt_dauer) | akt_dauer < 0

label define aktzeitgruppe 1 `"<=5"', modify
label define aktzeitgruppe 2 `" <= 10 "', modify
label define aktzeitgruppe 3 `" <= 15 "', modify
label define aktzeitgruppe 4 `" <= 30 "', modify
label define aktzeitgruppe 5 `" <= 45 "', modify
label define aktzeitgruppe 6 `" <= 60 "', modify
label define aktzeitgruppe 7 `" <= 75 "', modify
label define aktzeitgruppe 8 `" <= 90 "', modify
label define aktzeitgruppe 9 `" <= 120 "', modify
label define aktzeitgruppe 10 `" <= 150 "', modify
label define aktzeitgruppe 11 `" <= 180 "', modify
label define aktzeitgruppe 12 `" <= 210 "', modify
label define aktzeitgruppe 13 `" <= 240 "', modify
label define aktzeitgruppe 14 `" <= 270 "', modify
label define aktzeitgruppe 15 `" <= 300 "', modify
label define aktzeitgruppe 16 `" <= 330 "', modify
label define aktzeitgruppe 17 `" <= 360 "', modify
label define aktzeitgruppe 18 `" <= 390 "', modify
label define aktzeitgruppe 19 `" <= 420 "', modify
label define aktzeitgruppe 20 `" <= 450 "', modify
label define aktzeitgruppe 21 `" <= 480 "', modify
label define aktzeitgruppe 22 `" <= 510 "', modify
label define aktzeitgruppe 23 `" <= 540 "', modify
label define aktzeitgruppe 24 `" <= 570 "', modify
label define aktzeitgruppe 25 `" <= 600 "', modify
label define aktzeitgruppe 26 `" <= 630 "', modify
label define aktzeitgruppe 27 `" <= 660 "', modify
label define aktzeitgruppe 28 `" <= 690 "', modify
label define aktzeitgruppe 29 `" <= 720 "', modify
label define aktzeitgruppe 30 `" <= 750 "', modify
label define aktzeitgruppe 31 `" <= 780 "', modify
label define aktzeitgruppe 32 `" <= 810 "', modify

label define aktzeitgruppe 33 `">810"', modify
label define aktzeitgruppe .a `"keine Angabe"', modify

label value aktzeitgruppe aktzeitgruppe
label var aktzeitgruppe "Gruppierung der Aktivitätszeiten, keine einheitlichen Gruppengrenzen"

gen fahrzeitgruppe = 1 if fahrzeit <= 5 & fahrzeit>=0
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
replace fahrzeitgruppe = .a if missing(fahrzeit) | fahrzeit<0

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
label var fahrzeitgruppe "Gruppierung der Fahrzeiten, keine einheitlichen Gruppengrenzen"

tab fahrzeitgruppe, gen (FZ_Gr_)
tab aktzeitgruppe, gen (AKT_Gr_)
