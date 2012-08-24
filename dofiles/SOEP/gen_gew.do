version 10
capture log close
clear
set memory 800m
set more off
log using "$PW_workingdir\soep\proj\Monat\gen_gew.log",replace
use "$PW_workingdir\soep\proj\Monat\Monat-custom.dta", clear


recode phrf phrfd phrfg phrfall design (0=.f)
gen pgew = phrfall/ design
replace pgew = phrf/design if pgew>=.
replace pgew = phrfd/design if pgew>=.
replace pgew = phrfg/design if pgew>=.

forvalues y=1984/2007 {
	forvalues sam = 1/8 {
		quietly sum pgew if psample==`sam' & year==`y'
		quietly replace pgew=r(mean) if psample==`sam' & (design>=. | (pgew>=. & pop<=4)) & year==`y'
	}
}
bysort persnr (year): gen pgew1 = pgew[1]
bysort persnr (year): replace pgew1 = pgew[2] if pgew1>=. & pgew[2]<.
stset year,id(persnr) failure(year==.)
stfill pgew,forward
stset,clear
label var pgew "P-Gewicht ergänzt"
label var pgew1 "P-Gewicht Startwelle ergänzt"
keep hhnr persnr year pgew pgew1
save "$PW_workingdir\soep\proj\PGew.dta",replace