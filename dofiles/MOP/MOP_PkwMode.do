version 10

*** Datenaufbereitung der MOP-Daten für Modellschätzungen zum Pkw-Besitz ***

use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_HH.dta", clear
MOP_recodeHH
recode PKWHH (2/5=2 "2 und mehr"), gen(hpkw02)
label var hpkw02 "HH-Pkw (0-2)"
recode PKWHH (3/5=3 "3 und mehr"), gen(hpkw03)
label var hpkw03 "HH-Pkw (0-3)"
recode PKWHH (4/5=4 "4 und mehr"), gen(hpkw04)
label var hpkw04 "HH-Pkw (0-4)"
// Pkw-Besitz im Vorjahr
bysort ID (JAHR): gen hpkw03LastY = hpkw03[_n-1] if ID==ID[_n-1]
label var hpkw03LastY "Pkws im Vorjahr"
quietly compress
recast long ID
save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_HH0.dta", replace

use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_KIND.dta", clear
MOP_recodeKIND
quietly compress
recast long ID PHHID
replace FSPKW=0
replace FSMOT=0
drop PKWVERF MOPED 
save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_KIND0.dta", replace

use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_P.dta", clear
append using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_POT.dta", nolabel
recast long ID PHHID
duplicates tag ID PERSNR JAHR, gen(doppelt)
drop if doppelt & ALTER==.
drop doppelt
MOP_recodeP
append using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_KIND0.dta", nolabel
duplicates tag ID PERSNR JAHR, gen(doppelt)
bysort ID PERSNR JAHR: egen keinAbschluss = total (SCHULAB==5) if doppelt
drop if doppelt & keinAbschluss & SCHULAB!=5
recode SCHULAB (1/4 .a = 5) if doppelt & keinAbschluss==0
drop if doppelt & keinAbschluss==0 & SCHULAB>=.

rename ZEITOPNV zeitkarte
bysort PHHID (JAHR): gen zeitkLastY = zeitkarte[_n-1] if PHHID==PHHID[_n-1]
label var zeitkLastY "Zeitkarte in Vorjahr"
rename FSPKW fhs
replace fhs =0 if alter<17
quietly compress
save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_P0.dta", replace



use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_W.dta", clear
MOP_recodeW
quietly compress
recast long ID PHHID
save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_W0.dta", replace

use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_W0.dta", clear
MOP_impute_altTravelTimes
save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg.dta", replace

