quietly {
use "$MiD_workingdir\Stata\MidH_W0.dta" , clear
qui compress
format wKm %3.1f wegdauer %3.0f

// bilde Touren mit Endpunkt "zu Hause"
gsort PersId -WegId
by PersId: gen TourId = 1 if _n==1
gen nachHus = wZweck==8 // markiere Rückwege
by PersId: replace TourId = TourId[_n-1] + nachHus if _n>1
by PersId: replace TourId = TourId[_N]  - TourId + 1
sort PersId WegId
bysort PersId TourId (WegId): gen TourWegId = _n
// bilde Haupt-Verkehrsmittel der Tour und codiere in 5-er-Einteilung um
bysort PersId TourId: egen TourVM11 = max(wVM11)
recode wVM11 (1=1 "Fuss") (2=2 "Rad") (3/5 9=4 "sont. MIV") (6/7=5 "Pkw-F") (8 10=3 "ÖV") (11=.b "sonstiges"),gen(mode5)
recode TourVM11 (1=1 "Fuss") (2=2 "Rad") (3/5 9=4 "sont. MIV") (6/7=5 "Pkw-F") (8 10=3 "ÖV") (11=.b "sonstiges"),gen(Tourmode5)

bysort PersId TourId (WegId): egen AWTour = total(wZweck == 1 | wZweck== 3)
// markiere Hin- und Rückwege
bysort PersId (WegId): gen istAW = 1 if (wZweck==1 | wZweck==3) & (wZweck[_n-1]==8 | wZweck[_n-1]==9 | wStartpunkt==1)
bysort PersId (WegId): replace istAW = 2 if (wZweck==8) & (wZweck[_n-1]==1 | wZweck[_n-1]==3)
// zähle Wege W-A und A-W
by PersId: egen hatAW = count(istAW)
label var hatAW "count(istAW)"
by PersId: egen hatHinweg = total(istAW==1)
label var hatHinweg "total(istAW==1)"
bysort PersId TourId: egen TourKm = total(wKm)

sort PersId WegId
merge PersId using "$MiD_workingdir\Stata\P_kg_IV.dta" ,uniqusing
drop _merge
sort PersId WegId
merge PersId using "$MiD_workingdir\Stata\PersMitMehrerenAO.dta" ,uniqusing
drop _merge


// prüfe Entfernungen auf Unplaubilititäten
gen MeterOV = (wFahrtKm + wZuweg + wAbweg) * 1000
egen MeterAW = rowmax(MeterFuss MeterKfz MeterOV)
gen TourAWRatio = TourKm * 1000/ MeterAW

sort PersId WegId
merge PersId using "$MiD_workingdir\Stata\MidH_P0.dta",uniqusing
MiDH_P_Label_neu
drop _merge

drop if Weg==.
drop if AWTour == 0 | MehrereAO==1 // Lösche Personen ohne ArbeitsTour oder mit verschiedenen Arbeitsorten
drop if MeterAW==.

// wenn mehrere Touren zur Arbeit von einer Person berichtet wurden, schau, ob die VM gleich waren
keep if TourWegId ==1
duplicates tag PersId,gen(mehrereAWTouren)
bysort PersId (TourId): gen verschPendelVM = (Tourmode5 != Tourmode5[_n-1]) if mehrereAWTouren & _n>1
bysort PersId: egen mehrerePendelVM = total (verschPendelVM) if mehrereAWTouren & _n>1
// reduziere dann auf eine Tour pro Person
bysort PersId: keep if _n==1
// ansonsten lösche Person, da Pendelverkehrsmittel nicht bestimmbar
drop if mehrerePendelVM>0 & mehrerePendelVM<.


dropvars  WegId weg wStartpunkt wZiel wNurEinWeg wAlleWege wZweck* wVM*  wFahrer wHHKfz wwelchesKfz 
dropvars wBegleitung wAnzBegleiter wHHBegleiter wBeglPers?  wPersFahrer wKm wegdauer hpzweck diwzw?
dropvars  wVM11 wtag wegtempo Abfahrt Ankunft Minuten Stunden wTempo wStichtag nachHus mode5 istAW TourId

drop if TourAWRatio > 4 // Wenn Tourlänge insgesamt 4* die kürzeste Entfernung W-A ist, dann 
// ist auch die Verkehrsmittelwahl von anderen Aspekten dominiert
// keep if pTaetigkeit >=1 & pTaetigkeit<. // behalte alle Erwerbstätigen und in Ausbildung
replace MeterKfz = MeterFuss if MeterKfz>=. & MeterFuss<.
drop if Tourmode5==1 & MeterFuss > 6000 // Fusswege über 6 km
drop if Tourmode5==2 & MeterFuss > 30000 // Radstrecken über 30 km
drop if MeterKfz > 150000 & MeterKfz <. // Alle Wege über 150 km 

save "$MiD_workingdir\Stata\MidH_PTour.dta" , replace
}

use "$MiD_workingdir\Stata\MidH_PTour.dta" , clear
quietly {
sort caseid PersId
merge caseid using "$MiD_workingdir\Stata\HH_inc_dem_imputed.dta",uniqusing nokeep
drop _merge
sort caseid PersId
merge caseid using "$MiD_workingdir\Stata\MidH_HH0.dta",uniqusing nokeep keep(hPkw)
drop _merge
gen byte hPkwVerf = 0
replace hPkwVerf = 1 if hPkw < HHErwachsene & hPkw<. & hPkw > 0 & HHErwachsene < .
replace hPkwVerf = 2 if hPkw >= HHErwachsene & hPkw<. & HHErwachsene < .
replace hPkwVerf = 0 if pAlter<18
label define hPkwVerf 0 "kein Pkw" 1 "Pkw geteilt" 2 "eigener Pkw"
label values hPkwVerf hPkwVerf

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

// Berechnung des persönlichen Äquivalenzeinkommens
recode hheink_imp (1=400) (2=700) (3=1200) (4=1750) (5=2300) (6=2800) (7=3300) (8=4700),gen(pInc)
gen equPersons = 1 + ( HHKind14_17 + HHErwachsene-1)*.5 + (HHKind0_5 + HHKind6_13)*.3
replace pInc = pInc / equPersons
// gen wage = pInc / (20*8) // Studenlohn
gen wage0 = pInc / (20*8) // Studenlohn
gen wage =  ln(wage0) // ln(Studenlohn)
gen Dichte = DiHHEW + 2*(DiHHAPpriv + DiHHAPOD)+ 3*DiHHEHaperi+DiHHStudPl

compress
}

quietly {
preserve
keep PersId pInc pAusb  wage GEW_HA HHGroesse hGrErw HHKinder pAlter pTaet pFhs pFrau pPkwVerf pRadVerf VZNr Dichte  VZNR_AP ParkZeitAP
save "$MiD_workingdir\txt\P_Pendler.dta", replace
// outsheet PersId pInc pAusb wage GEW_HA HHGroesse pAlter pFhs pFrau pPkwVerf pRadVerf VZNr using "$MiD_workingdir\txt\P_Pendler.txt", noquote replace
restore
}
quietly {
// erzeuge eine Zeile je Alternative
expand 15
bysort PersId: gen AltNum = _n-1
gen byte v = AltNum / 5
gen byte p = mod(AltNum,5)+1

gen F = p==1
gen R = p==2
gen O = p==3
gen M = p==4
gen P = p==5
gen keinPkw = v==0
gen getPkw = v==1
gen eigPkw = v==2
// suches gewähltes Verkehrsmittel
gen chosen = (v==hPkwVerf) & (p==Tourmode5)
// markiere nicht mögliche Alternativen
gen _sample = 1
replace _sample = 0 if !keinPkw & pAlter<18
replace _sample = 0 if getPkw & hGrErw==1
replace _sample = 0 if !keinPkw & hGrErw==0
replace _sample = 0 if F & (TourKm>=10 | MinFuss >=.)
replace _sample = 0 if R & (TourKm>=50  | MinRad >=.)
replace _sample = 0 if O & wReisezeit >=.
replace _sample = 0 if MinKfz >=.

// Haushaltsgröße -> Pkw-Verfügbarkeit
gen H1eigPkw = (hGrErw==1)* eigPkw
gen H2getPkw = (hGrErw==2)* getPkw
gen H2eigPkw = (hGrErw==2)* eigPkw
gen H3getPkw = (hGrErw==3)* getPkw
gen H3eigPkw = (hGrErw==3)* eigPkw

// Kinder im Haushalt
qui dropvars  HHKinder01 Kind*Pkw
recode HHKinder (1/8=1),gen(HHKinder01)
gen KindgetPkw = HHKinder01* getPkw
gen KindeigPkw = HHKinder01* eigPkw

// Person noch in Ausbildung
gen AusbgetPkw = pAusb==1*getPkw
gen AusbeigPkw = pAusb==1*eigPkw

// gen ZK_Vollzeit = z*(pTaet==1)
// gen ZK_Teilzeit = z*(pTaet==2)
// gen ZK_Azubi = z*(pTaet==3)
// gen ZK_Schueler = z*(pTaet==4)
// gen ZK_Studi = z*(pTaet==5)
// replace _sample = 0 if z==0 & pTaet==5



// Auswirkungen Pkw-Verfügbarkeit auf Pkw-Nutzung
qui dropvars P_*Pkw M_*Pkw
gen P_keinPkw = P & keinPkw
gen P_getPkw = P & getPkw
// gen P_eigPkw = P & eigPkw
gen M_keinPkw = M & keinPkw
gen M_getPkw = M & getPkw
// gen M_eigPkw = M & eigPkw

// Pkw-Verfügbarkeit und Zeitkartenverfügbarkeit
// qui dropvars ZK*Pkw
// gen ZKgetPkw = z &  getPkw
// gen ZKeigPkw = z &  eigPkw

// gen ZK_OV = z & O

// Bilde DichteWert als Proxy für Parkplatzverfügbarkeit am Wohnort
qui dropvars Dichte*Pkw
gen DichtegetPkw = 0
replace DichtegetPkw = log(Dichte+1) if getPkw
gen DichteeigPkw = 0
replace DichteeigPkw = log(Dichte+1) if eigPkw

gen EHgetPkw = 0
replace EHgetPkw = log(DiHHEHperi+1)*getPkw
gen EHeigPkw = 0
replace EHeigPkw = log(DiHHEHperi+1)*eigPkw

// bilde Reisezeit-Parameter
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

MiDH_rInc, benzin(0.10)

replace _sample = 0 if wage>=.

gen EinkgetPkw = wage* getPkw
gen EinkeigPkw = wage* eigPkw


constraint define 1 cOV_kS = cPkw_kS
constraint define 2 cOV_Sch = cPkw_Sch
constraint define 3 cPkwM_kS = cPkw_kS
constraint define 4 cPkwM_Sch = cPkw_Sch
constraint define 5 cParkWage_kS = cPkw_kS
constraint define 6 cParkWage_Sch = cPkw_Sch
}


clogit chosen P_*Pkw M_*Pkw Dichte*Pkw H*Pkw Kind*Pkw Ausb*Pkw  /*
*/ F R Bus Bahn M /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_UH tOV_Gehzeit tOV_WZ rInc`incoffset'ln if _sample,group(PersId)
estimates store c0


clogit chosen P_*Pkw Dichte*Pkw H*Pkw Kind*Pkw Ausb*Pkw ZK*Pkw ZK_*  /*
*/ F R Bus Bahn M /*
*/ tFuss_* tRad_* tPkw_* tMF_* tOV_FZBus_* tOV_FZBahn_*  tOV_SWZ_* tOV_UH_* tOV_Gehzeit tOV_WZ rInc`incoffset'ln  if _sample,group(PersId)
estimates store c1



clogit chosen P_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw  ZK*Pkw ZK_*  /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZBus tOV_FZBahn tOV_SWZ tOV_UH tOV_Gehzeit tOV_WZ cOV cPkw cPkwM cPark  if _sample,group(PersId)
estimates store c2
clogit chosen P_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw ZK*Pkw ZK_OV  /* 
*/ F R Bus Bahn M  /*
*/ tFuss_* tRad_* tPkw_* tMF_* tOV_FZBus_* tOV_FZBahn_*  tOV_SWZ_* tOV_UH_* tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample,group(PersId) constr(1/6)
estimates store c3


clogit chosen P_*Pkw M_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw ZK*Pkw ZK_OV ZK_Studi /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ_* tOV_UH tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample,group(PersId) constr(1 2 3 4)
estimates store c4

clogit chosen P_*Pkw M_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw  /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ_* tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample,group(PersId) constr(1 2 3 4 5 6) //  
estimates store c5

local fn D:\temp\testClogit.txt
outreg using `fn', bdec(5) tdec(5) noparen noaster replace



************************************
predict Prob if _sample, pc1
egen PGes = total(Prob)
bysort AltNum: egen PAlt= total(Prob)
replace PAlt = PAlt / PGes * 100
gen FLGew = Prob* MeterKfz * 322 / 1000
gen PersGew = Prob * 322
tab p [iw=FLGew]
tab p [iw=PersGew]
tab v [iw=PersGew]
tab z [iw=PersGew]

MiDH_rInc, benzin(0.1224) // 6.8 Liter bei Benzinpreis von 1.80 €

predict ProbSprit180 if _sample, pc1
egen PGesSprit180 = total(ProbSprit180)
bysort AltNum: egen PAltSprit180= total(ProbSprit180)
replace PAlt = PAltSprit180 / PGesSprit180 * 100
gen FLGewSprit180 = ProbSprit180* MeterKfz * 322 / 1000
gen PersGewSprit180 = ProbSprit180 * 322
tab p [iw=FLGewSprit180]
tab p [iw=PersGewSprit180]
tab v [iw=PersGewSprit180]
tab z [iw=PersGewSprit180]

MiDH_rInc, benzin(0.223) // 6.2 Liter bei Benzinpreis von 3.60 €

predict ProbSprit360 if _sample, pc1
egen PGesSprit360 = total(ProbSprit360)
bysort AltNum: egen PAltSprit360= total(ProbSprit360)
replace PAlt = PAltSprit360 / PGesSprit360 * 100
gen FLGewSprit360 = ProbSprit360* MeterKfz * 322 / 1000
gen PersGewSprit360 = ProbSprit360 * 322
tab p [iw=FLGewSprit360]
tab p [iw=PersGewSprit360]
tab v [iw=PersGewSprit360]
tab z [iw=PersGewSprit360]

MiDH_rInc, benzin(0.1224) regiomaut // 6.8 Liter bei Benzinpreis von 1.80 €

predict ProbSpritRM if _sample, pc1
egen PGesSpritRM = total(ProbSpritRM)
bysort AltNum: egen PAltSpritRM= total(ProbSpritRM)
replace PAlt = PAltSpritRM / PGesSpritRM * 100
gen FLGewSpritRM = ProbSpritRM* MeterKfz * 322 / 1000
gen PersGewSpritRM = ProbSpritRM * 322
tab p [iw=FLGewSpritRM]
tab p [iw=PersGewSpritRM]
tab v [iw=PersGewSpritRM]
tab z [iw=PersGewSpritRM]

MiDH_rInc, benzin(0.1224) jobticket // 6.8 Liter bei Benzinpreis von 1.80 €

predict ProbSpritJobT if _sample, pc1
egen PGesSpritJobT = total(ProbSpritJobT)
bysort AltNum: egen PAltSpritJobT= total(ProbSpritJobT)
replace PAlt = PAltSpritJobT / PGesSpritJobT * 100
gen FLGewSpritJobT = ProbSpritJobT* MeterKfz * 322 / 1000
gen PersGewSpritJobT = ProbSpritJobT * 322
tab p [iw=FLGewSpritJobT]
tab p [iw=PersGewSpritJobT]
tab v [iw=PersGewSpritJobT]
tab z [iw=PersGewSpritJobT]

**************************************

constraint define 1 [AltNum]cOV_kS = [AltNum]cPkw_kS
constraint define 2 [AltNum]cOV_Sch = [AltNum]cPkw_Sch
constraint define 3 [AltNum]cPkwM_kS = [AltNum]cPkw_kS
constraint define 4 [AltNum]cPkwM_Sch = [AltNum]cPkw_Sch
constraint define 5 [AltNum]cParkWage_kS =[AltNum]cPkw_kS
constraint define 6 [AltNum]cParkWage_Sch = [AltNum]cPkw_Sch


*************************
nlogitgen PkwV = AltNum(kein: 0|1|2|3|4, geteilt: 5|6|7|8|9, eigen:10|11|12|13|14)
*************************
nlogittree AltNum PkwV if _sample, choice(chosen)

nlogit chosen P_*Pkw M_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw  /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ_* tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample||PkwV : , || AltNum:  ,noconst case(PersId) constraint(1/6)
local fn D:\temp\testNL
// estimates use `fn'
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace
estimates save `fn', replace



*************************
dropvars PkwV PkwP FR_O_MP
capture label drop lb_PkwV 
capture label drop lb_PkwP
capture label drop lb_FR_O_MP
nlogitgen PkwV = AltNum(kein: 0|1|2|3|4|5|6|7|8|9, geteilt: 10|11|12|13|14|15|16|17|18|19, eigen:20|21|22|23|24|25|26|27|28|29)
nlogitgen PkwP = AltNum(keinF: 0|5, keinR: 1|6, keinOEK: 2, keinOZK: 7, keinM: 3|8, keinP: 4|9, /*
*/ geteiltF: 10|15, geteiltR: 11|16, geteiltOEK: 12, geteiltOZK: 17, geteiltM: 13|18, geteiltP: 14|19, /*
*/ eigenF: 20|25, eigenR: 21|26, eigenOEK: 22, eigenOZK: 27, eigenM: 23|28, eigenP: 24|29)

nlogitgen FR_O_MP = AltNum(FR_kP: 0|5|1|6, OEK_kP: 2, OZK_kP: 7, MP_kP: 3|8|4|9, /*
*/ FR_gP: 10|15|11|16, OEK_gP: 12, OZK_gP: 17, MP_gP: 13|18|14|19, /*
*/ FR_eP: 20|25|21|26, OEK_eP: 22, OZK_eP: 27, MP_eP: 23|28|24|29)

capture drop F_R_OMP
capture label drop lb_F_R_OMP
nlogitgen F_R_OMP = AltNum(F_kP: 0|5, R_kP: 1|6, OMP_kP: 2|7|3|8|4|9, /*
*/ F_gP: 10|15, R_gP: 11|16, OMP_gP: 12|17|13|18|14|19, /*
*/ F_eP: 20|25, R_eP: 21|26, OMP_eP: 22|27|23|28|24|29)


*************************
nlogittree AltNum PkwP PkwV if _sample, choice(chosen)
nlogittree AltNum PkwP FR_O_MP PkwV if _sample, choice(chosen)
nlogittree AltNum PkwP F_R_OMP PkwV if _sample, choice(chosen)

constraint 10 [keinF_tau]_cons = [geteiltF_tau]_cons
constraint 11 [keinF_tau]_cons = [eigenF_tau]_cons
constraint 12 [keinR_tau]_cons = [geteiltR_tau]_cons
constraint 13 [keinR_tau]_cons = [eigenR_tau]_cons
// constraint 14 [keinO_tau]_cons = [geteiltO_tau]_cons
// constraint 15 [keinO_tau]_cons = [eigenO_tau]_cons
constraint 16 [keinM_tau]_cons = [geteiltM_tau]_cons
constraint 17 [keinM_tau]_cons = [eigenM_tau]_cons
constraint 18 [keinP_tau]_cons = [geteiltP_tau]_cons
constraint 19 [keinP_tau]_cons = [eigenP_tau]_cons
constraint 20 [keinM_tau]_cons = [keinP_tau]_cons
constraint 21 [keinF_tau]_cons = [keinR_tau]_cons
constraint 22 [kein_tau]_cons = 1
constraint 23 [geteilt_tau]_cons = 1
constraint 24 [eigen_tau]_cons = 1
constraint 25 [keinOEK_tau]_cons = 1
constraint 26 [keinOZK_tau]_cons = 1
constraint 27 [geteiltOEK_tau]_cons = 1
constraint 28 [geteiltOZK_tau]_cons = 1
constraint 29 [eigenOEK_tau]_cons = 1
constraint 30 [eigenOZK_tau]_cons = 1

constraint 31 [OEK_kP_tau]_cons = 1
constraint 32 [OZK_kP_tau]_cons = 1
constraint 33 [OEK_gP_tau]_cons = 1
constraint 34 [OZK_gP_tau]_cons = 1
constraint 35 [OEK_eP_tau]_cons = 1
constraint 36 [OZK_eP_tau]_cons = 1
constraint 37 [FR_kP_tau]_cons = [FR_gP_tau]_cons
constraint 38 [FR_kP_tau]_cons = [FR_eP_tau]_cons
constraint 39 [MP_kP_tau]_cons = [MP_gP_tau]_cons
constraint 40 [MP_kP_tau]_cons = [MP_eP_tau]_cons

constraint 41 [F_kP_tau]_cons = 1
constraint 42 [R_kP_tau]_cons = 1
constraint 43 [F_gP_tau]_cons = 1
constraint 44 [R_gP_tau]_cons = 1
constraint 45 [F_eP_tau]_cons = 1
constraint 46 [R_eP_tau]_cons = 1
constraint 47 [OMP_kP_tau]_cons = [OMP_gP_tau]_cons
constraint 48 [OMP_kP_tau]_cons = [OMP_eP_tau]_cons

nlogit chosen P_*Pkw M_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw ZK*Pkw ZK_OV  /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ_* tOV_UH tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample||PkwV : , base(eigen) ||PkwP: ,base(eigenP) || AltNum:  ,noconst case(PersId) constr(1/30)
local fn D:\temp\testNL3
//capture estimates use `fn'
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace
estimates save `fn', replace

nlogit chosen P_*Pkw M_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw ZK*Pkw ZK_OV  /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ_* tOV_UH tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample||PkwV : , base(eigen) ||FR_O_MP:,base(FR_kP) ||PkwP: ,base(eigenP) || AltNum:  ,noconst case(PersId) constr(1/40)
local fn D:\temp\testNL4
//capture estimates use `fn'
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace
estimates save `fn', replace

nlogit chosen P_*Pkw M_*Pkw Eink*Pkw H*Pkw Kind*Pkw Dichte*Pkw ZK*Pkw ZK_OV  /* 
*/ F R Bus Bahn M  /*
*/ tFuss tRad tPkw tMF tOV_FZ  tOV_SWZ_* tOV_UH tOV_Gehzeit tOV_WZ cOV_* /*
*/ cPkw_* cPkwM_* cParkWage_*  if _sample||PkwV : , base(eigen) ||F_R_OMP:,base(F_kP) ||PkwP: ,base(eigenP) || AltNum:  ,noconst case(PersId) constr(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 41 42 43 44 45 46 47 48)
local fn D:\temp\testNL5
//capture estimates use `fn'
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace
estimates save `fn', replace

************************************




