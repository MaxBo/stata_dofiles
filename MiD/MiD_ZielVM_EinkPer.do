clear
odbc load, dsn("h_localhost64") table("h.sampled_results") clear lowercase noquote
destring chosen, replace
rename wid WegId
merge m:1 WegId  using "D:\DatenMaxDiss\MiD-H\txt\P_Einkauf.dta"
keep  WegId vznr zp chosen ehid t_kfz t_rad t_fuss ov_fz ov_swz ov_wz ov_gz ov_uh ov_uwz ov_zz ov_az ov_cost iv_cost iv_park /*
*/ PersId caseid pid weg wZweckModell TourId mode5 Tourmode5  pGrup9 wage0 lnwage DichteSt DichteZi wZuzeit /*
*/ hPkwVerf pFhsPkw zeitkarte

gen lnzp = ln(zp)
constraint define 1 lnzp=1
// clogit chosen lnzp t_kfz, group(WegId)  constraint(1)

expand 5

bysort WegId ehid: gen m = _n
label values m mode5
gen F = m==1
gen R = m==2
gen O = m==3
gen M = m==4
gen P = m==5
// suches gewähltes Verkehrsmittel und Ziel
rename chosen chosenZiel
gen chosen = (m==mode5)*chosenZiel
// markiere nicht mögliche Alternativen
gen _sample = 1
//replace _sample = 0 if P & pAlter<18
// replace _sample = 0 if P & hPkwVerf==0
replace _sample = 0 if F & t_fuss >=.
replace _sample = 0 if R & t_rad >=.

gen P_keinPkw = P & (hPkwVerf==0)
gen P_getPkw = P & (hPkwVerf==1)
// gen P_eigPkw = P & eigPkw
gen M_keinPkw = M & (hPkwVerf==0)
gen M_getPkw = M & (hPkwVerf==1)
// gen M_eigPkw = M & eigPkw

// Zeitkartenverfügbarkeit
gen ZK_OV = (zeitkarte==1) & O

// bilde Kosten-Variablen
gen cOV = ZK_OV* ov_cost/ lnwage
gen cPkw = P* iv_cost/ lnwage
gen cPkwM = cPkw/ 2

// setze Mindest-Fahr- und Gehzeiten im ÖV
replace ov_fz = 3 if ov_fz < 3
replace ov_gz = 5 if ov_gz < 5


noi di "bilde Reisezeit-Variablen"
// bilde Reisezeit-Variablen
// Fehler bei der Wartezeitberechnung bereinigen
gen tFuss = 0
replace tFuss = t_fuss if F
gen tRad = 0
replace tRad = t_rad if R
gen tPkw = 0
replace tPkw = t_kfz if (P)
gen tMF = 0
replace tMF = t_kfz if (M)
gen tPark = 0
replace tPark = iv_park if (P|M)

gen tOV_FZ = 0
replace tOV_FZ = ov_fz if O
gen tOV_SWZ = 0
replace tOV_SWZ = ov_swz if O
gen tOV_WZ = 0
replace tOV_WZ = ov_wz if O
gen tOV_UH = 0
replace tOV_UH = ov_uh if O
gen tOV_Gehzeit = 0
replace tOV_Gehzeit = ov_gz if O

local fn "D:\\temp\\test2"
estimates use `fn'
predict U, xb
gen eU = exp(U)
bysort WegId ehid: egen sum_eU = total(eU), missing
gen logsum = log(sum_eU)
* clogit chosenZiel lnzp logsum if F, group(WegId) constraint(1)
clogit chosenZiel lnzp i.hPkwVerf#c.logsum if F, group(WegId) constraint(1)
* clogit chosenZiel lnzp i.hPkwVerf#c.logsum##c.logsum if F, group(WegId) constraint(1)

local fn "D:\\temp\\eh_per_Zielwahl"
estimates save `fn', replace
outreg using `fn'.txt, bdec(5) tdec(5) noparen noaster replace


clogit chosenZiel lnzp i.hPkwVerf#i.zeitkarte#c.logsum if F, group(WegId) constraint(1)

clogit chosenZiel lnzp i.hPkwVerf#c.logsum  if F, group(WegId) constraint(1)

/// ggf. mit anderer Spezifikation kubisches LogSum(...) besser angepasst
/// OV im Binnenverkehr der Verkehrszellen keine Fahrzeit ausgewiesen --- Done!
/// hier sollten Dummy-Werte ergänzt werden, um die Modellschätzung zu erleichtern
/// außerdem die Fusswege und die ParkZeitZiel korrigieren.

// ToDo: mit den U = lnzp + 1.5 * Logsum den LogSum des Zielwahlmodells berechnen.
// Karte für Personen mit und ohne Pkw-Verfügbarkeit darstellen
// das ganze auch noch mal für aperiodischen Bedarf und für Besuch von Freunden und Bekannten

gen long WegZiel = 0
replace WegZiel = WegId* 10000 + ehid

clogit chosen lnzp F R O ZK_OV M M_keinPkw M_getPkw P_keinPkw P_getPkw /*
*/ tFuss tRad tPkw tMF tPark tOV_FZ tOV_SWZ tOV_WZ tOV_UH tOV_Gehzeit iv_cost ov_cost /*
*/ if _sample, group(WegId) constraint(1)


constraint define 11 iv_cost = 20*tPkw
constraint define 12 ov_cost = 20*tOV_FZ
constraint define 13 tOV_UH = 10*tOV_FZ
constraint define 14 tOV_WZ = tOV_SWZ
constraint define 15 tOV_Gehzeit = tFuss
constraint define 16 iv_cost = ov_cost


clogit chosen lnzp F R O ZK_OV M M_keinPkw M_getPkw P_keinPkw P_getPkw /*
*/ tFuss tRad tPkw tMF tPark tOV_FZ tOV_SWZ tOV_WZ tOV_UH tOV_Gehzeit iv_cost ov_cost /*
*/ if _sample, group(WegId) constraint(1  12  14 15 16)
