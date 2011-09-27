********************************************************************************
********************* Haushalts-Datensatz ***************************************
********************************************************************************


use "$MiD_workingdir\Stata\HH",clear
*** codiere alle Labels um ***
MiDH_HH_Label_neu
rename h01 hAlleinlebend
recode hAlleinlebend (7=.a)
label define h01 .a "verweigert",modify
rename h001c hUnterlagenErhalten
rename h02 hhgr
renpfix h041_ PkwHerst_
renpfix h0412_ PkwBauj_
renpfix h0413_ PkwErwJahr_
renpfix h044_ PkwHauptNutzer_
renpfix h045_ PkwNutzer_
renpfix h046_ PkwHalter_
renpfix h047_ PkwZulArt_
renpfix h048_ PkwAntrieb_
renpfix h049_ PkwPSkW_
renpfix h0491_ PkwPS_
renpfix h0492_ PkwkW_
renpfix h0410_ PkwHubraum_
renpfix h0411_1 PkwParkGarage_
renpfix h0411_2 PkwParkAmHaus_
renpfix h0411_3 PkwParkNaehe_
renpfix h0411_4 PkwParkUnters_
renpfix h0414_ PkwKmStand_
renpfix h0415_ PkwKmJahr_

rename h04_1 hFahrrad
rename h04_2 hMotorad
rename h04_3 hPkw
rename h04_4 hLkwKlein
rename h04_5 hLkwGross
rename h04_6 hLkwGesamt
rename h05 hWohnlage

rename h06_1 hTelFest
rename h06_2 hTelMobil
rename h06_3 hComputer
rename h06_4 hInternet
rename h06_5 hkeineTelKom

recode hTelFest hTelMobil hComputer hInternet (0 1 = .b) if h06_7<0
drop h06_7 h06_8
drop h07*
rename stichtag wStichtag
replace wStichtag = (wStichtag * 1000) + clock("14101582","DMY") // SPSS-Kalenderbeginn am 14.10.1582
format wStichtag %tcDD.NN.CCYY

sort caseid
save "$MiD_workingdir\Stata\MidH_HH0",replace


********************************************************************************
********************* Personen-Datensatz ***************************************
********************************************************************************


use "$MiD_workingdir\Stata\P.dta",clear
gen double PersId = caseid*10+pid
label var PersId "eindeutige Personen-ID"
order PersId caseid pid
*** codiere alle Labels um ***
quietly label dir
foreach lab in `r(names)' {
	label define `lab' .a "keine Angabe" .b "trifft nicht zu" .c "unplausibel" .z "nicht gefragt",modify
}

renpfix s0 ks0

recode p12* (9=.a) (-400/-150=.c)
rename p12_1 pstaat_deutsch
rename p12_2 pstaat_tuerke
rename p12_3 pstaat_ital
rename p12_4 pstaat_griech
rename p12_5 pstaat_andere
label define Label_0 0 "nie" 1 "gelegentlich" 2 "immer",modify
recode p01 (7/9=.a) (-400/-20=.z) (1=2) (2/3=1) (4/6=0)
rename p01 pPkwVerf
label define Label_1 0 "Nein" 1 "Ja" ,modify
recode p02 (7/9=.a) (-400/-20=.z)  (2=0)
rename p02 pRadVerf
recode p051 p053 (997/999=.a) (-400/-20=.z)
recode p052 p054 (97/99=.a) (-400/-20=.z)
replace p053 = p051 if p053==996
replace p054 = p052 if p054==96
rename p051 pMinutenBus
rename p052 pMeterBus
rename p053 pMinutenBahn
rename p054 pMeterBahn
recode p041 p042 (6 7/9=.a) (-400/-20=.z)
rename p041 pErrOV
rename p042 pErrPkw
recode p11 (-200=.z) (9=.a) (2=1) (1=0)
label define Label_12 0 "Mann" 1 "Frau",modify
rename p11 pFrau
replace pFrau = 0 if pFrau==.a & psex==1
replace pFrau = 1 if pFrau==.a & psex==2
drop psex
recode p13(997/999=.a) (-400/-20=.z)
rename p13 pAlter
recode palter (997/999=.a)
replace pAlter=palter if pAlter>=. & palter<.
drop palter
recode p14(97/99=.a) (-400/-20=.z)
rename p14 pAbschluss
recode p15 (7=.a) (2=0) (-400/-20=.z)
label define Label_14 0 "nein",modify
rename p15 pBeruf
recode p16 (7/8=.a) (-400/-100=.z) (-24 = .a) (-23=.b)
rename p16 pErwerbStatus
recode p17 (97/98=.a) (-400/-100=.z) (-26 = .r) (-25=.s)
label define Label_23 .r "Azubi" .s "berufstätig",modify
rename p17 pHauptbesch
recode p18 (97/98=.a) (-400/-100=.z)
rename p18 pStellung
recode p17s (97/99=.a) (-150=.y) (-175=.b)
label define Label_25 0 "Kind unter 6 Jahre" .b "In CATI nicht erhoben" .y "im Kinder-Fragebogen nicht erhoben",modify
rename p17s pBeschaeftigung
replace pBeschaeftigung = 5 if pHauptbesch==3 & pBeschaeftigung == .b
replace pBeschaeftigung = 6 if pHauptbesch==2 & pBeschaeftigung == .b
replace pBeschaeftigung = pErwerbStatus if pErwerbStatus<=4 & pBeschaeftigung == .b
replace pBeschaeftigung = pHauptbesch+3 if pBeschaeftigung == .b & pHauptbesch<.
replace pBeschaeftigung = 6 if (pBeschaeftigung == .b | pBeschaeftigung == .y) & pAlter>=6&pAlter<10
replace pBeschaeftigung = 5 if (pBeschaeftigung == .b | pBeschaeftigung == .y) & pAlter>=10&pAlter<16
replace pBeschaeftigung = 0 if (pBeschaeftigung == .b | pBeschaeftigung == .y) & pAlter<6

recode p18s (97/99=.a) (-150=.y) (-175=.b)
replace pStellung = p18s-1 if p18s>=2&p18s<=13
replace pStellung = 13 if p18s==1
recode pStellung (.z=13) if pAlter < 16
drop p18s
recode p09_? (7/9=.a) (-400/-100=.z)
rename p09_1 pGehbehinderung
rename p09_2 pSehBehinderung
rename p09_3 pandereBehinderung
rename p09_4 pkeineBehinderung
recode p09 (7/9=.a) (2=0) (-400/-100=.z) (-28=0)
label define Label_27 0 "nein",modify
rename p09 pMobEingeschraenkt

recode ks03 (7/9=.a) (-400/-100=.z)
rename ks03 sWetter
recode ks04 (7/9=.a) (-400/-29=.z) (1=2) (2=1) (3=0)
label define Label_30 0 "gar nicht" 1 "teilweise" 2 "ständig",modify
rename ks04 sKfzVerf
label var sKfzVerf "Kfz verfügbar als Fahrer/Beifahrer am Stichtag"
recode ks01 (7/9=.a) (-400/-29=.z) (2=0)
label define Label_32 0 "nein" 1 "ja",modify
rename ks01 sNormal

rename p021 pRadAbstellort
rename p022 pRadZugang
rename p031 pNutzungPkw
rename p032 pNutzungOV
rename p033 pNutzungRad
rename p034 pNutzungBahnFern

recode pRadAbstellort pRadZugang pNutzung* (7/9=.a)

rename p07 pTicketart
recode pTicketart (8 96/99=.a) (9=0)
label define Label_8 0 "Fahre nie ÖPNV",modify

rename p10 pAnzReisen
replace pAnzReisen = 0 if p10as == 2
replace pAnzReisen = .a if p10as == 9
replace pAnzReisen = .b if p10as == .b
replace pAnzReisen = .z  if p10as == 1
drop p10as
recode pAnzReisen (994=.c) (997/999=.a)
label define Label_10 .z "Papi: mind. eine Reise unternommen",modify

rename p101_1 pRZwGeschaeftl
rename p101_2 pRZwPrivKurz
rename p101_3 pRZwPrivLang
rename p101_4 pRZwSonst

rename p102_1 pRVMAuto
rename p102_2 pRVMBahn
rename p102_3 pRVMReisebus
rename p102_4 pRVMFlug
rename p102_5 pRVMFahrrad
rename p102_6 pRVMSonst

rename p06 pFhs
rename p061_1 pFhsMoped
rename p061_2 pFhsMotorrad
rename p061_3 pFhsPkw
rename p061_4 pFhsLkw

recode pFhs* (2=0) (7/9=.a)
label define Label_14 0 "Nein",modify
label define Label_15 0 "Nein",modify
label define Label_16 0 "Nein",modify

rename p061_1j pJahrFhsMoped
rename p061_2j pJahrFhsMotorrad
rename p061_3j pJahrFhsPkw
rename p061_4j pJahrFhsLkw
recode pJahrFhs* (9996/9999 = .a)

rename p08 pWohndauer
recode pWohndauer (7/9 = .a)

rename ks05 sAusserHaus
recode sAusserHaus (2=0) (7/9=.a)
label define Label_31 0 "Nein",modify
rename ks02_1 sNNUrlaubInD
rename ks02_2 sNNUrlaubAusl
rename ks02_3 sNNKrank
rename ks02_4 sNNZuHaus
rename ks02_5 sNNPflege
rename ks02_6 sNNAndere
rename ks02_7 sNNVerweigert
rename ks02_8 sNNWeissNicht
recode sNN* (9=.a)

rename wv0 wvRegBerWege
recode wvRegBerWege (2=0) (7/9=.a)
label define Label_36 0 "Nein",modify
rename wv01 wvBranche
recode wvBranche (97/99=.a)
rename wv02 wvHauptzweck
recode wvHauptzweck (7/9 99 = .a) (11=4) (13=5) (14=6)
rename wv03 wvKm
recode wvKm (99997/99999 = .a)
rename wv04 wvAnzahlWege
recode wvAnzahlWege (97/99 = .a)
label values wvAnzahlWege Label_39
rename wv05 wvVerkehrsmittel
recode wvVerkehrsmittel (97/99 = .a)

rename w12 wWeitereWege
recode wWeitereWege (-20=.j) (-10=.a) (-13=.d) (-12=.c) (-15=.f) (-14=.e)
label define Label_41 .j `"Aufgrund Filterbedingungen Wege nicht berechnet"', modify
label define Label_41 .f `"PAPI:Keine Angaben in der Wegematrix"', modify
label define Label_41 .e `"PAPI:Kinder mit weniger als 6 Wegen werden nicht befragt"', modify
label define Label_41 .d `"PAPI:Erwachsene mit weniger als 7 Wegen werden nicht befragt"', modify
label define Label_41 .c `"Personen mit weniger als 8 Wegen werden nicht befragt"', modify
label define Label_41 .a `"Aufgrund Filterbedingungen Wege nicht erfasst"', modify

recode weganz_? (997/999 = .a)
rename weganz_1 wAnzInMatrix
rename weganz_2 wAnzInclWeitere
rename weganz_3 wAnzInclWVundWeitere

dropvars  gemnr stichpro fragebog  gew_pa  D_R an_schiene typ lage_iv zentralit entfernung zone_1 vz_nr_ne_1 /* */ vzname_n_1 typname zentrtyp filter_ WegekmKl Verkm5  bland westost ggkpol ggkbik bbr_reg bbr_dreg bbrkrtyp

dropvars h02 h05 lebensp h04* hhgr* hheink

recode ov_seg (-1=.d) (9=.a)
label define Label_46 .a "keine Angabe" .d "Nicht zuzuordnen aufgrund Erhebungsform",modify
recode pergrup* (99=.d)
label define Label_47 .d "Nicht zu zuordnen",modify
label define Label_48 .d "Nicht zu zuordnen",modify

recode proxy (-1=.d)
label define Label_50 .d "Nur als PAPI befragt", modify

** wegdauer schliesst Dauern > 870 Minuten aus wegen Unplausibilität **
replace wegdauer = .c if wegdauer>870 & wegdauer<.
recode wegtempo (9994/9999 = .c)
recode kinfo (9=.a)
recode mobil (2=.a)

gen pStichtag = date(stichtag , "MDY")
format pStichtag %tdDD_Mon_CCYY
drop stichtag

quietly label dir
local vallist `r(names)'
foreach vl in `vallist' {
	label copy `vl' P`vl', replace
	foreach var of varlist * {
		local varvl : value label `var'
		if "`varvl'"=="`vl'" {
			label values `var' P`vl'
		}
	}
	label drop `vl'
}

sort PersId
save "$MiD_workingdir\Stata\MidH_P0.dta" ,replace

********************************************************************************
********************* Wege-Datensatz *******************************************
********************************************************************************




use "$MiD_workingdir\Stata\W.dta",clear
dropvars  gemnr stichpro fragebog  gew_pa  D_R an_schiene typ lage_iv zentralit entfernung zone_1 vz_nr_ne_1 /*
*/ vzname_n_1 typname zentrtyp filter_ WegekmKl Verkm5  bland westost ggkpol ggkbik bbr_reg bbr_dreg bbrkrtyp
 
dropvars p0* p1* erfwege weganz_? hheink lebensp ov_seg pergrup* caseinfo proxy voll_hh ks* h0* palter psex /*
*/ persinfo befrag hhgr* 



gen double WegId = caseid*100+pid*10+weg
label var WegId "eindeutige Wege-ID"
gen double PersId = caseid*10+pid
label var PersId "eindeutige Personen-ID"
order WegId PersId caseid pid weg
*** codiere alle Labels um ***
quietly label dir
foreach lab in `r(names)' {
	label define `lab' .a "keine Angabe" .b "trifft nicht zu" .c "unplausibel" .z "nicht gefragt",modify
}

recode w01 (-39=.b) (7/9=.a)
rename w01 wStartpunkt
recode w111 (-150/-100=.z) (-73=.b) (8/9=.a)
rename w111 wNurEinWeg
recode w112 (-150/-100 -71 -70=.z)  (-73/-72=.b) (8/9=.a)
rename w112 wAlleWege
recode w04 (97/99=.a) 
rename w04 wZweck
recode w04? (-1=.b) (-150/-100=.z) (999=.a)
rename w041 wZweckEinkauf
rename w042 wZweckErledigung
rename w043 wZweckFreizeit
recode w13 (7/9=.a)
rename w13 wZiel
recode wZiel (1 .a .b = 1) (2/3=0)
label define Label_7 0 "ja" 1 "nein",modify
recode w05_* (-150/-50 = .z) (9=.a)
rename w05_1 wVM_Fuss
rename w05_2 wVM_Rad
rename w05_3 wVM_Moped
rename w05_4 wVM_Motorrad
rename w05_5 wVM_PkwFahrer
rename w05_6 wVM_PkwMitfahrer
replace w05_7 = 1 if w05_8==1 
replace w05_7 = 1 if w05_7s==1
replace w05_7 = 0 if w05_7s==0
drop w05_7s w05_8
rename w05_7 wVM_Lkw_unt35
label var wVM_Lkw_unt35 "Lkw bis 3.5t genutzt"
replace w05_9 = 1 if w05_10==1 
replace w05_9 = 1 if w05_9s==1
replace w05_9 = 0 if w05_9s==0
rename w05_9 wVM_Lkw_ueb35
drop w05_9s w05_9
label var wVM_Lkw_ueb35 "Lkw über 3.5t genutzt"
rename w05_10 wVM_Lkw_and
label var wVM_Lkw_and "anderer Lkw genutzt"
gen wVM_Lkw = wVM_Lkw_unt35==1|wVM_Lkw_ueb35==1|wVM_Lkw_and==1
label var wVM_Lkw "Lkw genutzt"
label values wVM_Lkw Label_8
move wVM_Lkw wVM_Lkw_unt35
rename w05_11 wVM_Bus
rename w05_12 wVM_UStrab
rename w05_13 wVM_SBahnRE
rename w05_14 wVM_Taxi
rename w05_15 wVM_Schiff
rename w05_16 wVM_Fernzug
rename w05_17 wVM_Reisebus
rename w05_18 wVM_Flugzeug
rename w05_20 wVM_andere
drop w05_21
recode w061 (-150/-45=.z) (-44=.b) (2=0)
label define Label_10 0 "Mitfahrer" .b "kein Kfz genutzt",modify
rename w061 wFahrer
recode w062 (-150/-100=.z) (-44=.b) (-46 2=0) (7/8 = .a)
label define Label_11 0 "nein" .b "kein Kfz",modify
rename w062 wHHKfz
recode w063 (-150/-48=.z) (5 -47/-46=0) (-44=.b) (7/9  = .a)
label define Label_12 0 "anderes" .b "kein Kfz genutzt",modify
rename w063 wwelchesKfz
recode w07 (-9/-7  = .a)
replace w07s = 1 if w07>1&w07<.
replace w07s = 0 if w07==0
rename w07s wBegleitung
rename w07 wAnzBegleiter
recode w071 (-150/-100=.z) (-73 7=.a) (-72=.b) (2=0)
label define Label_15 0 "nein" .b "Kein Begleiter",modify
rename w071 wHHBegleiter
recode w072? (-150/-100=.z) (-74/-73=.a) (-72=.b) (-71=.d) 
label define Label_16 .b "Kein Begleiter aus HH" .b "Kein Begleiter",modify
renpfix w072 wBeglPers
recode w073 (-150/-100 12=.z) (-2=.b) (10=0)
label define Label_17 .b "Kein Kfz genutzt" 0 "Fahrer nicht aus HH",modify
rename w073 wPersFahrer
recode w08 (99996=.c) (99997/99999=.a)
rename w08 wKm
gen double Abfahrt = clock(w03, "hms")
gen double Ankunft = clock(w09, "hms")
recode wegdauer (999995 = .d) (999996 = .c)
label define Label_19 .d "Wegdauer nicht berechenbar",modify
gen Minuten = (Ankunft-Abfahrt) / 60000
replace Minuten = wegdauer if (Minuten <0 | Minuten > 1000) & wegdauer >0 & wegdauer <.
replace Minuten = Minuten + (60*24) if Minuten <0 & wegdauer >=.
replace Minuten = .c if wegdauer ==.c
gen float Stunden = Minuten / 60
drop w03* w09* 
recode w05 (97=.a)
rename w05 wVM11
recode wegtempo (-9=.f) (999995=.g) (999996=.f)
label define Label_60 .f "unplausibel" .g "nicht berechenbar",modify
gen wTempo = wKm / (Minuten / 60)
// ggf. noch nach wVM11 plausibilisieren
replace wTempo = .g if Minuten == 0
replace wTempo = .f if wTempo < .5
replace wTempo = .f if wTempo > 150 & wVM11 != 10 // mehr als 150 ohne Flugzeug
replace wTempo = .f if wTempo > 45 & wVM11 ==2 // mehr als 45 mit Fahrrad
replace wTempo = .f if wTempo > 15 & wVM11 ==1 // mehr als 15 zu Fuss
replace wTemp = wegtempo if wTempo >.
label values wTempo Label_60


gen wStichtag = date(stichtag , "MDY")
format wStichtag %tdDD_Mon_CCYY
drop stichtag

quietly label dir
local vallist `r(names)'
foreach vl in `vallist' {
	label copy `vl' W`vl', replace
	foreach var of varlist * {
		local varvl : value label `var'
		if "`varvl'"=="`vl'" {
			label values `var' W`vl'
		}
	}
	label drop `vl'
}


sort WegId
save "$MiD_workingdir\Stata\MidH_W0.dta" ,replace
//qui recode * (.a / .z=.)
//outsheet using "C:\Dokumente und Einstellungen\max\Desktop\MidH.txt", nolabel replace
