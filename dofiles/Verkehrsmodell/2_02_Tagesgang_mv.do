clear
set more off
* set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
local path_ber "X:\Daten\Modell_MRH\Nachfragedaten\Berechnungsergebnisse\Verkehrsnachfrage\"
local path_postgis "X:\Daten\Modell_MRH\Nachfragedaten\Export_PostGIS\"


use  "`path'MiD_Wege_cod_bereinig_def_wegeketten.dta", clear


drop if missing(hz)
sort hhid pid wsid
qui tab hz, gen(Zweck_)

rename Zweck_1 arbeit
rename Zweck_2 bilden
rename Zweck_3 dienstl
rename Zweck_4 erl
rename Zweck_5 freizeit
rename Zweck_6 sport 
rename Zweck_7 einkb
rename Zweck_8 einkap
rename Zweck_9 einkp
rename Zweck_10 rundw
rename Zweck_11 begleitg 
rename Zweck_12 fremdW
rename Zweck_13 sonst
rename Zweck_14 wohnen

gen st_stunde = int((st_time - st_time*st_dat)/3600)


foreach x in  "arbeit" "dienstl" "bilden" "erl"  "freizeit" "begleitg" "fremdW" "sonst" "rundw" "einkp" "einkap" "einkb" "sport"  {
	ologit st_stunde i.verh_perg ib2.rtyp i.hp_sex ib3.hheink_5 [iw=w_gew] if `x'==1 & stichtag<6 & komplex==0 & WW_anf==1, nolog
	estimates save "`path_ber'tg_`x'_h.ster", replace
	outreg2 using "`path_postgis'export_postgis_`x'_h.txt", bdec(5) tdec(5) noparen noaster replace
	ologit st_stunde i.verh_perg ib2.rtyp i.hp_sex ib3.hheink_5 [iw=w_gew] if `x'==1 & wsid > 1 & stichtag<6 & komplex==0 & WW_end==1, nolog
	estimates save "`path_ber'tg_`x'_r.ster", replace
	outreg2 using "`path_postgis'export_postgis_`x'_r.txt", bdec(5) tdec(5) noparen noaster replace
	}

save "`path'MiD_Wege_cod_bereinig_def_wegeketten_opus_tg.dta", replace

keep in 1
keep rtyp hp_sex verh_perg hheink_5
set obs 360

forvalues i=1/2 {
replace hp_sex = `i' if mod(_n,2)== `i'-1
}
sort hp_sex

forvalues i = 1/3 {
	replace rtyp = `i' if mod(_n,3) == `i'-1
}
sort hp_sex rtyp

forvalues i = 1/12 {
replace verh_perg = `i' if mod(_n,12)==`i'-1
}
sort verh_perg hp_sex rtyp

forvalues i=1/5 {
	replace hheink_5 = `i' if mod(_n,5)==`i'-1
}

sort verh_perg hheink_5 hp_sex rtyp
xi i.verh_perg i.rtyp i.hp_sex i.hheink_5

local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
local path_ber "X:\Daten\Modell_MRH\Nachfragedaten\Berechnungsergebnisse\Verkehrsnachfrage\"
local path_postgis "X:\Daten\Modell_MRH\Nachfragedaten\Export_PostGIS\"

capture drop tg_*
foreach x in "arbeit" "dienstl" "bilden" "erl"  "freizeit" "begleitg" "fremdW" "sonst" "rundw" "einkp" "einkap" "einkb" "sport"  {
	
	estimates use "`path_ber'tg_`x'_h.ster"
	predict tg_`x'_hh_*
	foreach v of varlist tg_`x'_hh_* {
       local stunde : variable label `v'
       local stunde = regexr(regexr("`stunde'", "^Pr\(st_stunde==", ""), "\)$","")
	   local newvarname = regexr("`v'", "h_[0-9]+$", "")
	   local newvarname = "`newvarname'_`stunde'"
       rename `v' `newvarname'
    }
	outsheet verh_perg hheink_5 hp_sex rtyp tg_`x'_h* using "`path_postgis'Tagesgang_`x'_h.csv",  noquote nolabel replace

	estimates use "`path_ber'tg_`x'_r.ster"
	predict tg_`x'_rr_*
	foreach v of varlist tg_`x'_rr_* {
       local stunde : variable label `v'
       local stunde = regexr(regexr("`stunde'", "^Pr\(st_stunde==", ""), "\)$","")
	   local newvarname = regexr("`v'", "r_[0-9]+$", "")
	   local newvarname = "`newvarname'_`stunde'"
       rename `v' `newvarname'
    }
	outsheet verh_perg hheink_5 hp_sex rtyp tg_`x'_r* using "`path_postgis'Tagesgang_`x'_r.csv",  noquote nolabel replace
	
}


