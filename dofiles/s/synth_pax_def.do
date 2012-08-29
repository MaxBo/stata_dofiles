set more off

* use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_11_4verweildauer.dta", clear
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge2.dta" , clear
* Definition der Gruppierungen für Sampleziehung

gen grupp = 1 if destination == 60
label var grupp "Streckenziele gruppiert nach 2008"
replace grupp = 2 if destination == 90
replace grupp = 3 if destination == 1100
replace grupp = 4 if destination == 1400
replace grupp = 5 if destination == 1501
replace grupp = 6 if destination == 1850
replace grupp = 7 if destination == 1930
replace grupp = 8 if destination == 2001
replace grupp = 9 if destination == 2450
replace grupp = 10 if destination == 2550
replace grupp = 11 if destination == 2700
replace grupp = 12 if destination == 3310
replace grupp = 13 if destination == 3550
replace grupp = 14 if destination == 3650
replace grupp = 15 if destination == 3801
replace grupp = 16 if destination == 5753
replace grupp = 17 if destination == 8410
replace grupp = 15 if destination == 3802
replace grupp = 16 if destination == 5751
replace grupp = 16 if destination == 5610
replace grupp = 18 if destination == 40
replace grupp = 19 if destination == 50
replace grupp = 20 if destination == 70
replace grupp = 21 if destination == 80
replace grupp = 22 if destination == 150
replace grupp = 23 if destination == 610
replace grupp = 24 if destination == 605
replace grupp = 25 if destination == 675
replace grupp = 26 if destination == 100
replace grupp = 27 if destination == 1010
replace grupp = 28 if destination == 1070
replace grupp = 28 if destination == 1050
replace grupp = 29 if destination == 1201
replace grupp = 30 if destination == 1300
replace grupp = 31 if destination == 1502
replace grupp = 32 if destination == 1520
replace grupp = 33 if destination == 1560
replace grupp = 35 if destination == 2050
replace grupp = 34 if destination == 2060
replace grupp = 35 if destination == 1220
replace grupp = 36 if destination == 2210
replace grupp = 38 if destination == 2570
replace grupp = 39 if destination == 2730
replace grupp = 40 if destination == 2801
replace grupp = 37 if destination == 2560
replace grupp = 42 if destination == 3440
replace grupp = 43 if destination == 8200
replace grupp = 23 if destination == 120
replace grupp = 26 if destination == 30
replace grupp = 26 if destination == 160
replace grupp = 26 if destination == 590
replace grupp = 27 if destination == 1000
replace grupp = 28 if destination == 1052
replace grupp = 28 if destination == 1090
replace grupp = 31 if destination == 1504
replace grupp = 31 if destination == 1503
replace grupp = 33 if destination == 1510
replace grupp = 33 if destination == 1680
replace grupp = 33 if destination == 1750
replace grupp = 35 if destination == 1310
replace grupp = 35 if destination == 1420
replace grupp = 35 if destination == 2080
replace grupp = 35 if destination == 1860
replace grupp = 36 if destination == 2200
replace grupp = 40 if destination == 2812
replace grupp = 41 if destination == 2710
replace grupp = 41 if destination == 2750
replace grupp = 41 if destination == 2820
replace grupp = 41 if destination == 2870
replace grupp = 41 if destination == 2910
replace grupp = 41 if destination == 2920
replace grupp = 41 if destination == 2950
replace grupp = 41 if destination == 2980
replace grupp = 41 if destination == 3000
replace grupp = 42 if destination == 3450
replace grupp = 42 if destination == 3504
replace grupp = 42 if destination == 3536
replace grupp = 42 if destination == 3810
replace grupp = 42 if destination == 3835
replace grupp = 42 if destination == 3891
replace grupp = 44 if destination == 2230
replace grupp = 45 if destination == 2350
replace grupp = 46 if destination == 2400
replace grupp = 47 if destination == 2412
replace grupp = 48 if destination == 2420
replace grupp = 49 if destination == 2360
replace grupp = 50 if destination == 2460
replace grupp = 52 if destination == 3340
replace grupp = 53 if destination == 3300
replace grupp = 54 if destination == 3770
replace grupp = 44 if destination == 2240
replace grupp = 44 if destination == 2260
replace grupp = 44 if destination == 2270
replace grupp = 49 if destination == 2370
replace grupp = 49 if destination == 2430
replace grupp = 49 if destination == 2435
replace grupp = 50 if destination == 2480
replace grupp = 50 if destination == 2490
replace grupp = 50 if destination == 2530
replace grupp = 53 if destination == 3320
replace grupp = 53 if destination == 3330
replace grupp = 53 if destination == 3342
replace grupp = 53 if destination == 3346
replace grupp = 53 if destination == 3366
replace grupp = 53 if destination == 3410
replace grupp = 54 if destination == 3760
replace grupp = 51 if destination == 3110
replace grupp = 51 if destination == 3120
replace grupp = 51 if destination == 3140
replace grupp = 51 if destination == 3160
replace grupp = 51 if destination == 3170
replace grupp = 51 if destination == 3180
replace grupp = 51 if destination == 3190
replace grupp = 51 if destination == 3200
replace grupp = 51 if destination == 3210
replace grupp = 51 if destination == 3220
replace grupp = 51 if destination == 3230
replace grupp = 51 if destination == 3240
replace grupp = 51 if destination == 3242
replace grupp = 51 if destination == 3248
replace grupp = 51 if destination == 3258
replace grupp = 51 if destination == 3264
replace grupp = 35 if destination == 1270
replace grupp = 31 if destination == 1505
replace grupp = 35 if destination == 1810
replace grupp = 35 if destination == 1990
replace grupp = 35 if destination == 2100
replace grupp = 53 if destination == 3301
replace grupp = 53 if destination == 3321
replace grupp = 53 if destination == 3344
replace grupp = 42 if destination == 3570
replace grupp = 15 if destination == 3803
replace grupp = 55 if destination == 4040
replace grupp = 55 if destination == 4055
replace grupp = 55 if destination == 4060
replace grupp = 55 if destination == 4150
replace grupp = 55 if destination == 4160
replace grupp = 55 if destination == 4170
replace grupp = 55 if destination == 4280
replace grupp = 16 if destination == 5611
replace grupp = 43 if destination == 8020
replace grupp = 43 if destination == 8201
replace grupp = 28 if destination == 1075
replace grupp = 35 if destination == 1880
replace grupp = 35 if destination == 2040
replace grupp = 42 if destination == 3560

replace grupp = 26 if destination == 140
replace grupp = 26 if destination == 240
replace grupp = 42 if destination == 1020
replace grupp = 35 if destination == 1376
replace grupp = 35 if destination == 1650
replace grupp = 41 if destination == 2813
replace grupp = 41 if destination == 2890
replace grupp = 42 if destination == 3710
replace grupp = 42 if destination == 3890
replace grupp = 55 if destination == 4020
replace grupp = 55 if destination == 4380


label define grupp 1 "Frankfurt", modify
label define grupp 2 "München", modify
label define grupp 3 "Helsinki", modify
label define grupp 4 "Kopenhagen", modify
label define grupp 5 "London-Heathrow", modify
label define grupp 6 "Amsterdam", modify
label define grupp 7 "Brüssel", modify
label define grupp 8 "Paris", modify
label define grupp 9 "Lissabon", modify
label define grupp 10 "Zürich", modify
label define grupp 11 "Wien", modify
label define grupp 12 "Istanbul", modify
label define grupp 13 "Budapest", modify
label define grupp 14 "Prag", modify
label define grupp 15 "Moskau", modify
label define grupp 16 "Amerika", modify
label define grupp 17 "Dubai", modify
label define grupp 18 "Düsseldorf", modify
label define grupp 19 "Köln/Bonn", modify
label define grupp 20 "Stuttgart", modify
label define grupp 21 "Nürnberg", modify
label define grupp 22 "Dresden", modify
label define grupp 23 "Mannheim, Saarbrücken", modify
label define grupp 24 "Karlsruhe/Baden-Baden", modify
label define grupp 25 "Memmingen", modify
label define grupp 26 "übr. Deutschland", modify
label define grupp 27 "Danzig, Warschau", modify
label define grupp 28 "Baltikum", modify
label define grupp 29 "Stockholm", modify
label define grupp 30 "Oslo", modify
label define grupp 31 "übr. London", modify
label define grupp 32 "Manchester", modify
label define grupp 33 "übr. Großbritannien/Irland", modify
label define grupp 34 "Toulouse", modify
label define grupp 35 "übr. Nord- u. Westeuropa", modify
label define grupp 36 "Madrid, Barcelona", modify
label define grupp 38 "Basel", modify
label define grupp 39 "Salzburg", modify
label define grupp 40 "Rom, Mailand", modify
label define grupp 37 "Genf", modify
label define grupp 42 "übr. Osteuropa", modify
label define grupp 43 "Teheran u. übr. Asien", modify
label define grupp 41 "übr. Mittel- / Südeuropa", modify
label define grupp 44 "übr. Spanien (Festland)", modify
label define grupp 45 "Mallorca", modify
label define grupp 46 "Las Palmas", modify
label define grupp 47 "Teneriffa", modify
label define grupp 48 "Fuerteventura", modify
label define grupp 49 "übr. Spanien (Inseln)", modify
label define grupp 50 "übr. Portugal, Malta", modify
label define grupp 52 "Antalya", modify
label define grupp 53 "übr. Türkei, Zypern", modify
label define grupp 54 "Burgas, Varna", modify
label define grupp 51 "Griechenland", modify
label define grupp 55 "Afrika", modify

label value grupp grupp
rename grupp flughafenkategorie



drop if werktag==0
drop if missing(f24_neu)
drop if missing(f38)
drop if missing(f30_aggr2)
drop if missing(f30_aggr_4)

drop Jahr_*
qui tab Jahr, gen(Jahr_)

replace hrg3 = 1 if hrg==1| hrg==7 & Jahr==2010
replace hrg3 = 2 if hrg==2 & Jahr==2010
replace hrg3 = 3 if hrg>2 & hrg<7 & Jahr==2010

replace f30_aggr2 = 1 if Jahr==2010 & (f30==1 | f30==7 | f30==8 | f30==10)
replace f30_aggr2 = 2 if Jahr==2010 & (f30==3 )
replace f30_aggr2 = 3 if Jahr==2010 & (f30==9 | f30==12 | f30==11)
replace f30_aggr2 = 4 if Jahr==2010 & (f30==4 | f30==5 | f30==6)

bysort flughafenkategorie flugart Stunde: gen Stund_grupp4synthpax1 = _N if werktag==1
bysort flughafenkategorie flugart Stunde: gen Stund_grupp4synthpaxID1 = _n if werktag==1

replace  log_f24 = log(f24_neu)
recode Stunde (6/8=1 "früh") (9/11=2 "vormittags") (12/14=3 "mittags") (15/17=4 "nachmittags") (18/23=5 "abends"), gen(Stunde_5) 

bysort flughafenkategorie flugart Stunde_5: gen Stund_grupp4synthpax2 = _N if werktag==1
bysort flughafenkategorie flugart Stunde_5: gen Stund_grupp4synthpaxID2 = _n if werktag==1

bysort flughafenkategorie flugart Tageszeit: gen Stund_grupp4synthpax3 = _N if werktag==1
bysort flughafenkategorie flugart Tageszeit: gen Stund_grupp4synthpaxID3 = _n if werktag==1

bysort flughafenkategorie Stunde_5: gen Stund_grupp4synthpax4 = _N if werktag==1
bysort flughafenkategorie Stunde_5: gen Stund_grupp4synthpaxID4 = _n if werktag==1

bysort flughafenkategorie: gen Stund_grupp4synthpax5 = _N if werktag==1
bysort flughafenkategorie: gen Stund_grupp4synthpaxID5 = _n if werktag==1

glm f32 tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1 reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 deutsch log_f38_HAM hrg3_2  vm_1  if f12n<3 & f32<=240 & werktag==1, family(gamma) link(id) nolog
estimates save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\gamma_verweildauer.ster", replace


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\synthpax_2010.dta", clear
rename stunde Stunde
replace flughafenkategorie= 42 if entferntstreckenhkode == "POZ"
replace Stunde=20 if Stunde==21 & flugnummervoll =="OL 0890"
gen flugartn=flugart_n
replace flugartn = 2 if flugart_n == 3
label value flugartn flugart_n
tab flugartn, gen(flugartn_)
rename flugart_n flugart
drop if missing(flugart)

recode Stunde (6/8=1 "früh") (9/11=2 "vormittags") (12/14=3 "mittags") (15/17=4 "nachmittags") (18/21=5 "abends"), gen(Stunde_5) 

gen Tageszeit = 1 if Stunde <9
replace Tageszeit = 2 if missing(Tageszeit)
replace Tageszeit = 3 if Stunde ==22
label define tz 1  `"morgens"', modify
label define tz 2  `"tagsüber"', modify
label define tz 3  `"nachts"', modify
label value Tageszeit tz

merge m:m flughafenkategorie Stunde flugart using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(Stund_grupp4synthpax1) nogen
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie Stunde_5 flugart using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(Stund_grupp4synthpax2) nogen
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie Tageszeit flugart using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(Stund_grupp4synthpax3) nogen
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie  Stunde_5 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(Stund_grupp4synthpax4) nogen
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie   using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(Stund_grupp4synthpax5) nogen
drop if missing(paxid)
duplicates drop paxid, force

bysort flughafenkategorie Stunde: gen Anz_PAX=_N

forvalues i=1/5{

	gen zufall_pax4synth`i' = round(Stund_grupp4synthpax`i'*runiform(),1) 
	replace zufall_pax4synth`i' = round(Stund_grupp4synthpax`i'*runiform(),1) if zufall_pax4synth`i'==0
	replace zufall_pax4synth`i' = round(Stund_grupp4synthpax`i'*runiform(),1) if zufall_pax4synth`i'==0 
	replace zufall_pax4synth`i' = round(Stund_grupp4synthpax`i'*runiform(),1) if zufall_pax4synth`i'==0 
	replace zufall_pax4synth`i' = round(Stund_grupp4synthpax`i'*runiform(),1) if zufall_pax4synth`i'==0 
	rename zufall_pax4synth`i' Stund_grupp4synthpaxID`i'
}




merge m:m flughafenkategorie flugart Stunde Stund_grupp4synthpaxID1 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 geschlecht deutsch log_f38_HAM hrg3_2  vm_1 f32 hrg3 reise_allein reise_kind hrg3 VM_Kette *region Tageszeit f16_aggr VM_Zubring_0_diff f30_aggr2 f24_neu f38 f13 f18) nogen  update
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie Stunde_5 Stund_grupp4synthpaxID2 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 geschlecht deutsch log_f38_HAM hrg3_2  vm_1 f32 hrg3 reise_allein reise_kind hrg3 VM_Kette *region Tageszeit f16_aggr VM_Zubring_0_diff f30_aggr2 f24_neu f38 f13 f18) nogen  update
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie Tageszeit Stund_grupp4synthpaxID3 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 geschlecht deutsch log_f38_HAM hrg3_2  vm_1 f32 hrg3 reise_allein reise_kind hrg3 VM_Kette *region Tageszeit f16_aggr VM_Zubring_0_diff f30_aggr2 f24_neu f38 f13 f18) nogen  update
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie Stunde_5 Stund_grupp4synthpaxID4 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 geschlecht deutsch log_f38_HAM hrg3_2  vm_1 f32 hrg3 reise_allein reise_kind hrg3 VM_Kette *region Tageszeit f16_aggr VM_Zubring_0_diff f30_aggr2 f24_neu f38 f13 f18) nogen update
drop if missing(paxid)
duplicates drop paxid, force

merge m:m flughafenkategorie  Stund_grupp4synthpaxID5 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_4verweildauer_vorber.dta", keepusing(tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 geschlecht deutsch log_f38_HAM hrg3_2  vm_1 f32 hrg3 reise_allein reise_kind hrg3 VM_Kette *region Tageszeit f16_aggr VM_Zubring_0_diff f30_aggr2 f24_neu f38 f13 f18) nogen update
drop if missing(paxid)
duplicates drop paxid, force

label var f18  "Reiseklasse"
label define f18 1 `"First Class"' 2 `"Business Class"' 3 `"Economy Plus"' 4 `"Economy Class"' 5 `"klassenlos / Pauschalreisender"' 
label define f18 6 `"Weiß nicht"', modify
label define f18 7 `"Sonderklasse R 6"', modify
label define f18 8 `"Club Klasse"', modify
label define f18 9 `"Star Class"', modify
label define f18 10 `"Comfort Class"', modify
label value f18 f18

estimates use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\gamma_verweildauer.ster"

predict mu 
* histogram mu
gen resi = f32 - mu
* histogram resi

gammafitoffset resi, inita(14) initb(7)

gen res2 = rgamma(14.83 , 7.81) - 115.74

gen Verweildauer = mu+res2
replace res2 = rgamma(14.83 , 7.81) - 115.74 if Verweildauer<30
replace Verweildauer = mu+res2 if Verweildauer<30

replace res2 = rgamma(14.83 , 7.81) - 115.74 if Verweildauer<20
replace Verweildauer = mu+res2 if Verweildauer<20

replace res2 = rgamma(14.83 , 7.81) - 115.74 if Verweildauer<20
replace Verweildauer = mu+res2 if Verweildauer<20

replace Verweildauer = round(Verweildauer,1)

gen resid = f32 - Verweildauer
gen test= substr(planzeit_uhrzeit,-5,2)
destring(test), gen(Minute)

gen hilfszeit_start = Stunde*60 + Minute

gen hilfszeit_ankunft = hilfszeit_start - Verweildauer

gen Ankunfts_std = int(hilfszeit_ankunft/60)
gen Ankunfts_min = round(hilfszeit_ankunft - 60*Ankunfts_std,1) 

gen uhrzeit_abflug_ham = substr(planzeit_uhrzeit,-8,5)
gen uhrzeit_ankunft_ham = string(Ankunfts_std) + ":" + string(Ankunfts_min) if Ankunfts_min>9
replace uhrzeit_ankunft_ham = string(Ankunfts_std) + ":0" + string(Ankunfts_min) if Ankunfts_min<10
replace uhrzeit_ankunft_ham = "0" + uhrzeit_ankunft_ham if Ankunfts_std<10

* histogram Verweildauer, fraction width(10)

rename f24_neu Vorausbuchunszeit
rename f31 Reise_mit_Gepaeck
rename f30_aggr2 Eincheckarten
rename hrg3 Hauptreisegrund
rename f38 Abflughaeufigkeit_HAM
rename VM_Zubring_0_diff  Zubringerverkehrsmittel
rename f16_aggr Reisetyp
rename f13 Gesamtreisedauer
rename f18 Reiseklasse
sort paxid
* xmlsave  paxid uhrzeit_abflug_ham uhrzeit_ankunft_ham Stunde Minute Ankunfts_std Ankunfts_min Verweildauer entferntstreckenhkode registration flugzeugtyp flugart flughafenkategorie Reise_mit_Gepaeck alter geschlecht reise_allein reise_kind VM_Kette zielregion wohnregion aufbruchsregion Eincheckarten Hauptreisegrund Reisetyp Vorausbuchunszeit Abflughaeufigkeit_HAM Gesamtreisedauer Zubringerverkehrsmittel using /*
* */ "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\SynthPop.xml",  replace

outsheet  paxid uhrzeit_abflug_ham uhrzeit_ankunft_ham Stunde Minute Ankunfts_std Ankunfts_min Verweildauer entferntstreckenhkode registration flugzeugtyp flugart flughafenkategorie Reise_mit_Gepaeck alter geschlecht reise_allein reise_kind VM_Kette zielregion wohnregion aufbruchsregion Eincheckarten Hauptreisegrund Reisetyp Vorausbuchunszeit Abflughaeufigkeit_HAM Gesamtreisedauer Zubringerverkehrsmittel Reiseklasse using /*
*/ "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\SynthPop_Name_2010.xls",  replace noquote

outsheet  paxid uhrzeit_abflug_ham uhrzeit_ankunft_ham Stunde Minute Ankunfts_std Ankunfts_min Verweildauer entferntstreckenhkode registration flugzeugtyp flugart flughafenkategorie Reise_mit_Gepaeck alter geschlecht reise_allein reise_kind VM_Kette zielregion wohnregion aufbruchsregion Eincheckarten Hauptreisegrund Reisetyp Vorausbuchunszeit Abflughaeufigkeit_HAM Gesamtreisedauer Zubringerverkehrsmittel Reiseklasse using /*
*/ "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\SynthPop_Nr_2010.xls",  replace noquote nolabel

*++++++extra laufen lassen!
* log using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\SynthPop_Legende.txt", replace
* tabm flugart flughafenkategorie Reise_mit_Gepaeck alter geschlecht reise_allein reise_kind VM_Kette zielregion wohnregion aufbruchsregion Eincheckarten Hauptreisegrund Reisetyp Zubringerverkehrsmittel 
* log close
