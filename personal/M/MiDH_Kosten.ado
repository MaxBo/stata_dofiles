********** Program zur Generierung der Kostenvalriablen für Nicht-Pendelwege ************+
program define MiDH_Kosten
syntax , [BENZin(real 0.10)] [REGIOMaut] [CITYMaut] [JOBTicketalle] [ZEITKarte] [HALBpreis]

quietly {

// Kosten der Zeitkarte
dropvars cOV* cPark* Maut cPkw* tPark cost tOVVorbereitung
gen cOV = 0
gen tOVVorbereitung = 0
replace tOVVorbereitung = 5 if O & !z // 5 Minuten Verbindungssuche, Fahrkartenkauf 

if "`zeitkarte'" != "" {
	replace cOV = EK / lnwage if O & !z // Einzeltickets sind nicht ermäßigt für Personen über 14 Jahre
	// Studis pTaet==5 haben 'zwangsweise' ein Semesterticket
	replace cOV = 0 if pTaet==5
	if "`jobticketalle'" != "" {
		noi di "JOBTicketalle"
		replace cOV = 0 if (pTaet==1|pTaet==2)  // ÖV-Zusatzkosten = 0 für Beschäftigte
		replace tOVVorbereitung = 0 if (pTaet==1|pTaet==2)
		// replace ZK_Studi = 1 if z & (pTaet==1|pTaet==2) // gleiche Durchdringungswahrscheinlichkeit wie beim Semesterticket
	}
	if "`halbpreis'" != "" {
		noi di "Halbpreis-Ticket"
		replace cOV = cOV / 2 // if pNutzungOV <=3 // ÖV-Zusatzkosten = 0 für Beschäftigte
		// replace tOV_SWZ = tOV_SWZ*0.7
		replace tOVVorbereitung = 0
		// replace ZK_Studi = 1 if z & (pTaet==1|pTaet==2) // gleiche Durchdringungswahrscheinlichkeit wie beim Semesterticket
	}
}

gen cOV_kS = cOV*(pTaet!=4& pTaet!=3) // keine Schüler
gen cOV_Sch = cOV*(pTaet==4|pTaet==3) // Schüler
// Kosten den Parkens
// für die City (Bereiche mit Parkwiderstand > 10) ist ein Fussweg von PW-10 Minuten zum Ziel anzusetzen
// Hinzu kommen in diesen Bereichen für die Wegezwecke EinkAper, PrivErl und Dienstl 
// Parkkosten von durchschn. 2 h Aufenthaltsdauer * 1.50 € Parkgebühr/Stunde = 3 € je Parkvorgang, also 1.50 € je Hin & Rückweg
gen cPark = 0
gen tPark = 0
replace tPark = ParkzeitZielPunkt - 10  if (P) & ParkzeitZielPunkt > 10
replace cPark = 1.5 if (P) & ParkzeitZielPunkt > 10 & wZweckModell !=4
gen cParkWage = cPark/lnwage
gen cPkw = 0
gen Maut = 0
if "`regiomaut'" != "" {
	noi di "RegioMaut"
	replace Maut = Maut + (EK/2) // Mautkosten = halbe Kosten Einzeltickets in der NVZ
}
if "`citymaut'" != "" {
	noi di "CityMaut"
	replace Maut = Maut + 1. if UZ_Einfahrt==1 // Mautkosten 2 € je Einfahrt in die Umweltzone, also für Hin- und Rückweg je 1 €
}
replace cPkw =  ((MeterKfz* `benzin' / 1000)+Maut)  / lnwage if P // 10 ct je km (8 liter * 1,25 €/liter)
gen cPkw_kS = cPkw*(pTaet!=4& pTaet!=3) // keine Schüler
gen cPkw_Sch = cPkw*(pTaet==4|pTaet==3) // Schüler
gen cPkwM = 0
replace cPkwM =  ((MeterKfz* `benzin' / 1000)) / lnwage if  M // für Mitfahrer keine extra Maut
gen cPkwM_kS = cPkwM*(pTaet!=4& pTaet!=3) // keine Schüler
gen cPkwM_Sch = cPkwM*(pTaet==4|pTaet==3) // Schüler

gen cost = cOV+cPkw+cPkwM+cParkWage

}

end
****************************************************************************
