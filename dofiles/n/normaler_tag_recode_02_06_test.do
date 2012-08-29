* Do-File zur Generierung eines neuen Labels für den normalen Tag
* Eingangsdaten - MiD 2008 des jeweiligen Jahres
clear
set memory 32m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Personen.dta", clear


* Umkodierung

recode s02_1 (0=0) (1=1) (.a=0)
recode s02_2 (0=0) (1=10) (.a=0)
recode s02_3 (0=0) (1=100) (.a=0)
recode s02_4 (0=0) (1=1000) (.a=0)
recode s02_6 (0=0) (1=10000) (.a=0)
recode s02_7 (0=0) (1=100000) (.a=0)
recode s02_8 (0=0) (1=1000000) (.a=0)

gen S01a=s02_1+s02_2+s02_3+s02_4+s02_6+s02_7 
replace S01a = 0 if missing(S01a) & s01 == 1
replace S01a = 100000 if missing(S01a) & (s01 == .f | s01 == .a)
replace S01a = 1000000 if missing(S01a) & s01 == .g
tostring S01a, replace

label var S01a "normaler Stichtag, differenziert"

label define S01a 0 `"normal"', modify
label define S01a 1 `"Stichtag nicht normal: Urlaub, innerhalb Deutschlands"', modify
label define S01a 10 `"Stichtag nicht normal: Urlaub, außerhalb Deutschlands"', modify
label define S01a 11 `"Urlaub innerhalb und außerhalb von Deutschland"', modify
label define S01a 100 `"Stichtag nicht normal: Krankheit"', modify
label define S01a 1000 `"Stichtag nicht normal: gar nicht außer Haus"', modify
label define S01a 1001 `"Urlaub innerhalb und nicht außer Haus"', modify
label define S01a 1100 `"Krankheit und nicht außer Haus"', modify
label define S01a 10000 `"Stichtag nicht normal: andere Gründe"', modify
label define S01a 10001 `"Urlaub innerhalb und andere Gründe"', modify
label define S01a 10010 `"Urlaub außerhalb und andere Gründe"', modify
label define S01a 10100 `"Krankheit und andere Gründe"', modify
label define S01a 11000 `"nicht außer Haus und andere Gründe"', modify
label define S01a 100000 `"Stichtag nicht normal: verweigert"', modify
label define S01a 1000000 `"Stichtag nicht normal: weiß nicht"', modify