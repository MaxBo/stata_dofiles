* Do-File zur Zeitumkodierung der MiD-2008 Daten
* Hintergrund: Berechnung von Fahrzeiten und Aktivit�tsdauern, die �ber einen Tag

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege.dta", clear

* Sortierung f�r Datenanalyse
sort HHID PID WSID

* Neue Start- und Ankunftsstunden definieren

bysort HHID PID: gen ST_STD_korr = ST_STD
bysort HHID PID: replace ST_STD_korr = ST_STD+24 if _n>1 & ST_STD[_n] < ST_STD_korr[_n-1]
bysort HHID PID: gen EN_STD_korr = EN_STD
bysort HHID PID: replace EN_STD_korr = EN_STD +24 if _n>1 & EN_STD[_n]<EN_STD_korr[_n-1]
label var ST_STD_korr "korrigierte Startstunde 24+"
label var EN_STD_korr "korrigierte Ankunftsstunde 24+"
* Aktivit�tendauer generieren
bysort HHID PID: gen akt_dauer = (ST_STD_korr[_n+1]-  EN_STD_korr[_n])*60+ST_MIN[_n+1]- EN_MIN[_n] if _n>0
label var akt_dauer "Aktivit�tendauer mit korrigierten Stunden berechnet [min]"

* Fahrdauer generieren
gen fahrzeit = (EN_STD_korr-ST_STD_korr)*60+EN_MIN-ST_MIN
label var fahrzeit "Fahrzeit mit korrigierten Stunden berechnet [min]"

* Summe der Aktivit�ten- und Fahrtdauer [kumuliert] berechnen
bysort HHID PID: gen zeitsummefahr = sum(fahrzeit)
bysort HHID PID: gen zeitsummeakt = sum(akt_dauer)
label var zeitsummefahr "kumulierte Fahrzeit �ber den Tagesverlauf [min]"
label var zeitsummeakt "kumulierte Aktivit�tendauer �ber den Tagesverlauf [min]"


* Anteil der Aktivit�ten- Fahrtdauer an der Gesamtzeit (tagesbezogen, von 1. bis letzter Aktivit�t)
bysort HHID PID: gen ant_fahrzeit_akt=fahrzeit/zeitsummefahr[_N]
bysort HHID PID: gen ant_aktzeit_akt=akt_dauer/zeitsummeakt[_N]
label var ant_fahrzeit_akt "Anteil der Fahrzeit an der Tagesgesamtfahrzeit [%]"
label var ant_aktzeit_akt "Anteil der Aktivit�tendauer der Aktivit�t an der Gesamtaktivit�tendauer am Tag [%]"

* Anzahl Wege geniereren
bysort HHID PID: gen Anz_Wege=_N
label var Anz_Wege "Anzahl der Wege der Person"

* negative Aktivit�tendauer markieren
gen neg_akt=0
replace neg_akt=1 if akt_dauer<0
label var neg_akt "Aktivit�tendauer f�r diese Aktivit�t negativ"

* Persone mit negativer Aktivit�t markieren
sort  id_hhp
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn.dta"

* Markierung negativer Aktivit�tendauern f�r alle Wege der Person bis zur Editieransicht
outfile id_hhp neg_akt using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\neg_akt.txt" if neg_akt>0, nolabel noquote replace
clear

infile id_hhp neg_akt using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\neg_akt.txt"
sort  id_hhp
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\neg_akt.dta"


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn.dta"

merge id_hhp using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\neg_akt.dta", uniqusing  _merge(pneg_akt)
gen bearbeitet =0
label define bearbeitet 1 `"doppelten Weg entfernt"', modify
label define bearbeitet 2 `"Zeiten angepasst"', modify
label define bearbeitet 3 `"Wegekette ma�geblich ver�ndert"', modify
label define bearbeitet 4 `"Wegekette ma�geblich ver�ndert und Zeitanpassungen"', modify
label define bearbeitet 5 `"ungekl�rte F�lle"', modify
label define bearbeitet 0 `"keine Bearbeitung"', modify

gen WSIDN = WSID
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn2.dta"

* hineinkopieren in Stata:
* edit  HHID PID WSID WSIDN STICHTAG ST_STD_korr ST_MIN  EN_STD_korr EN_MIN W04 W04_DZW HWZWECK W01 W13 HVM akt_dauer bearbeitet if  pneg_akt == 3 & bearbeitet == 0

* beim Editieren beachten: wenn Wege entfernt werden, dann WSIDN = 0 und entsprechend die �brigen Wege in der Variablen anpassen
* am Ende des Editierens "bearbeitet"  mit Wert f�r alle Einzelwege der Person belegen:
* 1 = doppelten Weg entfernt
* 2 = Zeiten angepasst
* 3 = Wegekette ma�geblich ver�ndert
* 4 = Wegekette ma�geblich ver�ndert und Zeitanpassungen
* 5 = ungekl�rte F�lle