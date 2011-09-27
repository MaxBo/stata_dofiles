********** Program dass für typische Personen die Pkw-Führerschein-Verfügbarkeit im Lebesverlauf darstellt ************
*! version 1.02  27jun2009
************************************************************************

************************************************************************
program define soep_plot_pkw_graph

************************************************************************************
********** Berechne hazard-rates und Pkw-Verfügbarkeit *****************************
************************************************************************************

****** initialisiere Variablen: 4800 Fälle 4*(0-100 Jahre)*12 Monate ***************
preserve
drop _all
set obs 4800
gen persnr = _n
gen sam = int((_n-1)/1200)
gen agem = mod((_n-1)/12,100)
stset agem ,id(sam) failure(persnr=0) origin(time 18) exit(time .)


soep_define_lebenslauf

*** codiere Variablen um
gen equivpersons = 1+.3*eqnkids14+.5*(eqnpers-1-eqnkids14)
gen pequivinc = hhinc / equivpersons

soep_genvar_spatial


dropvars _age* agegroup
egen agegroup = cut(agem), at(18/24 25(5)90 110)
soep_genvar_agedummy
gen _age_18_24 = (agem>=18&agem<25)
soep_genvar_oc_age


************* store Estimates **************************
estimates use $PW_workingdir\soep\proj\FS\est\fs\FS01exp_LogSum
estimates store FS01
estimates use $PW_workingdir\soep\proj\FS\est\fs\FS10exp_LogSum
estimates store FS10
estimates use $PW_workingdir\soep\proj\FS\est\pkw\Pkw12exp_LogSum
estimates store Pkw12
estimates use $PW_workingdir\soep\proj\FS\est\pkw\Pkw13exp_LogSum
estimates store Pkw13
estimates use $PW_workingdir\soep\proj\FS\est\pkw\Pkw23exp_LogSum
estimates store Pkw23
estimates use $PW_workingdir\soep\proj\FS\est\pkw\Pkw21exp_LogSum
estimates store Pkw21
estimates use $PW_workingdir\soep\proj\FS\est\pkw\Pkw31exp_LogSum
estimates store Pkw31
estimates use $PW_workingdir\soep\proj\FS\est\pkw\Pkw32exp_LogSum
estimates store Pkw32
*************************************************************
//initialisiere: am 18. Geburtstag ist "kein Führerschein" = 100% und "Führerschein/Pkw-Verfügbarkeit" = 0%
dropvars h?? s? t??
sort sam persnr
// s0: kein Führerschein, s1-s3: Führerschein,s1: kein Pkw, s2: Pkw zeitweise, s3: Pkw immer
gen s0=1
gen s1=0
gen s2=0
gen s3=0
local startjahr=18
********** berechne Hazard-Rates *******************
local tlist "01 10 12 13 21 23 31 32"
foreach t of local tlist {
	if "`t'"=="01" | "`t'"=="10" {
		estimates restore FS`t'
	}
	else {
		estimates restore Pkw`t'
	}
	predict h`t',hazard
	recode h`t' (.=0)
	gen t`t' = 0
	replace h`t'=0 if agem<`startjahr'
}
gen t20=0
gen t30=0
forvalues nn=1/1200 {
	if mod(`nn',100)==0 {
		di `nn'
	}
	quietly {
		//berechne für jeden Monat die Zahl der Übergänge txx
		by sam: replace t01 = s0[_n-1]*h01*(1/12) if _n==`nn'
		by sam: replace t10 = s1[_n-1]*h10*(1/12) if _n==`nn'
		by sam: replace t20 = s2[_n-1]*h10*(1/12) if _n==`nn'
		by sam: replace t30 = s3[_n-1]*h10*(1/12) if _n==`nn'
		by sam: replace t12 = s1[_n-1]*h12*(1/12) if _n==`nn'
		by sam: replace t13 = s1[_n-1]*h13*(1/12) if _n==`nn'
		by sam: replace t21 = s2[_n-1]*h21*(1/12) if _n==`nn'
		by sam: replace t23 = s2[_n-1]*h23*(1/12) if _n==`nn'
		by sam: replace t31 = s3[_n-1]*h31*(1/12) if _n==`nn'
		by sam: replace t32 = s3[_n-1]*h32*(1/12) if _n==`nn'
		// ziehe von der Führerschein-Survival-Rate die Abgänge ab und addiere die Zugänge
		by sam: replace s0= s0[_n-1]-t01+t10+t20+t30 if _n==`nn' & _n>=(12*18)
		// ziehe von der Pkw-Survival-Rate die Abgänge ab und addiere die Zugänge
		by sam: replace s1= s1[_n-1]-t12-t13+t21+t31-t10+t01 if _n==`nn' & _n>=(12*18)
		by sam: replace s2= s2[_n-1]-t21-t23+t12+t32-t20 if _n==`nn' & _n>=(12*18)
		by sam: replace s3= s3[_n-1]-t31-t32+t13+t23-t30 if _n==`nn' & _n>=(12*18)
	}
}

************* berechne Werte für Hazard-Graphen und Bestands-Graphen ************
dropvars hh?? sh?
gen hh00=1
gen hh01=h01
label var hh00 "no change"
label var hh01 "obtains licence"
gen hh10=1
gen hh11=1-h10
gen hh12=h13+h12
gen hh13=h13
label var hh10 "surrenders licence"
label var hh11 "no change"
label var hh12 "car occasionally"
label var hh13 "car always"
gen hh20=1
gen hh21=1-h10
gen hh22=hh21-h21
gen hh23=h23
label var hh20 "surrenders licence"
label var hh21 "no car"
label var hh22 "no change"
label var hh23 "car always"
gen hh30=1
gen hh31=1-h10
gen hh32=hh31-h31
gen hh33=hh32-h32
label var hh30 "surrenders licence"
label var hh31 "no car"
label var hh32 "car occasionally"
label var hh33 "no change"

gen sh3=s3
gen sh2=sh3+s2
gen sh1=sh2+s1
gen sh0=1
label var sh0 "no licence"
label var sh1 "no car"
label var sh2 "car occasionally"
label var sh3 "car always"




/*

local tlist "FS01 FS10 Pkw12 Pkw13 Pkw21 Pkw23 Pkw31 Pkw32"
foreach t of local tlist {
	estimates restore `t'
	predict h`t',hazard
	recode h`t' (.=0)
	gen t`t' = 0
	replace h`t'=0 if agem<`startjahr'
}
forvalues nn=1/1200 {
	if mod(`nn',100)==0 {
		di `nn'
	}
	quietly {
		//berechne für jeden Monat die Übergänge
		by sam: replace tFS01 = sFS0[_n-1]*hFS01*(1/12) if _n==`nn'
		by sam: replace tFS10 = sFS1[_n-1]*hFS10*(1/12) if _n==`nn'
		// ziehe von der Führerschein-Survival-Rate die Abgänge ab und addiere die Zugänge
		by sam: replace sFS1= sFS1[_n-1]-tFS10+tFS01 if _n==`nn' & _n>=(12*18)
		by sam: replace sFS0= sFS0[_n-1]-tFS01+tFS10 if _n==`nn' & _n>=(12*18)
		//berechne für jeden Monat die Übergänge, berücksichtige dabei den Anteil der Führerscheinbesitzer sFS1
		by sam: replace tPkw12 = sPkw1[_n-1]*sFS1*hPkw12*(1/12) if _n==`nn'
		by sam: replace tPkw13 = sPkw1[_n-1]*sFS1*hPkw13*(1/12) if _n==`nn'
		by sam: replace tPkw21 = sPkw2[_n-1]*sFS1*hPkw21*(1/12) if _n==`nn'
		by sam: replace tPkw23 = sPkw2[_n-1]*sFS1*hPkw23*(1/12) if _n==`nn'
		by sam: replace tPkw31 = sPkw3[_n-1]*sFS1*hPkw31*(1/12) if _n==`nn'
		by sam: replace tPkw32 = sPkw3[_n-1]*sFS1*hPkw32*(1/12) if _n==`nn'
		// ziehe von der Survival-Rate die Abgänge ab und addiere die Zugänge
		by sam: replace sPkw1= sPkw1[_n-1]-tPkw12-tPkw13+tPkw21+tPkw31 if _n==`nn' & _n>=(12*18)
		by sam: replace sPkw2= sPkw2[_n-1]-tPkw21-tPkw23+tPkw12+tPkw32 if _n==`nn' & _n>=(12*18)
		by sam: replace sPkw3= sPkw3[_n-1]-tPkw31-tPkw32+tPkw13+tPkw23 if _n==`nn' & _n>=(12*18)
	}
}



************* berechne Werte für Hazard-Graphen und Bestands-Graphen ************
dropvars hh?? sh?
gen hh11=1
gen hh12=hPkw12+hPkw13
gen hh13=hPkw13
label var hh11 "no change"
label var hh12 "car never->occasionally"
label var hh13 "car never->always"
gen hh21=1
gen hh22=1-hPkw21
gen hh23=hPkw23
label var hh21 "car occasionally -> never"
label var hh22 "no change"
label var hh23 "car occasionally -> always"
gen hh31=1
gen hh32=1-hPkw31
gen hh33=hh32-hPkw32
label var hh31 "car always -> never"
label var hh32 "car always -> occasionally"
label var hh33 "no change"

label var hFS01 "obtains licence"
label var hFS10 "surrenders licence"

gen sh3=sPkw3
gen sh2=sh3+sPkw2
gen sh1=sh2+sPkw1
gen sh0=1
label var sh0 "kein Führerschein"
label var sh1 "Pkw nie, mit Fhs."
label var sh2 "Pkw zeitweise"
label var sh3 "Pkw immer"

*/


******** baue hazard-rate-Graphs ********************
twoway (area hh33 agem ,fcol(white)) /*
*/ (area hh10 agem ,col(ltblue)) /*
*/ (area hh31 agem ,col(midblue)) /*
*/ (area hh32 agem ,col(blue)) /*
*/ (area hh23 agem ,col(blue) fintensity(*2))if agem<1, /* 
*/ yscale(off) nodraw xscale(off) legend(subtitle("change to:") label(2 "no licence") label(3 "no car, with licence") rows(1) bmargin(medsmall)  symysize(*.6) symxsize(*.4)) name(leghazard,replace)
_gm_edit .leghazard.plotregion1.draw_view.set_false
_gm_edit .leghazard.ystretch.set fixed

twoway (area sh0 agem ,col(ltblue)) /*
*/ (area sh1 agem ,col(midblue)) /*
*/ (area sh2 agem ,col(blue)) /*
*/ (area sh3 agem ,col(blue) fintensity(*2))if agem<1, /* 
*/ yscale(off) nodraw xscale(off) legend (label(1 "no licence") label(2 "no car, with licence") /*
*/ label(3 "car, occasionally") label(4 "car, always") /*
*/ rows(1) bmargin(medsmall)  symysize(*.6) symxsize(*.4)) name(legsurv,replace)
_gm_edit .legsurv.plotregion1.draw_view.set_false
_gm_edit .legsurv.ystretch.set fixed

forvalues sa=0/3{

twoway (area hh01 agem if sam==`sa',col(midblue)) /*
*/ if agem>15&agem<90,subtitle("from: no licence")/*
*/ ytitle("yearly transition rate") yline(0 1,lcol(black)) ylabel(0(.1)1,angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,grid alternate labsize(small)) /*
*/ legend(off) saving(h1x`sa',replace) name(h1x`sa',replace) nodraw 

twoway (rarea hh11 hh10 agem if sam==`sa',col(ltblue)) /*
*/ (rarea hh13 hh12 agem if sam==`sa',col(blue)) /*
*/ (area hh13 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,subtitle("from: no car, with licence")/*
*/ ytitle("") yline(0 1,lcol(black)) ylabel(0(.1)1, angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,alternate labsize(small)) /*
*/ legend(off) saving(h2x`sa',replace) name(h2x`sa',replace) nodraw 

twoway (rarea hh21 hh20 agem if sam==`sa',col(ltblue)) /*
*/ (rarea hh22 hh21 agem if sam==`sa',col(midblue)) /*
*/ (area hh23 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,subtitle("from: car occasionally")/*
*/ ytitle("yearly transition rate") yline(0 1,lcol(black)) ylabel(0(.1)1, angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,alternate labsize(small)) /*
*/ legend(off) saving(h3x`sa',replace) name(h3x`sa',replace) nodraw 

twoway (rarea hh31 hh30 agem if sam==`sa',col(ltblue)) /*
*/ (rarea hh32 hh31 agem if sam==`sa',col(midblue)) /*
*/ (rarea hh33 hh32 agem if sam==`sa',col(blue)) /*
*/if agem>15&agem<90,subtitle("from: car always") /*
*/ ytitle("") yline(0 1,lcol(black)) ylabel(0(.1)1, angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,alternate labsize(small)) /*
*/ legend(off) saving(h4x`sa',replace) name(h4x`sa',replace) nodraw 

graph combine h1x`sa' h2x`sa' h3x`sa' h4x`sa',imargin(1 1 1 1) name(hx`sa',replace) nodraw 
}
************************************************************

****** stelle hazardrates und Anteile dar **********************************

local person0 "man, stays in village"
local person1 "woman, stays in village"
local person2 "man, moves to town"
local person3 "woman, moves to town"

forvalues sa=0/3{
graph combine hx`sa' leghazard, imargin(0 0 0 0) subtitle("yearly transition rates for `person`sa''") col(1) saving(hhx`sa',replace)name(hhx`sa',replace)

set graphics off

twoway (area sh0 agem if sam==`sa',col(ltblue)) /*
*/ (area sh1 agem if sam==`sa',col(midblue)) /*
*/ (area sh2 agem if sam==`sa',col(blue)) /*
*/ (area sh3 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,title("car/licence availability") subtitle("`person`sa''") /*
*/ ytitle("probability") legend(label(1 "no licence") label(2 "no car, with licence") label(3 "car occasionally") label(4 "car always")) ylabel(#10,glcol(gs0) angle(0) gextend ) ymtick(##2,glcol(gs8) gextend ) xtitle("age") xlabel(18 20(5)90,alternate) /*
*/ saving(surv`sa',replace) name(surv`sa',replace) nodraw 

twoway (area sh0 agem if sam==`sa',col(ltblue)) /*
*/ (area sh1 agem if sam==`sa',col(midblue)) /*
*/ (area sh2 agem if sam==`sa',col(blue)) /*
*/ (area sh3 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90, title("car/licence availability") subtitle("`person`sa''") /*
*/ ytitle("probability") ylabel(#10,glcol(gs0) angle(0) gextend ) legend(off) ymtick(##2,glcol(gs8) gextend ) xtitle("age") xlabel(18 20(5)90,alternate) /*
*/ saving(surv`sa'_ol,replace) name(surv`sa'_ol,replace) nodraw 

set graphics on
}
**************************************************************
graph combine surv0_ol surv1_ol surv2_ol surv3_ol, imargin(0 0 0 0) col(2) saving(surv_all,replace) name(surv_all,replace) nodraw 
graph combine surv_all legsurv, imargin(0 0 0 0) col(1) saving(surv_all,replace)name(surv_all,replace)


restore


end 
************************************************************************


