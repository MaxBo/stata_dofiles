use "$MiD\D\2008\Daten\STATA\STATA_Public Use File\MiD2008_PUF_Personen.dta", clear
recode hp_pkwfs (7/9=.b) (1=1 "ja") (2=0 "Nein"), gen(fhs)
recode hp_alter (994/999 = .b)
egen agegrp = cut(hp_alter), at(0 17 18 19 20 21 22 23 24 25 30 35 40 45 50 55 60 65 70 75 80 85 90 105)
recode hp_sex (9=.b) (1=0 "Mann") (2=1 "Frau"), gen(female)
recode hp_besch (99=.a) (3=1 "Vollzeit") (2=2 "Teilzeit") (5=5 "Sch�ler") (6=6 "Studi") (7/12 14 = 15 "Nicht Erwerbst") (13=4 "Azubi, Wehrdienst"), gen(erwerbst)
recode hp_besch (99=.a) (3=1 "Vollzeit") (2 6=2 "Teilzeit") (5 7/12 14 = 4 "Nicht Erwerbst") (13 4=3 "Azubi, Wehrdienst"), gen(erwerb4)

* Haushaltsgr��e, Einkommen und pers�nlichen �quivalenzeinkommen
recode h02 (98/99 = .a)
gen anz_pers = 1 + (hhgr14*.3) + (h02-hhgr14-1)*.5
recode hheink (79/99=.a)
recode hheink (1=300) (2=500) (3=900) (4=1500) (5=2000) (6=2600) (7=3000) (8=3600) (9=4000) (10=4600) (11=5000) (12=5600) (13=6000) (14=6600) (15=7000), gen(inc_u)
recode hheink (1=500) (2=900) (3=1500) (4=2000) (5=2600) (6=3000) (7=3600) (8=4000) (9=4600) (10=5000) (11=5600) (12=6000) (13=6600) (14=7000) (15=10000), gen(inc_o)
gen hhinc = inc_u + runiform()*(inc_o-inc_u)
drop inc_u inc_o
gen pinc = hhinc / anz_pers

* r�umliche Variablen
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

// Resteinkommen = HH-Netto - Grundbedarf (abh�ngig von der Zahl der Personen im Haushalt)
gen grundbedarf = anz_pers*250
gen rinc = hhinc - grundbedarf

gen rinc1600 = rinc + 1600

replace rinc = 100 if rinc < 100
gen rincln = ln(rinc)

recode hppkwfs* (7/9=.b) (1=1) (2=0) (100/300 = 0)
egen anz_fhs = rowtotal(hppkwfs*)
recode anz_fhs (4/8 = 3)
recode hpalter* (120/3000 = .b)
recode hpbesch* (1 2 = 1 ) (3/14=0)  (97/300 = 0)
egen anz_erwerbst = rowtotal(hpbesch*)
recode anz_erwerbst (4/6 = 3)
egen alter_hhvorstand = rowmax(hpalter*)
egen alterskl = cut(alter_hhvorstand), at(17 25 30 40 50 60 70 80 110)

replace hh_pkw = 1 if anz_fhs==0 & hh_pkw > 1
replace hh_pkw = 1 if anz_fhs==3 & hh_pkw ==0
replace hh_pkw = 1 if anz_erwerbst==3 & hh_pkw ==0

/*
constraint define 1 [ZweiPkw]: 0.anz_fhs = -20
constraint define 2 [DreiMehrPkw]: 0.anz_fhs = -20
constraint define 3 [KeinPkw]: 3.anz_fhs = -20
constraint define 4 [KeinPkw]: 3.anz_erwerbst = -20



// mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk westost hhinc hhincln  [iw=hh_gew], noconst constr(1 2 3 4)
// mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk westost pinc pincln  [iw=hh_gew], noconst constr(1 2 3 4)
mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk rinc rincln  [iw=hh_gew], noconst constr(1 2 3 4)
outreg2 using $elan_params\verkehrsmodell\pkw\pkw_2008_ohne_err.txt, bdec(5) tdec(5) noparen noaster replace
*/
expand 4
bysort hhid: gen altnum = _n - 1
gen choice = altnum == hh_pkw
gen byte sample = 1
gen KeinPkw = altnum==0
gen EinPkw = altnum==1
gen ZweiPkw = altnum==2
gen DreiPkw = altnum==3

gen fhs0_0Pkw = (anz_fhs == 0) & KeinPkw
gen fhs1_0Pkw = (anz_fhs == 1) & KeinPkw
gen fhs2_0Pkw = (anz_fhs == 2) & KeinPkw
replace sample = 0 if (anz_fhs == 3) & KeinPkw

replace sample = 0 if (anz_fhs == 0) & ZweiPkw
gen fhs1_2Pkw = (anz_fhs == 1) & ZweiPkw
gen fhs2_2Pkw = (anz_fhs == 2) & ZweiPkw
gen fhs3_2Pkw = (anz_fhs == 3) & ZweiPkw

replace sample = 0 if (anz_fhs == 0) & DreiPkw
gen fhs1_3Pkw = (anz_fhs == 1) & DreiPkw
gen fhs2_3Pkw = (anz_fhs == 2) & DreiPkw
gen fhs3_3Pkw = (anz_fhs == 3) & DreiPkw

gen erwerb0_0Pkw = (anz_erwerbst == 0) & KeinPkw
gen erwerb2_0Pkw = (anz_erwerbst == 2) & KeinPkw
replace sample = 0 if (anz_erwerbst == 3) & KeinPkw

gen erwerb0_2Pkw = (anz_erwerbst == 0) & ZweiPkw
gen erwerb2_2Pkw = (anz_erwerbst == 2) & ZweiPkw
gen erwerb3_2Pkw = (anz_erwerbst == 3) & ZweiPkw

gen erwerb0_3Pkw = (anz_erwerbst == 0) & DreiPkw
gen erwerb2_3Pkw = (anz_erwerbst == 2) & DreiPkw
gen erwerb3_3Pkw = (anz_erwerbst == 3) & DreiPkw

gen alterskl_0Pkw = alterskl *KeinPkw
gen alterskl_2Pkw = alterskl *ZweiPkw
gen alterskl_3Pkw = alterskl *DreiPkw

gen polgk_0 = polgk*KeinPkw
gen polgk_2= polgk*ZweiPkw
gen polgk_3 = polgk*DreiPkw

local fixkosten 125
replace rinc1600 = rinc1600 - `fixkosten' if EinPkw
replace rinc1600 = rinc1600 - 2*`fixkosten' if ZweiPkw
replace rinc1600 = rinc1600 - 3*`fixkosten' if DreiPkw

gen rinc1600ln = ln(rinc1600)
gen rinc1000ln = ln(rinc1600 - 600)
gen rinc2600ln = ln(rinc1600 +1000)
gen rinc3000ln = ln(rinc1600 +1400)
gen rinc4000ln = ln(rinc1600 +1400)
gen rinc2000ln = ln(rinc1600 +400)
gen rinc600 = rinc1600 - 1000
replace rinc600 = 50 if rinc600 < 50 
gen rinc600ln = ln(rinc600)

clogit choice i.rinc_cut fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc1600ln fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc1000ln fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc2000ln fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc600ln fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc2600ln fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc3000ln fhs?_* erwerb?_* i.polgk_? i.alterskl_* if sample, group(hhid)
outreg2 using $elan_params\verkehrsmodell\pkw\pkw_2008_rinc_clogit_ohne_err.txt, bdec(5) tdec(5) noparen noaster replace
clogit choice rinc3000ln fhs?_* i.polgk_? if sample, group(hhid)
outreg2 using $elan_params\verkehrsmodell\pkw\pkw_2008_rinc_clogit_ohne_err_ohne_erwerbst.txt, bdec(5) tdec(5) noparen noaster replace

clogit choice rinc4000ln fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)
clogit choice rinc2600ln rinc600 fhs?_* erwerb?_* i.polgk_? if sample, group(hhid)

mlogit hh_pkw ibn.anz_fhs ib1.anz_erwerbst ib4.polgk rinc1600ln_?  [iw=hh_gew], noconst constr(1 2 3 4 10/24) collinear base(1)
outreg2 using $elan_params\verkehrsmodell\pkw\pkw_2008_rinc1600_ohne_err.txt, bdec(5) tdec(5) noparen noaster replace

corr rinc1600ln_?
