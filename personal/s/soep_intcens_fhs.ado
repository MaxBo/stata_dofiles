********** Program zur genierierung eines imputierten Event-Zeitpunktes bei intervallzensierten Daten ************
*! version 1.0  08jun2009
version 8
program define soep_intcens_fhs

*************** Führerschein-Events in der Mitte des Intervall-Zensierte Zeitraums generieren       ********

noi di "hallo"
quietly {
use "$PW_workingdir\soep\proj\FS\temp.dta", clear 


preserve

noisily di "imputiere Zeitpunkt des Führerschein-Erwerbs in der Mitte des intervall-zensierten Zeitraums"
drop if fhs>=.
soep_gentransition_fhs
//nimm Zeitpunkt des events in der Mitte des intervall-zensierten Zeitraums an
dropvars age*event 
gen agenachevent = .z
gen agevorevent = .z
// Annahme: Event passiert in der Mitte des intervall-zensierten Zeitraums
// Risk Set beginnt dabei mit 18. Geburtstag
replace agenachevent = 18+(agem-18)/2 if fhs>=2&fhs<. & agem[_n-1]<18
replace agenachevent = agem[_n-1]+(agem-agem[_n-1])/2 if fhs>=2&fhs<. & agem[_n-1]>=18
replace agevorevent = agenachevent[_n+1]
keep persnr year agevorevent agenachevent 
tempfile FSimpute
save `FSimpute',replace
restore

dropvars _merge age*event 
merge persnr year using `FSimpute', uniqusing nokeep sort update 

soep_intcens fhs 

**** Übergänge Pkw-Verfügbarkeit ***

recode ppkwverf (0=1) (1=2) (2=3),gen(pkw)
label var pkw "Pkw verfügbar"
label define l_pkw 1 "nie" 2 "zeitweise" 3 "immer",modify
label values pkw l_pkw

********** Annahme: keine Veränderung des Pkw-Besitzes, wenn Daten vor und nach dem missing gleich sind *******
noi di "imputiere Führerschein bei gleichem Pkw-Besitz vor und nach dem missing"
// imputiere vorwärts
gen pkwimpforw = pkw
sort persnr year
by persnr: replace pkwimpforw  = pkwimpforw[_n-1] if pkwimpforw>=.
// imputiere rückwärts
gen pkwimpbackw = pkw
gsort persnr -year
by persnr: replace pkwimpbackw = pkwimpbackw[_n-1] if pkwimpbackw>=.
// wenn beim nach oben und nach unten erweitern für einen missing das gleich rauskommt, dann übernimm diesen Wert
replace pkw=pkwimpforw if pkw>=. & pkwimpforw==pkwimpbackw
dropvars pkwimpforw pkwimpbackw

gsort persnr year agem

gen agefserwerb = agem if fhs[_n-1]==2 | (fhs==1&fhs[_n-1]==.)
replace agefserwerb = agefserwerb[_n-1] if (fhs==1|fhs==3) & agefserwerb==.
// bei verdoppelten Beobachtungen: setze pkw der ersten Beobachtung auf unbekannt
replace pkw=. if persnr==persnr[_n+1] & year==year[_n+1] & pkw[_n+1] != pkw[_n-1]

save "$PW_workingdir\soep\proj\FS\temp2.dta", replace 
use "$PW_workingdir\soep\proj\FS\temp2.dta", clear 



preserve
drop if pkw>=.
soep_gentransition_pkw

noi di "imputiere Zeitpunkt des Pkw-Erwerbs in der Mitte des intervall-zensierten Zeitraums"
dropvars age*event 
gen agenachevent = .z
gen agevorevent = .z

// Annahme: Pkw-Erwerb nach 1/3 des Intervalls nach dem (imputierten) Führerschein-Erwerb
replace agenachevent = agefserwerb +(agem-agefserwerb )/3 if pkw>=12&pkw<. & agem[_n-1]<agefserwerb 

// Annahme: Pkw-Erwerb in der Mitte des Intervalls, wenn kein Führerschein-Erwerb
replace agenachevent = agem[_n-1]+(agem-agem[_n-1])/2 if pkw>=12&pkw<. &(agem[_n-1]>=agefserwerb | agefserwerb==.)
replace agevorevent = agenachevent[_n+1]
keep persnr year agem agevorevent agenachevent 
tempfile Pkwimpute
save `Pkwimpute',replace

restore
dropvars _merge age*event 
merge persnr year agem using `Pkwimpute', uniqusing nokeep sort update 
soep_intcens pkw
gsort persnr year agem -fhs
// lösche zeitgleiche Beobachtungen
by persnr: replace pkw=21 if (pkw[_n-1]==2|pkw[_n-1]==12|pkw[_n-1]==32) & agem==agem[_n+1]
by persnr: replace pkw=31 if (pkw[_n-1]==3|pkw[_n-1]==13|pkw[_n-1]==23) & agem==agem[_n+1]
by persnr: drop if agem==agem[_n-1]
sort persnr agem year 
by persnr: drop if agem==agem[_n-1]
save "$PW_workingdir\soep\proj\FS\temp2.dta", replace 
*** bei Pkw immer und zeitweise: exit(fhs==3 time.) definieren *****
}





end
****************************************************************************
