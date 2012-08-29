clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_attr_ek.dta", clear


gen mittlEink = 400 if hheink_imp==1
replace mittlEink = 750 if hheink_imp==2
replace mittlEink = 1200 if hheink_imp==3
replace mittlEink = 1750 if hheink_imp==4
replace mittlEink = 2300 if hheink_imp==5
replace mittlEink = 2800 if hheink_imp==6
replace mittlEink = 3300 if hheink_imp==7
replace mittlEink = 3800 if hheink_imp==8
replace mittlEink = 4300 if hheink_imp==9
replace mittlEink = 4800 if hheink_imp==10
replace mittlEink = 5300 if hheink_imp==11
replace mittlEink = 5800 if hheink_imp==12
replace mittlEink = 6300 if hheink_imp==13
replace mittlEink = 6800 if hheink_imp==14
replace mittlEink = 8000 if hheink_imp==15
replace mittlEink = .a if hheink_imp>20

label define mittlEink .a `"keine Angabe"', modify
label value mittlEink mittlEink
label var mittlEink "durchschnittliches Haushaltsnettoeinkommen, Mittelwert der Einkommensklassen"

gen aeqEink = mittlEink/HHGR_gew 

label var aeqEink "Äquivalenzeinkommen"

gen OEK_STAT_neu = OEK_STAT if HHEINK<20
label var OEK_STAT_neu "ökonomischer Status des HH in 4 Stufen" 
label value OEK_STAT_neu OEK_STAT

replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & HHGR_gew==1 & hheink_imp==1
replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & HHGR_gew==1 & hheink_imp==2
replace OEK_STAT_neu=3 if  missing(OEK_STAT_neu) & HHGR_gew==1 & hheink_imp==3
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & HHGR_gew==1 & (hheink_imp==4 | hheink_imp==5)
replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & HHGR_gew==1 & hheink_imp>5 & hheink_imp<20

replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & hheink_imp==1
replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & hheink_imp==2 & HHGR_gew>1 & HHGR_gew<10
replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & hheink_imp==3 & HHGR_gew>1.3 & HHGR_gew<10
replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & hheink_imp==4 & HHGR_gew>2.2 & HHGR_gew<10
replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & hheink_imp==5 & HHGR_gew>2.9 & HHGR_gew<10
replace OEK_STAT_neu=1 if  missing(OEK_STAT_neu) & hheink_imp==5 & HHGR_gew>3.4 & HHGR_gew<10

replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & hheink_imp==14 | hheink_imp==15
replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & hheink_imp==13 & HHGR_gew>1 & HHGR_gew<2.8
replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & hheink_imp==12 & HHGR_gew>1 & HHGR_gew<2.5
replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & (hheink_imp==11 | hheink_imp==10)  & HHGR_gew>1 & HHGR_gew<2.3
replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & hheink_imp==9 & HHGR_gew>1 & HHGR_gew<2
replace OEK_STAT_neu=5 if  missing(OEK_STAT_neu) & hheink_imp==8 & HHGR_gew==1.3

replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==13 & HHGR_gew>2.7 & HHGR_gew<10
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==12 & HHGR_gew>2.4 & HHGR_gew<10
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & (hheink_imp==11 | hheink_imp==10) & HHGR_gew==2.3
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==9 & HHGR_gew>1.9 & HHGR_gew<3
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==8 & HHGR_gew>1.3 & HHGR_gew<2.7
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==7 & HHGR_gew>1 & HHGR_gew<2.3
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==6 & HHGR_gew>1 & HHGR_gew<2
replace OEK_STAT_neu=4 if  missing(OEK_STAT_neu) & hheink_imp==5 & HHGR_gew==1.3

replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & hheink_imp==8 & HHGR_gew>3.4 & HHGR_gew<10
replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & hheink_imp==7 & HHGR_gew>2.9 & HHGR_gew<10
replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & hheink_imp==6 & HHGR_gew>2.4 & HHGR_gew<3.5
replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & hheink_imp==5 & HHGR_gew>2.2 & HHGR_gew<3
replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & hheink_imp==4 & HHGR_gew>1.5 & HHGR_gew<2.3
replace OEK_STAT_neu=2 if  missing(OEK_STAT_neu) & hheink_imp==3 & HHGR_gew==1.3

replace OEK_STAT_neu =3 if missing(OEK_STAT_neu) & HHGR_gew<10 & hheink_imp<20

tab OEK_STAT_neu, gen(OEK_STAT_)

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_attr2.dta", replace

