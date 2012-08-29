clear
set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
local path_ber "X:\Daten\Modell_MRH\Nachfragedaten\Berechnungsergebnisse\Verkehrsnachfrage\"
local path_postgis "X:\Daten\Modell_MRH\Nachfragedaten\Export_PostGIS\"

set more off


use  "`path'MiD_Wege_cod_bereinig_def_wegeketten.dta", clear


* collapse nach WWID
* Wege je Person und WWID

drop if missing(hz)
sort hhid pid wsid

* replace Zweck_1 = 1 if Zweck_1==0 & w01 == 2 & wsid==1
duplicates drop hhid pid WWID hz, force

qui tab hz, gen(Zweck_)
* Anzahl Wege je Hauptwegezweck
collapse (sum) Zweck_*, by (hhid pid)

* drop arbeit
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


* foreach x in "arbeit" "dienstl" "bilden" "erl"  "freizeit" "begleitg" "fremdW" "sonst" "rundw" "einkp" "einkap" "einkb" "sport"  {
	* bysort hhid pid: egen anz_`x' = sum(`x')
* }

save "`path'MiD_Wege_cod_bereinig_def_hauptwegezweck.dta", replace

use "`path'MiD_Personen_cod_def.dta", clear

drop _merge

* version 10
merge 1:1 hhid pid using "`path'MiD_Wege_cod_bereinig_def_hauptwegezweck.dta"
* version 12

gen alter2 = hp_alter*hp_alter
* xi: nbreg anz_arb hp_sex hp_alter alter2 hp_beruf i.hp_bkat i.rtyp, dispersion(mean)

* Aufbereitung als Dummyvariablen, damit sie in neu erstellter Datei verwendet werden können.

recode hp_sex (9=.a) (8=.c)
* drop if stichtag<6

foreach x in "arbeit" "dienstl" "bilden" "erl"  "freizeit" "begleitg" "fremdW" "sonst" "rundw" "einkp" "einkap" "einkb" "sport"  {
 replace `x' = 0 if missing(`x')
 }


 
set more off
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
local path_ber "X:\Daten\Modell_MRH\Nachfragedaten\Berechnungsergebnisse\Verkehrsnachfrage\"
local path_postgis "X:\Daten\Modell_MRH\Nachfragedaten\Export_PostGIS\"

foreach x in "arbeit" "dienstl" "bilden" "erl"  "freizeit" "begleitg" "fremdW" "sonst" "rundw" "einkp" "einkap" "einkb" "sport"  {
	
	* nbreg `x' i.hp_sex i.rtyp ib3.hheink_5 ib7.verh_perg [iw=p_gew] if stichtag<6 , nolog dispersion(mean)
	 poisson `x' i.hp_sex i.rtyp ib3.hheink_5 ib7.verh_perg [iw=p_gew] if mobil==1, nolog 
	* Variante mit outreg2
	outreg2 using "`path_postgis'export_postgis_`x'.txt", replace sideway noast tstat nopar 
	outreg2 using "`path_postgis'export_postgis_`x'2.txt", bdec(5) tdec(5) noparen noaster replace
	* Variante mit direkter Schätzung
	estimates save "`path_ber'anz_`x'.ster", replace
}



outreg2 using "`path_postgis'export_postgis.txt", replace noast tstat sideway
save "`path'MiD_Personen_cod_bereinig_def_wege.dta", replace

keep in 1 
keep rtyp verh_perg hp_sex hheink_5
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

foreach x in "arbeit" "dienstl" "bilden" "erl"  "freizeit" "begleitg" "fremdW" "sonst" "rundw" "einkp" "einkap" "einkb" "sport"  {
	estimates use "`path_ber'anz_`x'.ster"
	predict `x'
}

* Als nächstes kommt der Export zu PostGIS.
* Hier steht erst einmal eine einfache Variante mit Speichern als csv-Datei:

* outsheet verh_perg hp_sex rtyp arbeit dienstl bilden erl  freizeit begleitg fremdW sonst rundw einkp einkap einkb sport  using "`path'Erzeugungsraten_export_postgis.csv", nolabel noquote replace
outsheet verh_perg hp_sex rtyp arbeit dienstl bilden erl  freizeit begleitg fremdW sonst rundw einkp einkap einkb sport  using "`path_postgis'Erzeugungsraten_export_postgis.csv",  noquote nolabel replace
