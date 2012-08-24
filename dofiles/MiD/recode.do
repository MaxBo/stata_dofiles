local path= Y:\MiD-H\

run "Y:\MiD-H\Stata\P_Label_neu.do"
save "Y:\MiD-H\Stata\P_corr.dta",replace

run "Y:\MiD-H\Stata\HH_Label_neu.do"

label define eins 0 "0" 1 "1 und mehr" .y "Weiß nicht"
label define zwei 0 "0" 1 "1" 2 "2 und mehr" .y "Weiß nicht"
label define drei 0 "0" 1 "1" 2 "2" 3 "3 und mehr" .y "Weiß nicht"

* Haushaltsgröße
rename h01 Alleine //lebt alleine ?
rename h001c Unterlagen
rename h02 HHGroesse
recode Alleine (7=2) if HHGroesse >1 //verweigert
gen byte HHGr01=recode(HHGroesse,0,1) 
label var HHGr01 "Haushaltsgröße (0,1+)"
label values HHGr01 eins
gen byte HHGr02=recode(HHGroesse,0,1,2) 
label var HHGr02 "Haushaltsgröße (0,1,2+)"
label values HHGr02 zwei
gen byte HHGr03=recode(HHGroesse,0,1,2,3) 
label var HHGr03 "Haushaltsgröße (0,1,2,3+)"
label values HHGr03 drei

* Personenbezogene Daten ändern
forvalues i=1/8{
	rename h`i'alter alter`i'
	rename h`i'sex sex`i'
	rename h`i'taet taet`i'
	rename h`i'beruf beruf`i'
	rename h`i'besch besch`i'
	}
recode beruf? (.k .l = 0) // unter 15, über 65: nicht beruftstätig
recode besch? (.i .j .k=4) //unter 15, über 65 und Cati-Antworter: Nicht berufsttig
recode taet? (.j=4) (.i=12) (11=.z)
label define taet 13 "teilzeit berufstätig" 12 "vollzeit berufstätig", modify
save "Y:\MiD-H\Stata\HH_corr.dta",replace

use "Y:\MiD-H\Stata\HH_corr.dta",clear
keep caseid beruf? besch? alter? sex? taet? erwb? GEW_HA
rename GEW_HA gew_hb
reshape long alter sex taet erwb beruf besch, i(caseid) j(pid)
drop if (alter>. & alter<=.h) //lösche alle nicht existierenden Personen aus der Datenbank
label var alter "Alter"
label var sex "Geschlecht"
label var taet "Tätigkeit"
label var beruf "berufstätig?"
label var besch "Beschäftigung"
label var erwb "Erwerbstätigkeit"


merge caseid pid using "Y:\MiD-H\Stata\P_corr.dta", unique sort keep(p14 p17 p17s p18 p18s GEW_PA) nokeep
rename GEW_PA gew_pb
drop _merge
* Korrigiere personenbezogene Werte
recode erwb (3/9=1) if alter < 7
recode taet (4/12=1) if alter < 7
recode taet (1=8) if (alter > 17 & alter < 65)
recode taet (12=4) if besch ==3 //Tätigkeit: Azubi
recode taet (10=.z) if alter >30 //Ziwi mit 60 unrealistisch
recode besch (4=3) if taet ==4 //Beschäftigung: Azubi
recode besch (4=.z) if taet ==12 //unplausible Angaben zum Umfang der Berufstätigkeit
recode beruf (0=.z) if taet ==12 //unplausible Angaben zum Umfang der Berufstätigkeit
recode beruf (.h/.j=1) if taet==12 //Berufstätigkeit: ja
recode beruf (0 .h/.j=1) if taet==4 //Azubis sind berufstätig
recode taet (12=13)if besch==2 //Teilzeit

* Erwerbstätigkeit
label define erwb .a "keine Person" .z "Keine Angabe", modify

*Variablen umbenennen
rename p14 pSchAbschl
rename p17 pHauptBesch
rename p17s papiBesch
rename p18 pStellung
rename p18s papiStell

*Berufliche Stellung
replace pStellung=papiStell-1 if (papiStell>=2 & papiStell <= 13)
replace pStellung=13 if papiStell==1 
recode pStellung (12=.v)
replace pStellung=13 if (pSchAbschl >=7 & pSchAbschl<=15 & pStellung >=.)
label define p18 .v "sonstiges",add
recode pStellung (1 2 5 11=1) (3 6 9 10=2) (4 7 8=3) (12=.v) (13=.h) ,gen(stellung)
label var stellung "Berufliche Stellung"
label copy p18 stellung
label define stellung 1 "einfache Position" 2 "mittlere Position" 3 "höhere Position" .v "sonstiges" .h "noch nie berufstätig",modify
label values stellung stellung

* Tätigkeit
replace taet=1 if pSch==15
replace taet=2 if pSch==8
replace taet=3 if (pSch>=9 & pSch<=14 & alter>=9)
replace taet=3 if (pSch==7 & alter<=25)

*Bildung
recode pSch (1 2=1) (3 = 2) (4=3) (5 6=4) (7/15=5) (./.z=.a),gen(abschluss)
label define abschluss 1 "kein/HS" 2 "RS" 3 "FHS" 4 "Abi" 5 "noch (nicht) in Schule" .a "keine Angabe"
label values abschluss abschluss
label var abschluss "Schulabschluss"

save "Y:\MiD-H\Stata\HH_imp.dta",replace

*imputieren fehlender Werte für Personen
set more off
use "Y:\MiD-H\Stata\HH_imp.dta",clear
gen int alter2 = alter^2

*impute Alter
xi i.taet*i.sex ,noomit
uvis regress alter sex _ItaeXsex*,gen(alter_imp) match
uvis regress alter_imp _Itaet_*,gen(alter_imp2) match
replace alter=alter_imp2 if alter_imp2<.
drop alter_imp*
replace alter2 = alter^2

*impute sex
xi i.taet
uvis logit sex alter alter2 _Itaet_*,gen(sex_imp)
replace sex=sex_imp if sex_imp<.
drop sex_imp*

*impute Tätigkeit
xi i.sex*alter i.sex*alter2,noomit
mlogit taet _IsexXalter*
predict prob*
quietly tab taet ,matrow(vars)
local rows = rowsof(vars)
gen float cum=0
gen taet_imp=.
gen float random=runiform()
forvalues i= 1/`rows' {
	replace cum = cum + prob`i' if prob`i' <.
	replace taet_imp=vars[`i',1] if (taet>. & cum>=random & taet_imp ==.)
	}
replace taet=taet_imp if (taet>. & taet_imp <.)
drop cum random taet_imp prob* _I* 

*impute Stellung
xi i.taet i.pSchAbschl
mlogit pStellung alter alter2 sex _Itaet* _IpSch*
predict prob*
quietly tab pStellung ,matrow(vars)
local rows = rowsof(vars)
gen float cum=0
gen pStell_imp=.
gen float random=runiform()
forvalues i= 1/`rows' {
	replace cum = cum + prob`i' if prob`i' <.
	replace pStell_imp=vars[`i',1] if (pStellung>. & cum>=random & pStell_imp ==.)
	}
replace pStellung=pStell_imp if (pStellung>. & pStell_imp <.)
drop cum random pStell_imp prob* _I* 
save "Y:\MiD-H\Stata\HH_imp_Stellung.dta",replace

*impute Abschluss
use "Y:\MiD-H\Stata\HH_imp_Stellung.dta",clear
xi i.taet i.pStellung
mlogit abschluss alter alter2 sex _Itaet* _IpStell*
predict prob*
quietly tab abschluss ,matrow(vars)
local rows = rowsof(vars)
gen float cum=0
gen abschluss_imp=.
gen float random=runiform()
forvalues i= 1/`rows' {
	replace cum = cum + prob`i' if prob`i' <.
	replace abschluss_imp=vars[`i',1] if (abschluss>. & cum>=random & abschluss_imp ==.)
	}
replace abschluss=abschluss_imp if (abschluss>. & abschluss_imp <.)
drop cum random abschluss_imp prob* _I* 
drop pHauptBesch papi*
replace besch=taet
recode besch (1/3 5/9=4) (4=3) (10/12=1) (13=2) //Wehr&Zivis als Vollzeit gezählt
replace beruf=besch 
recode beruf (1/3=1) (4=0)
save "Y:\MiD-H\Stata\HH_imp_StellungAbschluss.dta",replace

use "Y:\MiD-H\Stata\HH_imp_StellungAbschluss.dta",clear
reshape wide alter sex taet erwb beruf besch pStellung stellung abschluss, i(caseid) j(pid)

* Anzahl Erwachsene, Führerscheininhaber, Kinder, Erwerbstätige etc. generieren
egen byte HHErwachsene=anycount(alter?),values(18/120)
label var HHErwachsene "Anzahl Erwachsene im Haushalt"
gen byte HHErw03=recode(HHErwachsene,0,1,2,3)
label var HHErw03"Erwachsene (0,1,2,3+) im Haushalt"

egen byte HHKinder=anycount(alter?),values(0/17)
label var HHKinder "Anzahl Kinder(0-17) im Haushalt"
gen byte HHKinder01=recode(HHErwachsene,0,1)
label var HHKinder01 "Kinder(0-17) im Haushalt"

egen byte HHKind0_5=anycount(alter?),values(0/5)
label var HHKind0_5 "Kinder(0-5) im Haushalt"
egen byte HHKind6_13=anycount(alter?),values(6/13)
label var HHKind6_13 "Kinder(6-13) im Haushalt"
egen byte HHKind14_17=anycount(alter?),values(14/17)
label var HHKind14_17 "Jugendliche(14-17) im Haushalt"
egen HHKind6_17=anycount(alter?),values(6/17)
label var HHKind6_17 "Kinder(6-17) im Haushalt"


egen HHKleinkind=anycount(taet?),values(1 2)
label var HHKleinkind "Kleinkinder im Haushalt"
egen HHSchueler=anycount(taet?),values(3)
label var HHSchueler "Schüler im Haushalt"
egen HHAzubi=anycount(taet?),values(4)
label var HHAzubi "Auszubildende im Haushalt"
egen HHStudent=anycount(taet?),values(5)
label var HHStudent "Studenten im Haushalt"
egen HHArbeitslos=anycount(taet?),values(6)
label var HHArbeitslos "Arbeitslose im Haushalt"
egen HHHaus_Frei=anycount(taet?),values(7 8)
label var HHHaus_Frei "Hausfrau/-mann und freigestellte im Haushalt"
egen HHRentner=anycount(taet?),values(9)
label var HHRentner "Rentner im Haushalt"
egen HHZivi=anycount(taet?),values(10)
label var HHZivi "Wehrdinstl./Zivis im Haushalt"
egen HHAzubiZiviStud=anycount(taet?),values(4 5 10)
label var HHAzubiZiviStud "Azubis/Studenten/Wehrdinstl./Zivis im Haushalt"
egen HHnichtErwAusb=anycount(taet?),values(6 7 8 9)
label var HHnichtErwAusb "Personen nicht erwerbstätig oder in Ausbildung im Haushalt"
egen HHVollzeit=anycount(taet?),values(12)
label var HHVollzeit "Vollzeit-Beschäftigte im Haushalt"
egen HHTeilzeit=anycount(taet?),values(13)
label var HHTeilzeit "Teilzeit-Beschäftigte im Haushalt"


egen HHErwerb=anycount(taet?),values(4 5 10 12 13)
label var HHErwerb"Erwerbstätige im Haushalt"
egen HHnErwerb=anycount(taet?),values(1 2 3 6 7 8 9)
label var HHnErwerb"Nicht-Erwerbstätige im Haushalt"
gen float HHStellen = HHVollzeit + 0.5 * (HHTeilzeit + HHAzubi)
label var HHStellen "ganze Stellen im Haushalt"


save "Y:\MiD-H\Stata\HH_demograph_imputed.dta",replace

use "Y:\MiD-H\Stata\HH_corr.dta",clear
keep caseid HHGroesse h?fhs hheink GEW_HA
sort caseid
merge caseid using "Y:\MiD-H\Stata\HH_demograph_imputed.dta",unique 
drop _merge

*xi: ologit hheink i.HHGroesse i.HHKleinkind i.HHSchueler i.HHArbeitslos i.HHStudent i.HHHaus_Frei i.HHRentner i.HHZivi i.HHVollzeit i.HHTeilzeit [pwe=GEW_HA]
*ologit hheink HHGroesse HHKleinkind HHSchueler HHArbeitslos HHStudent HHHaus_Frei HHRentner HHZivi HHVollzeit HHTeilzeit [pwe=GEW_HA]
mlogit hheink HHKleinkind HHSchueler HHArbeitslos  HHAzubiZiviStud HHHaus_Frei HHRentner HHVollzeit HHTeilzeit [pwe=GEW_HA]



predict prob*
quietly tab hheink ,matrow(vars)
local rows = rowsof(vars)
gen float cum=0
gen hheink_imp=.
gen float random=runiform()
forvalues i= 1/`rows' {
	replace cum = cum + prob`i' if prob`i' <.
	replace hheink_imp=vars[`i',1] if (hheink>=. & cum>=random & hheink_imp ==.)
	}
replace hheink_imp=hheink if (hheink_imp >=.)
label values hheink_imp eink
drop cum random prob* _I* 
save "Y:\MiD-H\Stata\HH_inc_dem_imputed.dta",replace


egen HHFhs=anycount(fhs?),values(1)
label var HHFhs "Pkw-Führerscheine im Haushalt"
gen byte HHFhs03=recode(HHFhs ,0,1,2,3)
label var HHFhs03 "Führerscheine (0,1,2,3+) im Haushalt"

* Pkw-Bezogene Daten ändern
forvalues i = 1/3 {
	rename h041_`i' Pkw`i'_Hersteller
	rename h0412_`i' Pkw`i'_Baujahr
	rename h0413_`i' Pkw`i'_Erwerbsjahr
	rename h044_`i' Pkw`i'_Hauptnutzer
	rename h045_`i' Pkw`i'_Nutzer
	rename h046_`i' Pkw`i'_Halter
	rename h047_`i' Pkw`i'_Zulassungsart
	rename h048_`i' Pkw`i'_Antriebsart
	rename h049_`i' Pkw`i'_PS_kW
	rename h0491_`i' Pkw`i'_PS
	rename h0492_`i' Pkw`i'_kW
	rename h0410_`i' Pkw`i'_Hubraum
	rename h0411_1`i' Stellplatz`i'_Garage
	rename h0411_2`i' Stellplatz`i'_am_Haus
	rename h0411_3`i' Stellplatz`i'_Naehe
	rename h0411_4`i' Stellplatz`i'_unterschiedlich
	rename h0414_`i' Pkw`i'_kmStand
	rename h0415_`i' Pkw`i'_kmJahr
	}
recode Pkw1_Hersteller Pkw2_Hersteller (.b=.c) (.a=.b)
label values Pkw1_Hersteller Pkw2_Hersteller Label_22
label drop Label_8
recode Pkw?_Hersteller (97=.x) (98=.y) (99=.z) 
label define Label_22 .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw?_Baujahr Pkw?_Erwerbsjahr Pkw?_Hubraum (99994=.w) (99997=.x) (99998=.y) (99999=.z) 
label define Label_9 .w "Wert unplausibel" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
label define Label_9 99994 "" 99997 "" 99998 "" 99999 "", modify
recode Pkw?_Hauptnutzer (7=.x) (8=.y) (9=.z) 
label define Label_10 .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw?_Nutzer (96=.w) (97=.x) (98=.y) (99=.z) 
label define Label_11 .w "Doppelnennung" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw?_Halter (6=.w) (7=.x) (8=.y) (9=.z) 
label define Label_12 .w "Doppelnennung" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw1_Zulassungsart Pkw1_Antriebsart(.a=.c)
label values Pkw1_Zulassungsart Label_20
label values Pkw1_Antriebsart Label_21
label drop Label_13 Label_14
recode Pkw?_Zulassungsart (7=.x) (8=.y) (9=.z) 
label define Label_20 .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw?_Antriebsart (6=.w) (7=.x) (8=.y) (9=.z) 
label define Label_21 .w "Doppelnennung" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw?_PS_kW (7=.x) (8=.y) (9=.z) 
label define Label_15 .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
recode Pkw?_PS Pkw?_kW (9994 = .w) (9997=.x) (9998=.y) (9999=.z) (-10=.d) (-3=.a) (-2=.b) (-1=.c)
label define Label_16 .w "Wert unplausibel" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe" .a "Nur zwei Pkws im HH" .b "Nur ein Pkw im HH" .c "Kein Pkw im HH" .d "CATI: PS/KW-Wert nicht berechenbar aufgr. fehlender Angaben", add
recode Pkw?_kmStand (9999997=.x) (9999998=.y) (9999999=.z) 
recode Pkw?_kmJahr (999997=.x) (999998=.y) (999999=.z) 
recode Stellplatz* (7=.x) (8=.y) (9=.z) 
label values Pkw?_kmStand Pkw?_kmJahr Stellplatz* Label_9

* generiere Stellplatz-Variablen aus Dummy-Variablen
tempvar _Stellplatz
forvalues i = 1/3 {
	egen byte _Stellplatz=anycount(Stellplatz`i'_*),values(1)
	gen byte Pkw`i'_Stellplatz = Stellplatz`i'_Garage if _Stellplatz == 0 //Missings übernehmen
	recode Pkw`i'_Stellplatz (0=.z) if _Stellplatz == 0 //keine Angabe
	replace Pkw`i'_Stellplatz = 1 if Stellplatz`i'_Garage ==1 & _Stellplatz ==1 
	replace Pkw`i'_Stellplatz = 2 if Stellplatz`i'_am_Haus ==1 & _Stellplatz ==1 
	replace Pkw`i'_Stellplatz = 3 if Stellplatz`i'_Naehe ==1 & _Stellplatz ==1 
	replace Pkw`i'_Stellplatz = 4 if (Stellplatz`i'_unterschiedlich ==1 & _Stellplatz ==1 ) | (_Stellplatz >1 & _Stellplatz <.) // unterschiedlich
	drop _Stellplatz
	label var Pkw`i'_Stellplatz "Stellplatz für Pkw `i'"
	} 
label define Stellplatz 1 "Garage" 2 "am Haus" 3 "in der Nähe" 4 "unterschiedlich" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe" .a "Nur zwei Pkws im HH" .b "Nur ein Pkw im HH" .c "Kein Pkw im HH"
label values Pkw?_Stellplatz Stellplatz


* Mobilitätswerkzeugbesitz
rename h04_1 HHFahrrad
recode HHFahrrad (998=.y)
gen byte Fahrrad03=recode(HHFahrrad,0,1,2,3)
label var Fahrrad03 "Fahrräder im Haushalt (0,1,2,3+)"
label values Fahrrad03 drei
rename h04_2 HHMofa
rename h04_3 HHPkw
gen byte HHPkw01=recode(HHPkw,0,1) 
label var HHPkw01 "Pkw im Haushalt (0,1+)"
label values HHPkw01 eins
gen byte HHPkw02=recode(HHPkw,0,1,2) 
label var HHPkw02 "Pkw im Haushalt (0,1,2+)"
label values HHPkw02 zwei
gen byte HHPkw03=recode(HHPkw,0,1,2,3) 
label var HHPkw03 "Pkw im Haushalt (0,1,2,3+)"
label values HHPkw03 drei
rename h04_4 HHLkw_klein
rename h04_5 HHLkw_gross
rename h04_6 HHLkw_ges
egen HHKfz = anymatch(HHMofa HHPkw HHLkw_ges),values(1/100)
label var HHKfz "Kfz im Haushalt (0,1+)"
label values HHKfz eins

*Wohnlage
rename h05 Wohnlage
recode Wohnlage (6=.w) (7=.x) (8=.y) (9=.z) 
label define Label_24 .w "Doppelnennung" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add

* Technische Geräte
rename h06_1 Telefon
rename h06_2 Handy
rename h06_3 Computer
rename h06_4 Internet
recode Telefon Handy Computer Internet (-70=.a)
label define Label_25 .a "In CATI nicht erhoben", add
egen HandyInternet = anymatch(Handy Computer Internet),values(1)
label var HandyInternet "Handy, Computer und/oder Internet" 
label values HandyInternet Label_25
drop h06_5 h06_7 h06_8

* Einkommen
recode hheink (96=.w) (97=.x) (98=.y) (99=.z) 
label define Label_36 .w "Doppelnennung" .x "Verweigert" .y "Weiß nicht" .z "Keine Angabe", add
drop h07*

set more on




