clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_6.dta", clear

drop Zweck Zweck_text wegpaar wegekette wegekette_home arbeit bilden eink_ap freizeit kindergarten


* Sortierung für Datenanalyse
sort HHID PID WSIDN


* Zweck generieren Hilfsvariablen: Wegzweck (W04)	 Spezifikation (W04_DZW)	Quelle (W01) 	Ziel (W13)
* Wegezwecke zusammengefasst

bysort HHID PID: gen Zweck = 2 if W04 == 1 | W13 == 2 
bysort HHID PID: replace Zweck = 2 if W04_DZW==715
bysort HHID PID: replace Zweck = 11 if  W04 == 9
bysort HHID PID: replace Zweck = 2 if Zweck==11 & Zweck[_n-2]==2 & _n>2
bysort HHID PID: replace Zweck = 2 if Zweck==11 & W01[_n-1] == 2 &_n==2
bysort HHID PID: replace Zweck = 2 if W04[_n-1] == 1 | W04 == 14
bysort HHID PID: replace Zweck = 5 if W04 == 3 | W04 == 31
bysort HHID PID: replace Zweck = 1 if W04 == 8| W13 == 1
bysort HHID PID: replace Zweck = 10 if W04 == 11 | W04 == 6
bysort HHID PID: replace Zweck = 7 if W04 == 7 | W04 == 5
bysort HHID PID: replace Zweck = 6 if W04 == 32
bysort HHID PID: replace Zweck = 8 if W04 == 10| W04 > 100
bysort HHID PID: replace Zweck = 12 if  W04_DZW == 701
bysort HHID PID: replace Zweck = 9 if (W01 == 1 & W13 == 1) | W13 == 5 | (W04_DZW>709 & W04_DZW<713)
bysort HHID PID: replace Zweck = 14 if W04 == 2 & WSID < 100
bysort HHID PID: replace Zweck = 3 if W04_DZW == 501
bysort HHID PID: replace Zweck = 4 if (W04_DZW > 501 & W04_DZW < 600) | (W04==4 & W04_DZW==.a)
bysort HHID PID: replace Zweck = 2 if Zweck==11 & Zweck[_n-2]==2 & _n>1
* bysort HHID PID: replace Zweck = 2 if Zweck==11 & (Zweck[_n-1]==9 |Zweck[_n-2]==2) & _n>2
bysort HHID PID: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==1 | W01[_n-2]==1) & _n>2
bysort HHID PID: replace Zweck = 1 if Zweck==11 & (Zweck[_n-2]==9 | W01[_n-2]==1) & _n>2
bysort HHID PID: replace Zweck = 5 if Zweck==11 & Zweck[_n-2]==5 & _n>2
bysort HHID PID: replace Zweck = 12 if Zweck==11 & (W01[_n-1] >2)  &_n==2
bysort HHID PID: replace Zweck = 15 if W04_DZW==503
bysort HHID PID: replace Zweck = 12 if Zweck==11 & Zweck[_n-2]==12 & _n>2
bysort HHID PID: replace Zweck = 13 if WSID > 100

label var Zweck "ausgeführte Zielaktivität"

label define Zweck 2 `"A: Arbeit"', modify
label define Zweck 1 `"W: Wohnen"', modify
label define Zweck 3 `"E_per: Einkauf periodisch"', modify
label define Zweck 4 `"E_aper: Einkauf aperiodisch"', modify
label define Zweck 5 `"B: Bilden"', modify
label define Zweck 6 `"K: Kindergarten"', modify
label define Zweck 7 `"F/E: Freizeit / Erledigung"', modify
label define Zweck 8 `"S: Sonstige"', modify
label define Zweck 9 `"Ru: Rundgang (Sport, Hund, spazieren)"', modify
label define Zweck 10 `"Begl: Begleitung"', modify
label define Zweck 11 `"Rü: Rückweg"', modify
label define Zweck 12 `"FW: Besuch von Freunden/Verwandten, fremde Wohnung"', modify
label define Zweck 13 `"d_per: dienstlich per"', modify
label define Zweck 14 `"d_aper: dienstlich aper"', modify
label define Zweck 15 `"E_b: Einkaufsbummel "', modify

label value Zweck Zweck


* Textfelder für Wegeketten
gen Zweck_text = "A" if Zweck==2
replace Zweck_text = "W" if Zweck ==1
replace Zweck_text = "E_per" if Zweck ==3
replace Zweck_text = "E_aper" if Zweck ==4
replace Zweck_text = "B" if Zweck ==5
replace Zweck_text = "K" if Zweck ==6
replace Zweck_text = "F/E" if Zweck ==7
replace Zweck_text = "S" if Zweck ==8
replace Zweck_text = "Ru" if Zweck ==9
replace Zweck_text = "Begl" if Zweck ==10
replace Zweck_text = "Rü" if Zweck ==11
replace Zweck_text = "FW" if Zweck ==12
replace Zweck_text = "d_per" if Zweck ==13
replace Zweck_text = "d_aper" if Zweck ==14
replace Zweck_text = "E_b" if Zweck ==15

label var Zweck_text "ausgeführte Zielaktivität im Textformat"

* Wegeketten

* Wegepaare generieren:
bysort HHID PID:gen wegpaar = Zweck_text[_n-1]+"-"+Zweck_text[_n]
bysort HHID PID:replace wegpaar = "W"+"-"+Zweck_text[_n] if _n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101))
bysort HHID PID:replace wegpaar = "W"+"-"+Zweck_text[_n] if Zweck[_n-1] ==9 & Zweck!=1 & ((_n-1==1 & (W01 [_n-1] == 1  | (WSOURCE[_n-1] == 1 & WSIDN[_n-1] ==101)))|(Zweck[_n-2]==1&_n>1))
bysort HHID PID:replace wegpaar = "FW"+"-"+Zweck_text[_n] if W01 > 2 & WSIDN[_n]==1
bysort HHID PID:replace wegpaar = "A"+"-"+Zweck_text[_n] if W01 ==2 & WSIDN==1 
bysort HHID PID:replace wegpaar = "A"+"-"+Zweck_text[_n] if (W01 > 1 | W01 <5) & WSIDN==1 & W13 == 1 & W04 ==1 
bysort HHID PID:replace wegpaar = "A"+"-"+Zweck_text[_n] if Zweck[_n-2] ==2 & Zweck[_n-1]==9 & _n>1
bysort HHID PID:replace wegpaar = "FW"+"-"+Zweck_text[_n] if Zweck[_n-1] ==9 & Zweck[_n-2]==12 & _n>1
bysort HHID PID:replace wegpaar = "FW"+"-"+Zweck_text[_n] if _n==1 &  (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 
bysort HHID PID:replace wegpaar = "B"+"-"+Zweck_text[_n] if (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 & (W04 ==3 | W04 ==31)



* bysort HHID PID:replace wegpaar = "S"+" - "+Zweck_text[_n] if (W01 == 4 | W01 ==3)  & WSIDN[_n]==1 & W13 == 1 

label var wegpaar "Aktivitätenpaare aus Hauptzwecken"

* Wegekette generieren:
bysort HHID PID: gen wegekette = wegpaar[_n] if _n==1
bysort HHID PID: replace wegekette = wegekette[_n-1]+";"+ wegpaar[_n] if _n>1
bysort HHID PID:replace wegekette = wegekette[_n-1]+";"+ wegpaar[_n] + "-W" if wegende==1  & W04 ==9

label var wegekette "Aktivitätenkette über den gesamten Tagesverlauf"

* Wegeketten generieren mit Wohnen als Heimbasis
* bysort HHID PID: gen wegekette_home = wegpaar[_n] if _n==1 | Zweck_text[_n-1] == "W"
* bysort HHID PID: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
* label var wegekette_home "heimbasierte Aktivitätenkette"

* drop Zweck_text 

* heim- und arbeitsbasierte Wege (Boolean)
gen arbeit = (( Zweck==2)| (W01 ==2 & WSIDN==1))
gen bilden = (( Zweck==5)| (W01 ==3 & WSIDN==1))
gen eink_ap = (Zweck==4)
gen freizeit = (Zweck == 7|Zweck == 10|Zweck == 12)
gen kindergarten = (Zweck == 6)
* gen heim = (Zweck==1 | ( _n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101))))

* bysort HHID PID: gen ha_heim_arbeit_ID = _n if WSIDN==1|heim==1|arbeit==1

* Personen mit Hauptaktivität herausschreiben
* replace id_hhp =  HHID*10+PID
* sort   id_hhp arbeit
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_8.dta", replace

