clear
set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
set more off

use  "`path'MiD_Wege_cod_bereinig_def_wegeketten_opus.dta", clear

gen st_stunde = int((st_time - st_time*st_dat)/3600)

foreach x in "arbeit" "dienstlich" "bilden" "erl"  "freizeit" "begleitg" "fremde_W" "sonst" "rundweg" "eink_p" "eink_ap" "eink_b" "sport"  {
	qui bysort verh_perg st_stunde: egen tg_teil_`x' = sum(`x')
	qui bysort verh_perg: egen tg_sum_`x' = sum(`x')
	qui gen tgt_`x' = tg_teil_`x'/tg_sum_`x'
	drop tg_sum_`x' tg_teil_`x'
	qui bysort verh_perg: egen tg_anz_`x' = count(`x') if `x'>0
	qui bysort hp_sex verh_perg: egen tg_anz_s_`x' = count(`x') if `x'>0
	qui bysort hp_sex rtyp verh_perg: egen tg_anz_s_r_`x' = count(`x') if `x'>0
}

* duplicates drop rtyp hp_sex verh_perg st_std tg_*, force

* drop if missing(tg_*)

drop if missing(hhid)

save "`path'MiD_Wege_cod_bereinig_def_wegeketten_opus_tg.dta", replace


keep in 1

keep rtyp hp_sex verh_perg st_stunde

sort verh_perg hp_sex rtyp

set obs 1728

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

sort verh_perg

bysort verh_perg hp_sex rtyp: replace st_stunde = _n
* bysort verh_perg: replace st_stunde = _n
recode st_stunde (24=0)

version 10
merge rtyp hp_sex verh_perg st_stunde using "`path'MiD_Wege_cod_bereinig_def_wegeketten_opus_tg.dta", keep(tgt_* tg_*) sort uniqmaster
version 12
drop if _n>1728


* Als nächstes kommt der Export zu PostGIS.
* Hier steht erst einmal eine einfache Variante mit Speichern als csv-Datei:

* outsheet verh_perg hp_sex rtyp arbeit dienstlich bilden erl  freizeit begleitg fremde_W sonst rundweg eink_p eink_ap eink_b sport  using "`path'Erzeugungsraten_export_postgis.csv", nolabel noquote replace
outsheet verh_perg hp_sex rtyp st_stunde tg_* using "`path'Tagesgang_export_postgis.csv",  noquote nolabel replace
