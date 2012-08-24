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
clonevar agegrp = EF44
recode agegrp (0/14 = 1) (15/20 = 2) (21/25 = 3) (26/30 = 4) (31/35 = 5) (36/40 = 6) (41/45 = 7) (46/50 = 8) (51/55 = 9) (56/60 = 10) (61/65 =11) (66/70 = 12) (71/75 = 13) (75/95 = 14)
label define agegrp 1 "0/14" 2 "15/20" 3 "21/25" 4 "26/30" 5 "31/35" 6 "36/40" 7 "41/45" 8 "46/50" 9 "51/55" 10 "56/60" 11 "61/65" 12 "66/70" 13 "71/75" 14 "75/95"
label values agegrp agegrp

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
clonevar bl = EF1
recode bl (1 2 3 4 5 7 10 11 12 13 14 16 = 17)
recode bl (6 = 2) (8 = 13) (9 = 3) (17 = 0) (15 = 1)
label define bl 1 "Schleswig-Holstein" 2 "Hamburg" 13 "Mecklenburg-Vorpommern" 3 "Niedersachsen" 0 "sonstiges Bundesland", replace
label values bl bl
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

recode EF38 (1/3 6/10 = 1) (4 5 12 13 = 2) (14/22 = 3), gen(erwerb3)
label define erwerb3 1 "[1] Erwerbstätige (inkl. WZD)" 2 "[2] Arbeitslose" 3 "[3] Nichterwerbsperson" 
label values erwerb3 erwerb3

// Modell Erwerbtstätig/AL/NE
// Für Simulation zu differenzieren nach EW_M/W und AL 1525-AL2555-AL5565 (NE als Referenzkategorie


gen kk01 = EF44<=1
gen kk23 = (EF44<=3) & (EF44>=2)
gen kk46 = (EF44<=6) & (EF44>=4)
gen ep2165 = (EF44<=65) & (EF44>=21)
bysort EF3 EF4: egen hhkk01 = total(kk01)
bysort EF3 EF4: egen hhkk23 = total(kk23)
bysort EF3 EF4: egen hhkk46 = total(kk46)
replace hhkk01=1 if hhkk01>1
replace hhkk23=1 if hhkk23>1
replace hhkk46=1 if hhkk46>1

bysort EF3 EF4: egen hhep = total(ep2165)
recode hhep (0/1=0) (2/99=1)
tabm hhkk01 if EF5a==1

// MISSING CONTROL
misschk agegrp female alone hhep bl_gg wfl wfl_pk  vztz


mlogit erwerb3 i.agegrp#female hhep#female /*
*/ hhkk01#female hhkk23#female hhkk46#female /*
*/ wfl_pk ib0.bl_gg#female [iw= EF960], base(1)

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

// WORKED HOURS
// EF131 Normalerweise geleistete Arbeitszeit je Woche (Stunden)
clonevar hours = EF131
recode hours (0/10 = 1) (11/20 = 2) (21/30 = 3) (31/40 = 4) (41/50 = 5) (51/100 = 6)
label define hours 1 "0/10" 2 "11/20" 3 "21/30" 4 "31/40" 5 "41/50" 6 "51/100", replace
label values hours hours

// VOLLZEIT-/TEILZEITTÄTIGKEIT
// EF129

tab hours EF129 // Definition: ab 32 Stunden Vollzeit

recode EF129 (2=0 "Teilzeit") (1=1 "Vollzeit"), gen(vz)
logit vz i.agegrp#female i.bl_gg wfl_pk if erwerb3 == 1 [iw=EF960]
outreg2 using "D:\Modell\sim\params\vztz.txt", bdec(5) tdec(5) noparen noaster replace


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

constraint define 23 [beamte]12.agegrp#1.female = 0
constraint define 24 [beamte]13.agegrp#1.female = 0
constraint define 25 [beamte]14.agegrp#1.female = 0

mlogit stellung i.agegrp#female wfl_pk [iw= EF960], base(5) constraint(1/25)
outreg2 using "D:\Modell\sim\params\stellung_im_beruf.txt", bdec(5) tdec(5) noparen noaster replace

