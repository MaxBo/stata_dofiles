********** Program zur genierierung eines imputierten Event-Zeitpunktes bei intervallzensierten Daten ************
*! version 1.0  08jun2009
program define soep_intcens

syntax varlist 
*************** Intervall-Zensierte Daten: neuen  generieren       ********

quietly {
noi di "update des imputierten `varlist'-Wertes" 

// 
gsort persnr year
replace agevorevent = agevorevent[_n-1] if `varlist'>=.
gsort persnr -year
replace agenachevent = agenachevent[_n-1] if `varlist'>=.
expand 2 if agem>agenachevent & agem[_n+1]<agevorevent[_n+1] & agevorevent[_n+1]<.
gsort persnr year agem
replace agem = agenachevent if agem==agem[_n+1] & agenachevent<.
replace `varlist'=`varlist'[_n-1] if `varlist'==. & agem<agevorevent & agevorevent<.
gsort persnr -year -agem
replace `varlist'=`varlist'[_n-1] if `varlist'==. & agem>=agevorevent & agevorevent<.
gsort persnr year agem
soep_gentransition_`varlist'
}


end
****************************************************************************
