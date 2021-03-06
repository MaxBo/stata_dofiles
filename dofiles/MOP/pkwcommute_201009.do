version 10
capture log close
clear
set memory 900m
set more off
log using "$MOP_workingdir\log\pkwcommute_20102009.log",replace


****************************************************************************************************
****************   Merge Daten zum Pkw-Besitz, Mobilit�tsverhalten und Wohnort            **********
****************************************************************************************************
use "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_Pendelweg.dta",clear

dropvars _merge
sort JAHR ID PERSNR
merge JAHR ID PERSNR using "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_P0.dta", uniqusing sort
drop _merge
merge JAHR ID using "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_HH0.dta", uniqusing sort
drop _merge
quietly compress

order  PHHID ID PERSNR JAHR
sort ID JAHR

noi di "nur Erwerbst�tige/Personen in Ausbildung"
// keine Arbeit/Ausbildung:
replace mode5 = .z if (BERUF==3 | BERUF==6 | BERUF==7 | BERUF==8)
label define mode5 .z "kein Arbeitsweg",modify

noi di "berechne Verkehrsmittelwahl des Vorjahres"
bysort PHHID (JAHR): gen modeLastY = mode5[_n-1] if PHHID==PHHID[_n-1]

label values modeLastY mode5
label var modeLastY "VM im Vorjahr"

save "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_Pendelweg01.dta",replace



***************************************************************************************************
******Codierung Verkehrsmittelwahl Arbeits-/Ausbildungsweg und Berechnung der Pkw-Verf�gbarkeit****
***************************************************************************************************


use "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_Pendelweg01.dta",clear

label define ALTER 0 "0 bis 9 Jahre",modify
*** codiere unplausible Angaben um 
recode BERUF (8=6) if  alter>18 
recode BERUF (1/3 5/7=8) if  alter<6
recode BERUF (1/3 5/7=.) if ALTER==0
impute_mlogit BERUF, by(ALTER)       
   


*** Z�hle Personen, Erwachsene und Kinder im Haushalt
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
// erst alle Personen mit Arbeitsweg, davon zuerst die mit F�hrerschein, 
// bei mehreren mit F�herschein ,die mit dem l�ngsten Arbeitsweg, bei Gleichstand, zuerst die �ltere Person
recode mode5 (.=.y) if alter<18 | BERUF==4
recode mode5 (.=.x) if alter>65 | BERUF==7
recode mode5 (.=.w) if fhs==0
label define mode5 .y "kA,Ausbildung" .x "kA,�ber 65" .w "kA,kein Fhs", modify
gen AWberichtet = (mode5<=5)

noi di "sortiere Haushaltsmitglieder nach F�hrerscheinbesitz, L�nge des Pendelweges und Alter"
gsort ID JAHR -AWberichtet  -fhs -km -alter
by ID JAHR: gen pid = _n

*** Wenn kein F�hrerschein: codiere zu: sonstige MIV-Nutzung 
noi di "Pkw ohne F�hrerschein oder HH-Pkw: sonstige MIV-Nutzung"
recode mode5 (5=4) if fhs==0
*** wenn kein Auto im HH: codiere zu: sonstige MIV-Nutzung
recode mode5 (5=4) if pid ==1 & hpkw04==0


noi di "markiere Haushalte mit fehlenden Interviews"
replace _hhmissing=0 if hpkw03>=.

*** Wenn erwerbsf�hige Erwachsene keine Personeninterview gegeben haben oder keine Infos zu Haushalts-Pkw: ganzer Haushalt als missing
bysort ID JAHR: egen _hhkAArbeisweg = total(mode5==.)
replace _hhmissing=0 if hpkw03>=.
replace _hhmissing=0 if _hhkAArbeisweg >0
drop _hhkAArbeisweg

noi di "ermittlere Pkw-Verf�gbarkeit f�r Haushaltsmitglieder"
*** berechne "freie" Pkw f�r Personen 2-6
gen pkwfrei = 0
// Annahme: Person 1 hat erstmal alle Pkw im Haushalt zur freien Verf�fung
replace pkwfrei = hpkw04 if pid==1
// Wenn Person 1 ein Auto nimmt (mode5[1]==5), dann bleiben f�r alle anderen eins weniger �brig (pkw2_frei)
bysort ID JAHR (pid): gen pkw2_frei=hpkw04-(mode5[1]==5)
forvalues p = 2/7 {
	// Wenn Person _n-1 ein Auto f�r Arbeitsweg nimmt, hat Person n ein Auto weniger zur freien Verf�fung
	by ID JAHR: replace pkwfrei = pkwfrei[_n-1]-(mode5[_n-1]==5) if pid==`p'
	// Wenn kein Haushalts-Auto mehr frei ist: nimm an, dass MIV als Beifahrer, mit Mofa/Motorrad oder mit fremdem Pkw geutzt wurde
	recode mode5 (5=4) if pid==`p'&pkwfrei==0
}
label var pkwfrei "HH-Pkw frei f�r Person"
label var pkw2_frei "Pkws f�r Personen 234"




*** Z�hle F�hrerscheine im Haushalt
bysort ID JAHR: egen hfhs = total(fhs==1)
label var hfhs "Anzahl F�hrerscheine im HH"
*** berechne Anzahl der restlichen  F�hrerscheininhaber ***
noi di "berechne Anzahl der sonstigen F�hrerscheininhaber im Haushalt"
bysort ID JAHR (pid): gen hweitfhs= (hfhs-fhs) if pid==1
bysort ID JAHR (pid): replace hweitfhs = hweitfhs[_n-1]-fhs if pid>1
label var hweitfhs "weitere F�hrerscheine im HH"

save "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_Pendelweg02.dta",replace
log close

*****************************************************************************************************************************************

capture log close
log using "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\HHohneAW.log"
***************************************************************************************************
**************************** Haushalte ohne  Arbeits-/Ausbildungsweg  *****************************
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",clear

soep_genvar_timekm
soep_genvar_spatial

// sortiere Personen im Haushalt:
// erst alle Personen mit Arbeitsweg, davon zuerst die mit F�hrerschein, 
// bei mehreren mit F�herschein ,die mit dem l�ngsten Arbeitsweg, bei Gleichstand, zuerst die �ltere Person
gen AWberichtet = (mode5<=5)
recode fhs (0 3=0) (1 2=1), gen(fhs0)
gsort ID JAHR -AWberichtet  -fhs0 -km -age
by ID JAHR: gen pid = _n
*** Z�hle F�hrerscheine im Haushalt
bysort ID JAHR: egen hfhs = total(fhs0==1)
recode hfhs (1=0) (2 3=1),gen(hfhs2)
label var hfhs2 "2 F�hrerscheine in HH"
bysort ID JAHR: egen hmodeX = total(mode5<=5)
drop if hmodeX>0

bysort ID JAHR: egen harbeitslos = total(taet==5 & fhs0==1)
label var harbeitslos "Arbeitslose F�hrerscheininhaber im Haushalt)
keep if pid==1 & mode5 == .z // nur Haushalte ohne Pendelweg
keep if taet == 5 | taet == 6 // nur Arbeitslose und sonstige nicht Erwerbst�tige ber�cksichtigen, keine Erwerbst�tigen mit Heimarbeit
keep if hfhs==1|hfhs==2 // nur Haushalte mit F�hrerschein-Inhabern (und schlie�e die 4 F�lle mit 3 FHS-Inhabern aus)
gen female1fhs = female * (hfhs2==0)
label var female1fhs "Frau, 1 Fhs im HH"
gen age15ln = ln(age-15)
gen age_fem1fhs = age * female1fhs 
gen agesq_fem1fhs = agesq * female1fhs 
gen age15ln_fem1fhs = age15ln * female1fhs 
dropvars ageg *Klassen
egen ageg = cut(age), at(18 30,40,55(5)80 99)

sort ID JAHR
gen hpkw_98 = hpkw012[_n-1] if JAHR==2003
gen hpkw98_0=hpkw_98==0
gen hpkw98_2=hpkw_98==2
gen adults_98 = adults[_n-1] if JAHR==2003

sum age,de

mlogit hpkw012 hpkw98_? hfhs2 female1fhs age agesq age15ln age_fem1fhs agesq_fem1fhs harbeitslos kid1 kid2 pincln shop10 shop20 doctor10 doctor20 notransit /*
*/ city_05_10 city_10_25 city_25_40 city_40_  mixedneighb house_rural house_detached house_terrace house_38 /*
*/ if hpkw_98 < . & adults == adults_98

mlogit hpkw012 hpkw98_? hfhs2 female1fhs age agesq age15ln age_fem1fhs agesq_fem1fhs harbeitslos kid1 kid2 pincln shop10 shop20 doctor10 doctor20 notransit /*
*/ MZLogSumPkw OZLogSumPkw METLogSumPkw mixedneighb house_rural house_detached house_terrace house_38 /*
*/ if hpkw_98 < . & adults == adults_98

mlogit hpkw012 hfhs2 female1fhs age agesq age15ln age_fem1fhs agesq_fem1fhs harbeitslos kid1 kid2 pincln/*
*/ OZLogSumPkw /*
*/ if hpkw_98 < . & adults == adults_98


mlogit hpkw012 hpkw98_? hfhs2 female1fhs age agesq age15ln age_fem1fhs agesq_fem1fhs harbeitslos kid1 kid2 pequivinc shop10 shop20 doctor10 doctor20 notransit /*
*/ city_* _IOZ* mixedneighb house_rural house_detached house_terrace house_38 /*
*/ if hpkw_98 < . & adults == adults_98



mlogit hpkw012 hpkw98_? hfhs2 female1fhs age agesq age15ln age_fem1fhs agesq_fem1fhs harbeitslos kid1 kid2 pequivinc shop10 shop20 doctor10 doctor20 notransit /*
*/ city_*   MZwiderstandov OZmindiffivov /*
*/ mixedneighb house_rural house_detached house_terrace house_38/* 
*/ if hpkw_98 < . & adults == adults_98



***************************************************************************************************



capture log close
log using "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\HHohneAW_160709.log",replace

***************************************************************************************************
*** andere Variante HH-Pkw-Besitz f�r Haushalte ohne Personen mit Arbeits-/Ausbildungsweg *********
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
sort ID JAHR
gen hpkw_98 = hpkw012[_n-1] if JAHR==2003
soep_PkwkeinAW

gen _sample = 1 if pid==1

*** Zahl der Pkw je Alternative
gen varcost = 0
soep_genvar_rinc c

soep_genvar_wohnung
recode hfhs (2/4=2)
soep_genvar_Fhs
soep_genvar_haushalt


replace _sample=0 if (hfhs==3)&C0
replace _sample=0 if (hfhs>=4&hfhs<.)& (C1|C2|C3)
drop  hfhs3C? hfhs4*
drop hfhs1C2
drop *C3*
replace _sample=0 if age<16

/* wird schon in soep_genvar_wohnung definiert
gen C0MZLogSumPkw = MZLogSumPkw * C0
gen C2MZLogSumPkw = MZLogSumPkw * C2
gen C0OZLogSumPkw = OZLogSumPkw * C0
gen C2OZLogSumPkw = OZLogSumPkw * C2
gen C0METLogSumPkw = METLogSumPkw * C0
gen C2METLogSumPkw = METLogSumPkw * C2

gen C0MZmittlswz = MZmittlswz * C0
gen C0OZmittlswz = OZmittlswz * C0
gen C0METmittlswz = METmittlswz * C0
gen C2MZmittlswz = MZmittlswz * C2
gen C2OZmittlswz = OZmittlswz * C2
gen C2METmittlswz = METmittlswz * C2
*/

gen C0OZwidov = OZwiderstandov * C0
gen C2OZwidov = OZwiderstandov * C2

clogit choice C0 C2 hfhs*C* /*
*/  C?age* C?fem* C*kid C*city* C*shop* C*notransit_10 C?efh/*
*/ rinc1700ln/*
*/ if _sample & METLogSumPkw <.,group(persnrJAHR)  
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_City",replace

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln /*
*/ if _sample ,group(persnrJAHR)  
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METLogSum",replace

// F�hrerschiene und Einkommen sind ganz wichtig
// Alter und Geschlecht auch (hier: �lteste Person)
// r�umliche Einfl�sse sind hier eher gering
// tendenziell eher nahr�umliche Einfl�sse relevant: Dicht (efh) und Einkaufsgelegenheiten
// Erreichbarkeitsvorteil von Zentren ist hier nicht! relevant
// nur city25 ist relevant
// Auch Reisezeit mit �V ins Oberzentrum (widOV) ist nicht relevant

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln /*
*/ if _sample  ,group(persnrJAHR)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz",replace

// Kein Auto eher bei geringer Startwartezeit 
// (vielleicht ist Reisezeitvergleich ins Zentrum weniger relevant, da eher Aktivit�ten (Freizeit) ???)

soep_genvar_StateDep_Pkw, carn(0/2)

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln C98_?_C?/*
*/ if _sample,group(persnrJAHR) 
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz_SD",replace
// die State-Dependence dominiert alle r�umlichen Faktoren ausser Einfamilienhaus

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
log using "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AW_Person_2x_170709.log",replace

*********************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Personen 2-x                          *****
*********************************************************************************************************
use "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_Pendelweg04.dta",clear
keep if pid>=2
soep_ModalSplitWorker

soep_genvar_fahrtkosten
soep_genvar_rinc hpkw04

/*
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss rinc1700ln if _sample,group(persnrJAHR)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AWPerson234_CL", replace
*/

gen OMETmittlswz = O * METmittlswz
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln if _sample,group(persnrJAHR)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AWPerson234_CL", replace


soep_VMWahl_AWeg_predictLogSum

// Erreichbarkeit der HH-Mitglieder 345 - LogSum-Variable ist nicht signifikant - vermutlich auch zu wenige F�lle
// Daher lasse es ich bei der Berechnung des LogSums der HH-Mitglieder 234
/*
**** f�ge die LogSums des Arbeitswegs der anderen Haushalts-Mitglieder hinzu, iteriere 2 mal ***
forvalues i = 1/2 { 
	soep_joinLogSumAw24
	clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP PLogSum PsonstkA O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln if _sample,group(persnrJAHR)
	soep_VMWahl_AWeg_predictLogSum
}

*** abschlie�ender Durchlauf
soep_joinLogSumAw24
clogit choice Ppkwfrei? hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss PLogSum PsonstkA OMETmittlswz rinc1700ln if _sample,group(persnrJAHR)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AW14_CL", replace
soep_VMWahl_AWeg_predictLogSum
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
// Rad und Fu� in ein Nest zu packen gibt zwar besseren Likeliehood, Tau ist aber mit 2,3 > 1
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
capture log close
log using "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_AWPers1_250809.log",replace
***************************************************************************************************
***************** HH-Pkw-Besitz und Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 1 ***********
***************************************************************************************************

set more off
log using "$MOP_workingdir\log\PkwVMWahlPers1.log",replace
use "$MOP_workingdir\Mobilit�tsdaten\Long\MOP_Pendelweg02.dta",replace
keep if pid==1
sort ID JAHR
MOP_expandPkwMode
MOP_genvar_Fhs
MOP_genvar_fahrtkosten
MOP_genvar_rinc c
MOP_genvar_FhsPkw
MOP_genvar_haushalt
MOP_genvar_spatial

//soep_joinLogSumAw24
//soep_genvar_wohnung
//gen OMETmittlswz = O * METmittlswz
drop if PERSNR==.
gen double PHHIDJAHR = PHHID * 1000 + (JAHR-1900)

/* ist gegen�ber 2004 nicht signifikant - keine Trends ablesbar
gen C02005 = C0*JAHR==2005
gen C02006 = C0*JAHR==2006
gen C02007 = C0*JAHR==2007
gen C22005 = C2*JAHR==2005
gen C22006 = C2*JAHR==2006
gen C22007 = C2*JAHR==2007
gen C32005 = C3*JAHR==2005
gen C32006 = C3*JAHR==2006
gen C32007 = C3*JAHR==2007
*/

*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* O R F M  C?Pfhs* /*
*/ o?_*  C*KIND FRAU_? ?Park* OZuZeit OAbZeit* C?LAGE_* C?PP_* C?EINK? C?20??/*
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
*** Dieses Modell ergibt tau-Parameter von ca. .25 f�r alle Verkehrsmittel ***
*** Die Effekte f�r Beispielpersonen/haushalte sind deutlich realistischer als beim CL-Modell ***
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
// Teilzeit-/Nicht-Erwebst�tige haben seltener, Studis h�ufiger Zeitkarte (Semester-Ticket, Fehlen von flexiblen Zeitkarten-Angeboten f�r Teilzeit-Besch�ftigte)
// nahr�umliche Erreichbarkeit shop, mixedneighbourhood etc. nicht entscheidend
// im l�ndlichen Raum (city_40_ und house_rural haben �V-Pendler seltener eine Zeitkarte - Fehlen attraktiver Zeitkarten-Angebote???
// bzw. da vor Takt sehr d�nn ist
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_City_WohnTyp",replace

logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  fs pkwfrei METmittlswz if mode5==1 
// Besser performt dieses Modell - Erreichbarkeitsvorteil Pkw Metropolen hat gro�e Auswirkungen (bei Oberzentren nur relativ klein)
// MET k�nnte aber auch Proxy f�r Verkehrsverbund sein
// Erreichbarkeitsvorteil MZ: gegenteiliger Effekt (eh Dinge im Nahbereich - da brauch ich keine Zeitkarte?)
// aufgrund der schlechten Abbildbarkeit innerhalb der Mittelzentren (oft ein PLZ-Bereich) lasse ich das weg!
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_LogSum",replace

logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  /*
*/ house_rural house_detached house_terrace house_38 fs pkwfrei METmittlswz if mode5==1 
// Besser performt dieses Modell - Erreichbarkeitsvorteil Pkw Metropolen hat gro�e Auswirkungen (bei Oberzentren nur relativ klein)
// MET k�nnte aber auch Proxy f�r Verkehrsverbund sein
// Erreichbarkeitsvorteil MZ: gegenteiliger Effekt (eh Dinge im Nahbereich - da brauch ich keine Zeitkarte?)
// aufgrund der schlechten Abbildbarkeit innerhalb der Mittelzentren (oft ein PLZ-Bereich) lasse ich das weg
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_City_LogSum_WohnTyp",replace

logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  fs pkwfrei METmittlswz zeitk98 if mode5==1 & zeitk98<.
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_LogSum_zeitk98_ohneSD",replace
logit zeitkarte oc_part oc_appr oc_stud  notempl METLogSumPkw  fs pkwfrei METmittlswz zeitk98 if mode5==1 
// sehr starke Wirkung der State dependence - Wer vor 5 Jahren mit Zeitkarte gependelt ist, pendelt auch immer noch
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\OVAW_LogSum_zeitk98_mitSD",replace



logit zeitkarte oc_part oc_appr oc_stud  notempl city_05_10 city_10_25 city_25_40 city_40_  house_rural fs pkwfrei METmittlswz if mode5>1 & mode5<. 
// bei den nicht-�V-Pendlern haben 
// im l�ndlichen Raum (city_40_ und house_rural haben �V-Pendler seltener eine Zeitkarte - Fehlen attraktiver Zeitkarten-Angebote???
// bzw. da vor Takt sehr d�nn ist
// Teilzeit-/Nicht-Erwebst�tige haben seltener, Studis h�ufiger Zeitkarte (Semester-Ticket, Fehlen von flexiblen Zeitkarten-Angeboten f�r Teilzeit-Besch�ftigte)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_City_WohnTyp",replace

logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumPkw METLogSumPkw /*
*/ METmittlswz fs pkwfrei notransit if mode5>1  
// Bei den Personen ohne �PNV-Arbeitsweg, haben Studenten und Azubis am ehesten eine Zeitkarte (Semesterticket)
// Vollzeit-Erwerbst�tige, die nicht mit dem �V zur Arbeit fahren, haben die geringste Neigung, eine Zeitkarte zu erwerben. 
// Andere Gruppen haben mehr Zeit f�r andere Aktivit�ten und kaufen sich daf�r eine Zeitkarte.
// F�hrerscheinbesitz und ein Pkw zur Verf�fung (pkwfrei - nicht durch andere HH-Mitglieder f�r den Arbeitsweg ben�tige) senken deutlich Zeitkarten-Besitz
// R�umlich: Erreichbarkeit von Metropolen und Oberzentren ohne Pkw am signifikantesten 
// (hier habe ich nicht LogSumOV genommen, da dieser im Innenstadtbereich nicht so richtig Sinn macht
// f�r die Mittelzentren: da wo �V gegen�ber reiner Fuss/Rad/Pkw-Nutzung einen Vorteil bringt, eher Zeitkartenbesitz
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\Zeitkarte\keinOVAW_LogSum",replace


logit zeitkarte keinenAW oc_part oc_appr oc_stud  notempl MZLogSumOV OZLogSumOV METLogSumOV /*
*/ METmittlswz fs pkwfrei notransit if mode5>1  
// Bei den Personen ohne �PNV-Arbeitsweg, haben Studenten und Azubis am ehesten eine Zeitkarte (Semesterticket)
// Vollzeit-Erwerbst�tige, die nicht mit dem �V zur Arbeit fahren, haben die geringste Neigung, eine Zeitkarte zu erwerben. 
// Andere Gruppen haben mehr Zeit f�r andere Aktivit�ten und kaufen sich daf�r eine Zeitkarte.
// F�hrerscheinbesitz und ein Pkw zur Verf�fung (pkwfrei - nicht durch andere HH-Mitglieder f�r den Arbeitsweg ben�tige) senken deutlich Zeitkarten-Besitz
// R�umlich: Erreichbarkeit von Metropolen und Oberzentren ohne Pkw am signifikantesten 
// (hier habe ich nicht LogSumOV genommen, da dieser im Innenstadtbereich nicht so richtig Sinn macht
// f�r die Mittelzentren: da wo �V gegen�ber reiner Fuss/Rad/Pkw-Nutzung einen Vorteil bringt, eher Zeitkartenbesitz
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

