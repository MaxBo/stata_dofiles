clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_10.dta", clear

gen Zweck2 = Zweck
replace Zweck2 = 3 if  W074==4 & Zweck==10
replace Zweck2 = 4 if  W074==6 & Zweck==10
replace Zweck2 = 15 if  W074==8 & Zweck==10
replace Zweck2 = 5 if W074==3 & Zweck==10
replace Zweck2 = 2 if W074==1 & Zweck==10
replace Zweck2 = 17 if W074==5 & Zweck==10
replace Zweck2 = 9 if W074==9 & Zweck==10

label value Zweck2 Zweck

duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==3, gen(mgl_bgl_ekp)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==4, gen(mgl_bgl_ekap)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==15, gen(mgl_bgl_ekb)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==2 | Zweck2==14, gen(mgl_bgl_arb)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==17, gen(mgl_bgl_erl)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==6, gen(mgl_bgl_kiga)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==5, gen(mgl_bgl_bild)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2==9, gen(mgl_bgl_rund)
duplicates tag HHID  ST_TIME EN_TIME Zweck2  if Zweck2!=13 & Zweck2!=10, gen(mgl_bgl)
* sort HHID PID WSIDN
* sort HHID ST_TIME EN_TIME
duplicates tag HHID  ST_TIME EN_TIME if Zweck!=13, gen(mgl_bgl_alle)

replace W074 = .b if Zweck2==13
replace W074 = .z if mgl_bgl_alle==0 & missing(W074)
label define W074 .b `"rbw"', modify
label define W074 .a `"keine Angabe"', modify
label define W074 .z `"kein Begleitweg"', modify
label define W074 2 `"Kindergarten"', modify
label define W074 99 `"gemeinsamer Weg für die jeweilige Aktivität"', modify
label define W074 98 `"Person mit Hauptweg"', modify
label value W074 W074


foreach x in "ekp" "ekap" "ekb" "arb" "erl" "kiga" "bild" "rund" "alle"{

sort HHID PID WSIDN
quietly bysort HHID ST_TIME EN_TIME mgl_bgl_`x':  gen Anz_dupl_`x' = _n if mgl_bgl_`x'>0 & mgl_bgl_`x'<10
quietly bysort HHID ST_TIME EN_TIME mgl_bgl_`x':  gen Anz_Summe_`x' = Anz_dupl_`x'[_N] if mgl_bgl_`x'>0 & mgl_bgl_`x'<10
}
merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_4.dta",sort uniqusing keep(HPP_BESCH_ang) _merge(Besch_neu)
drop if missing(WID)
drop Besch_neu
label value  HPP_BESCH_ang  HP_BESCH
replace W074=1 if mgl_bgl_arb>0 & mgl_bgl_arb<100 & missing(W074) & HPP_BESCH_ang>4 & HPP_BESCH_ang<20 & Anz_dupl_arb<100
replace W074=3 if mgl_bgl_bild>0 & mgl_bgl_bild<100 & HP_ALTER>22 & HPP_BESCH_ang!=5 & missing(W074)
replace W074=2 if mgl_bgl_kiga>0 & mgl_bgl_kiga<100 & HP_ALTER>12 & HPP_BESCH_ang!=8 & missing(W074)
replace W074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekp<100 & HP_ALTER<13 & missing(W074)
replace W074=6 if mgl_bgl_ekap>0 & mgl_bgl_ekap<100 & HP_ALTER<13 & missing(W074)
replace W074=8 if mgl_bgl_ekb>0 & mgl_bgl_ekb<100 & HP_ALTER<13 & missing(W074)
replace W074=5 if mgl_bgl_erl>0 & mgl_bgl_erl<100 & HP_ALTER<13 & missing(W074)
replace W074=9 if mgl_bgl_rund>0 & mgl_bgl_rund<100 & Anz_dupl_rund<100 & missing(W074)

replace W074=1 if mgl_bgl_arb>0 & mgl_bgl_arb<100 & missing(W074) & akt_dauer<30
replace W074=3 if mgl_bgl_bild>0 & mgl_bgl_bild<100 & missing(W074) & akt_dauer<30

replace W074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekp<100 &  missing(W074) & Anz_dupl_ekp<100 & Anz_dupl_ekp>1 & HP_ALTER<20
replace W074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekap<100 &  missing(W074) & Anz_dupl_ekap<100 & Anz_dupl_ekap>1 & HP_ALTER<20
replace W074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekb<100 &  missing(W074) & Anz_dupl_ekb<100 & Anz_dupl_ekb>1 & HP_ALTER<20

replace W074=99 if mgl_bgl_arb>0 & mgl_bgl_arb<100 & missing(W074) & akt_dauer>30
replace W074=99 if missing(W074) & mgl_bgl_alle>0 & mgl_bgl_alle<100

replace W074=98 if Zweck2==5 & HPP_BESCH_ang==5
replace W074=98 if Zweck2==6 & HPP_BESCH_ang==8

* bysort HHID 


replace Zweck2 = 18 if W074==1 
replace Zweck2 = 19 if W074==3 
replace Zweck2 = 20 if W074==5 
replace Zweck2 = 21 if W074==4
replace Zweck2 = 22 if W074==8
replace Zweck2 = 23 if W074==9 
replace Zweck2 = 24 if (W074==7 | W074==10 | W074==6 )& Zweck2==10


label define Zweck 18 `"BeglA: Begleitung bei Arbeitsweg"', modify
label define Zweck 19 `"BeglS: Begleitung bei Schulweg"', modify
label define Zweck 20 `"BeglErl: Begleitung bei Erledigungsweg"', modify
label define Zweck 21 `"BeglE_per: Begleitung bei Einkaufsweg täglicher Bedarf"', modify
label define Zweck 22 `"BeglE_b: Begleitung bei Einkaufsbummel"', modify
label define Zweck 23 `"R_gem: gemeinsamer Rundgang"', modify
label define Zweck 24 `"Begl_So: sonstiger Begleitweg"', modify

label value Zweck2 Zweck
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_10_test.dta", replace
drop if mgl_bgl_alle==0 | missing(mgl_bgl_alle)
keep HHID PID ST_TIME EN_TIME WSIDN mgl_bgl_alle
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\doppelte_wege.dta", replace
duplicates drop HHID ST_TIME EN_TIME, force
sort HHID ST_TIME EN_TIME
bysort HHID: gen mgl_bgl_alle_gr =_n
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\doppelte_wege2.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_10_test.dta", clear
merge HHID ST_TIME EN_TIME using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\doppelte_wege2.dta",sort uniqusing keep(mgl_bgl_alle_gr) _merge(_merge)
drop _merge
gen prüf_bgl_hh = 0
forvalues i=1/8 {
quietly replace prüf_bgl_hh = prüf_bgl_hh + W072_`i' if W072_`i'<2
}


* forvalues i=1/mgl_bgl_alle {

* }

* replace W074=98 if Zweck2==



* replace Zweck2=13 if mgl_bgl_arb>0 & HP_ALTER<18 & W074==1 &  Anz_dupl_arb<100

* sort HHID PID WSIDN mgl_bgl_arb
* bysort HHID mgl_bgl_ek: gen Anz_dupl_arb = _n if mgl_bgl_arb>0 & mgl_bgl_arb<10



* tab1 mgl_bgl_*
 