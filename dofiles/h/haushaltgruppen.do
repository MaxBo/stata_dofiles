clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2008_2006_HH.dta", clear


egen byte HHErwachsene=anycount(HPALTER?),values(18/120)
label var HHErwachsene "Anzahl Erwachsene im Haushalt"
gen byte HHErw03=recode(HHErwachsene,0,1,2,3)
label var HHErw03"Erwachsene (0,1,2,3+) im Haushalt"

egen byte HHKinder=anycount(HPALTER?),values(0/17)
label var HHKinder "Anzahl Kinder(0-17) im Haushalt"
gen byte HHKinder01=recode(HHErwachsene,0,1)
label var HHKinder01 "Kinder(0-17) im Haushalt"

egen byte HHKind0_5=anycount(HPALTER?),values(0/5)
label var HHKind0_5 "Kinder(0-5) im Haushalt"
egen byte HHKind6_13=anycount(HPALTER?),values(6/13)
label var HHKind6_13 "Kinder(6-13) im Haushalt"
egen byte HHKind14_17=anycount(HPALTER?),values(14/17)
label var HHKind14_17 "Jugendliche(14-17) im Haushalt"
egen HHKind6_17=anycount(HPALTER?),values(6/17)
label var HHKind6_17 "Kinder(6-17) im Haushalt"


egen HHKleinkind=anycount(HPBESCH?),values(7 8)
label var HHKleinkind "Kleinkinder im Haushalt"
egen HHSchueler=anycount(HPBESCH?),values(5)
label var HHSchueler "Sch�ler im Haushalt"
egen HHAzubi=anycount(HPBESCH?),values(4)
label var HHAzubi "Auszubildende im Haushalt"
egen HHStudent=anycount(HPBESCH?),values(6)
label var HHStudent "Studenten im Haushalt"
egen HHArbeitslos=anycount(HPBESCH?),values(9)
label var HHArbeitslos "Arbeitslose im Haushalt"
egen HHHaus_Frei=anycount(HPBESCH?),values(11 10)
label var HHHaus_Frei "Hausfrau/-mann und freigestellte im Haushalt"
egen HHRentner=anycount(HPBESCH?),values(12)
label var HHRentner "Rentner im Haushalt"
egen HHZivi=anycount(HPBESCH?),values(13)
label var HHZivi "Wehrdinstl./Zivis im Haushalt"
egen HHAzubiZiviStud=anycount(HPBESCH?),values(4 6 13)
label var HHAzubiZiviStud "Azubis/Studenten/Wehrdinstl./Zivis im Haushalt"
egen HHnichtErwAusb=anycount(HPBESCH?),values(4 5 9 10 11 12)
label var HHnichtErwAusb "Personen nicht erwerbst�tig oder in Ausbildung im Haushalt"
egen HHVollzeit=anycount(HPBESCH?),values(1)
label var HHVollzeit "Vollzeit-Besch�ftigte im Haushalt"
egen HHTeilzeit=anycount(HPBESCH?),values(2)
label var HHTeilzeit "Teilzeit-Besch�ftigte im Haushalt"


egen HHErwerb=anycount(HPBESCH?),values(1 2 3 4 14)
label var HHErwerb"Erwerbst�tige im Haushalt"
egen HHnErwerb=anycount(HPBESCH?),values(9 10 11 12)
label var HHnErwerb"Nicht-Erwerbst�tige im Haushalt"
gen float HHStellen = HHVollzeit + 0.5 * (HHTeilzeit + HHAzubi)
label var HHStellen "ganze Stellen im Haushalt"


* reshape long  HP_SEX HP_ALTER H021_ HPBESCH HPPKWFS, i(HHID) j(PID)
* HP_ALTER zu HPALTER und HPBESCH zu HPBESCH ???

