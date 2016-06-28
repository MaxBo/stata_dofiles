
quietly {
noi di "Lade Wegedaten"
use "$MiD_workingdir\Stata\MidH_W0.dta" , clear
qui compress
format wKm %3.1f wegdauer %3.0f
// codiere Modell-Wegezwecke
recode wZweck (5 7 10 11 40/42 =6) (31=7) (32=8) (8=9), gen(wZweckModell)
label define wZweckModell 1 "Arbeit" 2 "Dienstlich" 3 "Ausbildung" 4 "per. Einkauf" 5 "aper. Einkauf" 6 "Freizeit/Erledigung" 7 "Schule" 8 "Kita" 9 "Rückweg"
label values wZweckModell wZweckModell
replace wZweckModell = 5 if (wZweckEink==502|wZweckEink==503|wZweckErl==503|wZweckFreiz==503)
replace wZweckModell = 6 if (wZweckEink==504)

noi di "bilde Touren"
// bilde Touren mit Endpunkt "zu Hause"
gsort PersId -WegId
by PersId: gen TourId = 1 if _n==1
gen nachHause = wZweck==8 // markiere Rückwege // vorher:  wZweckModell==9
by PersId: replace TourId = TourId[_n-1] + nachHause if _n>1
by PersId: replace TourId = TourId[_N]  - TourId + 1
sort PersId WegId
bysort PersId TourId (WegId): gen TourWegId = _n
bysort PersId (WegId): gen vonZuHause = (wStartpunkt==1 | nachHause[_n-1])
bysort PersId TourId: egen TourAnzWege = count(TourWegId)
noi di "bilde Hauptverkehrsmittel der Tour"
// bilde Haupt-Verkehrsmittel der Tour und codiere in 5-er-Einteilung um
bysort PersId TourId: egen TourVM11 = max(wVM11)
recode wVM11 (1=1 "Fuss") (2=2 "Rad") (3/5 9=4 "sont. MIV") (6/7=5 "Pkw-F") (8 10=3 "ÖV") (11=.b "sonstiges"),gen(mode5)
recode TourVM11 (1=1 "Fuss") (2=2 "Rad") (3/5 9=4 "sont. MIV") (6/7=5 "Pkw-F") (8 10=3 "ÖV") (11=.b "sonstiges"),gen(Tourmode5)

bysort PersId TourId (WegId): egen AWTour = total(wZweck == 1 | wZweck== 3)
bysort PersId TourId (WegId): egen ShoppingTour = total(wZweckModell==5)
bysort PersId TourId (WegId): egen SonstigeTour = total(!(wZweckModell==4 | wZweckModell==5 | wZweckModell==9))

// markiere Hin- und Rückwege
bysort PersId (WegId): gen istAW = 1 if (wZweck==1 | wZweck==3) & (wZweck[_n-1]==8 | wZweck[_n-1]==9 | wStartpunkt==1)
bysort PersId (WegId): replace istAW = 2 if (wZweck==8) & (wZweck[_n-1]==1 | wZweck[_n-1]==3)
recode istAW (.=.z) if AWTour > 0 & AWTour < .
label define istAW 1 "Hinweg" 2 "Heimweg" .z "Zwischenweg"
label values istAW istAW
// zähle Wege W-A und A-W
by PersId: egen hatAW = count(istAW)
label var hatAW "count(istAW)"
by PersId: egen hatHinweg = total(istAW==1)
label var hatHinweg "total(istAW==1)"
bysort PersId TourId: egen TourKm = total(wKm)
// berechne Aktivitätendauer in Minuten (60000 1/1000 Sekunden)
bysort PersId TourId: gen AktDauer = (Abfahrt[_n+1]-Ankunft) / 60000
replace AktDauer = AktDauer + 1440 if AktDauer < 0

// noi di "lösche Pendeltouren"
// keep if AWTour==0 // betrachte nur Wege, die nicht Teil einer Pendeltour sind
drop if mode5 >=.
sort WegId
noi di "spiele Zeit und Kostenvariablen zu"
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", uniqusing nokeep
drop _merge

replace MeterKfz = MeterFuss if MeterKfz>=. & MeterFuss<.

drop if mode5==1 & MeterFuss > 6000 // Fusswege über 6 km
drop if mode5==2 & MeterFuss > 30000 // Radstrecken über 30 km
drop if MeterKfz > 150000 & MeterKfz <. // Alle Wege über 150 km
sort caseid PersId
noi di "spiele Haushaltsinformationen zu"
merge caseid using "$MiD_workingdir\Stata\HH_inc_dem_imputed.dta",uniqusing nokeep keep( HHGroesse  GEW_HA HHErwachsene HHErw03 HHKind*  hheink_imp)
drop _merge
sort caseid PersId
merge caseid using "$MiD_workingdir\Stata\MidH_HH0.dta",uniqusing nokeep keep(hPkw)
drop _merge
sort PersId
noi di "spiele Personeninfos zu"
merge PersId using "$MiD_workingdir\Stata\MidH_P0.dta",uniqusing nokeep
drop _merge
MiDH_P_Label_neu
rename VZNrStartPunkt VZNR
sort VZNR
merge VZNR using "$MiD_workingdir\Stata\VZ_Umweltzone.dta",uniqusing
drop _merge
rename UZ UZ_Start
recode UZ_Start (.=0) if VZNR<.
rename VZNR VZNrStartPunkt
rename VZNrZielPunkt  VZNR
sort VZNR
merge VZNR using "$MiD_workingdir\Stata\VZ_Umweltzone.dta",uniqusing
drop _merge
rename UZ UZ_Ziel
recode UZ_Ziel (.=0) if VZNR<.
rename VZNR VZNrZielPunkt
gen UZ_Einfahrt = (UZ_Start + UZ_Ziel) ==1
replace UZ_Einfahrt = . if UZ_Start>=. | UZ_Ziel>=.
noi di "bilde Pkw-Verfügbarkeit"
gen byte hPkwVerf = 0
replace hPkwVerf = 1 if hPkw < HHErwachsene & hPkw<. & hPkw > 0 & HHErwachsene < .
replace hPkwVerf = 2 if hPkw >= HHErwachsene & hPkw<. & HHErwachsene < .
replace hPkwVerf = 0 if pAlter<18
label define hPkwVerf 0 "kein Pkw" 1 "Pkw geteilt" 2 "eigener Pkw"
label values hPkwVerf hPkwVerf

noi di "codiere Personengruppen"
recode pTaet (0=.a "nicht Erwerbstätig") (3/5 = 1 "Ausbildung") (1/2 = 0 "Voll/Teilzeit"), gen (pAusb) 
label var pAusb "Ausbildung"
recode HHErwachsene (0=.a "kein Erwachsener im HH") (1=1 "1 Erwachsener") (2=2 "2 Erwachsene") (3/8=3 "3 und mehr"),gen(hGrErw)
label var hGrErw "Erwachsene in Haushalt (1, 2, 3+)"

gen byte pGrup9 = .
replace pGrup9 = 1 if hGrErw == 1 & hheink_imp <=2
replace pGrup9 = 2 if hGrErw == 1 & hheink_imp ==3
replace pGrup9 = 3 if hGrErw == 1 & hheink_imp >3 & hheink_imp < .
replace pGrup9 = 4 if hGrErw == 2 & hheink_imp <=4
replace pGrup9 = 5 if hGrErw == 2 & hheink_imp ==5 | hheink_imp == 6
replace pGrup9 = 6 if hGrErw == 2 & hheink_imp >6 & hheink_imp < .
replace pGrup9 = 7 if hGrErw == 3 & hheink_imp <=5
replace pGrup9 = 8 if hGrErw == 3 & hheink_imp ==6 | hheink_imp == 7
replace pGrup9 = 9 if hGrErw == 3 & hheink_imp ==8
label define pGrup9 1 "1Erw<900€" 2 "1Erw900-1500€" 3 "1Erw>=1500€" 4 "2Erw<2000€" 5 "2Erw2000-3000€" 6 "2Erw>3000€" 7 "3Erw<2600€" 8 "3Erw2600-3600€" 9 "3Erw>=3600€"
label values pGrup9 pGrup9
label var pGrup9 "Personengruppe nach HHGr und Einkommen"
noi di "berechne Äqzuvalenzeinkommen"
// Berechnung des persönlichen Äquivalenzeinkommens
recode hheink_imp (1=400) (2=700) (3=1200) (4=1750) (5=2300) (6=2800) (7=3300) (8=4700),gen(pInc)
gen equPersons = 1 + ( HHKind14_17 + HHErwachsene-1)*.5 + (HHKind0_5 + HHKind6_13)*.3
replace pInc = pInc / equPersons
// gen wage = pInc / (20*8) // Studenlohn
gen wage0 = pInc / (20*8) // Studenlohn
replace wage0 = 3 if wage0 < 3 // bei wage = 1 wäre ln(1) = 0 und damit die Kosten-Parameter ungültig. Mindestlohn von 3 € wird angenommen
gen lnwage =  ln(wage0) // ln(Studenlohn)
gen DichteSt = DiStEW + 2*(DiStAPpriv + DiStAPOD)+ 3*DiStEHaperi+DiStStudPl
gen DichteZi = DiZiEW + 2*(DiZiAPpriv + DiZiAPOD)+ 3*DiZiEHaperi+DiZiStudPl
merge m:1 caseid pid using "$MiD\H\Stata\P_pkwverf.dta"
drop if _merge==1

compress
}




quietly {
noi di "speichere Datensatz für Einkaufsfahrten zwischen"
preserve
local fn "$MiD_workingdir\Stata\\P_Einkauf.dta"
keep if wZweckModell==4 & vonZuHause & TourAnzWege==2
saveold `fn', replace
restore
preserve
local fn "$MiD_workingdir\Stata\\P_EinkaufAper.dta"
keep if wZweckModell==5 & !SonstigeTour
saveold `fn', replace
keep WegId PersId caseid
* odbc insert WegId  PersId caseid, as("wegid persid caseid") dsn("h_localhost64") table("wege_ehaper") create
odbc insert WegId  PersId caseid, as("wegid persid caseid") dsn("h_localhost64") table("wege_ehaper") overwrite 
restore
}



quietly {
noi di "bilde eine Zeile je Alternative"
// setze Pkw-Nutzer in Haushalten ohne Pkw auf "sonstiger MIV"
// recode mode5 (5=4) if hPkwVerf==0
// erzeuge eine Zeile je Alternative
expand 5
bysort WegId: gen m = _n
label values m mode5
gen F = m==1
gen R = m==2
gen O = m==3
gen M = m==4
gen P = m==5
// suches gewähltes Verkehrsmittel
gen chosen = (m==mode5)
// markiere nicht mögliche Alternativen
gen _sample = 1
replace _sample = 0 if P & pAlter<18
// replace _sample = 0 if P & hPkwVerf==0
replace _sample = 0 if F & (MeterFuss>=10000 | MinFuss >=.)
replace _sample = 0 if R & (MeterFuss>=50000  | MinRad >=.)
replace _sample = 0 if O & wReisezeit >=.
replace _sample = 0 if MinKfz >=.

noi di "berechne Verfügbarkeits-Variablen"
// Auswirkungen Pkw-Verfügbarkeit auf Pkw-Nutzung
qui dropvars P_*Pkw M_*Pkw
* keine Pkw-Nutzung ohne Führerschein
replace _sample = 0 if P & PKW_FS <=1
gen P_keinPkw = P & (PKW_FS==2)
gen P_getPkw = P & (PKW_FS==3)
gen P_eigPkw = P & (PKW_FS==4)

gen M_kHHPkw = M & (PKW_FS==0 | PKW_FS==2)
gen M_kFhsHHPkw = M & (PKW_FS==1)
gen M_getPkw = M & (PKW_FS==3)
* gen M_eigPkw = M & (PKW_FS==4)

// Zeitkartenverfügbarkeit
gen ZK_OV = (zeitkarte==1) & O

noi di "bilde Reisezeit-Variablen"
// bilde Reisezeit-Variablen
// Fehler bei der Wartezeitberechnung bereinigen
replace  wWartezeit =  wBefoerderungszeit -  wUmGehZeit -  wFahrtzeit
gen tFuss = 0
replace tFuss = MinFuss if F
gen tFuss_kS = tFuss* (pTaet!=4& pTaet!=3) // keine Schüler
gen tFuss_Sch = tFuss* (pTaet==4|pTaet==3) // Schüler
gen tRad = 0
replace tRad = MinRad if R
gen tRad_kS = tRad* (pTaet!=4& pTaet!=3) // keine Schüler
gen tRad_Sch = tRad* (pTaet==4|pTaet==3) // Schüler
gen tPkw = 0
replace tPkw = MinKfz if (P)
gen tPkw_kS = tPkw* (pTaet!=4& pTaet!=3) // keine Schüler
gen tPkw_Sch = tPkw* (pTaet==4|pTaet==3) // Schüler
gen tMF = 0
replace tMF = MinKfz if (M)
gen tMF_kS = tMF* (pTaet!=4& pTaet!=3) // keine Schüler
gen tMF_Sch = tMF* (pTaet==4|pTaet==3) // Schüler

gen tOV_FZ = 0
replace tOV_FZ = wFahrtzeit if O
gen tOV_FZBus = 0
replace tOV_FZBus = wBusFahrtzeit if O
gen tOV_FZBus_kS = tOV_FZBus* (pTaet!=4& pTaet!=3) // keine Schüler
gen tOV_FZBus_Sch = tOV_FZBus* (pTaet==4|pTaet==3) // Schüler
gen tOV_FZBahn = 0
replace tOV_FZBahn = wBahnFahrtzeit if O
gen tOV_FZBahn_kS = tOV_FZBahn*(pTaet!=4& pTaet!=3) // keine Schüler
gen tOV_FZBahn_Sch = tOV_FZBahn*(pTaet==4|pTaet==3) // Schüler
gen tOV_SWZ = 0
replace tOV_SWZ = (wSWZ) if O
gen tOV_SWZ_kS = tOV_SWZ*(pTaet!=4& pTaet!=3) // keine Schüler
gen tOV_SWZ_Sch = tOV_SWZ*(pTaet==4|pTaet==3) // Schüler
gen tOV_WZ = 0
replace tOV_WZ = wWartezeit if O
gen tOV_UH = 0
replace tOV_UH = wUmhaeufigkeit if O
gen tOV_UH_kS = tOV_UH*(pTaet!=4& pTaet!=3) // keine Schüler
gen tOV_UH_Sch = tOV_UH*(pTaet==4|pTaet==3) // Schüler
gen tOV_Gehzeit = 0
replace tOV_Gehzeit = (wUmGehZeit+wZuzeit+wAbzeit) if O
gen Bus = 0
replace Bus = wBusFahrtzeit / wFahrtzeit if O
gen Bahn = 0
replace Bahn = wBahnFahrtzeit / wFahrtzeit if O

noi di "berechne Kosten-Variablen"

replace _sample = 0 if lnwage>=.
}

MiDH_Kosten, benzin(0.10) zeitkarte

constraint define 2 tOV_FZBahn =  tOV_FZBus / 1.2 // / 1.2
constraint define 3 tOV_FZBus = -0.05
// constraint define 4 tOV_WZ = tOV_FZBahn * 2
constraint define 4 tOV_WZ = tOV_FZ * 2
constraint define 5 tPkw = tMF
// constraint define 6 tPkw = tMF
// constraint define 4 tOVVorbereitung = tOV_FZBus


// einfaches Modell zur Berechnung der LogSums 
constraint define 4 tOV_WZ = tOV_FZ * 2
constraint define 41 tOV_WZ = tOV_FZBahn * 2
constraint define 5 tPkw = tMF
constraint define 11 cPkw = 20*tPkw
constraint define 12 cPkw = cOV
constraint define 13 cPkwM = 0
constraint define 14 cPkwM = cPkw
constraint define 15 tFuss = tOV_Gehzeit
constraint define 16 Bahn = Bus
constraint define 20 F = 0
constraint define 21 R = 0
constraint define 22 Bahn = 0
constraint define 44 tOV_FZ = -0.05

clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ tOV_Gehzeit tOV_WZ /*  tOV_UH 
*/ cOV cPkw cPkwM    /*  cost cPkw cPkwM  tPark
*/ if _sample & vonZuHause & TourAnzWege==2,group(WegId) /* 
*/ constraint(4 11 12 13) // 


clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ tOV_Gehzeit tOV_WZ /*  tOV_UH 
*/ if _sample & vonZuHause & TourAnzWege==2,group(WegId) /* 
*/ constraint(44) // 

clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn M /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_Gehzeit tOV_WZ /*  tOV_UH 
*/ cOV cPkw cPkwM  /*  cost cPkw cPkwM  tPark
*/ if _sample & vonZuHause & TourAnzWege==2,group(WegId) constraint(41 2 5 11 12 14 15 ) // 

** Das ist das aktuelle Modell, das zur Schätzung für Einkaufen periodisch verwendet wurde...
clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn M /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_Gehzeit tOV_WZ /*  tOV_UH 
*/ cOV cPkw cPkwM   ZK_OV /*  cost cPkw cPkwM  tPark
*/ if _sample & (wZweckModell==4) & vonZuHause & TourAnzWege==2,group(WegId) constraint(41 5 11 12 14 15 16) // 

local fn "D:\\temp\\test2"
estimates save `fn', replace
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace

clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn M /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_Gehzeit tOV_WZ /*
*/ cOV cPkw cPkwM tPark   /* tOV_UH
*/ if _sample & (wZweckModell==4),group(WegId) constraint(4)


clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn M /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_Gehzeit tOV_WZ /*
*/ cOV cPkw cPkwM cParkWage  /* 
*/ if _sample & (wZweckModell==4),group(WegId) constraint(2 3)

clogit chosen P_*Pkw M_*Pkw  /* & wZweck==7 ZK_OV   & wZweckEinkauf==502
*/ F R Bus Bahn M /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_Gehzeit tOV_WZ /*
*/ cost /* 
*/ if _sample & (wZweckModell>=4&wZweckModell<=6),group(WegId) constraint(2 3)

estimates store c0
local fn D:\temp\ModeChoiceNonWorkClogit
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace
estimates save `fn', replace

quietly {
local fn D:\temp\ModeChoiceNonWorkClogit
estimates use `fn'
replace _sample = 0 if (wZweckModell<4|wZweckModell>6)
dropvars Meter
gen Meter = MeterKfz
replace Meter = 50000 if Meter < . & Meter > 50000
************************************
noi di "Referenzfall"
MiDH_Kosten, benzin(0.10) zeitkarte
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 €"
MiDH_Kosten, benzin(0.1224) zeitkarte // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 3,60 €"
MiDH_Kosten, benzin(0.223) zeitkarte // 6.2 Liter bei Benzinpreis von 3.60 €
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 € + CityMaut"
MiDH_Kosten, benzin(0.1224) zeitkarte citymaut  // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 € + Regio-Maut"
MiDH_Kosten, benzin(0.1224) zeitkarte regiomaut  // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 € + Regio-/CityMaut"
MiDH_Kosten, benzin(0.1224) zeitkarte regiomaut citymaut // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 € + Halbpreisticket"
MiDH_Kosten, benzin(0.1224) zeitkarte halbpreis // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare
 
noi di "Benzinpreis 1,80 € + JobTicket für alle Beschäftigten"
MiDH_Kosten, benzin(0.1224) zeitkarte jobticket // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 € + Halbpreisticket + Jobtickt für alle Beschäftigten"
MiDH_Kosten, benzin(0.1224) zeitkarte halbpreis jobticket // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 1,80 € + Halbpreisticket + Regio-/CityMaut + Jobtickt für alle Beschäftigten"
MiDH_Kosten, benzin(0.1224) zeitkarte halbpreis jobticket regiomaut citymaut // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

noi di "Benzinpreis 3,60 € + Halbpreisticket + Regio-/CityMaut + Jobtickt für alle Beschäftigten"
MiDH_Kosten, benzin(0.223) zeitkarte halbpreis jobticket regiomaut citymaut // 6.8 Liter bei Benzinpreis von 1.80 €
MiDH_PredictModeShare

}
**************************************




