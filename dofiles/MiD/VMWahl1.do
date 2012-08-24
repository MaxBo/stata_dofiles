use "$MiD_workingdir\Stata\MidH_W0.dta" , clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta",uniqusing
drop _merge
sort PersId WegId
merge PersId using "$MiD_workingdir\Stata\MidH_P0.dta",uniqusing
MiDH_P_Label_neu
drop _merge
sort caseid PersId WegId
merge caseid using "$MiD_workingdir\Stata\MidH_HH0.dta",uniqusing
drop _merge

recode wVM11 (1=1 "Fuss") (2=2 "Rad") (3/5 9=4 "sont. MIV") (6/7=5 "Pkw-F") (8 10=3 "ÖV") (11=.b "sonstiges"),gen(mode5)
egen hKinder14 = anycount(h?alter), values(0/14)
gen pEquivInc = ((hheink * 500)-200) / (1+0.5*(hhgr-hKinder14-1)+0.3*hKinder14)
drop  wWartezeit wUmzeit wUmGehZeit
gen wUmGehzeit = wUmweg / 4 * 60 // 4 km/h
gen wUmzeit = wBefoerderungszeit -  wFahrtzeit // Differenz der Zeit "Hst-Hst" und "Fahrtzeit im Fahrzeug"
gen wWartezeit = wUmzeit - wUmGehzeit

expand 5
bysort WegId: gen altnum = _n
gen choice = altnum==mode5
gen _sample = 1
replace _sample = 0 if mode5>=.
gen F = altnum==1
gen R = altnum==2
gen O = altnum==3
gen M = altnum==4
gen P = altnum==5

replace _sample = 0 if O & AnzRouten>=.
replace _sample = 0 if F & MeterKfz>=10000
replace _sample = 0 if R & MeterKfz>=30000
replace _sample = 0 if P & pPkwVerf==0
gen PPkwGel = P & pPkwVerf==1
replace _sample = 0 if R & pRadVerf==0
// // keine Wege außerhalb der Region
// replace _sample = 0 if VZNrStartPunkt >= 50000 | VZNrZielPunkt >= 50000
replace _sample = 0 if O & wUmweg > 1 // über 1 km Umsteigeweg unrealistisch
replace _sample = 0 if O & wUmzeit > 30 // über 30 Minuten Umsteigezeit unrealistisch
replace _sample = 0 if O & (wWartezeit <0 | wWartezeit > 30)





gen FwGehzeit = 0
replace FwGehzeit = MinFuss if F
gen RwFahrtzeit = 0
replace RwFahrtzeit = MinRad if R
gen MPwFahrtzeit = 0
replace MPwFahrtzeit = MinKfz if (M|P)
gen OwSWZ = 0
replace OwSWZ = wSWZ if O
gen OwFahrtzeit = 0
replace OwFahrtzeit = wFahrtzeit if O
gen OwBahnFahrtzeit = 0
replace OwBahnFahrtzeit = wBahnFahrtzeit if O
gen OwBusFahrtzeit = 0
replace OwBusFahrtzeit = wBusFahrtzeit if O
gen OwUmhaeufigkeit = 0
replace OwUmhaeufigkeit = wUmhaeufigkeit if O
gen OwZuAbzeit = 0
replace OwZuAbzeit = (wZuzeit + wAbzeit) if O
gen OwUmZeit = 0
replace OwUmZeit = wUmzeit if O
gen OwUmGehzeit = 0
replace OwUmGehzeit = wUmGehzeit if O
gen OwWartezeit = 0
replace OwWartezeit = wWartezeit if O



gen Bus = O * wBusFahrtzeit / wFahrtzeit
gen Bahn = O * wBahnFahrtzeit / wFahrtzeit

gen Buskm = O * wBusKm / wFahrtKm
gen Bahnkm = O * wBahnKm / wFahrtKm


// Umsteigehäufigkeit als Dummy-Variable
gen OwUH = round(OwUmh)
gen OwUH1 = OwUH==1
gen OwUH2 = OwUH==2
gen OwUH3 = (OwUH>=3 & OwUH<.)

foreach vm in F R O M {
	di "`vm'zwBeruf"
	gen `vm'zwBeruf = `vm' & hpzweck==1
	gen `vm'zwAusbildung = `vm' & hpzweck==2
	gen `vm'zwDient = `vm' & hpzweck==3
	gen `vm'zwBegleitung = `vm' & hpzweck==4
	gen `vm'zwPrivErl = `vm' & hpzweck==5
	gen `vm'zwEinkauf = `vm' & hpzweck==6
//   gen `vm'zwFreizeit = `vm' & (hpzweck==7 | hpzweck==8)
}


foreach vm in F R O M {
	di "`vm'Taetigkeit"
//	gen `vm'TkVoll = `vm' & pTaet==1
	gen `vm'TkTeil = `vm' & pTaet==2
	gen `vm'TkAzubi = `vm' & pTaet==3
	gen `vm'TkStudi = `vm' & pTaet==4
	gen `vm'TkNE = `vm' & pTaet==1
}
gen PM_DiAP = (P|M) * (DiZiAPpriv + DiZiAPOD + DiZiStudPl)
gen PM_DiZiEW = (P|M) * DiZiEW
gen PM_DiEinkaper = (P|M) * DiZiEHaper
gen Kfzkm = MeterKfz/1000
gen KfzKosten = Kfzkm * 1.05 * 8/100 // 1.05 EUR je Liter in 2003 und 8 Liter / 100 km Durchschnittsverbrauch
gen KfzKostenPark = KfzKosten + (ParkzeitZielPunkt-1) * .35 // Parkgebühren von 0 - 120 €/Monat
gen PParkZeit = P * (ParkzeitZielPunkt + ParkzeitStartPunkt)
gen PParkZeitQ = P * (ParkzeitStartPunkt)
gen PParkZeit2 = PParkZeit^2

gen OwSWZAusb = OwSWZ * (hpzweck==2)


// gen Kosten = P * KfzKosten + (M * KfzKosten / 3) // für Mitfahrer nur 1/3 der Pkw-Fahrer-Kosten
gen Kosten = P * KfzKostenPark + (M * KfzKostenPark / 3) // für Mitfahrer nur 1/3 der Pkw-Fahrer-Kosten
replace Kosten = EK if O & ((hpzweck>=3 & hpzweck<.) & (pTicketart != 3 & pTicketart != 4 & pTicketart != 5))
replace Kosten = ZK/44 if O & (hpzweck<=2 & (wZweck == 1 | wZweck == 3 | wZweck==8)) // Hin-/Rückweg der ÖV-Pendler: Monatskartenpreis / 44 Pendelfahrten
// Zwischenwege eines Arbeitsweges: auf 0 Eur lasse, da mit Zeitkarte keine Mehrkosten
replace Kosten = 0 if O & pHauptbesch==4 & pTicketart == 5 // Studenten mit Semesterticket

//gen Min5 = round(Minuten*2,10)/2
//graph box MPwFahrtzeit if P & choice & _sample & Minuten < 60, over(Min5)

gen KostenjeMinutenLohn = Kosten / (pEquivInc / (60*8*20)) // 60 Minuten * 8 Stunden * 20 Arbeitstage


// xi i.hheink|Kosten,noomit
// clogit choice F R O M _IhheX*  FwGehzeit RwFahrtzeit MPwFahrtzeit PParkZeit OwSWZ OwSWZAusb  OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample, group(WegId)

clogit choice PPkwGel ?Tk* F R Bus Bahn M KostenjeMinutenLohn FwGehzeit RwFahrtzeit MPwFahrtzeit PParkZeitQ OwSWZ OwSWZAusb OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample  & (wZweck==1 |  wZweck==3), group(WegId)  constraint(5)

clogit choice F R O M ?zw* KostenjeMinutenLohn FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwSWZAusb OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M KostenjeMinutenLohn FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwSWZAusb OwFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M ?zw* FwGehzeit RwFahrtzeit MPwFahrtzeit PParkZeit OwSWZ OwSWZAusb  OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M ?zw* FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M  FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit  OwZuAbzeit PParkZeit if _sample & wZweck==1, group(WegId)
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit PParkZeit  if _sample & wZweck==1, group(WegId)
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample & wZweck==3, group(WegId)
// Einkauf täglichger Bedarf
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit  OwZuAbzeit PParkZeit if _sample & hpzweck==6 & wZweckEinkauf==501, group(WegId)
// Einkauf Sontige Waren/Einkaufsbummel
clogit choice F R O M MPKosten OVKosten FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit  OwZuAbzeit PParkZeit* Pkm if _sample & hpzweck==6 & (wZweckEinkauf==502 | wZweckEinkauf==503), group(WegId)
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSWZ OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit Pkm if _sample & hpzweck==6 & (wZweckEinkauf==502 | wZweckEinkauf==503), group(WegId)
