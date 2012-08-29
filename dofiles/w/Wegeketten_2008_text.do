* Do-File zur Generierung von Wegeketten
* Grobes Modell zur Bestimmung von vereinfachten Wegeaktivitäten, Wegepaaren und allgemeine und heimbasierte Ketten
* Eingangsdaten - MiD des jeweiligen Jahres

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege.dta", clear

* Sortierung für Datenanalyse
sort id_hhpw


* Zweck generieren Hilfsvariablen: Wegzweck (W04)	 Spezifikation (W04_DZW)	Quelle (W01) 	Ziel (W13)

bysort id_hhpw: gen Zweck = "Arbeit" if W04 == 1 | W13 == 2
bysort id_hhpw: replace Zweck = "Bilden" if W04 == 3 | W04 == 31
bysort id_hhpw: replace Zweck = "Rundweg" if (W01 == 1 & W13 == 1) | W13 == 5
bysort id_hhpw: replace Zweck = "Wohnen" if W04[_n] == 8
bysort id_hhpw: replace Zweck = "Begleitung" if W04 == 11 | W04 == 6
bysort id_hhpw: replace Zweck = "Einkauf periodisch" if W04 == 4 & W04_DZW == 501
bysort id_hhpw: replace Zweck = "Einkauf aperiodisch" if W04 == 4 & W04_DZW != 501
bysort id_hhpw: replace Zweck = "Freizeit / Erledigung" if W04 == 7 | W04 == 5
bysort id_hhpw: replace Zweck = "Kindergarten" if W04 == 32
bysort id_hhpw: replace Zweck = "Sonstige" if W04 == 10 | W04 == .a| W04 == .g 
bysort id_hhpw: replace Zweck = Zweck[_n-2] if  W04 == 9 | _n>2

label var Zweck "ausgeführte Zielaktivität"


* Wegepaare generieren:
bysort id_hhpw: gen wegpaar = Zweck[_n-1]+" - "+Zweck[_n] if _n>0
bysort id_hhpw: replace wegpaar = "Wohnen"+" - "+Zweck[_n] if W01 == 1 |  (_n==1 & W01 == .a)
label var wegpaar "Aktivitätenpaare aus Hauptzwecken"
* Wegekette generieren:
bysort id_hhpw: gen wegekette = wegpaar[_n] if _n==1
bysort id_hhpw: replace wegekette = wegekette[_n-1]+" ; "+ wegpaar[_n] if _n>1
label var wegekette "Aktivitätenkette über den gesamten Tagesverlauf"
* Wegeketten generieren mit Wohnen als Heimbasis
bysort id_hhpw: gen wegekette_home = wegpaar[_n] if _n==1 | Zweck[_n-1] == "Wohnen"
bysort id_hhpw: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
label var wegekette_home "heimbasierte Aktivitätenkette"
