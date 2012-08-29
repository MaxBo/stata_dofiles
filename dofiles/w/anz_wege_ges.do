
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", clear
sort HHID PID

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Personen.dta", clear
sort HHID PID

merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", uniqmaster sort keep(Anz_Wege aktzeit_gesamt fahrzeit_gesamt bearbeitet)


gen Anz_Wege_ges = Anz_Wege
replace Anz_Wege_ges = Anz_Wege + W12 if Anz_Wege > 0 & W12!=.a

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Personen_neu.dta", replace


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_zeitn5_akt.dta", clear
sort HHID PID

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Personen.dta", clear
rename caseid HHID
rename pid PID
rename w12 W12
sort HHID PID

merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_zeitn5_akt.dta", uniqmaster sort keep(Anz_Wege aktzeit_gesamt fahrzeit_gesamt bearbeitet)


gen Anz_Wege_ges = Anz_Wege
replace Anz_Wege_ges = Anz_Wege + W12 if Anz_Wege > 0 & W12!=.b

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Personen_neu.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn5_akt.dta", clear
sort HHID PID

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Personen.dta", clear
rename caseid HHID
rename pid PID
rename w12 W12
sort HHID PID

merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Wege_zeitn5_akt.dta", uniqmaster sort keep(Anz_Wege aktzeit_gesamt fahrzeit_gesamt bearbeitet)


gen Anz_Wege_ges = Anz_Wege
replace Anz_Wege_ges = Anz_Wege + W12 if Anz_Wege > 0 & W12!=.*
* replace Anz_Wege_ges = Anz_Wege + W12 if Anz_Wege > 0 & (W12!=.b |W12!=.r |W12!=.s |W12!=.t |W12!=.u)
* noch zu prüfen!!!
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2002\MiD_2002_Personen_neu.dta", replace