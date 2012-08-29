clear
set memory 700m
* use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_11.dta", clear
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge2.dta" , clear
* Datenbereinigung
drop _I*
drop mct_*
drop  v8 v14 v15  v16 v17 v18 v30 v35 reisedauer_d buchungsort gebuchtes veranstalter klasse vorausbuchungszeit_d verkm flugnr_ldg eintreffzeit_min staat_11 v119
drop  charakter streckenziel_sz_1 hplz wplz endziel_ez_1

* gen catchment_area_aggr = catchment_area < 7 | (catchment_area == 8 &  aufbruchgebiet_ausland > 16 &  aufbruchgebiet_ausland < 21)
* label value catchment_area_aggr jn
* label var catchment_area_aggr "Teil des Einzugsgebiets HAM"

gen reise_allein = reise_gemeinsam==1
label var reise_allein "Alleinreisend"
label value reise_allein jn

tab catchment_area, gen(ca_)
label value ca_* jn

tab Jahr, gen(Jahr_)
label value Jahr_* jn

replace f12n = f12
replace f12n = 3 if f25==14
replace f12n = 2 if wohnland==zielland & f12==1 & f8_1==2


* f30 für 2009 schon bestimmt ; f30_1 & f30_2 widersprechen sich teilweise, z.B. Check-In am Schalter und Automat => Check-In am Schalter
replace f30_1 = f30 if missing(f30_1) & Jahr==2009

gen f30n = f30_1
replace f30n = 3 if f30_2==3 & f31==1 & Jahr<2009


label var f30n "Eincheckart am Flughafen"
label value f30n f30

gen f30_aggr = 1 if (f30n>6 & f30n<12) | f30n==4  | f30n==17
replace f30_aggr = 2 if f30n==1 | f30n==5
replace f30_aggr = 3 if f30n==3 | f30n==6
replace f30_aggr = 4 if (f30_1== 1  & f30_2==3) | f30_1 == 2
replace f30_aggr = 5 if (f30_1== 3  & f30_2==7) 
replace f30_aggr = 5 if (f30_1== 7 | f30_1 ==17 | f30_1 == 9 | f30_1==8) & f30_2==3
replace f30_aggr = 6 if f30_1 ==4 | f30_1==9 | f30_1==10 | f30_2==4
replace f30_aggr = 7 if f30_1 ==5 | f30_1==6 | f30_1==10

* Check-In-Art: Schalter, Automat, Fernkommunikation u.a --> vielleicht in drei Klassen untergliedern: zeitsparend, zeitaufwendig?

label define f30_a 1`"ohne Flughafeneinchecken"', modify
label define f30_a 2`"am Automaten"', modify
label define f30_a 3`"am Schalter"', modify
label define f30_a 4`"Automat + Schalter"', modify
label define f30_a 5`"andere Medien + Schalter"', modify
label define f30_a 6`"Vorabendeinchecker"', modify
label define f30_a 7`"sonstige"', modify

gen f30_aggr2 = 1 if f30_aggr==1 | f30_aggr==2
replace f30_aggr2 = 2 if f30_aggr ==3
replace f30_aggr2 = 3 if f30_aggr == 4 | f30_aggr==5 | f30_aggr==7
replace f30_aggr2 = 4 if f30_aggr ==6

label define f30_b 1`"ohne + Automat"', modify
label define f30_b 2`"am Schalter"', modify
label define f30_b 3`"Schalter + andere Medien"', modify
label define f30_b 4`"Vorabendeinchecker"', modify

label value f30_aggr2 f30_b
label var f30_aggr2 "Eincheckarten aggregiert"

label value f30_aggr f30_a
tab f30_aggr2, gen(f30_aggr_)

replace VM_Zubring_0 = 1 if VM_Zubring_0_diff<3

tab VM_Zubring_0_diff, gen(vm_diff_)
tab VM_Zubring_0, gen (vm_)
tab hrg2, gen(hrg_)

gen zeit_aggr_mct = 1 if Stunde < 9
* replace zeit_aggr_mct = 2 if Stunde == 8
replace zeit_aggr_mct = 3 if missing(zeit_aggr_mct)
replace zeit_aggr_mct = 4 if Stunde == 10 | Stunde== 14 | Stunde== 15 | Stunde== 20 | Stunde== 21
replace zeit_aggr_mct = 5 if Stunde ==22
label var zeit_aggr_mct "Zeitscheiben mit signifikanten Unterschieden bei der MCT"
* tab Tageszeit, gen(z_mct_)

gen Tageszeit = 1 if Stunde <9
replace Tageszeit = 2 if missing(Tageszeit)
replace Tageszeit = 3 if Stunde ==22
label define tz 1  `"morgens"', modify
label define tz 2  `"tagsüber"', modify
label define tz 3  `"nachts"', modify
label value Tageszeit tz
 tab Tageszeit, gen(tz_)

* regress f32  werktag flugart_* if  vm_6!=1, nocons
* test flugart_3=flugart_2
* regress f32 werktag z_mct_*, nocons
gen catchment_area_wohn = 1 if bundesland_wohn==2
replace catchment_area_wohn =2 if kreis_wohn=="Dithmarschen" | kreis_wohn=="Steinburg" | kreis_wohn=="Pinneberg" | kreis_wohn=="Segeberg" | kreis_wohn=="Stormarn" | kreis_wohn=="Herzogtum Lauenburg"
replace catchment_area_wohn =3 if kreis_wohn=="Lüneburg" | kreis_wohn=="Lüchow-Dannenberg" | kreis_wohn=="Uelzen" | kreis_wohn=="Soltau-Fallingbostel" | kreis_wohn=="Rotenburg (Wümme)" | kreis_wohn=="Stade" | kreis_wohn=="Cuxhaven" | kreis_wohn=="Harburg"
replace catchment_area_wohn =4 if kreis_wohn=="Kiel"
replace catchment_area_wohn =5 if kreis_wohn=="Lübeck"

replace catchment_area_wohn =6 if missing(catchment_area_wohn) & (bundesland_wohn==13 | bundesland_wohn==1 | bundesland_wohn==3 | bundesland_wohn==4 | kreis_wohn=="Prignitz" | kreis_wohn=="Stendal" | kreis_wohn=="Ostprignitz_Ruppin" | kreis_wohn=="Altmarkkreis Salzwedel") 
replace catchment_area_wohn =7 if (missing(catchment_area_wohn) & f5_1==1) | (kreis_wohn=="Holzminden" | kreis_wohn=="Northeim" | kreis_wohn =="Goslar" | kreis_wohn=="Göttingen" | kreis_wohn=="Osterode am Harz")
replace catchment_area_wohn =9 if f8_1==2
replace catchment_area_wohn =8 if f8_2==7

quietly label define c_a 1  `"Hamburg"', modify
quietly label define c_a 2  `"Metropolregion HH Schleswig-Holstein"', modify
quietly label define c_a 3  `"Metropolregion HH Niedersachsen"', modify
quietly label define c_a 4  `"Kiel"', modify
quietly label define c_a 5  `"Lübeck"', modify
quietly label define c_a 6  `"Einzugsgebiet außerhalb MRH"', modify
quietly label define c_a 7  `"Restdeutschland"', modify
quietly label define c_a 8  `"Dänemark"', modify
quietly label define c_a 9  `"Ausland"', modify

label value catchment_area_wohn c_a
label var catchment_area_wohn "Wohnen Einzugsgebiet Flughafen (klassifiziert)"


quietly tab f12n, gen(herkunft_)
recode f31 (2=0)
label value f31 jn

gen flugartn=flugart
replace flugartn = 2 if flugart == 3
label value flugartn flugart
tab flugartn, gen(flugartn_)
* regress f32  f38_HAM_vf  f31  reise_kind reise_allein  vm_1 vm_2 vm_3 vm_4 vm_5 if  vm_6!=1 & werktag==1 , nocons
* regress f32  f31  reise_allein  flugartn_1 if  vm_6!=1 & werktag==1 , nocons

* regress f32  f31   z_mct_1 reise_allein  f30_aggr_3   ca_wohn_1 ca_wohn_2 ca_wohn_3  flugartn_*  if  vm_6!=1 & flugart!=4 & werktag==1 , nocons
* regress f32  f31   z_mct_1 reise_allein  f30_aggr_3   ca_wohn_1 ca_wohn_2 ca_wohn_3  herkunft_*  if  vm_6!=1 & flugart!=4 & werktag==1 , nocons

* regress f32  f31   z_mct_1  f30_aggr_3   ca_wohn_1 ca_wohn_2 ca_wohn_3  flugartn_*  if  vm_6!=1 & flugart!=4 & werktag==1 , nocons



gen catchment_area_wohn_diff = catchment_area_wohn
replace catchment_area_wohn_diff = 10 if bundesland_wohn==2 & Bezirke_HH_wohn == 6 
replace catchment_area_wohn_diff = 10 if bundesland_wohn==2 & (Stadtteil_HH_wohn == 119 | Stadtteil_HH_wohn == 121)

gen catchment_area_start_diff = catchment_area
replace catchment_area_start_diff = 10 if bundesland_start==2 & Bezirke_HH_start == 6 
replace catchment_area_start_diff = 10 if bundesland_start==2 & (Stadtteil_HH_start == 119 | Stadtteil_HH_start == 121)


quietly label define c_a 1  `"Hamburg Nord"', modify
quietly label define c_a 10  `"Hamburg Süd"', modify

label value catchment_area_wohn_diff c_a
label value catchment_area_start_diff c_a

label variable catchment_area_wohn_diff "Differenziertes Einzugsgebiet Wohnen"
label variable catchment_area_start_diff "Differenziertes Einzugsgebiet Aufbruch"


label define c_a_einf 1 `"HH Nord"', modify
label define c_a_einf 10 `"HH Süd"', modify
label define c_a_einf 2 `"MRH SH"', modify
label define c_a_einf 3 `"MRH NS"', modify
label define c_a_einf 4 `"Kiel"', modify
label define c_a_einf 5 `"Lübeck"', modify
label define c_a_einf 6 `"CA ex MRH"', modify
label define c_a_einf 7 `"restl. BRD"', modify
label define c_a_einf 8 `"Dänemark"', modify
label define c_a_einf 9 `"Ausland"', modify

gen Einzugsgebiet_Start = catchment_area_start_diff
gen Einzugsgebiet_Wohn = catchment_area_wohn_diff

label value Einzugsgebiet_* c_a_einf


quietly tab catchment_area_wohn_diff, gen(ca_wohn_diff_)
quietly tab catchment_area_start_diff, gen(ca_start_diff_)
 * mvreg f32 = f31  reise_allein  hrg_1  hrg_2  f30_aggr_1 f38_HAM_vf  z_mct_1  f30_aggr_3   ca_wohn_diff_1  ca_wohn_diff_2   herkunft_1 flugartn_1 flugartn_2 ziel_1 ziel_2 if  vm_6!=1 & flugart!=4 & werktag==1 & f32<=120, nocons

gen f52_aggr = 1 if f52==2
replace f52_aggr = 2 if f52 > 3 & f52 < 200
replace f52_aggr = 3 if f52== 1 | f52==3
replace f52_aggr = 4 if f52==5


label define f52_a 1  `"Leitende Angestellte"', modify
label define f52_a 3  `"Angestellte + Selbständige"', modify
label define f52_a 2  `"Nicht Berufstätige"', modify
label define f52_a 4  `"Sonstige Arbeiter"', modify 
label value f52_aggr f52_a
tab f52_aggr, gen(besch_)
label var f52_aggr "Beschäftigungsgruppen (aggregiert)"
 
gen bed_wz = f48_1==4 | f48_2==4 | f48_3==4
 
recode geschlecht (2=0)
label define geschlecht 0 `"weiblich"', modify
label define geschlecht 1 `"männlich"', modify
label value geschlecht geschlecht
recode f61 (2=0)
label value f61 jn

tab altersgruppe, gen(alt1_)
tab altersgruppe2, gen(alt2_)

gen alt2_5 = alt2_1==1 | alt2_4==1

replace f13_aggr = 6 if f13_aggr==2 & f13<4
label define f13_aggr 6 `"bis zu 3 Tagen"', modify
label value f13_aggr f13_aggr

gen f16_aggr = 1 if f16 <5 
replace f16_aggr= 2 if f16 ==5 | f16==6
label define f16_aggr 1 `"Flug +"', modify
label define f16_aggr 2 `"Pauschalreise"', modify
label value f16_aggr f16_aggr


tab f16_aggr, gen(reisetyp_)

gen hrg3 = 1 if hrg2==1 | hrg2==7
replace hrg3 =2 if hrg2==2
replace hrg3 = 3 if hrg2==5 | hrg2==6
label define hrg3 1 `"dienstlich"', modify
label define hrg3 2 `"Urlaub"', modify
label define hrg3 3 `"privat"', modify
label value hrg3 hrg3
tab hrg3, gen(hrg3_)

* tab f13_aggr, gen(reisedauer_)
* tab f24_aggr, gen(vorausbuchung_)

gen ank_15 = (f32_aggr+1)* 15 if f32 <=120
replace ank_15 = (f32_aggr-3)*30 if 120<=f32
replace ank_15 = 357 if ank_15==270

label var ank_15 "Ankunft am Flughafen in 15-Minutenschritten"


gen log_f32 = log(f32)
gen log_f24 = log(f24_neu)
gen log_f38_HAM = log(f38_HAM+1)
gen log_f13 = log(f13)
gen z_mct_1n = tz_2 == 1
gen besch_1n = besch_1==0
gen ca_10 =  ca_1==1 |  ca_2==1
gen  kurzreise =  f13<4
gen herbst = welle==3
label value herbst jn
label define welle 1`"Frühling"', modify
label define welle 2`"Sommer"', modify
label define welle 3`"Herbst"', modify
label define welle 4`"Winter"', modify
label value welle welle
tab welle, gen (jz_)
gen Wohnort_HH_N = Einzugsgebiet_Wohn==1
label value Wohnort_HH_N jn
gen Startort = 1 if bundesland_start==2
replace Startort = 2 if Einzugsgebiet_Start==2
replace Startort = 3 if Einzugsgebiet_Start==3
replace Startort = 4 if missing(Startort)
replace Startort = 5 if Einzugsgebiet_Start==8 | Einzugsgebiet_Start==9  | Einzugsgebiet_Start==7 

label define startort 1 `"HH"', modify
label define startort 2 `"MRH SH"', modify
label define startort 3 `"MRH NS"', modify
label define startort 4 `"Einzugsgebiet HAM"', modify
label define startort 5 `"außerhalb Einzugsgebiet"', modify
label value Startort startort

gen zielregion_aggr = 1 if zielregion==1
replace zielregion_aggr = 2 if zielregion==2
replace zielregion_aggr = 3 if missing(zielregion_aggr)

label define ziel_aggr 1 `"D"', modify
label define ziel_aggr 2 `"Europa"', modify
label define ziel_aggr 3 `"Rest der Welt"', modify
label value zielregion_aggr ziel_aggr

quietly tab zielregion_aggr, gen(ziel_)
gen ziel_10 = ziel_1==0 & ziel_2==0
gen alter2 = alter*alter

tab Startort, gen(start_)

recode f8_1 (2=0)
gen deutsch = staat_1==1
label value deutsch jn
gen f32_u30 = f32
replace f32_u30 = 25 if f32<25

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_11_4verweildauer.dta", replace

* regress f32   f31 log_f24  log_f38_HAM   f8_1 log_f13  flugartn_1  reisetyp_2 besch_1n  f30_aggr_1  f30_aggr_3  z_mct_1n vm_diff_1    ziel_2  in_dt  ca_10    ca_start_diff_3 hrg3_1  ca_wohn_diff_1 Jahr_1 Jahr_3  if vm_diff_6==0 & f32<=240 & werktag==1
regress f32 tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 deutsch log_f38_HAM hrg3_2  vm_1  if f12n<3 & f32<=240 & werktag==1
predict t if vm_diff_6==0 & f32<=240 & werktag==1
* gen fit = exp(t)
predict r if vm_diff_6==0 & f32<=240 & werktag==1, resid


* predict stdp, stdp
predict stdf, stdf

* set seed 30
forvalues i=1/3 {
quietly gen ank_zufall_`i' = rnormal(t,stdf) if f32<=240 & werktag==1 & vm_diff_6==0 
}
gen su_ank_zu = ank_zufall_1
* quietly egen mean_ank_zu = mean(ank_zufall)

forvalues i=2/3 {
quietly replace su_ank_zu = ank_zufall_`i' + su_ank_zu
}

gen ank_zu_mw = su_ank_zu/3

drop ank_zufall_*

gen res_gauss = f32 - ank_zu_mw

gen ank_30 = f32_aggr2*30 if f32<=240

poisson ank_30 f31 log_f24  log_f38_HAM   log_f13 f8_1 flugartn_1  reisetyp_2 besch_1n  f30_aggr_1  f30_aggr_3  z_mct_1n vm_diff_1    ziel_2  in_dt  ca_10    ca_start_diff_3 hrg3_1  ca_wohn_diff_1 Jahr_1 Jahr_3  if vm_diff_6==0 & f32<=240 & werktag==1

predict tp if f32<=240 & werktag==1 & vm_diff_6==0 
predict sp if f32<=240 & werktag==1 & vm_diff_6==0, stdp
* predict rx if f32<=240 & werktag==1 & vm_diff_6==0 , resid
* gen a = tx - rx
* gen b = tx + rx

gen tx_r =rpoisson(t)

poisson f32 tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 deutsch log_f38_HAM hrg3_2  vm_1  if f12n<3 & f32<=240 & werktag==1

predict tp2 if f32<=240 & werktag==1 & vm_diff_6==0 
predict sp2 if f32<=240 & werktag==1 & vm_diff_6==0, stdp
* predict rx if f32<=240 & werktag==1 & vm_diff_6==0 , resid
* gen a = tx - rx
* gen b = tx + rx

gen tx_r2 =rpoisson(tp2)


* grmeanby  f30_aggr2 flugart  VM_Zubring_0_diff  altersgruppe2 zielregion f38_HAM_vf reise_allein f31 hrg3 if f32<=240 & werktag==1, summarize(f32)


glm f32 tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 deutsch log_f38_HAM hrg3_2  vm_1  if f12n<3 & f32<=240 & werktag==1, family(gamma) link(id)
predict mu if vm_diff_6==0 & f32<=240 & werktag==1
* histogram mu
gen resi = f32 - mu
* histogram resi

gammafitoffset resi, inita(14) initb(7)

gen res2 = rgamma(14.83 , 7.81) - 115.74


gen y2 = mu+res2




gen resid = f32 - y2


* qqplot f32 y2 if f32<=240

* twoway (histogram mu, width(30)) (histogram y2, width(30)) (histogram f32, width(30)) if f32<=240

* twoway  (histogram y2, width(30)) (histogram f32, width(30)) if f32<=240 & hrg3==1
* twoway  (histogram y2, width(30)) (histogram f32, width(30)) if f32<=240 & hrg3==2
* twoway  (histogram y2, width(30)) (histogram f32, width(30)) if f32<=240 & hrg3==3



* zeitabhängige Einflussfaktoren
* grmeanby welle herbst wochentag werktag Stunde Tageszeit  if f32<=240 & Stunde<25 & f12n<3, summarize(f32)
* regress f32  jz_*  tz_* werktag if & f12n<3, nocons

* raumabhängige Einflussfaktoren
* grmeanby   Einzugsgebiet_Start Startort Einzugsgebiet_Wohn zielregion zielregion_aggr if f32<=240 & f12n<3, summarize(f32)
* regress f32  ca_wohn_diff_*  start_* ziel_* if f12n<3, nocons

* reiseabhängige Einflussfaktoren
* grmeanby hrg3 reise_allein reise_kind flugartn  f16_aggr f31  f30_aggr     f13_aggr f24_aggr  VM_Zubring_0_diff  if  f12n<3, summarize(f32)
* regress f32 hrg3_* reise_allein reise_kind flugartn_*   reisetyp_* f31  f30_aggr_*  log_f13 log_f24   vm_diff_*   if  f12n<3
* regress f32 hrg3_* reise_allein reise_kind flugartn_*   reisetyp_* f31  f30_aggr_*  f13 f24   vm_diff_*   if  f12n<3

* sozioökonomische Einflussfaktoren  
* grmeanby geschlecht altersgruppe2 f52  f52_aggr deutsch f38_HAM_aggr if  f12n<3, summarize(f32)
* regress f32 geschlecht  alt2_1  alt2_2 alt2_3 alt2_4  besch_1  besch_2 besch_3 besch_4 deutsch f38_HAM if  f12n<3

* regress f32 tz_2 werktag  ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_1  f30_aggr_3 f13 log_f24  alter alter2 deutsch log_f38_HAM  vm_diff_1 Jahr_* if f12n<3 & f32<=240

* regress f32 tz_2 werktag Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_1  f30_aggr_3 f13 log_f24  alter alter2 deutsch log_f38_HAM  vm_diff_1  if f12n<3 & f32<=240
* regress f32   f31 log_f24  log_f38_HAM   deutsch log_f13  flugartn_1  reisetyp_2 besch_1n  f30_aggr_1  f30_aggr_3  z_mct_1n vm_diff_1    ziel_2  in_dt  ca_10    ca_start_diff_3 hrg3_1  ca_wohn_diff_1 Jahr_1 Jahr_3  if vm_diff_6==0 & f32<=240 & werktag==1

* Das sieht bisher am besten aus :o)
* regress f32 tz_2 werktag Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 f13 log_f24  alter alter2 deutsch log_f38_HAM hrg3_1 vm_diff_1  if f12n<3 & f32<=240
* regress f32 tz_2 Jahr_* ziel_1 ziel_2 Wohnort_HH_N  start_* reise_allein  flugartn_1   reisetyp_1 f31  f30_aggr_2  f30_aggr_4 log_f13 log_f24  alter alter2 deutsch log_f38_HAM hrg3_2  vm_1  if f12n<3 & f32<=240 & werktag==1


* 
* twoway (histogram f32,  width (30)) (histogram f32 if Jahr==2006, width (30)) (histogram f32 if Jahr==2008, width (30)) (histogram f32 if Jahr==2009, width (30))  if f32<201 & f12n<3, legend(pos(5) ring(0) col(1) lab(1 "2006") lab(2 "2008") lab(3 "2009")lab(4 "gesamt") region(fcolor(gs15))) legend(subtitle("Legende"))

* twoway (histogram  mu, width(30) legend(lab(1 "Schätzungsergebnis ohne Monte-Carlo-Simulation"))) (histogram   y2, width(30) legend(lab(2 "Mittelwert der Schätzung nach 4 Monte-Carlo-Simulation"))) (histogram f32, width(30) legend( lab(1 "Risikoaffinität"))) if f32<=240


* Graphiken für das Paper

* qqplot  y2 f32 if f32<=240 & werktag==1 & vm_diff_6==0
* qqplot  ank_zu_mw f32 if f32<=240 & werktag==1 & vm_diff_6==0

* twoway (histogram f32, width(30)) (histogram  y2, width(30)) (histogram  ank_zu_mw, width(30)) if f32<=240 & werktag==1 & vm_diff_6==0, by(hrg3, total)

* twoway (histogram f32, width(30)) (histogram  mu, width(30)) (histogram  y2, width(30)) if f32<=240 & werktag==1 & vm_diff_6==0
* twoway (histogram f32, width(30)) (histogram  t, width(30)) (histogram  ank_zu_mw, width(30)) if f32<=240 & werktag==1 & vm_diff_6==0


