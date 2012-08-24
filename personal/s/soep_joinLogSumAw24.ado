********** Program zur Generierung der Variablen für das HH-Pkw/Arbeitsweg 1.Person-Modell ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_joinLogSumAw24

di "merge den Erreichbarkeitsvorteil der Personen 2-4"
quietly {

sort hhnrakt year pid
//merge hhnrakt year pid using "$PW_workingdir\soep\proj\Mobilitaet\LogSum.dta", uniqusing
merge hhnrakt year using "$PW_workingdir\soep\proj\Mobilitaet\LogSum.dta", uniqusing
drop _merge*

dropvars PLogSum PsonstkA
gen PLogSum = 0
label var PLogSum "Err.-Vorteil Pkw restliche Personen"
gen PsonstkA=0
label var PsonstkA "restl. P. ohne Angabe zum Pendelweg"

*** wenn Person p für die übrigen Personen kein Auto übrig lässt, (eh kein Auto oder 1 Auto, das Person p nimmt):
//Referenzwert: LogSum0 
replace PLogSum = LogSumPers34Pkw0 if LogSumPers34Pkw0<. & (pkwfrei==0 | (pkwfrei==1&P)) & pid==2
replace PLogSum = LogSumPers4Pkw0 if LogSumPers4Pkw0<. & (pkwfrei==0 | (pkwfrei==1&P)) & pid==3

*** wenn Person p für Person p+1 mindestens ein Auto übrig lässt, (mind. 2 Autos oder 1 Auto, das Person p nicht nimmt):
replace PLogSum = LogSumPers34Pkw1 if LogSumPers34Pkw1<. & ((pkwfrei>=2&pkwfrei<.) | (pkwfrei==1 & !P)) & pid==2
replace PLogSum = LogSumPers4Pkw1 if LogSumPers4Pkw1<. & ((pkwfrei>=2&pkwfrei<.) | (pkwfrei==1 & !P)) & pid==3

capture confirm var C0
if !_rc {
	noi di "Weise LogSum der richtigen Pkw-Besitz/-Nutzungs-Kombination zu"
	replace PLogSum = LogSumPers24Pkw0 if LogSumPers24Pkw0<. & (C0 | C1&P) & pid==1
	replace PLogSum = LogSumPers24Pkw1 if LogSumPers24Pkw1<. & (C1&!P | C2&P) & pid==1
	replace PLogSum = LogSumPers24Pkw2 if LogSumPers24Pkw2<. & (C2&!P | C3&P) & pid==1
	replace PLogSum = LogSumPers24Pkw3 if LogSumPers24Pkw3<. & (C3&!P) & pid==1

	replace PsonstkA = 1 if Pers24ArbeitswegkA==1 & (C1&!P | C2&P) & pid==1
	replace PsonstkA = 2 if Pers24ArbeitswegkA==2 & (C2&!P | C3&P) & pid==1
	replace PsonstkA = 3 if (Pers24ArbeitswegkA==3|Pers24ArbeitswegkA==4) & (C3&!P) & pid==1
}

replace PsonstkA= Pers34ArbeitswegkA if Pers34ArbeitswegkA<.  &  ((pkwfrei>=2&pkwfrei<.) | (pkwfrei==1 & !P)) & pid==2
replace PsonstkA= Pers4ArbeitswegkA if Pers4ArbeitswegkA<.  & ((pkwfrei>=2&pkwfrei<.) | (pkwfrei==1 & !P)) & pid==3

dropvars LogSum* Pers*ArbeitswegkA
}

end

