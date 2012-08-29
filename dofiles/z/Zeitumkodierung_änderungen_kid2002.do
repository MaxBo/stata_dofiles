* Do-File zur Zeitumkodierung der MiD-2008 Daten
* Hintergrund: Berechnung von Fahrzeiten und Aktivitätsdauern, die über einen Tag

clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100705_zeitn_2.dta", clear

* Sortierung für Datenanalyse
drop if f00_n == .
drop pneg_akt2
sort  k00 f00 Ab_std_korr Ab_min An_std_korr An_min
bysort k00: replace f00_n = _n

* Aktivitätendauer aktualisierung
bysort k00: replace akt_dauer = (Ab_std_korr[_n+1]-  An_std_korr[_n])*60+Ab_min[_n+1]- An_min[_n] if f00_n!=.


* Fahrdauer generieren
replace fahrzeit = (An_std_korr-Ab_std_korr)*60+An_min-Ab_min if f00_n!=.


* Summe der Aktivitäten- und Fahrtdauer [kumuliert] berechnen
bysort k00: replace zeitsummefahr = sum(fahrzeit)
bysort k00: replace zeitsummeakt = sum(akt_dauer)



* Anteil der Aktivitäten- Fahrtdauer an der Gesamtzeit (tagesbezogen, von 1. bis letzter Aktivität)
bysort k00: replace ant_fahrzeit_akt=fahrzeit/zeitsummefahr[_N]
bysort k00: replace ant_aktzeit_akt=akt_dauer/zeitsummeakt[_N]


* Anzahl Wege geniereren
bysort k00: gen AnzWege=sum(f17)
bysort k00: replace Anz_Wege=AnzWege[_N]
drop AnzWege 
bysort k00: replace Anz_Wege=_N


* negative Aktivitätendauer markieren
replace neg_akt=0
replace neg_akt=1 if akt_dauer<0


* Persone mit negativer Aktivität markieren
sort  k00 f00_n
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100705_zeitn_3.dta", replace

* Markierung negativer Aktivitätendauern für alle Wege der Person bis zur Editieransicht

keep k00 neg_akt
keep if neg_akt>0
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\neg_akt2.dta", replace
sort  k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\neg_akt2.dta", replace
clear

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100705_zeitn_3.dta"

merge k00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\neg_akt2.dta", uniqusing  _merge(pneg_akt2)

