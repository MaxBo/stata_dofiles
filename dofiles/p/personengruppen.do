clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_8.dta", clear



gen VHPG_einfach = .a
replace VHPG_einfach = 1 if  > 0 &
replace VHPG_einfach = 2 if Anz_Arbeit > 0 &

label define VHPG_einfach 1 `"Berufstätige mit verfügbarem Pkw"', modify 
label define VHPG_einfach 1 `"Berufstätige ohne verfügbarem Pkw"', modify
* Berufstätige sind alle, die einer Arbeitstätigkeit nachgehen: Vollzeit, Teilzeit oder sonstige