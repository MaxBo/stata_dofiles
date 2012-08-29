* Do-File zur Zeitumkodierung der MiD-2002 Daten
* Hintergrund: Berechnung von Fahrzeiten und Aktivit�tsdauern, die �ber einen Tag

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn3_1.dta", clear

* Sortierung f�r Datenanalyse
replace WSIDN = . if WSIDN ==0
sort HHID PID WSIDN
drop if WSIDN == .

* Aktivit�tendauer generieren
bysort HHID PID: replace akt_dauer = (ST_STD_korr[_n+1]-  EN_STD_korr[_n])*60+ST_MIN[_n+1]- EN_MIN[_n] if WSIDN!=.


* Fahrdauer generieren
replace fahrzeit = (EN_STD_korr-ST_STD_korr)*60+EN_MIN-ST_MIN if WSIDN!=.


* Summe der Aktivit�ten- und Fahrtdauer [kumuliert] berechnen
bysort HHID PID: replace zeitsummefahr = sum(fahrzeit)
bysort HHID PID: replace zeitsummeakt = sum(akt_dauer)



* Anteil der Aktivit�ten- Fahrtdauer an der Gesamtzeit (tagesbezogen, von 1. bis letzter Aktivit�t)
bysort HHID PID: replace ant_fahrzeit_akt=fahrzeit/zeitsummefahr[_N]
bysort HHID PID: replace ant_aktzeit_akt=akt_dauer/zeitsummeakt[_N]


* Anzahl Wege geniereren
bysort HHID PID: replace Anz_Wege=_N


* negative Aktivit�tendauer markieren
replace neg_akt=0
replace neg_akt=1 if akt_dauer<0


* Persone mit negativer Aktivit�t markieren
sort  id_hhp
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn4.dta", replace

* Markierung negativer Aktivit�tendauern f�r alle Wege der Person bis zur Editieransicht
keep id_hhp neg_akt
keep if neg_akt>0
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\neg_akt2.dta", replace
sort  id_hhp
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\neg_akt2.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn4.dta"

merge id_hhp using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\neg_akt2.dta", uniqusing  _merge(pneg_akt2)

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn5.dta", replace

* hineinkopieren in Stata:
* edit  HHID PID WSID WSIDN STICHTAG ST_STD_korr ST_MIN  EN_STD_korr EN_MIN W04 W04_DZW HWZWECK W01 W13 HVM akt_dauer bearbeitet if  pneg_akt == 3 & bearbeitet == 0

* beim Editieren beachten: wenn Wege entfernt werden, dann WSIDN = 0 und entsprechend die �brigen Wege in der Variablen anpassen
* am Ende des Editierens "bearbeitet"  mit Wert f�r alle Einzelwege der Person belegen:
* 1 = doppelten Weg entfernt
* 2 = Zeiten angepasst
* 3 = Wegekette ma�geblich ver�ndert
* 4 = Wegekette ma�geblich ver�ndert und Zeitanpassungen
* 5 = ungekl�rte F�lle