********** Program zur Generierung der Kostenvalriablen f�r Nicht-Pendelwege ************+
program define MiDH_Kosten
syntax , [BENZin(real 0.10)] [REGIOMaut] [CITYMaut] [JOBTicketalle] [ZEITKarte] [HALBpreis]

quietly {

// Kosten der Zeitkarte
dropvars cOV* cPark* Maut cPkw* tPark cost tOVVorbereitung
gen cOV = 0
gen tOVVorbereitung = 0
replace tOVVorbereitung = 5 if O & !z // 5 Minuten Verbindungssuche, Fahrkartenkauf 

if "`zeitkarte'" != "" {
	replace cOV = EK / lnwage if O & !z // Einzeltickets sind nicht erm��igt f�r Personen �ber 14 Jahre
	// Studis pTaet==5 haben 'zwangsweise' ein Semesterticket
	replace cOV = 0 if pTaet==5
	if "`jobticketalle'" != "" {
		noi di "JOBTicketalle"
		replace cOV = 0 if (pTaet==1|pTaet==2)  // �V-Zusatzkosten = 0 f�r Besch�ftigte
		replace tOVVorbereitung = 0 if (pTaet==1|pTaet==2)
		// replace ZK_Studi = 1 if z & (pTaet==1|pTaet==2) // gleiche Durchdringungswahrscheinlichkeit wie beim Semesterticket
	}
	if "`halbpreis'" != "" {
		noi di "Halbpreis-Ticket"
		replace cOV = cOV / 2 // if pNutzungOV <=3 // �V-Zusatzkosten = 0 f�r Besch�ftigte
		// replace tOV_SWZ = tOV_SWZ*0.7
		replace tOVVorbereitung = 0
		// replace ZK_Studi = 1 if z & (pTaet==1|pTaet==2) // gleiche Durchdringungswahrscheinlichkeit wie beim Semesterticket
	}
}

gen cOV_kS = cOV*(pTaet!=4& pTaet!=3) // keine Sch�ler
gen cOV_Sch = cOV*(pTaet==4|pTaet==3) // Sch�ler
// Kosten den Parkens
// f�r die City (Bereiche mit Parkwiderstand > 10) ist ein Fussweg von PW-10 Minuten zum Ziel anzusetzen
// Hinzu kommen in diesen Bereichen f�r die Wegezwecke EinkAper, PrivErl und Dienstl 
// Parkkosten von durchschn. 2 h Aufenthaltsdauer * 1.50 � Parkgeb�hr/Stunde = 3 � je Parkvorgang, also 1.50 � je Hin & R�ckweg
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
	replace Maut = Maut + 1. if UZ_Einfahrt==1 // Mautkosten 2 � je Einfahrt in die Umweltzone, also f�r Hin- und R�ckweg je 1 �
}
replace cPkw =  ((MeterKfz* `benzin' / 1000)+Maut)  / lnwage if P // 10 ct je km (8 liter * 1,25 �/liter)
gen cPkw_kS = cPkw*(pTaet!=4& pTaet!=3) // keine Sch�ler
gen cPkw_Sch = cPkw*(pTaet==4|pTaet==3) // Sch�ler
gen cPkwM = 0
replace cPkwM =  ((MeterKfz* `benzin' / 1000)) / lnwage if  M // f�r Mitfahrer keine extra Maut
gen cPkwM_kS = cPkwM*(pTaet!=4& pTaet!=3) // keine Sch�ler
gen cPkwM_Sch = cPkwM*(pTaet==4|pTaet==3) // Sch�ler

gen cost = cOV+cPkw+cPkwM+cParkWage

}

end
****************************************************************************
