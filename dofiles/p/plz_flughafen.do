set more off
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", clear
gen f5 = f5_2
replace f5 = 1 if missing(f5_2)
label value f5 Ausland
duplicates drop f3a f5 Jahr, force
sort Jahr f5 f3a

export excel Jahr f5 f3a  using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\Auswertungen\plz.xls", replace  firstrow(varlabels) sheet("Rohdaten")

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", clear
gen f8 = f8_2
replace f8 = 1 if missing(f8_2)
label value f8 Ausland

duplicates drop f7a f8 Jahr, force
sort Jahr f8 f7a

export excel Jahr f8 f7a  using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\Auswertungen\plz.xls",  firstrow(varlabels) cell(D1) sheetmodify

