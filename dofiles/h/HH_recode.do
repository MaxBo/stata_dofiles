clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_HH.dta", clear

drop  H001C H0411*  H0412* H0413* H0414*  H0415* H041* H044* H045* H046* H047* H048* H049*  SWITCHER LOCALTYP LCSTATUS GEMNR

rename CASEID HHID
rename  GEW_HA HH_GEW
rename   BBRGRT  RTYP
rename  BBRDIFFT  RTYPD7

forvalues i=1/8{
	rename H`i'ALTER HPALTER`i'
	rename H`i'SEX HP_SEX`i'
	* rename H`i'taet taet`i'
	rename H`i'BERUF H021_`i'
	rename H`i'BESCH HPBESCH`i'
	rename H`i'FHS  HPPKWFS`i'
	}

forvalues i=1/8{
bysort HHID : replace HPBESCH`i' =  1 if H`i'TAET==1
bysort HHID : replace HPBESCH`i' =  2 if H`i'TAET==2
bysort HHID : replace HPBESCH`i' =  3 if H`i'TAET==3
bysort HHID : replace HPBESCH`i' =  4 if H`i'TAET==4
bysort HHID : replace HPBESCH`i' =  5 if H`i'TAET<4
bysort HHID : replace HPBESCH`i' =  6 if H`i'TAET==4
bysort HHID : replace HPBESCH`i' =  9 if H`i'TAET==5
bysort HHID : replace HPBESCH`i' =  10 if H`i'TAET==6
bysort HHID : replace HPBESCH`i' =  11 if H`i'TAET==7
bysort HHID : replace HPBESCH`i' =  12 if H`i'TAET==8
bysort HHID : replace HPBESCH`i' =  13 if H`i'TAET==9
bysort HHID : replace HPBESCH`i' =  14 if H`i'TAET==10
bysort HHID : replace HPBESCH`i' =  .a if missing(HPBESCH`i')

	}

sort HHID

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_HH2.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_HH.dta", clear
append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_HH2.dta"

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2008_2006_HH.dta", replace


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
label var HHSchueler "Schüler im Haushalt"
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
label var HHnichtErwAusb "Personen nicht erwerbstätig oder in Ausbildung im Haushalt"
egen HHVollzeit=anycount(HPBESCH?),values(1)
label var HHVollzeit "Vollzeit-Beschäftigte im Haushalt"
egen HHTeilzeit=anycount(HPBESCH?),values(2)
label var HHTeilzeit "Teilzeit-Beschäftigte im Haushalt"


egen HHErwerb=anycount(HPBESCH?),values(1 2 3 4 14)
label var HHErwerb"Erwerbstätige im Haushalt"
egen HHnErwerb=anycount(HPBESCH?),values(9 10 11 12)
label var HHnErwerb"Nicht-Erwerbstätige im Haushalt"
gen float HHStellen = HHVollzeit + 0.5 * (HHTeilzeit + HHAzubi)
label var HHStellen "ganze Stellen im Haushalt"


* reshape long  HP_SEX HP_ALTER H021_ HPBESCH HPPKWFS, i(HHID) j(PID)
* HP_ALTER zu HPALTER und HPBESCH zu HPBESCH ???
