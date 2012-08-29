clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege_zeitn.dta", clear

* duplicates drop hhid pid w04  w04_dzw w01 w13 st_time  en_time if wid<100, force
* drop Zweck wegpaar wegekette wegekette_home
label define w072_2 .a `"keine Angabe"', modify
forvalue i=2/10{
replace w072_`i' = .a if w072_`i'<0
label value w072_`i' w072_2
}


gen zweck_angep = 0
replace w01=.a if w01==-39
replace  zweck_angep=1 if hp_alter<14 & w04<3 &  (w071==1 | begleit==0)
replace w074 = 1 if hp_alter<14 & w04<3 &  (w071==1 | begleit ==0)
replace  w04=11 if hp_alter<14 & w04<3 &  (w071==1 | begleit ==0)
replace zweck_angep=1 if hp_alter<5 & w04==3
replace w04=32 if hp_alter<5 & w04==3
replace zweck_angep=1 if hp_alter>4 &hp_alter<14 & w04<3
replace w074=1 if hp_alter>4 &hp_alter<14 & w04<3
replace w04=3 if hp_alter>4 & hp_alter<14 & w04<3
replace  zweck_angep=1 if hp_alter<7 & w04<9 & begleit ==0
replace  w04=11 if hp_alter<7 & w04<9 & begleit ==0
replace zweck_angep = 1 if hp_alter<7 & w04_dzw == 501 & begleit ==0
replace w074 = 4 if hp_alter<7 & w04_dzw == 501 & begleit ==0
replace w04 = 11 if hp_alter<7 & w04_dzw == 501 & begleit ==0
replace zweck_angep = 1 if hp_alter<7 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a)) & begleit ==0
replace w074 = 6 if hp_alter<7 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a)) & begleit ==0
replace w04 = 11 if hp_alter<7 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a)) & begleit ==0
replace zweck_angep = 1 if hp_alter<7 & w04_dzw > 503  & begleit ==0
replace w074 = 8 if hp_alter<7 & w04_dzw > 503  & begleit ==0
replace w04 = 11 if hp_alter<7 & w04_dzw > 503 & begleit ==0
replace zweck_angep = 1 if hp_alter<7 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713))  & begleit ==0
replace w074 = 9 if hp_alter<7 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713))  & begleit ==0
replace w04 = 11 if hp_alter<7 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713)) & begleit ==0


label define w074 4 `"periodischer Einkauf"', modify
label define w074 6 `"aperiodischer Einkauf"', modify
label define w074 8 `"Einkaufsbummel"', modify
label define w074 9 `"Rundgang"', modify
label value w074 w074


* Sortierung für Datenanalyse
sort hhid pid  st_time en_time
bysort hhid pid: gen wsidn = _n

sort hhid pid wsidn

bysort hhid pid: gen weganfang=1 if _n==1
bysort hhid pid: replace weganfang=0 if missing(weganfang)
bysort hhid pid: gen wegende=1 if wsid==_N
bysort hhid pid: replace wegende=0 if missing(wegende)
gen werktag= stichtag<6

* Zweck generieren Hilfsvariablen: Wegzweck (w04)	 Spezifikation (w04_dzw)	Quelle (w01) 	Ziel (w13)
* Wegezwecke zusammengefasst
sort hhid pid wsidn
bysort hhid pid: gen Zweck = 2 if w04 == 1 | w13 == 2 

bysort hhid pid: replace Zweck = 11 if  w04 == 9

bysort hhid pid: replace Zweck = 2 if Zweck==11 & Zweck[_n-2]==2 & _n>1
bysort hhid pid: replace Zweck = 2 if Zweck==11 & w01[_n-1] == 2 &_n==2
bysort hhid pid: replace Zweck = 2 if w04[_n-1] == 1 | w04 == 14
bysort hhid pid: replace Zweck = 5 if w04 == 3 | w04 == 31
bysort hhid pid: replace Zweck = 1 if w04 == 8| w13 == 1
bysort hhid pid: replace Zweck = 10 if w04 == 11 | w04 == 6
bysort hhid pid: replace Zweck = 18 if w04 == 6

bysort hhid pid: replace Zweck = 7 if w04 == 7 | w04 == 5
bysort hhid pid: replace Zweck = 6 if w04 == 32

bysort hhid pid: replace Zweck = 12 if  w04_dzw == 701

bysort hhid pid: replace Zweck = 3 if w04_dzw == 501 & w04!=11
bysort hhid pid: replace Zweck = 4 if ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))& w04!=11

bysort hhid pid: replace Zweck = 8 if w04 == 10| w04 > 100
bysort hhid pid: replace Zweck = 8 if w04_dzw == 604| w04_dzw == 699 | w04_dzw == 720| w04_dzw == 799 

bysort hhid pid: replace Zweck = 9 if ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713)) & w04!=11
bysort hhid pid: replace Zweck = 14 if w04 == 2 & wsid < 100
bysort hhid pid: replace Zweck = 2 if w04_dzw==715
bysort hhid pid: replace Zweck = 10 if w04_dzw == 11 | w04_dzw == 716
bysort hhid pid: replace Zweck = 15 if w04_dzw==503 & w04!=11
bysort hhid pid: replace Zweck = 16 if w04_dzw==704
bysort hhid pid: replace Zweck = 17 if (w04_dzw>600 & w04_dzw<604) | w04_dzw==605 | w04_dzw==705 | w04_dzw==714

* bysort hhid pid: replace Zweck = 2 if Zweck==11 & (Zweck[_n-1]==9 |Zweck[_n-2]==2) & _n>2
bysort hhid pid: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==1 | w01[_n-2]==1) & _n>2
bysort hhid pid: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==9 | w01[_n-2]==1) & _n>2
bysort hhid pid: replace Zweck = 5 if Zweck==11 & Zweck[_n-2]==5 & _n>2
bysort hhid pid: replace Zweck = 12 if Zweck==11 & (w01[_n-1] >2)  &_n==2
bysort hhid pid: replace Zweck = 12 if Zweck==11 & Zweck[_n-2]==12 & _n>2
bysort hhid pid: replace Zweck = 13 if wsid > 100
bysort hhid pid: replace Zweck = Zweck[_n-2] if  _n>2 & hp_alter<7 & begleit==0 & Zweck==2




label var Zweck "ausgeführte Zielaktivität"

label define Zweck 2 `"A: Arbeit"', modify
label define Zweck 1 `"W: Wohnen"', modify
label define Zweck 3 `"E_per: Einkauf periodisch"', modify
label define Zweck 4 `"E_aper: Einkauf aperiodisch"', modify
label define Zweck 5 `"B: Bilden"', modify
label define Zweck 6 `"K: Kindergarten"', modify
label define Zweck 7 `"F: Freizeit / Erledigung"', modify
label define Zweck 8 `"S: Sonstige"', modify
label define Zweck 9 `"Ru: Rundgang (Sport, Hund, spazieren)"', modify
label define Zweck 10 `"Begl: Begleitung"', modify
label define Zweck 11 `"Rü: Rückweg"', modify
label define Zweck 12 `"FW: Besuch von Freunden/Verwandten, fremde Wohnung"', modify
label define Zweck 13 `"d_per: dienstlich per"', modify
label define Zweck 14 `"d_aper: dienstlich aper"', modify
label define Zweck 15 `"E_b: Einkaufsbummel"', modify
label define Zweck 16 `"Sp: Sport"', modify
label define Zweck 17 `"Erl: Erledigungen"', modify
label define Zweck 18 `"Br: Bringen / Holen"', modify

label value Zweck Zweck


* Textfelder für Wegeketten
gen Zweck_text = "A" if Zweck==2
replace Zweck_text = "W" if Zweck ==1
replace Zweck_text = "E_per" if Zweck ==3
replace Zweck_text = "E_aper" if Zweck ==4
replace Zweck_text = "B" if Zweck ==5
replace Zweck_text = "K" if Zweck ==6
replace Zweck_text = "F" if Zweck ==7
replace Zweck_text = "S" if Zweck ==8
replace Zweck_text = "Ru" if Zweck ==9
replace Zweck_text = "Begl" if Zweck ==10
replace Zweck_text = "Rü" if Zweck ==11
replace Zweck_text = "FW" if Zweck ==12
replace Zweck_text = "d_per" if Zweck ==13
replace Zweck_text = "d_aper" if Zweck ==14
replace Zweck_text = "E_b" if Zweck ==15
replace Zweck_text = "Sp" if Zweck ==16
replace Zweck_text = "Erl" if Zweck ==17
replace Zweck_text = "Br" if Zweck ==18

label var Zweck_text "ausgeführte Zielaktivität im Textformat"

* Wegeketten

* Wegepaare generieren:
bysort hhid pid:gen wegpaar = Zweck_text[_n-1]+"-"+Zweck_text[_n]
bysort hhid pid:replace wegpaar = "W"+"-"+Zweck_text[_n] if _n==1 & (w01 == 1  | (wsource == 1 & wsid ==101))
bysort hhid pid:replace wegpaar = "W"+"-"+Zweck_text[_n] if Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (w01 [_n-1] == 1  | (wsource[_n-1] == 1 & wsid[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1))
bysort hhid pid:replace wegpaar = "A"+"-"+Zweck_text[_n] if w01 ==2 & wsid==1 
bysort hhid pid:replace wegpaar = "A"+"-"+Zweck_text[_n] if (w01 > 1 | w01 <5) & wsid==1 & w13 == 1 & w04 ==1 
bysort hhid pid:replace wegpaar = "A"+"-"+Zweck_text[_n] if Zweck[_n-2] ==2 & Zweck[_n-1]==9 & _n>1
bysort hhid pid:replace wegpaar = "FW"+"-"+Zweck_text[_n] if Zweck[_n-1] ==9 & Zweck[_n-2]==12 & _n>1
bysort hhid pid:replace wegpaar = "FW"+"-"+Zweck_text[_n] if _n==1 &  (w01 == 4 | w01 ==3)  & wsid[_n]==1 & w13 == 1 
bysort hhid pid:replace wegpaar = "B"+"-"+Zweck_text[_n] if (w01 == 4 | w01 ==3)  & wsid[_n]==1 & w13 == 1 & (w04 ==3 | w04 ==31)
bysort hhid pid:replace wegpaar = "FW"+"-"+Zweck_text[_n] if w01 > 2 & wsid[_n]==1


* bysort hhid pid:replace wegpaar = "S"+" - "+Zweck_text[_n] if (w01 == 4 | w01 ==3)  & wsid[_n]==1 & w13 == 1 

label var wegpaar "Aktivitätenpaare aus Hauptzwecken"

* Wegekette generieren:
bysort hhid pid: gen wegekette = wegpaar[_n] if _n==1
bysort hhid pid: replace wegekette = wegekette[_n-1]+";"+ wegpaar[_n] if _n>1
bysort hhid pid:replace wegekette = wegekette[_n-1]+";"+ wegpaar[_n] + "-W" if wegende==1  & w04 ==9

label var wegekette "Aktivitätenkette über den gesamten Tagesverlauf"

* Wegeketten generieren mit Wohnen als Heimbasis
* bysort hhid pid: gen wegekette_home = wegpaar[_n] if (_n==1 & (w01 == 1  | (wsource == 1 & wsid ==101))) |(Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (w01 [_n-1] == 1  | (wsource[_n-1] == 1 & wsid[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1)))
bysort hhid pid: gen wk=(_n==1 & (w01 == 1  | (wsource == 1 & wsid ==101)))
bysort hhid pid: replace wk=1 if Zweck[_n-1]==1
bysort hhid pid: replace wk=1 if Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (w01 [_n-1] == 1  | (wsource[_n-1] == 1 & wsid[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1))
bysort hhid pid: gen wg_n = wk
bysort hhid pid: replace wg_n = wg_n[_n] +wg_n[_n-1] if _n>1
sort hhid pid wsid
bysort hhid pid wg_n: gen wg_n2 = _n

bysort hhid pid wg_n: gen wegekette_home = wegpaar[_n] if _n==1
bysort hhid pid wg_n: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
label var wegekette_home "heimbasierte Aktivitätenkette"

bysort hhid pid wg_n: gen zeitsummefahr_heim= sum(fahrzeit)
bysort hhid pid wg_n: gen zeitsummeakt_heim= sum(akt_dauer)
bysort hhid pid wg_n: gen fahrtlaenge_heim = sum(wegkm_k)
bysort hhid pid: gen fahrtlaenge = sum(wegkm_k)
bysort hhid pid wg_n: gen Anz_Wege_heim = _N

bysort hhid pid wg_n: gen wegende_home = wg_n2==_N


drop Zweck_text 

* heim- und arbeitsbasierte Wege (Boolean)
gen arbeit = (( Zweck==2)| (w01 ==2 & wsid==1))
gen bilden = (( Zweck==5)| (w01 ==3 & wsid==1))
gen eink_ap = (Zweck==4)
gen freizeit = (Zweck == 7|Zweck == 10|Zweck == 12)
gen kindergarten = (Zweck == 6)
* gen heim = (Zweck==1 | ( _n==1 & (w01 == 1  | (wsource == 1 & wsid ==101))))

* bysort hhid pid: gen ha_heim_arbeit_ID = _n if wsid==1|heim==1|arbeit==1
bysort pergrup wegekette: gen sum_pergr_wk = _N if wegende==1
bysort pergrup: gen anteil = sum_pergr_wk/_N if wegende==1

gen Zweck2 = Zweck
replace Zweck2 = 3 if  w074==4 & Zweck==10
replace Zweck2 = 4 if  w074==6 & Zweck==10
replace Zweck2 = 15 if  w074==8 & Zweck==10
replace Zweck2 = 5 if w074==3 & Zweck==10
replace Zweck2 = 2 if w074==1 & Zweck==10
replace Zweck2 = 17 if w074==5 & Zweck==10
replace Zweck2 = 9 if w074==9 & Zweck==10

label value Zweck2 Zweck

duplicates tag hhid  st_time en_time Zweck2  if Zweck2==3, gen(mgl_bgl_ekp)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==4, gen(mgl_bgl_ekap)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==15, gen(mgl_bgl_ekb)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==2 | Zweck2==14, gen(mgl_bgl_arb)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==17, gen(mgl_bgl_erl)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==6, gen(mgl_bgl_kiga)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==5, gen(mgl_bgl_bild)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2==9, gen(mgl_bgl_rund)
duplicates tag hhid  st_time en_time Zweck2  if Zweck2!=13 & Zweck2!=10, gen(mgl_bgl)
* sort hhid pid WSIDN
* sort HHID ST_TIME EN_TIME
duplicates tag hhid  st_time en_time if Zweck!=13, gen(mgl_bgl_alle)

replace w074 = .b if Zweck2==13
replace w074 = .z if mgl_bgl_alle==0 & missing(w074)
label define w074 .b `"rbw"', modify
label define w074 .a `"keine Angabe"', modify
label define w074 .z `"kein Begleitweg"', modify
label define w074 2 `"Kindergarten"', modify
label define w074 99 `"gemeinsamer Weg für die jeweilige Aktivität"', modify
label define w074 98 `"Person mit Hauptweg"', modify
label value w074 w074


foreach x in "ekp" "ekap" "ekb" "arb" "erl" "kiga" "bild" "rund" "alle"{

sort hhid pid wsidn
quietly bysort hhid st_time en_time mgl_bgl_`x':  gen Anz_dupl_`x' = _n if mgl_bgl_`x'>0 & mgl_bgl_`x'<10
quietly bysort hhid st_time en_time mgl_bgl_`x':  gen Anz_Summe_`x' = Anz_dupl_`x'[_N] if mgl_bgl_`x'>0 & mgl_bgl_`x'<10
}

merge hhid pid using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Personen.dta",sort uniqusing keep(HPP_BESCH_ang) _merge(Besch_neu)
drop if missing(wid)
drop Besch_neu
label value  HPP_BESCH_ang  hp_besch
replace w074=1 if mgl_bgl_arb>0 & mgl_bgl_arb<100 & missing(w074) & HPP_BESCH_ang>4 & HPP_BESCH_ang<20 & Anz_dupl_arb<100
replace w074=3 if mgl_bgl_bild>0 & mgl_bgl_bild<100 & hp_alter>22 & HPP_BESCH_ang!=5 & missing(w074)
replace w074=2 if mgl_bgl_kiga>0 & mgl_bgl_kiga<100 & hp_alter>12 & HPP_BESCH_ang!=8 & missing(w074)
replace w074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekp<100 & hp_alter<13 & missing(w074)
replace w074=6 if mgl_bgl_ekap>0 & mgl_bgl_ekap<100 & hp_alter<13 & missing(w074)
replace w074=8 if mgl_bgl_ekb>0 & mgl_bgl_ekb<100 & hp_alter<13 & missing(w074)
replace w074=5 if mgl_bgl_erl>0 & mgl_bgl_erl<100 & hp_alter<13 & missing(w074)
replace w074=9 if mgl_bgl_rund>0 & mgl_bgl_rund<100 & Anz_dupl_rund<100 & missing(w074)

replace w074=1 if mgl_bgl_arb>0 & mgl_bgl_arb<100 & missing(w074) & akt_dauer<30
replace w074=3 if mgl_bgl_bild>0 & mgl_bgl_bild<100 & missing(w074) & akt_dauer<30

replace w074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekp<100 &  missing(w074) & Anz_dupl_ekp<100 & Anz_dupl_ekp>1 & hp_alter<20
replace w074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekap<100 &  missing(w074) & Anz_dupl_ekap<100 & Anz_dupl_ekap>1 & hp_alter<20
replace w074=4 if mgl_bgl_ekp>0 & mgl_bgl_ekb<100 &  missing(w074) & Anz_dupl_ekb<100 & Anz_dupl_ekb>1 & hp_alter<20

replace w074=99 if mgl_bgl_arb>0 & mgl_bgl_arb<100 & missing(w074) & akt_dauer>30
replace w074=99 if missing(w074) & mgl_bgl_alle>0 & mgl_bgl_alle<100

replace w074=98 if Zweck2==5 & HPP_BESCH_ang==5
replace w074=98 if Zweck2==6 & HPP_BESCH_ang==8

* bysort HHID 


replace Zweck2 = 18 if w074==1 
replace Zweck2 = 19 if w074==3 
replace Zweck2 = 20 if w074==5 
replace Zweck2 = 21 if w074==4
replace Zweck2 = 22 if w074==8
replace Zweck2 = 23 if w074==9 
replace Zweck2 = 24 if (w074==7 | w074==10 | w074==6 )& Zweck2==10


label define Zweck 18 `"BeglA: Begleitung bei Arbeitsweg"', modify
label define Zweck 19 `"BeglS: Begleitung bei Schulweg"', modify
label define Zweck 20 `"BeglErl: Begleitung bei Erledigungsweg"', modify
label define Zweck 21 `"BeglE_per: Begleitung bei Einkaufsweg täglicher Bedarf"', modify
label define Zweck 22 `"BeglE_b: Begleitung bei Einkaufsbummel"', modify
label define Zweck 23 `"R_gem: gemeinsamer Rundgang"', modify
label define Zweck 24 `"Begl_So: sonstiger Begleitweg"', modify

label value Zweck2 Zweck
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD_2008_PUF_Wege_10_test.dta", replace
drop if mgl_bgl_alle==0 | missing(mgl_bgl_alle)
keep hhid pid st_time en_time wsidn mgl_bgl_alle
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\doppelte_wege.dta", replace
duplicates drop hhid st_time en_time, force
sort hhid st_time en_time
bysort hhid: gen mgl_bgl_alle_gr =_n
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\doppelte_wege2.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD_2008_PUF_Wege_10_test.dta", clear
merge hhid st_time en_timeusing "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\\doppelte_wege2.dta",sort uniqusing keep(mgl_bgl_alle_gr) _merge(_merge)
drop _merge
gen prüf_bgl_hh = 0
forvalues i=1/8 {
quietly replace prüf_bgl_hh = prüf_bgl_hh + w072_`i' if w072_`i'<2
}

