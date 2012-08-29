set more off


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_raum.dta", clear

gen hrg_invermo = 1 if hrg3==1
replace hrg_invermo = 2 if hrg3!=1 & f13_1>4
replace hrg_invermo = 3 if missing(hrg_invermo)
label value hrg_invermo hrg3

gen modo = wochentag<5
label var modo "Wochentag Montag bis Donnerstag"
label value modo jn


