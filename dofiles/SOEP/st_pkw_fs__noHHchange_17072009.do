****************************************************************************************************************************
set more off
capture log close
log using "$PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\st_pkw_170709_noHHchange.log",replace

****************************************************************************************************
****************   Schätze parametrische Modelle für die einzelnen Zustände und Übergänge **********
****************************************************************************************************

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs.dta",clear
//lösche Jahre mit Missing Values der abhängigen Variablen
drop if fhs>=.
sort hhnrakt year agem
dropvars _merge
local addvars MZ* OZ* MET*
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* `addvars ')

******* lösche missings ******************
drop if _merge==1
drop _merge
gen miss=0 if  wohn_typ<.& entfgrstadt<.& inf_shops<.& inf_doctor<.& inf_transit<. & wohn_quartier<.
drop if miss>=.


****************************************************************************

soep_genvar_spatial
soep_genvar_moved
gen hhgrchanged = adult1_2==1 | adult1_3==1 | adult2_1==1 | adult2_3==1 | adult3_1==1 | adult3_2==1

save "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",replace


******** Übergänge "Pkw-Erwerb" *********

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",clear

//12 13 nie -> zeitweise/immer
dropvars pkwpossible
gen pkwpossible = (pkw==1|pkw==21|pkw==31) & (fhs==1|fhs==2)

noi di "schätze Pkw-Erwerb-Modell nie->zeitweise"
stset agem ,id(persnr) failure(pkw=12) origin(time 18) enter(pkwpossible=1) exit(hhgrchanged==1 time .)
replace _st=0 if (pkw!=1 & pkw!=12 & pkw!=13) | (fhs==0 | fhs==2)
//stsum
soep_numfailures

soep_splitage,a18
soep_genvar_oc_age

/*
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
*/
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? doc*, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw12exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw12exp_LogSum,replace
streg _age_* _fem_* pincln adult2 mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw12exp_LogSum_ohneocc,replace

streg _age_* _fem_* pincln adult2 mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? nachabgabe, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw12exp_LogSum_ohneocc_nachabgabe,replace



use "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",clear

dropvars pkwpossible
gen pkwpossible = (pkw==1|pkw==21|pkw==31) & (fhs==1|fhs==2)

noi di "schätze Pkw-Erwerb-Modell nie->immer"
stset agem ,id(persnr) failure(pkw=13) origin(time 18) enter(pkwpossible=1) exit(hhgrchanged==1 time .)
replace _st=0 if (pkw!=1 & pkw!=12 & pkw!=13) | (fhs==0 | fhs==2)
//stsum
soep_numfailures

soep_splitage,a18
soep_genvar_oc_age


streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw13exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw13exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw13exp_LogSum_ohneocc,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? nachabgabe, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw13exp_LogSum_ohneocc_nachabgabe,replace


/*
dropvars s h ch
stcox female pincln adult2 adult3  oa_* mixedneighb house_*  city_* shop??  ,  nohr basehc(h) basesurv(s) basechazard(ch)
stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
*/


use "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",clear

//21 23 zeitweise -> nie/immer
dropvars pkwpossible
gen pkwpossible = (pkw==2|pkw==12|pkw==32)

noi di "schätze Pkw-Erwerb-Modell zeitweise->immer"
stset agem ,id(persnr) failure(pkw=23) origin(time 18) enter(pkwpossible=1) exit(hhgrchanged==1 time .)
replace _st=0 if (pkw!=2 & pkw!=21 & pkw!=23)
//stsum
soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage,a18
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw23exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw23exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw23exp_LogSum_ohneocc,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? nachabgabe, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw23exp_LogSum_ohneocc_nachabgabe,replace

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",clear
dropvars pkwpossible
gen pkwpossible = (pkw==2|pkw==12|pkw==32)

noi di "schätze Pkw-Abgabe-Modell zeitweise->nie"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(pkw=21) origin(time 18) enter(pkwpossible=1) exit(hhgrchanged==1 time .)
replace _st=0 if (pkw!=2 & pkw!=21 & pkw!=23)
//stsum
//soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw21exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw21exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop?? , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw21exp_LogSum_ohneocc,replace

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",clear
//31 32 immer -> nie/zeitweise
dropvars pkwpossible
gen pkwpossible = (pkw==3|pkw==13|pkw==23)

noi di "schätze Pkw-Erwerb-Modell immer->zeitweise"
stset agem ,id(persnr) failure(pkw=32) origin(time 18) enter(pkwpossible=1) exit(hhgrchanged==1 time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)
//stsum
//soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage
soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw32exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw32exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??, dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw32exp_ohneocc,replace

use "$PW_workingdir\soep\proj\FS\FS-pkw_fs_wohnen.dta",clear
dropvars pkwpossible
gen pkwpossible = (pkw==3|pkw==13|pkw==23)
noi di "schätze Pkw-Abgabe-Modell immer->nie"
// Führerschein-Erwerb
stset agem ,id(persnr) failure(pkw=31) origin(time 18) enter(pkwpossible=1) exit(hhgrchanged==1 time .)
replace _st=0 if (pkw!=3 & pkw!=31 & pkw!=32)
//stsum
//soep_numfailures
//stphplot, by(taet) plot1opts(msymbol(i))  plot2opts(msymbol(i)) plot3opts(msymbol(i)) plot4opts(msymbol(i)) plot5opts(msymbol(i)) plot6opts(msymbol(i))
soep_splitage

soep_genvar_oc_age
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* city_* shop??  , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw31exp_city,replace
streg _age_* _fem_* pincln adult2 adult3 kid? oa_* mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??  , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw31exp_LogSum,replace
streg _age_* _fem_* pincln mixedneighb house_* MZLogSumPkw OZLogSumPkw METmittlswz shop??  , dist(e) log nohr constr(100) collin
estimates save $PW_workingdir\soep\proj\FS\est\pkwhhgrchanged\Pkw31exp_LogSum_ohneocc,replace
soep_strejoin

log close

**** Änderung der Haushaltsgröße ***

