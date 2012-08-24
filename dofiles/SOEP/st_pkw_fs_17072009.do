version 10
capture log close
clear
set memory 800m
set more off
log using "$PW_workingdir\soep\proj\FS\st_fhs_15072009.log",replace


*****************Lade Rohdaten und joine demographische Daten an *****************
use "$PW_workingdir\soep\proj\Monat\Monat-custom.dta", clear 

quietly {
recode female (2=1) (1=0) (-1=.a)
label define xsex 0 "m�nnlich" 1 "weiblich" .a "keine Angabe",modify
keep(persnr year hhnrakt hhnr gebjahr gebmonat monatinterv female mar /*
*/ heink_korr hinc_2007 pequivinc eqnpers eqnkids eqnpers0014 eqnpers1518 /*
*/ hpers0_1 hpers2_4 hpers5_7 hpers8_10 hpers11_12 hpers13_15 )

noi di "merge L�ngsschnittsgewichte zum Datensatz "
merge persnr year using "$PW_workingdir\soep\proj\PGew.dta", uniqusing nokeep sort  
drop _merge

noi di "merge Besch�ftigungs-Variablen"
merge persnr year using "$PW_workingdir\soep\proj\employment\employment-custom.dta", /*
*/ uniqusing nokeep sort keep(unifhs taetig arbeitslos empstat jobchanged edu3 yrsed ) 
drop _merge

noi di "merge Variablen zur F�hrerschein- und Pkw-Verf�gbareit"
merge persnr year using "$PW_workingdir\soep\proj\FS\FS-custom.dta", uniqusing nokeep sort  /*
*/ keep( ppkwverf hpkw01 hpkw012 hpkw04 hpkw_gekauft hmotorrad  hmotorrad_gekauft /*
*/ pfhs pfhsmoped pfhsmotrad pfhspkw pfhslkw povzeitk pbahncard pautobegeist povungern pfreizuhaus pumweltbew /*
*/ fahrzeug*) /* h2353x h2359x h2365x h2371x) */
sort persnr year

*** sortiere die Variablen im Datensatz ***
order hhnr hhnrakt persnr year  pgew pgew1 gebjahr gebmonat monatinterv female mar /*
*/ eqnpers eqnkids eqnpers0014 eqnpers1518 hpers0_1 hpers2_4  hpers5_7 hpers8_10 hpers11_12 hpers13_15 /*
*/ heink_korr hinc_2007 pequivinc taetig empstat jobchanged unifhs arbeitslos jobchanged edu3 yrsed /*
*/ hpkw01 hpkw012 hpkw04 hpkw_gekauft hmotorrad hmotorrad_gekauft /*
*/ ppkwverf pfhs pfhsmoped pfhsmotrad pfhspkw pfhslkw povzeitk  pbahncard /*
*/ pautobegeist povungern pfreizuhaus pumweltbew

*****************Berechne monatsgenaues Alter agem *********************************

noi di "berechne monatsgenaues Alter agem"
// codiere den Monat um
recode gebjahr (-1=.a)
recode gebmonat (-1=.a) (-3=.c)
gen float agem = year-gebjahr 
// Wenn Monat des Interviews unbekannt - gehe von M�rz aus
replace monatinterv = 3 if monatinterv >=.
// Wenn Geburtsmonat des Interviews unbekannt - gehe von Juni aus
replace gebmonat = 6 if gebmonat >=.
//Wenn Geburtstag nach Befragung, oder wenn Geburtsmonat unbekannt 
//und Befragungsmonat in der 1. Jahresh�lfte oder unbekannt und Alter > 0
replace gebmonat = monatinterv-1 if age==0 & gebmonat >= monatinterv 
replace agem = agem + (monatinterv - gebmonat)/12
label var agem "Alter"

// Personen ohne Alter/Geburtsjahr machen keinen Sinn bei der Auswertung
drop if agem >=.

**************************** setze Pkw- und F�hrerscheinbesitz f�r Kinder auf 0 *********************

*** imputiere F�hrerscheinbesitz aus Pkw-Verf�gbarkeit ***
// wenn Pkw-Verf�gbarkeit, dann auch Pkw-F�hrerschein
replace pfhspkw=1 if ppkwverf==1 | ppkwverf==2 
// wenn Pkw-Verf�gbarkeit, dann auch F�hrerschein
replace pfhs=1 if ppkwverf==1 | ppkwverf==2 
// kein F�hrerschein und Auto unter 18
replace pfhs=0 if agem <18 
replace pfhspkw=0 if agem <18 
replace ppkwverf=0 if agem <18 


****************** bereinige Daten zum F�hrerscheinbesitz *******************************************
//nimm Pkw-F�hrerschein und gehe in 1995 davon aus, dass die Frage als Frage nach Pkw-F�hrerschein interpretiert wurde
noi di "generiere F�hrerschein-Variable"
recode pfhspkw (.e=1),gen(fhs)
label copy tp685x_DE l_pfhs
label values fhs l_pfhs
label var fhs "F�hrerschein"
// wer Lkw fahren darf, darf auch Pkw fahren
replace fhs=1 if pfhslkw==1

********** Annahme: keine Ver�nderung des F�hrerscheinbesitzes, wenn Daten vor und nach dem missing gleich sind *******
noi di "imputiere F�hrerschein bei gleichem F�hrerscheinbesitz vor und nach dem missing"
// imputiere vorw�rts
gen fhsimpforw = fhs
sort persnr year
by persnr: replace fhsimpforw  = fhsimpforw[_n-1] if fhsimpforw>=.
// imputiere r�ckw�rts
gen fhsimpbackw = fhs
gsort persnr -year
by persnr: replace fhsimpbackw = fhsimpbackw[_n-1] if fhsimpbackw>=.
// wenn beim nach oben und nach unten erweitern f�r einen missing das gleich rauskommt, dann �bernimm diesen Wert
replace fhs=fhsimpforw if fhs>=. & fhsimpforw==fhsimpbackw
dropvars fhsimpforw fhsimpbackw


************* bilde Variable pkwfs ********************
noi di "generiere F�hrerschein/Pkw-Variable"
recode ppkwverf (0=2) (1=3) (2=4),gen(pkwfs)
label define l_pkwfs 1 "kein F�hrerschein" 2 "Pkw nie, FHS" 3 "Pkw zeitweise" 4 "Pkw immer" .f "Pkw nie, FS unbekannt" .a "keine Angabe"
label var pkwfs "Pkw/F�hrerschein"
label values pkwfs l_pkwfs
recode pkwfs (2=.f) if year==1997|year==2000|year==2002|year==2005|year==2007|fhs>=.
replace pkwfs = 1 if fhs==0
recode pkwfs (.f=2) if fhs==1

}
save "$PW_workingdir\soep\proj\FS\temp.dta", replace

***************************************************************************************************

use "$PW_workingdir\soep\proj\FS\temp.dta", clear
soep_intcens_fhspkw

dropvars _merge
save "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",replace
use "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",clear
bysort persnr year: drop if _n>1
keep persnr year pkw fhs pkwfs povzeitk
dropvars _merge
merge persnr year using "$PW_workingdir\soep\proj\Monat\Monat-custom.dta", uniqusing nokeep sort keep(gebmonat monatinterv female  mar eqnpers eqnkids eqnpers0014 eqnpers1518 hpers0_1 hpers2_4 hpers5_7 hpers8_10 hpers11_12 hpers13_15 heink_korr hinc_2007 pequivinc) 
dropvars _merge
merge persnr year using "$PW_workingdir\soep\proj\employment\employment-custom.dta", uniqusing nokeep sort keep(unifhs taetig arbeitslos empstat jobchanged edu3 yrsed ) 
dropvars _merge
save "$PW_workingdir\soep\proj\FS\persnr_year_pkw_fhs.dta",replace
log close

***************************************************************************************************






****************************************************************************************************


set mem 800m
set more off
capture log close
log using "$PW_workingdir\soep\proj\FS\est\fs\st_pkw_fs170709.log",replace

****************************************************************************************************
****************   Sch�tze parametrische Modelle f�r die einzelnen Zust�nde und �berg�nge **********
****************************************************************************************************

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",clear
//l�sche Jahre mit Missing Values der abh�ngigen Variablen
drop if fhs>=.
sort hhnrakt year agem
dropvars _merge
local addvars MZ* OZ* MET*
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* `addvars ')

******* l�sche missings ******************
drop if _merge==1
drop _merge
gen miss=0 if  wohn_typ<.& entfgrstadt<.& inf_shops<.& inf_doctor<.& inf_transit<. & wohn_quartier<.
drop if miss>=.


****************************************************************************

soep_genvar_spatial
soep_genvar_moved


******** �berg�nge "F�hrerschein-Erwerb" *********

noi di "sch�tze F�hrerschein-Erwerb-Modell"
// F�hrerschein-Erwerb
stset agem ,id(persnr) failure(fhs=2) origin(time 18) enter(fhs==0 3) exit(time .)
replace _st=0 if (fhs==1 | fhs==3)

soep_numfailures
//gen nachabgabe = nf>=1&nf<.
//sts graph ,surv by(entfgrstadt) tmax(20) xlabel(0(2)20) ylabel(0(.05)1, labsize(small) angle(0))
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))

soep_splitage,a18

/* **** teste Cox-Modell ***
dropvars s h ch
stcox female pincln adult2 adult3  oc_* mixedneighb house_* city_* shop?? if MZLogSumPkw<. & OZLogSumPkw<.,  nohr basehc(h) basesurv(s) basechazard(ch)
gen METCity3 =  METmeteriv<3000
gen METCity3_5 =  METmeteriv>=3000 & METmeteriv<5000
gen METCity5_10 =  METmeteriv>=5000 & METmeteriv<10000
gen OZCity =  OZmeteriv<5000
dropvars s h ch
stcox female pincln adult2 adult3  oc_* mixedneighb house_* MZLogSumPkw OZLogSumPkw  METCity* shop??,  nohr basehc(h) basesurv(s) basechazard(ch)

stcurve, surv range(0 30) at1(city_25_40=0 city_05_10=0 city_10_25=0  city_40_=0 shop10=1) /*
*/ at2(city_25_40=1 city_05_10=0 city_10_25=0  city_40_=0 house_deta=1) xlabel(0(5)30) ylabel(0(.05)1, labsize(small) angle(0))

stcurve, haz at1(city_25_40=0 city_05_10=0 city_10_25=0  city_40_=0 shop10=1) /*
*/ at2(city_25_40=1 city_05_10=0 city_10_25=0  city_40_=0 house_deta=1) xlabel(0(5)60) width(1)

*/

streg _age_* _fem_* pincln adult2 adult3 oc* mixedneighb house_* city_* shop?? notransit, dist(e) log nohr constr(100) collin 
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp ,replace

streg _age_* _fem_* pincln adult2 adult3 oc* mixedneighb house_* MZLogSumPkw OZLogSumPkw shop??, dist(e) log nohr constr(100) collin 
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp_LogSum ,replace

streg _age_* _fem_* pincln adult2 adult3 oc* mixedneighb house_* MZLogSumPkw OZLogSumPkw shop?? if !nachabgabe, dist(e) log nohr constr(100) collin 
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp_LogSum_erstFS ,replace


constraint define 1819 _age_18 = _age_19 
constraint define 1820 _age_18 = _age_20 
streg _age_* _fem_* pincln adult2 adult3 oc* mixedneighb house_* city_* shop?? notransit if nachabgabe, dist(e) log nohr constr(100 1819 1820 ) 
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp_nachAbgabe,replace
// wenn man den Lappen schon mal abegegeben hat, spielt das Alter keine Rolle
streg _fem_* pincln adult2 adult3 oc* mixedneighb house_* city_* shop?? notransit if nachabgabe, dist(e) log nohr constr(100 1819 1820 ) 
estimates save $PW_workingdir\soep\proj\FS\est\FS01exp_nachAbgabe_ohneAlter,replace
// eigentlich keine r�umlichen Faktoren relevant - nur Personen mit geringem Einkommen und �ltere Frauen versuchen nicht mehr, den F�hrerschein zur�ck zu bekommen.

soep_strejoin


******** �berg�nge "F�hrerschein-Abgabe" *********

noi di "sch�tze F�hrerschein-Abgabe-Modell"
// F�hrerschein-Erwerb
stset agem ,id(persnr) failure(fhs=3) origin(time 18) enter(fhs==1 2) exit(time .)
replace _st=0 if (fhs==0 | fhs==2)
sts graph ,surv by(female) tmax(70) xlabel(0(5)70) ylabel(0(.05)1, labsize(small) angle(0))

soep_numfailures
gen pkwimmer = pkw==31 | pkw==3
gen pkwzeitw = pkw==21 | pkw==2

soep_splitage

soep_genvar_oc_age

streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_city,replace

streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_LogSum,replace
// Frauen geben F�hrerschein im Alter deutlich eher ab als M�nner
// weder City noch �V-Erreichbarkeit noch �V-Startwartezeit spielen bei der F�hrerschein-Abgabe eine Rolle, 
// wohl aber die nahr�umliche Erreichbarkeit (shop, house, ...)
// f�r �ltere Menschen: entscheidend ist, ob Alltag in der N�he ohne Auto organisierbar ist, dann geben sie ggf. F�hrerschein ab.

streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp,replace

streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* shop?? pkwimmer pkwzeitw , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_pkw,replace
// wer noch (immer) ein Auto hat, der gibt den F�hrerschein nicht freiwillig ab
streg _age_* _fem_* pincln adult2 adult3 oa_* mixedneighb house_* shop?? pkwimmer , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_pkwimmer,replace
// wer noch immer ein Auto hat, der gibt den F�hrerschein nicht freiwillig ab
// wenn noch andere Erwachsene im Haushalt - F�hrerschein wird eher abgegeben (andere k�nnen mich zur Not fahren)

streg _age_* _fem_* pincln mixedneighb house_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_ohneocc,replace
streg _age_* _fem_* pincln mixedneighb house_* shop?? pkwimmer , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\FS10exp_ohneocc_pkwimmer,replace



soep_strejoin

log close
****************************************************************************************************************************
set more off
capture log close
log using "$PW_workingdir\soep\proj\FS\est\pkw\st_pkw_170709.log",replace

****************************************************************************************************
****************   Sch�tze parametrische Modelle f�r die einzelnen Zust�nde und �berg�nge **********
****************************************************************************************************

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",clear
//l�sche Jahre mit Missing Values der abh�ngigen Variablen
drop if fhs>=.
sort hhnrakt year agem
dropvars _merge
local addvars MZ* OZ* MET*
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* `addvars ')

******* l�sche missings ******************
drop if _merge==1
drop _merge
gen miss=0 if  wohn_typ<.& entfgrstadt<.& inf_shops<.& inf_doctor<.& inf_transit<. & wohn_quartier<.
drop if miss>=.


****************************************************************************

soep_genvar_spatial
soep_genvar_moved




******** �berg�nge "Pkw-Erwerb" *********


//12 13 nie -> zeitweise/immer
dropvars pkwpossible
gen pkwpossible = (pkw==1|pkw==21|pkw==31) & (fhs==1|fhs==2)

noi di "sch�tze Pkw-Erwerb-Modell nie->zeitweise"
stset agem ,id(persnr) failure(pkw=12) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=1 & pkw!=12 & pkw!=13) | (fhs==0 | fhs==2)
//stsum
soep_numfailures

soep_splitage,a18
soep_genvar_oc_age

/*
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
*/
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? doc*, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw12exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw12exp_LogSum,replace
streg _age_* _fem_* pincln adult2 mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw12exp_LogSum_ohneocc,replace

streg _age_* _fem_* pincln adult2 mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? nachabgabe, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw12exp_LogSum_ohneocc_nachabgabe,replace



noi di "sch�tze Pkw-Erwerb-Modell nie->immer"
stset agem ,id(persnr) failure(pkw=13) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=1 & pkw!=12 & pkw!=13) | (fhs==0 | fhs==2)
//stsum
soep_numfailures



streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw13exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw13exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw13exp_LogSum_ohneocc,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? nachabgabe, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw13exp_LogSum_ohneocc_nachabgabe,replace


/*
dropvars s h ch
stcox female pincln adult2 adult3  oa_* mixedneighb house_*  city_* shop??  ,  nohr basehc(h) basesurv(s) basechazard(ch)
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
*/

soep_strejoin


//21 23 zeitweise -> nie/immer
dropvars pkwpossible
gen pkwpossible = (pkw==2|pkw==12|pkw==32)

noi di "sch�tze Pkw-Erwerb-Modell zeitweise->immer"
stset agem ,id(persnr) failure(pkw=23) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=2 & pkw!=21 & pkw!=23)
//stsum
soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage,a18
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw23exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw23exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw23exp_LogSum_ohneocc,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? nachabgabe, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw23exp_LogSum_ohneocc_nachabgabe,replace


noi di "sch�tze Pkw-Abgabe-Modell zeitweise->nie"
// F�hrerschein-Erwerb
stset agem ,id(persnr) failure(pkw=21) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=2 & pkw!=21 & pkw!=23)
//stsum
//soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw21exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkw\Pkw21exp_city,replace


soep_strejoin


//31 32 immer -> nie/zeitweise
dropvars pkwpossible
gen pkwpossible = (pkw==3|pkw==13|pkw==23)

noi di "sch�tze Pkw-Erwerb-Modell immer->zeitweise"
stset agem ,id(persnr) failure(pkw=32) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)
//stsum
//soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? doctor??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw32exp,replace
soep_strejoin

noi di "sch�tze Pkw-Abgabe-Modell immer->nie"
// F�hrerschein-Erwerb
stset agem ,id(persnr) failure(pkw=31) origin(time 18) enter(pkwpossible=1) exit(time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)
//stsum
//soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? doctor?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\Pkw31exp,replace
soep_strejoin

log close


noi di "sch�tze Pkw-Abgabe-Modell immer->/zeitweise oder nie"
// F�hrerschein-Erwerb
stset agem ,id(persnr) failure(pkw=31 32) origin(time 18) enter(pkwpossible=1) exit(fhs=3 time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)

dropvars h s ch
stcox female pincln adult2 adult3  oc_* mixedneighb house_* city_* shop?? notransit,  nohr basehc(h) basesurv(s) basechazard(ch)
stcurve, surv at1(city_25_40=0 city_05_10=0 city_10_25=0  city_40_=0 shop10=1) at2(city_25_40=1 city_05_10=0 city_10_25=0  city_40_=0 house_deta=1) xlabel(0(5)60) ylabel(0(.1)1)





stset agem ,id(persnr) failure(pkwfs=12 13 ) origin(time 18) enter(pkw==1 21 31) exit(fhs==3 time .)
** setzt Episoden ohne F�hrerscheinbesitz auf _st=0 ***
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