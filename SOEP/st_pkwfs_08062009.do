version 10
capture log close
clear
set memory 800m
set more off
log using "$PW_workingdir\soep\proj\FS\st_fhs_08062009.log",replace


*****************Lade Rohdaten und joine demographische Daten an *****************
use "$PW_workingdir\soep\proj\Monat\Monat-custom.dta", clear 

quietly {
keep(persnr year hhnrakt hhnr gebjahr gebmonat monatinterv female mar /*
*/ heink_korr hinc_2007 pequivinc eqnpers eqnkids eqnpers0014 eqnpers1518 /*
*/ hpers0_1 hpers2_4 hpers5_7 hpers8_10 hpers11_12 hpers13_15 )

noi di "merge Längsschnittsgewichte zum Datensatz "
merge persnr year using "$PW_workingdir\soep\proj\PGew.dta", uniqusing nokeep sort  
drop _merge

noi di "merge Beschäftigungs-Variablen"
merge persnr year using "$PW_workingdir\soep\proj\employment\employment-custom.dta", /*
*/ uniqusing nokeep sort keep(unifhs taetig arbeitslos empstat jobchanged edu3 yrsed ) 
drop _merge

noi di "merge Variablen zur Führerschein- und Pkw-Verfügbareit"
merge persnr year using "$PW_workingdir\soep\proj\FS\FS-custom.dta", uniqusing nokeep sort  /*
*/ keep( ppkwverf hpkw01 hpkw012 hpkw04 hpkw_gekauft hmotorrad  hmotorrad_gekauft /*
*/ pfhs pfhsmoped pfhsmotrad pfhspkw pfhslkw povzeitk pbahncard pautobegeist povungern pfreizuhaus pumweltbew /*
*/ fahrzeug*) /* h2353x h2359x h2365x h2371x) */
sort persnr year

*** sortiere die Variablen im Datensatz ***
order hhnr hhnrakt persnr year  pgew pgew1 gebjahr gebmonat monatinterv female mar eqnpers eqnkids eqnpers0014 eqnpers1518 hpers0_1 hpers2_4  hpers5_7 hpers8_10 hpers11_12 hpers13_15 /*
*/ heink_korr hinc_2007 pequivinc taetig empstat jobchanged unifhs arbeitslos jobchanged edu3 yrsed /*
*/ hpkw01 hpkw012 hpkw04 hpkw_gekauft hmotorrad hmotorrad_gekauft ppkwverf pfhs pfhsmoped pfhsmotrad pfhspkw pfhslkw povzeitk  pbahncard /*
*/ pautobegeist povungern pfreizuhaus pumweltbew

*****************Berechne monatsgenaues Alter agem *********************************

noi di "berechne monatsgenaues Alter agem"
// codiere den Monat um
recode gebjahr (-1=.a)
recode gebmonat (-1=.a) (-3=.c)
gen float agem = year-gebjahr 
// Wenn Monat des Interviews unbekannt - gehe von März aus
replace monatinterv = 3 if monatinterv >=.
// Wenn Geburtsmonat des Interviews unbekannt - gehe von Juni aus
replace gebmonat = 6 if gebmonat >=.
//Wenn Geburtstag nach Befragung, oder wenn Geburtsmonat unbekannt 
//und Befragungsmonat in der 1. Jahreshälfte oder unbekannt und Alter > 0
replace gebmonat = monatinterv-1 if age==0 & gebmonat >= monatinterv 
replace agem = agem + (monatinterv - gebmonat)/12
label var agem "Alter"

// Personen ohne Alter/Geburtsjahr machen keinen Sinn bei der Auswertung
drop if agem >=.

**************************** setze Pkw- und Führerscheinbesitz für Kinder auf 0 *********************

*** imputiere Führerscheinbesitz aus Pkw-Verfügbarkeit ***
// wenn Pkw-Verfügbarkeit, dann auch Pkw-Führerschein
replace pfhspkw=1 if ppkwverf==1 | ppkwverf==2 
// wenn Pkw-Verfügbarkeit, dann auch Führerschein
replace pfhs=1 if ppkwverf==1 | ppkwverf==2 
// kein Führerschein und Auto unter 18
replace pfhs=0 if agem <18 
replace pfhspkw=0 if agem <18 
replace ppkwverf=0 if agem <18 


****************** bereinige Daten zum Führerscheinbesitz *******************************************
//nimm Pkw-Führerschein und gehe in 1995 davon aus, dass die Frage als Frage nach Pkw-Führerschein interpretiert wurde
noi di "generiere Führerschein-Variable"
recode pfhspkw (.e=1),gen(fhs)
label copy tp685x_DE l_pfhs
label values fhs l_pfhs
label var fhs "Führerschein"
// wer Lkw fahren darf, darf auch Pkw fahren
replace fhs=1 if pfhslkw==1

********** Annahme: keine Veränderung des Führerscheinbesitzes, wenn Daten vor und nach dem missing gleich sind *******
noi di "imputiere Führerschein bei gleichem Führerscheinbesitz vor und nach dem missing"
// imputiere vorwärts
gen fhsimpforw = fhs
sort persnr year
by persnr: replace fhsimpforw  = fhsimpforw[_n-1] if fhsimpforw>=.
// imputiere rückwärts
gen fhsimpbackw = fhs
gsort persnr -year
by persnr: replace fhsimpbackw = fhsimpbackw[_n-1] if fhsimpbackw>=.
// wenn beim nach oben und nach unten erweitern für einen missing das gleich rauskommt, dann übernimm diesen Wert
replace fhs=fhsimpforw if fhs>=. & fhsimpforw==fhsimpbackw
dropvars fhsimpforw fhsimpbackw


************* bilde Variable pkwfs ********************
noi di "generiere Führerschein/Pkw-Variable"
recode ppkwverf (0=2) (1=3) (2=4),gen(pkwfs)
label define l_pkwfs 1 "kein Führerschein" 2 "Pkw nie, FHS" 3 "Pkw zeitweise" 4 "Pkw immer" .f "Pkw nie, FS unbekannt" .a "keine Angabe"
label var pkwfs "Pkw/Führerschein"
label values pkwfs l_pkwfs
recode pkwfs (2=.f) if year==1997|year==2000|year==2002|year==2005|year==2007|fhs>=.
replace pkwfs = 1 if fhs==0
recode pkwfs (.f=2) if fhs==1

}

***************************************************************************************************

soep_impute_fhs

save "$PW_workingdir\soep\proj\FS\FS-pkwfsfilled.dta",replace
***************************************************************************************************






****************************************************************************************************


set mem 800m
set more off
capture log close
log using "$PW_workingdir\soep\proj\FS\st_pkwfs220409.log",replace

****************************************************************************************************
****************   Schätze parametrische Modelle für die einzelnen Zustände und Übergänge **********
****************************************************************************************************

use "$PW_workingdir\soep\proj\FS\FS-pkwfsfilled.dta",clear
//lösche Jahre mit Missing Values der abhängigen Variablen
drop if pkwfs>=.
sort hhnrakt year
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* pollu* nogreen crime)

******* lösche missings ******************
drop if _merge==1
drop _merge
gen miss=0 if  wohn_typ<.& entfgrstadt<.& inf_shops<.& inf_doctor<.& inf_transit<. & wohn_quartier<.
drop if miss>=.



****************************************************************************

soep_genvar_spatial
soep_genvar_moved


******** Übergänge von "kein Führerschein" *********

soep_stgew pgew,failure(pkwfs=12 13 14) enter(pkwfs==1 21 31 41)
// genieriere Event-Zeitpunkt in der Mitte des intervall-zensierten Zeitraums
gen _tt = _t0+(_t-_t0)/2 if _d==1


/*
//12 13 14 kein FS -> Führerschein
stset agem [pw=pgew2],id(persnr) failure(pkwfs=12 13 14) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
** setzt Episoden ohne Führerscheinbesitz auf _st=0 ***
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
sts graph ,hazard by(female)
*/

*** 12 kein FS -> kein Pkw *** 
stset agem [pw=pgew2],id(persnr) failure(pkwfs=12) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1819
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS12exp,replace
soep_strejoin


*** 13 kein FS -> Pkw zeitweise ***
stset agem [pw=pgew2],id(persnr) failure(pkwfs=13) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1819
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS13exp,replace
soep_strejoin


*** 14 kein FS-> Pkw immer *** 
stset agem [pw=pgew2],id(persnr) failure(pkwfs=14) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1819
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS14exp,replace
soep_strejoin


******** Übergänge von "Pkw nie, mit Führerschein" *********

soep_stgew pgew,failure(pkwfs=21 23 24) enter(pkwfs==2 12 32 42)
// genieriere Event-Zeitpunkt in der Mitte des intervall-zensierten Zeitraums
gen _tt = _t0+(_t-_t0)/2 if _d==1

/*
//21 23 24 FS, Pkw nie -> alle anderen
stset agem [pw=pgew2],id(persnr) failure(pkwfs=21 23 24) origin(time 18) enter(pkwfs==2 12 32 42) exit(time .)
replace _st=0 if (pkwfs!=2 & pkwfs != 21 & pkwfs !=23 & pkwfs !=24)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
sts graph,hazard by(female)
*/

//21 kein Pkw, Führerschein-Abgabe
stset agem [pw=pgew2],id(persnr) failure(pkwfs=21) origin(time 18) enter(pkwfs==2 12 32 42) exit(time .)
replace _st=0 if (pkwfs!=2 & pkwfs != 21 & pkwfs !=23 & pkwfs !=24)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS21exp,replace
soep_strejoin


//23 keim Pkw mit FS -> Pkw zeitweise
stset agem [pw=pgew2],id(persnr) failure(pkwfs=23) origin(time 18) enter(pkwfs==2 12 32 42) exit(time .)
replace _st=0 if (pkwfs!=2 & pkwfs != 21 & pkwfs !=23 & pkwfs !=24)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1819
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS23exp,replace
soep_strejoin


//24 kein Pkw mit FS-> Pkw immer
stset agem [pw=pgew2],id(persnr) failure(pkwfs=24) origin(time 18) enter(pkwfs==2 12 32 42) exit(time .)
replace _st=0 if (pkwfs!=2 & pkwfs != 21 & pkwfs !=23 & pkwfs !=24)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1819
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS24exp,replace
soep_strejoin


******** Übergänge von "Pkw zeitweise" *********

soep_stgew pgew,failure(pkwfs=31 32 34) enter(pkwfs==3 13 23 43)
// genieriere Event-Zeitpunkt in der Mitte des intervall-zensierten Zeitraums
gen _tt = _t0+(_t-_t0)/2 if _d==1

/*
//31 32 34 Pkw zeitweise -> alle anderen
stset agem ,id(persnr) failure(pkwfs=31 32 34) origin(time 18) enter(pkwfs==3 13 23 43) exit(time .)
replace _st=0 if (pkwfs!=3 & pkwfs != 31 & pkwfs !=32 & pkwfs !=34)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
sts graph,hazard by(female)
*/

//31 Pkw zeitweise -> Führerschein-Abgabe
stset agem [pw=pgew2],id(persnr) failure(pkwfs=31) origin(time 18) enter(pkwfs==3 13 23 43) exit(time .)
replace _st=0 if (pkwfs!=3 & pkwfs != 31 & pkwfs !=32 & pkwfs !=34)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS31exp,replace
soep_strejoin

//32 Pkw zeitweise -> Pkw nie, mit FS
stset agem [pw=pgew2],id(persnr) failure(pkwfs=32) origin(time 18) enter(pkwfs==3 13 23 43) exit(time .)
replace _st=0 if (pkwfs!=3 & pkwfs != 31 & pkwfs !=32 & pkwfs !=34)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS32exp,replace
soep_strejoin


//34 Pkw zeitweise -> Pkw immer
stset agem [pw=pgew2],id(persnr) failure(pkwfs=34) origin(time 18) enter(pkwfs==3 13 23 43) exit(time .)
replace _st=0 if (pkwfs!=3 & pkwfs != 31 & pkwfs !=32 & pkwfs !=34)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS34exp,replace
soep_strejoin


******** Übergänge von "Pkw immer" *********

soep_stgew pgew,failure(pkwfs=41 42 43) enter(pkwfs==4 14 24 44)
// genieriere Event-Zeitpunkt in der Mitte des intervall-zensierten Zeitraums
gen _tt = _t0+(_t-_t0)/2 if _d==1

/*
//41 42 43 Pkw immer -> alle anderen
stset agem ,id(persnr) failure(pkwfs=41 42 43) origin(time 18) enter(pkwfs==4 14 24 44) exit(time .)
replace _st=0 if (pkwfs!=4 & pkwfs != 41 & pkwfs !=42 & pkwfs !=43)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
sts graph,hazard by(female)
*/

//41 Pkw immer -> Führerschein-Abgabe
stset agem ,id(persnr) failure(pkwfs=41) origin(time 18) enter(pkwfs==4 14 24 44) exit(time .)
replace _st=0 if (pkwfs!=4 & pkwfs != 41 & pkwfs !=42 & pkwfs !=43)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS41exp,replace
soep_strejoin



//42 Pkw immer -> Pkw nie, mit FS
stset agem ,id(persnr) failure(pkwfs=42) origin(time 18) enter(pkwfs==4 14 24 44) exit(time .)
replace _st=0 if (pkwfs!=4 & pkwfs != 41 & pkwfs !=42 & pkwfs !=43)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS42exp,replace
soep_strejoin


//43 Pkw immer -> Pkw zeitweise
stset agem ,id(persnr) failure(pkwfs=43) origin(time 18) enter(pkwfs==4 14 24 44) exit(time .)
replace _st=0 if (pkwfs!=4 & pkwfs != 41 & pkwfs !=42 & pkwfs !=43)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage1825
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr
estimates save $PW_workingdir\soep\proj\FS\est\FS43exp,replace
soep_strejoin

********************************************************************************************
log close
********************************************************************************************



soep_plot_pkwfsgraph





log close