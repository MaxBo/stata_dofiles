clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege_zeit_wegn.dta", clear

gen hvm_neu=1 if hvm_diff==1
replace hvm_neu=2 if hvm_diff==2
replace hvm_neu=3 if (hvm_diff>2 & hvm_diff<8) | hvm_diff==9
replace hvm_neu=4 if hvm_diff ==8 | hvm_diff==10

label var hvm_neu "Neue Verkehrsmittelklassen"
label define hvm_neu 1 `"Fuß"' 2  `"Rad"' 3 `"MIV"' 4  `"ÖPNV"'
label value hvm_neu hvm_neu

gen Zweck_aggr = 1 if Zweck==2
replace Zweck_aggr =2 if Zweck==3 | Zweck==4
replace Zweck_aggr = 3 if Zweck==7 | Zweck==9 | Zweck==12

label var Zweck_aggr "Zweck für Auswertungen Philine"
label define zweck_aggr 1  `"Arbeit"' 2 `"Einkauf"' 3  `"Freizeit"'
label value Zweck_aggr zweck_aggr

tab Zweck_aggr hvm_neu [iw=w_gew] if bland==2, col row




