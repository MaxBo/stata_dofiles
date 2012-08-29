clear
set memory  700m
insheet using "C:\Spitzencluster Luftverkehr\Kommunikation\Konferenzen\2011\07_WPSC_Perth\fehlende_plz.txt"
tostring plz, gen(f3a)
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\fehlende_plz.dta", replace
clear
insheet using "S:\Modell\Nachfragemodell\Flughafen\fahrzeiten_2000er.txt"
tostring plz, gen(f3a)
gen Jahr=2010
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\fz_2000er.dta", replace

clear
insheet using "S:\Modell\Nachfragemodell\Flughafen\fahrpreis_ˆv_grob.txt"
tostring plz, gen(f3a)
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\kosten_oev.dta", replace


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge2.dta", clear


merge f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\fehlende_plz.dta", sort uniqusing keep(fz fw) _merge(plz_fehl)
merge lfd Jahr using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\fz_2000er.dta", sort uniqusing keep(fz_ges umsteigehufigkeit) _merge(fz_2000er)
merge f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\kosten_oev.dta", sort uniqusing keep(fahrpreis_08 fahrpreis_10) _merge(fahrpreis)



gen t_miv_hilf = t_miv
replace t_miv=32 if f3a=="22145" & missing(t_miv)
replace l_miv=20 if f3a=="22145" & missing(l_miv)
replace t_oev=60 if f3a=="22145" & missing(t_oev) & Jahr==2008
replace uh=1 if f3a=="22145" & missing(uh) & Jahr==2008

replace t_oev=round(fz_ges) if missing(t_oev)
replace uh = umsteigehufigkeit if missing(uh)
 
replace t_miv = fz if Jahr ==2010 & hvm_neu2>2 & missing(t_miv)
replace l_miv = fw if Jahr==2010 & missing(l_miv)
replace t_oev = fahrzeit if Jahr==2010 & hvm_neu2==3
replace t_miv = fahrzeit if Jahr==2010 & hvm_neu2<3 & l_miv/fahrzeit*60<=65 | fahrzeit<=10
replace t_miv_l = t_miv +5 if hvm_neu2!=2
replace t_miv_l = t_miv if hvm_neu2==2


replace t_miv = t_miv_l-10 if f27>7 & f27<.
replace t_miv = t_miv_l-5 if f27<3
replace t_miv = t_miv_l-15 if f27==11
replace t_miv = t_miv_l-8 if f27==12
replace t_miv = t_miv_l-7  if f27>3 & f27<7

replace t_miv = 3*t_miv if Stunde>7 & Stunde<=19 & hvm_neu2>2  &  ca_start_diff_1==0
replace t_miv = 2*t_miv if Stunde>7 & Stunde<=19 & hvm_neu2>2  &  ca_start_diff_1==1
replace t_miv_l = t_miv + 5 if hvm_neu2!=2


gen hvm_aggr = 1 if hvm_neu2<3
replace hvm_aggr = 2 if hvm_neu2==3|hvm_neu2==7
replace hvm_aggr = 3 if hvm_neu2==5

label define hvm_aggr 2 `"÷PNV"', modify
label define hvm_aggr 3 `"NMIV"', modify
label define hvm_aggr 1 `"MIV"', modify
label value hvm_aggr hvm_aggr

* mlogit  hvm_neu2  s_bahnanschluss  t_miv   t_miv_l t_oev l_miv uh  tz_1 jz_1 f13 f31  reise_allein hrg3_1 hrg3_2 ziel_1  f61 ca_wohn_diff_1 herkunft_2 alter alter2  if  jan_auﬂerhalb & Stunde<25 & (Jahr==2010|Jahr==2008), base(2)
* mlogit  hvm_aggr  s_bahnanschluss  t_miv   t_miv_l t_oev l_miv uh  tz_1 jz_1 f13 f31  reise_allein hrg3_1 hrg3_2 ziel_1  f61 ca_wohn_diff_1 herkunft_2 alter alter2  if  jan_auﬂerhalb & Stunde<25 & (Jahr==2010|Jahr==2008)
* replace hvm_neu2=9 if missing(hvm_neu2)


gen t_1 = t_miv
gen t_2 = t_miv_l
gen t_3 = t_oev
gen t_5 = l_miv/3*60
gen t_7 = t_oev - 15
gen t_8 = t_1 + 10
* replace t_8= fahrzeit if hvm_neu==8
* gen t_9 = t_miv
gen uh_1 = 0
gen uh_2 = 0
gen uh_7= uh-1 if uh>=0
replace uh_7=0 if uh==0
gen uh_5 =0
gen uh_8= 0
gen uh_3 = uh
* gen uh_9= uh
* drop uh
* 
rename t_miv tmiv
rename t_oev toev
rename t_miv_l tmiv_l

drop if missing(welle)
tostring lfd, gen(lfd_string)
tostring Jahr, gen(Jahr_string)
gen lfd_jahr = Jahr_string + lfd_string
destring(lfd_jahr), replace



drop if jan_auﬂerhalb==0 
drop if Jahr==2006|Jahr==2009
drop _merge

* drop hvm_neu2_*
* tab hvm_neu2, gen(hvm_neu2_)

* case2alt, choice(hvm_neu2) case(lfd_jahr) altnum(vm_long)



* drop ytemp1

* label value _altnum hvm_neu2

* reshape wide, i(lfd_jahr)
* mlogit  hvm_neu2  s_bahnanschluss  t_miv t_miv_l t_oev t_5 uh tz_1 jz_1 f13 f31 reise_allein hrg3_1  ziel_1  f61 ca_wohn_diff_1 herkunft_2 alter alter2 geschlecht if  jan_auﬂerhalb & Stunde<25 & (Jahr==2008|Jahr==2010) & hvm_neu2<8, base(2)

* predict prob_*
* quietly tab hvm_neu2 ,matrow(vars)
* local rows = rowsof(vars)
* gen float cum=0
* gen hvm_sch‰tz=.
* gen float random=runiform()
* forvalues i= 1/5 {
* 	replace cum = cum + prob_`i' if prob_`i' <.
*	replace hvm_sch‰tz=vars[`i',1] if (cum>=random & hvm_sch‰tz ==.)
*	}
* replace hheink_imp=HHEINK if (hheink_imp >=.)
* label value hvm_sch‰tz hvm_neu



* mlogit  hvm_neu3  s_bahnanschluss  t_miv  t_oev t_5 uh tz_1 jz_1 f13 f31 reise_allein hrg3_1  ziel_1  f61 ca_wohn_diff_1 herkunft_2 alter alter2 geschlecht if  jan_auﬂerhalb & Stunde<25 & (Jahr==2010|Jahr==2008) & hvm_neu2<8

* predict prob_aggr_*

* quietly tab hvm_neu2 ,matrow(vars)
* local rows = rowsof(vars)
* gen float cum2=0
* gen hvm_sch‰tz_aggr=.
* gen float random2=runiform()
* forvalues i= 1/4 {
*	replace cum2 = cum2 + prob_`i' if prob_aggr_`i' <.
*	replace hvm_sch‰tz_aggr=vars[`i',1] if (cum2>=random2 & hvm_sch‰tz_aggr ==.)
*		}
* outsheet  f3a lfd  ankunft abreise hvm_neu2 fahrzeit using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\fehlende_verbindung2.txt" if (missing(hvm_sch‰tz) | missing(t_oev)|missing(uh)) & Jahr==2010, noquote replace
* outsheet  f3a lfd  ankunft abreise hvm_neu2 fahrzeit using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\fehlende_verbindung.txt" if missing(hvm_sch‰tz) & Jahr==2010, noquote replace
* tab hvm_neu2 hvm_sch‰tz

gen cmiv=l_miv*0.3
gen cpmivk=1.5
* replace cpmivk = 1.5 if f25==1
replace cpmivk =  3 if f25==2

gen cmiv_t = 2.70 + 1.85*round(l_miv) if l_miv<5
replace cmiv_t = cmiv +1.75*round(l_miv) if l_miv>4& l_miv<11
replace cmiv_t = cmiv + 1.28*round(l_miv) if  l_miv>10
replace cmiv_t = 2.7 if l_miv<1.1
* replace cmiv_t = 0 if missing(cmiv_t)
* replace cmiv = 0 if f25==6 | f25==12 | f25==26 | f25==26
* replace cmiv=cmiv_t if f25==5




* gen cmiv_l = l_miv*0.3
gen cmiv_l =  21*f13 if f13<7 & f27<3
replace cmiv_l=24*f13 if f27>3 & f27<7
replace cmiv_l=12 if f25==3

replace cmiv_l =  100 + 3*(f13-7) if f13<14 & f13>6 & f27<3
replace cmiv_l =  120 + 2*(f13-14) if f13>13 & f27<3

replace cmiv_l =  15*f13 if f13<7 & f27==8
replace cmiv_l =  60 + 3*(f13-7) if f13<14 & f13>6 & f27==8
replace cmiv_l =  75 + 3*(f13-14) if f13>13 & f27==8

replace cmiv_l =  18*f13 if f13<7 & (f27==9 | hvm_neu2!=2)
replace cmiv_l =  70 + 3*(f13-7) if f13<14 & f13>6 & (f27==9  | hvm_neu2!=2)
replace cmiv_l =  85 + 3*(f13-14) if f13>13 & (f27==9  | hvm_neu2!=2)

replace cmiv_l =  17 if f13<3 & (f27==11|f27==10) | f25==3
replace cmiv_l =  36 if f13>2 & f13<5 & (f27==11|f27==10)
replace cmiv_l =  45 if f13>4 & f13<7 & (f27==11|f27==10)
replace cmiv_l =  55 if f13>6 & f13<9 & (f27==11|f27==10)
replace cmiv_l =  64 if f13>8 & f13<12 & (f27==11|f27==10)
replace cmiv_l =  67 if f13>11 & f13<16 & (f27==11|f27==10)
replace cmiv_l =  95 if f13==30 & (f27==11|f27==10)
replace cmiv_l = 18.50 + 22*f13

replace cmiv_l= 5 if missing(cmiv_l)
replace cmiv_l=400 if cmiv_l>400

gen coev = fahrpreis_08 if Jahr==2008
replace coev = fahrpreis_10 if Jahr==2010
replace coev = 0 if f61==1
replace coev = 0 if (f62>6 & f62<16) | (f62>26 & f62<.)
replace coev = 2.60 if Jahr==2008 & f62==17
replace coev = 2.95 if Jahr==2008 & f62==18
replace coev = 2.60 if Jahr==2008 & f62==17
replace coev = 2.95 if Jahr==2008 & f62==18
replace coev = 3.15 if Jahr==2010 & f62==17
replace coev = 4.25 if Jahr==2010 & f62==18


gen c_1=cmiv
gen c_2=cmiv
gen c_3=coev
gen c_5=0
gen c_7=coev
gen c_8=cmiv_t

gen cp_1= cpmivk
gen cp_2= cmiv_l
gen cp_3=0
gen cp_5=0
gen cp_7=0
gen cp_8=0

gen hvm_neu_t= hvm_neu2
replace hvm_neu_t=8 if f25==5

mlogit  hvm_neu2  s_bahnanschluss  tmiv  toev t_5 uh coev cmiv  cpmivk cmiv_l tz_1 jz_1 f13 f31 reise_allein hrg3_1  ziel_1  f61 ca_wohn_diff_1 herkunft_2 alter alter2 geschlecht if  Stunde<25  & hvm_neu2<8
predict prob_vm_*

quietly tab hvm_neu2 ,matrow(vars)
gen float cum2=0
gen hvm_sch‰tz_aggr=.
gen float random2=runiform()
 forvalues i= 1/5 {
	replace cum2 = cum2 + prob_vm_`i' if prob_vm_`i' <.
	replace hvm_sch‰tz_aggr=vars[`i',1] if (cum2>=random2 & hvm_sch‰tz_aggr ==.)
		}
label value hvm_sch‰tz_aggr hvm_neu

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge_red.dta", replace


