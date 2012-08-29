clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_attr.dta", clear

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
egen HHKind0_13=anycount(HPALTER?),values(0/13)
label var HHKind0_13 "Kinder(6-13) im Haushalt"

egen HHKleinkind=anycount(HPALTER?),values(0/5)
label var HHKleinkind "Kleinkinder im Haushalt"
egen HHSchueler=anycount(HPP_BESCH?),values(5)
label var HHSchueler "Schüler im Haushalt"
egen HHAzubi=anycount(HPP_BESCH?),values(4)
label var HHAzubi "Auszubildende im Haushalt"
egen HHStudent=anycount(HPP_BESCH?),values(6)
label var HHStudent "Studenten im Haushalt"
egen HHArbeitslos=anycount(HPP_BESCH?),values(9)
label var HHArbeitslos "Arbeitslose im Haushalt"
egen HHHaus_Frei=anycount(HPP_BESCH?),values(11 10)
label var HHHaus_Frei "Hausfrau/-mann und freigestellte im Haushalt"
egen HHRentner=anycount(HPP_BESCH?),values(12)
label var HHRentner "Rentner im Haushalt"
egen HHZivi=anycount(HPP_BESCH?),values(13)
label var HHZivi "Wehrdinstl./Zivis im Haushalt"
egen HHAzubiZiviStud=anycount(HPP_BESCH?),values(4 6 13)
label var HHAzubiZiviStud "Azubis/Studenten/Wehrdinstl./Zivis im Haushalt"
egen HHnichtErwAusb=anycount(HPP_BESCH?),values(4 5 9 10 11 12)
label var HHnichtErwAusb "Personen nicht erwerbstätig oder in Ausbildung im Haushalt"
egen HHVollzeit=anycount(BerufVoll?),values(1)
label var HHVollzeit "Vollzeit-Beschäftigte im Haushalt"
egen HHTeilzeit=anycount(BerufTeil?),values(1)
label var HHTeilzeit "Teilzeit-Beschäftigte im Haushalt"


egen HHErwerb=anycount(HPP_BESCH?),values(1 2 3 4 14)
label var HHErwerb"Erwerbstätige im Haushalt"
egen HHnErwerb=anycount(HPP_BESCH?),values(9 10 11 12)
label var HHnErwerb"Nicht-Erwerbstätige im Haushalt"
gen float HHStellen = HHVollzeit + 0.5*(HHTeilzeit + HHAzubi)
label var HHStellen "ganze Stellen im Haushalt"

forvalues i=1/8{
replace HHStelle = HHStelle - BerufVoll`i'*Azubi`i' - 0.5*BerufTeil`i'*Azubi`i' if (BerufVoll`i'==1 & Azubi`i'==1) | (BerufTeil`i'==1 & Azubi`i'==1)
}

gen HHGRue14 = H02-HHKind0_13
gen HHGR_gew = 1 + (HHGRue14 - 1)*0.5 +  HHKind0_13*0.3 if HHGRue14>0

mlogit HHEINK  HHGR_gew HHStellen HHKind0_13 HHRentner HHAzubiZiviStud  HHHaus_Frei [pwe=HH_GEW]

predict prob*
quietly tab HHEINK ,matrow(vars)
* local rows = rowsof(vars)
gen float cum=0
gen hheink_imp=.
gen float random=runiform()
forvalues i= 1/15 {
	replace cum = cum + prob`i' if prob`i' <.
	replace hheink_imp=vars[`i',1] if (HHEINK>=. & cum>=random & hheink_imp ==.)
	}
replace hheink_imp=HHEINK if (hheink_imp >=.)

label values hheink_imp HHEINK
drop cum random prob* 
* reshape long  HP_SEX HP_ALTER H021_ HPP_BESCH HPPKWFS, i(HHID) j(PID)
* HP_ALTER zu HPALTER und HPP_BESCH zu HPP_BESCH ???
