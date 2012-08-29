clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_wegattr2.dta", clear
* drop OEK_STAT
merge HHID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_attr2.dta", uniqusing sort keep(OEK_STAT_neu OEK_STAT_1 OEK_STAT_2 OEK_STAT_3 OEK_STAT_4 OEK_STAT_5 HHErwachsene HHErw03 HHKind* HHKleinkind HHSchueler HHAzubi HHStudent HHArbeitslos HHHaus_Frei HHRentner HHZivi HHAzubiZiviStud HHnichtErwAusb HHVollzeit HHTeilzeit HHErwerb HHnErwerb HHStellen HHGRue14 HHGR_gew hheink_imp mittlEink aeqEink)

drop _merge
