set more off

import excel "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\Datumszuweisung_Sonja.xlsx", clear sheet("Reisedaten_Bundesland") firstrow

rename NormalerTagReisebeginn normalertagreisebeginn
rename NormaleWocheReisebeginn normalewochereisebeginn
rename NormalerTagReiseende normalertagreiseende
rename NormaleWocheReiseende normalewochereiseende
rename Feiertagwoche feiertagwoche
rename Wochenendfahrt wochenendfahrt
rename Woche_Schulferien woche_schulferien

gen rdatsas = Reiseende
gen rbeginn = Reisebeginn

gen wbland = 1 if Wohnbundesland == "Schleswig-Holstein"
replace wbland = 2 if Wohnbundesland == "Hamburg"
replace wbland = 3 if Wohnbundesland == "Niedersachsen"
replace wbland = 4 if Wohnbundesland == "Bremen"
replace wbland = 5 if Wohnbundesland == "Nordrhein-Westfalen"
replace wbland = 6 if Wohnbundesland == "Hessen"
replace wbland = 7 if Wohnbundesland == "Rheinland-Pfalz"
replace wbland = 8 if Wohnbundesland == "Baden-Württemberg"
replace wbland = 9 if Wohnbundesland == "Bayern"
replace wbland = 10 if Wohnbundesland == "Saarland"
replace wbland = 11 if Wohnbundesland == "Berlin"
replace wbland = 12 if Wohnbundesland == "Brandenburg"
replace wbland = 13 if Wohnbundesland == "Mecklenburg-Vorpommern"
replace wbland = 14 if Wohnbundesland == "Sachsen"
replace wbland = 15 if Wohnbundesland == "Sachsen-Anhalt"
replace wbland = 16 if Wohnbundesland == "Thüringen"

* gen hhtyp_3 =1 if hhtyp=="Einpersonen-HH"
* replace hhtyp_3 =1 if hhtyp=="Haushalt mit Kind"
* replace hhtyp_3 =1 if hhtyp=="Mehrpersonen-HH (Erw.)"

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\datumszuweisung.dta", replace

