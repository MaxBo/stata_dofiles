* Do-File zur Generierung von Wegeketten
* Grobes Modell zur Bestimmung von vereinfachten Wegeaktivitäten, Wegepaaren und allgemeine und heimbasierte Ketten
* Eingangsdaten - MiD des jeweiligen Jahres
* Aktivitäten sind Wohnen, Arbeiten, Einkaufen (per) und Sonstiges

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5.dta", clear





* Sortierung für Datenanalyse
sort HHID PID WSIDN


* Zweck generieren Hilfsvariablen: Wegzweck (W04)	 Spezifikation (W04_DZW)	Quelle (W01) 	Ziel (W13)

bysort HHID PID: gen Zweck = "Arbeit" if W04 == 1 | W13 == 2
bysort HHID PID: replace Zweck = "dienstlich per" if WSID > 100
bysort HHID PID: replace Zweck = "dienstlich aper" if W04 == 2 & WSID < 100
bysort HHID PID: replace Zweck = "Bilden" if W04 == 3 | W04 == 31
bysort HHID PID: replace Zweck = "Kindergarten" if W04 == 32 | W04 == 31
bysort HHID PID: replace Zweck = "Rundweg" if (W01 == 1 & W13 == 1) | W13 == 5
bysort HHID PID: replace Zweck = "Wohnen" if W04 == 8 | W13 == 1
bysort HHID PID: replace Zweck = "Einkauf periodisch" if W04 == 4 & W04_DZW == 501
bysort HHID PID: replace Zweck = "Einkauf aperiodisch" if W04 == 4 & W04_DZW != 501


bysort HHID PID: replace Zweck = "Sonstige" if (W04 > 4 & W04 < 8)| (W04 >9 & W04 < 30)| W04 == .a| W04 == .g | W04 == .f
bysort HHID PID: replace Zweck = "Rückweg" if  W04 == 9

label var Zweck "ausgeführte Zielaktivität"


* Wegepaare generieren:
bysort HHID PID:gen wegpaar = Zweck[_n-1]+" - "+Zweck[_n]
bysort HHID PID:replace wegpaar = "Wohnen"+" - "+Zweck[_n] if _n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101))
bysort HHID PID:replace wegpaar = "Sonstige"+" - "+Zweck[_n] if W01 > 2 & WSIDN[_n]==1
bysort HHID PID:replace wegpaar = "Arbeit"+" - "+Zweck[_n] if W01 ==2 & WSIDN==1 
bysort HHID PID:replace wegpaar = "Arbeit"+" - "+Zweck[_n] if (W01 > 1 | W01 <5) & WSIDN==1 & W13 == 1 & HWZWECK ==1 
bysort HHID PID:replace wegpaar = "Bilden"+" - "+Zweck[_n] if (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 & HWZWECK ==3
bysort HHID PID:replace wegpaar = "Sonstige"+" - "+Zweck[_n] if (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 & HWZWECK ==6
label var wegpaar "Aktivitätenpaare aus Hauptzwecken"

* Wegekette generieren:
bysort HHID PID: gen wegekette = wegpaar[_n] if _n==1
bysort HHID PID: replace wegekette = wegekette[_n-1]+" ; "+ wegpaar[_n] if _n>1
label var wegekette "Aktivitätenkette über den gesamten Tagesverlauf"

* Wegeketten generieren mit Wohnen als Heimbasis
bysort HHID PID: gen wegekette_home = wegpaar[_n] if _n==1 | Zweck[_n-1] == "Wohnen"
bysort HHID PID: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
label var wegekette_home "heimbasierte Aktivitätenkette"

* Zusatz: Aktivitäten- und Fahrzeitsumme für eine Person an einem Tag
bysort HHID PID: gen fahrzeit_gesamt = zeitsummefahr[_N]
bysort HHID PID: gen aktzeit_gesamt = zeitsummeakt[_N]

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", replace
