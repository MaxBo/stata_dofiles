* Do-File zur Generierung von Wegeketten
* Grobes Modell zur Bestimmung von vereinfachten Wegeaktivitäten, Wegepaaren und allgemeine und heimbasierte Ketten
* Eingangsdaten - MiD des jeweiligen Jahres


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege.dta", clear

* Sortierung für Datenanalyse
sort HHID PID WSID


* Zweck generieren Hilfsvariablen: Wegzweck (W04)	 Spezifikation (W04_DZW)	Quelle (W01) 	Ziel (W13)

bysort HHID PID: gen Zweck = 2 if W04 == 1 | W13 == 2
bysort HHID PID: replace Zweck = 5 if W04 == 3 | W04 == 31
bysort HHID PID: replace Zweck = 9 if (W01 == 1 & W13 == 1) | W13 == 5
bysort HHID PID: replace Zweck = 1 if W04[_n] == 8
bysort HHID PID: replace Zweck = 10 if W04 == 11 | W04 == 6
bysort HHID PID: replace Zweck = 3 if W04 == 4 & W04_DZW == 501
bysort HHID PID: replace Zweck = 4 if W04 == 4 & W04_DZW != 501
bysort HHID PID: replace Zweck = 7 if W04 == 7 | W04 == 5
bysort HHID PID: replace Zweck = 6 if W04 == 32
bysort HHID PID: replace Zweck = 8 if W04 == 10 | W04 == .a| W04 == .g 
bysort HHID PID: replace Zweck = Zweck[_n-2] if  W04 == 9 | _n>2

label var Zweck "ausgeführte Zielaktivität"

label define Zweck 2 `"Arbeit"', modify
label define Zweck 1 `"Wohnen"', modify
label define Zweck 3 `"Einkauf periodisch"', modify
label define Zweck 4 `"Einkauf aperiodisch"', modify
label define Zweck 5 `"Bilden"', modify
label define Zweck 6 `"Kindergarten"', modify
label define Zweck 7 `"Freizeit / Erledigung"', modify
label define Zweck 8 `"Sonstige"', modify
label define Zweck 9 `"Rundweg"', modify
label define Zweck 10 `"Begleitung"', modify

* Wegepaare generieren:
bysort HHID PID: gen wegpaar = Zweck[_n-1]+" - "+Zweck[_n] if _n>0
bysort HHID PID: replace wegpaar = "Wohnen"+" - "+Zweck[_n] if W01 == 1 |  (_n==1 & W01 == .a)

* Wegekette generieren:
bysort HHID PID: gen wegekette = wegpaar[_n] if _n==1
bysort HHID PID: replace wegekette = wegekette[_n-1]+" ; "+ wegpaar[_n] if _n>1

* Wegeketten generieren mit Wohnen als Heimbasis
bysort HHID PID: gen wegekette_home = wegpaar[_n] if _n==1 | Zweck[_n-1] == 1
bysort HHID PID: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
