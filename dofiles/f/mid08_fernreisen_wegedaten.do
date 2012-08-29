clear
set memory 700m
use "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\MiD2008\Daten\STATA\STATA_Public Use File\MiD2008_PUF_Wege_label.dta", clear

recode oek_stat (9=.c) (95=.b)
label define jn 0 `"nein"' 1 `"ja"' .a `"keine Angabe"' 


sort hhid pid wsid

* Neue Start- und Ankunftsstunden definieren

bysort hhid pid: gen st_std_korr = st_std
bysort hhid pid: replace st_std_korr = st_std+24 if _n>1 & st_std[_n] < st_std_korr[_n-1]
bysort hhid pid: gen en_std_korr = en_std
bysort hhid pid: replace en_std_korr = en_std +24 if _n>1 & en_std[_n]<en_std_korr[_n-1]
label var st_std_korr "korrigierte Startstunde 24+"
label var en_std_korr "korrigierte Ankunftsstunde 24+"
* Aktivitätendauer generieren
bysort hhid pid: gen akt_dauer = (st_std_korr[_n+1]-  en_std_korr[_n])*60+st_min[_n+1]- en_min[_n] if _n>0
label var akt_dauer "Aktivitätendauer mit korrigierten Stunden berechnet [min]"

* Fahrdauer generieren
gen fahrzeit = (en_std_korr-st_std_korr)*60+en_min-st_min
label var fahrzeit "Fahrzeit mit korrigierten Stunden berechnet [min]"

* Summe der Aktivitäten- und Fahrtdauer [kumuliert] berechnen
bysort hhid pid: gen zeitsummefahr = sum(fahrzeit)
bysort hhid pid: gen zeitsummeakt = sum(akt_dauer)
label var zeitsummefahr "kumulierte Fahrzeit über den Tagesverlauf [min]"
label var zeitsummeakt "kumulierte Aktivitätendauer über den Tagesverlauf [min]"


* Anteil der Aktivitäten- Fahrtdauer an der Gesamtzeit (tagesbezogen, von 1. bis letzter Aktivität)
bysort hhid pid: gen ant_fahrzeit_akt=fahrzeit/zeitsummefahr[_N]
bysort hhid pid: gen ant_aktzeit_akt=akt_dauer/zeitsummeakt[_N]
label var ant_fahrzeit_akt "Anteil der Fahrzeit an der Tagesgesamtfahrzeit [%]"
label var ant_aktzeit_akt "Anteil der Aktivitätendauer der Aktivität an der Gesamtaktivitätendauer am Tag [%]"

* Anzahl Wege geniereren
bysort hhid pid: gen Anz_Wege=_N
label var Anz_Wege "Anzahl der Wege der Person"

* negative Aktivitätendauer markieren
gen neg_akt=0
replace neg_akt=1 if akt_dauer<0
label var neg_akt "Aktivitätendauer für diese Aktivität negativ"




* duplicates drop hhid pid w04  w04_dzw w01 w13 st_time  en_time if wid<100, force
* drop Zweck wegpaar wegekette wegekette_home
replace w072_2 = .a if w072_2<0
replace w072_3 = .a if w072_3<0
replace w072_4 = .a if w072_4<0
replace w072_5 = .a if w072_5<0
replace w072_6 = .a if w072_6<0
replace w072_7 = .a if w072_7<0
replace w072_8 = .a if w072_8<0
replace w072_9 = .a if w072_9<0
replace w072_10 = .a if w072_10<0

label define w072_2 .a `"keine Angabe"', modify
label define w072_3 .a `"keine Angabe"', modify
label define w072_4 .a `"keine Angabe"', modify
label define w072_5 .a `"keine Angabe"', modify
label define w072_6 .a `"keine Angabe"', modify
label define w072_7 .a `"keine Angabe"', modify
label define w072_8 .a `"keine Angabe"', modify
label define w072_9 .a `"keine Angabe"', modify
label define w072_10 .a `"keine Angabe"', modify

label value w072_2 w072_2
label value w072_3 w072_3
label value w072_4 w072_4
label value w072_5 w072_5
label value w072_6 w072_6
label value w072_7 w072_7
label value w072_8 w072_8
label value w072_9 w072_9
label value w072_10 w072_10

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
gen eink_p = Zweck == 3

label value werktag jn

foreach x in "arbeit" "bilden" "eink_ap" "freizeit" "kindergarten" "eink_p" {
	bysort hhid pid: egen sum_`x' =  sum(`x')
}

gen u100=wegkm_k <=100
replace u100 = .a if missing(wegkm_k)
bysort hhid pid: egen wegkm_kum = sum(wegkm_k)
label var wegkm_kum "Tageskilometer mit rbw"
gen ue100_kum=wegkm_kum >=100
replace ue100_kum = .a if missing(wegkm_kum)
gen distanz = 1 if wegkm_kum<=20
replace distanz = 2 if wegkm_kum<=40 & missing(distanz)
replace distanz = 3 if wegkm_kum<=60 & missing(distanz)
replace distanz = 4 if wegkm_kum<=80 & missing(distanz)
replace distanz = 5 if wegkm_kum<=100 & missing(distanz)
replace distanz = 6 if wegkm_kum<=120 & missing(distanz)
replace distanz = 7 if wegkm_kum<=140 & missing(distanz)

label value u100 jn
label value ue100_kum jn 
label value w05_* jn


