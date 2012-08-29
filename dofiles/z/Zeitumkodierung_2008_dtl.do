* Do-File zur Zeitumkodierung der MiD-2008 Daten
* Hintergrund: Berechnung von Fahrzeiten und Aktivitätsdauern, die über einen Tag

clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege.dta", clear

* Sortierung für Datenanalyse
sort hhid pid wsid

* Neue Start- und Ankunftsstunden definieren

bysort hhid pid: gen st_std_korr = st_std
bysort hhid pid: replace st_std_korr = st_std+24 if _n>1 & st_dat==1 & st_std[_n] < st_std_korr[_n-1]
bysort hhid pid: gen en_std_korr = en_std
bysort hhid pid: replace en_std_korr = en_std +24 if _n>1 & en_dat==1 & en_std[_n]<en_std_korr[_n-1]
label var st_std_korr "korrigierte Startstunde 24+"
label var en_std_korr "korrigierte Ankunftsstunde 24+"
* Aktivitätendauer generieren
bysort hhid pid: gen akt_dauer = (st_std_korr[_n+1]-  en_std_korr[_n])*60+st_min[_n+1]- en_min[_n] if _n>0
label var akt_dauer "Aktivitätendauer mit korrigierten Stunden berechnet [min]"

* Fahrdauer generieren
gen fahrzeit = (en_std_korr-st_std_korr)*60+en_min-st_min
label var fahrzeit "Fahrzeit mit korrigierten Stunden berechnet [min]"

* Summe der Aktivitäten- und Fahrtdauer [kumuliert] berechnen
bysort hhid pid: gen zeitsummefahr = sum(fahrzeit)
bysort hhid pid: gen zeitsummeakt = sum(akt_dauer)
label var zeitsummefahr "kumulierte Fahrzeit über den Tagesverlauf [min]"
label var zeitsummeakt "kumulierte Aktivitätendauer über den Tagesverlauf [min]"


* Anteil der Aktivitäten- Fahrtdauer an der Gesamtzeit (tagesbezogen, von 1. bis letzter Aktivität)
bysort hhid pid: gen ant_fahrzeit_akt=fahrzeit/zeitsummefahr[_N]
bysort hhid pid: gen ant_aktzeit_akt=akt_dauer/zeitsummeakt[_N]
label var ant_fahrzeit_akt "Anteil der Fahrzeit an der Tagesgesamtfahrzeit [%]"
label var ant_aktzeit_akt "Anteil der Aktivitätendauer der Aktivität an der Gesamtaktivitätendauer am Tag [%]"

* Anzahl Wege geniereren
bysort hhid pid: gen Anz_Wege=_N
label var Anz_Wege "Anzahl der Wege der Person"

* negative Aktivitätendauer markieren
gen neg_akt=0
replace neg_akt=1 if akt_dauer<0
label var neg_akt "Aktivitätendauer für diese Aktivität negativ"

* Persone mit negativer Aktivität markieren
sort  id_hhp
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege_zeitn.dta", replace

* Markierung negativer Aktivitätendauern für alle Wege der Person bis zur Editieransicht
* outfile id_hhp neg_akt using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\neg_akt.txt" if neg_akt>0, nolabel noquote replace
* clear

* infile id_hhp neg_akt using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\neg_akt.txt"
keep id_hhp neg_akt
keep if neg_akt>0
sort  id_hhp
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\neg_akt.dta", replace


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege_zeitn.dta"

merge id_hhp using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\neg_akt.dta" uniqusing _merge(pneg_akt)
gen bearbeitet =0
label define bearbeitet 1 `"doppelten Weg entfernt"', modify
label define bearbeitet 2 `"Zeiten angepasst"', modify
label define bearbeitet 3 `"Wegekette maßgeblich verändert"', modify
label define bearbeitet 4 `"Wegekette maßgeblich verändert und Zeitanpassungen"', modify
label define bearbeitet 5 `"ungeklärte Fälle"', modify
label define bearbeitet 0 `"keine Bearbeitung"', modify

gen WSIDN = WSID
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege_zeitn2.dta"

* hineinkopieren in Stata:
* edit  hhid pid WSID WSIDN stICHTAG st_std__korr st_min  en_std__korr en_min W04 W04_DZW HWZWECK W01 W13 HVM akt_dauer bearbeitet if  pneg_akt == 3 & bearbeitet == 0

* beim Editieren beachten: wenn Wege entfernt werden, dann WSIDN = 0 und entsprechend die übrigen Wege in der Variablen anpassen
* am Ende des Editierens "bearbeitet"  mit Wert für alle Einzelwege der Person belegen:
* 1 = doppelten Weg entfernt
* 2 = Zeiten angepasst
* 3 = Wegekette maßgeblich verändert
* 4 = Wegekette maßgeblich verändert und Zeitanpassungen
* 5 = ungeklärte Fälle