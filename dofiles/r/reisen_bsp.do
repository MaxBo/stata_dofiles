set more off

local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\"

import excel "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\Verteilung.xlsx", sheet("ant_normaler_tag") firstrow clear
save "`path'normaler_tag_wkt.dta", replace

import excel "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\Verteilung.xlsx", sheet("verfügb") firstrow clear
save "`path'verfügb_tag.dta", replace

import excel "S:\Modell\Konzepte\Fernverkehrsmodell\Bsp_Simulation.xlsx", sheet("Alternative_VM") firstrow clear
expand 24
bysort ID: gen id = _n
save "`path'Reisealternativen.dta", replace


import excel "S:\Modell\Konzepte\Fernverkehrsmodell\Bsp_Simulation.xlsx", sheet("Person") firstrow clear
rename plfex pflex
rename hhtyp hhtyp_3
rename ID id

merge n:m hhtyp_3 using "`path'normaler_tag_wkt.dta"
drop _merge

merge n:m besch using "`path'verfügb_tag.dta"
drop _merge

xi i.sex i.hheink i.bildung_2 i.besch i.pkwfuehrer i.pkwbes i.pkw_verf i.bahncard_jn i.hhtyp_3 i.rtyp i.wohnlage_4 i.zweitw i.hh_bt i.hhflex i.pflex


foreach i in "dir" "kurl" "url" "tar" {
	estimates use "`path'anz_`i'.ster"
	predict pr_`i'
	gen anz`i'=rpoisson(pr_`i')
	gen er_`i' = verf_`i'/anz`i'*norm_tag_`i'
}

rename er_dir er_1
rename er_kurl er_2
rename er_url er_3
rename er_tar er_4

* quietly tab rwzeck_3 ,matrow(vars)
gen float cum=0
gen rzweck_3=.
* egen float r=rowmax(er_*)
gen float random=runiform()
forvalues  i = 1/4 {
	replace cum = cum + er_`i' if er_`i' <.
	replace rzweck_3=`i' if (cum>=random & rzweck_3 ==.)
}
replace rzweck_3=0 if missing(rzweck_3)
save "`path'reisende_normaler_tag.dta", replace
keep if rzweck_3>0
merge 1:m id using "`path'Reisealternativen.dta" 
sort id ID
drop _merge
drop if missing(alter)






