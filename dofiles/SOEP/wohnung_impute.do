********************** Erg�nze Angaben zu Umz�gen/Wohnungen            ********************
********************** und �bertrage Angaben zum Wohnstandort auf alle Jahre, *************
********************** in der ein Haushalt in einer Wohnung wohnt           ***************

capture log close
log using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_150709.log", replace

use "H:\SOEP\Reisezeiten\93_07_RZ_Zentren.dta",clear
capture conf var erhebj
if !_rc { 
	rename erhebj year 
}
sort hhnrakt year
save "H:\SOEP\Reisezeiten\93_07_RZ_Zentren.dta",replace

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

local addvars MZ* OZ* MET*  dist_?z 
merge hhnrakt year using "H:\SOEP\Reisezeiten\93_07_RZ_Zentren.dta", uniqusing nokeep keep(MZ* OZ* MET*) sort
dropvars _merge

merge hhnrakt year using "H:\SOEP\Reisezeiten\93_07_dist_ozmz.dta", uniqusing nokeep keep(dist_?z) sort
dropvars _merge

** korrigiere zu hohe Reisezeiten ohne Auto im Nahbereich
replace MZwiderstandov=10 if dist_mz == 0  
replace MZwiderstandov=15 if dist_mz == 1 & MZwiderstandov>15 

replace OZwiderstandov=10 if dist_oz == 0  
replace OZwiderstandov=15 if dist_oz == 1 & OZwiderstandov>15  
replace OZwiderstandov=25 if dist_oz == 2 & OZwiderstandov>25 

replace METwiderstandov = OZwiderstandov if OZmeterov==METmeterov & OZmeterov<.
replace  MZmindiffivov = MZwiderstandov- MZminuteniv 
replace  OZmindiffivov = OZwiderstandov- OZminuteniv 
replace  METmindiffivov = METwiderstandov- OZminuteniv 

stset year, id(hhnrakt) failure(year=.)
stfill  hhmovedyr,forward
********** erstelle Wohnungs-Nummer *******************
dropvars whgnr hhwhgnr
stgen whgnr = count0(umzug==.d |  umzug==1 |  hhmovedyr[_n]!=hhmovedyr[_n-1])
gen hhwhgnr = hhnrakt*100+whgnr

******** Erg�nze Angaben zur Infrastruktur, zur Entfernung, zum Wohnumfeld nach unten ...*******
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
