
*******************************

local Typen "MZ OZ Metropolen"
foreach Typ of local Typen {
	di "`Typ'"
	insheet using "H:\SOEP\Reisezeiten\AlleZeiten`Typ'.txt", tab clear
	local Typ1 "`Typ'"
	if "`Typ'" == "Metropolen" {
		local Typ1 "MET"
	}
	rename mindiffivov `Typ1'mindiffivov
	rename meteriv `Typ1'meteriv 
	rename  minuteniv `Typ1'minuteniv  
	rename  meterov `Typ1'meterov 
	rename  widerstandov `Typ1'widerstandov 
	rename  zeitraum `Typ1'zeitraum 
	rename  mittlrz `Typ1'mittlrz 
	rename  mittltakt `Typ1'mittltakt 
	rename  mittlswz `Typ1'mittlswz 
	rename  zentrumivoid `Typ1'IVOID 
	rename  zentrumivname `Typ1'IVName
	rename  zentrumovoid `Typ1'OVOID 
	rename  zentrumovname `Typ1'OVName 
	sort plz
	save "H:\SOEP\Reisezeiten\RZ_Orte_`Typ'.dta",replace
//	drop zentrumivoid zentrumivname zentrumovoid zentrumovname
	save "H:\SOEP\Reisezeiten\RZ_`Typ'.dta",replace
}

use "H:\SOEP\Reisezeiten\RZ_MZ.dta",clear
merge plz using "H:\SOEP\Reisezeiten\RZ_OZ.dta", sort
dropvars _merge
merge plz using "H:\SOEP\Reisezeiten\RZ_Metropolen.dta", sort
dropvars _merge
save "H:\SOEP\Reisezeiten\RZ_Zentren.dta",replace

*** Berechne Luftliniendistanz zum nächsten Zentrum

insheet using "H:\SOEP\Reisezeiten\PLZ_Zentrum_Luftlinie.csv", tab clear
bysort plz (distance): drop if _n>1
rename distance MZluftlinie
tempfile mzfile
keep(plz MZluftlinie)
save `mzfile',replace

insheet using "H:\SOEP\Reisezeiten\PLZ_Zentrum_Luftlinie.csv", tab clear
drop if oz==0
bysort plz (distance): drop if _n>1
rename distance OZluftlinie
tempfile ozfile
keep(plz OZluftlinie)
save `ozfile',replace 

insheet using "H:\SOEP\Reisezeiten\PLZ_Zentrum_Luftlinie.csv", tab clear
drop if metropole==0
bysort plz (distance): drop if _n>1
rename distance METluftlinie
tempfile metfile
keep(plz METluftlinie)
save `metfile',replace

use `mzfile',clear
sort plz
merge plz using `ozfile', sort
drop _merge
sort plz
merge plz using `metfile', sort
drop _merge
order plz
save "H:\SOEP\Reisezeiten\PLZ_Zentrum_Luftlinie",replace

use "H:\SOEP\Reisezeiten\RZ_Zentren.dta",clear
merge plz using "H:\SOEP\Reisezeiten\PLZ_Zentrum_Luftlinie",sort
drop _merge
local betarad = -.06 // -.10
local betafuss = -.06 // -.11
local betaov = -.06 // -.04
local betapkw = -.06
local constrad = -.5
local constfuss = 1.55
local constov = 0
local constpkw = 0

local Typen "MZ OZ Metropolen"
local VM "fuss rad ov"
foreach Typ of local Typen {
	di "`Typ'"
	local Typ1 "`Typ'"
	if "`Typ'" == "Metropolen" {
		local Typ1 "MET"
	}
	dropvars eUpkw eUrad eUfuss eUov
	gen eUpkw = exp(`constpkw' + `betapkw'* `Typ1'minuteniv)
	gen `Typ1'tfuss = (`Typ1'luftlinie/1000)*(60/4)
	gen `Typ1'trad = (`Typ1'luftlinie/1000)*(60/14)
	gen `Typ1'tov = `Typ1'widerstandov
	gen eUfuss = 0
	gen eUrad = 0
	gen eUov = 0
	replace eUfuss = exp(`constfuss' + `betafuss' * `Typ1'tfuss) if `Typ1'tfuss <.
	replace eUrad = exp(`constrad' + `betarad' * `Typ1'trad) if `Typ1'trad <.
	replace eUov = exp(`constov' + `betaov' * `Typ1'tov) if `Typ1'tov <.
*** Erreichbarkeitsvorteil durch Pkw gegenüber reiner Fuss/Rad/ÖV-Nutzung ***
	gen `Typ1'LogSumPkw = ln(1+(eUpkw / (eUfuss+eUrad+eUov)))
*** gehe davon aus, dass im Radius von 3 km um Oberzentren und 5 km um Metropolen dicht besiedelte, gemischte Quartiere sind, 
*** die eine Angebotsqualität wie ein Mittelzentrum haben ***
	if "`Typ1'"=="MZ" {
		replace `Typ1'LogSumPkw = .05 * METluftlinie/1000 if METluftlinie < 5000
		replace `Typ1'LogSumPkw = .05 * OZluftlinie/1000 if OZluftlinie < 3000

	}
*** Erreichbarkeitsvorteil durch ÖPNV gegenüber reiner Fuss/Rad/Pkw-Nutzung ***
	gen `Typ1'LogSumOV = ln(1+(eUov / (eUfuss+eUrad+eUpkw)))
}

//list plz  OZIVName OZmeteriv OZminuteniv OZOVName OZwiderstandov OZLogSum if OZmeteriv > 60000 & OZLogSum<.5
keep plz *LogSum*
save "H:\SOEP\Reisezeiten\LogSum_Zentren.dta",replace
outsheet using "H:\SOEP\Reisezeiten\LogSum_Zentren.txt", replace



use "I:\MA\jgoebel\mbohnet\plz_93_07_fakeid.dta",clear
sort plz fakeid
merge plz using "I:\MA\jgoebel\mbohnet\LogSum_Zentren.dta", sort uniqusing 
dropvars _merge
sort fakeid erhebj
save "I:\MA\jgoebel\mbohnet\plz_93_07_fakeid_LogSum_Zentren.dta",replace


use "I:\MA\jgoebel\mbohnet\plz_93_07_fakeid.dta",clear
sort plz fakeid
merge plz using "I:\MA\jgoebel\mbohnet\RZ_Zentren.dta", sort uniqusing 
dropvars _merge
sort fakeid erhebj
save "I:\MA\jgoebel\mbohnet\plz_93_07_fakeid_RZ_Zentren.dta",replace
