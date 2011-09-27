version 10
capture log close
clear
set memory 800m
set more off
log using "$PW_workingdir\soep\proj\Mobilitaet\pkwcommute_140509.log",replace


****************************************************************************************************
****************   Merge Daten zum Pkw-Besitz, Mobilitätsverhalten und Wohnort            **********
****************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mobilitaet-custom.dta",clear
keep if year==1998|year==2003
sort persnr year
merge persnr year using "$PW_workingdir\soep\proj\FS\FS-stfilled.dta",uniqusing nokeep
recode pkwfs (21 31 41=1) (12 32 42=2) (13 23 43=3) (14 24 34=4)
drop if _merge==1
drop _merge
sort hhnrakt year
merge hhnrakt year using "$PW_workingdir\soep\proj\Wohnen\Wohnen-custom_erg.dta", uniqusing nokeep keep(hhwhgnr whgnr entfgrstadt wohn* inf_* pollu* nogreen crime)
drop if _merge==1
drop _merge

recode modework (1=1) (2 3 4=2) (5 6=3),gen(mode3work)
label define mode3work 1 "O" 2 "P" 3 "N"
label values mode3work mode3work
label var mode3work "VM Arbeitsweg"

drop if mode3work>=.
bysort persnr (year): drop if _N<2
bysort persnr (year): gen mode98 = mode3work[_n-1] if _n==_N
bysort persnr (year): gen pf98 = pkwfs[_n-1] if _n==_N
label values mode98 mode3work
label var mode98 "VM 1998"

save "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",replace


***************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 3 *****************************
***************************************************************************************************


use "$PW_workingdir\soep\proj\Mobilitaet\Mob03.dta",clear
rename minbycar tmiv
rename minbypubtr tov
rename kmcommute km
rename pequivinc inc
gen incln = ln(inc)
replace km = 0.25 if km==0 // um ln(0)-Probleme zu vermeiden
gen kmln = ln(km)
gen km2 = km^2

recode modework (1=1) (2=4) (3 4=3) (5 6=2),gen(mode4)
label define mode4 0 "NoWorktrip"  1 "OV" 2 "NMIV" 3 "andMIV" 4 "eigPKW"
label values mode4 mode4
recode modework (1=1) (2=5) (3 4=4) (5=2) (6=3),gen(mode5)
label define mode5 0 "NoWorktrip"  1 "OV" 2 "Rad" 3 "Fuss" 4 "andMIV" 5 "eigPKW"
label values mode5 mode5 
label var mode4 "VM Arbeitsweg"
*** imputiere fehlenden Wert füt tmiv
replace tmiv=mincommute if tmiv>=. & mincommute<. & (mode4==1|modework==4)
replace tmiv=6 + 0.7*km + 3*kmln if km<. & tmiv>=.
*** Geschwindigkeit Radverkehr: 12 km/h, also 5 min/km
gen trad = km*5
*** Geschwindigkeit Fuss: 4 km/h, also 15 min/km
gen tfuss = km*15
gen workathome = commutefreq==1
soep_genvar_occ_spatial

gsort hhnrakt year  -pfhs -km -age
by hhnrakt year: gen pid = _n
*** Wenn kein Führerschein: codiere zu: Nutzung eines nicht eigenen-Autos
recode mode4 (4=3) if pfhs==0
recode mode5 (5=4) if pfhs==0
*** wenn keine Infos zu Haushalts-Pkw: Haushalt als Missing
gen _hhmissing= (hpkw04>=.)

*** wenn kein Auto im HH: codiere zu: Nutzung eines nicht eigenen-Autos
recode mode4 (4=3) if pid==1 & hpkw04==0
recode mode5 (5=4) if pid==1 & hpkw04==0

*** berechne "freie" Pkw für Personen 2-4
gen pkwfrei = 0
replace pkwfrei = hpkw04 if pid==1
forvalues p = 2/4 {
	by hhnrakt year: replace pkwfrei = pkwfrei[_n-1]-(mode4[_n-1]==4) if pid==`p'
	recode mode4 (4=3) if pid==`p'&pkwfrei==0
	recode mode5 (5=4) if pid==`p'&pkwfrei==0
}
label var pkwfrei "Haushalts-Pkw noch 'frei' "

*** Zähle Führerscheine im Haushalt
by hhnrakt year: egen hfhs = total(pfhs==1)

*** generiere eindeutige ID *****
gen long persnryear = persnr*100+(year-1980)

save "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace

************************************************************************
capture program drop predictLogSum
program define predictLogSum

*** Für alle Personen, für die genug Infos vorliegen (_hhmissing==0) ***
*** berechne den Log des Gesamtnutzen aller zur Verfügung stehenden Alternativen ***
*** Einmal, wenn kein eigener Pkw zur Verfügung steht: ***
dropvars LogSum0 LogSum1
replace _sample=0 if P & _hhmissing==0
dropvars _U _eU _Sum
predict _U if _sample,xb 
gen _eU = exp(_U)
bysort hhnrakt year pid: egen _Sum=total(_eU) if _sample
gen LogSum0 = ln(_Sum)
*** Einmal, wenn ein eigener Pkw zur Verfügung steht: ***
replace _sample=1 if P & _hhmissing==0 & pfhs==1
dropvars _U _eU _Sum
predict _U if _sample,xb 
gen _eU = exp(_U)
bysort hhnrakt year pid: egen _Sum=total(_eU) if _sample
gen LogSum1 = ln(_Sum)
*** relevant ist nachher nur die Differenz, nicht die absoluten Werte: ***
dropvars LogSumDiff LogSum*HH* LogSum*Fhs*
gen LogSumDiff = LogSum1 - LogSum0
*** nur eine Zeile pro Haushalt ***
gsort hhnrakt year pid _altnum LogSum1 LogSum0
by hhnrakt year pid: keep if _n==1
*** Summe der Nutzen der Erwerbstätigen 2-4, 3-4 bzw. 4 mit/ohne eigenem Pkw
by hhnrakt year: egen LogSum24HH0 = total(LogSum0)
by hhnrakt year: egen LogSum24HH1 = total(LogSum1)
by hhnrakt year: egen LogSum34HH0 = total(LogSum0 * (pid>=3))  
by hhnrakt year: egen LogSum34HH1 = total(LogSum1 * (pid>=3)) 
by hhnrakt year: egen LogSum4HH0 = total(LogSum0 * (pid>=4)) 
by hhnrakt year: egen LogSum4HH1 = total(LogSum1 * (pid>=4))
// Anzahl der sonstigen Führerscheininhaber
by hhnrakt year: egen LogSum24Fhs = total(pfhs==1)
by hhnrakt year: egen LogSum34Fhs = total((pfhs==1)* (pid>=3))
by hhnrakt year: egen LogSum4Fhs = total((pfhs==1)* (pid>=4))
// Anzahl der sonstigen Personen mit Führerschein, die Arbeitsweg haben, deren LogSum aber nicht berechnet werden konnte
by hhnrakt year: egen LogSum24kA = total((LogSum0==.)&(modework<.)&(pfhs==1))
by hhnrakt year: egen LogSum34kA = total(((LogSum0==.)&(modework<.)&(pfhs==1))* (pid>=3))
by hhnrakt year: egen LogSum4kA = total(((LogSum0==.)&(modework<.)&(pfhs==1))* (pid>=4))
end
************************************************************************


************************************************************************
capture program drop expandMode
program define expandMode

expand 5
gen _altnum=0
bysort hhnrakt year pid: gen m = _n
replace _altnum=m
gen choice = (m==mode5)
genModeInteractions

end
************************************************************************


************************************************************************
capture program drop expandModeZK
program define expandModeZK

recode povzeitk (1/2=1),gen(zk)
expand 10
gen _altnum=0
bysort hhnrakt year pid: gen z = int((_n-1)/5)
bysort hhnrakt year pid: gen m = mod((_n-1),5)+1
replace _altnum=z*10+m
gen choice = (m==mode5) & (z==zk)
genModeInteractions
gen Z = (z==1)
sort hhnrakt year pid _altnum

end
************************************************************************


************************************************************************
capture program drop genModeInteractions
program define genModeInteractions

gen X = m==0
gen O = m==1
gen R = m==2
gen F = m==3
gen N = F|R
gen M = m==4
gen P = m==5

gen MPtmiv = (M|P)*tmiv
gen Otov = O*tov
recode Otov (.=0)
gen Rtrad = R*trad
gen Ftfuss = F*tfuss
gen Nkm=N*km
gen Nkmln=N*kmln
gen Nkm2=N*km2
recode Nkm (.=0)
recode Nkmln(.=0)
gen Pfrei = pkwfrei*P



// berechne Kosten einer Fahrt mit Monatskarte (ca. 20 €/Monat = 0.50 €/Fahrt Mindestkosten, 
// Annahme, dass Preis der Zeitkarte mit Entfernung degressiv zunimmt (50€ für 10 km, 75€ für 20 km, 100 € für 40 km 
gen cozk = 2.5*ln(km/17+1.2)
label var cozk "Fahrtkosten Zeitkarte"
// berechne Kosten einer Fahrt mit Einzelkarte
gen coek = 7*ln(km/17+1.1)
label var cozk "Fahrtkosten Einzelkarte"
// berechne Kosten einer Fahrt mit Pkw (1 € Parkgebühr und 20 ct variable Kosten je km)
gen benzin = .79 if year==1998
replace benzin = 1.07 if year==2003
gen copkw = 1+km*(benzin/10)
label var copkw "Fahrtkosten Pkw"

gen o_Vollzeit = taet==1
gen o_Teilzeit = taet==2
gen o_Azubi = taet==3
gen o_Student = taet==4

dropvars o?_*
gen oO_Vollzeit = O*taet==1
gen oO_Teilzeit = O*taet==2
gen oO_Azubi = O*taet==3
gen oO_Student = O*taet==4
//gen oO_nErwtaet = O*taet>4
gen oF_Vollzeit = F*taet==1
gen oF_Teilzeit = F*taet==2
gen oF_Azubi = F*taet==3
gen oF_Student = F*taet==4
//gen oF_nErwtaet = F*taet>4
gen oR_Vollzeit = R*taet==1
gen oR_Teilzeit = R*taet==2
gen oR_Azubi = R*taet==3
gen oR_Student = R*taet==4
//gen oR_nErwtaet = R*taet>4
gen oM_Vollzeit = M*taet==1
gen oM_Teilzeit = M*taet==2
gen oM_Azubi = M*taet==3
gen oM_Student = M*taet==4
//gen oM_nErwtaet = M*taet>4

gen femO = O*female
gen femR = R*female
gen femF = F*female
gen femM = M*female

gen _sample = 1
*** wenn kein Führerschein, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & pfhs==0
*** wenn kein HH-Auto frei, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & Pfrei==0
*** wenn ÖPNV nicht möglich ***
replace _sample = 0 if O & tov==.d
*** wenn Entfernung über 4 km, dann Fuss nicht möglich ***
replace _sample = 0 if F & (km>4&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 20 Minuten, dann Fuss nicht möglich ***
replace _sample = 0 if F & (km>=. & (tmiv>=20&tmiv<.))
*** wenn Entfernung über 25 km, dann Rad nicht möglich ***
replace _sample = 0 if R & (km>25&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 35 Minuten, dann Rad nicht möglich ***
replace _sample = 0 if R & (km>=. & (tmiv>=35&tmiv<.))

*** markiere Personen, die wegen Missing Values gar nicht betrachtet werden sollen (_hhmissing=1) ***
bysort persnryear: egen _tovmiss = total (O & tov>=.&_sample==1)
bysort persnryear: egen _tmivmiss = total ((M|P) & tmiv>=.&_sample==1)
bysort persnryear: egen _kmmiss = total (N & km>=.&_sample==1)
bysort persnryear: egen _worksathome = total(commutefreq==1)
replace _hhmissing= 1 if _tovmiss|_tmivmiss|_kmmiss|_worksathome
replace _sample = 0 if _hhmissing

end 
************************************************************************

***************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Personen 2-4 *************************
***************************************************************************************************
use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",clear
keep if pid>=2&pid<=4
expandModeZK



gen restinc =  hinc_2007-400-230*adults-200*eqnkids
*** weiter werden noch Fixkosten der Pkw abgezogen
replace restinc = restinc - 200*(hpkw04)
gen cozk1=cozk*2*19*Z/(restinc+1700) 
replace cozk1 = 0 if taet==4 |taet==6
gen copkw1=copkw*2*19*(P|M)/(restinc+1700) 
gen coek1 = coek*2*19*(O&!Z)/(restinc+1700) 
gen costvari = copkw1+coek1+cozk1

constraint 2 costvari =-10


gen ZO = Z*O
gen ZR = Z*R
gen ZM = Z*M
gen ZP = Z*P
gen femZ = Z*female
gen oZ_Vollzeit = Z*taet==1
gen oZ_Teilzeit = Z*taet==2
gen oZ_Azubi = Z*taet==3
gen oZ_Student = Z*taet==4

clogit choice Z O R F M Z? o?_* fem? MPtmiv Otov  Rtrad Ftfuss  costvari if _sample,group(persnryear)  constraints(2)
predictLogSum
recode LogSum? (.=.x) if modework ==.
recode LogSum? (.=.z) if pfhs==1
recode LogSum? (.=.y) if pfhs==0
label define logsum .x "kein Pendelweg" .y "kein Fhs, Pendelweg k.A" .z "Fhs, Pendelweg k.A"
label values LogSum? logsum
*** Speichere die LogSums für den Haushalt zwischen ***
keep hhnrakt year pid LogSum*
save "$PW_workingdir\soep\proj\Mobilitaet\LogSum.dta",replace

constraint 5 [_altnum]costvari =-10/[Z_tau]_cons
constraint 3 [kZ_tau]_cons = [Z_tau]_cons 
nlogitgen mz = _altnum(kZ: 1|2|3|4|5, Z: 11|12|13|14|15)
nlogit choice MPtmiv Otov  Rtrad Ftfuss  costvari O R F M Z oZ_* femZ* if _sample & year==2003 || mz: , base(kZ) || _altnum: ,noconst case(persnr) from(a,skip) constraints(3)
nlogitgen zm = _altnum(O: 1|11, R: 2|12, F: 3|13, M: 4|14, P: 5|15)
constraint 11 [O_tau]_cons = [P_tau]_cons 
constraint 12 [R_tau]_cons = [P_tau]_cons 
constraint 13 [F_tau]_cons = [P_tau]_cons 
constraint 14 [M_tau]_cons = [P_tau]_cons 

nlogit choice MPtmiv Otov  Rtrad Ftfuss  costvari O R F M Z oZ_* femZ* if _sample & year==2003 || zm: , base(P) || _altnum: ,noconst case(persnr) from(a,skip) // constraints(12/14)
// ÖV-Nutzung: tau ist nicht signifikant verschieden von 1 (ziemlich genau 1)
// R, M: Tau ca. .37, P, F: Tau ca. .26



***************************************************************************************************
***************** Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 2 *****************************
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",clear
keep if pid>=2&pid<=4
sort hhnrakt year pid
merge hhnrakt year pid using "$PW_workingdir\soep\proj\Mobilitaet\LogSum.dta", uniqusing
drop _merge*

ModalSplitWorker23

*** wenn Person p für die übrigen Personen kein Auto übrig lässt, (eh kein Auto oder 1 Auto, das Person p nimmt):
dropvars PLogSum PsonstFhs PsonstkA
gen PLogSum = 0
gen PsonstFhs=0
gen PsonstkA=0
replace PLogSum = LogSum34HH0 if LogSum34HH0<. & ((pkwfrei>=2&pkwfrei<.) | (pkwfrei==1&(X|O|M|N))) & pid==2
replace PLogSum = LogSum4HH0 if LogSum4HH0<. & ((pkwfrei>=2&pkwfrei<.) | (pkwfrei==1&(X|O|M|N))) & pid==3

*** wenn Person p für Person p+1 mindestens ein Auto übrig lässt, (mind. 2 Autos oder 1 Auto, das Person p nicht nimmt):
replace PLogSum = LogSum34HH1 if LogSum34HH1<. & (pkwfrei==0 | (pkwfrei==1&P)) & pid==2
replace PLogSum = LogSum4HH1 if LogSum4HH1<. & (pkwfrei==0 | (pkwfrei==1&P)) & pid==3
replace PsonstFhs= LogSum34Fhs if LogSum34Fhs <.  &  (pkwfrei==0 | (pkwfrei==1&P)) & pid==2
replace PsonstFhs= LogSum4Fhs if LogSum4Fhs <.  &  (pkwfrei==0 | (pkwfrei==1&P)) & pid==3
replace PsonstkA= LogSum34kA if LogSum34kA <.  &  (pkwfrei==0 | (pkwfrei==1&P)) & pid==2
replace PsonstkA= LogSum4kA if LogSum4kA <.  & (pkwfrei==0 | (pkwfrei==1&P)) & pid==3




clogit choice O F R M o?_* MPtmiv Otov Rtrad Ftfuss PsonstFhs PLogSum PsonstkA if _sample,group(persnryear) // constraints(1/2)



predictLogSum
recode LogSum? (.=.x) if modework ==.
recode LogSum? (.=.z) if pfhs==1
recode LogSum? (.=.y) if pfhs==0
label drop logsum
label define logsum .x "kein Pendelweg" .y "kein Fhs, Pendelweg k.A" .z "Fhs, Pendelweg k.A"
label values LogSum* logsum
*** Speichere die LogSums für den Haushalt zwischen ***
keep hhnrakt year pid LogSum*
save "$PW_workingdir\soep\proj\Mobilitaet\LogSum.dta",replace


***************************************************************************************************
***************** HH-Pkw-Besitz und Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 1 ***********
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",replace
sort hhnrakt year pid
merge hhnrakt year using "$PW_workingdir\soep\proj\Mobilitaet\LogSum2.dta", uniqusing
drop _merge*
rename LogSum0 LogSumP20
rename LogSum1 LogSumP21
sort hhnrakt year pid
merge hhnrakt year using "$PW_workingdir\soep\proj\Mobilitaet\LogSum3.dta", uniqusing
drop _merge*
rename LogSum0 LogSumP30
rename LogSum1 LogSumP31
bysort hhnrakt year: gen P2fhs = pfhs[2] if _n==1
bysort hhnrakt year: gen P3fhs = pfhs[3] if _n==1
recode P2fhs P3fhs (.=0)
keep if pid==1
recode hpkw04 (3/4=3) ,gen(hpkw03) 

*** Haushalte mit FHS-Kombi, die (praktisch) nicht vorkommen, umcodieren ***
recode hpkw03 (2 3=1) if hfhs==0
recode hpkw03 (3=2) if hfhs==1




*** Einkommen in Anlehnung an Ben-Akiva 1976
*** hier geschätzt: + 400 € fixer Haushalts-Grundbedarf + 230 € je Erwachsenen + 200 € je Kind***
*** (entspricht in etwa dem Mindesrückbehalt bei der Wohnungsbauförderung in NRW) ***
*** theoretisch liessen sich nach diesem Prinzip auch Wohn- und Mobilitätskosten in das Rest-Einkommen integrieren ***
gen restinc =  hinc_2007-400-230*adults-200*eqnkids




recode mode4 (./.b=0),gen(modeX4)
recode mode5 (./.b=0),gen(modeX5)
label values modeX5 mode5
gen hhpkwmode = hpkw03*10+modeX5

foreach c of numlist 0/3 {
	label define hhpkwmode  `c'0 "C`c'X"  `c'1 "C`c'O"  `c'2 "C`c'R"  `c'3 "C`c'F"  `c'4 "C`c'M" `c'5 "C`c'P",add
}
label values hhpkwmode hhpkwmode 
expand 24
gen _altnum=0
bysort hhnrakt year: gen c = int((_n-1)/6)
bysort hhnrakt year: gen p = mod((_n-1),6)
replace _altnum=c*10+p

gen choice = _altnum==hhpkwmode

gen X = p==0
gen O = p==1
gen R = p==2
gen F = p==3
gen N = F|R
gen M = p==4
gen P = p==5
gen C0 = c==0
gen C1 = c==1
gen C2 = c==2
gen C3 = c==3

gen Pfrei = pkwfrei*P





gen _sample = 1
*** wenn kein Auto, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & C0
*** wenn kein Führerschein, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & pfhs==0
*** wenn kein HH-Auto frei, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & Pfrei==0
*** wenn ÖPNV nicht möglich ***
replace _sample = 0 if O & tov==.d
*** wenn Entfernung über 4 km, dann Fuss nicht möglich ***
replace _sample = 0 if F & (km>4&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 20 Minuten, dann Fuss nicht möglich ***
replace _sample = 0 if F & (km>=. & (tmiv>=20&tmiv<.))
*** wenn Entfernung über 25 km, dann Rad nicht möglich ***
replace _sample = 0 if R & (km>25&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 35 Minuten, dann Rad nicht möglich ***
replace _sample = 0 if R & (km>=. & (tmiv>=35&tmiv<.))

*** Haushalten mit sehr geringem verfügbaren Einkommen stehen die Alternativen 2 bzw. 3 Pkw nicht zur Verfügung ***
replace _sample=0 if C2 & restinc<-100
replace _sample=0 if C3 & restinc<50


*** markiere Personen, die wegen Missing Values gar nicht betrachtet werden sollen (_hhmissing=1) ***
bysort persnryear: egen _tovmiss = total (O & tov>=.&_sample==1)
bysort persnryear: egen _tmivmiss = total ((M|P) & tmiv>=.&_sample==1)
bysort persnryear: egen _kmmiss = total (N & km>=.&_sample==1)
bysort persnryear: egen _worksathome = total(commutefreq==1)
replace _hhmissing= 1 if _tovmiss|_tmivmiss|_kmmiss|_worksathome
replace _sample = 0 if _hhmissing


*** LogSum
gen LS0 = 0
replace LS0=LogSumP20 if LogSumP20 <. 
replace LS0=LS0+LogSumP30 if LogSumP30 <. 
gen LS1 = 0
replace LS1=LogSumP21 if LogSumP21 <. 
replace LS1=LS1+LogSumP31 if LogSumP31 <. 
gen CkA = (LogSumP20==.z)
replace CkA = CkA + (LogSumP30==.z)

*******************

*** ist diese Person erwerbstätig, aber LogSum-Nutzen des Autos für den Erwerbstätigen konnte nicht berechnet werden
*** (Koeffizient müsste vermutlich negativ sein: Erwerbstätige brauchen Wagen eher als nicht-Erwerbstätige)
*** ggf. Nicht-Erwerbstätige über weitere Variablen X einfließen lassen...
*** Verschiede Spezifikationen geben keine Sinnvollen Werte, insb. nicht für C1kA
*** Was noch halbwegs plausible Werte ergab, waren nur C2kA und C3kA zu verwenden
*** Also: Weitere Erwerbstätige mit unbekanntem Arbeitsweg und Führerschein erhöhen den Zweit- und Drittwagen-Besitz
/*
gen C1kA = (LogSumP20==.z) & ((C1&(X|M|N|O))|C2|C3)
replace C1kA = C1kA + ((LogSumP30==.z) & ((C1&(X|M|N|O))|C2|C3))
*/
gen C2kA = (LogSumP20==.z) & ((C2&(X|M|N|O))|C3)
replace C2kA = C2kA + ((LogSumP30==.z) & ((C2&(X|M|N|O))|C3))
gen C3kA = (LogSumP20==.z) & C3&(X|M|N|O)
replace C3kA = C3kA + ((LogSumP30==.z) & C3&(X|M|N|O))


*** Logsum-Koeffizient müsste positiv sein: je größer der Nutzenverlust ist, wenn in LogSum0 über kein Auto verfügt wird,
*** desto eher nimmt Person 2 das Auto und folglich bekommt Person 1 es nicht mehr.

replace _sample = 0 if X
replace _sample = 0 if modeX4==0

// berechne Kosten einer Fahrt mit Monatskarte
gen cozk = ln(km)-1
label var cozk "Fahrtkosten Zeitkarte"
gen cozky = cozk*40*12 //40 Fahrten/Monat * 12 Monate
replace cozk = .5 if cozk <.5|km==0
// berechne Kosten einer Fahrt mit Einzelkarte
gen coek = 2.5*ln(km)-3.5
replace coek = 1.5 if coek<1.5 | km==0
label var cozk "Fahrtkosten Einzelkarte"
// berechne Kosten einer Fahrt mit Pkw (1 € Parkgebühr und 20 ct variable Kosten je km)
gen copkw = 1+.1*km
label var copkw "Fahrtkosten Pkw"


replace _sample=0 if (hfhs>=4&hfhs<.)&C0
replace _sample=0 if (hfhs==0)&(C2|C3)
replace _sample=0 if (hfhs==1)&C3

save "$PW_workingdir\soep\proj\Mobilitaet\Long_temp.dta",replace


***************************************************************************************************
***************** HH-Pkw-Besitz und Verkehrsmittelwahl Arbeits-/Ausbildungsweg Person 1 ***********
***************************************************************************************************

use "$PW_workingdir\soep\proj\Mobilitaet\Long_temp.dta",replace


keep hhpkwmode persnryear sex oc_full oc_part oc_appr oc_stud notempl kid1 kid2 hfhs  tmiv tov trad tfuss/*
*/ mixedneighb house_rural house_detached house_terrace house_38 city_5_10 city_10_25 city_25_40 city_40_ /*
*/ doctor10 doctor20 shop10 shop20 noshop pid /*
*/ LogSumP20 LogSumP21 LogSumP30 LogSumP31 P2fhs P3fhs restinc _altnum _sample LS0 LS1 CkA cozk copkw

drop if hhpkwmode >=. | hhpkwmode == 0| hhpkwmode == 10| hhpkwmode == 20| hhpkwmode == 30
reshape wide _sample, i(persnryear) j(_altnum)
foreach alt of numlist 1/4 11/15 21/25 31/35 {
	drop if _sample`alt'==0 & hhpkwmode == `alt'
}
recode * (./.z=99999)
outsheet using "Y:\data\biogeme\biogeme18\windows_cfsqp\Mobilitaet\sample.dat", nolabel replace


*** Konkurrenz um Pkw ***
gen C1Pfhs2 = hfhs==2 & C1 & P
gen C1Pfhs3 = hfhs==3 & C1 & P
gen C1Pfhs4_ = hfhs>=4&hfhs<. & C1 & P
gen C2Pfhs3 = hfhs==3 & C2 & P
gen C2Pfhs4_ = hfhs>=4&hfhs<. & C2 & P
gen C3Pfhs4_ = hfhs>=4&hfhs<. & C3 & P

**Kinder: Nur Einfluss auf Erstwagen, auf Zweitwagen keinen Einfluss
gen C0kid = C0*(kid1|kid2)
** Ein oder mehr Kinder: Koeffizienten sind nicht signifikant verschieden **
// gen C0kid1 = C0*(kid1)
// gen C0kid2 = C0*(kid2)
gen C23kid = (C2|C3)*(kid1|kid2)


*** Entfernung zur City: Für HH mit Erwerbstätigen nur Effekt bis 10 km messbar - darüber hinaus vermutlich schon über Arbeitsweg berücksichtigt***
*** Eigenständiger Erst-, Zweit- und Drittwagen-Effekt sind messbar
*** testen unter Berücksichtigung von Nicht-Erwerbstätigen ***
gen C0city5_10 = C0*city_5_10
gen C0city10_25 = C0*city_10_25
gen C0city25_ = C0*(city_25_40|city_40_)
gen C2city5_10 = C2*city_5_10
gen C2city10_25 = C2*city_10_25
gen C2city25_ = C2*(city_25_40|city_40_)
gen C3city5_10 = C3*city_5_10
gen C3city10_25 = C3*city_10_25
gen C3city25_ = C3*(city_25_40|city_40_)

*** Erreichbarkeit Einzelhandel: Eigenständiger Erst-, Zweit- und Drittwagen-Effekt sind messbar
gen C0shop10 = C0*shop10
gen C0shop20 = C0*shop20
gen C2shop10 = C2*shop10
gen C2shop20 = C2*shop20
gen C3shop10 = C3*shop10
gen C3shop20 = C3*shop20

*** ÖV-Qualität scheint für Personen mit Arbeitsweg schon über die VM-Wahl abgebildet zu sein. keinen eigenständigen Einfluss dieses Parameters ***
*** testen unter Berücksichtigung von Nicht-Erwerbstätigen ***
gen C0notransit_10 = C0*notransit
gen C23notransit_10 = (C2|C3)*notransit

*** Mixedneighbourhood: Signifikant, Unterschied Zweit- und Drittwagen nicht zu sehen ***
*** testen unter Berücksichtigung von Nicht-Erwerbstätigen ***
gen C0mixedneighb = C0*mixedneighb
gen C2mixedneighb = C2*mixedneighb
gen C3mixedneighb = C3*mixedneighb

*** Haustyp ***
gen C0hsrural = C0*house_rural
gen C2hsrural = C2*house_rural
gen C3hsrural = C3*house_rural
gen C0hsdetatched = C0*house_detached
gen C2hsdetatched = C2*house_detached
gen C3hsdetatched = C3*house_detached
gen C0hsterraced = C0*house_terrace
gen C2hsterraced = C2*house_terrace
gen C3hsterraced = C3*house_terrace
gen C0hsmulti38 = C0*house_38
gen C2hsmulti38 = C2*house_38
gen C3hsmulti38 = C3*house_38

*** Haustyp einfacher***
gen C0efh = C0*(house_rural|house_detached|house_terrace)
gen C2efh = C2*(house_rural|house_detached|house_terrace)
gen C3efh = C3*(house_rural|house_detached|house_terrace)

/*
keep choice r*inc* C*kid C*city* C*shop?0 C*notransit_10 C?mixedneighb C?efh  /*
*/ MPtmiv Otov Nkm C0 C2 C3 C0O C0R C0M C1O C1R C1P C13M C23O C23R C23P C?hfhs* C?Pfhs* LogSumC* _sample persnryear
keep if _sample
*/
clogit choice hfhs*C* O R N P /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700 /*
*/ if _sample,group(persnryear) constraints(1) 

clogit choice hfhs*C* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ o?_* C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs*/*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700 /*
*/ if _sample,group(persnryear) constraints(1) coll
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_CL",replace
estimates store MC_CL


**** Das folgede Modell liefert zwar den bedeutend höheren LL-Wert, die tau-Parameter sind aber mit 20-25 deutlich größer als 1 ***
*** Daher ist das NL-Modell zurückzuweisen ***
/*
nlogitgen C = _altnum(C0: 1|2|3|4|5, C1: 11|12|13|14|15, C2: 21|22|23|24|25, C3: 31|32|33|34|35)
nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700 /*
*/  if _sample || C: , base(C1) || _altnum: ,noconst case(persnryear)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\CM_NL",replace
estimates store CM_NL
*/

*** Dieses Modell ergibt tau-Parameter von ca. .25 für alle Verkehrsmittel ***
*** Die Effekte für Beispielpersonen/haushalte sind deutlich realistischer als beim CL-Modell ***
nlogitgen Mode = _altnum(O: 1|11|21|31, R: 2|12|22|32, F: 3|13|23|33, M: 4|14|24|34, P: 5|15|25|35)
nlogit choice C1-C3 C?hfhs* C0O C0R C0M C1O C1R C1M C1P C23O C23R C23M C23P C?Pfhs* LogSumC* CkAC? /*
*/ C*kid C*city* C*shop* C*notransit_10 C?mixedneighb C?hs* /*
*/ MPtmiv Otov Ftfuss  Rtrad  rincln1700 /*
*/  if _sample || Mode : , base(F) || _altnum: ,noconst case(persnryear)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\MC_NL",replace
estimates store MC_NL

constraint 11 [O_tau]_cons = [P_tau]_cons 
constraint 12 [R_tau]_cons = [P_tau]_cons 
constraint 13 [F_tau]_cons = [P_tau]_cons 
constraint 14 [M_tau]_cons = [P_tau]_cons 

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




nlogit choice MPtmiv Otov  Rtrad Ftfuss  costvari O R F M Z oZ_* femZ* if _sample & year==2003 || zm: , base(P) || _altnum: ,noconst case(persnr) from(a,skip) // constraints(12/14)
// ÖV-Nutzung: tau ist nicht signifikant verschieden von 1 (ziemlich genau 1)
// R, M: Tau ca. .37, P, F: Tau ca. .26
















gen zeitk = povzeitk==1|povzeitk==2
gen mzk = zeitk *10+mode3work
label define mzk 1 "On" 2 "Pn" 3 "Nn" 11 "Oj" 12 "Pj" 13 "Nj"
label values mzk mzk 
label var mzk "VM Zeitkarte"

gen mpkw = pkwfs*100+mode3work
label define mpkw 101 "OkF" 102"PkF" 103"NkF" 201"OkP" 202 "PkP" 203 "NkP" 301 "OPz" 302 "PPz" 303 "NPz" 401 "OPi" 402 "PPi" 403 "NPi"
label values mpkw mpkw
label var mpkw "VM Pkw-Verfügbarkeit"



// berechne Kosten einer Fahrt mit Monatskarte
gen cozk = ln(km)-1
label var cozk "Fahrtkosten Zeitkarte"
gen cozky = cozk*40*12 //40 Fahrten/Monat * 12 Monate
replace cozk = .5 if cozk <.5|km==0
// berechne Kosten einer Fahrt mit Einzelkarte
gen coek = 2.5*ln(km)-3.5
replace coek = 1.5 if coek<1.5 | km==0
label var cozk "Fahrtkosten Einzelkarte"
// berechne Kosten einer Fahrt mit Pkw (1 € Parkgebühr und 20 ct variable Kosten je km)
gen copkw = 1+.2*km
label var copkw "Fahrtkosten Pkw"

keep if year==2003
soep_genvar_occ_spatial
//case2alt, choice(mzk) case(persnr) gen(choice) altnum(_altnum) alt(co) casevars(inc incln tov tmiv tnmiv coek cozk copkw)
case2alt, choice(mpkw) case(persnr) gen(choice) altnum(_altnum)
//ÖV nicht möglich
//clogit choice  OjXinc OjXincln OnXinc OnXincln PjXinc PjXincln NjXinc NjXincln NnXinc NnXincln OjXtov OnXtov PjXtmiv PnXtmiv OjXkm OjXkmln OnXkm OnXkmln NjXkm NjXkmln NnXkm NnXkmln,group(persnr)

gen O = (mod(_altnum,100)==1)
gen P = (mod(_altnum,100)==2)
gen N = (mod(_altnum,100)==3)

gen kF = int(_altnum/100)==1
gen kP = int(_altnum/100)==2
gen zP = int(_altnum/100)==3
gen iP = int(_altnum/100)==4

gen O98 = mode98==1
gen P98 = mode98==2
gen N98 = mode98==3

gen kF98 = pf98==1
gen kP98 = pf98==2
gen zP98 = pf98==3
gen iP98 = pf98==4


gen co = 0
replace co = cozk if O
replace co = copkw if P
gen cw = co/(inc/150) // durchschnittlich 150 Arbeitsstunden pro Monat -> Netto-Stundenlohn
gen OXcw = cozk*O/(inc/150)
gen PXcw = copkw*P/(inc/150)

// nehme ÖV aus dem Alternativen-Set, wenn "ÖPNV nicht möglich"
drop if O & pubtrnotposs==1
gen OXtov = tov*O
recode OXtov (.=0) if tov==.d
gen PXtmiv = tmiv*P

// nehme NMIV aus dem Alternativen-Set, wenn Distanz > 20 km oder, 
// wenn keine Angabe zur Entfernung, wenn Fahrzeit MIV >= 35 Minuten 
// (bei 35 Min sind 90% aller Fahrten weiter als 14 km und 75% aller Fahrten weiter als 20 km)
drop if N & (km>20 | km>=.)
gen NXkm = km*N
gen NXkmln = kmln*N
recode NXkm (.=0) if tmiv>=35&tmiv<.
recode NXkmln (.=0) if tmiv>=35&tmiv<.

gen OXkm = km*O
gen OXkmln = kmln*O
gen PXkm = km*P
gen PXkmln = kmln*P
gen PXcopkw = copkw*P
dropvars *Xage* *Xad?
foreach v in O N kF kP zP {
	gen `v'Xage17=(age-17)*`v'
	gen `v'Xage17ln=ln(age-17)*`v'
//	gen `v'Xage65=(age-65)*(age>65)*`v'
//	gen `v'Xage65sq=(((age-65)*(age>65)*`v')^2)
	gen `v'Xagesq=((age-17)^2)*`v'
	gen `v'Xad2 = adult2*`v'
	gen `v'Xad3 = adult3*`v'
}

dropvars ??Xc_* ??Xh_* ??Xshop10 ??Xnoshop ??Xtram2 ??Xmetro2 ??Xrail2 ??X??98
foreach v in kF kP zP {
	foreach c of varlist city* {
		gen `v'X`c'=`c'*`v'
		renpfix `v'Xcity `v'Xc
	}
	foreach h of varlist house* {
		gen `v'X`h'=`h'*`v'
		renpfix `v'Xhouse `v'Xh
	}
//	gen `v'Xshop10 = shop10*`v'
	gen `v'Xnoshop = noshop*`v'
	gen `v'Xtram2 = tramaccess*`v'
	gen `v'Xmetro2 = metroaccess*`v'
	gen `v'Xrail2 = railaccess*`v'
}
foreach v in kF kP zP iP{
	foreach v98 in kF98 kP98 zP98 iP98 {
		gen `v'X`v98'=`v98'*`v'
	}
}

gen OXbus = busaccess*O
gen OXtram1 = (tramaccess==1)*O
gen OXmetro1 = (metroaccess==1)*O
gen OXtram2 = (tramaccess==2)*O
gen OXmetro2 = (metroaccess==2)*O
gen OXrail1 = (railaccess==1)*O
gen OXrail2 = (railaccess==2)*O

gen OXincln = incln*O
gen PXincln = incln*P
gen NXincln = incln*N
//gen kFXincln = incln*kF
gen kPXincln = incln*kP
gen zPXincln = incln*zP
gen iPXincln = incln*iP

local AltCons "kF kP zP iP OkF PkF NkF OkP PkP NkP OPz PPz NPz OPi PPi NPi"
constraint 2 [choice]PPi=0
constraint 3 [choice]PPz =0
constraint 4 [choice]PkP =0
constraint 5 [choice]PkF =0
constraint 6 [choice]iP =0
constraint 7 [choice]kFXiP98=0
constraint 8 [choice]kPXiP98=0
constraint 9 [choice]zPXiP98=0
constraint 10 [choice]iPXiP98=0
constraint 11 [choice]iPXzP98=0
constraint 12 [choice]iPXkP98=0
constraint 13 [choice]iPXkF98=0

clogit choice `AltCons' *Xad? *Xage* kPXincln zPXincln iPXincln OXtram2 OXmetro2 OXrail2 OXcw PXcw OXtov PXtmiv NXkm NXkmln ??Xnoshop ??Xc_* ??Xh_* ??Xtram2 ??Xmetro2 ??Xrail2 ,group(persnr) constraints(2/6) coll from(A,skip)

//clogit choice `AltCons' *Xad? *Xage* kPXincln zPXincln iPXincln OXtram2 OXmetro2 OXrail2 OXcw PXcw OXtov PXtmiv NXkm NXkmln ??Xnoshop ??Xc_* ??Xh_* ??Xtram2 ??Xmetro2 ??Xrail2 ??X??98,group(persnr) constraints(2/13) coll from(A,skip)
mat A = e(b)




****** bestimme, ob Person arbeitet/in Ausbildung ist und wenn ja, ob Angaben zum Arbeitsweg vorliegen
gen modeinfo=1 if // Infos zum Arbeits/Ausbildungsweg vorhanden...
gen empltrain=1 if // wenn in Ausbildung/Arbeit...
replace mode = 0 if empltrain==0
*** 
sort hhnrakt year empltrain modeinfo km 
*** sortiere: Personen mit Arbeis- und Ausbildungsweg und Infos dazu zuerst, 
*** bei 2+mehr-Personen: nimm die Person mit dem weitesten Arbeitsweg als Person 1, etc.

local `maxpers'=2

by hhnrakt year: gen pid=_n if empltrain & _n<=`maxpers'

*** generiere ggf. weitere HH-Variablen aus den restlichen Personen-Daten ***
*** Lösche dann Personen 3+ ***
by hhnrakt year: drop if _n>`maxpers'
reshape wide mode age **** alle Personenbezogenen Daten****, i(hhnrakt) j(pid)

foreach p in 1/`maxpers' {
	gen altP`p' = hhpkw012*100+10*`p'+modeP`p'
	label var altP`p' "Alt. Pers. `p'"
	foreach c in 0/`maxpers' {
		label define alt  `c'`p'0 "C`c'_P`p'_X"  `c'`p'1 "C`c'_P`p'_O"  `c'`p'2 "C`c'_P`p'_P"  `c'`p'3 "C`c'_P`p'_N",add
		*** X: keinen Arbeitsweg, O: ÖPNV, P: Pkw, N: Nicht-Motorisiert ****
	}
}
label values altP? alt

case2alt, choice(altP1) case(hhnrakt) gen(choice) altnum(_altnum)

replace choice=1 if _altnum==altP2

gen C0 = int(_altnum/100)==0
label var C0 "0 HH-Pkw"
gen C1 = int(_altnum/100)==1
label var C1 "1 HH-Pkw"
gen C2 = int(_altnum/100)==2
label var C2 "2+ HH-Pkw"

gen P1 = mod(_altnum/10,10)==1
label var P1 "Person 1"
gen P2 = mod(_altnum/10,10)==2
label var P2 "Person 2"

gen X = (mod(_altnum,100)==0)
label var X "kein Arbeitsweg"
gen O = (mod(_altnum,100)==1)
label var O "ÖPNV"
gen P = (mod(_altnum,100)==2)
label var P "Pkw"
gen N = (mod(_altnum,100)==3)
label var N "Nicht-motorisiert"

*** lösche nicht vorhandene Alternativen ***
// nur ein Erwachsener: lösche P2
drop if P2 & mode2==.
// Pkw-Fahrer nicht verfügbar, wenn kein Führerschein // ggf. Mitfahrer???
drop if P & P1 & pfhs1==0
drop if P & P2 & pfhs2==0
// wenn "kein Arbeitsweg", dann nur Alt. X
drop if (O|P|N) & P1 & mode1==0
drop if (O|P|N) & P2 & mode2==0
// wenn Arbeitsweg, dann keine Alt. X
drop if X & P1 & mode1>=1&mode1<=3
drop if X & P2 & mode2>=1&mode2<=3

*** generiere Alternativen-spezifische Variablen
*** ggf. Einkommen in Anlehnung an Ben-Akiva/Lerman
*** hier geschätzt: + 400 € fixer Haushalts-Grundbedarf + 230 € je Erwachsenen + 200 € je Kind***
*** (entspricht in etwa dem Mindesrückbehalt bei der Wohnungsbauförderung in NRW) ***
*** theoretisch liessen sich nach diesem Prinzip auch Wohn- und Mobilitätskosten in das Rest-Einkommen integrieren ***
gen restinc =  hinc_2007-400-230*adults-200*eqnkids
*** weiter werden noch Fixkosten der Pkw abgezogen
replace restinc = restinc - 200*1 if C1
replace restinc = restinc - 200*2 if C2
*** Dann Abzug der variablen Pkw/ÖV-Kosten für den Arbeitsweg: 
*** je Erwerbstätigen: Hin-und Rückfahrt an durchschnittlich 19 Tagen (beim Zeitkarten-Besitz über Fixkosten Monatskarte...)
*** 10 ct je km reine Betriebskosten für einen Kleinwagen
gen copkw = km*.10
replace restinc = restinc - (cozk*2*19) if O
replace restinc = restinc - (copkw*2*19) if P 
*** ln(restinc+1000€), damit (fast) keine negativen Werte generiert werden...  ***
gen restincln = ln(restinc+1000)

**** generiere Variablen auf der HH-Ebene
**** 1 Pkw (C1) als Referenzkategorie
foreach c of 0 1 2 {
	gen C`c'Xhhinc = C`c'*hhinc
	gen C`c'Xkid1 = C`c'*(kid==1)
	gen C`c'Xkid2_ = C`c'*(kid>=2 & kid<.)
// erw3: mehr als 3 Erwachsene (1 oder 2 müsste eigentlich über die Pers1 und Pers2-Konstanten berücksichtigt sein
	gen C`c'Xadult3_ = C`c'*(adult>=3 & adult<.)
** ggf. die Spezifikation wie in Ben-Akiva und Lerman
	*** Wohnort-Variablen ***
	gen C`c'X.. = C`c'*...
}



//clogit choice  OXtov PXtmiv OnXcoek OjXcozk PXcopkw O? Pj N?,group(persnr)
clogit choice  ?Xage* OXincln PXincln kPXincln PzXincln PiXincln cw OXtov PXtmiv NXkm NXkmln *Xtram2 *Xmetro2 O P kP Pz Pi,group(persnr)

nlogitgen pf = _altnum(kF: 101|102|103, kP: 201|202|203, zP:301|302|303, iP: 401|402|403)
//konvergiert noch nicht so wie es soll!!!
nlogit choice  cw OXtov PXtmiv NXkm NXkmln OXtram2 O P in 1/20000 || pf: incln metroaccess tramaccess, base(kF) || _altnum:  ,noconst case(persnr)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\nlogit0",replace
estimates use "$PW_workingdir\soep\proj\Mobilitaet\nlogit0"
mat A=e(b)
matrix list A
nlogit choice  cw OXtov PXtmiv NXkm NXkmln OXtram2 OkF PkF NkF OkP PkP NkP OPz PPz NPz OPi NPi || pf: incln metroaccess tramaccess, base(kF) || _altnum:  ,noconst case(persnr) from(A,skip)
estimates save "$PW_workingdir\soep\proj\Mobilitaet\nlogit0",replace

constraint 1 [_altnum]PPi=0
nlogit choice  cw OXtov PXtmiv NXkm NXkmln OXtram2 OkF PkF NkF OkP PkP NkP OPz PPz NPz OPi PPi NPi || pf: incln metroaccess tramaccess, base(kF) || _altnum:  ,noconst case(persnr) from(A,skip) constraints(1)

//local AltCons "kF kP zP OkF PkF NkF OkP PkP NkP OPz PPz NPz OPi PPi NPi"




******* lösche missings ******************
gen miss=0 if  wohn_typ<.& entfgrstadt<.& inf_shops<.& inf_doctor<.& inf_transit<. & wohn_quartier<.
drop if miss>=.



capture program drop strejoin
program define strejoin
	dropvars agegroup _age_* _fem_* _fem1_*
	stjoin
	replace agem = agem_backup
end

capture program drop agedummy
program define agedummy
	xi i.agegroup*female,noomit
	renpfix _Iagegroup_ _age_
	renpfix  _IageXfema_ _fem1_
	forvalues i=25(5)85 {
		local ii=`i'+4
		rename _age_`i' _age_`i'_`ii'
		rename _fem1_`i' _fem1_`i'_`ii'
	}
	rename _age_90 _age_90_
	rename _fem1_90 _fem1_90_
	dropvars _fem1_18-_fem1_24
	gen _fem1_18_24=0
	replace _fem1_18_24=1 if (agem>=18&agem<25&female==1)
	gen _fem_18_34 = 1 if female==1 & agem>=18 & agem<35
	gen _fem_35_49 = 1 if female==1 & agem>=35 & agem<50
	gen _fem_50_64 = 1 if female==1 & agem>=50 & agem<65
	gen _fem_65_79 = 1 if female==1 & agem>=65 & agem<80
	gen _fem_80_ = 1 if female==1 & agem>=80 & agem<.
	recode _fem_* (.=0)

end


capture program drop splitage1819
program define splitage1819
  quietly {
	dropvars agem_backup
	gen agem_backup = agem
	stsplit agegroup, at(1/6 7(5)72)
	replace agegroup= agegroup+18
	agedummy
  }
end

capture program drop splitage1825
program define splitage1825
  quietly {
	dropvars agem_backup agegroup
	gen agem_backup = agem
	stsplit agegroup, at(7(5)72)
	replace agegroup= agegroup+18
	agedummy
  }
end

soep_genvar_occ_spatial

******** Übergänge von "kein Führerschein" *********

//
streg _age_* _fem_* pincln adult2 adult3 kid? oc* mixedneighb house_* city_* shop?? notransit moved2y, dist(e) log nocons nohr


log close