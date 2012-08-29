clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_8.dta", clear



gen VHPG_einfach = .a
replace VHPG_einfach = 1 if  > 0 &
replace VHPG_einfach = 2 if Anz_Arbeit > 0 &

label define VHPG_einfach 1 `"Berufst�tige mit verf�gbarem Pkw"', modify 
label define VHPG_einfach 1 `"Berufst�tige ohne verf�gbarem Pkw"', modify
* Berufst�tige sind alle, die einer Arbeitst�tigkeit nachgehen: Vollzeit, Teilzeit oder sonstige