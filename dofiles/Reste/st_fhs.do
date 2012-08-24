version 10
capture log close
clear
set memory 800m
set more off
log using "F:\DatenMaxDiss\data\pw\soep\proj\FS\st_fhs.log",replace
use "F:\DatenMaxDiss\data\pw\soep\proj\FS\FS-custom.dta", clear
sort persnr year
merge persnr year using "F:\DatenMaxDiss\data\pw\soep\proj\PGew.dta", uniqusing nokeep sort keep(pgew pgew1) 
drop _merge
merge persnr year using "F:\DatenMaxDiss\data\pw\soep\proj\Monat\Monat-custom.dta", uniqusing nokeep sort keep(gebmonat monatinterv female  mar eqnpers eqnkids eqnpers0014 eqnpers1518 hpers0_1 hpers2_4 hpers5_7 hpers8_10 hpers11_12 hpers13_15 heink_korr hinc_2007 pequivinc) 
drop _merge
merge persnr year using "F:\DatenMaxDiss\data\pw\soep\proj\employment\employment-custom.dta", uniqusing nokeep sort keep(unifhs taetig arbeitslos empstat jobchanged edu3 yrsed ) 
drop _merge



// codiere den Monat um
recode gebjahr (-1=.a)
recode gebmonat (-1=.a) (-3=.c)
gen float agem = year-gebjahr 
//Wenn Geburtstag nach Befragung, oder wenn Gebiurtsmonat unbekannt und Befragungsmonat in der 1. Jahreshälfte oder unbekannt und Alter > 0
replace monatinterv = 3 if monatinterv >=.
replace gebmonat = 6 if gebmonat >=.
replace gebmonat = monatinterv-1 if age==0 & gebmonat >= monatinterv 
replace agem = agem + (monatinterv - gebmonat)/12
label var agem "Alter"

// Personen ohne Alter/Geburtsjahr machen keinen Sinn bei der Auswertung
drop if agem >=.

// bilde Zeitspannen auf der Basis des Alters
snapspan persnr age agem year pgew pgew1 design psu strat ppkwverf hpkw01 hmotorrad pfhsmoped pfhsmotrad pfhslkw pfhspkw pfhs povzeitk pautobegeist povungern pfreizuhaus pumweltbew hpkw04, replace
//snapspan persnr agem pgew pgew1 design psu strat year gebjahr , replace

// imputiere Führerscheinbesitz aus Pkw-Verfügbarkeit
replace pfhspkw=1 if ppkwverf==1 | ppkwverf==2 // wenn Pkw-Verfügbarkeit, dann auch Pkw-Führerschein
replace pfhs=1 if ppkwverf==1 | ppkwverf==2 // wenn Pkw-Verfügbarkeit, dann auch Führerschein
//recode pfhs pfhspkw ppkwverf (.=0) if agem <18 // kein Führerschein und Auto unter 18
replace pfhs=0 if agem <18 // kein Führerschein und Auto unter 18
replace pfhspkw=0 if agem <18 // kein Führerschein und Auto unter 18
replace ppkwverf=0 if agem <18 // kein Führerschein und Auto unter 18


//backup der abhängigen Variablen, um später die Original-Missings wieder einspielen zu können
rename pfhs pfhs0
gen pfhs = pfhs0
label copy tp685x_DE l_pfhs
label values pfhs l_pfhs
label var pfhs "Führerschein"

rename pfhspkw pfhspkw0
gen pfhspkw = pfhspkw0
label copy tp683x_DE l_pfhspkw 
label values pfhspkw l_pfhspkw 
label var pfhspkw "Pkw-Führerschein"

rename ppkwverf ppkwverf0 
gen ppkwverf = ppkwverf0 
label copy xp686x_DE l_ppkwverf 
label values ppkwverf l_ppkwverf 
label var ppkwverf "Pkw-Verfügbarkeit"

rename povzeitk povzeitk0 
gen povzeitk = povzeitk0 
label copy tp687x_DE l_povzeitk 
label values povzeitk l_povzeitk 
label var povzeitk "ÖV-Zeitkarte"

// imputiere fehlende Werte zur Führerschein- und Pkw-Verfügbarkeit für Zwischenjahre
stset agem ,id(persnr) failure(gebjahr==.) origin(time 0) exit(time .)
format %4.1f _t _t0
stfill pfhs pfhspkw ppkwverf pgew povzeitk,forward
// fülle Führerscheinbesitz "rückwärts" (bis zum Alter 18)
gen agem1000 = 1000-agem
stset agem1000 ,id(persnr) failure(gebjahr==.) origin(time 0) exit(time 982)
gen _fhs=pfhs
gen _fhspkw=pfhspkw
stfill _fhs _fhspkw,forward

//bilde Variable pkwfs
recode ppkwverf (0=2) (1=3) (2=4),gen(pkwfs)
label define l_pkwfs 1 "kein Führerschein" 2 "Pkw nie, FHS" 3 "Pkw zeitweise" 4 "Pkw immer" .f "Pkw nie, FS unbekannt"/*
*/ 12 "k.FS->FS, Pkw nie" 13 "k.FS->Pkw zeitweise" 14 "k.FS->Pkw immer" 21 " nie,FS->kein FS" 23 "nie,FS->zeitw" 24 "nie,FS->immer" /*
*/ 31 "zeitw->k.FS" 32 "zeitw->nie,FS" 34 "zeitw->immer" 41 "immer->k.FS" 42 "immer->nie,FS" 43 "immer->zeitw" .a "keine Angabe"
label var pkwfs "Pkw/Führerschein"
label values pkwfs l_pkwfs
recode pkwfs (2=.f) if year==1997|year==2000|year==2002|year==2005|year==2007
replace pkwfs = 1 if _fhs==0
recode pkwfs (.f=2) if _fhs==1
dropvars agem1000 _fhs _fhspkw


sort persnr (year)

// codiere Ereignisse (Wechsel zwischen Zuständen) um und füge die Labels hierfür hinzu
// für den Führerscheinbesitz
label define l_pfhs 2 "Erwerb" 3 "Abgabe", add
label define l_pfhspkw 2 "Erwerb" 3 "Abgabe", add
by persnr (year): replace pfhs =2 if (pfhs[_n-1]==0 & pfhs[_n]==1 & _n!=1)
by persnr (year): replace pfhs =3 if ((pfhs[_n-1]==1 | pfhs[_n-1]==2) & pfhs[_n]==0  & _n!=1)
by persnr (year): replace pfhspkw =2 if (pfhspkw [_n-1]==0 & pfhspkw [_n]==1 & _n!=1)
by persnr (year): replace pfhspkw =3 if ((pfhspkw [_n-1]==1 | pfhspkw [_n-1]==2) & pfhspkw [_n]==0 & _n!=1)

// für dir Pkw-Verfügbarkeit
label define l_ppkwverf 3 "nie->zeitw" 4 "nie->immer" 5 "zeitw->immer" 6 "immer->zeitw" 7 "immer->nie" 8 "zeitw->nie", add
by persnr (year): replace ppkwverf = 3 if (ppkwverf [_n-1]==0 & ppkwverf [_n]==1 & _n!=1)
by persnr (year): replace ppkwverf = 4 if (ppkwverf [_n-1]==0 & ppkwverf [_n]==2 & _n!=1)
by persnr (year): replace ppkwverf = 5 if ((ppkwverf [_n-1]==1 | ppkwverf [_n-1]==3) & ppkwverf [_n]==2 & _n!=1)
by persnr (year): replace ppkwverf = 6 if ((ppkwverf [_n-1]==2 |ppkwverf [_n-1]==4 | ppkwverf [_n-1]==5) & ppkwverf [_n]==1 & _n!=1)
by persnr (year): replace ppkwverf = 7 if ((ppkwverf [_n-1]==2 |ppkwverf [_n-1]==4 | ppkwverf [_n-1]==5) & ppkwverf [_n]==0 & _n!=1)
by persnr (year): replace ppkwverf = 8 if ((ppkwverf [_n-1]==1 | ppkwverf [_n-1]==3 |ppkwverf [_n-1]==6) & ppkwverf [_n]==0 & _n!=1)

// für Pkw/Führerschein
by persnr (year): replace pkwfs= 12 if (pkwfs[_n-1]==1 & pkwfs[_n]==2 & _n!=1)
by persnr (year): replace pkwfs= 13 if (pkwfs[_n-1]==1 & pkwfs[_n]==3 & _n!=1)
by persnr (year): replace pkwfs= 14 if (pkwfs[_n-1]==1 & pkwfs[_n]==4 & _n!=1)
by persnr (year): replace pkwfs= 21 if ((pkwfs[_n-1]==2 | pkwfs[_n-1]==12) & pkwfs[_n]==1 & _n!=1)
by persnr (year): replace pkwfs= 23 if ((pkwfs[_n-1]==2 | pkwfs[_n-1]==12) & pkwfs[_n]==3 & _n!=1)
by persnr (year): replace pkwfs= 24 if ((pkwfs[_n-1]==2 | pkwfs[_n-1]==12) & pkwfs[_n]==4 & _n!=1)
by persnr (year): replace pkwfs= 31 if ((pkwfs[_n-1]==3 | pkwfs[_n-1]==13 | pkwfs[_n-1]==23) & pkwfs[_n]==1 & _n!=1)
by persnr (year): replace pkwfs= 32 if ((pkwfs[_n-1]==3 | pkwfs[_n-1]==13 | pkwfs[_n-1]==23) & pkwfs[_n]==2 & _n!=1)
by persnr (year): replace pkwfs= 34 if ((pkwfs[_n-1]==3 | pkwfs[_n-1]==13 | pkwfs[_n-1]==23) & pkwfs[_n]==4 & _n!=1)
by persnr (year): replace pkwfs= 41 if ((pkwfs[_n-1]==4 | pkwfs[_n-1]==14 | pkwfs[_n-1]==24 | pkwfs[_n-1]==34) & pkwfs[_n]==1 & _n!=1)
by persnr (year): replace pkwfs= 42 if ((pkwfs[_n-1]==4 | pkwfs[_n-1]==14 | pkwfs[_n-1]==24 | pkwfs[_n-1]==34) & pkwfs[_n]==2 & _n!=1)
by persnr (year): replace pkwfs= 43 if ((pkwfs[_n-1]==4 | pkwfs[_n-1]==14 | pkwfs[_n-1]==24 | pkwfs[_n-1]==34) & pkwfs[_n]==3 & _n!=1)


// für die Zeitkarten-Verfügbarkeit
label define l_povzeitk 3 "ja" 4 "Erwerb" 5 "Abgabe", add
recode povzeitk (1/2=3)
by persnr (year): replace povzeitk = 4 if (povzeitk[_n-1]==0 & povzeitk[_n]==3 & _n!=1)
by persnr (year): replace povzeitk = 5 if ((povzeitk[_n-1]==3 | povzeitk[_n-1]==4) & povzeitk[_n]==0 & _n!=1)


// spiele Original-Missings wieder zurück
replace pfhs = pfhs0 if pfhs0 >=.
replace pfhspkw= pfhspkw0 if pfhspkw0 >=.
replace ppkwverf= ppkwverf0 if ppkwverf0 >=.
replace povzeitk= povzeitk0 if povzeitk0 >=.
replace pkwfs= ppkwverf if ppkwverf >=. & pfhs>=.
recode pkwfs (1=.) if ppkwverf >=. & pfhs>=.


//list persnr gebjahr age _t0 _t  _d _st  pfhs ppkwverf in 1000/1300,noobs sepby(persnr)
// speichere als neuen Datensatz
dropvars _*
save "F:\DatenMaxDiss\data\pw\soep\proj\FS\FS-stfilled.dta",replace





// Führerschein-Besitz

set more off
use "F:\DatenMaxDiss\data\pw\soep\proj\FS\FS-stfilled.dta",clear
//lösche Jahre mit Missing Values der abhängigen Variablen
drop if pfhs>=.
dropvars pinc1000 pincln vollzeit teilzeit azubi studi arblos nichterwerb single
gen pinc1000 = pequivinc / 1000
gen pincln = ln(pequivinc)
gen vollzeit = taetig==1
gen teilzeit = taetig==2
gen azubi = taetig==3
gen studi = taetig==4
gen arblos = taetig==5
gen nichterwerb = taet==6
recode empstat (1 2 3 4 10=1) (5 6 7 8 9 11 12=0),gen(ewt)
label var ewt "reg. erwerbstätig/in Ausbildung"
recode eqnpers (1=1) (2/20=0),gen(single)

dropvars aged aged5
gen aged = int(agem) if agem>=18&agem<25
replace aged=0 if aged==.
gen aged5=int(agem/5)*5
gen aged2=int(agem/2)*2 if agem>=18&agem<30
replace aged2=0 if aged2==.

// Führerschein-Erwerb

//Setze Gewichtungsfaktor für Person auf pgew2 des Jahres, in dem Person ins "Risk-Set" eintritt
stset agem ,id(persnr) failure(pfhs=2) origin(time 18) enter(pfhs==0 3) exit(time .)
capture drop pgew2
gen pgew2 = pgew
//fülle erstmal das Gewicht den ersten relevanten Jahres bis unten auf 
stfill pgew2 ,base
// lösche dann die alten Gewichte 
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.



// Führerschein-Erwerb
stset agem [pw=pgew2],id(persnr) failure(pfhs=2) origin(time 18) enter(pfhs==0 3) exit(time .)
replace _st=0 if (pfhs==1 | pfhs==3)


//streg female pincln vollzeit teilzeit azubi studi arblos nichterwerb , dist(lognormal) ancillary(female vollzeit teilzeit azubi studi arblos nichterwerb pincln ) log 
streg female pincln , dist(lognormal) ancillary(female pincln ) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_logn,replace

//xi i.female*i.aged i.female*i.aged5 i.aged5*pincln

xi i.aged2*female i.aged5*female i.aged5*pincln,noomit

streg _Iaged2_20-_Iaged2_28  _IageXfema_18-_IageXfema_28 _Iaged5_30-_Iaged5_95   _IageXfemaa30-_IageXfemaa95 pincln _IageXpinc_20-_IageXpinc_95, dist(e) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_expdummy,replace



streg female, dist(gamma) ancillary(female) anc2(female) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_gamma,replace

streg female, dist(lognormal) ancillary(female) log from(a,skip) 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_logn,replace
mat a = e(b)
//streg female pincln , dist(gamma) ancillary(female pincln ) anc2(female pincln ) log from(a,skip) 

streg female pincln , dist(lognormal) ancillary(female) log 
tab povzeitk0,gen(povzk)
replace povzk2=1 if povzk3==1
streg female pincln , dist(lognormal) log from(a,skip) 
streg female pequivinc povzk2, dist(lognormal) log from(a,skip) 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_logn_inc_zeitk,replace

//Kappa ist mit .03 nicht signifikant von 0 verschieden, daher lognormal
//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_gamma18
//mat a = e(b)
//streg female, dist(gamma) log from(a,skip)
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_gamma18,replace

//stcox female pincln,basehc(h0)
//stcurve, hazard at1(female=0 pincln=7) at2(female=1 pincln=7) kernel(gaus) width(2)


// Führerschein-Abgabe
stset agem,id(persnr) failure(pfhs=3) origin(time 18) enter(pfhs==1 2) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(pfhs=3) origin(time 18) enter(pfhs==1 2) exit(time .)
replace _st=0 if (pfhs==0 | pfhs==2)

streg female pincln , dist(gompertz) ancillary(female pincln ) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz,replace

//xi i.female*i.aged i.female*i.aged5 i.aged5*pincln
xi i.aged2*female i.aged5*female i.aged5*pincln,noomit

streg _Iaged2_20-_Iaged2_28  _IageXfema_18-_IageXfema_28 _Iaged5_30-_Iaged5_95   _IageXfemaa30-_IageXfemaa95 pincln _IageXpinc_20-_IageXpinc_95, dist(e) log

streg _Iaged5_15-_Iaged5_90  _IageXfemaa15-_IageXfemaa95 pincln  _IageXpinc_20-_IageXpinc_80, dist(e) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_expdummy,replace


sts graph, hazard by(female) kernel(gaussian)

capture drop w8085 m8085 w85 m85
gen w8085=(female==1)*(agem>=80&agem<85)
gen m8085=(female==0)*(agem>=80&agem<85)
gen w85=(female==1)*(agem>=85&agem<.)
gen m85=(female==0)*(agem>=85&agem<.)

streg female m85,  dist(gompertz) ancillary(female m85) log


local agesplit 70
capture drop agem`agesplit' agem`agesplit'2
gen agem`agesplit'=(agem-`agesplit')*(agem>`agesplit')
gen agem`agesplit'2= agem`agesplit'^2
local agesplit 75
capture drop agem`agesplit'male agem`agesplit'male2
gen agem`agesplit'male=(agem-`agesplit')*(agem>`agesplit')*(female==0)
gen agem`agesplit'male2= agem`agesplit'male^2

gen nopkw = ppkwverf==0
gen pkwabgabe= (ppkwverf==7 | ppkwverf==8)


local agesplit 70
streg female  agem`agesplit'2  pincln,  dist(gompertz) anc(female agem`agesplit'2 )  log trace 
//streg female  agem`agesplit'2  pincln pkwabgabe if (nopkw | pkwabgabe),  dist(gompertz) anc(female agem`agesplit'2 )  log trace from(a,skip)
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz_age`agesplit'80male2,replace


capture drop agemln
gen agemln= ln(agem)/ln(100)
local ln18 = ln(18)/ln(100)
stset agemln [pw=pgew2],id(persnr) failure(pfhs=3) origin(time `ln18') enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0
streg female,  dist(gompertz) ancillary(female) log

capture drop agemxx3
local betax3 -0.0000002
gen agemxx3 = agem + `betax3'*agem^4
local xx318 = 18 + `betax3'*18^4
stset agemxx3 [pw=pgew2],id(persnr) failure(pfhs=3) origin(time `xx318') enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0
streg female,  dist(gompertz) ancillary(female) log

capture drop agemexp15
gen agemexp15 = exp(agem/15)
local exp18 = exp(18/15)
stset agemexp15 [pw=pgew2],id(persnr) failure(pfhs=3) origin(time `exp18') enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0
streg female,  dist(gompertz) ancillary(female) log


//2 Durchläufe - einmal für Personen bis 70 und einmal über 70
local agesplit 70

stset agem [pw=pgew2],id(persnr) failure(pfhs=3) origin(time 18) enter(pfhs==1 2) exit(time `agesplit')
replace _st=0 if pfhs==0
streg female,  dist(gompertz) ancillary(female) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18`agesplit',replace
local agesplit 70

stset agem [pw=pgew2],id(persnr) failure(pfhs=3) origin(time `agesplit') enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0
streg female,  dist(gompertz) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz`agesplit',replace

//drop if _st==0
//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18
//mat a = e(b)
// Weibull hat bei weitem den besten Model-Fit, die Residuen weichen aber deutlich ab.
streg female,  dist(weibull) ancillary(female) log time
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_weibull18,replace
estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_weibull18

streg female,  dist(gompertz) log
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18,replace
//streg female,  dist(loglogistic) ancillary(female) log 
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_LogLogistic18,replace

//gamma-Funktion konvergiert nicht, Kappa läuft immer höher, irgendwann kommt "discontinous region encountered"
//streg female,  dist(gamma)  log trace from(/_t=4.5 /ln_sig=-1 /kappa=2)
//streg female,  dist(gamma) ancillary(female)  log trace from([_t]female=-2.1 [_t]_cons=-7.5 [ln_sig]_female=.42 [ln_sig]_cons=.46 [kappa]_cons=1)//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gamma18,replace
//streg female,  dist(gamma) ancillary(female) anc2(female) log trace

streg female,  dist(lognormal) ancillary(female)  log trace 
stset agem [pw=pgew2],id(persnr) failure(pfhs=3) origin(time 18) enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0



//teste Residuen: Im oberen Bereich der cumhazard-Kurve
est use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_weibull18
predict resi,csnell
stset resi,failure(pfhs=3)
sts gen km=s
gen cumhaz = -ln(km)
line cumhaz resi resi , sort name("weibull, replace") legend(off) t1(Weibull) xtitle("")
drop cumhaz resi km

stset agem [pw=pgew2],id(persnr) failure(pfhs=3) origin(time 18) enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0
est use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18
predict resi,csnell
stset resi,failure(pfhs=3)
sts gen km=s
gen cumhaz = -ln(km)
line cumhaz resi resi , sort name("gompertz, replace") legend(off) t1(Gompertz) xtitle("")
drop cumhaz resi km



// Pkw-Führerschein

set more off
use "F:\DatenMaxDiss\data\pw\soep\proj\FS\FS-stfilled.dta",clear
//lösche Jahre mit Missing Values der abhängigen Variablen
drop if pfhspkw>=.
gen pincln = ln(pequivinc)
gen pinc1000 = pequivinc / 1000

// Pkw-Führerschein-Erwerb

//Setze Gewichtungsfaktor für Person auf pgew2 des Jahres, in dem Person ins "Risk-Set" eintritt
stset agem ,id(persnr) failure(pfhspkw=2) origin(time 18) enter(pfhspkw==0 3) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.



stset agem [pw=pgew2],id(persnr) failure(pfhspkw=2) origin(time 18) enter(pfhspkw==0 3) exit(time .)
replace _st=0 if (pfhspkw==1 | pfhspkw==3)

streg female, dist(lognormal) ancillary(female)  log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSPkw_logn,replace

//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_gamma18
//mat a = e(b)
//streg female, dist(gamma) log 
// from(a) skip 
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSPkw_gamma18,replace


// Pkw-Führerschein-Abgabe
stset agem,id(persnr) failure(pfhspkw=3) origin(time 18) enter(pfhspkw==1 2) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(pfhspkw=3) origin(time 18) enter(pfhspkw==1 2) exit(time .)
replace _st=0 if (pfhspkw==0 | pfhspkw==2)

estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18
mat a = e(b)
streg female,  dist(gompertz) ancillary(female) from(a) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSPkwAbgabe_gompertz18,replace
estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_weibull18
mat a = e(b)
streg female,  dist(weibull) ancillary(female) log from(a)
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSPkwAbgabe_weibull18,replace
//Gamma-Funktion geht auch mit dieser Stichprobe nicht
//streg female,  dist(gamma) ancillary(female)



// Pkw-Verfügbarkeit

set more off
use "F:\DatenMaxDiss\data\pw\soep\proj\FS\FS-stfilled.dta",clear
//lösche Jahre mit Missing Values der abhängigen Variablen
drop if ppkwverf>=.
dropvars pinc1000 pincln vollzeit teilzeit azubi studi arblos nichterwerb 
gen pinc1000 = pequivinc / 1000
gen pincln = ln(pequivinc)
gen vollzeit = taetig==1
gen teilzeit = taetig==2
gen azubi = taetig==3
gen studi = taetig==4
gen arblos = taetig==5
gen nichterwerb = taet==6

// von Pkw_nie zu Pkw_gelegentlich oder immer

stset agem,id(persnr) failure(ppkwverf=3 4) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=3 4) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
replace _st=0 if (ppkwverf!=0 & ppkwverf != 3 & ppkwverf != 4)

streg female pincln vollzeit teilzeit azubi studi arblos nichterwerb, dist(lognormal) ancillary(female vollzeit teilzeit azubi studi arblos nichterwerb) log 

//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_12_gamma18
//mat a = e(b)
streg female, dist(gamma) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_12_gamma18,replace
streg female, dist(lognormal) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_12_logn18,replace
streg female, dist(lognormal) ancillary(female) log
streg female pincln, dist(lognormal) ancillary(female) log from(a)
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_12_logn18,replace



// von Pkw_nie zu Pkw_gelegentlich

stset agem,id(persnr) failure(ppkwverf=3) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=3) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
replace _st=0 if (ppkwverf!=0 & ppkwverf != 3 & ppkwverf != 4)

//drop if _st==0
//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_1_gamma18
//mat A = e(b)
streg female pincln, dist(lognormal) ancillary(female pincln) log from(A)
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_1_logn,replace

// von Pkw_nie zu Pkw_immer

stset agem,id(persnr) failure(ppkwverf=4) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=4) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
replace _st=0 if (ppkwverf!=0 & ppkwverf != 3 & ppkwverf != 4)

//mat a = e(b)
streg female pincln, dist(lognormal) ancillary(female pincln) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_2_logn,replace

//gamma-Funktion konvergiert nicht, kappa geht gegen 0 (.002), daher lognormale Funktion, auch wenn der LL deutlich schlechter ist.
//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_2_gamma18
//streg , dist(gamma) log trace technique(bhhh) from(1.2 .15 .01,copy)
//streg female, dist(gamma) ancillary(female) log trace technique(bhhh) from(a,skip) difficult
//mat a = e(b)
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_2_gamma18,replace

// von Pkw_gelegentlich zu Pkw_immer

stset agem,id(persnr) failure(ppkwverf=5) origin(time 18) enter(ppkwverf==1 3 6) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=5) origin(time 18) enter(ppkwverf==1 3 6) exit(time .)
replace _st=0 if (ppkwverf!=1 & ppkwverf!=5 & ppkwverf!=8)

//lognormal fittet besser als loglogistic
streg female pincln, dist(lognormal) ancillary(female pincln) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_2_logn,replace
estimates store lognPkwV1_2

streg female pincln, dist(loglogistic) ancillary(female pincln) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_2_loglog,replace
estimates store loglogPkwV1_2

//weibull und gamma geben positive Log-Likeliehood-Werte
streg female pincln, dist(weibull) ancillary(female pincln) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_2_weibull,replace
estimates store weibPkwV1_2

streg female pincln, dist(gamma) ancillary(female pincln) anc2(female ) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_2_gamma,replace
estimates store gamPkwV1_2

streg female pincln, dist(gompertz) ancillary(female pincln) log 
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_2_gompertz,replace
estimates store gompPkwV1_2



// von Pkw_gelegentlich zu Pkw_nie

stset agem,id(persnr) failure(ppkwverf=8) origin(time 18) enter(ppkwverf==1 3 6) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
stfill pgew2 ,base
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=8) origin(time 18) enter(ppkwverf==1 3 6) exit(time .)
replace _st=0 if (ppkwverf!=1 & ppkwverf!=5 & ppkwverf!=8)

//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_0_gamma18
//mat a = e(b)
streg female, dist(gamma) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_0_gamma18,replace
streg female, dist(gompertz) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_0_gompertz18,replace
estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_0_gompertz18
mat a = e(b)
streg female, dist(gompertz) ancillary(female) log from(a) skip
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_0_anc_fem_gompertz18,replace
streg female, dist(weibull) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf1_0_weibull18,replace

// von Pkw_immer zu Pkw_gelegentlich 

stset agem ,id(persnr) failure(ppkwverf=6) origin(time 18) enter(ppkwverf==2 4 5) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
stfill pgew2 ,base
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=6) origin(time 18) enter(ppkwverf==2 4 5) exit(time .)
replace _st=0 if (ppkwverf!=2 & ppkwverf!=6 & ppkwverf!=7)

//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_1_gamma18
//mat a = e(b)
streg female, dist(gamma) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_1_gamma18,replace
streg female, dist(gompertz)log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_1_gompertz18,replace
estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_1_gompertz18
mat a = e(b)
streg female, dist(gompertz) ancillary(female) log from(a) skip
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_1_anc_fem_gompertz18,replace
streg female, dist(weibull) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_1_weibull18,replace

// von Pkw_immer zu Pkw_nie 

stset agem,id(persnr) failure(ppkwverf=7) origin(time 18) enter(ppkwverf==2 4 5) exit(time .)
capture drop pgew2
gen pgew2 = pgew
stfill pgew2 ,base
replace pgew2 = . if _st==0
stfill pgew2 ,base
bysort persnr (year): replace pgew2 = pgew2[_N] if pgew2==.

stset agem [pw=pgew2],id(persnr) failure(ppkwverf=7) origin(time 18) enter(ppkwverf==2 4 5) exit(time .)
replace _st=0 if (ppkwverf!=2 & ppkwverf!=6 & ppkwverf!=7)

sts graph, hazard by(female) kernel(gaussian)

capture drop w8085 m8085 w85 m85
gen w8085=(female==1)*(agem>=80&agem<85)
gen m8085=(female==0)*(agem>=80&agem<85)
gen w85=(female==1)*(agem>=85&agem<.)
gen m85=(female==0)*(agem>=85&agem<.)

streg female  m85, dist(gompertz) ancillary(female m85) log


set more off
estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_0_gamma18
mat a = e(b)
streg female, dist(gamma) log from(a) skip
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_0_gamma18,replace
streg female, dist(gamma) ancillary(female) log from(a) skip
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_0_anc_fem_gamma18,replace
streg female, dist(gompertz) ancillary(female) log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_0_gompertz18,replace
streg female, dist(weibull) ancillary(female)  log
estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf2_0_weibull18,replace

log close

// Berechne hazard-rates und Führerschein/Nicht-Führerschein-Besitz

preserve
drop if _n>0
set obs 4800
//initialisiere Variablen: 4800 Fälle 4*(0-100 Jahre)*12 Monate
dropvars sam aged aged2 aged5 pkwabgabe single pinc1000 pincln ewt vollzeit teilzeit azubi studi arblos nichterwerb efh shop10 grossstadt 
gen sam = int((_n-1)/1200)
replace agem = mod((_n-1)/12,100)
gen aged = int(agem) if agem>18&agem<25
replace aged=0 if aged==.
gen aged5=int(agem/5)*5
gen aged2=int(agem/2)*2 if agem>=18&agem<30
replace aged2=0 if aged2==.

gen pkwabgabe=1
gen pinc1000 = pequivinc / 1000
gen pincln = ln(pequivinc)
gen single=0
gen ewt=0
gen vollzeit = 0
gen teilzeit = 0
gen azubi = 0
gen studi = 0
gen arblos = 0
gen nichterwerb = 0
gen efh=0
gen shop10=1
gen grossstadt=1
replace _t = agem-18
replace _t0=_t[_n-1] if _t>0
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace female = 0 if sam<2
replace female = 1 if sam>=2


replace pincln = ln(1000) if sam==0|sam==2
replace pincln = ln(2000) if sam==1|sam==3

xi i.aged2*female i.aged5*female i.aged5*pincln,noomit


dropvars h01 h10 s0 s1 erwerber abgeber 
//berechne hazard-rates für den Führerschein-Erwerb

estimates use "F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_expdummy"
//estimates use "F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_logn"
predict h01,hazard
//berechne hazard-rates für die Führerschein-Abgabe
estimates use "F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_expdummy"
//estimates use "F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz"
predict h10,hazard

twoway (line h01 h10 agem if sam==0) (line h01 h10 agem if sam==1) (line h01 h10 agem if sam==2) (line h01 h10 agem if sam==3)

//initialisiere: am 18. Geburtstag ist "kein Führerschein" = 100% und "Führerschein-Besitz" = 0%
gen s0=1
gen s1=0
sort sam persnr
gen erwerber = 0
gen abgeber = 0
forvalues nn=1/1200 {
	if mod(`nn',100)==0 {
		di `nn'
	}
	quietly {
		//berechne Erwerber und Abgeber
		by sam: replace erwerber = s0[_n-1]*h01*(1/12) if h01<. & _n==`nn'
		by sam: replace abgeber = s1[_n-1]*h10*(1/12) if h10<. & _n==`nn'
		by sam: replace s0= s0[_n-1]-erwerber+abgeber if _n==`nn' & abgeber <.
		by sam: replace s1= s1[_n-1]+erwerber-abgeber if _n==`nn' & abgeber <. 
	}
}
replace s0=1-s0
twoway (line s0 agem if sam==0) (line s0 agem if sam==1) (line s0 agem if sam==2) (line s0 agem if sam==3)
gen ss0 = s0
twoway (line s0 agem if sam==0) (line s0 agem if sam==1) (line s0 agem if sam==2) (line s0 agem if sam==3) /*
*/(line ss0 agem if sam==0) (line ss0 agem if sam==1) (line ss0 agem if sam==2) (line ss0 agem if sam==3) 
restore

//replace ewt =1 if ((agem>=18 & agem<40) | (agem>=43 & agem<63)) & (sam==1 | sam==3)
//replace ewt =1 if ((agem>=28 & agem<40) | (agem>=50 & agem<63)) & (sam==0 | sam==2)
replace single=1 if (sam==1 | sam==3)

//replace azubi =1 if agem<22 & (sam==1 | sam==3)
//replace vollzeit =1 if (agem>=22 & agem<40) & (sam==1 | sam==3)
//replace arblos =1 if (agem>=40 & agem<43) & (sam==1 | sam==3)
//replace vollzeit =1 if (agem>=43 & agem<63) & (sam==1 | sam==3)
//replace nichterwerb =1 if (agem>=63 & agem<.) & (sam==1 | sam==3)

//replace nichterwerb =1 if agem<21 & (sam==0 | sam==2)
//replace studi =1 if (agem>=21 & agem<29) & (sam==0 | sam==2)
//replace vollzeit =1 if (agem>=29 & agem<34) & (sam==0 | sam==2)
//replace nichterwerb  =1 if (agem>=34 & agem<37) & (sam==0 | sam==2)
//replace teilzeit =1 if (agem>=37 & agem<47) & (sam==0 | sam==2)
//replace vollzeit =1 if (agem>=47 & agem<65) & (sam==0 | sam==2)
//replace nichterwerb =1 if (agem>=65 & agem<.) & (sam==0 | sam==2)



local diffvar "female"
//replace efh=1 if (sam==1 | sam==3)
//replace shop10=0 if (sam==1 | sam==3)
//replace grossstadt=0 if (sam==1 | sam==3)
//replace `diffvar' =1 if (sam==1 | sam==3)

replace pequivinc = 1100
replace pincln=ln(pequivinc )
//replace pincln=ln(650) if (sam==0 | sam==2)
//replace pincln=ln(2000) if (sam==1 | sam==3)
replace persnr = _n
dropvars hmale_low hmale_high hfemale_low hfemale_high
predict hmale_low if female==0 & (sam==0 | sam==2) ,hazard //surv
gen smalelow=1
sort sam persnr
by sam: replace smalelow= smalelow[_n-1]*(1-(hmale_low*(.1)))  if _st==1 & agem >18
replace smalelow=1-smalelow
predict hmale_high if female==0 & (sam==1 | sam==3) ,hazard
gen smalehigh=1
sort sam persnr
by sam: replace smalehigh= smalehigh[_n-1]*(1-(hmale_high*(.1)))  if _st==1 & agem >18
replace smalehigh=1-smalehigh
predict hfemale_low if female==1 & (sam==0 | sam==2) ,hazard //hazard
gen sfemalelow=1
sort sam persnr
by sam: replace sfemalelow= sfemalelow[_n-1]*(1-(hfemale_low*(.1)))  if _st==1 & agem >18
replace sfemalelow=1-sfemalelow
predict hfemale_high if female==1 & (sam==1 | sam==3) ,hazard
gen sfemalehigh=1
sort sam persnr
by sam: replace sfemalehigh= sfemalehigh[_n-1]*(1-(hfemale_high*(.1)))  if _st==1 & agem >18
replace sfemalehigh=1-sfemalehigh

label var hmale_low "Männer, `diffvar'=0"
label var hmale_high "Männer, `diffvar'=1"
label var hfemale_low "Frauen, `diffvar'=0"
label var hfemale_high "Frauen, `diffvar'=1"
line smalelow smalehigh sfemalelow sfemalehigh hmale_low hmale_high hfemale_low hfemale_high agem if agem<=95&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)95,grid) xlabel(15(5)95)  ymtick(0(.01).25,grid) 
restore



preserve
drop if _n>0
set obs 4000
gen sam = int((_n-1)/1000)
replace agem = mod((_n-1)/10,100)
gen pkwabgabe=1
dropvars single pinc1000 pincln ewt vollzeit teilzeit azubi studi arblos nichterwerb efh shop10 grossstadt 
gen pinc1000 = pequivinc / 1000
gen pincln = ln(pequivinc)

gen single=0
gen ewt=0
gen vollzeit = 0
gen teilzeit = 0
gen azubi = 0
gen studi = 0
gen arblos = 0
gen nichterwerb = 0
gen efh=0
gen shop10=1
gen grossstadt=1
replace _t = agem-18
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=_t[_n-1] // //0
replace female = 0 if sam<2
replace female = 1 if sam>=2

//replace ewt =1 if ((agem>=18 & agem<40) | (agem>=43 & agem<63)) & (sam==1 | sam==3)
//replace ewt =1 if ((agem>=28 & agem<40) | (agem>=50 & agem<63)) & (sam==0 | sam==2)
replace single=1 if (sam==1 | sam==3)

//replace azubi =1 if agem<22 & (sam==1 | sam==3)
//replace vollzeit =1 if (agem>=22 & agem<40) & (sam==1 | sam==3)
//replace arblos =1 if (agem>=40 & agem<43) & (sam==1 | sam==3)
//replace vollzeit =1 if (agem>=43 & agem<63) & (sam==1 | sam==3)
//replace nichterwerb =1 if (agem>=63 & agem<.) & (sam==1 | sam==3)

//replace nichterwerb =1 if agem<21 & (sam==0 | sam==2)
//replace studi =1 if (agem>=21 & agem<29) & (sam==0 | sam==2)
//replace vollzeit =1 if (agem>=29 & agem<34) & (sam==0 | sam==2)
//replace nichterwerb  =1 if (agem>=34 & agem<37) & (sam==0 | sam==2)
//replace teilzeit =1 if (agem>=37 & agem<47) & (sam==0 | sam==2)
//replace vollzeit =1 if (agem>=47 & agem<65) & (sam==0 | sam==2)
//replace nichterwerb =1 if (agem>=65 & agem<.) & (sam==0 | sam==2)



local diffvar "female"
//replace efh=1 if (sam==1 | sam==3)
//replace shop10=0 if (sam==1 | sam==3)
//replace grossstadt=0 if (sam==1 | sam==3)
//replace `diffvar' =1 if (sam==1 | sam==3)

replace pequivinc = 1100
replace pincln=ln(pequivinc )
//replace pincln=ln(650) if (sam==0 | sam==2)
//replace pincln=ln(2000) if (sam==1 | sam==3)
replace persnr = _n
dropvars hmale_low hmale_high hfemale_low hfemale_high
predict hmale_low if female==0 & (sam==0 | sam==2) ,hazard //surv
gen smalelow=1
sort sam persnr
by sam: replace smalelow= smalelow[_n-1]*(1-(hmale_low*(.1)))  if _st==1 & agem >18
replace smalelow=1-smalelow
predict hmale_high if female==0 & (sam==1 | sam==3) ,hazard
gen smalehigh=1
sort sam persnr
by sam: replace smalehigh= smalehigh[_n-1]*(1-(hmale_high*(.1)))  if _st==1 & agem >18
replace smalehigh=1-smalehigh
predict hfemale_low if female==1 & (sam==0 | sam==2) ,hazard //hazard
gen sfemalelow=1
sort sam persnr
by sam: replace sfemalelow= sfemalelow[_n-1]*(1-(hfemale_low*(.1)))  if _st==1 & agem >18
replace sfemalelow=1-sfemalelow
predict hfemale_high if female==1 & (sam==1 | sam==3) ,hazard
gen sfemalehigh=1
sort sam persnr
by sam: replace sfemalehigh= sfemalehigh[_n-1]*(1-(hfemale_high*(.1)))  if _st==1 & agem >18
replace sfemalehigh=1-sfemalehigh

label var hmale_low "Männer, `diffvar'=0"
label var hmale_high "Männer, `diffvar'=1"
label var hfemale_low "Frauen, `diffvar'=0"
label var hfemale_high "Frauen, `diffvar'=1"
line smalelow smalehigh sfemalelow sfemalehigh hmale_low hmale_high hfemale_low hfemale_high agem if agem<=95&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)95,grid) xlabel(15(5)95)  ymtick(0(.01).25,grid) 
restore


preserve
drop if _n>0
set obs 4000
replace agem = mod((_n-1)/10,100)
dropvars w8085 m8085 w85 m85
gen w8085=(female==1)*(agem>=80&agem<85)
gen m8085=(female==0)*(agem>=80&agem<85)
gen w85=(female==1)*(agem>=85&agem<.)
gen m85=(female==0)*(agem>=85&agem<.)
local agesplit 70
dropvars agem`agesplit' agem`agesplit'2
gen agem`agesplit'=(agem-`agesplit')*(agem>`agesplit')
gen agem`agesplit'2= agem`agesplit'
local agesplit 75
dropvars agem`agesplit'male agem`agesplit'male2 pkwabgabe
gen agem`agesplit'male=(agem-`agesplit')*(agem>`agesplit')*(female==0)
gen agem`agesplit'male2= agem`agesplit'male^2
gen pkwabgabe=1
dropvars pinc1000 pincln vollzeit teilzeit azubi studi nojob  efh shop10 grossstadt 
gen pinc1000 = pequivinc / 1000
gen pincln = ln(pequivinc)

gen vollzeit = 0
gen teilzeit = 0
gen azubi = 0
gen studi = 0
gen nojob = 0
gen efh=0
gen shop10=1
gen grossstadt=1
replace _t = agem-18
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=0 //_t[_n-1]
replace female = 0 if _n<=2000
replace female = 1 if _n>2000

//replace pincln=ln(650) if _n<=1000 | (_n>2000 & _n<=3000)
//replace pincln=ln(2000) if (_n>1000 & _n<=2000) | _n>3000

local diffvar "azubi"
//replace efh=1 if (_n>1000 & _n<=2000) | _n>3000
//replace shop10=0 if (_n>1000 & _n<=2000) | _n>3000
//replace grossstadt=0 if (_n>1000 & _n<=2000) | _n>3000
replace `diffvar' =1 if (_n>1000 & _n<=2000) | _n>3000

replace pequivinc = 1100
replace pincln=ln(pequivinc )
replace persnr = _n
dropvars hmale_low hmale_high hfemale_low hfemale_high
predict hmale_low if female==0 & `diffvar'==0  ,hazard //surv
predict hmale_high if female==0 & `diffvar'==1  ,hazard
predict hfemale_low if female==1 & `diffvar'==0  ,surv //hazard
predict hfemale_high if female==1 & `diffvar'==1  ,surv 
label var hmale_low "Männer, `diffvar'=0"
label var hmale_high "Männer, `diffvar'=1"
label var hfemale_low "Frauen, `diffvar'=0"
label var hfemale_high "Frauen, `diffvar'=1"
line hmale_low hmale_high hfemale_low hfemale_high agem if agem<=95&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)95,grid) xlabel(15(5)95)  ymtick(0(.01).25,grid) 
restore




preserve
drop if _n>0
set obs 4000
replace agem = mod((_n-1)/10,100)
local agesplit 70
capture drop agem`agesplit' agem`agesplit'2
gen agem`agesplit'=(agem-`agesplit')*(agem>`agesplit')
gen agem`agesplit'2= agem`agesplit'
local agesplit 75
capture drop agem`agesplit'male agem`agesplit'male2 pkwabgabe
gen agem`agesplit'male=(agem-`agesplit')*(agem>`agesplit')*(female==0)
gen agem`agesplit'male2= agem`agesplit'male^2
gen pkwabgabe=1
capture drop  efh shop10 grossstadt
gen efh=0
gen shop10=1
gen grossstadt=1
replace _t = agem-18
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=_t[_n-1] if _n!=0
replace female = 0 if _n<=2000
replace female = 1 if _n>2000

replace pincln=ln(650) if _n<=1000 | (_n>2000 & _n<=3000)
replace pincln=ln(2000) if (_n>1000 & _n<=2000) | _n>3000

replace pequivinc = 1100
replace persnr = _n
capture drop hmale_low
capture drop hmale_high
capture drop hfemale_low
capture drop hfemale_high
predict hmale_low if female==0 & pincln <= ln(500)+1 ,hazard
predict hmale_high if female==0 & pincln > ln(500)+1 ,hazard
predict hfemale_low if female==1 & pincln <= ln(500)+1 ,hazard
predict hfemale_high if female==1 & pincln > ln(500)+1 ,hazard
label var hmale_low "Männer, 650 €"
label var hmale_high "Männer, 2000 €"
label var hfemale_low "Frauen, 650 €"
label var hfemale_high "Frauen, 2000 €"
line hmale_low hmale_high hfemale_low hfemale_high agem if agem<=95&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)95,grid) xlabel(15(5)95)  ymtick(0(.01).25,grid) 
restore

preserve
local lnnr 100
drop if _n>0
set obs 4000
replace agem = mod((_n-1)/10,100)
capture drop agemln
gen agemln = ln(agem)/ln(`lnnr')
replace _t = agemln -ln(18)/ln(`lnnr')
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=_t[_n-1] if _n!=0
replace female = 0 if _n<=2000
replace female = 1 if _n>2000
replace pincln=ln(500) if _n<=1000 | (_n>2000 & _n<=3000)
replace pincln=ln(2000) if (_n>1000 & _n<=2000) | _n>3000
replace pequivinc = 1100
replace persnr = _n
capture drop hmale_low
capture drop hmale_high
capture drop hfemale_low
capture drop hfemale_high
predict hmale_low if female==0 & pincln <= ln(500)+1 ,hazard
predict hmale_high if female==0 & pincln > ln(500)+1 ,hazard
predict hfemale_low if female==1 & pincln <= ln(500)+1 ,hazard
predict hfemale_high if female==1 & pincln > ln(500)+1 ,hazard
replace hmale_low =hmale_low / (ln(`lnnr')*agem)
replace hfemale_low =hfemale_low / (ln(`lnnr')*agem)
replace hmale_high =hmale_high / (ln(`lnnr')*agem)
replace hfemale_high =hfemale_high / (ln(`lnnr')*agem)
label var hmale_low "Männer, 500 €"
label var hmale_high "Männer, 2000 €"
label var hfemale_low "Frauen, 500 €"
label var hfemale_high "Frauen, 2000 €"
line hmale_low hmale_high hfemale_low hfemale_high agem if agem<=90&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)85,grid) xlabel(15(5)85)  ymtick(0(.01).25,grid) 
restore


preserve
local betax3 -0.0000002
drop if _n>0
set obs 4000
replace agem = mod((_n-1)/10,100)
capture drop agemxx3
gen agemxx3 = agem + `betax3'*agem^4
replace _t = agemxx3 -(18 + `betax3'*18^4)
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=_t[_n-1] if _n!=0
replace female = 0 if _n<=2000
replace female = 1 if _n>2000
replace pincln=ln(500) if _n<=1000 | (_n>2000 & _n<=3000)
replace pincln=ln(2000) if (_n>1000 & _n<=2000) | _n>3000
replace pequivinc = 1100
replace persnr = _n
capture drop hmale_low
capture drop hmale_high
capture drop hfemale_low
capture drop hfemale_high
predict hmale_low if female==0 & pincln <= ln(500)+1 ,hazard
predict hmale_high if female==0 & pincln > ln(500)+1 ,hazard
predict hfemale_low if female==1 & pincln <= ln(500)+1 ,hazard
predict hfemale_high if female==1 & pincln > ln(500)+1 ,hazard
replace hmale_low =hmale_low / (1+4*`betax3'*agem^3)
replace hfemale_low =hfemale_low / (1+4*`betax3'*agem^3)
replace hmale_high =hmale_high / (1+4*`betax3'*agem^3)
replace hfemale_high =hfemale_high / (1+4*`betax3'*agem^3)
label var hmale_low "Männer, 500 €"
label var hmale_high "Männer, 2000 €"
label var hfemale_low "Frauen, 500 €"
label var hfemale_high "Frauen, 2000 €"
line hmale_low hmale_high hfemale_low hfemale_high agem if agem<=90&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)85,grid) xlabel(15(5)85)  ymtick(0(.01).25,grid) 
restore



preserve
local agesplit 70
drop if _n>0
set obs 4000
replace agem = mod((_n-1)/10,100)
replace pincln=ln(500) if _n<=1000 | (_n>2000 & _n<=3000)
replace pincln=ln(2000) if (_n>1000 & _n<=2000) | _n>3000
replace pequivinc = 1100
replace persnr = _n
replace female = 0 if _n<=2000
replace female = 1 if _n>2000

estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18`agesplit'
replace _t = agem-18
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=_t[_n-1] if _n!=0
capture drop hmale_low
capture drop hmale_high
capture drop hfemale_low
capture drop hfemale_high
predict hmale_low if female==0 & pincln <= ln(500)+1 & agem<`agesplit',hazard
predict hmale_high if female==0 & pincln > ln(500)+1 & agem<`agesplit',hazard
predict hfemale_low if female==1 & pincln <= ln(500)+1 & agem<`agesplit',hazard
predict hfemale_high if female==1 & pincln > ln(500)+1 & agem<`agesplit',hazard
capture drop hmale_low0
capture drop hmale_high0
capture drop hfemale_low0
capture drop hfemale_high0
gen hmale_low0 = hmale_low
gen hmale_high0 = hmale_high
gen hfemale_low0 = hfemale_low
gen hfemale_high0 = hfemale_high

estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz`agesplit'
replace _t = agem-`agesplit'
replace _t=. if _t<0
replace _st=1 if agem >=`agesplit'
replace _st=0 if agem <`agesplit'
replace _t0=_t[_n-1] if _n!=0
capture drop hmale_low
capture drop hmale_high
capture drop hfemale_low
capture drop hfemale_high
predict hmale_low if female==0 & pincln <= ln(500)+1 & agem>=`agesplit'&agem<90,hazard
predict hmale_high if female==0 & pincln > ln(500)+1 & agem>=`agesplit'&agem<90,hazard
predict hfemale_low if female==1 & pincln <= ln(500)+1 & agem>=`agesplit'&agem<90,hazard
predict hfemale_high if female==1 & pincln > ln(500)+1 & agem>=`agesplit'&agem<90,hazard
replace hmale_low0 = hmale_low if agem>=`agesplit'
replace hmale_high0 = hmale_high if agem>=`agesplit'
replace hfemale_low0 = hfemale_low if agem>=`agesplit'
replace hfemale_high0 = hfemale_high if agem>=`agesplit'

estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSAbgabe_gompertz18
replace _t = agem-18
replace _t=. if _t<0
replace _st=1 if agem >=18
replace _st=0 if agem <18
replace _t0=_t[_n-1] if _n!=0
capture drop hmale_low
capture drop hmale_high
capture drop hfemale_low
capture drop hfemale_high
predict hmale_low if female==0 & pincln <= ln(500)+1&agem<90 ,hazard
predict hmale_high if female==0 & pincln > ln(500)+1&agem<90 ,hazard
predict hfemale_low if female==1 & pincln <= ln(500)+1&agem<90,hazard
predict hfemale_high if female==1 & pincln > ln(500)+1&agem<90,hazard


label var hmale_low0 "Männer, 500 €"
label var hmale_high0 "Männer, 2000 €"
label var hfemale_low0 "Frauen, 500 €"
label var hfemale_high0 "Frauen, 2000 €"
line hmale_low hfemale_low hmale_low0 hmale_high0 hfemale_low0 hfemale_high0 agem if agem<=90&agem>15,c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)90,grid) xlabel(15(5)90)  ymtick(0(.01).25,grid) 
restore




stset agem [pw=design],id(persnr) failure(ppkwverf=4 ) origin(time 18) enter(ppkwverf==0 7 8) exit(time .)
replace _st=0 if (ppkwverf==1 | ppkwverf == 2)
//drop if _st==0
//stset agem [pw=design],id(persnr) failure(pfhspkw=2) origin(time 18) enter(pfhspkw==0 3) exit(time .)
//replace _st=0 if pfhspkw==1
//list persnr gebjahr agem _t0 _t  _d _st  pfhs pfhspkw ppkwverf in 5000/5500 if _st==1,noobs sepby(persnr)
//stdescribe
gen int fromwave = .
gen int towave = .
bysort persnr (year): replace fromwave = (year[1]-1983)
bysort persnr (year): replace towave = (year[_N]-1983)
merge persnr using "F:\DatenMaxDiss\SOEP\daten\soep24\pw\phrf.dta", uniqusing nokeep sort
capture drop plhrf
gen float plhrf= .
forvalues y = 1/24 {
	local w = char(`y'+96)
	quietly replace plhrf = `w'phrf if `y'<=fromwave & `w'phrf!=0

//wenn nur HFR für Sample D in (wave)phrfd gegeben ist, dann nimm diesen
	if `y'>=12 {
		quietly replace plhrf = `w'phrfd if `y'<=fromwave & plhrf==. & `w'phrfd!=0
		} 
//wenn nur HFR für Sample G/H in als (wave)phrfall gegeben ist, dann nimm diesen
	if `y'>=19 {
		quietly replace plhrf = `w'phrfall if `y'<=fromwave & plhrf==. & `w'phrfall!=0
		} 

// Berechne Längsschnittsgewichte durch Multiplikation mit den pbleib-Faktoren
//	if "`w'" != "a" {
//		quietly replace plhrf = plhrf * `w'pbleib if (`y'>fromwave & `y'<=towave & `w'pbleib >0)
//		}
	}
sum plhrf
quietly replace plhrf = plhrf / r(mean)
quietly replace plhrf = 1 if plhrf ==.
drop ?phrf* _merge *pbleib prgroup
stset age [pw=plhrf],id(persnr) failure(pfhspkw=2) origin(time 18) enter(pfhspkw==0 3) exit(time .)

//estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_gamma18
estimates use F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_12_gamma18
mat a = e(b)
xi: streg i.sex, dist(gamma) log 
//xi: streg i.sex, dist(gamma) log from(a) skip
//xi: streg i.sex, dist(gamma) from(a) skip
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FS_gamma18,replace
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\FSPkw_gamma18,replace
//estimates save F:\DatenMaxDiss\data\pw\soep\proj\FS\est\Pkwverf0_12_gamma18,replace
capture drop hmale_gamma
capture drop hfemale_gamma
predict hmale_gamma if female==0 & e(sample),hazard
predict hfemale_gamma if female==1 & e(sample),hazard
label var hmale_gamma "Männer"
label var hfemale_gamma "Frauen"
//label var hmale_gamma "Führerschein-Erwerb Männer_g"
//label var hfemale_gamma "Führerschein-Erwerb Frauen_g"
line hmale_gamma hfemale_gamma agem if e(sample),c(1 1) sort l1title("transition rate h(t)") xmtick(15(1)85,grid) xlabel(15(5)85)  ymtick(0(.01).25,grid) 

stdescribe
// mittlere Gewichtungsfaktor...
//by persnr (year): replace gew = median(phrf)

stset age [pw=design],id(persnr) failure(pfhs=2) origin(time 18) enter(pfhs==0 3) exit(time .)

//sts list,by(sex)

capture drop kmS
sts gen kmS = s
line kmS age, c(J J) sort xmtick(15(1)85,grid) xlabel(15(5)85) ymtick(.1(.1)1,grid) 


sts gen naH = na
gen naS = exp(-naH)
gen kmH = -log(kmS)

label var kmS "K-M"
label var naS "N-A"
label var kmH "K-M"
label var naH "N-A"

line kmS naS alter, c(J J) sort

// schneller als Gamma, aber mit -7196 deutlich schlecheteren LogLikeliehood als Gamma mit -7018
capture drop female
gen female = sex==2
streg female , dist(loglogistic) ancillary(female)
capture drop hmale
capture drop hfemale 
predict hmale if sex==1,hazard
predict hfemale if sex==2,hazard
label var hmale "Fhs-Erwerb Männer"
label var hfemale "Fhs-Erwerb Frauen"
line hmale hfemale age,c(1 1) sort l1title("h(t)") xmtick(15(1)85,grid) xlabel(15(5)85)  ymtick(0(.01).25,grid) 




// Führerschein-Abgabe
//Ababe (3) als failure, RiskSet: Abgabe nur möglich nur wenn vorher ein Führerschein bessen (1) oder erworben (2) wurde.
stset age,id(persnr) failure(pfhs=3) origin(time 18) enter(pfhs==1 2) exit(time .)
replace _st=0 if pfhs==0
stdescribe
xi: streg , dist(gompertz) ancillary(i.sex) // keinen zusätzlichen Effekt von sex auf die hazard-ratio, nur auf die Form
xi: streg , dist(weibull) ancillary(i.sex)
capture drop hmale_Abgabe
capture drop hfemale_Abgabe
predict hmale_Abgabe if sex==1,hazard
predict hfemale_Abgabe if sex==2,hazard
label var hmale_Abgabe "Fhs-Abgabe Männer"
label var hfemale_Abgabe "Fhs-Abgabe Frauen"
line hmale_Abgabe hfemale_Abgabe age,c(1 1) sort l1title("h(t)") xmtick(15(1)85,grid) xlabel(15(5)85)  ymtick(0(.01).25,grid) 

capture drop kmS
sts gen kmS = s,by(sex)
gen kmS1 = kmS*(sex==1)
gen kmS2 = kmS*(sex==2)
line kmS1 kmS2 age, c(J J) sort xmtick(15(1)85,grid) xlabel(15(5)85)  ymtick(0(.01)1,grid) 

stcox if(sex==2), estimate basehc(h2)
stcurve,hazard




log close