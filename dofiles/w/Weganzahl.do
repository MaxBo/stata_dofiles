* Anzahl Wege geniereren

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege.dta", clear

* Sortierung für Datenanalyse
sort HHID PID WSID

* Anzahl Wege geniereren
bysort HHID PID: gen Anz_Wege=_N
label var Anz_Wege "Anzahl der Wege je Person und Tag"