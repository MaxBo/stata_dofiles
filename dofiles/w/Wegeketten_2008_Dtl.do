clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_PUF\MiD2008_PUF_Wege_zeitn.dta", clear

* drop Zweck wegpaar wegekette wegekette_home


* Sortierung für Datenanalyse
sort hhid pid wsid


* Zweck generieren Hilfsvariablen: Wegzweck (w04)	 Spezifikation (w04_dzw)	Quelle (w01) 	Ziel (w13)
* Wegezwecke zusammengefasst

bysort hhid pid: gen Zweck = 2 if w04 == 1 | w13 == 2 

bysort hhid pid: replace Zweck = 11 if  w04 == 9

bysort hhid pid: replace Zweck = 2 if Zweck==11 & Zweck[_n-2]==2 & _n>1
bysort hhid pid: replace Zweck = 2 if Zweck==11 & w01[_n-1] == 2 &_n==2
bysort hhid pid: replace Zweck = 2 if w04[_n-1] == 1 | w04 == 14
bysort hhid pid: replace Zweck = 5 if w04 == 3 | w04 == 31
bysort hhid pid: replace Zweck = 1 if w04 == 8| w13 == 1
bysort hhid pid: replace Zweck = 10 if w04 == 11 | w04 == 6

bysort hhid pid: replace Zweck = 7 if w04 == 7 | w04 == 5
bysort hhid pid: replace Zweck = 6 if w04 == 32

bysort hhid pid: replace Zweck = 12 if  w04_dzw == 701

bysort hhid pid: replace Zweck = 3 if w04_dzw == 501 & w04!=11
bysort hhid pid: replace Zweck = 4 if ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))& w04!=11

bysort hhid pid: replace Zweck = 8 if w04 == 10| w04 > 100
bysort hhid pid: replace Zweck = 8 if w04_dzw == 604| w04_dzw == 699 | w04_dzw == 720| w04_dzw == 799 

bysort hhid pid: replace Zweck = 9 if ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713)) & w04!=11
bysort hhid pid: replace Zweck = 14 if w04 == 2 & WSID < 100
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
bysort hhid pid: replace Zweck = 13 if WSID > 100
bysort hhid pid: replace Zweck = Zweck[_n-2] if  _n>2 & HP_ALTER<7 & begleit==0 & Zweck==2




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
sort HHID PID wsid
bysort HHID PID wg_n: gen wg_n2 = _n

bysort HHID PID wg_n: gen wegekette_home = wegpaar[_n] if _n==1
bysort HHID PID wg_n: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
label var wegekette_home "heimbasierte Aktivitätenkette"

bysort HHID PID wg_n: gen zeitsummefahr_heim= sum(fahrzeit)
bysort HHID PID wg_n: gen zeitsummeakt_heim= sum(akt_dauer)
bysort HHID PID wg_n: gen fahrtlaenge_heim = sum(wegkm_k)
bysort hhid pid: gen fahrtlaenge = sum(wegkm_k)
bysort HHID PID wg_n: gen Anz_Wege_heim = _N

bysort HHID PID wg_n: gen wegende_home = wg_n2==_N


drop Zweck_text 

* heim- und arbeitsbasierte Wege (Boolean)
gen arbeit = (( Zweck==2)| (w01 ==2 & wsid==1))
gen bilden = (( Zweck==5)| (w01 ==3 & wsid==1))
gen eink_ap = (Zweck==4)
gen freizeit = (Zweck == 7|Zweck == 10|Zweck == 12)
gen kindergarten = (Zweck == 6)
* gen heim = (Zweck==1 | ( _n==1 & (w01 == 1  | (wsource == 1 & wsid ==101))))

* bysort hhid pid: gen ha_heim_arbeit_ID = _n if wsid==1|heim==1|arbeit==1
sort HHID PID wsid
bysort hhid pid: replace weganfang=1 if _n==1
bysort hhid pid: replace weganfang=0 if missing(weganfang)
bysort hhid pid: replace wegende=1 if wsid==_N
bysort hhid pid: replace wegende=0 if missing(wegende)
gen werktag= stichtag<6