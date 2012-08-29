set more off

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Reiseanalyse\RA_00_03_05_08.dta", clear

label define jn 1 "ja" 0 "nein", modify

* Berechnung Anzahl Reisen
* Reisen vor 3 Jahren: 1997, 2000, 2002, 2005
gen r3jahre = f2a if  (Jahr==2000 | Jahr==2003)
replace r3jahre = fc11 if Jahr==2005 
replace r3jahre = fc7 if Jahr==2008 
recode r3jahre (4=0) (5=.a)
label define r2jahre 0 "keine Reise" 1 "eine Reise" 2 "2 Reisen" 3 "3 und mehr Reisen" .a "keine Angabe", modify
label value r3jahre r2jahre
label var r3jahre "Reisehäufigkeit vor 3 Jahren"

* Reisen vor 2 Jahren: 1998, 2001, 2003, 2006
gen r2jahre = f2c if  Jahr==2000 
replace r2jahre = f3a if Jahr==2003
replace r2jahre = fc12 if Jahr==2005 
replace r2jahre = fc6 if Jahr==2008 
recode r2jahre (4=0) (5=.a)
label value r2jahre r2jahre
label var r2jahre "Reisehäufigkeit vor zwei Jahren"

* Ziel HUR vor 2 und 3 Jahren
gen r3_hur = f2b if Jahr==2000 | Jahr == 2003
label var r3_hur "Reiseziel HUR vor 3 Jahren"
gen r2_hur = f2d if Jahr==2000
replace r2_hur = f3b if Jahr==2003
label var r2_hur "Reiseziel HUR vor 2 Jahren"

* Reisen Vorjahr: 1999, 2002, 2005, 2008
* Urlaub im Vorjahr
gen url = f3 if Jahr ==2000
replace url = f4a if Jahr==2003
label var url "Urlaubsreise im Vorjahr"
recode url (2=0)
label value url jn

* Urlaubsreisen im Vorjahr
gen r_url = f4 if Jahr ==2000
replace r_url = f4b if Jahr==2003
replace r_url = f01a_1 if Jahr==2005
replace r_url = f1a if Jahr ==2008
label var r_url "Urlaubsreise im Vorjahr"
recode r_url (2=0)
label value r_url jn

* Anzahl Urlaubsreisen im Vorjahr
gen r_anzurl = f01a_2 if Jahr==2005
replace r_anzurl = f1a_1 if Jahr==2008
label var r_anzurl "Anzahl Urlaubsreisen im Vorjahr"

* Kurzurlaub und sonstige Reisen
* Anzahl Kurzurlaube im Vorjahr
gen r_anzkurl = f38a if Jahr==2003 | Jahr==2008
replace r_anzkurl = f01b_2 if Jahr==2005
replace r_anzkurl = f19a if Jahr==2000
label var r_anzkurl "Anzahl Kurzurlaubsreisen im Vorjahr"

* Kurzurlaub im Vorjahr
gen r_kurl = f01b_1 if Jahr==2005
replace r_kurl = f19a if Jahr==2008
replace r_kurl = f19 if Jahr==2000
replace r_kurl = f38 if Jahr==2003
label var r_kurl "Kurzurlaub im Vorjahr"
recode r_kurl (2=0)
label value r_kurl jn

gen r_sonst = f01d_1 if Jahr ==2005
replace r_sonst = f1d if Jahr ==2008
recode r_sonst (2=0)
label var r_sonst "sonst. Reisen im Vorjahr"
label value r_sonst jn

gen r_anzsonst = f01d_2 if Jahr==2005
replace r_anzsonst = f1d_1 if Jahr==2008
label var r_anzsonst "Anz. sonst. Reisen im Vorjahr"

recode r_anz* (.=0)

gen r_anzges= r_anzkurl + r_anzurl
replace r_anzges = r_anzges + r_anzsonst if Jahr>2004
* Widerspruch zu r_anzahl!!!

gen r_anz = r_anzges if r_anzges>r_anzahl
replace r_anz = r_anzahl if r_anzges <= r_anzahl
label var r_anz "Anzahl Reisen (bereinigt)"


* Eigenschaften der Kurzurlaubsreise
* drop r_kurlt* r_kurlv*
gen r_kurltyp_1 = 1 if (f21_01==1 | f39_01==1 | f20x01==1)
label var r_kurltyp_1 "Kurzurlaub: Städtereise"
gen r_kurltyp_2 = 1 if (f20x02==1 |f39_02==1 | f39_16==1 | f21_04==1 | f21_07==1| f21_08==1) & Jahr!=2008
replace r_kurltyp_2 = 1 if Jahr==2008 & (f21_05==1 | f21_08==1)
label var r_kurltyp_2 "Kurzurlaub: Sportreise"
gen r_kurltyp_3 = 1 if (f21_02==1 | f20x03==1 | f20x06==1 | f39_03==1 | f39_07==1) & Jahr!=2008
replace r_kurltyp_3 = 1 if Jahr==2008 & (f21_02==1 | f21_03==1) 
label var r_kurltyp_3 "Kurzurlaub: Studien-/Kultur-/Bildungsreise"
gen r_kurltyp_4 = 1 if (f21_03==1 | f20x04==1 | f20x05==1 | f39_04==1 | f39_05==1 | f39_06==1) & Jahr!=2008
replace r_kurltyp_4 = 1 if f21_04==1 & Jahr==2008
label var r_kurltyp_4 "Kurzurlaub: Gesundheits-/Fitness-/Welnessreise"
gen r_kurltyp_5 = 1 if (f21_06==1 | f39_08==1 | f20x07==1) & Jahr!=2008
replace r_kurltyp_5 =1 if f21_07 ==1 & Jahr==2008
label var r_kurltyp_5 "Kurzurlaub: Verwandten-/Bekanntenbesuch"
gen r_kurltyp_6 = 1 if (f21_05==1 | f39_20==1) & Jahr!=2008
replace r_kurltyp_6 = 1 if f21_06==1 & Jahr==2008
label var r_kurltyp_6 "Kurzurlaub: Einkaufen"
gen r_kurltyp_7 = 1 if (f21_12==1 | f39_17==1 | f39_18==1) & Jahr!=2008
replace r_kurltyp_7 = 1 if f21_19==1 & Jahr==2008
label var r_kurltyp_7 "Kurzurlaub: Caravaningurlaub"
gen r_kurltyp_8 = 1 if (f21_10==1 | f21_11==1 | f39_15==1) & Jahr!=2008
replace r_kurltyp_8 = 1 if f21_18==1 & Jahr==2008
label var r_kurltyp_8 "Kurzurlaub: Freizeit-/Ferienparkaufenthalt"
gen r_kurltyp_9 = 1 if f21_09==1 | f39_19==1 
label var r_kurltyp_9 "Kurzurlaub: sonstige"


gen r_kurlvm_1 = 1 if (f21_14==1 | f20x08==1 | f39_09==1) & Jahr!=2008
replace r_kurlvm_1 =1 if Jahr==2008 & f21_11==1
label var r_kurlvm_1 "Kurzurlaub mit Bus"
gen r_kurlvm_2 = 1 if (f21_15==1 | f20x09==1 | f39_10==1) & Jahr!=2008
replace r_kurlvm_2 =1 if Jahr==2008 & f21_12==1
label var r_kurlvm_2 "Kurzurlaub mit Bahn"
gen r_kurlvm_3 = 1 if (f21_16==1 | f20x10==1 | f39_11==1 | f39_12==1) & Jahr!=2008
replace r_kurlvm_3 =1 if Jahr==2008 & f21_13==1
label var r_kurlvm_3 "Kurzurlaub mit Flugzeug"
gen r_kurlvm_4 = 1 if (f20x12==1 | f39_13==1) & Jahr!=2008
label var r_kurlvm_4 "Kurzurlaub mit Fahrrad"
gen r_kurlvm_5 = 1 if (f21_13==1 & Jahr==2005) | (f21_10==1 & Jahr==2008)
label var r_kurlvm_5 "Kurzurlaub mit Pkw"

gen r_kurlnacht_1 = 1 if (f21_19==1 & Jahr==2005) | (f21_20==1 & Jahr==2008)
label var r_kurlnacht_1 "Kurzurlaub: kostenlose Übernachtung"
gen r_kurlnacht_2 = 1 if (f21_20==1 & Jahr==2005) | (f21_17==1 & Jahr==2008)
label var r_kurlnacht_2 "Kurzurlaub: bezahlte Übernachtung"

recode r_kurlt*  (.=0)
recode r_kurlv* (.=0)
recode r_kurln* (.=0)
replace r_kurlvm_4 = . if Jahr==2005
replace r_kurlvm_5 = . if Jahr <2005

replace r_kurltyp_6=. if Jahr==2000
replace r_kurltyp_7=. if Jahr==2000
replace r_kurltyp_8=. if Jahr==2000
replace r_kurltyp_9=. if Jahr==2000

replace r_kurlnacht_1 = . if Jahr<2005
replace r_kurlnacht_2 = . if Jahr<2005

label value r_kurlt* jn
label value r_kurlv* jn
label value r_kurln* jn

drop f21_* f39_* f20x*

* ---------------------------- sozioök. Merkmale -------------
recode pol (1 2 = 1 "bis 5.000 EW") (3 4 = 2 "5.000 -49.999 EW") (5 = 3 "50.00 - 99.999 EW") (6=4 "100.000 -499.999 EW") (7=5 "500.000 EW u. mehr") if Jahr!=2008, gen (polgk)
replace polgk = pol if Jahr==2008

recode s11 (1=1 "<=500€") (2 3 = 2 "(500;750]€") (4 5 = 3 "(750;1000]€") (6 7 = 4 "(1000;1250]€") (8 9 = 5 "(1250;1500]€") (10=6 "(1500;1750]€") (11=7 "(1750;2000]€") /*
*/ (12 = 8 "(2000;2250]€") (13 = 9 "(2250;2500]€") (14=10 "(2500;3000]€") (15=11 "(3000;5000]€") (16=12 "5000€ u. mehr") if Jahr==2000, gen(hheink)
replace hheink = s11-1 if Jahr!=2000
recode hheink (0 1 = 1) (10 11 = 10) (12/14 = 11) (15=12) if Jahr!=2000

replace s10_5 = 1 if (s10_1==1 | s10_2==1) & Jahr!=2008

recode hheink (1/3= 1 "<=1000 €") (4/5=2 "(1000;1500]€") (6/7=3 "(1500;2000]€") (8/10=4 "(3000;4000]€") (11/12=5 "=> 4000 €"), gen(hheink_5)
recode s10_* (.=0) if Jahr!=2008
label value s10_* jn

gen hhtyp = 1 if s9a==1
replace hhtyp = 2 if s10_4==1 & s9a>1
replace hhtyp = 3 if s9a>1 & s10_4==0
label var hhtyp "Haushaltstyp (3 Kategorien)"
label define hhtyp 2 "Mehrpersonen-HH ohne Kinder" 1 "Einpersonen-HH" 3 "HH mit Kindern", modify
label value hhtyp hhtyp

gen s9c = s9a-s9b
label var s9c "Anzahl HH-Mitglieder unter 14 Jahren"


recode s7b (1=1 "Vollzeit berufstätig") (2 3=2 "Teilzeit berufstätig") (4 5 = 3 "ohne Arbeit") (6= 4 "Rente") (7=5 "Ausbildung"), gen(hhv_besch)
recode s7a (1=1 "Vollzeit berufstätig") (2 3=2 "Teilzeit berufstätig") (4 5 = 3 "ohne Arbeit") (6= 4 "Rente") (7=5 "Ausbildung"), gen(besch)
label var hhv_besch "Beschäftigung Haushaltsvorstand"
label var besch "Beschäftigung befragte Person"

recode fc03_* (.=0) if Jahr!=2008
label value fc03_* jn

* Berechnung Anzahl Urlaubsreisen
* nbreg r_anzurl ib3.hheink_5 s9a ib3.polgk ib2.hhtyp  [iw=weight] 

* Anpassungen an INVERMO

recode hheink (1 2=1 "bis 750" ) (3/5=2 "[750;1500]") (6/10=3 "[1500;3000]") (11 12=4 "über 3000"), gen(hheink_4)

replace f8b_2_75 = f8a_75 if Jahr==2008
replace f8b_2_76 = f8a_76 if Jahr==2008
replace f8b_2_74 = f8a_74 if Jahr==2008

drop f13 f19a fc11 fc12 f2a f4b f4a f38 f19 f3a f1a_num f38a f1d_num alt_num fc6 fc7 f4 p_3 p_1
drop f2c f2d f3
drop r01c1 r02c1 r03c1 r04c1 r05c1 r06c1 r07c1 r08c1 r09c1 r01g1 r02g1 r03g1 r04g1 r05g1 r06g1 r07g1 r08g1 r09g1 r01h1 r02h1 r03h1 r04h1 r05h1 r06h1 r07h1 r08h1 r09h1 r01h2 r02h2 r03h2 r04h2 r05h2 r06h2 r07h2 r08h2 r09h2 r01h3 r02h3 r03h3 r04h3 r05h3 r06h3 r07h3 r08h3 r09h3 r01k1 r02k1 r03k1 r04k1 r05k1 r06k1 r07k1 r08k1 r09k1 r01k2 r02k2 r03k2 r04k2 r05k2 r06k2 r07k2 r08k2 r09k2 
drop f01a_1 f01a_2 f01b_1 f01b_2 f01d_1 f01d_2
drop f1a f1a_1 f1b_1 f1d f1d_1 

gen pid = _n

replace f5l2_1 = R01l2

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Reiseanalyse\RA_00_03_05_08_ang.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Reiseanalyse\RA_00_03_05_08_ang.dta", clear


forvalues i=1/9 {
	rename f5l1_`i'01 f5l1_01_`i'
	rename f5l1_`i'02 f5l1_02_`i'
	rename f5l1_`i'03 f5l1_03_`i'
	rename f5l1_`i'04 f5l1_04_`i'
	rename f5l1_`i'05 f5l1_05_`i'
	rename f5l1_`i'06 f5l1_06_`i'
	rename f5l1_`i'07 f5l1_07_`i'
	rename f5l1_`i'08 f5l1_08_`i'
	rename f5l1_`i'09 f5l1_09_`i'
	rename f5l1_`i'10 f5l1_10_`i'
	rename f5l1_`i'11 f5l1_11_`i'
	rename f5l1_`i'12 f5l1_12_`i'
	rename f5l1_`i'13 f5l1_13_`i'
	rename f5l1_`i'14 f5l1_14_`i'
	rename r0`i'd_1 rd_1_`i'
	rename r0`i'd_2 rd_2_`i'
	rename r0`i'd_3 rd_3_`i'
	rename r0`i'd_4 rd_4_`i'
	rename r0`i'd_5 rd_5_`i'
	rename r0`i'd_6 rd_6_`i'
	rename r0`i'd_7 rd_7_`i'
}

forvalue i=1/7{
	rename r`i'f5b2 rf5b2_`i'
}

rename R01l1_15 rl_1_15_1

forvalues i=2/9{
	rename r0`i'l_1_15 r_1_15_`i'
	* rename r`i'f5m rf5m_`i'
	rename f5g0_`i'2 f5g0_`i'2
}

reshape long f5a_ f5b1_ f5b2_ f5c_ f5d_ f5e_ f5f_ f5g0_ f5g1_ f5g2_ f5h1_ f5h2_ f5h3_ f5h4_ f5k_ f5ka_   f5l2_ f5m_ /*
*/ f5l1_01_ f5l1_02_ f5l1_03_ f5l1_04_ f5l1_05_ f5l1_06_ f5l1_07_ f5l1_08_ f5l1_09_ f5l1_10_ f5l1_11_ f5l1_12_ f5l1_13_ f5l1_14_ /*
*/ rd_1_ rd_2_ rd_3_ rd_4_ rd_5_ rd_6_ rd_7_ r_1_15_ f5b1a_ rf5b2_ f5g0_,  i(pid) j(rid)


drop if rid>1 & missing( f5a_)

* reshape long f5a_ f5b1_ f5b2_ f5c_ f5d_ f5e_ f5f_ f5g0_ f5g1_ f5g2_ f5h1_ f5h2_ f5h3_ f5h4_ f5k_ f5ka_   f5l2_ f5m_ f5l1_01_ f5l1_02_ f5l1_03_ f5l1_04_ f5l1_05_ f5l1_06_ f5l1_07_ f5l1_08_ f5l1_09_ f5l1_10_ f5l1_11_ f5l1_12 f5l1_13 f5l1_14 rd_1 rd_2 rd_3 rd_4 rd_5 r
