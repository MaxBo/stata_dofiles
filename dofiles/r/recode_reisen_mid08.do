clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_Zusatzfile\MiD2008_Zusatzfile_Reisen.dta", clear

replace p101 = .f if p101==97
replace p101 = .g if p101==98

replace p1015 = .f if p1015==97
replace p1015 = .g if p1015==98
replace p1015 = .z if p1015==201

replace p1014 = .f if p1014==97
replace p1014 = .g if p1014==98

replace p1012 = .f if p1012==7
replace p1012 = .g if p1012==8

replace p1016 =  .f if p1016==99997
replace p1016 =  .g if p1016==99998

label define p101 .f `"verweigert"' .g `"weiﬂ nicht"', add
label define p1012 .f `"verweigert"' .g `"weiﬂ nicht"', add
label define p1016 .f `"verweigert"' .g `"weiﬂ nicht"' .z  `"1-Personen-HH"', add

label value p101 p101
label value p1012 p1012
label value p1016 p1016
label value p1015 p1016
label value p1014 p1016


gen Reisezweck = 1 if p101 ==4
replace Reisezweck = 2 if p101 == 1
replace Reisezweck = 3 if p101 == 2 | p101 ==3 | p101 == 5 | p101==6

label var Reisezweck "Reisezweck"
label define Reisezweck 1 `"gesch‰ftlich"' 2 `"Urlaub"'  3 `"privat"'
label value Reisezweck Reisezweck

sort hhid pid rid
bysort hhid pid: gen p_reisen_doku = _N
bysort hhid: gen hh_reisen_doku = _N
label var p_reisen_doku "Anzahl dokumentierter Reisen je Person"
label var hh_reisen_doku "Anzahl dokumentierter Reisen je Haushalt"

gen Entfernungsklasse_400 = 1 if  p1016 <=400
replace Entfernungsklasse_400 = 2 if p1016 >400 & p1016 <=800
replace Entfernungsklasse_400 = 3 if p1016 >800 & p1016 <=1200
replace Entfernungsklasse_400 = 4 if p1016 >1200 & p1016 <.

label define Entfernungsklasse_400 1 `" <=400"', modify
label define Entfernungsklasse_400 2 `" <=800 & > 400"', modify
label define Entfernungsklasse_400 3 `" <=1200 & > 800"', modify
label define Entfernungsklasse_400 4 `" > 1200"', modify

label value Entfernungsklasse_400  Entfernungsklasse_400 
label var Entfernungsklasse_400 "Entfernungsklassen in 400er-Schritten"

gen HVM_Reise = 1 if p1013_4==1
replace HVM_Reise = 3 if missing(HVM_Reise) & p1013_2==1 & p1013_6==1
replace HVM_Reise = 2 if missing(HVM_Reise) & p1013_2==1
replace HVM_Reise = 4 if missing(HVM_Reise) & p1013_6==1
replace HVM_Reise = 5 if missing(HVM_Reise) & p1013_3==1
replace HVM_Reise = 6 if missing(HVM_Reise) & p1013_1==1

label var HVM_Reise "Hauptverkehrsmitel der Reise"
label define HVM_Reise 1 `"Flugzeug"' 2 `"Bahn"'  3 `"Schiff & Bahn"' 4 `"Schiff"' 5 `"Reisebus"' 6 `"Auto"'
label value HVM_Reise HVM_Reise

merge hhid pid using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_Zusatzfile\MiD2008_Zusatzfile_Personen.dta", sort uniqusing keep( p01_1 p032 p034 p035 p052 p054 p11 p13 p15 p16 p17 p14a p14b p14_1 p16_1 p070 p070_a rbw0 rbw1 p06 p_gew p_hoch)
replace p10=0 if _merge==2
replace rid=1 if _merge==2
drop _merge

merge hhid using "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\MiD2008\Regionaldatensatz\Daten\STATA\MiD2008_Regionalfile.dta", sort uniqusing
drop _merge
merge hhid using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_Zusatzfile\MiD2008_Zusatzfile_Haushalte.dta", sort uniqusing keep( hh_gew hh_hoch h01 h02 h07 fak_hhgr  h072c h040_1 h040_2 h040_3 h040_4 h040_5 h040_6)
drop _merge
merge hhid using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\alt\MiD2008_PUF_Haushalte.dta", sort uniqusing keep(oek_stat bland  polgk rtyp rtypd7 ktyp ktyp_zsg sgtyp sgtypd)
drop _merge

* Anzahl Verkehrsflugh‰fen je Bundesland hinzuspielen
* recode zugespielter Variablen

