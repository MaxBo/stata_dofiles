clear
set memory 700m
use "C:\Sonja_Diss\KiD_2002\Einzelfahrten_100623_neu.dta", clear

sort k00 f00

* Fahrzeiten
bysort k00 f00: gen fahrzeit =  (An_std - Ab_std)*60 +   An_min - Ab_min
bysort k00: gen fahrzeit_kum = fahrzeit if _n==1
bysort k00: replace fahrzeit_kum = fahrzeit_kum[_n-1] + fahrzeit[_n] if _n>1
bysort k00: gen fahrzeit_ges = fahrzeit_kum[_N]

label variable fahrzeit "Fahrzeit einer Fahrt"
label variable fahrzeit_kum  "kumulierte Fahrzeit für ein Fahrzeug"
label variable fahrzeit_ges "Gesamtfahrzeit des Fahrzeuges am Erhebungstag"

* Aktivitätendauer

bysort k00: gen akt_dauer =  (Ab_std[_n]-An_std[_n-1])*60 + Ab_min[_n]-An_min[_n-1]
bysort k00: gen akt_dauer_kum = akt_dauer[_n] if _n==2
bysort k00: replace akt_dauer_kum = akt_dauer_kum[_n-1] + akt_dauer[_n] if _n>2 & f00 <= 11
bysort k00: gen akt_dauer_ges = akt_dauer_kum[_N]

label variable akt_dauer "Dauer einer Aktivität"
label variable akt_dauer_kum  "kumulierte Aktivitätendauer eines Fahrzeugs"
label variable akt_dauer_ges "Gesamtaktivitätendauer eines Fahrzeugs"

bysort k00: gen Anz_Fahrten = [_N]
label variable Anz_Fahrten "Anzahl Fahrten eines Fahrzeugs am Erhebungstag"

gen bearbeitet = 0
label variable bearbeitet "Korrektur der Fahrtkette"
label define bearbeitet 0 `"keine Änderungen"', modify
label define bearbeitet 1 `"Abfahrts- oder Ankunftszeit angepasst"', modify
label define bearbeitet 2 `"Fahrtenreihenfolge angepasst"', modify
label define bearbeitet 3 `"Attributierung angepasst"', modify
label define bearbeitet 4 `"mehrere Anpassungen"', modify
label define bearbeitet 5 `"12. Fahrt"', modify
label define bearbeitet 6 `"Ausschluss der Fahrtenkette"', modify


* Persone mit negativer Aktivität markieren
gen akt_dauer_neg = (akt_dauer<0)
sort k00
keep k00 akt_dauer_neg
keep if akt_dauer_neg>0
save "C:\Sonja_Diss\KiD_2002\neg_akt.dta", replace


use "C:\Sonja_Diss\KiD_2002\Einzelfahrten_100623_neu_2.dta"

merge k00 using "C:\Sonja_Diss\KiD_2002\neg_akt.dta", uniqusing  _merge(pneg_akt)

