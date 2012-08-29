clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_wegattr.dta", clear

* gen einkauf= Zweck==3 | Zweck==4 | Zweck==14
* gen einkauf_per = Zweck==3

* drop Anz_Arbeit Anz_zurArbeit

* egen Anz_Arbeit= total(Zweck==2|W01 ==2)
* egen Anz_zurArbeit= total(Zweck==2)
* egen Anz_Eink_per = total(Zweck==3)
* egen Anz_Eink_aper = total(Zweck==4)
* egen Anz_Eink_b = total(Zweck==14)
* gen Anz_Eink = Anz_Eink_per+Anz_Eink_aper+Anz_Eink_b
* egen Anz_Bilden = total(Zweck==5)
* egen Anz_KiGa = total(Zweck==6)
* egen Anz_Begl = total(Zweck==10)

replace HPP_BESCH=5 if (HPP_BESCH<5 |HPP_BESCH==12)& HP_ALTER<=15
replace HPP_BESCH=5 if HPP_BESCH==14 & (HP_ALTER>5 & HP_ALTER<=15)
replace HPP_BESCH=5 if HPP_BESCH==12 & HP_ALTER<=20
replace HPP_BESCH=4 if HPP_BESCH<4 & HP_ALTER<=18
replace HPP_BESCH=8 if HP_ALTER<6 & (HPP_BESCH==5 | HPP_BESCH==14)
replace HPP_BESCH=4 if HP_ALTER>23 & HP_ALTER<42 & HPP_BESCH==5
replace HPP_BESCH=14 if HP_ALTER>42 & (HPP_BESCH == 4 | HPP_BESCH==5)

gen BerufVoll= HPP_BESCH ==1 
gen BerufTeil= HPP_BESCH ==2 | HPP_BESCH ==3 | HPP_BESCH ==14
* gen arbeitt= (Zweck==2|W01 ==2|Zweck==14)
* gen az = sum(arbeitt*akt_dauer)
* gen arbeitszeit = az[_N]
replace BerufVoll = 1 if BerufVoll ==0 & BerufTeil==0 & (Anz_Arbeit>0) & arbeitszeit>239 &exclude==0
replace BerufTeil = 1 if BerufVoll ==0 & BerufTeil==0 & (Anz_Arbeit>0) & arbeitszeit<240 &exclude==0
* drop az

gen soNErwerb = HPP_BESCH >6 & HPP_BESCH <12 & Anz_Arbeit==0 & BerufVoll==0 & BerufTeil==0
* Unterschiede bei Art der Kinderbetreuung, aber zu geringe Fallzahlen für MRH
gen Student= HPP_BESCH==6
gen Azubi= HPP_BESCH==4 & HP_ALTER>14
gen OSchüler = HPP_BESCH==5 & HP_ALTER>9
gen GSchüler = HPP_BESCH==5 & HP_ALTER<10
gen Kleinkind = HP_ALTER<7 & HPP_BESCH!=5
gen Rentner = HPP_BESCH == 12 | HP_ALTER>64
gen HH_Kind6 =  HHGR06 >0
gen HH_Kind14 =  HHGR14 >0
gen HH_Kind18 =  HHGR18 >0
gen HH_oKind =  HHGR18==0 & HHGR14==0 & HHGR06==0

* tab POLGK, gen (POLGK_)

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


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_wegattr2.dta", replace
* tab OEK_STAT, gen (OEK_STAT_)
* Unterteilung des ökonomischen Status einer Person in einem HH






* Unterteilung der Anzahl der HH-Mitglieder über die gewichtete Anzahl der HH-Mitglieder

* bysort HHID: gen HHTYP2 = 1 if HPP_BESCH>3 & HPP_BESCH!=14 & HPP_BESCH<100
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







