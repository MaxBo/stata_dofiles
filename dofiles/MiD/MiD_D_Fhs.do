use "$MiD\D\2008\Daten\STATA\STATA_Public Use File\MiD2008_PUF_Personen.dta", clear
recode hp_pkwfs (7/9=.b) (1=1 "ja") (2=0 "Nein"), gen(fhs)
recode hp_alter (994/999 = .b)
egen agegrp = cut(hp_alter), at(0 17 18 19 20 21 22 23 24 25 30 35 40 45 50 55 60 65 70 75 80 85 90 105)
recode hp_sex (9=.b) (1=0 "Mann") (2=1 "Frau"), gen(female)
recode hp_besch (99=.a) (3=1 "Vollzeit") (2=2 "Teilzeit") (5=5 "Schüler") (6=6 "Studi") (7/12 14 = 15 "Nicht Erwerbst") (13=4 "Azubi, Wehrdienst"), gen(erwerbst)
recode hp_besch (99=.a) (3=1 "Vollzeit") (2 6=2 "Teilzeit") (5 7/12 14 = 4 "Nicht Erwerbst") (13 4=3 "Azubi, Wehrdienst"), gen(erwerb4)

* Haushaltsgröße, Einkommen und persönlichen Äquivalenzeinkommen
recode h02 (98/99 = .a)
gen anz_pers = 1 + (hhgr14*.3) + (h02-hhgr14-1)*.5
recode hheink (79/99=.a)
recode hheink (1=300) (2=500) (3=900) (4=1500) (5=2000) (6=2600) (7=3000) (8=3600) (9=4000) (10=4600) (11=5000) (12=5600) (13=6000) (14=6600) (15=7000), gen(inc_u)
recode hheink (1=500) (2=900) (3=1500) (4=2000) (5=2600) (6=3000) (7=3600) (8=4000) (9=4600) (10=5000) (11=5600) (12=6000) (13=6600) (14=7000) (15=10000), gen(inc_o)
gen hhinc = inc_u + runiform()*(inc_o-inc_u)
drop inc_u inc_o
gen pinc = hhinc / anz_pers

* räumliche Variablen
recode  p052 p054 p0411_4 (7/99=.a) (102/109=.b)

rename p0411_4 err_shops
rename p052 entf_station

logit fhs i.agegrp#female pinc i.erwerbst i.polgk i.entf_station err_shops[iw=p_gew], nocons
outreg2 using $elan_params\verkehrsmodell\fhs\fhs_2008.txt, bdec(5) tdec(5) noparen noaster replace

logit fhs i.agegrp#female pinc i.erwerb4 i.polgk i.entf_station err_shops[iw=p_gew], nocons
outreg2 using $elan_params\verkehrsmodell\fhs\fhs_2008_erwerb4.txt, bdec(5) tdec(5) noparen noaster replace

logit fhs i.agegrp#female pinc i.erwerb4 i.polgk [iw=p_gew], nocons
outreg2 using $elan_params\verkehrsmodell\fhs\fhs_2008_erwerb4_ohne_err.txt, bdec(5) tdec(5) noparen noaster replace



use "$MiD\D\2008\Daten\STATA\STATA_Public Use File\MiD2008_PUF_Haushalte.dta", clear

recode h04_3 (0=0 "KeinPkw") (1=1 "EinPkw") (2=2 "ZweiPkw") (4/20=3 "DreiMehrPkw") (97/99=.a), gen(hh_pkw)
recode h04_2 (4/20=3 "Drei und Mehr") (97/99=.a), gen(hh_mofas)
recode h04_1 (4/20=3 "Drei und Mehr") (97/99=.a), gen(hh_bikes)
recode hheink (79/99=.a)
recode hheink (1=300) (2=500) (3=900) (4=1500) (5=2000) (6=2600) (7=3000) (8=3600) (9=4000) (10=4600) (11=5000) (12=5600) (13=6000) (14=6600) (15=7000), gen(inc_u)
recode hheink (1=500) (2=900) (3=1500) (4=2000) (5=2600) (6=3000) (7=3600) (8=4000) (9=4600) (10=5000) (11=5600) (12=6000) (13=6600) (14=7000) (15=10000), gen(inc_o)
gen hhinc = inc_u + runiform()*(inc_o-inc_u)
drop inc_u inc_o
gen hhincln = ln(hhinc)
recode h02 (98/99 = .a)
gen anz_pers = 1 + (hhgr14*.3) + (h02-hhgr14-1)*.5
gen pinc = hhinc / anz_pers
gen pincln = ln(pinc)

// Resteinkommen = HH-Netto - Grundbedarf (abhängig von der Zahl der Personen im Haushalt)
gen grundbedarf = anz_pers*250
gen rinc = hhinc - grundbedarf
replace rinc = 100 if rinc < 100
gen rincln = ln(rinc)

recode hppkwfs* (7/9=.b) (1=1) (2=0) (100/300 = 0)
egen anz_fhs = rowtotal(hppkwfs*)
recode anz_fhs (4/8 = 3)
recode hpalter* (120/999 = .b)
recode hpbesch* (1 2 = 1 ) (3/14=0)  (97/300 = 0)
egen anz_erwerbst = rowtotal(hpbesch*)
recode anz_erwerbst (4/6 = 3)

replace hh_pkw = 1 if anz_fhs==0 & hh_pkw > 1
replace hh_pkw = 1 if anz_fhs==3 & hh_pkw ==0
replace hh_pkw = 1 if anz_erwerbst==3 & hh_pkw ==0

constraint define 1 [2]: 0.anz_fhs = -20
constraint define 2 [Drei_und_Mehr]: 0.anz_fhs = -20
constraint define 3 [0]: 3.anz_fhs = -20
constraint define 4 [0]: 3.anz_erwerbst = -20

// mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk westost hhinc hhincln  [iw=hh_gew], noconst constr(1 2 3 4)
// mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk westost pinc pincln  [iw=hh_gew], noconst constr(1 2 3 4)
mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk rinc rincln  [iw=hh_gew], noconst constr(1 2 3 4)
outreg2 using $elan_params\verkehrsmodell\pkw\pkw_2008_ohne_err.txt, bdec(5) tdec(5) noparen noaster replace
