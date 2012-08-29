* Do-File zur Generierung eines neuen Labels für den normalen Tag
* Eingangsdaten - MiD 2008 des jeweiligen Jahres


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Personen.dta", clear


* Umkodierung

recode S02_1 (0=0) (1=1) (.f=0) (.g=0)
recode S02_2 (0=0) (1=10) (.f=0) (.g=0)
recode S02_3 (0=0) (1=100) (.f=0) (.g=0)
recode S02_4 (0=0) (1=1000) (.f=0) (.g=0)
recode S02_5 (0=0) (1=10000) (.f=0) (.g=0)
recode S02_6 (0=0) (1=100000) (.f=0) (.g=0)
recode S02_7 (0=0) (1=1000000) (.f=0) (.g=0)

gen S01a=S02_1+S02_2+S02_3+S02_4+S02_5+S02_6+S02_7 
replace S01a = 0 if missing(S01a) & S01 == 1
replace S01a = 100000 if missing(S01a) & S01 == .f
replace S01a = 1000000 if missing(S01a) & S01 == .g

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
