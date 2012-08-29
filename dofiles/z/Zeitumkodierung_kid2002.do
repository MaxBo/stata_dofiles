* Do-File zur Zeitumkodierung der MiD-2002 Daten
* Hintergrund: Berechnung von Fahrzeiten und Aktivitätsdauern, die über einen Tag

clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100705.dta", clear

sort  k00 f00 Ab_std Ab_min An_std An_min
bysort k00: gen f00_n = _n

sort k00 f00_n

* Neue Start- und Ankunftsstunden definieren
* WENN(C2<B2,C2+24,WENN(C2<D1,C2+24,C2)) ODER WENN(A2=1,C2,WENN(C2<E1,C2+24,C2))
bysort k00: gen Ab_std_korr = Ab_std
bysort k00: replace Ab_std_korr = Ab_std+24 if _n>1 & Ab_std[_n] < Ab_std_korr[_n-1]
bysort k00: gen An_std_korr = An_std
bysort k00: replace An_std_korr = An_std +24 if An_std[_n]<Ab_std_korr[_n]
label var Ab_std_korr "korrigierte Startstunde 24+"
label var An_std_korr "korrigierte Ankunftsstunde 24+"
* Aktivitätendauer generieren
bysort k00: gen akt_dauer = (Ab_std_korr[_n+1]-  An_std_korr[_n])*60+Ab_min[_n+1]- An_min[_n]
label var akt_dauer "Aktivitätendauer mit korrigierten Stunden berechnet [min]"

* Fahrdauer generieren
gen fahrzeit = (An_std_korr-Ab_std_korr)*60+An_min-Ab_min
label var fahrzeit "Fahrzeit mit korrigierten Stunden berechnet [min]"

* Summe der Aktivitäten- und Fahrtdauer [kumuliert] berechnen
bysort k00: gen zeitsummefahr = sum(fahrzeit)
bysort k00: gen zeitsummeakt = sum(akt_dauer)
label var zeitsummefahr "kumulierte Fahrzeit über den Tagesverlauf [min]"
label var zeitsummeakt "kumulierte Aktivitätendauer über den Tagesverlauf [min]"


* Anteil der Aktivitäten- Fahrtdauer an der Gesamtzeit (tagesbezogen, von 1. bis letzter Aktivität)
bysort k00: gen ant_fahrzeit_akt=fahrzeit/zeitsummefahr[_N]
bysort k00: gen ant_aktzeit_akt=akt_dauer/zeitsummeakt[_N]
label var ant_fahrzeit_akt "Anteil der Fahrzeit an der Tagesgesamtfahrzeit [%]"
label var ant_aktzeit_akt "Anteil der Aktivitätendauer der Aktivität an der Gesamtaktivitätendauer am Tag [%]"

* Anzahl Wege geniereren
bysort k00: gen AnzWege=sum(f17)
bysort k00: gen Anz_Wege=AnzWege[_N]
drop AnzWege 
label var Anz_Wege "Anzahl der Wege des Fahrzeugs"



* negative Aktivitätendauer markieren
gen neg_akt=0
replace neg_akt=1 if akt_dauer<0
label var neg_akt "Aktivitätendauer für diese Aktivität negativ"


* Persone mit negativer Aktivität markieren
sort  k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100705_zeit.dta", replace

* Markierung negativer Aktivitätendauern für alle Wege der Person bis zur Editieransicht
keep k00 neg_akt
keep if neg_akt>0
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\neg_akt.dta", replace
sort  k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\neg_akt.dta", replace
clear

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100705_zeit.dta"

merge k00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\neg_akt.dta", uniqusing  _merge(pneg_akt)
gen bearbeitet =0
label define bearbeitet 1 `"doppelten Weg entfernt"', modify
label define bearbeitet 2 `"Zeiten angepasst"', modify
label define bearbeitet 3 `"Wegekette maßgeblich verändert"', modify
label define bearbeitet 4 `"Wegekette maßgeblich verändert und Zeitanpassungen"', modify
label define bearbeitet 5 `"ungeklärte Fälle"', modify
label define bearbeitet 0 `"keine Bearbeitung"', modify

label value bearbeitet bearbeitet


* gen WSIDN = WSID
* save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn2.dta", replace

* hineinkopieren in Stata:
* edit  k00 WID WSID WSIDN WTAG Ab_std_korr Ab_min  An_std_korr An_min W04  W01 W13 akt_dauer bearbeitet if  pneg_akt == 3 & bearbeitet == 0

* beim Editieren beachten: wenn Wege entfernt werden, dann WSIDN = 0 und entsprechend die übrigen Wege in der Variablen anpassen
* am Ende des Editierens "bearbeitet"  mit Wert für alle Einzelwege der Person belegen:
* 1 = doppelten Weg entfernt
* 2 = Zeiten angepasst
* 3 = Wegekette maßgeblich verändert
* 4 = Wegekette maßgeblich verändert und Zeitanpassungen
* 5 = ungeklärte Fälle