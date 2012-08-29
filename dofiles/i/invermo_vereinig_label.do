clear
set memory 700m

* pfad = C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\Welle
* pfadn = C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA


foreach x in "hh" "p" "r"{
	use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\Welle1\\`x'1.dta", clear
	 forvalue i = 2/4{
		qui append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\Welle`i'\\`x'`i'.dta"
	}
	save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\\`x'.dta", replace
}

* Screening
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_k1.dta", clear
forvalue i = 2/3{
	qui append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_k`i'.dta"
}

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_ges.dta", replace


