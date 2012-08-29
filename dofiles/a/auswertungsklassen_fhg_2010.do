clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG10_2.dta", clear

replace bundesland_start=2 if f3a=="22145"
replace bundesland_wohn=2 if f7a=="22145"
replace gemeinde_start="Hamburg" if f3a=="22145"
replace gemeinde_wohn="Hamburg" if f7a=="22145"
replace kreis_start="Hamburg" if f3a=="22145"
replace kreis_wohn="Hamburg" if f7a=="22145"
* Datenbereinigung
label define jn 0 `"nein"', modify
label define jn 1 `"ja"', modify

gen reise_allein = reise_gemeinsam==1
label var reise_allein "Alleinreisend"
label value reise_allein jn

label define f30_c  1 `"FHG am Automaten ohne Gep‰ck"', modify
label define f30_c  9 `"Drag & Drop"', modify
label define f30_c  3 `"FHG am normalen Schalter"', modify
label define f30_c  4 `"FHG Vorabend Check-In am normalen Schalter"', modify
label define f30_c  5 `"Beim Herflug am Automaten"', modify
label define f30_c  6 `"Beim Herflug am normalen Schalter"', modify
label define f30_c  7 `"Internet "', modify
label define f30_c  8 `"Telefonisch "', modify
label define f30_c  10 `"Handy / SMS"', modify
label define f30_c  11 `"Drag & Drop beim Herflug"', modify
label define f30_c  12 `"sonstige"', modify

label value f30 f30_c


* Check-In-Art: Schalter, Automat, Fernkommunikation u.a --> vielleicht in drei Klassen untergliedern: zeitsparend, zeitaufwendig?


gen f30_aggr2 = 1 if f30==1 | (f30>4 & f30<12)
replace f30_aggr2 = 2 if f30 ==3
replace f30_aggr2 = 3 if f30 ==9
replace f30_aggr2 = 4 if f30 ==4

label define f30_b 1`"ohne + Automat + Herflug"', modify
label define f30_b 2`"am Schalter"', modify
label define f30_b 3`"Schalter + andere Medien"', modify
label define f30_b 4`"Vorabendeinchecker"', modify

label value f30_aggr2 f30_b
label var f30_aggr2 "Eincheckarten aggregiert"

tab f30_aggr2, gen(f30_aggr_)


tab VM_Zubring_0_diff, gen(vm_diff_)
tab VM_Zubring_0, gen (vm_)


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
label define tz 2  `"tags¸ber"', modify
label define tz 3  `"nachts"', modify
label value Tageszeit tz
 tab Tageszeit, gen(tz_)

* regress f32  werktag flugart_* if  vm_6!=1, nocons
* test flugart_3=flugart_2
* regress f32 werktag z_mct_*, nocons
gen catchment_area_wohn = 1 if bundesland_wohn==2
replace catchment_area_wohn =2 if kreis_wohn=="Dithmarschen" | kreis_wohn=="Steinburg" | kreis_wohn=="Pinneberg" | kreis_wohn=="Segeberg" | kreis_wohn=="Stormarn" | kreis_wohn=="Herzogtum Lauenburg"
replace catchment_area_wohn =3 if kreis_wohn=="L¸neburg" | kreis_wohn=="L¸chow-Dannenberg" | kreis_wohn=="Uelzen" | kreis_wohn=="Soltau-Fallingbostel" | kreis_wohn=="Rotenburg (W¸mme)" | kreis_wohn=="Stade" | kreis_wohn=="Cuxhaven" | kreis_wohn=="Harburg"
replace catchment_area_wohn =4 if kreis_wohn=="Kiel"
replace catchment_area_wohn =5 if kreis_wohn=="L¸beck"
replace catchment_area_wohn =6 if missing(catchment_area_wohn) & (bundesland_wohn==13 | bundesland_wohn==1 | bundesland_wohn==3 | bundesland_wohn==4 | kreis_wohn=="Prignitz" | kreis_wohn=="Stendal" | kreis_wohn=="Ostprignitz_Ruppin" | kreis_wohn=="Altmarkkreis Salzwedel") 
replace catchment_area_wohn =7 if (missing(catchment_area_wohn) & f5_1==1) | (kreis_wohn=="Holzminden" | kreis_wohn=="Northeim" | kreis_wohn =="Goslar" | kreis_wohn=="Gˆttingen" | kreis_wohn=="Osterode am Harz")
replace catchment_area_wohn =9 if f8_1==2
replace catchment_area_wohn =8 if f8_2==7

gen catchment_area_start = 1 if bundesland_wohn==2
replace catchment_area_start =2 if kreis_wohn=="Dithmarschen" | kreis_wohn=="Steinburg" | kreis_wohn=="Pinneberg" | kreis_wohn=="Segeberg" | kreis_wohn=="Stormarn" | kreis_wohn=="Herzogtum Lauenburg"
replace catchment_area_start =3 if kreis_wohn=="L¸neburg" | kreis_wohn=="L¸chow-Dannenberg" | kreis_wohn=="Uelzen" | kreis_wohn=="Soltau-Fallingbostel" | kreis_wohn=="Rotenburg (W¸mme)" | kreis_wohn=="Stade" | kreis_wohn=="Cuxhaven" | kreis_wohn=="Harburg"
replace catchment_area_start =4 if kreis_wohn=="Kiel"
replace catchment_area_start =5 if kreis_wohn=="L¸beck"
replace catchment_area_start =6 if missing(catchment_area_start) & (bundesland_wohn==13 | bundesland_wohn==1 | bundesland_wohn==3 | bundesland_wohn==4 | kreis_wohn=="Prignitz" | kreis_wohn=="Stendal" | kreis_wohn=="Ostprignitz_Ruppin" | kreis_wohn=="Altmarkkreis Salzwedel") 
replace catchment_area_start =7 if (missing(catchment_area_start) & f5_1==1) | (kreis_wohn=="Holzminden" | kreis_wohn=="Northeim" | kreis_wohn =="Goslar" | kreis_wohn=="Gˆttingen" | kreis_wohn=="Osterode am Harz")
replace catchment_area_start =9 if f8_1==2
replace catchment_area_start =8 if f8_2==7

quietly label define c_a 1  `"Hamburg"', modify
quietly label define c_a 2  `"Metropolregion HH Schleswig-Holstein"', modify
quietly label define c_a 3  `"Metropolregion HH Niedersachsen"', modify
quietly label define c_a 4  `"Kiel"', modify
quietly label define c_a 5  `"L¸beck"', modify
quietly label define c_a 6  `"Einzugsgebiet auﬂerhalb MRH"', modify
quietly label define c_a 7  `"Restdeutschland"', modify
quietly label define c_a 8  `"D‰nemark"', modify
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


gen catchment_area_wohn_diff = catchment_area_wohn
replace catchment_area_wohn_diff = 10 if bundesland_wohn==2 & Bezirke_HH_wohn == 6 
replace catchment_area_wohn_diff = 10 if bundesland_wohn==2 & (Stadtteil_HH_wohn == 119 | Stadtteil_HH_wohn == 121)

gen catchment_area_start_diff = catchment_area_start
replace catchment_area_start_diff = 10 if bundesland_start==2 & Bezirke_HH_start == 6 
replace catchment_area_start_diff = 10 if bundesland_start==2 & (Stadtteil_HH_start == 119 | Stadtteil_HH_start == 121)


quietly label define c_a 1  `"Hamburg Nord"', modify
quietly label define c_a 10  `"Hamburg S¸d"', modify

label value catchment_area_wohn_diff c_a
label value catchment_area_start_diff c_a

label variable catchment_area_wohn_diff "Differenziertes Einzugsgebiet Wohnen"
label variable catchment_area_start_diff "Differenziertes Einzugsgebiet Aufbruch"


label define c_a_einf 1 `"HH Nord"', modify
label define c_a_einf 10 `"HH S¸d"', modify
label define c_a_einf 2 `"MRH SH"', modify
label define c_a_einf 3 `"MRH NS"', modify
label define c_a_einf 4 `"Kiel"', modify
label define c_a_einf 5 `"L¸beck"', modify
label define c_a_einf 6 `"CA ex MRH"', modify
label define c_a_einf 7 `"restl. BRD"', modify
label define c_a_einf 8 `"D‰nemark"', modify
label define c_a_einf 9 `"Ausland"', modify

gen Einzugsgebiet_Start = catchment_area_start_diff
gen Einzugsgebiet_Wohn = catchment_area_wohn_diff

label value Einzugsgebiet_* c_a_einf


quietly tab catchment_area_wohn_diff, gen(ca_wohn_diff_)
quietly tab catchment_area_start_diff, gen(ca_start_diff_)


 
recode geschlecht (2=0)
label define geschlecht 0 `"weiblich"', modify
label define geschlecht 1 `"m‰nnlich"', modify
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

gen hrg3 = 1 if f1_1==1 | f1_1==6
replace hrg3 =2 if f1_1==2
replace hrg3 = 3 if f1_1==3 | f1_1==4 | f1_1==5
label define hrg3 1 `"dienstlich"', modify
label define hrg3 2 `"Urlaub"', modify
label define hrg3 3 `"privat"', modify
label value hrg3 hrg3
tab hrg3, gen(hrg3_)

* tab f13_aggr, gen(reisedauer_)
* tab f24_aggr, gen(vorausbuchung_)

gen log_f32 = log(f32)
gen log_f24 = log(f24_neu)
gen log_f38_HAM = log(f38_HAM+1)
gen log_f13 = log(f13)
gen z_mct_1n = tz_2 == 1
gen  kurzreise =  f13<4
gen herbst = welle==3
label value herbst jn
label define welle 1`"Fr¸hling"', modify
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
label define startort 5 `"auﬂerhalb Einzugsgebiet"', modify
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

tab flugart, gen(flugart_)


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG10_3.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_11_sch‰tz.dta", clear
append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG10_3.dta"

gen s_bahn = Jahr==2009 | Jahr==2010 | (Jahr==2008 & Monat==12)
label value s_bahn jn
tab f13_aggr, gen(reisedauer_)
gen reisedauer_13 = f13<7
label var reisedauer_13 "Reise k¸rzer 7 Tage"

* gen fahrzeit_oev = fahrzeit*vm_diff_3
* gen fahrzeit_miv = fahrzeit*vm_1
* gen fahrzeit_nmiv = fahrzeit*vm_3

replace bundesland_start=2 if f3a=="22145"
replace bundesland_wohn=2 if f7a=="22145"
replace gemeinde_start="Hamburg" if f3a=="22145"
replace gemeinde_wohn="Hamburg" if f7a=="22145"
replace kreis_start="Hamburg" if f3a=="22145"
replace kreis_wohn="Hamburg" if f7a=="22145"

replace Startort=1 if bundesland_start==2


gen jan_auﬂerhalb = Startort==1
replace jan_auﬂerhalb = 1 if f3a =="21465"
replace jan_auﬂerhalb = 1 if f3a =="21502"
replace jan_auﬂerhalb = 1 if f3a =="21509"
replace jan_auﬂerhalb = 1 if f3a =="21521"
replace jan_auﬂerhalb = 1 if f3a =="21614"
replace jan_auﬂerhalb = 1 if f3a =="21629"
* replace jan_auﬂerhalb = 1 if f3a =="21635"
replace jan_auﬂerhalb = 1 if f3a =="22113"
replace jan_auﬂerhalb = 1 if f3a =="22844"
replace jan_auﬂerhalb = 1 if f3a =="22850"
* replace jan_auﬂerhalb = 1 if f3a =="22851"
replace jan_auﬂerhalb = 1 if f3a =="22869"
replace jan_auﬂerhalb = 1 if f3a =="22880"
replace jan_auﬂerhalb = 1 if f3a =="22885"
replace jan_auﬂerhalb = 1 if f3a =="22927"
replace jan_auﬂerhalb = 1 if f3a =="25421"
replace jan_auﬂerhalb = 1 if f3a =="25469"
label value jan_auﬂerhalb jn




* br  f3a  abreise ankunft fahrzeit_* if Jahr==2010 & Startort==1

* logit  vm_diff_3  f61  alt1_2 s_bahn  tz_2  reisedauer_13   flugart_1 flugart_2 reise_allein  hrg3_1 hrg3_2 hrg3_3 ziel_1 ziel_2 ziel_3 ca_wohn_diff_1  herkunft_2  jz_1     if Startort==1 & Stunde<25 & (Jahr ==2008 | Jahr==2010) & f12n<3
* logit  vm_diff_3  f61  alt1_2 s_bahn  tz_2  reisedauer_13   flugart_1 flugart_2 reise_allein  hrg3_1 hrg3_2 hrg3_3 ziel_1 ziel_2 ziel_3 ca_wohn_diff_1  herkunft_2  jz_1     if Startort==1 & Stunde<25  & f12n<3
* tab f32_aggr, gen(Aufenthaltszeit_)
gen wichtung_hilf = subinstr(wichtung,",","",1) if Jahr==2010
destring(wichtung_hilf), gen(wichtung_n)
drop wichtung_hilf

gen hvm_neu =  VM_Zubring_0_diff
replace hvm_neu=3 if vm_3==1 & f60_1>1&f60_1<6
replace hvm_neu=7 if (vm_1==1 & (f60_1>1&f60_1<6)|(f60_2>1&f60_2<6)) | (vm_diff_3==1 & (f60_1==1 | f60_2==1))
replace hvm_neu=8 if f25==5 | f25==6
replace hvm_neu=.a if hvm_neu==8 & (f60_1>1&f60_1<6)|(f60_2>1&f60_2<6)
replace hvm_neu=.b if hvm_neu==6
replace hvm_neu=.c if hvm_neu==4

lab var hvm_neu "Anreiseverkehrsmittel, 8 Klassen"

label define hvm_neu 3 `"÷PNV"', modify
label define hvm_neu 2 `"MIV-lang"', modify
label define hvm_neu 1 `"MIV-kurz"', modify
label define hvm_neu 4 `"÷PFV"', modify
label define hvm_neu 5 `"NMIV"', modify
label define hvm_neu 6 `"Flug"', modify
label define hvm_neu 7 `"P&R"', modify
label define hvm_neu 8 `"Taxi&Leihwagen"', modify
label define hvm_neu .a `"Taxi&Leihwagen + ÷V"', modify
label define hvm_neu .c `"÷PFV"', modify
label define hvm_neu .b `"Flug"', modify
label value hvm_neu hvm_neu


gen hvm_neu2 = hvm_neu
replace hvm_neu2=1 if hvm_neu==8
label value hvm_neu2 hvm_neu

gen hvm_neu3 = hvm_neu
replace hvm_neu3=1 if hvm_neu==8 | hvm_neu==2
label value hvm_neu3 hvm_neu



save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge.dta", replace

* outsheet f3a  abreise ankunft  vm_1 vm_diff_3 vm_3 fahrzeit_* wichtung_n using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Fahrzeiten_2010_alternativ.txt"  if Jahr==2010 & Startort==1, noq non replace
* outsheet  lfd  f3a  abreise ankunft vm_1 vm_diff_3 vm_3 fahrzeit_* wichtung_n using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Fahrzeiten_2010_alternativ_name.txt"  if Jahr==2010 & Startort==1, noq replace
* outsheet  lfd f3a  abreise ankunft vm_1 vm_diff_3 vm_3 fahrzeit_* flug_hoch* using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Fahrzeiten_2008_alternativ_name.txt"  if Jahr==2008 & Startort==1, noq replace
* outsheet f3a  abreise ankunft  vm_1 vm_diff_3 vm_3 fahrzeit_* wichtung_n using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Fahrzeiten_2010_alternativ_oev_suche.txt"  if Jahr==2010 & Startort==1 & vm_diff_3==0, noq non replace
* outsheet lfd f3a Jahr  vm_diff_3  vm_1 vm_3 f60_* VM_Kette  f37 f37a_1 f37a_2 f37b_1 f37b_2  abreise ankunft  fahrzeit   using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\÷V_Kette.txt" if (Jahr==2010 | Jahr==2008)  & Startort==1, noq replace


clear

insheet using "S:\Modell\Nachfragemodell\Flughafen\÷V_Angebot_wpsc.txt"
rename f3a kurz
tostring(zip_codec5), gen(f3a)

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\÷V_Anschluss_HH2.dta", replace
clear
insheet using "S:\Modell\Nachfragemodell\Flughafen\2010_2.txt"
tostring(f3a), replace
rename jahr Jahr
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\altert_FZ_10_2.dta", replace
clear
insheet using "S:\Modell\Nachfragemodell\Flughafen\2008.txt"
tostring(f3a), replace
rename jahr Jahr
replace lfd=219062+1000000 if id==4104
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\altert_FZ_08_2.dta", replace


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge.dta", clear
rename s_bahn s_bahnanschluss
tostring(f3a), replace
merge f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\÷V_Anschluss_HH2.dta", uniqusing keep( s_bahn r_bahn u_bahn alle ang_*) _merge(ttt) sort
drop ttt

replace s_bahn=0 if s_bahnanschluss==0 & f3a=="22335"
replace lfd=219062+1000000 if lfd==219062 & Jahr==2008 & f48_1==4
tab s_bahn, gen(s_halt_)
tab u_bahn, gen(u_halt_)

merge lfd Jahr using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\altert_FZ_10_2.dta", uniqusing keep( t_miv t_oev l_miv uh) _merge(ttt) sort

merge lfd Jahr f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\altert_FZ_08_2.dta", uniqusing keep( t_miv t_oev l_miv uh) _merge(tttt) sort update

gen kurzweg=l_miv<=1
label value kurzweg jn
* logit  vm_diff_3  f61  alt1_2 s_bahnanschluss kurzweg alle  s_halt_1  u_halt_4 tz_2  reisedauer_13   flugart_1 flugart_2 reise_allein  hrg3_1 hrg3_2 hrg3_3 ziel_1 ziel_2 ziel_3 ca_wohn_diff_1  herkunft_2  jz_1     if Startort==1 & Stunde<25 & (Jahr ==2008 | Jahr==2010)
* logit  vm_diff_3  f61  verh_t   diff_t alt1_2  kurzweg alle  s_halt_1   tz_2     reise_allein  hrg3_1   ziel_1 ziel_2 ziel_3 ca_wohn_diff_1    jz_1     if Startort==1 & Stunde<25 & Jahr==2010

replace t_miv = fahrzeit if Jahr==2010 & hvm_neu3<3
gen t_miv_l = t_miv +5
replace t_miv_l = t_miv+15 if f27>7
replace t_miv_l = t_miv+7 if f27==1
replace t_miv_l = t_miv+20 if f27==11
replace t_miv_l = t_miv+10 if f27==12
* replace t_miv_l = fahrzeit if hvm_neu2==2

replace t_oev = fahrzeit if Jahr==2010 & hvm_neu2==3

tab hvm_neu2, gen(hvm_neu2_)
tab hvm_neu3, gen(hvm_neu3_)
gen hvm_neu3_5 = missing(hvm_neu3)
replace flug_hochr = wichtung_n if Jahr==2010


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge2.dta", replace

outsheet  lfd  f3a  abreise ankunft  hvm_neu?_*   wichtung_n using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Fahrzeiten_2010_alternativ_name_neu.txt"  if Jahr==2010 & jan_auﬂerhalb, noq replace
outsheet  lfd f3a  abreise ankunft hvm_neu?_*  flug_hoch* using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Fahrzeiten_2008_alternativ_name_neu.txt"  if Jahr==2008 & jan_auﬂerhalb, noq replace
replace hvm_neu2=9 if missing(hvm_neu2)
 * mlogit  hvm_neu2  s_bahnanschluss herkunft_2 f61 f31 t_miv   t_miv_l t_oev l_miv uh alter alter2  s_halt_1   tz_1  f13   reise_allein reise_kind  hrg3_1   ziel_2 ziel_1 ca_wohn_diff_1    jz_1     if  jan_auﬂerhalb & Stunde<25 & (Jahr==2010|Jahr==2008), base(2)
 * mlogit  hvm_neu2  s_bahnanschluss herkunft_2 f61 f31 t_miv   t_miv_l t_oev l_miv uh alter alter2  s_halt_1   tz_1  f13   reise_allein reise_kind  hrg3_1   werktag ziel_1 ca_wohn_diff_1    if  jan_auﬂerhalb & Stunde<25 & (Jahr==2010|Jahr==2008) & hvm_neu2<8, base(2)
 

