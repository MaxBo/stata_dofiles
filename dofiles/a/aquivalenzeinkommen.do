clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_9_2.dta", clear

gen HHGRue14 = H02-HHGR14
gen HHGR_gew = 1 + (HHGRue14 - 1)*0.5 + HHGR14*0.3 if HHGRue14>0

gen mittlEink = 400 if HHEINK==1
replace mittlEink = 750 if HHEINK==2
replace mittlEink = 1200 if HHEINK==3
replace mittlEink = 1750 if HHEINK==4
replace mittlEink = 2300 if HHEINK==5
replace mittlEink = 2800 if HHEINK==6
replace mittlEink = 3300 if HHEINK==7
replace mittlEink = 3800 if HHEINK==8
replace mittlEink = 4300 if HHEINK==9
replace mittlEink = 4800 if HHEINK==10
replace mittlEink = 5300 if HHEINK==11
replace mittlEink = 5800 if HHEINK==12
replace mittlEink = 6300 if HHEINK==13
replace mittlEink = 6800 if HHEINK==14
replace mittlEink = 8000 if HHEINK==15
replace mittlEink = .a if HHEINK>20

label define mittlEink .a `"keine Angabe"', modify
label value mittlEink mittlEink
label var mittlEink "durchschnittliches Haushaltsnettoeinkommen, Mittelwert der Einkommensklassen"

gen aeqEink = mittlEink/HHGR_gew 

label var aeqEink "Äquivalenzeinkommen"

replace OEK_STAT =3 if STICH_J == 2006 & HHGR_gew<10 & HHEINK<20

replace OEK_STAT=1 if  STICH_J==2006 & HHGR_gew==1 & HHEINK==1
replace OEK_STAT=2 if  STICH_J==2006 & HHGR_gew==1 & HHEINK==2
replace OEK_STAT=3 if  STICH_J==2006 & HHGR_gew==1 & HHEINK==3
replace OEK_STAT=4 if  STICH_J==2006 & HHGR_gew==1 & (HHEINK==4 | HHEINK==5)
replace OEK_STAT=5 if  STICH_J==2006 & HHGR_gew==1 & HHEINK>5 & HHEINK<20

replace OEK_STAT=1 if  STICH_J==2006 & HHEINK==1
replace OEK_STAT=1 if  STICH_J==2006 & HHEINK==2 & HHGR_gew>1 & HHGR_gew<10
replace OEK_STAT=1 if  STICH_J==2006 & HHEINK==3 & HHGR_gew>1.3 & HHGR_gew<10
replace OEK_STAT=1 if  STICH_J==2006 & HHEINK==4 & HHGR_gew>2.2 & HHGR_gew<10
replace OEK_STAT=1 if  STICH_J==2006 & HHEINK==5 & HHGR_gew>2.9 & HHGR_gew<10
replace OEK_STAT=1 if  STICH_J==2006 & HHEINK==5 & HHGR_gew>3.4 & HHGR_gew<10

replace OEK_STAT=5 if  STICH_J==2006 & HHEINK==14 | HHEINK==15
replace OEK_STAT=5 if  STICH_J==2006 & HHEINK==13 & HHGR_gew>1 & HHGR_gew<2.8
replace OEK_STAT=5 if  STICH_J==2006 & HHEINK==12 & HHGR_gew>1 & HHGR_gew<2.5
replace OEK_STAT=5 if  STICH_J==2006 & (HHEINK==11 | HHEINK==10)  & HHGR_gew>1 & HHGR_gew<2.3
replace OEK_STAT=5 if  STICH_J==2006 & HHEINK==9 & HHGR_gew>1 & HHGR_gew<2
replace OEK_STAT=5 if  STICH_J==2006 & HHEINK==8 & HHGR_gew==1.3

replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==13 & HHGR_gew>2.7 & HHGR_gew<10
replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==12 & HHGR_gew>2.4 & HHGR_gew<10
replace OEK_STAT=4 if  STICH_J==2006 & (HHEINK==11 | HHEINK==10) & HHGR_gew==2.3
replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==9 & HHGR_gew>1.9 & HHGR_gew<3
replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==8 & HHGR_gew>1.3 & HHGR_gew<2.7
replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==7 & HHGR_gew>1 & HHGR_gew<2.3
replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==6 & HHGR_gew>1 & HHGR_gew<2
replace OEK_STAT=4 if  STICH_J==2006 & HHEINK==5 & HHGR_gew==1.3

replace OEK_STAT=2 if  STICH_J==2006 & HHEINK==8 & HHGR_gew>3.4 & HHGR_gew<10
replace OEK_STAT=2 if  STICH_J==2006 & HHEINK==7 & HHGR_gew>2.9 & HHGR_gew<10
replace OEK_STAT=2 if  STICH_J==2006 & HHEINK==6 & HHGR_gew>2.4 & HHGR_gew<3.5
replace OEK_STAT=2 if  STICH_J==2006 & HHEINK==5 & HHGR_gew>2.2 & HHGR_gew<3
replace OEK_STAT=2 if  STICH_J==2006 & HHEINK==4 & HHGR_gew>1.5 & HHGR_gew<2.3
replace OEK_STAT=2 if  STICH_J==2006 & HHEINK==3 & HHGR_gew==1.3





