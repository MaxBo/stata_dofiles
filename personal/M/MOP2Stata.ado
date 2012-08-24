* Converting MOP-Panel-Files into long-format
* by Max Bohnet, 4.12.2007

program MOP2Stata
	set more off
	local path "Y:\MOP\Mobilitätsdaten\"
	di "Datenpfad: `path'"
// Definiere erstes und letztes Jahr
	local firstyear = 1994
	local lastyear = 2007
// Konvertiere SPSS-Daten mit den km mit Nachkommastelle in Stata-File
	forvalues y = `firstyear'/`lastyear' {
		local yy = mod(`y',100)
		if `yy' < 10 {
			local Null = "0"
			}
		else{
			local Null = ""
			}
		usespss using "`path'Panel `y'\\SPSS\\W`Null'`yy'.sav",clear
		keep ID PERSNR JAHR BERTAG WNRT KM ABZEIT
		sort ID PERSNR JAHR BERTAG WNRT ABZEIT
// markiere Wege mit doppelter Wegenummer und markiere anschließend alle Wege des Tages und zähle sie sortiert nach der Abfahrtszeit neu durch
		duplicates tag ID PERSNR JAHR  BERTAG  WNRT,gen(_dubl_weg)
		by ID PERSNR JAHR BERTAG: egen _dubl_tag = max(_dubl_weg)
		by ID PERSNR JAHR BERTAG: egen _rank = rank(ABZEIT) if _dubl_tag >0,unique
// ersetze Wegenummern bei geänderten Tagen und speichere Datensatz mit Kilometern
		replace WNRT = _rank if _rank<.
		drop _rank ABZEIT
		quietly save "`path'Panel `y'\Stata\MOP_W_km.dta",replace
	}
// Schleife über alle Ebenen
	foreach Typ in "HH" "P" "PT" "W" "KIND" "POT" {
// Dateinamen zum lesen und schreiben definieren
		local dictfname "Dict`Typ'.dct"
		local adofname "MOP_StataLabel`Typ'"
		local savefname "`path'\\Long\\MOP_`Typ'"
		di "`dictfname'"
// Personen ohne Tagebuch erst ab 1996 erfasst
		if "`Typ'" == "POT" {
			local firstyear = 1996
		}
// Für jedes jahr lies Daten ein, bearbeite sie und füge sie zusammen
		forvalues y = `firstyear'/`lastyear' {
			local dctfile "`path'Panel `y'\\`dictfname'"
			di "`dctfile'"
// Lies Daten im Text-Format mit DictFile ein, unterdrücke dabei den Output
			quietly infix using "`dctfile'",clear
// markiere Wege mit doppelter Wegenummer und markiere anschließend alle Wege des Tages und zähle sie sortiert nach der Abfahrtszeit neu durch und
			if "`Typ'" == "W"{
				sort ID PERSNR JAHR BERTAG WNRT ABZEIT
				duplicates tag ID PERSNR JAHR  BERTAG  WNRT,gen(_dubl_weg)
				by ID PERSNR JAHR BERTAG: egen _dubl_tag = max(_dubl_weg)
				by ID PERSNR JAHR BERTAG: egen _rank = rank(ABZEIT) if _dubl_tag>0,unique
				replace WNRT = _rank if _rank<.
// ersetze bei den Wegen die in den .txt-Dateien gerundeten km-Angaben durch die km-Angaben mit Nachkommastelle aus den SPSS-Daten
				drop _rank _dubl_weg _dubl_tag KM
				sort ID PERSNR JAHR  BERTAG  WNRT
				merge ID PERSNR JAHR  BERTAG  WNRT using "`path'Panel `y'\Stata\MOP_W_km.dta", unique sort
				drop _merge
			}
// Füge ab dem 2. Jahr Daten an vorhandene Daten an
			if `y' > `firstyear'{
				append using `savefname',nolabel
			}
// Am Schluss (im letzten Jahr)
			if `y' == `lastyear' {
//  Füge Labels hinzu
			`adofname'
//  Schaffe neues Feld mit dem Berichtsdatum im Stata-Format für HH-, P und PT-Daten (in KIND und HH-Daten nicht relevant)
				if "`Typ'" !="KIND" & "`Typ'" !="POT" & "`Typ'" !="HH" {
					if "`Typ'" == "P" {
						local datevar "DATANF"
						tostring `datevar', replace format(%04.0f)
						gen `datevar'_1 = date(`datevar'+string(JAHR),"DMY")
						format `datevar'_1 %td
					}
					else{
						local datevar "DATUM"
						tostring `datevar', replace format(%06.0f)
						gen `datevar'_1 = date(substr(`datevar',1,4)+string(JAHR),"DMY")
						format `datevar'_1 %td
					}
// Lösche SAS-Datumsvariable und benenne neue Variable um
					drop `datevar'
					rename `datevar'_1 `datevar'
					label var `datevar' "Datum"
				}
// Füge eindeutige HH bzw. Pers.-IDs hinzu und definiere diese als Panel-Variable
				if "`Typ'"=="HH" {
					xtset ID
				}
				else {
					gen PHHID= ID*10+ PERSNR
					label var PHHID "HH_Pers-ID"
					xtset PHHID
				}
// Missings definieren
				foreach variable of varlist _all {
					quietly recode `variable'(-9 = .)
				}
			}
// Speichere Daten im Stata-Format
			save `savefname', replace
			clear
			
		} 
	 }
	set more on

	
end
