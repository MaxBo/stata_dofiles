global MZ "O:\MZ\Daten\2006"
use "$MZ\mz2006.dta", clear
// ERWERBSTÄTIGKEIT
// Datensatz: mz2006.dta 
// Quelle: GESIS - Mikrozensus 2006
// Autor: Thiago Guimaraes
// Zustand: 23.08.2012 

drop if EF5b == 1
// EF30?? Bevölkerung am Hauptwohnsitz

// AGEGRP (age groups)

recode EF44 (0/14 = 1 "0/14") (15/17 = 2 "15/17") (18/20 = 3 "18/20") (21/25 = 4 "21/25") (26/30 = 5 "26/40") (31/35 = 6 "31/35") /*
*/(36/40 = 7 "36/40") (41/45 = 8 "41/45") (46/50 = 9 "46/50") (51/55 = 10 "51/55") (56/60 = 11 "56/60") (61/63 =12 "61/63") (64/65 =13 "64/65") /*
*/(66/70 = 14 "66/70") (71/75 = 15 "71/75") (76/95 = 16 "76/95"), gen(agegrp)


// FEMALE (sex)
recode EF46 (2=1 "Frau") (1=0 "Mann"), gen(female)


// ALONE (ledig, verwitwet, geschieden)
clonevar alone = EF49
recode alone (3=1) (4=1) (2=0) (5=0)
label define alone 0 "not alone" 1 "alone"
label values alone alone
// tab EF49 EF50 --> 1,5% der Ehepartner leben nicht im selben Haushalt

// PERSONEN_HH (number of persons in household)
clonevar pers_hh = EF20
// EF20 Zahl der Personen im Haushalt
// EF616 Zahl der Personen in Privathaushalten 
// EF637 Zahl der Personen in der Wohnung
// EF663 Zahl der Haushaltsmitglieder

// BUNDESLAND
// EF1 Land der Bundesrepublik
// EF563 Gemeindegrößenklassen
recode EF1 (1 2 3 4 5 7 10 11 12 13 14 16 = 0 "sonstiges Bundesland") (6 = 2 "Hamburg") (8 = 13 "Mecklenburg-Vorpommern") (9 = 3 "Niedersachsen") (17 = 0) (15 = 1 "Schleswig-Holstein"), gen(bl)
gen bl_gg = .
replace bl_gg = 10*bl + EF563
recode bl_gg (137=133) (1/9=0)

label define bl_gg 11 "SH" 12 "Hamburg" 13 "Hamburg" 14 "Hamburg" 15 "Hamburg (>500T)" 21 "Mecklenburg-Vorpommern (<5T)" 22 "Mecklenburg-Vorpommern (5T-20T)" 23 "Mecklenburg-Vorpommern (20T-100T)" 24 "Mecklenburg-Vorpommern" 25 "Mecklenburg-Vorpommern" 31 "Niedersachsen (<5T)" 32 "Niedersachsen (5T-20T)" 33 "Niedersachsen (20T-100T)" 34 "Niedersachsen (100T-500T)" 35 "Niedersachsen (>500T)" 4 "sonstiges Bundesland, irgendwelche Grösse", replace
label values bl_gg bl_gg

// WOHNFLÄCHE - categories
// EF492 Wie groß ist die Wohnfläche der gesamten Wohnung?
clonevar wfl = EF492
sum EF492, d
recode wfl (0/30 = 1) (31/40 = 2) (41/50 = 3) (51/60 = 4) (61/70 = 5) (71/80 = 6) (81/90 = 7) (91/100 = 8) (101/110 =9) (111/120 = 10) (121/130 = 11) (131/140 = 12) (141/150 = 13) (151/180 = 14) (181/1000 = 15) 
// label define wfl 
// label values wfl wfl

// DICHTE
// ehemals pers_hh / EF492
gen wfl_pk = EF492 / EF637

// ERWERBSTYP
// tab EF29 agegrp
// EF38 is subdivision of EF29
clonevar erwerb = EF38
recode erwerb (1 3 = 1) (4 5 12 13 = 3) (2 6/10 14 15 = 2) (16 19 20 = 4) (17 18 21 = 5) (22 = 6)
label define erwerb 1 "[1] Erwerbstätige (inkl. WZD)" 2 "[2] gleich (wieder) Erwerbstätige" 3 "[3] Erwerbslose/Arbeitsuchender" 4 "[4] Nichterwerbsperson (keine Suche)" 5 "[5] Nichterwerbsperson (Rentner o. ä.)" 6 "[6] Nichterwerbsperson (Kind)", replace
label values erwerb erwerb
tab erwerb EF38, m

recode EF38 (1/3 6/10 = 1 "ET") (4 5 12 13 = 2 "AL") (14/22 = 3 "NE"), gen(erwerb3)


// Modell Erwerbtstätig/AL/NE
// Für Simulation zu differenzieren nach EW_M/W und AL 1525-AL2555-AL5565 (NE als Referenzkategorie


gen kk01 = EF44<=1
gen kk23 = (EF44<=3) & (EF44>=2)
gen kk46 = (EF44<=6) & (EF44>=4)
gen kk710 = (EF44<=10) & (EF44>=7)
gen kk1117 = (EF44<=17) & (EF44>=11)
gen erw = (EF44>=18) & (EF44<.)
gen ep2165 = (EF44<=65) & (EF44>=21)
bysort EF3 EF4: egen hhkk01 = total(kk01)
bysort EF3 EF4: egen hhkk23 = total(kk23)
bysort EF3 EF4: egen hhkk46 = total(kk46)
bysort EF3 EF4: egen hhkk710 = total(kk710)
bysort EF3 EF4: egen hhkk1117 = total(kk1117)
bysort EF3 EF4: egen hherw = total(erw)
// Erwerbstätige im Haushalt
bysort EF3 EF4: egen hh_et = total(erwerb3==1)
// andere Erwerbstätige im Haushalt
gen andere_et = (hh_et - (erwerb3==1)) //* (hh_et_m > 0)

bysort EF3 EF4: egen hhep = total(ep2165)
recode hhep (0/1=0) (2/99=1)
tabm hhkk01 if EF5a==1

// Stellung im Beruf
recode EF117 (1=1 "s_o_b") (2=2 "s_m_b") (3=3 "mhfam") (4 9 =4 "beamte") (5/6 10/11 = 5 "angest") (7/8=6 "azubi"), gen(stellung)


// eindeutige ID
gen long pid = EF3 * 10000 + EF4 * 100 + EF5a


*******************************************************************

// VOLLZEIT-/TEILZEITTÄTIGKEIT
// EF129
// WORKED HOURS
// EF131 Normalerweise geleistete Arbeitszeit je Woche (Stunden)
recode EF131 (0/10 = 1 "0/10") (11/20 = 2 "11/20") (21/31 = 3 "21/31") (32/40 = 4 "32/40") (41/50 = 5 "41/50") (51/100 = 6 "51/100"), gen(hours)

tab hours EF129 // Definition: ab 32 Stunden Vollzeit

recode EF129 (2=0 "Teilzeit") (1=1 "Vollzeit"), gen(vz)

logit vz i.agegrp#female i.bl_gg wfl_pk i.stellung if erwerb3 == 1 [iw=EF960]
outreg2 using "D:\Modell\sim\params\vztz.txt", bdec(5) tdec(5) noparen noaster replace

*******************************************************************
// CLogit Modell ET_AL_NE


//keep  if pid<50000000

// nur relevante Variablen behalten
keep pid agegrp female hhkk* wfl_pk bl_gg EF960 erwerb3 andere_et hherw
// EIne Zeile je Alternative
expand 3
bysort pid: gen _altnum = _n
gen ET = _altnum == 1
gen AL = _altnum == 2
gen NE = _altnum == 3
// generiere abhängige Variable Choice
gen choice = _altnum == erwerb3
gen sample = 1

forvalues a=1/16 {
	forvalues f = 0/1 {
	    if `a'>=2 & `a'<=11 {
			gen AL_f`f'_agr_`a' = AL & agegrp == `a' & female==`f'
		}
		if `a'>=2 & `a'<=13 {
			gen NE_f`f'_agr_`a' = NE & agegrp== `a' & female==`f'
		}
	}
}

//dropvars NE_f?* AL_f*

// Kinder im Haushalt nach Geschlecht
forvalues f = 0/1 {
	gen ET_f`f'_hhkk01 = hhkk01 * (ET & female==`f')
	gen ET_f`f'_hhkk23 = hhkk23 * (ET & female==`f')
	gen ET_f`f'_hhkk46 = hhkk46 * (ET & female==`f')
	gen ET_f`f'_hhkk710 = hhkk710 * (ET & female==`f')
	gen ET_f`f'_hhkk1117 = hhkk1117 * (ET & female==`f')
	gen ET_f`f'_hherw = hherw * (ET & female==`f')
}
// andere Erwerbstätige im Haushalt
gen ET_mann_arbeitet = (andere_et >= 1) & ET & female==1

// Bundesländer und Gemeindegrößen
// Hole erst Vektor der Ausprägungen
tab bl_gg, matrow(i)
local rofi = rowsof(i)
forvalues b = 1/`rofi' {
	local bi = i[`b',1]
	if `bi' > 0 {
		forvalues f = 0/1 {
			gen ET_f`f'_bl_`bi' = ET & bl_gg == `bi' & female==`f'
		    }
		gen AL_bl_`bi' = AL & bl_gg == `bi'
	}
}

gen AL_wfl = AL * wfl_pk
gen NE_wfl = NE * wfl_pk


replace sample = 0 if AL & (agegrp==1 | agegrp >= 14)
replace sample = 0 if ET & (agegrp==1 | agegrp >= 16)


//clogit choice AL_* NE_* ET_*  if sample  [iw= EF960] , group(pid)
//outreg2 using "D:\Modell\sim\params\erwerbst_al_ne_hhgr_clogit.txt", bdec(5) tdec(5) noparen noaster replace
drop ET_mann_arbeitet 
clogit choice AL_* NE_* ET_*  if sample  [iw= EF960] , group(pid)
outreg2 using "D:\Modell\sim\params\erwerbst_al_ne_clogit2.txt", bdec(5) tdec(5) noparen noaster replace

*********************************************************************************************************
// Modell Stellung im Beruf



//keep  if pid<50000000

// nur relevante Variablen behalten
keep pid agegrp female hhkk* wfl_pk bl_gg EF960 erwerb3 stellung
// Eine Zeile je Alternative
drop if erwerb3 > 1
drop if stellung == .
expand 6
bysort pid: gen _altnum = _n
label values _altnum stellung

gen SOB = _altnum == 1
gen SMB = _altnum == 2
gen MHF = _altnum == 3
gen BEA = _altnum == 4
gen ANG = _altnum == 5
gen AZU = _altnum == 6
// generiere abhängige Variable Choice
gen choice = _altnum == stellung
gen sample = 1

replace sample = 0 if AZU & agegrp > 8
replace sample = 0 if BEA & agegrp > 14
tab agegrp, gen(ag_)
fovalues i=1/13 {
    local i1 = `i'+1
    rename ag_`i' ag_`i1'
}

asclogit choice if sample, case(pid) alt(_altnum) casevars(ag_* wfl_pk)
outreg2 using "D:\Modell\sim\params\stellung_asclogit_test.txt", bdec(5) tdec(5) noparen noaster replace



forvalues a=2/16 {
	forvalues f = 0/1 {
		gen SOB_f`f'_agr_`a' = SOB & agegrp == `a' & female==`f'
	    if `a'>2 {
			gen SMB_f`f'_agr_`a' = SMB & agegrp == `a' & female==`f'
		}
		gen MHF_f`f'_agr_`a' = MHF & agegrp == `a' & female==`f'
//		gen ANG_f`f'_agr_`a' = SOB & agegrp == `a' & female==`f'
	    if `a'<=7 {
			gen AZU_f`f'_agr_`a' = AZU & agegrp == `a' & female==`f'
		}
	    if `a' >=3 & `a'<=11 {
			gen BEA_f`f'_agr_`a' = BEA & agegrp == `a' & female==`f'
		}
	}
}


// Bundesländer und Gemeindegrößen
// Hole erst Vektor der Ausprägungen
tab bl_gg, matrow(i)
local rofi = rowsof(i)
forvalues b = 1/`rofi' {
	local bi = i[`b',1]
	if `bi' > 0 {
		gen SOB_bl_`bi' = SOB & bl_gg == `bi'
		gen SMB_bl_`bi' = SMB & bl_gg == `bi'
		gen MHF_bl_`bi' = MHF & bl_gg == `bi'
		gen BEA_bl_`bi' = BEA & bl_gg == `bi'
		gen AZU_bl_`bi' = AZU & bl_gg == `bi'
	}
}



clogit choice SOB_* SMB_* MHF_* BEA_* AZU_*  if sample [iw= EF960] , group(pid)
outreg2 using "D:\Modell\sim\params\stellung_clogit.txt", bdec(5) tdec(5) noparen noaster replace






mlogit erwerb3 ibn.agegrp#female [iw= EF960] in 1/10000, base(1) constraint(12/20) noconst  collinear



mlogit erwerb3 ibn.agegrp#female hhep#female /*
*/ hhkk01#female hhkk23#female hhkk46#female /*
*/ wfl_pk ib0.bl_gg#female [iw= EF960] in 1/10000, base(1) constraint(1/99) noconst  collinear

outreg2 using "D:\Modell\sim\params\erwerbst_al_ne.txt", bdec(5) tdec(5) noparen noaster replace




// DIFFERENZIERUNG DER ERWERBSTÄTIGE:

// EF84 Erwerbstätigkeit in der Berichtswoche
// Umkodierung: Erwerbstätigkeit in der Berichtswoche (Erwerbstätige, Mithelfende Familienangehörige, gelegentlicher Zuverdienst in der Berichtswoche, geringfügig Beschäftigte sollen nur für "ET" verfügbar sein, Mutterschutz < 3, Mutterschutz > 3 und Sonstige NET sollen für "gleich ET" verfügbar sein)
recode erwerb (2=1) if EF84 == 1
recode erwerb (2=1) if EF84 == 3
recode erwerb (2=1) if EF84 == 4
recode erwerb (1=2) if EF84 == 5
recode erwerb (3=2) (4=2) if EF84 == 6
tab erwerb EF84

gen etaetig = EF84 if erwerb == 1

// STELLUNG IM BERUF: Selbständiger, Mithelfender, Beamter, Angestellter, Arbeiter, Azubi, ZWD...
// EF117 Stellung im Beruf (gegenwärtige Tätigkeit)
// Umkodierung: Stellung im Beruf soll nur für "ET" oder "gleich ET" verfügbar sein
recode erwerb (3 4 5 = 1) if EF117 < .
tab erwerb EF117 





// DISCRETE CHOICE MODELS 
set more off

// MODEL 1
// Welcher Erwerbstyp der Personen?
mlogit erwerb3 i.agegrp#female pers_hh dichte i.bl_gg if agegrp > 1, base(1)
mlogit erwerb2_a i.agegrp female pers_hh dichte i.bl_gg if agegrp > 1, base(1)

outreg2 using "C:\Thiago\ELAN\MZ\etaetig\results\model1.txt", bdec(5) tdec(5) noparen noaster replace

// MODEL 2
// Welche ist die Erwerbstätigkeit (Erwerbstätige, Mithelfende Familienangehörige, gelegentlicher Zuverdienst in der Berichtswoche, geringfügig Beschäftigte) der Erwerbstätigen?
// mlogit EF84 i.agegrp female alone pers_hh i.bl_gg if erwerb_a == 1, base(5)
mlogit EF84 i.agegrp female pers_hh i.bl_gg if erwerb_a == 1 & (agegrp > 1 & agegrp <= 12), base(1)



recode EF117 (1=1 "s_o_b") (2=2 "s_m_b") (3=3 "mhfam") (4 9 =4 "beamte") (5/6 10/11 = 5 "angest") (7/8=7 "azubi"), gen(stellung)

constraint define 1 [azubi]10.agegrp#0b.female = 0
constraint define 2 [azubi]11.agegrp#0b.female = 0
constraint define 3 [azubi]12.agegrp#0b.female = 0
constraint define 4 [azubi]13.agegrp#0b.female = 0
constraint define 5 [azubi]14.agegrp#0b.female = 0
constraint define 6 [azubi]9.agegrp#0b.female = 0
constraint define 11 [azubi]10.agegrp#1.female = 0
constraint define 12 [azubi]11.agegrp#1.female = 0
constraint define 13 [azubi]12.agegrp#1.female = 0
constraint define 14 [azubi]13.agegrp#1.female = 0
constraint define 15 [azubi]14.agegrp#1.female = 0

constraint define 23 [beamte]14.agegrp#1.female = 0
constraint define 24 [beamte]15.agegrp#1.female = 0
constraint define 25 [beamte]16.agegrp#1.female = 0

mlogit stellung i.agegrp#female wfl_pk [iw= EF960], base(5) constraint(1/25)
outreg2 using "D:\Modell\sim\params\stellung_im_beruf.txt", bdec(5) tdec(5) noparen noaster replace

