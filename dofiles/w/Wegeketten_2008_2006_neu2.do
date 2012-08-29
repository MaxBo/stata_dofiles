clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_8.dta", clear

drop Zweck Zweck_text wegpaar wegekette arbeit bilden eink_ap freizeit kindergarten werktag

replace W072_2 = .a if W072_2<0
replace W072_3 = .a if W072_3<0
replace W072_4 = .a if W072_4<0
replace W072_5 = .a if W072_5<0
replace W072_6 = .a if W072_6<0
replace W072_7 = .a if W072_7<0
replace W072_8 = .a if W072_8<0
replace W072_9 = .a if W072_9<0
replace W072_10 = .a if W072_10<0

label define W072_2 .a `"keine Angabe"', modify
label define W072_3 .a `"keine Angabe"', modify
label define W072_4 .a `"keine Angabe"', modify
label define W072_5 .a `"keine Angabe"', modify
label define W072_6 .a `"keine Angabe"', modify
label define W072_7 .a `"keine Angabe"', modify
label define W072_8 .a `"keine Angabe"', modify
label define W072_9 .a `"keine Angabe"', modify
label define W072_10 .a `"keine Angabe"', modify

label value W072_2 W072_2
label value W072_3 W072_3
label value W072_4 W072_4
label value W072_5 W072_5
label value W072_6 W072_6
label value W072_7 W072_7
label value W072_8 W072_8
label value W072_9 W072_9
label value W072_10 W072_10


replace W01=.a if W01==-39
replace  zweck_angep=1 if HP_ALTER<14 & W04<3 &  (W071==1 | W07S==0)
replace W074 = 1 if HP_ALTER<14 & W04<3 &  (W071==1 | W07S ==0)
replace  W04=11 if HP_ALTER<14 & W04<3 &  (W071==1 | W07S ==0)
replace zweck_angep=1 if HP_ALTER<5 & W04==3
replace W04=32 if HP_ALTER<5 & W04==3
replace zweck_angep=1 if HP_ALTER>4 &HP_ALTER<14 & W04<3
replace W074=1 if HP_ALTER>4 &HP_ALTER<14 & W04<3
replace W04=3 if HP_ALTER>4 & HP_ALTER<14 & W04<3
replace  zweck_angep=1 if HP_ALTER<7 & W04<9 & W07S ==0
replace  W04=11 if HP_ALTER<7 & W04<9 & W07S ==0
replace zweck_angep = 1 if HP_ALTER<7 & W04_DZW == 501 & W07S ==0
replace W074 = 4 if HP_ALTER<7 & W04_DZW == 501 & W07S ==0
replace W04 = 11 if HP_ALTER<7 & W04_DZW == 501 & W07S ==0
replace zweck_angep = 1 if HP_ALTER<7 & ((W04_DZW > 501 & W04_DZW < 600) | (W04==4 & W04_DZW==.a)) & W07S ==0
replace W074 = 6 if HP_ALTER<7 & ((W04_DZW > 501 & W04_DZW < 600) | (W04==4 & W04_DZW==.a)) & W07S ==0
replace W04 = 11 if HP_ALTER<7 & ((W04_DZW > 501 & W04_DZW < 600) | (W04==4 & W04_DZW==.a)) & W07S ==0
replace zweck_angep = 1 if HP_ALTER<7 & W04_DZW > 503  & W07S ==0
replace W074 = 8 if HP_ALTER<7 & W04_DZW > 503  & W07S ==0
replace W04 = 11 if HP_ALTER<7 & W04_DZW > 503 & W07S ==0
replace zweck_angep = 1 if HP_ALTER<7 & ((W01 == 1 & W13 == 1) | W13 == 5 | (W04_DZW>709 & W04_DZW<713))  & W07S ==0
replace W074 = 9 if HP_ALTER<7 & ((W01 == 1 & W13 == 1) | W13 == 5 | (W04_DZW>709 & W04_DZW<713))  & W07S ==0
replace W04 = 11 if HP_ALTER<7 & ((W01 == 1 & W13 == 1) | W13 == 5 | (W04_DZW>709 & W04_DZW<713)) & W07S ==0


label define W074 4 `"periodischer Einkauf"', modify
label define W074 6 `"aperiodischer Einkauf"', modify
label define W074 8 `"Einkaufsbummel"', modify
label define W074 9 `"Rundgang"', modify
label value W074 W074


* Sortierung für Datenanalyse
sort HHID PID WSIDN


* Zweck generieren Hilfsvariablen: Wegzweck (W04)	 Spezifikation (W04_DZW)	Quelle (W01) 	Ziel (W13)
* Wegezwecke zusammengefasst

bysort HHID PID: gen Zweck = 2 if W04 == 1 | W13 == 2 

bysort HHID PID: replace Zweck = 11 if  W04 == 9

bysort HHID PID: replace Zweck = 2 if Zweck==11 & Zweck[_n-2]==2 & _n>1
bysort HHID PID: replace Zweck = 2 if Zweck==11 & W01[_n-1] == 2 &_n==2
bysort HHID PID: replace Zweck = 2 if W04[_n-1] == 1 | W04 == 14
bysort HHID PID: replace Zweck = 5 if W04 == 3 | W04 == 31
bysort HHID PID: replace Zweck = 1 if W04 == 8| W13 == 1
bysort HHID PID: replace Zweck = 10 if W04 == 11 | W04 == 6

bysort HHID PID: replace Zweck = 7 if W04 == 7 | W04 == 5
bysort HHID PID: replace Zweck = 6 if W04 == 32

bysort HHID PID: replace Zweck = 12 if  W04_DZW == 701

bysort HHID PID: replace Zweck = 3 if W04_DZW == 501 & W04!=11
bysort HHID PID: replace Zweck = 4 if ((W04_DZW > 501 & W04_DZW < 600) | (W04==4 & W04_DZW==.a))& W04!=11

bysort HHID PID: replace Zweck = 8 if W04 == 10| W04 > 100
bysort HHID PID: replace Zweck = 8 if W04_DZW == 604| W04_DZW == 699 | W04_DZW == 720| W04_DZW == 799 

bysort HHID PID: replace Zweck = 9 if ((W01 == 1 & W13 == 1) | W13 == 5 | (W04_DZW>709 & W04_DZW<713)) & W04!=11
bysort HHID PID: replace Zweck = 14 if W04 == 2 & WSID < 100
bysort HHID PID: replace Zweck = 2 if W04_DZW==715
bysort HHID PID: replace Zweck = 10 if W04_DZW == 11 | W04_DZW == 716
bysort HHID PID: replace Zweck = 15 if W04_DZW==503 & W04!=11
bysort HHID PID: replace Zweck = 16 if W04_DZW==704
bysort HHID PID: replace Zweck = 17 if (W04_DZW>600 & W04_DZW<604) | W04_DZW==605 | W04_DZW==705 | W04_DZW==714

* bysort HHID PID: replace Zweck = 2 if Zweck==11 & (Zweck[_n-1]==9 |Zweck[_n-2]==2) & _n>2
bysort HHID PID: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==1 | W01[_n-2]==1) & _n>2
bysort HHID PID: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==9 | W01[_n-2]==1) & _n>2
bysort HHID PID: replace Zweck = 5 if Zweck==11 & Zweck[_n-2]==5 & _n>2
bysort HHID PID: replace Zweck = 12 if Zweck==11 & (W01[_n-1] >2)  &_n==2
bysort HHID PID: replace Zweck = 12 if Zweck==11 & Zweck[_n-2]==12 & _n>2
bysort HHID PID: replace Zweck = 13 if WSID > 100
bysort HHID PID: replace Zweck = Zweck[_n-2] if  _n>2 & HP_ALTER<7 & W07S==0 & Zweck==2




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
bysort HHID PID:gen wegpaar = Zweck_text[_n-1]+"-"+Zweck_text[_n]
bysort HHID PID:replace wegpaar = "W"+"-"+Zweck_text[_n] if _n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101))
bysort HHID PID:replace wegpaar = "W"+"-"+Zweck_text[_n] if Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (W01 [_n-1] == 1  | (WSOURCE[_n-1] == 1 & WSIDN[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1))
bysort HHID PID:replace wegpaar = "A"+"-"+Zweck_text[_n] if W01 ==2 & WSIDN==1 
bysort HHID PID:replace wegpaar = "A"+"-"+Zweck_text[_n] if (W01 > 1 | W01 <5) & WSIDN==1 & W13 == 1 & W04 ==1 
bysort HHID PID:replace wegpaar = "A"+"-"+Zweck_text[_n] if Zweck[_n-2] ==2 & Zweck[_n-1]==9 & _n>1
bysort HHID PID:replace wegpaar = "FW"+"-"+Zweck_text[_n] if Zweck[_n-1] ==9 & Zweck[_n-2]==12 & _n>1
bysort HHID PID:replace wegpaar = "FW"+"-"+Zweck_text[_n] if _n==1 &  (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 
bysort HHID PID:replace wegpaar = "B"+"-"+Zweck_text[_n] if (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 & (W04 ==3 | W04 ==31)
bysort HHID PID:replace wegpaar = "FW"+"-"+Zweck_text[_n] if W01 > 2 & WSIDN[_n]==1


* bysort HHID PID:replace wegpaar = "S"+" - "+Zweck_text[_n] if (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 

label var wegpaar "Aktivitätenpaare aus Hauptzwecken"

* Wegekette generieren:
bysort HHID PID: gen wegekette = wegpaar[_n] if _n==1
bysort HHID PID: replace wegekette = wegekette[_n-1]+";"+ wegpaar[_n] if _n>1
bysort HHID PID:replace wegekette = wegekette[_n-1]+";"+ wegpaar[_n] + "-W" if wegende==1  & W04 ==9

label var wegekette "Aktivitätenkette über den gesamten Tagesverlauf"

* Wegeketten generieren mit Wohnen als Heimbasis
* bysort HHID PID: gen wegekette_home = wegpaar[_n] if (_n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101))) |(Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (W01 [_n-1] == 1  | (WSOURCE[_n-1] == 1 & WSIDN[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1)))
bysort HHID PID: gen wk=(_n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101)))
bysort HHID PID: replace wk=1 if Zweck[_n-1]==1
bysort HHID PID: replace wk=1 if Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (W01 [_n-1] == 1  | (WSOURCE[_n-1] == 1 & WSIDN[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1))
bysort HHID PID: gen wg_n = wk
bysort HHID PID: replace wg_n = wg_n[_n] +wg_n[_n-1] if _n>1
sort HHID PID WSIDN
bysort HHID PID wg_n: gen wg_n2 = _n

bysort HHID PID wg_n: gen wegekette_home = wegpaar[_n] if _n==1
bysort HHID PID wg_n: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
label var wegekette_home "heimbasierte Aktivitätenkette"

bysort HHID PID wg_n: gen zeitsummefahr_heim= sum(fahrzeit)
bysort HHID PID wg_n: gen zeitsummeakt_heim= sum(akt_dauer)
bysort HHID PID wg_n: gen fahrtlaenge_heim = sum(WEGKM_K)
bysort HHID PID: gen fahrtlaenge = sum(WEGKM_K)
bysort HHID PID wg_n: gen Anz_Wege_heim = _N

bysort HHID PID wg_n: gen wegende_home = wg_n2==_N


drop Zweck_text 

* heim- und arbeitsbasierte Wege (Boolean)
gen arbeit = (( Zweck==2)| (W01 ==2 & WSIDN==1))
gen bilden = (( Zweck==5)| (W01 ==3 & WSIDN==1))
gen eink_ap = (Zweck==4)
gen freizeit = (Zweck == 7|Zweck == 10|Zweck == 12)
gen kindergarten = (Zweck == 6)
* gen heim = (Zweck==1 | ( _n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101))))

* bysort HHID PID: gen ha_heim_arbeit_ID = _n if WSIDN==1|heim==1|arbeit==1
sort HHID PID WSIDN
bysort HHID PID: replace weganfang=1 if _n==1
bysort HHID PID: replace weganfang=0 if missing(weganfang)
bysort HHID PID: replace wegende=1 if WSIDN==_N
bysort HHID PID: replace wegende=0 if missing(wegende)
gen werktag= STICHTAG<6

* drop Zweck_text

* Personen mit Hauptaktivität herausschreiben
* replace id_hhp =  HHID*10+PID
* sort   id_hhp arbeit
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_9.dta", replace

