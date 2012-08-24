********************** Ergänze Angaben zu Umzügen/Wohnungen            ********************
********************** und übertrage Angaben zum Wohnstandort auf alle Jahre, *************
********************** in der ein Haushalt in einer Wohnung wohnt           ***************

capture log close
log using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_160709.log", replace

use "H:\SOEP\Reisezeiten\93_07_RZ_Zentren.dta",clear
capture conf var erhebj
if !_rc { 
	rename erhebj year 
}
sort hhnrakt year
save "H:\SOEP\Reisezeiten\93_07_RZ_Zentren.dta",replace

use "H:\SOEP\Reisezeiten\93_07_LogSum_Zentren.dta",clear
capture conf var erhebj
if !_rc { 
	rename erhebj year 
}
sort hhnrakt year
save "H:\SOEP\Reisezeiten\93_07_LogSum_Zentren.dta",replace


use "H:\SOEP\Reisezeiten\93_07_dist_ozmz.dta",clear
capture conf var erhebj
if !_rc { 
	rename erhebj year 
}
sort hhnrakt year
save "H:\SOEP\Reisezeiten\93_07_dist_ozmz.dta",replace


use "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom.dta", clear
*** merge weitere Kontext-Variablen hinzu** 
sort hhnrakt year
dropvars _merge

local addvars MZ* OZ* MET*
merge hhnrakt year using "H:\SOEP\Reisezeiten\93_07_RZ_Zentren.dta", uniqusing nokeep keep(MZ* OZ* MET*) sort
dropvars _merge

merge hhnrakt year using "H:\SOEP\Reisezeiten\93_07_LogSum_Zentren.dta", uniqusing nokeep keep(*LogSum*) sort
dropvars _merge

stset year, id(hhnrakt) failure(year=.)
stfill  hhmovedyr,forward
********** erstelle Wohnungs-Nummer *******************
dropvars whgnr hhwhgnr
stgen whgnr = count0(umzug==.d |  umzug==1 |  hhmovedyr[_n]!=hhmovedyr[_n-1])
gen hhwhgnr = hhnrakt*100+whgnr

******** Ergänze Angaben zur Infrastruktur, zur Entfernung, zum Wohnumfeld nach unten ...*******
stset year, id(hhwhgnr) failure(year=.)
stfill  entfgrstadt inf_shops inf_restaur inf_bank  inf_doctor inf_kinderg inf_primschool inf_gymnasium /*
*/ inf_youthcentre inf_elderlycentre inf_sport inf_transit pollu_noise pollu_air nogreen crime /*
*/ wohng_verhaelt wohng_ausl wohng_landsleute `addvars',forward

**** ... und nach oben , indem die Zeitvariable _t umgedreht wird *********
replace _t = 100-_t
stfill  entfgrstadt inf_shops inf_restaur inf_bank  inf_doctor inf_kinderg inf_primschool inf_gymnasium /*
*/ inf_youthcentre inf_elderlycentre inf_sport inf_transit pollu_noise pollu_air nogreen crime /*
*/ wohng_verhaelt wohng_ausl wohng_landsleute `addvars',forward
replace _t = 100-_t
sort hhnrakt year

save "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", replace

*************************************************************************************************
