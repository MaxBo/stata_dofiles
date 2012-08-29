clear
set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
set more off

use  "`path'MiD_Wege_cod_bereinig_def_wegeketten_opus.dta", clear



* Widerstandsfunktionen
bysort VM_6: egen anz_km = count(wegkm_k) if filter & arbeit==1 & wegkm_k<=500
bysort VM_6 wegkm_k: egen anz_km_t = count(wegkm_k) if filter & arbeit==1 & wegkm_k<=500
drop if arbeit!=1
sort VM_6 wegkm_k

duplicates drop  VM_6 wegkm_k, force

gen abs = anz_km  if filter
sort VM_6 wegkm_k
bysort VM_6: replace abs = abs[_n-1] - anz_km_t[_n-1] if _n>1 & filter 
gen rel = abs/anz_km

* br VM_6 arbeit wegkm_k anz_km* abs if arbeit
* twoway (kdensity abs if abs>=0 & VM_6==1) (kdensity abs if abs>=0 & VM_6==3) (kdensity abs if abs>=0 & VM_6==4)
* vielleicht mit anderer Funktion oder doch gleich in anderen Programm?