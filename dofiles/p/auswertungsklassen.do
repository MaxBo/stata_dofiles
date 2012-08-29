clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_10_test.dta", clear

gen einkauf= Zweck==3 | Zweck==4 | Zweck==14
gen einkauf_per = Zweck==3

bysort HHID PID: egen Anz_Arbeit= total(Zweck==2|W01 ==2)
bysort HHID PID: egen Anz_zurArbeit= total(Zweck==2)
bysort HHID PID: egen Anz_Eink_per = total(Zweck==3)
bysort HHID PID: egen Anz_Eink_aper = total(Zweck==4)
bysort HHID PID: egen Anz_Eink_b = total(Zweck==14)
bysort HHID PID: gen Anz_Eink = Anz_Eink_per+Anz_Eink_aper+Anz_Eink_b
bysort HHID PID: egen Anz_Bilden = total(Zweck==5)
bysort HHID PID: egen Anz_KiGa = total(Zweck==6)
bysort HHID PID: egen Anz_Begl = total(Zweck==10)


bysort HHID PID: gen BerufVoll= HP_BESCH ==1 
bysort HHID PID: gen BerufTeil= HP_BESCH ==2 | HP_BESCH ==3 | HP_BESCH ==14
bysort HHID PID: gen arbeitt= (Zweck==2|W01 ==2|Zweck==14)
bysort HHID PID: gen az = sum(arbeitt*akt_dauer)
bysort HHID PID: gen arbeitszeit = az[_N]
bysort HHID PID: replace BerufVoll = 1 if BerufVoll ==0 & BerufTeil==0 & (Anz_Arbeit>0) & arbeitszeit>239
bysort HHID PID: replace BerufTeil = 1 if BerufVoll ==0 & BerufTeil==0 & (Anz_Arbeit>0) & arbeitszeit<240
drop az

bysort HHID PID: gen soNErwerb = HP_BESCH >6 & HP_BESCH <12 & Anz_Arbeit==0 & BerufVoll==0 & BerufTeil==0
* Unterschiede bei Art der Kinderbetreuung, aber zu geringe Fallzahlen für MRH
bysort HHID PID: gen Student= HP_BESCH==6
bysort HHID PID: gen Azubi= HP_BESCH==4
bysort HHID PID: gen OSchüler = HP_BESCH==5 & HP_ALTER>9
bysort HHID PID: gen GSchüler = HP_BESCH==5 & HP_ALTER<10
bysort HHID PID: gen Kleinkind = HP_ALTER<7 & HP_BESCH!=5
bysort HHID PID: gen Rentner = HP_BESCH == 12 | HP_ALTER>64
bysort HHID PID: gen HH_Kind6 =  HHGR06 >0
bysort HHID PID: gen HH_Kind14 =  HHGR14 >0
bysort HHID PID: gen HH_Kind18 =  HHGR18 >0
bysort HHID PID: gen HH_oKind =  HHGR18==0 & HHGR14==0 & HHGR06==0

tab POLGK, gen (POLGK_)

gen BerufVollW = (BerufVoll==1 & HP_SEX==2)
replace BerufVollW= .a if missing(HP_SEX)
gen BerufVollM = (BerufVoll==1 & HP_SEX==1)
replace BerufVollM= .a if missing(HP_SEX)

gen BerufTeilM = (BerufTeil==1 & HP_SEX==1)
gen BerufTeilW = (BerufTeil==1 & HP_SEX==2)
replace BerufTeilW= .a if missing(HP_SEX)
replace BerufTeilM= .a if missing(HP_SEX)

gen NErwerb = ( soNErwerb==1 |  Rentner==1) & Anz_Arbeit==0

gen NErwerbW = (NErwerb==1 & HP_SEX==2)
gen NErwerbM = (NErwerb==1 & HP_SEX==1)
replace NErwerbW= .a if missing(HP_SEX)
replace NErwerbM= .a if missing(HP_SEX)


gen StudentW = (Student==1 & HP_SEX==2)
gen StudentM = (Student==1 & HP_SEX==1)
replace StudentW= .a if missing(HP_SEX)
replace StudentM= .a if missing(HP_SEX)

gen AzubiW = (Azubi==1 & HP_SEX==2)
gen AzubiM = (Azubi==1 & HP_SEX==1)
replace AzubiW= .a if missing(HP_SEX)
replace AzubiM= .a if missing(HP_SEX)

gen OSchülerW = (OSchüler==1 & HP_SEX==2)
gen OSchülerM = (OSchüler==1 & HP_SEX==1)
replace OSchülerW= .a if missing(HP_SEX)
replace OSchülerM= .a if missing(HP_SEX)


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_10_test.dta", replace
* tab OEK_STAT, gen (OEK_STAT_)
* Unterteilung des ökonomischen Status einer Person in einem HH






* Unterteilung der Anzahl der HH-Mitglieder über die gewichtete Anzahl der HH-Mitglieder

* bysort HHID: gen HHTYP2 = 1 if HP_BESCH>3 & HP_BESCH!=14 & HP_BESCH<100
* bysort HHID: replace HHTYP2 = 2 if tab 


* label define HHTYP2 1 `"Haushalt ohne Arbeiter"', modify
* label define HHTYP2 2 `"Haushalt ohne Arbeiter"', modify
* label define HHTYP2 3 `"Haushalt ohne Arbeiter"', modify
* label define HHTYP2 4 `"Haushalt ohne Arbeiter"', modify





* Alleinerziehend = HHGR_gew==1.3 |HHGR_gew==1.6 | HHGR_gew==1.9
* Partnerschaft ohne Kinder = HHGR_gew==1.5
* Familie mit Kleinkinderen = HHGR_gew==1.8 | HHGR_gew==2.1 |  HHGR_gew==2.4 | HHGR_gew==2.7
* Familie mit nur alten Kindern  = HHGR_gew == 2 | HHGR_gew==2.5 | (HHGR_gew==3 & HHGR14==0) | HHGR_gew==3.5
* Familie mit alten und jungen Kindern = HHGR_gew == HHGR_gew==3







