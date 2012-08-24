version 10
capture log close
clear
set memory 900m
set more off
log using "$PW_workingdir\soep\proj\Mobilitaet\pkwcommute_160709.log",replace


****************************************************************************************************
****************   Merge Daten zum Pkw-Besitz, Mobilitätsverhalten und Wohnort            **********
****************************************************************************************************
use "$PW_workingdir\soep\proj\Mobilitaet\Mobilitaet-custom.dta",clear
keep if year==1998|year==2003
sort persnr year
dropvars _merge
merge persnr year using "$PW_workingdir\soep\proj\FS\persnr_year_pkw_fhs.dta",uniqusing nokeep sort
//recode pkwfs (21 31 41=1) (12 32 42=2) (13 23 43=3) (14 24 34=4)
drop if _merge==1
drop _merge

sort hhnrakt year
local addvars MZ* OZ* MET*

merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", /*
*/ uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* `addvars')
drop if _merge==1
drop _merge


sort hhnrakt year
merge hhnrakt year using "$PW_workingdir\soep\proj\HH\HH-custom.dta", sort /*
*/ uniqusing nokeep keep( hsample hnetto hwgt hhrf hpkw* hmotorrad*)

drop if _merge==1
drop _merge


*** codiere Verkehrsmittelwahl Arbeits-/Ausbildungsweg in 5 Kategorien um"
recode modework (1=1) (2=5) (3 4=4) (5=2) (6=3),gen(mode5)
// wenn kein Verkehrsmittel berichtet, schau, ob wirklich kein Arbeits/Ausbildungsweg vorliegt
recode mode5 (.a/.b=.z) if (commutefreq==1|commutefreq==.b)
label define mode5 .z "keinAW"  1 "OV" 2 "Rad" 3 "Fuss" 4 "andMIV" 5 "eigPKW"
label values mode5 mode5 
label var mode5 "VM5"

recode povzeitk (1 2=1),gen(zeitkarte)
bysort persnr (year): gen mode98 = mode5[_n-1] if year==2003
bysort persnr (year): gen pfhs98 = pkwfs[_n-1] if year==2003
bysort persnr (year): gen zeitk98 = zeitkarte[_n-1] if year==2003

label values mode98 mode5
label var mode98 "VM 1998"

label var zeitk98 "Zeitkarte 1998"


save "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",replace



***************************************************************************************************
******Codierung Verkehrsmittelwahl Arbeits-/Ausbildungsweg und Berechnung der Pkw-Verfügbarkeit****
***************************************************************************************************


use "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",clear


soep_genvar_timekm
soep_genvar_spatial

// sortiere Personen im Haushalt:
// erst alle Personen mit Arbeitsweg, davon zuerst die mit Führerschein, 
// bei mehreren mit Füherschein ,die mit dem längsten Arbeitsweg, bei Gleichstand, zuerst die ältere Person
gen AWberichtet = (mode5<=5)
recode fhs (0 3=0) (1 2=1),gen(fhs01)
gsort hhnrakt year -AWberichtet  -fhs01 -km -age
by hhnrakt year: gen pid = _n

*** Wenn kein Führerschein: codiere zu: sonstige MIV-Nutzung 
recode mode5 (5=4) if fhs01==0
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
label var pkwfrei "HH-Pkw frei für Person"
label var pkw2_frei "Pkws für Personen 234"

*** Zähle Führerscheine im Haushalt
bysort hhnrakt year: egen hfhs = total(fhs01==1)
label var hfhs "Anzahl Führerscheine im HH"
*** berechne Anzahl der restlichen  Führerscheininhaber ***
noi di "berechne Anzahl der sonstigen Führerscheininhaber im Haushalt"
bysort hhnrakt year (pid): gen hweitfhs= (hfhs-fhs01) if pid==1
bysort hhnrakt year (pid): replace hweitfhs = hweitfhs[_n-1]-fhs01 if pid>1
label var hweitfhs "weitere Führerscheine im HH"


*** generiere eindeutige ID *****
gen long persnryear = persnr*100+(year-1980)

save "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
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
// erst alle Personen mit Arbeitsweg, davon zuerst die mit Führerschein, 
// bei mehreren mit Füherschein ,die mit dem längsten Arbeitsweg, bei Gleichstand, zuerst die ältere Person
gen AWberichtet = (mode5<=5)
recode fhs (0 3=0) (1 2=1), gen(fhs0)
gsort hhnrakt year -AWberichtet  -fhs0 -km -age
by hhnrakt year: gen pid = _n
*** Zähle Führerscheine im Haushalt
bysort hhnrakt year: egen hfhs = total(fhs0==1)
recode hfhs (1=0) (2 3=1),gen(hfhs2)
label var hfhs2 "2 Führerscheine in HH"
bysort hhnrakt year: egen hmodeX = total(mode5<=5)
drop if hmodeX>0

bysort hhnrakt year: egen harbeitslos = total(taet==5 & fhs0==1)
label var harbeitslos "Arbeitslose Führerscheininhaber im Haushalt)
keep if pid==1 & mode5 == .z // nur Haushalte ohne Pendelweg
keep if taet == 5 | taet == 6 // nur Arbeitslose und sonstige nicht Erwerbstätige berücksichtigen, keine Erwerbstätigen mit Heimarbeit
keep if hfhs==1|hfhs==2 // nur Haushalte mit Führerschein-Inhabern (und schließe die 4 Fälle mit 3 FHS-Inhabern aus)
gen female1fhs = female * (hfhs2==0)
label var female1fhs "Frau, 1 Fhs im HH"
gen age15ln = ln(age-15)
gen age_fem1fhs = age * female1fhs 
gen agesq_fem1fhs = agesq * female1fhs 
gen age15ln_fem1fhs = age15ln * female1fhs 
dropvars ageg *Klassen
egen ageg = cut(age), at(18 30,40,55(5)80 99)

sort hhnrakt year
gen hpkw_98 = hpkw012[_n-1] if year==2003
gen hpkw98_0=hpkw_98==0
gen hpkw98_2=hpkw_98==2
gen adults_98 = adults[_n-1] if year==2003

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
*** andere Variante HH-Pkw-Besitz für Haushalte ohne Personen mit Arbeits-/Ausbildungsweg *********
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
sort hhnrakt year
gen hpkw_98 = hpkw012[_n-1] if year==2003
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
*/ if _sample & METLogSumPkw <.,group(persnryear)  
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_City",replace

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln /*
*/ if _sample ,group(persnryear)  
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METLogSum",replace

// Führerschiene und Einkommen sind ganz wichtig
// Alter und Geschlecht auch (hier: älteste Person)
// räumliche Einflüsse sind hier eher gering
// tendenziell eher nahräumliche Einflüsse relevant: Dicht (efh) und Einkaufsgelegenheiten
// Erreichbarkeitsvorteil von Zentren ist hier nicht! relevant
// nur city25 ist relevant
// Auch Reisezeit mit ÖV ins Oberzentrum (widOV) ist nicht relevant

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln /*
*/ if _sample  ,group(persnryear)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz",replace

// Kein Auto eher bei geringer Startwartezeit 
// (vielleicht ist Reisezeitvergleich ins Zentrum weniger relevant, da eher Aktivitäten (Freizeit) ???)

soep_genvar_StateDep_Pkw, carn(0/2)

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln C98_?_C?/*
*/ if _sample,group(persnryear) 
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz_SD",replace
// die State-Dependence dominiert alle räumlichen Faktoren ausser Einfamilienhaus

gen C0zeitk98 = zeitk98 * C0
gen C2zeitk98 = zeitk98 * C2
drop  C98_2_C0 C98_0_C2

clogit choice C0 C2 hfhs*C* /*
*/ C?age* C?fem* C*kid C?METLogSumPkw C?METmittlswz C?city25_ C*shop* C*notransit_10 C?efh /*
*/ rinc1700ln  C98_?_C? C?zeitk98/*
*/ if _sample,group(persnryear) 
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\Pkw_keinAW_METswz_SDzk",replace
// einen Einfluss des Zeitkartenbesitzes von 5 Jahren vorher ist nicht so eindeutig festzustellen

log close



***************************************************************************************************


capture log close
log using "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AW_Person_2x_170709.log",replace

*********************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Personen 2-x                          *****
*********************************************************************************************************
use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",clear
keep if pid>=2
soep_ModalSplitWorker

soep_genvar_fahrtkosten
soep_genvar_rinc hpkw04

/*
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss rinc1700ln if _sample,group(persnryear)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AWPerson234_CL", replace
*/

gen OMETmittlswz = O * METmittlswz
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln if _sample,group(persnryear)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AWPerson234_CL", replace


soep_VMWahl_AWeg_predictLogSum

// Erreichbarkeit der HH-Mitglieder 345 - LogSum-Variable ist nicht signifikant - vermutlich auch zu wenige Fälle
// Daher lasse es ich bei der Berechnung des LogSums der HH-Mitglieder 234
/*
**** füge die LogSums des Arbeitswegs der anderen Haushalts-Mitglieder hinzu, iteriere 2 mal ***
forvalues i = 1/2 { 
	soep_joinLogSumAw24
	clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP PLogSum PsonstkA O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln if _sample,group(persnryear)
	soep_VMWahl_AWeg_predictLogSum
}

*** abschließender Durchlauf
soep_joinLogSumAw24
clogit choice Ppkwfrei? hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss PLogSum PsonstkA OMETmittlswz rinc1700ln if _sample,group(persnryear)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\ModeAW\AW14_CL", replace
soep_VMWahl_AWeg_predictLogSum
*/

***************************************************************************************************
********************************** VM-Modell mit State Dependence *********************************
***************************************************************************************************

soep_genvar_StateDep_Mode
clogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln ??mode98 if _sample,group(persnryear)
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
nlogit choice Ppkwfrei2 Ppkwfrei3 hweitfhsP O F R M o?_* female? MPtmiv Otov Rtrad Ftfuss OMETmittlswz rinc1700ln if _sample||FRM : , base(Rad1) || PM: ,base(OV) || _altnum:  ,noconst case(persnryear) 
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
use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
keep if pid==1
recode hpkw04 (3/4=3) ,gen(hpkw03)
sort hhnrakt year
gen hpkw_98 = hpkw012[_n-1] if year==2003
gen adults_98 = adults[_n-1] if year==2003
gen hfhs_98 = hfhs[_n-1] if year==2003

soep_PkwModeAW

soep_genvar_fahrtkosten
soep_genvar_rinc c
soep_genvar_Fhs
soep_genvar_FhsPkw
soep_genvar_haushalt
soep_joinLogSumAw24
soep_genvar_wohnung
gen OMETmittlswz = O * METmittlswz

*** Verkehrsmittelwahl / Zielwahl-Modell
clogit choice C0 hfhs*C* O R F M  C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/ acO* MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample,group(persnryear) 
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_City_CL", replace
estimates store PkwCommute_City_CL
estimates use  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_City_CL"
mat Beta = e(b)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/  MPtmiv Otov Ftfuss  Rtrad  rinc1700ln /*
*/ if _sample,group(persnryear) from(Beta,skip)
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
*/ if _sample,group(persnryear) from(Beta,skip) constraint(111)


clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum PsonstkA /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C*LogSumPkw C?METmittlswz*/*
*/  MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln /*
*/ if _sample,group(persnryear) from(Beta,skip)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_AlleLogSum_CL", replace
mat Beta = e(b)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C?MZLogSumPkw C?METLogSumPkw C?METmittlswz*/*
*/  MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln /*
*/ if _sample,group(persnryear) // from(Beta,skip)
estimates save  "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\PkwCommute_LogSum_CL", replace
mat Beta = e(b)

soep_genvar_StateDep_Pkw , car(0/3)

clogit choice C0 hfhs*C* O R F M  C23P C?Pfhs* PLogSum /*
*/ o?_* C*kid C*shop* C*notransit_10 C?mixedneighb C?hs* C?MZLogSumPkw C?METLogSumPkw C?METmittlswz /*
*/  MPtmiv Otov Ftfuss  Rtrad OMETmittlswz rinc1700ln C98_?_C?/*
*/ if _sample,group(persnryear) from(Beta,skip)
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
*/  if _sample || Mode : , base(F) || _altnum: ,noconst case(persnryear) constraints(11/14)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\est\PkwMode\MC_NL",replace
estimates store MC_NL


/*
nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700 /*
*/  if _sample in 1/100000 || Mode : , base(F) || _altnum:  ,noconst case(persnryear) constraints(11/14)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_NL_00_1700",replace
estimates store MC_NL_00_1700
mat a=e(b)


nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1500 /*
*/  if _sample in 1/100000 || Mode : , base(F) || _altnum:  ,noconst case(persnryear) constraints(11/14) from(a,skip)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_NL_00_1500",replace
estimates store MC_NL_00_1500
mat a=e(b)

nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ o?_* C*kid C*city* C*shop* C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700_125 /*
*/  if _sample  in 1/50000 || Mode : , base(F) || _altnum: ,noconst case(persnryear) constraints(11/14)
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

