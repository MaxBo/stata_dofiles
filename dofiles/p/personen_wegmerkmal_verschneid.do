clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_9_4.dta", clear

keep HHID PID werktag Anz_Arbeit Anz_zurArbeit Anz_Eink_per Anz_Eink_aper Anz_Eink_b Anz_Eink Anz_Bilden Anz_KiGa Anz_Begl  Anz_Wege fahrzeit_gesamt aktzeit_gesamt arbeitszeit

duplicates drop
sort HHID PID
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_9_PInfo.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen.dta", clear
drop bearbeitet
duplicates drop
sort HHID PID

merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_9_PInfo.dta", uniqmaster keep(werktag Anz_Arbeit Anz_zurArbeit Anz_Eink_per Anz_Eink_aper Anz_Eink_b Anz_Eink Anz_Bilden Anz_KiGa Anz_Begl  Anz_Wege fahrzeit_gesamt aktzeit_gesamt arbeitszeit) _merge(mobil_gepr)

gen exclude=arbeitszeit<0

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_wegattr.dta", replace
