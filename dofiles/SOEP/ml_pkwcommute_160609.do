version 10
capture log close
clear
set memory 800m
set more off
log using "$PW_workingdir\soep\proj\Mobilitaet\pkwcommute_160609.log",replace


****************************************************************************************************
****************   Merge Daten zum Pkw-Besitz, Mobilitätsverhalten und Wohnort            **********
****************************************************************************************************
use "$PW_workingdir\soep\proj\Mobilitaet\Mobilitaet-custom.dta",clear
keep if year==1998|year==2003
sort persnr year
dropvars _merge
merge persnr year using "$PW_workingdir\soep\proj\FS\FS-stfilled.dta",uniqusing nokeep sort
recode pkwfs (21 31 41=1) (12 32 42=2) (13 23 43=3) (14 24 34=4)
drop if _merge==1
drop _merge

sort hhnrakt year
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", /*
*/ uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* pollu* nogreen crime)
drop if _merge==1
drop _merge

*** codiere Verkehrsmittelwahl Arbeits-/Ausbildungsweg in 5 Kategorien um"
recode modework (1=1) (2=5) (3 4=4) (5=2) (6=3),gen(mode5)
// wenn kein Verkehrsmittel berichtet, schau, ob wirklich kein Arbeits/Ausbildungsweg vorliegt
recode mode5 (.a/.b=.z) if (commutefreq==1|commutefreq==.b)
label define mode5 .z "keinAW"  1 "OV" 2 "Rad" 3 "Fuss" 4 "andMIV" 5 "eigPKW"
label values mode5 mode5 
label var mode5 "VM5"

bysort persnr (year): gen mode98 = mode5[_n-1] if year==2003
bysort persnr (year): gen pfhs98 = pkwfs[_n-1] if year==2003
label values mode98 mode5
label var mode98 "VM 1998"

save "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",replace


***************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg  *****************************
***************************************************************************************************


use "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",clear


soep_genvar_timekm
soep_genvar_spatial

// sortiere Personen im Haushalt:
// erst alle Personen mit Arbeitsweg, davon zuerst die mit Führerschein, 
// bei mehreren mit Füherschein ,die mit dem längsten Arbeitsweg, bei Gleichstand, zuerst die ältere Person
gen AWberichtet = (mode5<=5)
gsort hhnrakt year -AWberichtet  -pfhs -km -age
by hhnrakt year: gen pid = _n

*** Wenn kein Führerschein: codiere zu: sonstige MIV-Nutzung 
recode mode5 (5=4) if pfhs==0
*** Wenn erwerbsfähige Erwachsene unter 65 keinen Personeninterview gegeben haben: ganzer Haushalt als missing
bysort hhnrakt year: egen _hhmissing = total(netto==30 & (age<=65|age>=.))
*** wenn keine Infos zu Haushalts-Pkw: Haushalt als Missing
replace _hhmissing = (_hhmissing>0) | (hpkw04>=.)

*** wenn kein Auto im HH: codiere zu: sonstige MIV-Nutzung
recode mode5 (5=4) if pid==1 & hpkw04==0

*** berechne "freie" Pkw für Personen 2-6
gen pkwfrei = 0
// Annahme: Person 1 hat erstmal alle Pkw im Haushalt zur freien Verfüfung
replace pkwfrei = hpkw04 if pid==1
// Wenn Person 1 ein Auto nimmt (mode5[1]==5), dann bleiben für alle anderen eins weniger übrig (pkw2_frei)
bysort hhnrakt year (pid): gen pkw2_frei=hpkw04-(mode5[1]==5)
forvalues p = 2/6 {
	// Wenn Person _n-1 ein Auto für Arbeitsweg nimmt, hat Person n ein Auto weniger zur freien Verfüfung
	by hhnrakt year: replace pkwfrei = pkwfrei[_n-1]-(mode5[_n-1]==5) if pid==`p'
	// Wenn kein Haushalts-Auto mehr frei ist: nimm an, dass MIV als Beifahrer, mit Mofa/Motorrad oder mit fremdem Pkw geutzt wurde
	recode mode5 (5=4) if pid==`p'&pkwfrei==0
}
label var pkwfrei "Haushalts-Pkw noch 'frei' "

*** Zähle Führerscheine im Haushalt
bysort hhnrakt year: egen hfhs = total(pfhs==1)
*** berechne Anzahl der restlichen  Führerscheininhaber ***
noi di "berechne Anzahl der sonstigen Führerscheininhaber im Haushalt"
bysort hhnrakt year (pid): gen hweitfhs= (hfhs-pfhs) if pid==1
bysort hhnrakt year (pid): replace hweitfhs = hweitfhs[_n-1]-pfhs if pid>1
// gen hweitfhs=(hfhs-pid)*(hfhs>pid)


*** generiere eindeutige ID *****
gen long persnryear = persnr*100+(year-1980)

save "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace


*********************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Personen 2-x                          *****
*********************************************************************************************************
use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",clear
keep if pid>=2
soep_ModalSplitWorker

soep_genvar_fahrtkosten
soep_genvar_rinc hpkw04

********** Analyse der missings auf unplausible Angaben ************************************
/* 
sort persnryear _altnum
bysort persnryear: egen chmi = total(choice) if _sample
bysort persnryear: egen _numalt = count(_altnum) if _sample
list persnryear _altnum choice mode5 chmi km tov if _sample & (chmi==0 | _numalt == 1),sepby(hhnrakt year pid)
*/
*********************************************************************************************

clogit choice O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss hweitfhsP rinc1700ln ??mode98 if _sample,group(persnryear)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\AW14_CL", replace
soep_VMWahl_AWeg_predictLogSum

forvalues i = 1/2 { 
	soep_joinLogSumAw24
	clogit choice O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss hweitfhsP PLogSum PsonstkA rinc1700ln if _sample,group(persnryear)
	soep_VMWahl_AWeg_predictLogSum
}

soep_joinLogSumAw24
clogit choice O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss hweitfhsP Ppkwfrei? PLogSum PsonstkA rinc1700ln if _sample,group(persnryear)
soep_VMWahl_AWeg_predictLogSum

***************************************************************************************************
********************************** VM-Modell mit State Dependence *********************************
***************************************************************************************************

soep_genvar_StateDep_Mode
clogit choice O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss hweitfhsP rinc1700ln ??mode98 if _sample,group(persnryear)
****************************************************************************************************


***************************************************************************************************
***************** Nested Logit Model                                                    ***********
***************************************************************************************************

// folgendes Modell fittet am besten:
nlogitgen FRM = _altnum(Rad1: 2, Fuss1: 3, Motorisiert:1|4|5)
nlogitgen PM = _altnum(Rad2: 2, Fuss2: 3, OV: 1, MIV:4|5)
// Rad und Fuß in ein Nest zu packen gibt zwar besseren Likeliehood, Tau ist aber mit 2,3 > 1
// daher lasse ich sie einzeln

nlogittree _altnum PM FRM if _sample, choice(choice)
nlogit choice O F R M o?_* MPtmiv Otov Rtrad Ftfuss hweitfhsP hweitfhsM* rinc1700ln if _sample||FRM : , base(Rad1) || PM: ,base(OV) || _altnum:  ,noconst case(persnryear) 
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\AW24_NL", replace
*** soep_VMWahl_AWeg_predictLogSum ***
******************************************************
*** beim predict kommt eine Fehlermeldung    *********
*** noch mal Fehler suchen (IV-- nicht definiert)  ***
******************************************************

***************************************************************************************************
***************** HH-Pkw-Besitz und Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 1 ***********
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
keep if pid==1
recode hpkw04 (3/4=3) ,gen(hpkw03)
sort hhnrakt year
gen hpkw_98 = hpkw012[_n-1] if year==2003
gen adults_98 = adults[_n-1] if year==2003
gen povzeitk_98 = povzeitk[_n-1] if year==2003

soep_PkwModeAW

soep_genvar_fahrtkosten
soep_genvar_rinc c
soep_genvar_Fhs
soep_genvar_FhsPkw
soep_genvar_haushalt
soep_joinLogSumAw24
soep_genvar_wohnung


clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/ acO* MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample,group(persnryear) 


soep_genvar_StateDep_Pkw , car(0/3)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* C?ac*/*
*/ acO* MPtmiv Otov Ftfuss  Rtrad  rinc1700ln C?_C?/*
*/ if _sample,group(persnryear) 





***************************************************************************************************
***************** HH-Pkw-Besitz für Haushalte ohne Personen mit Arbeits-/Ausbildungsweg ***********
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
recode hpkw04 (3/4=3) ,gen(hpkw03)
sort hhnrakt year
gen hpkw_98 = hpkw012[_n-1] if year==2003
soep_PkwkeinAW

gen _sample = 1 if pid==1

*** Zahl der Pkw je Alternative
gen varcost = 0
soep_genvar_rinc c

soep_genvar_wohnung
soep_genvar_Fhs
soep_genvar_haushalt

replace _sample=0 if (hfhs==3)&C0
replace _sample=0 if (hfhs>=4&hfhs<.)& (C1|C2|C3)
drop  hfhs3C0 hfhs4_C2 hfhs4_C3

drop *C3*

clogit choice C0 hfhs*C* /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* C?ac*/*
*/ rinc1700ln/*
*/ if _sample,group(persnryear) 



soep_genvar_StateDep_Pkw, carn(0/2)
clogit choice C0 hfhs*C* /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* C?ac*/*
*/ rinc1700ln C?_C?/*
*/ if _sample,group(persnryear) 






log close