* Bilden von Zeitgruppen für eine bessere Auswertung

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", clear

gen aktzeitgruppe = 1 if akt_dauer <= 15
replace aktzeitgruppe = 2 if akt_dauer > 15 & akt_dauer <=30
replace aktzeitgruppe = 3 if akt_dauer > 30 & akt_dauer <=45
replace aktzeitgruppe = 4 if akt_dauer > 45 & akt_dauer <=60
replace aktzeitgruppe = 5 if akt_dauer > 60 & akt_dauer <=90
replace aktzeitgruppe = 6 if akt_dauer > 90 & akt_dauer <=120
replace aktzeitgruppe = 7 if akt_dauer > 120 & akt_dauer <=180
replace aktzeitgruppe = 8 if akt_dauer > 180 & akt_dauer <=240
replace aktzeitgruppe = 9 if akt_dauer > 240 & akt_dauer <=300
replace aktzeitgruppe = 10 if akt_dauer > 300 & akt_dauer <=360
replace aktzeitgruppe = 11 if akt_dauer > 120
replace aktzeitgruppe = .a if missing(fahrzeit) | fahrzeit < 0

label define aktzeitgruppe 1 `"<=5"', modify
label define aktzeitgruppe 2 `"<=10"', modify
label define aktzeitgruppe 3 `"<=15"', modify
label define aktzeitgruppe 4 `"<=30"', modify
label define aktzeitgruppe 5 `"<=45"', modify
label define aktzeitgruppe 6 `"<=60"', modify
label define aktzeitgruppe 7 `"<=75"', modify
label define aktzeitgruppe 8 `"<=90"', modify
label define aktzeitgruppe 9 `"<=105"', modify
label define aktzeitgruppe 10 `"<=120"', modify
label define aktzeitgruppe 11 `">120"', modify
label define aktzeitgruppe .a `"keine Angabe"', modify

label value aktzeitgruppe aktzeitgruppe
