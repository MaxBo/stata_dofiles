clear
set memory 700m
local path "D:\DatenMaxDiss\MiD-Hessen\MiD_2008\STATA\"

use "`path'MiD_Wege_Hessen_cod_bereinig_def.dta", clear

* gen multimodal = 0
gen OEV =  W05_12 | W05_13 | W05_11 |  W05_15 | W05_16 | W05_17 | W05_18
* label var W05_6 "ÖV"

gen MIV =  (W05_4 | W05_5 | W05_7 |  W05_14)
* Es werden Fußwege ausgeschlossen?
* forvalues i=2/7 {
* replace multimodal = multimodal + W05_`i' if W05_`i'<2
* }

gen  multimodal = MIV + OEV +   W05_2 + W05_3  if W05_3<2 |  W05_2<2 


gen VM_Kombi = 1 if multimodal < 2
replace VM_Kombi = 3 if multimodal >1 &  OEV & MIV
bysort HHID PID: replace VM_Kombi = 4 if VM_Kombi == 3 &  ANZPERS > 1 & ANZPERS[_n+1]<ANZPERS[_n]
replace VM_Kombi = 2 if multimodal >1 &  W05_2 == 1
replace VM_Kombi = 5 if missing(VM_Kombi)

label var VM_Kombi "VM_Kombi für Sonderauswertung"

label define VM_Kombi 1 `"Monomodal"' 2 `"Bike&Ride"' 3 `"Park&Ride"' 4 `"Kiss&Ride"' 5 `"sonstige Multimodale"', modify
label value VM_Kombi VM_Kombi


* Für Untersuchungen
* br MIV  W05_6 W05_14 W05_15 W05_16 W05_17 W05_18 W05_20 if multimodal>1 & MIV & VM_Kombi>2
* br MIV  W05_6 W05_14 W05_15 W05_16 W05_17 W05_18 W05_20 if  VM_Kombi==5


* Erzeugung der Kreuztabellen
* hier fehlt noch eine Routine zum Auslesen der Kreuztabellen nach Excel :(
* Es wäre auch schön einen Kommentar zu haben, was genau gerade herausgeschrieben wird.

foreach x in "Distanzklasse" "HWZWECK2"{
* Alle Wege
	tab `x' VM_Kombi if filter, row chi2 lrchi2
	tab `x' VM_Kombi [iw=W_GPV] if filter, row
* Arbeitsbezogene Wege
	tab `x' VM_Kombi if arbeit & filter, row chi2 lrchi2
	tab `x' VM_Kombi [iw=W_GPV] if arbeit & filter, row
}

forvalue i=1/2 {
* Alle Wege
	tab GK`i' VM_Kombi if filter, row chi2 lrchi2
	tab GK`i' VM_Kombi [iw=W_GPV] if filter, row
* Arbeitsbezogene Wege
	tab GK`i' VM_Kombi if arbeit & filter, row chi2 lrchi2
	tab GK`i' VM_Kombi [iw=W_GPV] if arbeit & filter, row
}




