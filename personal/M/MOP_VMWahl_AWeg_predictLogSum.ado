********** Program zur Berechnung der LogSum-Indikatoren des Verkehrsmittel-Wahlmodells ************
*! version 1.0  01nov2009
************************************************************************
program define MOP_VMWahl_AWeg_predictLogSum

preserve
*** Für alle Personen, für die genug Infos vorliegen (_hhmissing==0) ***
*** berechne den Log des Gesamtnutzen aller zur Verfügung stehenden Alternativen ***
quietly {
replace _sample=0 if _hhmissing==1
dropvars LogSum0 LogSum1
noi di "berechne LogSUm für Personen, denen kein eigener Pkw zur Verfügung steht"

*** Einmal, wenn kein eigener Pkw zur Verfügung steht: ***
// setze Alternative Pkw auf "nicht verfügbar"
replace _sample=0 if P
replace Ppkwfrei2=0
replace Ppkwfrei3=0
dropvars _U _eU _Sum
//berechne den Nutzen der Alternativen
if e(cmd)=="nlogit" {
	predict _U if _sample,iv hlevel(2)
}
else if e(cmd)=="clogit" {
	predict _U if _sample,xb
}
gen _eU = exp(_U)
// berechne den Logarithmus des Nenners des VM-Wahl-Modells: ln(Sum(exp(U))
bysort ID JAHR pid: egen _Sum=total(_eU) if _sample
gen LogSum0 = ln(_Sum)
label var LogSum0 "Err Apl ohne freien Pkw"

*** Einmal, wenn ein eigener Pkw zur Verfügung steht: ***
// setze Alternative Pkw auf "verfügbar", wenn Führerschein vorhanden
noi di "berechne LogSUm für Personen mit Führerschein, denen ein eigener Pkw zur Verfügung steht"
replace _sample=1 if P & fhs==1
dropvars _U _eU _Sum
predict _U if _sample,xb 
gen _eU = exp(_U)
bysort ID JAHR pid: egen _Sum=total(_eU) if _sample
gen LogSum1 = ln(_Sum)
label var LogSum1 "Err Apl mit 1 freien Pkw"

*** Einmal, wenn zwei eigene Pkws zur Verfügung steht: ***
// setze Alternative Pkw auf "verfügbar", wenn Führerschein vorhanden
noi di "berechne LogSUm für Personen mit Führerschein, denen zwei eigene Pkws zur Verfügung steht"
replace _sample=1 if P & fhs==1
replace Ppkwfrei2=1
dropvars _U _eU _Sum
predict _U if _sample,xb 
gen _eU = exp(_U)
bysort ID JAHR pid: egen _Sum=total(_eU) if _sample
gen LogSum2 = ln(_Sum)
label var LogSum2 "Err Apl mit 2 freien Pkw"

*** Einmal, wenn zwei eigene Pkws zur Verfügung steht: ***
// setze Alternative Pkw auf "verfügbar", wenn Führerschein vorhanden
noi di "berechne LogSUm für Personen mit Führerschein, denen drei eigene Pkws zur Verfügung steht"
replace _sample=1 if P & fhs==1
replace Ppkwfrei2=0
replace Ppkwfrei3=1
dropvars _U _eU _Sum
predict _U if _sample,xb 
gen _eU = exp(_U)
bysort ID JAHR pid: egen _Sum=total(_eU) if _sample
gen LogSum3 = ln(_Sum)
label var LogSum3 "Err Apl mit 3 freien Pkw"

*** relevant ist nachher nur die Differenz, nicht die absoluten Werte: ***
noi di "berechne LogSum-Differenz als Erreichbarkeitsvorteil durch eigenen Pkw"
dropvars LogSumDiff LogSumPers*Pkw? Pers*Fhs Pers*ArbeitswegkA
replace LogSum1 = LogSum1 - LogSum0
replace LogSum2 = LogSum2 - LogSum0
replace LogSum3 = LogSum3 - LogSum0
replace LogSum0 = LogSum0 - LogSum0 

*** nur eine Zeile pro Haushalt ***
noi di "fasse die Erreibarkeitsvorteile der Haushaltsmitglieder zusammen"
gsort ID JAHR pid p LogSum1 LogSum0
by ID JAHR pid: keep if _n==1
*** Summe der Nutzen der Erwerbstätigen 2-4, 3-4 bzw. 4 mit/ohne eigenem Pkw
by ID JAHR: egen LogSumPers24Pkw0 = total(LogSum0)
by ID JAHR: egen LogSumPers24Pkw1 = total(LogSum1)
by ID JAHR: egen LogSumPers24Pkw2 = total(LogSum2)
by ID JAHR: egen LogSumPers24Pkw3 = total(LogSum3)
by ID JAHR: egen LogSumPers34Pkw0 = total(LogSum0 * (pid>=3))  
by ID JAHR: egen LogSumPers34Pkw1 = total(LogSum1 * (pid>=3)) 
by ID JAHR: egen LogSumPers4Pkw0 = total(LogSum0 * (pid>=4)) 
by ID JAHR: egen LogSumPers4Pkw1 = total(LogSum1 * (pid>=4))

*** berechne Anzahl der sonstigen Personen mit Führerschein, die Arbeitsweg haben, *** 
*** deren LogSum aber nicht berechnet werden konnte *** 
noi di "berechne Anzahl der sonstigen Führerscheininhaber im Haushalt mit Arbeitsweg, für die keine Erreichbarkeit berechnet werden kann"
by ID JAHR: egen Pers24ArbeitswegkA = total((LogSum0==.)&(mode5<.)&(fhs==1))
by ID JAHR: egen Pers34ArbeitswegkA = total(((LogSum0==.)&(mode5<.)&(fhs==1))* (pid>=3))
by ID JAHR: egen Pers4ArbeitswegkA = total(((LogSum0==.)&(mode5<.)&(fhs==1))* (pid>=4))

recode LogSum? (.=.x) if mode5 ==.
recode LogSum? (.=.z) if fhs==1
recode LogSum? (.=.y) if fhs==0
label define logsum .x "kein Pendelweg" .y "kein Fhs, Pendelweg k.A" .z "Fhs, Pendelweg k.A",modify
label values LogSum? logsum

noi di "speichere LogSums für den Haushalt zwischen"
*** Speichere die LogSums für den Haushalt zwischen ***
//keep ID JAHR LogSum* Pers*ArbeitswegkA
keep ID JAHR LogSumPers*Pkw? Pers*ArbeitswegkA
collapse (first) LogSumPers*Pkw? Pers*ArbeitswegkA,by(ID JAHR)
save "$MOP_workingdir\Mobilitätsdaten\Long\LogSum.dta",replace
}
restore
end
************************************************************************
