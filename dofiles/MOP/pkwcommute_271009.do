version 10
capture log close
clear
set memory 900m
set more off
log using "$MOP_workingdir\log\pkwcommute_01112009.log",replace


****************************************************************************************************
****************   Merge Daten zum Pkw-Besitz, Mobilitätsverhalten und Wohnort            **********
****************************************************************************************************
use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg.dta",clear

dropvars _merge
sort JAHR ID PERSNR
merge JAHR ID PERSNR using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_P0.dta", uniqusing sort
drop _merge
merge JAHR ID using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_HH0.dta", uniqusing sort
drop _merge
quietly compress

order  PHHID ID PERSNR JAHR
sort ID JAHR

label define ALTER 0 "0 bis 9 Jahre",modify
*** codiere unplausible Angaben um 
recode BERUF (8=6) if  alter>18 
recode BERUF (1/3 5/7=8) if  alter<6
recode BERUF (1/3 5/7=.) if ALTER==0
impute_mlogit BERUF, by(ALTER)       

noi di "nur Erwerbstätige/Personen in Ausbildung"
// keine Arbeit/Ausbildung:
replace mode5 = .z if (BERUF==3 | BERUF==6 | BERUF==7 | BERUF==8)
label define mode5 .z "kein Arbeitsweg",modify

noi di "berechne Verkehrsmittelwahl des Vorjahres"
bysort PHHID (JAHR): gen modeLastY = mode5[_n-1] if PHHID==PHHID[_n-1]

label values modeLastY mode5
label var modeLastY "VM im Vorjahr"

save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg01.dta",replace



***************************************************************************************************
******Codierung Verkehrsmittelwahl Arbeits-/Ausbildungsweg und Berechnung der Pkw-Verfügbarkeit****
***************************************************************************************************


use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg01.dta",clear

   


*** Zähle Personen, Erwachsene und Kinder im Haushalt
bysort ID JAHR: egen byte hhgr = total(PERSNR>0)
replace HHGR = hhgr if HHGR<hhgr

bysort ID JAHR: egen byte ERWACHSENE = total((alter>=18 & alter<.) | (alter==. & (BERUF<=3|BERUF==6|BERUF==7|fhs==1)))
label var ERWACHSENE "Anzahl Erwachsene im HH"
bysort ID JAHR: egen byte kind18 = total(alter<18)
bysort ID JAHR: egen byte kind10 = total(alter<10)
replace kind10 = max(kind10,P0_10)
bysort ID JAHR: egen byte kind1018 = total(alter >=10 & alter<18)
gen erwachMind = HHGR-(kind10+kind1018)
gen _hhmissing = (ERWACHSENE==0) | ((erwachMind>ERWACHSENE) & !(ERWACHSENE>=3)) // wenn Daten zu keinen Erwachsenen im HH oder 
replace ERWACHSENE = erwachMind if !_hhmissing
gen byte KIND = HHGR - ERWACHSENE if !_hhmissing
label var KIND "Anzahl Kinder im HH"
drop erwachMind 

//soep_genvar_timekm
//soep_genvar_spatial

// sortiere Personen im Haushalt:
// erst alle Personen mit Arbeitsweg, davon zuerst die mit Führerschein, 
// bei mehreren mit Füherschein ,die mit dem längsten Arbeitsweg, bei Gleichstand, zuerst die ältere Person
recode mode5 (.=.y) if alter<18 | BERUF==4
recode mode5 (.=.x) if alter>65 | BERUF==7
recode mode5 (.=.w) if fhs==0
label define mode5 .y "kA,Ausbildung" .x "kA,über 65" .w "kA,kein Fhs", modify
gen AWberichtet = (mode5<=5)

noi di "sortiere Haushaltsmitglieder nach Führerscheinbesitz, Länge des Pendelweges und Alter"
gsort ID JAHR -AWberichtet  -fhs -km -alter
by ID JAHR: gen pid = _n

*** Wenn kein Führerschein: codiere zu: sonstige MIV-Nutzung 
noi di "Pkw ohne Führerschein oder HH-Pkw: sonstige MIV-Nutzung"
recode mode5 (5=4) if fhs==0
*** wenn kein Auto im HH: codiere zu: sonstige MIV-Nutzung
recode mode5 (5=4) if pid ==1 & hpkw04==0


noi di "markiere Haushalte mit fehlenden Interviews"
replace _hhmissing=0 if hpkw03>=.

*** Wenn erwerbsfähige Erwachsene keine Personeninterview gegeben haben oder keine Infos zu Haushalts-Pkw: ganzer Haushalt als missing
bysort ID JAHR: egen _hhkAArbeisweg = total(mode5==.)
replace _hhmissing=0 if hpkw03>=.
replace _hhmissing=0 if _hhkAArbeisweg >0
drop _hhkAArbeisweg

noi di "ermittlere Pkw-Verfügbarkeit für Haushaltsmitglieder"
*** berechne "freie" Pkw für Personen 2-6
gen pkwfrei = 0
// Annahme: Person 1 hat erstmal alle Pkw im Haushalt zur freien Verfüfung
replace pkwfrei = hpkw04 if pid==1
// Wenn Person 1 ein Auto nimmt (mode5[1]==5), dann bleiben für alle anderen eins weniger übrig (pkw2_frei)
bysort ID JAHR (pid): gen pkw2_frei=hpkw04-(mode5[1]==5)
forvalues p = 2/7 {
	// Wenn Person _n-1 ein Auto für Arbeitsweg nimmt, hat Person n ein Auto weniger zur freien Verfüfung
	by ID JAHR: replace pkwfrei = pkwfrei[_n-1]-(mode5[_n-1]==5) if pid==`p'
	// Wenn kein Haushalts-Auto mehr frei ist: nimm an, dass MIV als Beifahrer, mit Mofa/Motorrad oder mit fremdem Pkw geutzt wurde
	recode mode5 (5=4) if pid==`p'&pkwfrei==0
}
label var pkwfrei "HH-Pkw frei für Person"
label var pkw2_frei "Pkws für Personen 234"




*** Zähle Führerscheine im Haushalt
bysort ID JAHR: egen hfhs = total(fhs==1)
label var hfhs "Anzahl Führerscheine im HH"
*** berechne Anzahl der restlichen  Führerscheininhaber ***
noi di "berechne Anzahl der sonstigen Führerscheininhaber im Haushalt"
bysort ID JAHR (pid): gen hweitfhs= (hfhs-fhs) if pid==1
bysort ID JAHR (pid): replace hweitfhs = hweitfhs[_n-1]-fhs if pid>1
label var hweitfhs "weitere Führerscheine im HH"

save "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg02.dta",replace
log close

*****************************************************************************************************************************************

capture log close
log using log using "$MOP_workingdir\log\HHOhneAW_01112009.log",replace
"
***************************************************************************************************
**************************** Haushalte ohne  Arbeits-/Ausbildungsweg  *****************************
***************************************************************************************************



***************************************************************************************************
*** HH-Pkw-Besitz für Haushalte ohne Personen mit Arbeits-/Ausbildungsweg *********
***************************************************************************************************

use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg02.dta",replace
sort ID JAHR
//gen hpkw_98 = hpkw012[_n-1] if JAHR==2003
MOP_PkwkeinAW

gen _sample = 1 if pid==1

*** Zahl der Pkw je Alternative
gen varcost = 0
MOP_genvar_rinc c

recode hfhs (2/4=2)
MOP_genvar_Fhs
//MOP_genvar_fahrtkosten
MOP_genvar_rinc c
//MOP_genvar_FhsPkw
MOP_genvar_haushalt
MOP_genvar_spatial
MOP_genvar_ZuZeit

drop if PERSNR==.

gen double PHHIDJAHR = PHHID * 1000 + (JAHR-1900)

replace _sample=0 if (hfhs==3)&C0
replace _sample=0 if (hfhs>=4&hfhs<.)& (C1|C2|C3)
drop  hfhs3C? hfhs4*
drop hfhs1C2
drop *C3?*
replace _sample=0 if alter<16

clogit choice C0 C2 hfhs*C* /*
*/  C?alter* C?fem* C?PP_* C*KIND C*LAGE* C?EINK? /*
*/ C?ZwWoh C?KNEIPE C?KINO C?SPORT rinc1700ln/*
*/ if _sample ,group(PHHIDJAHR)  


MOP_genvar_StateDep_Pkw, carn(0/2)

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln C98_?_C?/*
*/ if _sample,group(persnrJAHR) 
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz_SD",replace
// die State-Dependence dominiert alle räumlichen Faktoren ausser Einfamilienhaus

gen C0zeitk98 = zeitk98 * C0
gen C2zeitk98 = zeitk98 * C2
drop  C98_2_C0 C98_0_C2

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln  C98_?_C? C?zeitk98/*
*/ if _sample,group(persnrJAHR) 
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz_SDzk",replace
// einen Einfluss des Zeitkartenbesitzes von 5 Jahren vorher ist nicht so eindeutig festzustellen

log close



***************************************************************************************************


capture log close
log using log using "$MOP_workingdir\log\Pers2_4_01nov2009.log",replace

*********************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Personen 2-x                          *****
*********************************************************************************************************
use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg02.dta",replace
keep if pid>1
sort ID JAHR pid
MOP_expandMode
MOP_genvar_fahrtkosten
MOP_genvar_rinc hpkw04

gen double PHHIDJAHR = PHHID * 1000 + (JAHR-1900)
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP M  o?_* FRAU_? MPtmiv Otov Rtrad Ftfuss rinc1700ln if _sample & JAHR>=2004,group(PHHIDJAHR )
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP M ?Park* o?_* FRAU_? OZuZeit MPtmiv Otov Rtrad Ftfuss if _sample ,group(PHHIDJAHR )
estimates save  "$MOP_workingdir\est\AWPerson234_CL", replace



MOP_VMWahl_AWeg_predictLogSum

// Erreichbarkeit der HH-Mitglieder 345 - LogSum-Variable ist nicht signifikant - vermutlich auch zu wenige Fälle
// Daher lasse es ich bei der Berechnung des LogSums der HH-Mitglieder 234
/*
**** füge die LogSums des Arbeitswegs der anderen Haushalts-Mitglieder hinzu, iteriere 2 mal ***
forvalues i = 1/2 { 
	MOP_joinLogSumAw24
	clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP PLogSum PsonstkA M  o?_* FRAU_? MPtmiv Otov Rtrad Ftfuss rinc1700ln if _sample,group(PHHIDJAHR )
	MOP_VMWahl_AWeg_predictLogSum
}

*** abschließender Durchlauf
MOP_joinLogSumAw24
	clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP PLogSum PsonstkA M  o?_* FRAU_? MPtmiv Otov Rtrad Ftfuss rinc1700ln if _sample,group(PHHIDJAHR )
estimates save  "$MOP_workingdir\est\AWPerson234_CL", replace
MOP_VMWahl_AWeg_predictLogSum
*/

***************************************************************************************************
********************************** VM-Modell mit State Dependence *********************************
***************************************************************************************************

soep_genvar_StateDep_Mode
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln ??mode98 if _sample,group(persnrJAHR)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AWPerson234_CL_SD", replace

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
nlogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln if _sample||FRM : , base(Rad1) || PM: ,base(OV) || _altnum:  ,noconst case(persnrJAHR) 
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AWPerson24_NL", replace
*** soep_VMWahl_AWeg_predictLogSum ***
******************************************************
*** beim predict kommt eine Fehlermeldung    *********
*** noch mal Fehler suchen (IV-- nicht definiert)  ***
******************************************************

*************************************************************************************************
log close

set more off
***************************************************************************************************
***************** HH-Pkw-Besitz und Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 1 ***********
***************************************************************************************************

set more off
capture log close
log using "$MOP_workingdir\log\PkwVMWahlPers1_01nov2009.log",replace
use "$MOP_workingdir\Mobilitätsdaten\Long\MOP_Pendelweg02.dta",replace
keep if pid==1
sort ID JAHR
MOP_expandPkwMode
MOP_genvar_Fhs
MOP_genvar_fahrtkosten
MOP_genvar_rinc c
MOP_genvar_FhsPkw
MOP_genvar_haushalt
MOP_genvar_spatial
MOP_genvar_ZuZeit
MOP_joinLogSumAw24

//soep_joinLogSumAw24
drop if PERSNR==.

gen double PHHIDJAHR = PHHID * 1000 + (JAHR-1900)

*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? OAbZ* C?LAGE_* C?PP_* C?EINK?/*
*/ C?ZuZ* C?Sch* C?KINO C?KNEIPE C?ZWEIT C?SPORT/*
*/ MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample & JAHR>=2004,group(PHHIDJAHR ) 

// KNEIPE nicht signifikant, 


clogit choice C0 hfhs*C* M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? OAbZ* C?LAGE_* C?PP_* C?EINK?/*
*/ C?ZuZ* C?Sch* C?KINO C?KNEIPE C?ZWEIT C?SPORT/*
*/ MPtmiv Otov Ftfuss  Rtrad  rinc1700ln  PLogSum PsonstkA/*
*/ if _sample & JAHR>=2004,group(PHHIDJAHR ) 

// KNEIPE nicht signifikant, 


MOP_genvar_StateDep_Pkw, carn(0/2)

*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? OAbZ* C?LAGE_* C?PP_* C?EINK?/*
*/ C?ZuZ* C?Sch* C?KINO C?KNEIPE C?ZWEIT C?SPORT/*
*/ MPtmiv Otov Ftfuss  Rtrad  rinc1700ln CLY*/*
*/ if _sample & JAHR>=2004,group(PHHIDJAHR ) 




*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* O R F M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? ?Park* OZuZeit OAbZeit* C?LAGE_* C?PP_* C?EINK?/*
*/ MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample & JAHR>=2004,group(PHHIDJAHR ) 

*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* O R F M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? ?Park* OZuZeit OAbZeit* C?LAGE_* C?PP_* C?EINK?/*
*/ MPtmiv Otov Ftfuss  Rtrad  /*
*/ if _sample ,group(PHHIDJAHR ) 

*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* O R F M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? ?Park* OFuss*10 OAbZeit* C?LAGE_* C?PP_* C?EINK?/*
*/ MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample & JAHR>=2004,group(PHHIDJAHR ) 


*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* O R F M  C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/ acO* MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample,group(persnrJAHR) 
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_City_CL", replace
estimates store PkwCommute_City_CL
estimates use  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_City_CL"
mat Beta = e(b)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/  MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample,group(persnrJAHR) from(Beta,skip)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_City_CL", replace

gen CC1_1 = hfhs==1&P&C1
gen CC1_2 = hfhs==2&P&C1
gen CC1_3 = hfhs==3&P&C1
gen CC1_4 = (hfhs>3&hfhs<.)&P&C1

gen CC2_1 = hfhs==1&P&C2
gen CC2_2 = hfhs==2&P&C2
gen CC2_3 = hfhs==3&P&C2
gen CC2_4 = (hfhs>3&hfhs<.)&P&C2

gen CC3_2 = hfhs==2&P&C3
gen CC3_3 = hfhs==3&P&C3
gen CC3_4 = (hfhs>3&hfhs<.)&P&C3

constraint 111 /CC1_1 = 0 

clogit choice C0 hfhs*C* O R F M   CC?_? PLogSum female?/*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/  MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample,group(persnrJAHR) from(Beta,skip) constraint(111)


clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C*LogSumPkw C?METmittlswz*/*
*/  MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln /*
*/ if _sample,group(persnrJAHR) from(Beta,skip)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_AlleLogSum_CL", replace
mat Beta = e(b)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C?MZLogSumPkw C?METLogSumPkw C?METmittlswz*/*
*/  MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln /*
*/ if _sample,group(persnrJAHR) // from(Beta,skip)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_LogSum_CL", replace
mat Beta = e(b)

soep_genvar_StateDep_Pkw , car(0/3)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C?MZLogSumPkw C?METLogSumPkw C?METmittlswz /*
*/  MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln C98_?_C?/*
*/ if _sample,group(persnrJAHR) from(Beta,skip)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_AlleLogSum_CL_SD", replace


soep_export2biogeme

log close



set more off
*** Dieses Modell ergibt tau-Parameter von ca. .25 für alle Verkehrsmittel ***
*** Die Effekte für Beispielpersonen/haushalte sind deutlich realistischer als beim CL-Modell ***
constraint 11 [O_tau]_cons = [P_tau]_cons 
constraint 12 [R_tau]_cons = [P_tau]_cons 
constraint 13 [F_tau]_cons = [P_tau]_cons 
constraint 14 [M_tau]_cons = [P_tau]_cons 
nlogitgen Mode = _altnum(O: 1|11|21|31, R: 2|12|22|32, F: 3|13|23|33, M: 4|14|24|34, P: 5|15|25|35)
nlogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum  /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C?MZLogSumPkw C?METLogSumPkw C?METmittlswz /*
*/ MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln /*
*/  if _sample || Mode : , base(F) || _altnum: ,noconst case(persnrJAHR) constraints(11/14)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\MC_NL",replace
estimates store MC_NL


/*
nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700 /*
*/  if _sample in 1/100000 || Mode : , base(F) || _altnum:  ,noconst case(persnrJAHR) constraints(11/14)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_NL_00_1700",replace
estimates store MC_NL_00_1700
mat a=e(b)


nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1500 /*
*/  if _sample in 1/100000 || Mode : , base(F) || _altnum:  ,noconst case(persnrJAHR) constraints(11/14) from(a,skip)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_NL_00_1500",replace
estimates store MC_NL_00_1500
mat a=e(b)

nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ o?_* C*kid C*city* C*shop* C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700_125 /*
*/  if _sample  in 1/50000 || Mode : , base(F) || _altnum: ,noconst case(persnrJAHR) constraints(11/14)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_NL_00_1700_125",replace
estimates store MC_NL_00_1700_125
mat a=e(b)
*/






capture log close
log using "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\Modell_Zeitkarte_16072009.log",replace
***************************************************************************************************
***************** Zeitkartenbesitz                                                      ***********
***************************************************************************************************
use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",clear

logit zeitkarte oc_part oc_appr oc_stud  notempl city_05_10 city_10_25 city_25_40 city_40_  house_rural pkwfrei  if mode5==1 
gen metroguterreichbar = metroaccess==2
gen fs = pkwfs>1&pkwfs<.
gen pkwzeitweise = pkwfs==3
gen pkwimmer = pkwfs==4
gen keinenAW = mode5==.z

replace  METmittlswz = 4 if METmeteriv< 5000 & METmittlswz ==.
replace  METmittlswz = 8 if METmeteriv< 10000 & METmittlswz ==.


logit zeitkarte oc_part oc_appr oc_stud  notempl city_05_10 city_10_25 city_25_40 city_40_  house_rural fs pkwfrei if mode5==1
// Geschlecht spielt keine Rolle
// Teilzeit-/Nicht-Erwebstätige haben seltener, Studis häufiger Zeitkarte (Semester-Ticket, Fehlen von flexiblen Zeitkarten-Angeboten für Teilzeit-Beschäftigte)
// nahräumliche Erreichbarkeit shop, mixedneighbourhood etc. nicht entscheidend
// im ländlichen Raum (city_40_ und house_rural haben ÖV-Pendler seltener eine Zeitkarte - Fehlen attraktiver Zeitkarten-Angebote???
// bzw. da vor Takt sehr dünn ist
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_City_WohnTyp",replace

logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  fs pkwfrei METmittlswz if mode5==1 
// Besser performt dieses Modell - Erreichbarkeitsvorteil Pkw Metropolen hat große Auswirkungen (bei Oberzentren nur relativ klein)
// MET könnte aber auch Proxy für Verkehrsverbund sein
// Erreichbarkeitsvorteil MZ: gegenteiliger Effekt (eh Dinge im Nahbereich - da brauch ich keine Zeitkarte?)
// aufgrund der schlechten Abbildbarkeit innerhalb der Mittelzentren (oft ein PLZ-Bereich) lasse ich das weg!
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_LogSum",replace

logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  /*
*/ house_rural house_detached house_terrace house_38 fs pkwfrei METmittlswz if mode5==1 
// Besser performt dieses Modell - Erreichbarkeitsvorteil Pkw Metropolen hat große Auswirkungen (bei Oberzentren nur relativ klein)
// MET könnte aber auch Proxy für Verkehrsverbund sein
// Erreichbarkeitsvorteil MZ: gegenteiliger Effekt (eh Dinge im Nahbereich - da brauch ich keine Zeitkarte?)
// aufgrund der schlechten Abbildbarkeit innerhalb der Mittelzentren (oft ein PLZ-Bereich) lasse ich das weg
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_City_LogSum_WohnTyp",replace

logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  fs pkwfrei METmittlswz zeitk98 if mode5==1 & zeitk98<.
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_LogSum_zeitk98_ohneSD",replace
logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  fs pkwfrei METmittlswz zeitk98 if mode5==1 
// sehr starke Wirkung der State dependence - Wer vor 5 Jahren mit Zeitkarte gependelt ist, pendelt auch immer noch
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_LogSum_zeitk98_mitSD",replace



logit zeitkarte oc_part oc_appr oc_stud  notempl city_05_10 city_10_25 city_25_40 city_40_  house_rural fs pkwfrei METmittlswz if mode5>1 & mode5<. 
// bei den nicht-ÖV-Pendlern haben 
// im ländlichen Raum (city_40_ und house_rural haben ÖV-Pendler seltener eine Zeitkarte - Fehlen attraktiver Zeitkarten-Angebote???
// bzw. da vor Takt sehr dünn ist
// Teilzeit-/Nicht-Erwebstätige haben seltener, Studis häufiger Zeitkarte (Semester-Ticket, Fehlen von flexiblen Zeitkarten-Angeboten für Teilzeit-Beschäftigte)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_City_WohnTyp",replace

logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumPkw METLogSumPkw /*
*/ METmittlswz fs pkwfrei notransit if mode5>1  
// Bei den Personen ohne ÖPNV-Arbeitsweg, haben Studenten und Azubis am ehesten eine Zeitkarte (Semesterticket)
// Vollzeit-Erwerbstätige, die nicht mit dem ÖV zur Arbeit fahren, haben die geringste Neigung, eine Zeitkarte zu erwerben. 
// Andere Gruppen haben mehr Zeit für andere Aktivitäten und kaufen sich dafür eine Zeitkarte.
// Führerscheinbesitz und ein Pkw zur Verfüfung (pkwfrei - nicht durch andere HH-Mitglieder für den Arbeitsweg benötige) senken deutlich Zeitkarten-Besitz
// Räumlich: Erreichbarkeit von Metropolen und Oberzentren ohne Pkw am signifikantesten 
// (hier habe ich nicht LogSumOV genommen, da dieser im Innenstadtbereich nicht so richtig Sinn macht
// für die Mittelzentren: da wo ÖV gegenüber reiner Fuss/Rad/Pkw-Nutzung einen Vorteil bringt, eher Zeitkartenbesitz
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_LogSum",replace


logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumOV METLogSumOV /*
*/ METmittlswz fs pkwfrei notransit if mode5>1  
// Bei den Personen ohne ÖPNV-Arbeitsweg, haben Studenten und Azubis am ehesten eine Zeitkarte (Semesterticket)
// Vollzeit-Erwerbstätige, die nicht mit dem ÖV zur Arbeit fahren, haben die geringste Neigung, eine Zeitkarte zu erwerben. 
// Andere Gruppen haben mehr Zeit für andere Aktivitäten und kaufen sich dafür eine Zeitkarte.
// Führerscheinbesitz und ein Pkw zur Verfüfung (pkwfrei - nicht durch andere HH-Mitglieder für den Arbeitsweg benötige) senken deutlich Zeitkarten-Besitz
// Räumlich: Erreichbarkeit von Metropolen und Oberzentren ohne Pkw am signifikantesten 
// (hier habe ich nicht LogSumOV genommen, da dieser im Innenstadtbereich nicht so richtig Sinn macht
// für die Mittelzentren: da wo ÖV gegenüber reiner Fuss/Rad/Pkw-Nutzung einen Vorteil bringt, eher Zeitkartenbesitz
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_LogSumOV",replace


logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumPkw METLogSumPkw /*
*/ METmittlswz fs pkwfrei house_rural house_detached house_terrace house_38   notransit if mode5>1  
// Siedlungsdichte wichtig - erreichbarkeit shop/doctor keine sinnvollen Ergebnisse
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_LogSum_WohnTyp",replace

logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumPkw METLogSumPkw /*
*/ METmittlswz fs pkwfrei notransit if mode5>1 & zeitk98 <.
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_LogSum_zeitk98_ohneSD",replace
logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumPkw METLogSumPkw /*
*/ METmittlswz fs pkwfrei notransit zeitk98 if mode5>1  
// Sehr starke State Dependence - Einmal Zeitkarte - immer Zeitkarte - wichtiges Kundenbindungs-Instrument
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_LogSum_zeitk98_mitSD",replace

log close

