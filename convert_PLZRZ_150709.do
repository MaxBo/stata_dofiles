
local Typen "MZ OZ Metropolen"
foreach Typ of local Typen {
	di "`Typ'"
	insheet using "H:\SOEP\Reisezeiten\AlleZeiten`Typ'.txt", tab clear
	save "H:\SOEP\Reisezeiten\RZ_Orte_`Typ'.dta",replace
	drop zentrumivoid zentrumivname zentrumovoid zentrumovname
	save "H:\SOEP\Reisezeiten\RZ_`Typ'.dta",replace
}

use "H:\SOEP\Reisezeiten\RZ_MZ.dta",clear

rename mindiffivov MZmindiffivov
rename meteriv MZmeteriv 
rename  minuteniv MZminuteniv  
rename  meterov MZmeterov 
rename  widerstandov MZwiderstandov 
rename  zeitraum MZzeitraum 
rename  mittlrz MZmittlrz 
rename  mittltakt MZmittltakt 
rename  mittlswz MZmittlswz 

sort plz
merge plz using "H:\SOEP\Reisezeiten\RZ_OZ.dta", sort
rename mindiffivov OZmindiffivov
rename meteriv OZmeteriv 
rename  minuteniv OZminuteniv  
rename  meterov OZmeterov 
rename  widerstandov OZwiderstandov 
rename  zeitraum OZzeitraum 
rename  mittlrz OZmittlrz 
rename  mittltakt OZmittltakt 
rename  mittlswz OZmittlswz 

dropvars _merge
sort plz
merge plz using "H:\SOEP\Reisezeiten\RZ_Metropolen.dta", sort
rename mindiffivov METmindiffivov
rename meteriv METmeteriv 
rename  minuteniv METminuteniv  
rename  meterov METmeterov 
rename  widerstandov METwiderstandov 
rename  zeitraum METzeitraum 
rename  mittlrz METmittlrz 
rename  mittltakt METmittltakt 
rename  mittlswz METmittlswz 

dropvars _merge

save "H:\SOEP\Reisezeiten\RZ_Zentren.dta",replace


use "I:\MA\jgoebel\mbohnet\plz_93_07_fakeid.dta",clear
sort plz fakeid
merge plz using "I:\MA\jgoebel\mbohnet\RZ_Zentren.dta", sort uniqusing 
dropvars _merge
sort fakeid erhebj
save "I:\MA\jgoebel\mbohnet\plz_93_07_fakeid_RZ_Zentren.dta",replace
