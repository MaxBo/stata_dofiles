version 10
capture log close
clear
set memory 800m
set more off
log using "$PW_workingdir\soep\proj\FS\st_fhs_11062009.log",replace


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
save "$PW_workingdir\soep\proj\FS\temp.dta", replace

***************************************************************************************************


/*
*/

use "$PW_workingdir\soep\proj\FS\temp.dta", clear
soep_intcens_fhspkw


save "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",replace
log close

***************************************************************************************************






****************************************************************************************************


set mem 800m
set more off
capture log close
log using "$PW_workingdir\soep\proj\FS\st_pkw_fs210609.log",replace

****************************************************************************************************
****************   Schätze parametrische Modelle für die einzelnen Zustände und Übergänge **********
****************************************************************************************************

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",clear
//lösche Jahre mit Missing Values der abhängigen Variablen
drop if fhs>=.
sort hhnrakt year agem
dropvars _merge
//local addvars dist_?z
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* `addvars ')

******* lösche missings ******************
drop if _merge==1
drop _merge
gen miss=0 if  wohn_typ<.& entfgrstadt<.& inf_shops<.& inf_doctor<.& inf_transit<. & wohn_quartier<.
drop if miss>=.


****************************************************************************

soep_genvar_spatial
soep_genvar_moved


******** Übergänge "Führerschein-Erwerb" *********

noi di "schätze Führerschein-Erwerb-Modell"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(fhs=2) origin(time 18) enter(fhs==0 3) exit(time .)
replace _st=0 if (fhs==1 | fhs==3)

soep_numfailures
gen nachabgabe = nf>=1&nf<.
sts graph ,surv by(entfgrstadt) tmax(20) xlabel(0(2)20) ylabel(0(.05)1, labsize(small) angle(0))
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))

soep_splitage,a18

/*
dropvars s h ch
stcox female pincln adult2 adult3  oc_* mixedneighb house_* city_* shop??,  nohr basehc(h) basesurv(s) basechazard(ch)

stcurve, surv range(0 30) at1(city_25_40=0 city_05_10=0 city_10_25=0  city_40_=0 shop10=1) /*
*/ at2(city_25_40=1 city_05_10=0 city_10_25=0  city_40_=0 house_deta=1) xlabel(0(5)30) ylabel(0(.05)1, labsize(small) angle(0))

stcurve, haz at1(city_25_40=0 city_05_10=0 city_10_25=0  city_40_=0 shop10=1) /*
*/ at2(city_25_40=1 city_05_10=0 city_10_25=0  city_40_=0 house_deta=1) xlabel(0(5)60) width(1)

*/

streg _age_* _fem_* pincln adult2 adult3 oc* mixedneighb house_* city_* shop?? notransit, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp,replace
streg _age_* _fem_* pincln adult2 adult3 oc* mixedneighb house_* city_* shop?? notransit nacha, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp_nachAbgabe,replace
soep_strejoin


******** Übergänge "Führerschein-Abgabe" *********

noi di "schätze Führerschein-Abgabe-Modell"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(fhs=3) origin(time 18) enter(fhs==1 2) exit(time .)
replace _st=0 if (fhs==0 | fhs==2)
sts graph ,surv by(female) tmax(70) xlabel(0(5)70) ylabel(0(.05)1, labsize(small) angle(0))

soep_numfailures
gen pkwimmer = pkw==31 | pkw==3
gen pkwzeitw = pkw==21 | pkw==2

soep_splitage

soep_genvar_oc_age

streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin

estimates save $PW_workingdir\soep\proj\FS\est\FS10exp,replace
streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* city_* shop?? pkwimmer pkwzeitw , dist(e) log nohr constr(100) collin

estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_pkw,replace

soep_strejoin


******** Übergänge "Pkw-Erwerb" *********


//12 13 nie -> zeitweise/immer
dropvars pkwpossible
gen pkwpossible = (pkw==1|pkw==21|pkw==31) & (fhs==1|fhs==2)

noi di "schätze Pkw-Erwerb-Modell nie->zeitweise"
stset agem ,id(persnr) failure(pkw=12) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=1 & pkw!=12 & pkw!=13) | (fhs==0 | fhs==2)
//stsum
//soep_numfailures

soep_splitage,a18
soep_genvar_oc_age

stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? doc*, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw12exp,replace
soep_strejoin


noi di "schätze Pkw-Erwerb-Modell nie->immer"
stset agem ,id(persnr) failure(pkw=13) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=1 & pkw!=12 & pkw!=13) | (fhs==0 | fhs==2)
//stsum
//soep_numfailures



streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? doc*, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw13exp,replace


dropvars s h ch
stcox female pincln adult2 adult3  oa_* mixedneighb house_*  city_* shop??  ,  nohr basehc(h) basesurv(s) basechazard(ch)

stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))

soep_strejoin


//21 23 zeitweise -> nie/immer
dropvars pkwpossible
gen pkwpossible = (pkw==2|pkw==12|pkw==32)

noi di "schätze Pkw-Erwerb-Modell zeitweise->immer"
stset agem ,id(persnr) failure(pkw=23) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=2 & pkw!=21 & pkw!=23)
stsum
soep_numfailures
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage,a18
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw23exp,replace



noi di "schätze Pkw-Abgabe-Modell zeitweise->nie"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(pkw=21) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=2 & pkw!=21 & pkw!=23)
stsum
soep_numfailures
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw21exp,replace


//31 32 immer -> nie/zeitweise
dropvars pkwpossible
gen pkwpossible = (pkw==3|pkw==13|pkw==23)

noi di "schätze Pkw-Erwerb-Modell immer->zeitweise"
stset agem ,id(persnr) failure(pkw=32) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)
stsum
soep_numfailures
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw32exp,replace

noi di "schätze Pkw-Abgabe-Modell immer->nie"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(pkw=31) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)
stsum
soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw31exp,replace
soep_strejoin

log close


noi di "schätze Pkw-Abgabe-Modell immer->/zeitweise oder nie"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(pkw=31 32) origin(time 18) enter(pkwpossible=1) exit(fhs=3 time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)

dropvars h s ch
stcox female pincln adult2 adult3  oc_* mixedneighb house_* city_* shop?? notransit,  nohr basehc(h) basesurv(s) basechazard(ch)
stcurve, surv at1(city_25_40=0 city_05_10=0 city_10_25=0  city_40_=0 shop10=1) at2(city_25_40=1 city_05_10=0 city_10_25=0  city_40_=0 house_deta=1) xlabel(0(5)60) ylabel(0(.1)1)





stset agem ,id(persnr) failure(pkwfs=12 13 ) origin(time 18) enter(pkw==1 21 31) exit(fhs==3 time .)
** setzt Episoden ohne Führerscheinbesitz auf _st=0 ***
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
sts graph ,hazard by(female)
*/

*** 12 kein FS -> kein Pkw *** 
stset agem ,id(persnr) failure(pkwfs=12) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage,a18
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS12exp,replace
soep_strejoin


*** 13 kein FS -> Pkw zeitweise ***
stset agem ,id(persnr) failure(pkwfs=13) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage,a18
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS13exp,replace
soep_strejoin


*** 14 kein FS-> Pkw immer *** 
stset agem ,id(persnr) failure(pkwfs=14) origin(time 18) enter(pkwfs==1 21 31 41) exit(time .)
replace _st=0 if (pkwfs!=1 & pkwfs != 12 & pkwfs !=13 & pkwfs !=14)
** Wenn Event, dann nimm an, dass es in der Mitte des beobachteten Intervalls stattgefunden hat ***
replace _t = _tt if _tt<. 
soep_splitage,a18
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS14exp,replace
soep_strejoin

********************************************************************************************
log close
********************************************************************************************



soep_plot_pkwfsgraph





log close