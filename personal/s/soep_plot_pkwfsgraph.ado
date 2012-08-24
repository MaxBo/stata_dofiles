********** Program dass für typische Personen die Pkw-Führerschein-Verfügbarkeit im Lebesverlauf darstellt ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_plot_pkwfsgraph

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
gen aged = int(agem)
replace aged=0 if (aged<18 | agem>=25)
gen aged5=int(agem/5)*5
replace aged5=90 if agem>90
gen aged2=int(agem/2)*2
replace aged2=0 if (aged2<18 | aged2 >=30)
stset agem ,id(sam) failure(persnr=0) origin(time 18) exit(time .)

/*
gen _t = agem-18
gen _t0=_t[_n-1] if _t>0
replace _t=. if _t<0
gen _st=0
replace _st=1 if agem >=18
gen _d=0
*/

soep_define_lebenslauf

*** codiere Variablen um
gen equivpersons = 1+.3*eqnkids14+.5*(eqnpers-1-eqnkids14)
gen pequivinc = hhinc / equivpersons

soep_genvar_spatial


dropvars aged aged5 _age* _fem*
gen aged = int(agem)
replace aged=0 if (aged<18 | agem>=25)
gen aged5=int(agem/5)*5
replace aged5=90 if agem>90
replace aged5=18 if (agem<25 & agem>=18)
replace aged5=0 if (agem<18)
replace aged=aged5 if (agem>=25)

gen _age_18_24 = 1 if agem>=18&agem<25
xi i.aged 
renpfix _Iaged_ _age_
forvalues i=25(5)85 {
	local ii=`i'+4
	rename _age_`i' _age_`i'_`ii'
}
rename _age_90 _age_90_
gen _fem_18_34 = 1 if female==1 & agem>=18 & agem<35
gen _fem_35_49 = 1 if female==1 & agem>=35 & agem<50
gen _fem_50_64 = 1 if female==1 & agem>=50 & agem<65
gen _fem_65_79 = 1 if female==1 & agem>=65 & agem<80
gen _fem_80_ = 1 if female==1 & agem>=80 & agem<.
recode _age_18_24 _fem_* (.=0)


************* store Estimates **************************
estimates use $PW_workingdir\soep\proj\FS\est\FS12exp
estimates store pkwfs12
estimates use $PW_workingdir\soep\proj\FS\est\FS13exp
estimates store pkwfs13
estimates use $PW_workingdir\soep\proj\FS\est\FS14exp
estimates store pkwfs14
estimates use $PW_workingdir\soep\proj\FS\est\FS21exp
estimates store pkwfs21
estimates use $PW_workingdir\soep\proj\FS\est\FS23exp
estimates store pkwfs23
estimates use $PW_workingdir\soep\proj\FS\est\FS24exp
estimates store pkwfs24
estimates use $PW_workingdir\soep\proj\FS\est\FS31exp
estimates store pkwfs31
estimates use $PW_workingdir\soep\proj\FS\est\FS32exp
estimates store pkwfs32
estimates use $PW_workingdir\soep\proj\FS\est\FS34exp
estimates store pkwfs34
estimates use $PW_workingdir\soep\proj\FS\est\FS41exp
estimates store pkwfs41
estimates use $PW_workingdir\soep\proj\FS\est\FS42exp
estimates store pkwfs42
estimates use $PW_workingdir\soep\proj\FS\est\FS43exp
estimates store pkwfs43
*************************************************************
//initialisiere: am 18. Geburtstag ist "kein Führerschein" = 100% und "Führerschein/Pkw-Verfügbarkeit" = 0%
dropvars h?? s? t??
sort sam persnr
gen s1=1
gen s2=0
gen s3=0
gen s4=0
local startjahr=18
********** berechne Hazard-Rates *******************
local tlist "12 13 14 21 23 24 31 32 34 41 42 43"
foreach t of local tlist {
	estimates restore pkwfs`t'
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
		by sam: replace t12 = s1[_n-1]*h12*(1/12) if _n==`nn'
		by sam: replace t13 = s1[_n-1]*h13*(1/12) if _n==`nn'
		by sam: replace t14 = s1[_n-1]*h14*(1/12) if _n==`nn'
		by sam: replace t21 = s2[_n-1]*h21*(1/12) if _n==`nn'
		by sam: replace t23 = s2[_n-1]*h23*(1/12) if _n==`nn'
		by sam: replace t24 = s2[_n-1]*h24*(1/12) if _n==`nn'
		by sam: replace t31 = s3[_n-1]*h31*(1/12) if _n==`nn'
		by sam: replace t32 = s3[_n-1]*h32*(1/12) if _n==`nn'
		by sam: replace t34 = s3[_n-1]*h34*(1/12) if _n==`nn'
		by sam: replace t41 = s4[_n-1]*h41*(1/12) if _n==`nn'
		by sam: replace t42 = s4[_n-1]*h42*(1/12) if _n==`nn'
		by sam: replace t43 = s4[_n-1]*h43*(1/12) if _n==`nn'
		// ziehe von der Survival-Rate die Abgänge ab und addiere die Zugänge
		by sam: replace s1= s1[_n-1]-t12-t13-t14+t21+t31+t41 if _n==`nn' & _n>=(12*18)
		by sam: replace s2= s2[_n-1]-t21-t23-t24+t12+t32+t42 if _n==`nn' & _n>=(12*18)
		by sam: replace s3= s3[_n-1]-t31-t32-t34+t13+t23+t43 if _n==`nn' & _n>=(12*18)
		by sam: replace s4= s4[_n-1]-t41-t42-t43+t14+t24+t34 if _n==`nn' & _n>=(12*18)
	}
}

************* berechne Werte für Hazard-Graphen und Bestands-Graphen ************
dropvars hh?? sh?
gen hh11=1
gen hh12=h12+h13+h14
gen hh13=h14+h13
gen hh14=h14
label var hh11 "no change"
label var hh12 "gets licence, no car"
label var hh13 "car temporarily"
label var hh14 "car always"
gen hh21=1
gen hh22=1-h21
gen hh23=h24+h23
gen hh24=h24
label var hh21 "hand in licence"
label var hh22 "no change"
label var hh23 "car temporarily"
label var hh24 "car always"
gen hh31=1
gen hh32=1-h31
gen hh33=hh32-h32
gen hh34=h34
label var hh31 "hand in licence"
label var hh32 "no car"
label var hh33 "no change"
label var hh34 "car always"
gen hh41=1
gen hh42=1-h41
gen hh43=hh42-h42
gen hh44=hh43-h43
label var hh41 "hand in licence"
label var hh42 "no car"
label var hh43 "car temporarily"
label var hh44 "no change"

gen sh4=s4
gen sh3=sh4+s3
gen sh2=sh3+s2
gen sh1=1
label var sh1 "kein Führerschein"
label var sh2 "Pkw nie, mit Fhs."
label var sh3 "Pkw zeitweise"
label var sh4 "Pkw immer"




******** baue hazard-rate-Graphs ********************
twoway (area hh44 agem ,fcol(white)) /*
*/ (area hh21 agem ,col(ltblue)) /*
*/ (area hh42 agem ,col(midblue)) /*
*/ (area hh43 agem ,col(blue)) /*
*/ (area hh34 agem ,col(blue) fintensity(*2))if agem<1, /* 
*/ yscale(off) nodraw xscale(off) legend(subtitle("change to:") label(2 "no licence") label(3 "no car, with licence") rows(1) bmargin(medsmall)  symysize(*.6) symxsize(*.4)) name(leghazard,replace)
_gm_edit .leghazard.plotregion1.draw_view.set_false
_gm_edit .leghazard.ystretch.set fixed

twoway (area sh1 agem ,col(ltblue)) /*
*/ (area sh2 agem ,col(midblue)) /*
*/ (area sh3 agem ,col(blue)) /*
*/ (area sh4 agem ,col(blue) fintensity(*2))if agem<1, /* 
*/ yscale(off) nodraw xscale(off) legend (label(1 "no licence") label(2 "no car, with licence") /*
*/ label(3 "car, temporarily") label(4 "car, always") /*
*/ rows(1) bmargin(medsmall)  symysize(*.6) symxsize(*.4)) name(legsurv,replace)
_gm_edit .legsurv.plotregion1.draw_view.set_false
_gm_edit .legsurv.ystretch.set fixed

forvalues sa=0/3{

twoway (rarea hh13 hh12 agem if sam==`sa',col(midblue)) /*
*/ (rarea hh14 hh13 agem if sam==`sa',col(blue)) /*
*/ (area hh14 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,subtitle("from: no licence")/*
*/ ytitle("yearly transition rate") yline(0 1,lcol(black)) ylabel(0(.1)1,angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,grid alternate labsize(small)) /*
*/ legend(off) saving(h1x`sa',replace) name(h1x`sa',replace) nodraw 

twoway (rarea hh22 hh21 agem if sam==`sa',col(ltblue)) /*
*/ (rarea hh24 hh23 agem if sam==`sa',col(blue)) /*
*/ (area hh24 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,subtitle("from: no car, with licence")/*
*/ ytitle("") yline(0 1,lcol(black)) ylabel(0(.1)1, angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,alternate labsize(small)) /*
*/ legend(off) saving(h2x`sa',replace) name(h2x`sa',replace) nodraw 

twoway (rarea hh32 hh31 agem if sam==`sa',col(ltblue)) /*
*/ (rarea hh33 hh32 agem if sam==`sa',col(midblue)) /*
*/ (area hh34 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,subtitle("from: car temporarily")/*
*/ ytitle("yearly transition rate") yline(0 1,lcol(black)) ylabel(0(.1)1, angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,alternate labsize(small)) /*
*/ legend(off) saving(h3x`sa',replace) name(h3x`sa',replace) nodraw 

twoway (rarea hh42 hh41 agem if sam==`sa',col(ltblue)) /*
*/ (rarea hh43 hh42 agem if sam==`sa',col(midblue)) /*
*/ (rarea hh44 hh43 agem if sam==`sa',col(blue)) /*
*/if agem>15&agem<90,subtitle("from: car always") /*
*/ ytitle("") yline(0 1,lcol(black)) ylabel(0(.1)1, angle(0) labsize(small)) ymtick(##2,grid glstyle(minor_grid)) xtitle("age") xlabel(18 20(5)90,alternate labsize(small)) /*
*/ legend(off) saving(h4x`sa',replace) name(h4x`sa',replace) nodraw 

graph combine h1x`sa' h2x`sa' h3x`sa' h4x`sa',imargin(1 1 1 1) name(hx`sa',replace) nodraw 
}
************************************************************

****** stelle hazardrates und Anteile dar **********************************

local person0 "man, stays in village"
local person1 "man, moves to town"
local person2 "woman, stays in village"
local person3 "woman, moves to town"

forvalues sa=0/3{
graph combine hx`sa' leghazard, imargin(0 0 0 0) subtitle("yearly transition rates for `person`sa''") col(1) saving(hhx`sa',replace)name(hhx`sa',replace)

set graphics off

twoway (area sh1 agem if sam==`sa',col(ltblue)) /*
*/ (area sh2 agem if sam==`sa',col(midblue)) /*
*/ (area sh3 agem if sam==`sa',col(blue)) /*
*/ (area sh4 agem if sam==`sa',col(blue) fintensity(*2)) /*
*/ if agem>15&agem<90,title("car/licence availability") subtitle("`person`sa''") /*
*/ ytitle("probability") legend(label(1 "no licence") label(2 "no car, with licence") label(3 "car temporarily") label(4 "car always")) ylabel(#10,glcol(gs0) angle(0) gextend ) ymtick(##2,glcol(gs8) gextend ) xtitle("age") xlabel(18 20(5)90,alternate) /*
*/ saving(surv`sa',replace) name(surv`sa',replace) nodraw 

twoway (area sh1 agem if sam==`sa',col(ltblue)) /*
*/ (area sh2 agem if sam==`sa',col(midblue)) /*
*/ (area sh3 agem if sam==`sa',col(blue)) /*
*/ (area sh4 agem if sam==`sa',col(blue) fintensity(*2)) /*
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


