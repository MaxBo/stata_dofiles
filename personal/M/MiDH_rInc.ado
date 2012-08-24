********** Program zur Generierung des Resteinkommens und der Kostenvalriablen ************+
program define MiDH_rInc
syntax , [BENZin(real 0.10)] [REGIOMaut] [CITYMaut] [JOBTicketalle] [ZEITKarte]

quietly {

// Kosten der Zeitkarte
dropvars cOV* cPark* Maut cPkw*
gen cOV = 0
if "`zeitkarte'" != "" {
	noi di "mit  Zeitkarte"
	replace cOV = ZK / 40 / wage if z & (pTaet==1|pTaet==2)
	replace cOV = ZK / 1.5 / 40 / wage if z & (pTaet==3) // AzubiCards sind ca. 33% billiger als normale Tickets
	replace cOV = ZK / 2 / 40 / wage if z & (pTaet==4) // SchülerTickets sind ca. 50% billiger als normale Tickets
	replace cOV = EK / wage if O & !z // Einzeltickets sind nicht ermäßigt für Personen über 14 Jahre
	// Studis pTaet==5 haben 'zwangsweise' ein Semesterticket
	replace cOV = 0 if pTaet==5
	if "`jobticketalle'" != "" {
		noi di "JOBTicketalle"
		replace cOV = 0 if z & (pTaet==1|pTaet==2)  // ÖV-Zusatzkosten = 0 für Beschäftigte
		// replace ZK_Studi = 1 if z & (pTaet==1|pTaet==2) // gleiche Durchdringungswahrscheinlichkeit wie beim Semesterticket
	}
}
else {
	noi di "ohne Zeitkarte"
	replace cOV = ZK / 40 / wage if O & (pTaet==1|pTaet==2)
	replace cOV = ZK / 1.5 / 40 / wage if O & (pTaet==3) // AzubiCards sind ca. 33% billiger als normale Tickets
	replace cOV = ZK / 2 / 40 / wage if O & (pTaet==4) // SchülerTickets sind ca. 50% billiger als normale Tickets
	replace cOV = 0 if pTaet==5
	if "`jobticketalle'" != "" {
		noi di "JOBTicketalle"
		replace cOV = 0 if (pTaet==1|pTaet==2)  // ÖV-Zusatzkosten = 0 für Beschäftigte
	}

}
gen cOV_kS = cOV*(pTaet!=4& pTaet!=3) // keine Schüler
gen cOV_Sch = cOV*(pTaet==4|pTaet==3) // Schüler
// Kosten den Parkens
gen cPark = 0
replace cPark = ParkZeitAP / 5 if (P) // 5 Minuten "Parkwiederstand" entsprechen ca. 1€ pro Fahrt, also 2€/Tag und 40€/Monat
gen cParkWage = cPark/wage
gen cParkWage_kS = cParkWage*(pTaet!=4& pTaet!=3) // keine Schüler
gen cParkWage_Sch = cParkWage*(pTaet==4|pTaet==3) // Schüler
gen cPkw = 0
gen Maut = 0
if "`regiomaut'" != "" {
	noi di "RegioMaut"
	replace Maut = Maut + EK // Mautkosten = Kosten Einzeltickets
}
if "`citymaut'" != "" {
	noi di "CityMaut"
	replace Maut = Maut + 2. if AP_UZ==1 // Mautkosten 2 € je Einfahrt in die Umweltzone
}
replace cPkw =  ((MeterKfz* `benzin' / 1000)+Maut)  / wage if P // 10 ct je km (8 liter * 1,25 €/liter)
gen cPkw_kS = cPkw*(pTaet!=4& pTaet!=3) // keine Schüler
gen cPkw_Sch = cPkw*(pTaet==4|pTaet==3) // Schüler
gen cPkwM = 0
replace cPkwM =  ((MeterKfz* `benzin' / 2 / 1000)) / wage if  M // für Mitfahrer nur halbe Benzinkosten
gen cPkwM_kS = cPkwM*(pTaet!=4& pTaet!=3) // keine Schüler
gen cPkwM_Sch = cPkwM*(pTaet==4|pTaet==3) // Schüler


// Berechnung des Resteinkommens: erst variable Kosten abziehen
qui dropvars rInc
gen rInc = pInc
replace rInc = rInc - ZK if z & (pTaet==1|pTaet==2)
replace rInc = rInc - ZK/1.5 if z & (pTaet==3) // AzubiCards sind ca. 33% billiger als normale Tickets
replace rInc = rInc - ZK/2 if z & (pTaet==4) // SchülerTickets sind ca. 50% billiger als normale Tickets
// für Studis nix abziehen - Semesterticket
replace rInc = rInc - EK*40 if O&!z
replace rInc = rInc - MeterKfz*0.10/1000*40 if (P|M)
replace rInc = rInc - ParkZeitAP*8 if (P) // 5 Minuten "Parkwiderstand" entsprechen ca. monatlichen Parkgebühren von 40 € 

*** weiter werden noch Fixkosten der Pkw und die variablen Kosten des Arbeitsweges abgezogen
// 125 € je Pkw
local fixcosteigPkw 125
local fixcostgetPkw 62.5

replace rInc = rInc - `fixcosteigPkw' if eigPkw
replace rInc = rInc - `fixcostgetPkw' if getPkw

local incoffset 1600
qui dropvars rInc`incoffset'* 
gen rInc`incoffset'=rInc+`incoffset'
gen rInc`incoffset'ln = ln(rInc`incoffset')
replace rInc`incoffset'ln=0 if rInc`incoffset'<=0
}

end
****************************************************************************
