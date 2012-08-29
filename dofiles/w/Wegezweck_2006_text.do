* Do-File zur Generierung von Wegezwecken
* Eingangsdaten - MiD des jeweiligen Jahres


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege.dta", clear

* Sortierung für Datenanalyse
sort  id_hhpw

* Zweck generieren Hilfsvariablen: 
* Wegzweck (W04) Spezifikation (W041) Quelle (W01) Ziel (W13)

bysort id_hhp: gen Zweck = "Arbeit" if W04 == 1 | W13 == 2
bysort id_hhp: replace Zweck = "Bilden" if W04 == 3 | W04 == 31
bysort id_hhp: replace Zweck = "Rundweg" if (W01 == 1 & W13 == 1) | W13 == 5
bysort id_hhp: replace Zweck = "Wohnen" if W04[_n] == 8
bysort id_hhp: replace Zweck = "Begleitung" if W04 == 11 | W04 == 6
bysort id_hhp: replace Zweck = "Einkauf periodisch" if W04 == 4 & W041 == 501
bysort id_hhp: replace Zweck = "Einkauf aperiodisch" if W04 == 4 & W041 != 501
bysort id_hhp: replace Zweck = "Freizeit / Erledigung" if W04 == 7 | W04 == 5
bysort id_hhp: replace Zweck = "Kindergarten" if W04 == 32
bysort id_hhp: replace Zweck = "Sonstige" if W04 == 10 | W04 == .a| W04 == .g 
bysort id_hhp: replace Zweck = Zweck[_n-2] if  W04 == 9 | _n>2


