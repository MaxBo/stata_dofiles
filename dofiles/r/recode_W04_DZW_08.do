

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", clear

* label define W04_DZW 599 `"Einkäufe, kein Angabe zum Detail"', modify
* label define W04_DZW 799 `"Freizeit, kein Angabe zum Detail"', modify
* label define W04_DZW 699 `"Erledigung, kein Angabe zum Detail"', modify

recode W04_DZW (599=.a) (799=.a) (699=.a)