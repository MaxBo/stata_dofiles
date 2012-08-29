clear
set more off
* set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
local path_ber "X:\Daten\Modell_MRH\Nachfragedaten\Berechnungsergebnisse\Verkehrsnachfrage\"
local path_valide "X:\Daten\Modell_MRH\Nachfragedaten\Validierung\"
local path_hh "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\"
local path_postgis "X:\Daten\Modell_MRH\Nachfragedaten\Export_PostGIS\"

use  "`path'MiD_Wege_cod_bereinig_def_wegeketten.dta", clear
drop if missing(hz)
drop if missing(verh_perg)
drop if hz==14

gen km_ru = round(wegkm_k,1)

collapse (mean) mw_km=km_ru (median) med_km=km_ru (sem) sd_km=km_ru (count) fallzahl=km_ru if komplex==0 & filter==1 & km_ru<=100, by(verh_perg hz rtyp hp_sex)
sort hz verh_perg rtyp hp_sex

outsheet hz verh_perg hp_sex rtyp mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDD_einfach_100_export_postgis.csv",  noquote nolabel replace
outsheet hz verh_perg hp_sex rtyp mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDD_einfach_100_export_postgis_ansicht.csv",  noquote replace

use  "`path'MiD_Wege_cod_bereinig_def_wegeketten.dta", clear
drop if missing(hz)
drop if missing(verh_perg)
drop if hz==14

gen km_ru = round(wegkm_k,1)

collapse (mean) mw_km=km_ru (median) med_km=km_ru (sem) sd_km=km_ru (count) fallzahl=km_ru  if komplex==0 & filter==1, by(verh_perg hz rtyp hp_sex)
sort hz verh_perg rtyp hp_sex

outsheet hz verh_perg hp_sex rtyp mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDD_einfach_export_postgis.csv",  noquote nolabel replace
outsheet hz verh_perg hp_sex rtyp mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDD_einfach_export_postgis_ansicht.csv",  noquote replace


use "`path_hh'MiD_2008_2006_Wege_11_ausw.dta", clear
 
drop if missing(hz)
drop if missing(verh_perg)
drop if hz==14

gen km_ru = round(wegkm_k,1)

collapse (mean) mw_km=km_ru (median) med_km=km_ru (sem) sd_km=km_ru (count) fallzahl=km_ru  if komplex==0 & filter==1, by(verh_perg hz auswertungsklassen_raum hp_sex)
sort hz verh_perg auswertungsklassen_raum hp_sex

outsheet hz verh_perg hp_sex auswertungsklassen_raum mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_export_postgis.csv",  noquote nolabel replace
outsheet hz verh_perg hp_sex auswertungsklassen_raum mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_export_postgis_ansicht.csv",  noquote replace

use "`path_hh'MiD_2008_2006_Wege_11_ausw.dta", clear
 
drop if missing(hz)
drop if missing(verh_perg)
drop if hz==14

gen km_ru = round(wegkm_k,1)

collapse (mean) mw_km=km_ru (median) med_km=km_ru (sem) sd_km=km_ru (count) fallzahl=km_ru  if komplex==0 & filter==1 & km_ru<=100, by(hz verh_perg auswertungsklassen_raum hp_sex)
sort hz verh_perg auswertungsklassen_raum hp_sex

outsheet hz verh_perg hp_sex auswertungsklassen_raum mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_100_export_postgis.csv",  noquote nolabel replace
outsheet hz verh_perg hp_sex auswertungsklassen_raum mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_100_export_postgis_ansicht.csv",  noquote replace

* Auswertung der mittleren Reiseweiten nach jeweils einem Kriterium
local path_valide "X:\Daten\Modell_MRH\Nachfragedaten\Validierung\"
local path_hh "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\"
foreach x in "hz" "verh_perg" "hp_sex" "auswertungsklassen_raum" "hheink_5"{ 

	use "`path_hh'MiD_2008_2006_Wege_11_ausw.dta", clear
	 
	drop if missing(hz)
	drop if missing(verh_perg)
	drop if hz==14

	gen km_ru = round(wegkm_k,1)

	collapse (mean) mw_km=km_ru (median) med_km=km_ru (sem) sd_km=km_ru (count) fallzahl=km_ru  if komplex==0 & filter==1 & km_ru<=100, by(`x')

	outsheet `x' mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_`x'_100_export_postgis.csv",  noquote nolabel replace
	outsheet `x' mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_`x'_100_export_postgis_ansicht.csv",  noquote replace
	* odbc insert `x' mw_km med_km sd_km fallzahl, table("`x'_mittlereWegelaenge_MiDHH_einfach_100") dsn("`path_valide'Verkehrsmodell_Kennzahlen.accdb")
	
	
	use "`path_hh'MiD_2008_2006_Wege_11_ausw.dta", clear
	 
	drop if missing(hz)
	drop if missing(verh_perg)
	drop if hz==14

	gen km_ru = round(wegkm_k,1)

	collapse (mean) mw_km=km_ru (median) med_km=km_ru (sem) sd_km=km_ru (count) fallzahl=km_ru  if komplex==0 & filter==1, by(`x')

	outsheet `x' mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_`x'_export_postgis.csv",  noquote nolabel replace
	outsheet `x' mw_km med_km sd_km fallzahl using "`path_valide'mittlereWegelaenge_MiDHH_einfach_`x'_export_postgis_ansicht.csv",  noquote replace
	
}

use "`path_hh'MiD_2008_2006_Wege_11_ausw.dta", clear

tab hz VM_6 [iw=w_gew] if stichtag<6  & hz<13 & filter==1 & komplex==0
tab hz VM_6 [iw=w_gew] if stichtag<6  & hz<13 & filter==1 & komplex==0, nofr row

use "`path'MiD_Personen_cod_bereinig_def_wege.dta", clear

tab verh_perg mobil [iw=p_gew] if stichtag<6
tab verh_perg mobil [iw=p_gew] if stichtag<6, nofr row

logit mobil i.verh_perg i.rtyp i.hp_sex  [iw=p_gew] if stichtag<6, nolog
outreg2 using "`path_valide'logit_mobilität.xls",  sideway nopar nolabel ctitle("Mobilität am Werktag") e(r2_p) replace



