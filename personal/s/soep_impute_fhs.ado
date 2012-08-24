********** Program zur Imputation des F�hrerschein-Besitzes ************+
*! version 1.0  06jun2009
program define soep_impute_fhs

*************** wenn F�hrerschein-Besitz vor und nach eines missings verschieden,       ********
*************** nimm den Wert der zeilich n�chsten Beobachtung (Kriterium �ber agediff) ********

quietly {

preserve
noi di "imputiere F�hrerscheinbesitz, wenn Pkw-Verf�gbarkeit bekannt ist aus benachbarten Intervallen"
// nimm nur die F�lle, bei denen Pkw-Verf�gbarkeit bekannt ist
drop if pkwfs>=. & pkwfs!=.f
sort persnr year

// berechne Zeitraum zwischen t-1 - t und (agediff0), t und t+1 (agediff1) und t und t+2 (agediff2)
by persnr: gen agediff0 = agem - agem[_n-1]
by persnr: gen agediff1 = agem[_n+1]-agem
by persnr: gen agediff2 = agem[_n+2]-agem

// wenn t+1 und t-1 sich unterscheiden:
// Wenn t n�her an t-1 als an t+1 liegt, nimm den Wert von t-1
recode pkwfs (.f=1) if (fhs[_n-1]==0 & fhs[_n+1]==1 & agediff0<=agediff1)
recode pkwfs (.f=2) if (fhs[_n-1]==1 & fhs[_n+1]==0 & agediff0<=agediff1)
// sonst den von t+1
recode pkwfs (.f=1) if (fhs[_n-1]==1 & fhs[_n+1]==0 & agediff0>agediff1)
recode pkwfs (.f=2) if (fhs[_n-1]==0 & fhs[_n+1]==1 & agediff0>agediff1)

//wenn t+1 auch unbekannt ist, aber t-1 und t+2 bekannt und sich unterscheiden:
//wenn dann t n�her an t-1 als an t+2 ist, nimm den Wert von t-1
recode pkwfs (.f=1) if (pkwfs[_n+1]==.f & fhs[_n-1]==0 & fhs[_n+2]==1 & agediff0<=agediff2)
recode pkwfs (.f=2) if (pkwfs[_n+1]==.f & fhs[_n-1]==1 & fhs[_n+2]==0 & agediff0<=agediff2)
//sonst den von t+2
recode pkwfs (.f=1) if (pkwfs[_n+1]==.f & fhs[_n-1]==1 & fhs[_n+2]==0 & agediff0>agediff2)
recode pkwfs (.f=2) if (pkwfs[_n+1]==.f & fhs[_n-1]==0 & fhs[_n+2]==1 & agediff0>agediff2)

// mit den imputierten Werten bearbeite auch den F�hrerschein-Besitz
recode fhs (.=0) if pkwfs==1
recode fhs (.=1) if pkwfs==2

// schau noch mal, ob sich durch die Imputation �ber 3 Intervalle (t aus t-1 und t+2 bestimmt)
// sich jetzt auch noch was f�r t+1 generieren l�sst 
recode pkwfs (.f=1) if (fhs[_n-1]==0 & fhs[_n+1]==1 & agediff0<=agediff1)
recode pkwfs (.f=2) if (fhs[_n-1]==1 & fhs[_n+1]==0 & agediff0<=agediff1)
recode pkwfs (.f=1) if (fhs[_n-1]==1 & fhs[_n+1]==0 & agediff0>agediff1)
recode pkwfs (.f=2) if (fhs[_n-1]==0 & fhs[_n+1]==1 & agediff0>agediff1)
// mit den imputierten Werten bearbeite auch den F�hrerschein-Besitz
recode fhs (.=0) if pkwfs==1
recode fhs (.=1) if pkwfs==2

noi di "speichere erg�nzte Daten zwischen"
keep persnr year fhs pkwfs
tempfile FSimpute
save `FSimpute',replace
//save "$PW_workingdir\soep\proj\FS\FS-imp1.dta",replace
restore
noi di "update des imputierten pkwfs-Wertes" 
dropvars _merge
merge persnr year using `FSimpute', uniqusing nokeep sort update 
//merge persnr year using "$PW_workingdir\soep\proj\FS\FS-imp1.dta", uniqusing nokeep sort update 

}

***************sch�tze kleines Modell zum F�hrerschein-Besitz *************

quietly {

preserve
drop if fhs>=.

soep_gentransition_fhs

// F�hrerschein-Erwerb: Gewichtung

soep_stgew pgew,failure(fhs=2) enter(fhs==0 3)

noi di "sch�tze F�hrerschein-Erwerb-Modell"
// F�hrerschein-Erwerb
stset agem [pw=pgew2],id(persnr) failure(fhs=2) origin(time 18) enter(fhs==0 3) exit(time .)
replace _st=0 if (fhs==1 | fhs==3)
replace _t = _t0+(_t-_t0)/2 if _d==1

streg female , dist(lognormal) ancillary(female) log 
estimates save $PW_workingdir\soep\proj\FS\est\FS_logn,replace
estimates store FS_Erwerb_logn

noi di "sch�tze F�hrerschein-Abgabe-Modell"
// F�hrerschein-Abgabe
soep_stgew pgew,failure(fhs=3) enter(fhs==1 2)

stset agem [pw=pgew2],id(persnr) failure(fhs=3) origin(time 18) enter(fhs==1 2) exit(time .)
replace _st=0 if (fhs==0 | fhs==2)
replace _t = _t0+(_t-_t0)/2 if _d==1

streg female , dist(gompertz) ancillary(female) log 
estimates save $PW_workingdir\soep\proj\FS\est\FSAbgabe,replace
estimates store FS_Abgabe_gompertz

restore
}
*************** Ende F�hrerschein-Modellsch�tzung ********************


*************** imputiere F�hrerschein-Besitz f�r erste und letze Beobachtungen *********
*************** auf der Basis der Modellsch�tzung                           *************
quietly {
preserve
drop if pkwfs>=. & pkwfs!=.f
noi di "generiere Zufallszahlen und berechne Survival-Wahrscheinlichkeit"

// generiere Zufallsvariable
dropvars rand surv01 surv10
set seed 3412984
gen rand = runiform()

// Berechne Survival-Rates f�r F�hrerschein-Abgabe und -erwerb 
stset agem,id(persnr) failure(gebjahr==.) origin(time 18) exit(time .)
estimates restore FS_Erwerb_logn
predict surv01,surv
estimates restore FS_Abgabe_gompertz
predict surv10,surv
dropvars fhsende fhsanfang
gen fhsende=fhs
gen fhsanfang=fhs
sort persnr year

noi di "imputiere F�hrerschein-Besitz nach der letzten Beobachtung"
*************** imputiere "am Ende" *****************
//ermittle letzten bekannten F�hrerschein-Besitz
by persnr: replace fhsende = fhsende[_n-1] if pkwfs==.f

//Wenn zuletzt kein F�hrerschein: simuliere, ob F�hrerschein danach erworben wird.
//Wenn ja, dann F�hrerschein und f�lle gleich bis ganz unten weiter auf
by persnr: replace pkwfs =2 if (pkwfs==.f & fhsende==0) & (rand>surv01 | pkwfs[_n-1]==2)
//Wenn nein, dann bleib bei kein F�hrerschein
by persnr: replace pkwfs =1 if (pkwfs==.f & fhsende==0) & (rand<=surv01)

//Wenn zuletzt F�hrerschein vorhanden: simuliere, ob F�hrerschein danach abgegeben wird
//Wenn ja, dann kein F�hrerschein und f�lle gleich bis ganz unten weiter auf
by persnr: replace pkwfs =1 if (pkwfs==.f & fhsende==1) & (rand>surv10 | pkwfs[_n-1]==1)
//Wenn nein, dann behalte F�hrerschein
by persnr: replace pkwfs =2 if (pkwfs==.f & fhsende==1) & (rand<=surv10)

noi di "imputiere F�hrerschein-Besitz vor der ersten Beobachtung"
************ imputiere "am Anfang" ******************
//ermittlere den ersten bekannten F�hrerschein-Besitz, sortiere daf�r die Daten um
gsort +persnr -year
by persnr: replace fhsanfang = fhsanfang[_n-1] if pkwfs==.f

//Wenn kein F�hrerschein: simuliere, ob F�hrerschein vorher abgegeben wurde
//Wenn ja, dann geh von F�hrerschein-Abgabe aus und f�lle "F�hrerschein" gleich bis ganz oben weiter auf
by persnr: replace pkwfs =2 if (pkwfs==.f & fhsanfang ==0) & (rand>surv10[_n-1] | pkwfs[_n-1]==2)
//Wenn nein, dann geh davon aus, dass auch vorher kein F�hrerschein vorhanden war
by persnr: replace pkwfs =1 if (pkwfs==.f & fhsanfang ==0) & (rand<surv10[_n-1])

//Wenn 1. Info: F�hrerschein vorhanden: simuliere, ob F�hrerschein vorher erworben wurde
//Wenn ja, dann geh von F�hrerschein-Erwerb aus und f�lle "kein F�hrerschein" gleich bis ganz oben weiter auf
by persnr: replace pkwfs =1 if (pkwfs==.f & fhsanfang ==1) & (rand>surv01[_n-1] | pkwfs[_n-1]==1)
//Wenn nein, dann geh davon aus, dass F�hrerschein schon vorher vorhanden war
by persnr: replace pkwfs =2 if (pkwfs==.f & fhsanfang ==1) & (rand<surv01[_n-1])

//sortiere wieder richtig rum
sort persnr year
replace fhs = 0 if pkwfs==1
replace fhs = 1 if pkwfs==2

soep_gentransition_fhs
soep_gentransition_pkwfs

noi di "speichere erg�nzte Daten zwischen"
*** berechne L�nge der Intervall-zensierten Periode ***
by persnr (year): gen _dur = agem-agem[_n-1]
by persnr (year): gen _first = _n==1
keep persnr year fhs pkwfs _dur _first

tempfile FSimpute
save `FSimpute',replace
//save "$PW_workingdir\soep\proj\FS\FS-imp1.dta",replace

restore

******** lade nun alle Beobachtungen und berechne intervall-zensierte Zeitr�ume neu *****
noi di "update des imputierten pkwfs-Wertes" 
dropvars _merge
merge persnr year using `FSimpute', uniqusing nokeep sort update replace


noi di "f�lle missings zwischen Beobachtungen, wenn es kein event gegeben hat"
*** f�lle missings ab der ersten Beobachtung (hinter _first==1) mit Wert aus n�chstem beobachtetem Jahr auf, wenn es kein Event gegeben hat ***
gsort persnr -year
by persnr : replace _first=1 if _first[_n-1]==1
by persnr : replace pkwfs=pkwfs[_n-1] if pkwfs[_n-1]<=4 & pkwfs>=. & _first!=1
by persnr : replace fhs=fhs[_n-1] if fhs[_n-1]<=1 & fhs>=. & _first!=1
sort persnr year

noi di "setze den Eventzeitpunkt in die Mitte des intervall-zensierten Zeitraums"

*** berechne mittlere Dauer der intervallzensierten Periode _mdur und markiere, dass das event in die Mitte dieses Zeitraums verschoben werden soll (_shiftevent) ***
gen _mdur = round(_dur/2)
// wenn es ein Event gab, und 
gen _shiftevent=1 if pkwfs>4&pkwfs<. & pkwfs[_n-_mdur]>=.
replace _mdur=. if _shiftevent==.

*** l�sche Personen, bei denen der intervallzensierte Zeitraum gr��er als 6 Jahre (_mdur > 3) ist, da dann keine sinnvolle Absch�tzung, wann das Event stattgefunden hat, m�glich ist***
by persnr: egen _droppers=total(_mdur>3&_mdur<.)
drop if _droppers==1
drop _droppers

*** Verschiebe das Event in die Mitte des Intervallzensierten Zeitraums ***
by persnr (year): replace pkwfs=pkwfs[_n+1] if _mdur[_n+1]==1
by persnr (year): replace pkwfs=pkwfs[_n+2] if _mdur[_n+2]==2
by persnr (year): replace pkwfs=pkwfs[_n+3] if _mdur[_n+3]==3

*** generiere zur Kontrolle _agediff, ***
by persnr (year): gen _agediff=agem[_n+1]-(_dur[_n+1]/2)-agem if _mdur[_n+1]==1
by persnr (year): replace _agediff=agem[_n+2]-(_dur[_n+2]/2)-agem if _mdur[_n+2]==2
by persnr (year): replace _agediff=agem[_n+3]-(_dur[_n+3]/2)-agem if _mdur[_n+3]==3

noi di "setze missings vor und nach dem Event in der Mitte des intervallzensierten Zeitraums entsprechend dem Event"

*** wandele die missings vor einem Event (A->B, codiert als AB) in den Ausgangswert A um:  int(AB/10) und f�lle ggf. das Jahr davor ***
by persnr (year): replace pkwfs = int(pkwfs[_n+1]/10) if pkwfs[_n+1]>4&pkwfs[_n+1]<. & pkwfs>=. & _shiftevent[_n+1]==.
by persnr (year): replace pkwfs = pkwfs[_n+1] if _mdur[_n+5]==3
*** wandele das Event (AB) in den Zielzustand B (mod(AB,10)) um ***
*** und f�lle die missings der "2. H�lfte" des intervallzensierten Zeitraums mit dem Zielwert ***
replace pkwfs = mod(pkwfs,10) if pkwfs>4&pkwfs<.
by persnr (year): replace pkwfs = pkwfs[_n+1] if _mdur[_n+1]==2|_mdur[_n+1]==3
by persnr (year): replace pkwfs = pkwfs[_n+2] if _mdur[_n+2]==3
by persnr (year): replace pkwfs = pkwfs[_n+1] if pkwfs>=. & pkwfs[_n+1]==pkwfs[_n-1]


noi di "codiere fhs neu"
*** codiere die Events f�r pkwfs wieder neu und berechne den F�hrerscheinbesitz fhs ebenfalls neu ****
soep_gentransition_pkwfs
drop fhs
recode pkwfs (1=0) (2/4 23/24 32/34 42/44 =1) (12/14=2) (21 31 41=3) (./.z=.),gen(fhs)
label values fhs l_pfhs 
label define l_pfhs 2 "Erwerb" 3 "Abgabe", modify
label var fhs "F�hrerschein"
*** l�sche tempor�re Variablen ***
drop _*

}

end
****************************************************************************
