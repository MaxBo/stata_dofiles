clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\hh.dta", clear
label define vorh 1 `"vorhanden"' 0 `"fehlt"'

label var ID "Schl�sselnummer des HH (1-7)"
label var Welle "Befragungswelle"
label var Kohorte "Kohorte"
label var Gruppe "Befragungsgruppe"

label var HHstat "Haushaltsfragebogen"
label define HHstat 1 `"Fragebogen vorhanden"' .a `"Fragebogen fehlt"'
recode HHstat (9=.a)
label value HHstat HHstat

label var HHgro "Anzahl der Personen im HH"
label var hhkind "Anzahl Kinder unter 14 im HH"

label var hhpkw "Anzahl verf�gbarer Pkw im HH"
label var hhpkwp "Anzahl verf�gbarer privater Pkw"
label var hhpkwd "Anzahl verf�gbarer privat genutzter Firmenwagen"

label var hhlage "Lage der Wohnung"
label define hhlage 1 `"innerer Stadtbereich einer Gro�stadt"', modify 
label define hhlage 2 `"Stadtrand bzw. Vorort Gro�stadt"', modify 
label define hhlage 3 `"innerer Stadtbereich einer mittelgro�en Stadt"', modify
label define hhlage 4 `"Stadtrand bzw. Vorort mittelgro�e Stadt"', modify
label define hhlage 5 `"Kleinstadt bzw. gro�e Gemeinde"', modify
label define hhlage 6 `"auf dem Land bzw. kleine Landgemeinde"', modify
label value hhlage hhlage  
  
foreach x in "bus" "tram" "ubahn" "sbahn" "bahn" { 
	label var hh`x' "`x'haltestelle in der N�he der Wohnng"
	label value hh`x' vorh
	replace hh`x'=0 if missing(hh`x')
	label var hh`x'min "Minuten Fu�weg zu `x'"
}

label var hhbhfkm "Entfernung zum n�chsten DB-Bhf [km]"
label var hhbhfkmkA "Entfernung zum n�chsten DB-Bhf nicht bekannt"
label define kA .a `"Entfernung nicht bekannt"', modify
label value  hhbhfkm kA
replace hhbhfkm=.a if  hhbhfkmkA==1 & missing(hhbhfkm)

label var hhbhfcode "Code des n�chsten Bhf"
label var hhbhfname "Name des n�chsten Bhf"
label var hhbhfcodekA "Code des n�chsten Bhf nicht bekannt"
replace hhbhfcode = .a if missing(hhbhfcode) & hhbhfcodekA==1

label var hhbhfnvmin "Min mit Nahverkehr zum Bhf"
label var hhbhfnvminkA "Bahnhof mit Nahverkehr"
replace hhbhfnvmin = .b if missing(hhbhfnvmin) & hhbhfnvminkA==2
replace hhbhfnvmin = .a if missing(hhbhfnvmin) & hhbhfnvminkA==3
label define erreich .b `"nicht oder nur ung�nstig erreichbar"' .a `"nicht bekannt"'
label value hhbhfnvmin erreich

label var hhbhfpkwmin "Min mit Pkw zum Bhf"
label var hhbhfpkwkA "Fahrzeit zum Bhf nicht bekannt"
replace hhbhfpkwmin = .a if missing(hhbhfpkwmin) & hhbhfpkwkA==1
label value hhbhfpkwmin erreich

label var ruecksenddat "R�cksendebogen des Bogens [TT:MM:JJ]"
label var wohnplz "PLZ des Wohnortes"
label var wohnort "Wohnort"
label var wohngkz "Gemeindekennziffer"
label var wohncode "Ortscode [Stadt.exe]"
label var kontrolnr "interne Kontrollnummer HH-Fragebogen"
label var berichtzeitanf "Bereichtszeitraum Anfang [TTMMJJ]"
label var berichtzeitend "Bereichtszeitraum Ende [TTMMJJ]"

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\hh_label.dta", replace
