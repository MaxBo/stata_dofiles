clear
set memory 700m
set more off
* Lokal auf meinem Rechner (Sonja)
local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\"

use "`path'MiD_2008_2006_HH.dta", clear
rename HHID hhid
rename H04_1 h04_1
rename H04_2 h04_2
rename H04_3 h04_3
rename KRS_HVV krs_hvv
* rename STICH_J stich_j


save "`path'MiD_2008_2006_HH_angepasst.dta", replace

use "`path'MiD_2008_Autos.dta", clear
rename HHID hhid
rename VMID vmid
rename H044 h044

gen pid = h044
recode pid (96=.e)
label define pid  .e `"nicht zuzuordnen"', add modify
label value pid pid

bysort hhid pid: egen Anz_auto_Person = count(vmid) if pid<.
label var Anz_auto_Person "Anzahl der Pkw je Person"
save "`path'MiD_autos_cod_def.dta", replace

duplicates drop hhid pid, force
save "`path'MiD_2008_Autos_angepasst.dta", replace

use "`path'MiD_2008_2006_Personen_5.dta", clear


recode hp_pkwfs (2=0)
label define jn 1 "ja" 0 "nein", modify
label value hp_pkwfs jn

* Führerscheinerwerbsalter
gen Alter_fS =   p061_3j- (stich_j  - hp_alter) if p061_3j<. | hp_alter<.
label var Alter_fS "Alter, in dem die Person den Führerschein erworben hat"
replace Alter_fS= . if Alter_fS<=16
gen fs_ew = Alter_fS < .
gen alter_fs = hp_alter if fs_ew==0 & hp_pkwfs == 0
replace alter_fs = Alter_fS if fs_ew==1 & hp_pkwfs==1

version 10
merge hhid using "`path'MiD_2008_2006_HH_angepasst.dta", sort keep(h04_?) update replace _merge(upd_hh) uniqusing
version 12

* Mobilitätswerkzeuge für Personen und Haushalte definieren
gen hh_ohne_pkw = h04_3==0
label var hh_ohne_pkw "HH ohne Pkw"
label value hh_ohne_pkw jn

gen hh_mofa = h04_1>0
label var hh_mofa "Haushalt hat mind. ein Mofa"

gen hh_rad  = h04_2>0
label var hh_rad "Haushalt hat mind. ein Fahrrad"

gen hat_zeitkarte =  p070>2 & p070<6 
label var hat_zeitkarte "Person hat Zeitkarte"

gen hh_zeitkarte = p070_a==3 | p070_a==4
bysort hhid: egen hh_zeit = sum(hh_zeitkarte)
replace hh_zeitkarte = 1 if hh_zeit > 0 & hh_zeit<.
drop hh_zeit
label var hh_zeitkarte "Haushalt verfügt über mind. eine personenunabhängige Zeitkarte"


gen zeitkarte = 1 if hat_zeitkarte==1
replace zeitkarte =2 if hat_zeitkarte==0 & hh_zeitkarte==1
replace zeitkarte = 3 if hat_zeitkarte==0 & hh_zeitkarte==0
label var zeitkarte "ÖV-Zeitkartenbesitz (Kat.)"
label define zeitkarte 1 `"personengebundene Zeitkarte"' 2 `"personenungebundene Zeitkarte"' 3 `"keine Zeitkarte im Haushalt"', modify
label value zeitkarte zeitkarte


* Imputieren von Haltestellenentfernungen für Missings und Kinder unter 14 Jahre auf HH Ebene
* Hilfe zur Erstellung einer Zufallsziehung
* Eine Zufällig generierte Kennung für alle Missings in p052 generieren: 
sort p052 hp_alter pid 
gen Random = .
replace Random = 1 if mod(_n,2) == 0 
replace Random = 0 if mod(_n,2) == 1 
replace Random = . if p052 < 9
sort hhid pid

* Kontrolle von ungleichen Antworten innerhalb von Haushalten
by hhid: gen flag_052 = 1 if p052 != p052[_n-1] & p052<97 & p052[_n-1] < 97

recode p052(.a=98) (.c=98), gen(p052_ka)
* Missings imputieren:
sort hhid pid
by hhid: replace p052_ka = p052_ka[_n-1] if p052_ka == 98 & Random == 1 | p052_ka == . & Random == 1
by hhid: replace p052_ka = p052_ka[_n+1] if p052_ka == 98 & Random == 0 | p052_ka == . & Random == 0
by hhid: replace p052_ka = p052_ka[_n-1] if p052_ka == 98 | p052_ka == . 
by hhid: replace p052_ka = p052_ka[_n+1] if p052_ka == 98 | p052_ka == . 
drop Random
label values p052_ka p052

* Kontrolle von ungleichen Antworten innerhalb von Haushalten
by hhid: gen flag_054 = 1 if p054 != p054[_n-1] & p054  <97 & p054[_n-1] < 97

sort p054 hp_alter pid 
gen Random = .
replace Random = 1 if mod(_n,2) == 0 
replace Random = 0 if mod(_n,2) == 1 
replace Random = . if p054 < 9
sort hhid pid

recode p054(.a=98) (.c=98), gen(p054_ka)
sort hhid pid
by hhid: replace p054_ka = p054_ka[_n-1] if p054_ka == 98 & Random == 1 | p054_ka == . & Random == 1
by hhid: replace p054_ka = p054_ka[_n-1] if p054_ka == 98 & Random == 0 | p054_ka == . & Random == 0
by hhid: replace p054_ka = p054_ka[_n-1] if p054_ka == 98 | p054_ka == .
by hhid: replace p054_ka = p054_ka[_n+1] if p054_ka == 98 | p054_ka == .
drop Random
label values p054_ka p052



* Variable für Ausbildungsverkehre nach Absprache mit dem Regionalverband
rename HPP_BESCH hp_besch
recode hp_besch (4=1 "Auszubildende(r)") (5=2 "Schüler(in) an einer Grundschule") (5=3 "Schüler(in) an einer weiterführenden Schule") (6=4 "Student(in)") (13=5 "Wehr- oder Zivildienstleistende(r), Freiwilligendienst") (9/14=6 "Andere")(nonmissing = .), gen(hp_ausb)
label var hp_ausb "Personengruppen nach Schulart/Ausbildungsart"
replace hp_ausb = 2 if p14b==9 & hp_alter>4 & hp_alter<13
replace hp_ausb = 3 if p14b>9 & p14b<15
replace hp_ausb = 3 if hp_besch==5 & hp_alter>12 & hp_alter<23
replace hp_ausb = . if p14b==8
replace hp_ausb = . if (p14b==9 | hp_ausb==2) & (hp_alter<5 | hp_alter>12)
replace hp_ausb = . if p14b>9 & p14b<15 & hp_alter<9

version 10
merge hhid pid using "`path'MiD_2008_Autos_angepasst.dta", sort uniqusing keep(Anz_auto_Person) _merge(upd_auto1)
version 12

drop if missing(pid)
gen Pkw_eigen = Anz_auto_Person
replace Pkw_eigen = 0 if missing(Anz_auto_Person)
label var Pkw_eigen "Anzahl Pkw der jeweiligen Person"
bysort hhid: egen Anz_auto_bel_HH = sum(Anz_auto_Person)
bysort hhid: gen Anz_auto_frei = h04_3 - Anz_auto_bel_HH 
drop if missing(pid)
label var Anz_auto_bel_HH "Anzahl der personengebundenen Pkw im Haushalt"
label var Anz_auto_frei "Anzahl der ungebundenen Pkw im Haushalt"

replace Anz_auto_Person=0 if h04_3==0
replace Anz_auto_Person=0 if hp_alter<17
replace Anz_auto_Person=0 if hp_pkwfs==0
replace Anz_auto_Person=0 if Anz_auto_frei==0 & missing(Anz_auto_Person)
bysort hhid pid: gen ohne_pw = missing(Anz_auto_Person)
label var ohne_pw "Personen ohne eigenen Pkw"

bysort hhid: egen anz_fS_ohne_pw=sum(hp_pkwfs) if ohne_pw==1
label var anz_fS_ohne_pw "Summe Personen mit Führerschein aber ohne eigenen Pkw im Haushalt"
bysort hhid: egen anz_fS=sum(hp_pkwfs)
label var anz_fS "Summe Personen mit Führerschein im Haushalt"
bysort hhid: egen anz_P_auto = count(Anz_auto_Person)
label var anz_P_auto "Anzahl Personen mit mindestens einen eigenen Pkw"

bysort hhid: replace Anz_auto_Person = Anz_auto_frei/ anz_fS_ohne_pw if ohne_pw==1


gen PKW_VERF_neu = 1 if Anz_auto_Person >=1 | (anz_P_auto < anz_fS & hp_pkwfs==1)
replace PKW_VERF_neu = 2 if (Anz_auto_Person < 1 & Anz_auto_Person>0) | (h04_3>=anz_fS & missing(PKW_VERF_neu) & hp_pkwfs==1)
replace PKW_VERF_neu = 3 if Anz_auto_frei==0 & h04_3<. & h04_3>0 &  hp_pkwfs==1 & missing(PKW_VERF_neu)
replace PKW_VERF_neu = 4 if h04_3<. & h04_3>0  & (hp_pkwfs==0)
replace PKW_VERF_neu = 5 if (h04_3==0 | missing(h04_3)) & missing(PKW_VERF_neu)

label define PKW_VERF_neu 1 `"Pkw immer verfügbar"' 2 `"Pkw teilweise als Fahrer verfügbar"' 3 `"Pkw selten als Fahrer verfügbar"' 5 `"kein Pkw im HH"' 4 `"Pkw nur als Beifahrer verfügbar"', modify
label value PKW_VERF_neu PKW_VERF_neu
label var PKW_VERF_neu "Pkw-Verfügbarkeit des HH-Teilnehmers nach neuer Definition (5 Klassen)"

gen Pkw_eigen2 = Pkw_eigen>0
label value Pkw_eigen2 jn
label var Pkw_eigen2 "mind. ein eigener Pkw vorhanden"

gen Anz_auto_frei2 = Anz_auto_frei>0
label value Anz_auto_frei2 jn
label var Anz_auto_frei2 "mind. ein Pkw personenunabhängiger Pkw im Haushalt vorhanden"

label value  p05?_ka p052

gen p05_3 = 1 if p054_ka<4 | p052_ka<4
replace p05_3 = 2 if missing(p05_3) & (p054_ka==4 | p052_ka==4) 
replace p05_3 = 3 if (p054_ka<. | p052_ka<.)  & missing(p05_3)

label var p05_3 "Entfernung zur nächsten Haltestelle (Bus/Schiene)"
label define p05_3 1 `"<=400m"' 2 `"400m - 1000m"' 3 `"> 1000m"', add modify
label value p05_3 p05_3


* generierte Variablen für die Modelle

recode hheink (2/3=1 "unter 1500") (4/5=2 "1500-2600")(6/7=3 "2600-3600")(8/9=4 "3600-4600")(10/15=5 "über4600"), gen(hheink_5)
gen hp_alter2 = hp_alter*hp_alter
recode hhtyp (2/3=1 "EPH") (4/6=2 "2PH")  (7=3 "3und mehr ERW" ) (8/11=4 "HH mit Kind") , gen(hhtyp_4)
recode hhtyp (2/3=1 "EPH") (4/7=2 "2und mehr ERW") (8/11=3 "HH mit Kind") , gen(hhtyp_3)
recode hp_besch (1=1 "Berufstätig - Vollzeit") (2/3=2 "Berufstätig - Teilzeit") (4=3 "Auszubildene") (5=4 "Schüler") (6=5 "Student") (7/8=6 "Kind") (9/11=7 "daheim") (12=8 "Rentner") (13/14=9 "andere"), gen(hp_besch_aggr)

replace hp_besch=14 if hp_alter>18 & (hp_besch==7 | hp_besch==8)
* drop verh_perg
gen verh_perg = 1 if hp_alter<7
replace verh_perg = 2 if hp_alter>4 & hp_alter<14 & (hp_besch==5 | p14b==9)
replace verh_perg = 3 if hp_alter>8 & hp_alter<17 & (hp_besch==5 | (p14b>9 & p14b<15))
replace verh_perg = 2 if hp_alter>5 & hp_alter<11 & missing(verh_perg)
replace verh_perg = 3 if hp_alter>10 & hp_alter<16 & missing(verh_perg)
replace verh_perg =4 if hp_alter>16 & hp_besch==5
replace verh_perg =5 if hp_alter>15 & hp_besch==4
replace verh_perg =6 if hp_besch==6 & hp_alter<41
replace verh_perg =7 if (hp_besch==1 | hp_besch==13) & missing(verh_perg)
replace verh_perg =8 if (hp_besch==2 | hp_besch==3)  & missing(verh_perg)
replace verh_perg =9 if (hp_besch==11 | hp_besch==10)  & missing(verh_perg)
replace verh_perg =10 if missing(verh_perg) & (hp_beruf==4 | hp_besch==9)
replace verh_perg =11 if hp_alter>60 & hp_beru==2 & hp_besch==12
replace verh_perg =11 if hp_alter>60 & hp_alter<75 & missing(verh_perg) & hp_besch==12
replace verh_perg =12 if hp_alter>74 & hp_beru==2 & hp_besch==12
replace verh_perg =12 if hp_alter>74 & missing(verh_perg) & hp_besch==12



label define verh_perg 1 `"Kleinkind"' 2 `"Grundschüler"' 3  `"Schüler-Mittelstufe"' 4  `"Schüler-Oberstufe"' 5  `"Berufsschüler"', modify
label define verh_perg 6 `"Student"' 7 `"Vollzeitbeschäftigter"' 8 `"Teilzeitbeschäftigter"' 9 `"nicht erwerbstätig: Hausfrau/-mann"' 10 `"nicht erwerbstätig: sonstige"', modify
label define verh_perg 11 `"aktiver Rentner"' 12  `"inaktiver Rentner"', modify

label value verh_perg verh_perg


label define zentral 3 "Unterzentrum" 4 "ländl. Peripherie", modify
label define zentral 2 "Mittelzentrum" 1 "Innenstadt", modify


gen zentral = 3 if st_hvv==102
replace zentral = 1 if st_hvv==103
replace zentral = 3 if st_hvv==104
replace zentral = 1 if st_hvv==108
replace zentral = 1 if st_hvv==109
replace zentral = 1 if st_hvv==110
replace zentral = 1 if st_hvv==111
replace zentral = 1 if st_hvv==112
replace zentral = 1 if st_hvv==114
replace zentral = 1 if st_hvv==115
replace zentral = 1 if st_hvv==116
replace zentral = 1 if st_hvv==117
replace zentral = 2 if st_hvv==119
replace zentral = 2 if st_hvv==121
replace zentral = 1 if st_hvv==201
replace zentral = 1 if st_hvv==202
replace zentral = 2 if st_hvv==203
replace zentral = 3 if st_hvv==204
replace zentral = 3 if st_hvv==205
replace zentral = 4 if st_hvv==206
replace zentral = 3 if st_hvv==207
replace zentral = 4 if st_hvv==208
replace zentral = 4 if st_hvv==209
replace zentral = 3 if st_hvv==210
replace zentral = 1 if st_hvv==211
replace zentral = 3 if st_hvv==212
replace zentral = 1 if st_hvv==213
replace zentral = 4 if st_hvv==214
replace zentral = 3 if st_hvv==301
replace zentral = 2 if st_hvv==302
replace zentral = 1 if st_hvv==303
replace zentral = 1 if st_hvv==304
replace zentral = 3 if st_hvv==305
replace zentral = 3 if st_hvv==306
replace zentral = 1 if st_hvv==307
replace zentral = 4 if st_hvv==308
replace zentral = 3 if st_hvv==309
replace zentral = 3 if st_hvv==401
replace zentral = 2 if st_hvv==402
replace zentral = 1 if st_hvv==403
replace zentral = 3 if st_hvv==404
replace zentral = 1 if st_hvv==405
replace zentral = 3 if st_hvv==406
replace zentral = 4 if st_hvv==407
replace zentral = 1 if st_hvv==408
replace zentral = 1 if st_hvv==409
replace zentral = 3 if st_hvv==410
replace zentral = 3 if st_hvv==411
replace zentral = 1 if st_hvv==412
replace zentral = 1 if st_hvv==413
replace zentral = 4 if st_hvv==501
replace zentral = 3 if st_hvv==502
replace zentral = 4 if st_hvv==503
replace zentral = 3 if st_hvv==504
replace zentral = 3 if st_hvv==505
replace zentral = 4 if st_hvv==506
replace zentral = 3 if st_hvv==507
replace zentral = 4 if st_hvv==508
replace zentral = 4 if st_hvv==509
replace zentral = 3 if st_hvv==510
replace zentral = 3 if st_hvv==511
replace zentral = 4 if st_hvv==512
replace zentral = 3 if st_hvv==513
replace zentral = 3 if st_hvv==514
replace zentral = 4 if st_hvv==515
replace zentral = 2 if st_hvv==516
replace zentral = 4 if st_hvv==517
replace zentral = 4 if st_hvv==518
replace zentral = 3 if st_hvv==601
replace zentral = 4 if st_hvv==602
replace zentral = 2 if st_hvv==603
replace zentral = 3 if st_hvv==604
replace zentral = 4 if st_hvv==605
replace zentral = 4 if st_hvv==606
replace zentral = 3 if st_hvv==607
replace zentral = 4 if st_hvv==608
replace zentral = 4 if st_hvv==609
replace zentral = 4 if st_hvv==610
replace zentral = 4 if st_hvv==611
replace zentral = 4 if st_hvv==612
replace zentral = 4 if st_hvv==613
replace zentral = 4 if st_hvv==702
replace zentral = 4 if st_hvv==703
replace zentral = 4 if st_hvv==704
replace zentral = 2 if st_hvv==706
replace zentral = 4 if st_hvv==707
replace zentral = 3 if st_hvv==708
replace zentral = 4 if st_hvv==709
replace zentral = 3 if st_hvv==710
replace zentral = 4 if st_hvv==712
replace zentral = 3 if st_hvv==713
replace zentral = 4 if st_hvv==715
replace zentral = 4 if st_hvv==716
replace zentral = 3 if st_hvv==717

label value zentral zentral
label var zentral "Zentralität des Wohnortes"

******* +++++ Einwohnerdichte je Stadtteil [EW/km²]
gen einwohnerdichte_EW = 4106 if st_hvv==102
replace einwohnerdichte_EW = 7388 if st_hvv==103
replace einwohnerdichte_EW = 606 if st_hvv==104
replace einwohnerdichte_EW = 12104 if st_hvv==108
replace einwohnerdichte_EW = 12081 if st_hvv==109
replace einwohnerdichte_EW = 3656 if st_hvv==110
replace einwohnerdichte_EW = 679 if st_hvv==111
replace einwohnerdichte_EW = 6440 if st_hvv==112
replace einwohnerdichte_EW = 5381 if st_hvv==114
replace einwohnerdichte_EW = 1208 if st_hvv==115
replace einwohnerdichte_EW = 5926 if st_hvv==116
replace einwohnerdichte_EW = 9436 if st_hvv==117
replace einwohnerdichte_EW = 1116 if st_hvv==119
replace einwohnerdichte_EW = 1411 if st_hvv==121
replace einwohnerdichte_EW = 9850 if st_hvv==201
replace einwohnerdichte_EW = 9684 if st_hvv==202
replace einwohnerdichte_EW = 2426 if st_hvv==203
replace einwohnerdichte_EW = 1538 if st_hvv==204
replace einwohnerdichte_EW = 4508 if st_hvv==205
replace einwohnerdichte_EW = 3983 if st_hvv==206
replace einwohnerdichte_EW = 5222 if st_hvv==207
replace einwohnerdichte_EW = 1552 if st_hvv==208
replace einwohnerdichte_EW = 3434 if st_hvv==209
replace einwohnerdichte_EW = 2055 if st_hvv==210
replace einwohnerdichte_EW = 11333 if st_hvv==211
replace einwohnerdichte_EW = 870 if st_hvv==212
replace einwohnerdichte_EW = 12775 if st_hvv==213
replace einwohnerdichte_EW = 1594 if st_hvv==214
replace einwohnerdichte_EW = 3468 if st_hvv==301
replace einwohnerdichte_EW = 16713 if st_hvv==302
replace einwohnerdichte_EW = 8204 if st_hvv==303
replace einwohnerdichte_EW = 17834 if st_hvv==304
replace einwohnerdichte_EW = 5095 if st_hvv==305
replace einwohnerdichte_EW = 3119 if st_hvv==306
replace einwohnerdichte_EW = 5708 if st_hvv==307
replace einwohnerdichte_EW = 3055 if st_hvv==308
replace einwohnerdichte_EW = 3911 if st_hvv==309
replace einwohnerdichte_EW = 4141 if st_hvv==401
replace einwohnerdichte_EW = 9709 if st_hvv==402
replace einwohnerdichte_EW = 10005 if st_hvv==403
replace einwohnerdichte_EW = 14693 if st_hvv==404
replace einwohnerdichte_EW = 8442 if st_hvv==405
replace einwohnerdichte_EW = 1773 if st_hvv==406
replace einwohnerdichte_EW = 1704 if st_hvv==407
replace einwohnerdichte_EW = 15482 if st_hvv==408
replace einwohnerdichte_EW = 8164 if st_hvv==409
replace einwohnerdichte_EW = 2964 if st_hvv==410
replace einwohnerdichte_EW = 1991 if st_hvv==411
replace einwohnerdichte_EW = 7191 if st_hvv==412
replace einwohnerdichte_EW = 6376 if st_hvv==413
replace einwohnerdichte_EW = 1349 if st_hvv==501
replace einwohnerdichte_EW = 4988 if st_hvv==502
replace einwohnerdichte_EW = 915 if st_hvv==503
replace einwohnerdichte_EW = 11927 if st_hvv==504
replace einwohnerdichte_EW = 4023 if st_hvv==505
replace einwohnerdichte_EW = 1832 if st_hvv==506
replace einwohnerdichte_EW = 4987 if st_hvv==507
replace einwohnerdichte_EW = 820 if st_hvv==508
replace einwohnerdichte_EW = 3585 if st_hvv==509
replace einwohnerdichte_EW = 2710 if st_hvv==510
replace einwohnerdichte_EW = 3257 if st_hvv==511
replace einwohnerdichte_EW = 2682 if st_hvv==512
replace einwohnerdichte_EW = 7720 if st_hvv==513
replace einwohnerdichte_EW = 3254 if st_hvv==514
replace einwohnerdichte_EW = 1707 if st_hvv==515
replace einwohnerdichte_EW = 5403 if st_hvv==516
replace einwohnerdichte_EW = 2375 if st_hvv==517
replace einwohnerdichte_EW = 254 if st_hvv==518
replace einwohnerdichte_EW = 1290 if st_hvv==601
replace einwohnerdichte_EW = 141 if st_hvv==602
replace einwohnerdichte_EW = 3586 if st_hvv==603
replace einwohnerdichte_EW = 137 if st_hvv==604
replace einwohnerdichte_EW = 353 if st_hvv==605
replace einwohnerdichte_EW = 278 if st_hvv==606
replace einwohnerdichte_EW = 2957 if st_hvv==607
replace einwohnerdichte_EW = 262 if st_hvv==608
replace einwohnerdichte_EW = 186 if st_hvv==609
replace einwohnerdichte_EW = 163 if st_hvv==610
replace einwohnerdichte_EW = 70 if st_hvv==611
replace einwohnerdichte_EW = 143 if st_hvv==612
replace einwohnerdichte_EW = 164 if st_hvv==613
replace einwohnerdichte_EW = 596 if st_hvv==702
replace einwohnerdichte_EW = 2794 if st_hvv==703
replace einwohnerdichte_EW = 70 if st_hvv==704
replace einwohnerdichte_EW = 5604 if st_hvv==706
replace einwohnerdichte_EW = 1530 if st_hvv==707
replace einwohnerdichte_EW = 1734 if st_hvv==708
replace einwohnerdichte_EW = 5259 if st_hvv==709
replace einwohnerdichte_EW = 1533 if st_hvv==710
replace einwohnerdichte_EW = 295 if st_hvv==712
replace einwohnerdichte_EW = 1198 if st_hvv==713
replace einwohnerdichte_EW = 1432 if st_hvv==715
replace einwohnerdichte_EW = 1307 if st_hvv==716
replace einwohnerdichte_EW = 4590 if st_hvv==717


******* +++++ Anteil Wohnungen in Ein-und Zweifamilienhäusern je Stadtteil
gen einwohnerdichte_EFH = 19.5 if st_hvv==102
replace einwohnerdichte_EFH = 1.3 if st_hvv==103
replace einwohnerdichte_EFH = 33.7 if st_hvv==104
replace einwohnerdichte_EFH = 0.5 if st_hvv==108
replace einwohnerdichte_EFH = 1 if st_hvv==109
replace einwohnerdichte_EFH = 4.5 if st_hvv==110
replace einwohnerdichte_EFH = 3.6 if st_hvv==111
replace einwohnerdichte_EFH = 6.7 if st_hvv==112
replace einwohnerdichte_EFH = 2 if st_hvv==114
replace einwohnerdichte_EFH = 5.6 if st_hvv==115
replace einwohnerdichte_EFH = 2.7 if st_hvv==116
replace einwohnerdichte_EFH = 2.6 if st_hvv==117
replace einwohnerdichte_EFH = 2 if st_hvv==119
replace einwohnerdichte_EFH = 15.4 if st_hvv==121
replace einwohnerdichte_EFH = 2.1 if st_hvv==201
replace einwohnerdichte_EFH = 1.4 if st_hvv==202
replace einwohnerdichte_EFH = 19.2 if st_hvv==203
replace einwohnerdichte_EFH = 46.6 if st_hvv==204
replace einwohnerdichte_EFH = 42.5 if st_hvv==205
replace einwohnerdichte_EFH = 41.7 if st_hvv==206
replace einwohnerdichte_EFH = 33.8 if st_hvv==207
replace einwohnerdichte_EFH = 48.8 if st_hvv==208
replace einwohnerdichte_EFH = 28 if st_hvv==209
replace einwohnerdichte_EFH = 37.8 if st_hvv==210
replace einwohnerdichte_EFH = 2.4 if st_hvv==211
replace einwohnerdichte_EFH = 46.9 if st_hvv==212
replace einwohnerdichte_EFH = 2.6 if st_hvv==213
replace einwohnerdichte_EFH = 50.6 if st_hvv==214
replace einwohnerdichte_EFH = 28.7 if st_hvv==301
replace einwohnerdichte_EFH = 1.1 if st_hvv==302
replace einwohnerdichte_EFH = 5.1 if st_hvv==303
replace einwohnerdichte_EFH = 1.7 if st_hvv==304
replace einwohnerdichte_EFH = 16.8 if st_hvv==305
replace einwohnerdichte_EFH = 34.8 if st_hvv==306
replace einwohnerdichte_EFH = 3.8 if st_hvv==307
replace einwohnerdichte_EFH = 41.1 if st_hvv==308
replace einwohnerdichte_EFH = 14.2 if st_hvv==309
replace einwohnerdichte_EFH = 19.4 if st_hvv==401
replace einwohnerdichte_EFH = 1.3 if st_hvv==402
replace einwohnerdichte_EFH = 0.7 if st_hvv==403
replace einwohnerdichte_EFH = 0.6 if st_hvv==404
replace einwohnerdichte_EFH = 3 if st_hvv==405
replace einwohnerdichte_EFH = 23.6 if st_hvv==406
replace einwohnerdichte_EFH = 42.4 if st_hvv==407
replace einwohnerdichte_EFH = 1.6 if st_hvv==408
replace einwohnerdichte_EFH = 2.3 if st_hvv==409
replace einwohnerdichte_EFH = 40.3 if st_hvv==410
replace einwohnerdichte_EFH = 20.9 if st_hvv==411
replace einwohnerdichte_EFH = 1.9 if st_hvv==412
replace einwohnerdichte_EFH = 2.6 if st_hvv==413
replace einwohnerdichte_EFH = 58.1 if st_hvv==501
replace einwohnerdichte_EFH = 28.5 if st_hvv==502
replace einwohnerdichte_EFH = 77.5 if st_hvv==503
replace einwohnerdichte_EFH = 1.5 if st_hvv==504
replace einwohnerdichte_EFH = 34.8 if st_hvv==505
replace einwohnerdichte_EFH = 28.6 if st_hvv==506
replace einwohnerdichte_EFH = 19.9 if st_hvv==507
replace einwohnerdichte_EFH = 89.1 if st_hvv==508
replace einwohnerdichte_EFH = 25.5 if st_hvv==509
replace einwohnerdichte_EFH = 58.1 if st_hvv==510
replace einwohnerdichte_EFH = 29.7 if st_hvv==511
replace einwohnerdichte_EFH = 69.7 if st_hvv==512
replace einwohnerdichte_EFH = 4.1 if st_hvv==513
replace einwohnerdichte_EFH = 26.2 if st_hvv==514
replace einwohnerdichte_EFH = 58.1 if st_hvv==515
replace einwohnerdichte_EFH = 13.2 if st_hvv==516
replace einwohnerdichte_EFH = 54 if st_hvv==517
replace einwohnerdichte_EFH = 75.5 if st_hvv==518
replace einwohnerdichte_EFH = 34.9 if st_hvv==601
replace einwohnerdichte_EFH = 79.5 if st_hvv==602
replace einwohnerdichte_EFH = 24.8 if st_hvv==603
replace einwohnerdichte_EFH = 78 if st_hvv==604
replace einwohnerdichte_EFH = 71.1 if st_hvv==605
replace einwohnerdichte_EFH = 76.4 if st_hvv==606
replace einwohnerdichte_EFH = 22.1 if st_hvv==607
replace einwohnerdichte_EFH = 86.6 if st_hvv==608
replace einwohnerdichte_EFH = 77.3 if st_hvv==609
replace einwohnerdichte_EFH = 74.9 if st_hvv==610
replace einwohnerdichte_EFH = 79 if st_hvv==611
replace einwohnerdichte_EFH = 72.6 if st_hvv==612
replace einwohnerdichte_EFH = 83.6 if st_hvv==613
replace einwohnerdichte_EFH = 37.4 if st_hvv==702
replace einwohnerdichte_EFH = 30.6 if st_hvv==703
replace einwohnerdichte_EFH = 77.2 if st_hvv==704
replace einwohnerdichte_EFH = 2.6 if st_hvv==706
replace einwohnerdichte_EFH = 34.3 if st_hvv==707
replace einwohnerdichte_EFH = 14.9 if st_hvv==708
replace einwohnerdichte_EFH = 56.6 if st_hvv==709
replace einwohnerdichte_EFH = 49.7 if st_hvv==710
replace einwohnerdichte_EFH = 58.5 if st_hvv==712
replace einwohnerdichte_EFH = 39.9 if st_hvv==713
replace einwohnerdichte_EFH = 50.6 if st_hvv==715
replace einwohnerdichte_EFH = 59.7 if st_hvv==716
replace einwohnerdichte_EFH = 19.1 if st_hvv==717


gen Bahnanschluss = 1 if st_hvv==102
replace Bahnanschluss = 1 if st_hvv==103
replace Bahnanschluss = 0 if st_hvv==104
replace Bahnanschluss = 1 if st_hvv==108
replace Bahnanschluss = 1 if st_hvv==109
replace Bahnanschluss = 1 if st_hvv==110
replace Bahnanschluss = 1 if st_hvv==111
replace Bahnanschluss = 1 if st_hvv==112
replace Bahnanschluss = 1 if st_hvv==114
replace Bahnanschluss = 1 if st_hvv==115
replace Bahnanschluss = 1 if st_hvv==116
replace Bahnanschluss = 1 if st_hvv==117
replace Bahnanschluss = 1 if st_hvv==119
replace Bahnanschluss = 1 if st_hvv==121
replace Bahnanschluss = 1 if st_hvv==201
replace Bahnanschluss = 1 if st_hvv==202
replace Bahnanschluss = 1 if st_hvv==203
replace Bahnanschluss = 1 if st_hvv==204
replace Bahnanschluss = 1 if st_hvv==205
replace Bahnanschluss = 1 if st_hvv==206
replace Bahnanschluss = 0 if st_hvv==207
replace Bahnanschluss = 1 if st_hvv==208
replace Bahnanschluss = 1 if st_hvv==209
replace Bahnanschluss = 1 if st_hvv==210
replace Bahnanschluss = 1 if st_hvv==211
replace Bahnanschluss = 1 if st_hvv==212
replace Bahnanschluss = 1 if st_hvv==213
replace Bahnanschluss = 1 if st_hvv==214
replace Bahnanschluss = 1 if st_hvv==301
replace Bahnanschluss = 1 if st_hvv==302
replace Bahnanschluss = 1 if st_hvv==303
replace Bahnanschluss = 1 if st_hvv==304
replace Bahnanschluss = 1 if st_hvv==305
replace Bahnanschluss = 1 if st_hvv==306
replace Bahnanschluss = 1 if st_hvv==307
replace Bahnanschluss = 1 if st_hvv==308
replace Bahnanschluss = 1 if st_hvv==309
replace Bahnanschluss = 1 if st_hvv==401
replace Bahnanschluss = 1 if st_hvv==402
replace Bahnanschluss = 1 if st_hvv==403
replace Bahnanschluss = 1 if st_hvv==404
replace Bahnanschluss = 1 if st_hvv==405
replace Bahnanschluss = 1 if st_hvv==406
replace Bahnanschluss = 0 if st_hvv==407
replace Bahnanschluss = 1 if st_hvv==408
replace Bahnanschluss = 1 if st_hvv==409
replace Bahnanschluss = 1 if st_hvv==410
replace Bahnanschluss = 1 if st_hvv==411
replace Bahnanschluss = 1 if st_hvv==412
replace Bahnanschluss = 1 if st_hvv==413
replace Bahnanschluss = 0 if st_hvv==501
replace Bahnanschluss = 0 if st_hvv==502
replace Bahnanschluss = 0 if st_hvv==503
replace Bahnanschluss = 1 if st_hvv==504
replace Bahnanschluss = 1 if st_hvv==505
replace Bahnanschluss = 0 if st_hvv==506
replace Bahnanschluss = 0 if st_hvv==507
replace Bahnanschluss = 0 if st_hvv==508
replace Bahnanschluss = 1 if st_hvv==509
replace Bahnanschluss = 1 if st_hvv==510
replace Bahnanschluss = 1 if st_hvv==511
replace Bahnanschluss = 0 if st_hvv==512
replace Bahnanschluss = 0 if st_hvv==513
replace Bahnanschluss = 1 if st_hvv==514
replace Bahnanschluss = 1 if st_hvv==515
replace Bahnanschluss = 1 if st_hvv==516
replace Bahnanschluss = 1 if st_hvv==517
replace Bahnanschluss = 1 if st_hvv==518
replace Bahnanschluss = 1 if st_hvv==601
replace Bahnanschluss = 0 if st_hvv==602
replace Bahnanschluss = 1 if st_hvv==603
replace Bahnanschluss = 1 if st_hvv==604
replace Bahnanschluss = 0 if st_hvv==605
replace Bahnanschluss = 0 if st_hvv==606
replace Bahnanschluss = 0 if st_hvv==607
replace Bahnanschluss = 1 if st_hvv==608
replace Bahnanschluss = 0 if st_hvv==609
replace Bahnanschluss = 0 if st_hvv==610
replace Bahnanschluss = 0 if st_hvv==611
replace Bahnanschluss = 0 if st_hvv==612
replace Bahnanschluss = 0 if st_hvv==613
replace Bahnanschluss = 0 if st_hvv==702
replace Bahnanschluss = 0 if st_hvv==703
replace Bahnanschluss = 0 if st_hvv==704
replace Bahnanschluss = 1 if st_hvv==706
replace Bahnanschluss = 1 if st_hvv==707
replace Bahnanschluss = 1 if st_hvv==708
replace Bahnanschluss = 0 if st_hvv==709
replace Bahnanschluss = 0 if st_hvv==710
replace Bahnanschluss = 0 if st_hvv==712
replace Bahnanschluss = 1 if st_hvv==713
replace Bahnanschluss = 0 if st_hvv==715
replace Bahnanschluss = 0 if st_hvv==716
replace Bahnanschluss = 0 if st_hvv==717

gen rk_gesa = 3 if st_hvv==102
replace rk_gesa = 2 if st_hvv==103
replace rk_gesa = 5 if st_hvv==104
replace rk_gesa = 2 if st_hvv==108
replace rk_gesa = 2 if st_hvv==109
replace rk_gesa = 2 if st_hvv==110
replace rk_gesa = 3 if st_hvv==111
replace rk_gesa = 3 if st_hvv==112
replace rk_gesa = 2 if st_hvv==114
replace rk_gesa = 3 if st_hvv==115
replace rk_gesa = 2 if st_hvv==116
replace rk_gesa = 2 if st_hvv==117
replace rk_gesa = 3 if st_hvv==119
replace rk_gesa = 2 if st_hvv==121
replace rk_gesa = 2 if st_hvv==201
replace rk_gesa = 2 if st_hvv==202
replace rk_gesa = 3 if st_hvv==203
replace rk_gesa = 4 if st_hvv==204
replace rk_gesa = 3 if st_hvv==205
replace rk_gesa = 4 if st_hvv==206
replace rk_gesa = 4 if st_hvv==207
replace rk_gesa = 3 if st_hvv==208
replace rk_gesa = 4 if st_hvv==209
replace rk_gesa = 3 if st_hvv==210
replace rk_gesa = 2 if st_hvv==211
replace rk_gesa = 4 if st_hvv==212
replace rk_gesa = 2 if st_hvv==213
replace rk_gesa = 4 if st_hvv==214
replace rk_gesa = 4 if st_hvv==301
replace rk_gesa = 2 if st_hvv==302
replace rk_gesa = 2 if st_hvv==303
replace rk_gesa = 2 if st_hvv==304
replace rk_gesa = 3 if st_hvv==305
replace rk_gesa = 3 if st_hvv==306
replace rk_gesa = 2 if st_hvv==307
replace rk_gesa = 4 if st_hvv==308
replace rk_gesa = 3 if st_hvv==309
replace rk_gesa = 3 if st_hvv==401
replace rk_gesa = 2 if st_hvv==402
replace rk_gesa = 2 if st_hvv==403
replace rk_gesa = 2 if st_hvv==404
replace rk_gesa = 2 if st_hvv==405
replace rk_gesa = 3 if st_hvv==406
replace rk_gesa = 4 if st_hvv==407
replace rk_gesa = 2 if st_hvv==408
replace rk_gesa = 2 if st_hvv==409
replace rk_gesa = 3 if st_hvv==410
replace rk_gesa = 3 if st_hvv==411
replace rk_gesa = 2 if st_hvv==412
replace rk_gesa = 2 if st_hvv==413
replace rk_gesa = 4 if st_hvv==501
replace rk_gesa = 3 if st_hvv==502
replace rk_gesa = 5 if st_hvv==503
replace rk_gesa = 2 if st_hvv==504
replace rk_gesa = 3 if st_hvv==505
replace rk_gesa = 5 if st_hvv==506
replace rk_gesa = 4 if st_hvv==507
replace rk_gesa = 5 if st_hvv==508
replace rk_gesa = 3 if st_hvv==509
replace rk_gesa = 4 if st_hvv==510
replace rk_gesa = 4 if st_hvv==511
replace rk_gesa = 4 if st_hvv==512
replace rk_gesa = 3 if st_hvv==513
replace rk_gesa = 4 if st_hvv==514
replace rk_gesa = 4 if st_hvv==515
replace rk_gesa = 2 if st_hvv==516
replace rk_gesa = 4 if st_hvv==517
replace rk_gesa = 5 if st_hvv==518
replace rk_gesa = 3 if st_hvv==601
replace rk_gesa = 5 if st_hvv==602
replace rk_gesa = 2 if st_hvv==603
replace rk_gesa = 5 if st_hvv==604
replace rk_gesa = 5 if st_hvv==605
replace rk_gesa = 5 if st_hvv==606
replace rk_gesa = 3 if st_hvv==607
replace rk_gesa = 5 if st_hvv==608
replace rk_gesa = 5 if st_hvv==609
replace rk_gesa = 5 if st_hvv==610
replace rk_gesa = 5 if st_hvv==611
replace rk_gesa = 5 if st_hvv==612
replace rk_gesa = 5 if st_hvv==613
replace rk_gesa = 5 if st_hvv==702
replace rk_gesa = 4 if st_hvv==703
replace rk_gesa = 5 if st_hvv==704
replace rk_gesa = 2 if st_hvv==706
replace rk_gesa = 4 if st_hvv==707
replace rk_gesa = 3 if st_hvv==708
replace rk_gesa = 4 if st_hvv==709
replace rk_gesa = 4 if st_hvv==710
replace rk_gesa = 5 if st_hvv==712
replace rk_gesa = 4 if st_hvv==713
replace rk_gesa = 5 if st_hvv==715
replace rk_gesa = 4 if st_hvv==716
replace rk_gesa = 4 if st_hvv==717

gen rk_gesa2 = 3 if st_hvv==102
replace rk_gesa2 = 1 if st_hvv==103
replace rk_gesa2 = 7 if st_hvv==104
replace rk_gesa2 = 1 if st_hvv==108
replace rk_gesa2 = 1 if st_hvv==109
replace rk_gesa2 = 1 if st_hvv==110
replace rk_gesa2 = 3 if st_hvv==111
replace rk_gesa2 = 3 if st_hvv==112
replace rk_gesa2 = 1 if st_hvv==114
replace rk_gesa2 = 3 if st_hvv==115
replace rk_gesa2 = 1 if st_hvv==116
replace rk_gesa2 = 1 if st_hvv==117
replace rk_gesa2 = 3 if st_hvv==119
replace rk_gesa2 = 2 if st_hvv==121
replace rk_gesa2 = 1 if st_hvv==201
replace rk_gesa2 = 2 if st_hvv==202
replace rk_gesa2 = 3 if st_hvv==203
replace rk_gesa2 = 6 if st_hvv==204
replace rk_gesa2 = 5 if st_hvv==205
replace rk_gesa2 = 6 if st_hvv==206
replace rk_gesa2 = 6 if st_hvv==207
replace rk_gesa2 = 6 if st_hvv==208
replace rk_gesa2 = 6 if st_hvv==209
replace rk_gesa2 = 6 if st_hvv==210
replace rk_gesa2 = 2 if st_hvv==211
replace rk_gesa2 = 6 if st_hvv==212
replace rk_gesa2 = 1 if st_hvv==213
replace rk_gesa2 = 7 if st_hvv==214
replace rk_gesa2 = 6 if st_hvv==301
replace rk_gesa2 = 2 if st_hvv==302
replace rk_gesa2 = 1 if st_hvv==303
replace rk_gesa2 = 1 if st_hvv==304
replace rk_gesa2 = 3 if st_hvv==305
replace rk_gesa2 = 6 if st_hvv==306
replace rk_gesa2 = 1 if st_hvv==307
replace rk_gesa2 = 7 if st_hvv==308
replace rk_gesa2 = 3 if st_hvv==309
replace rk_gesa2 = 3 if st_hvv==401
replace rk_gesa2 = 2 if st_hvv==402
replace rk_gesa2 = 1 if st_hvv==403
replace rk_gesa2 = 2 if st_hvv==404
replace rk_gesa2 = 2 if st_hvv==405
replace rk_gesa2 = 5 if st_hvv==406
replace rk_gesa2 = 6 if st_hvv==407
replace rk_gesa2 = 1 if st_hvv==408
replace rk_gesa2 = 1 if st_hvv==409
replace rk_gesa2 = 5 if st_hvv==410
replace rk_gesa2 = 6 if st_hvv==411
replace rk_gesa2 = 1 if st_hvv==412
replace rk_gesa2 = 1 if st_hvv==413
replace rk_gesa2 = 6 if st_hvv==501
replace rk_gesa2 = 3 if st_hvv==502
replace rk_gesa2 = 7 if st_hvv==503
replace rk_gesa2 = 1 if st_hvv==504
replace rk_gesa2 = 5 if st_hvv==505
replace rk_gesa2 = 7 if st_hvv==506
replace rk_gesa2 = 6 if st_hvv==507
replace rk_gesa2 = 7 if st_hvv==508
replace rk_gesa2 = 3 if st_hvv==509
replace rk_gesa2 = 6 if st_hvv==510
replace rk_gesa2 = 6 if st_hvv==511
replace rk_gesa2 = 7 if st_hvv==512
replace rk_gesa2 = 3 if st_hvv==513
replace rk_gesa2 = 7 if st_hvv==514
replace rk_gesa2 = 7 if st_hvv==515
replace rk_gesa2 = 3 if st_hvv==516
replace rk_gesa2 = 7 if st_hvv==517
replace rk_gesa2 = 7 if st_hvv==518
replace rk_gesa2 = 3 if st_hvv==601
replace rk_gesa2 = 7 if st_hvv==602
replace rk_gesa2 = 1 if st_hvv==603
replace rk_gesa2 = 7 if st_hvv==604
replace rk_gesa2 = 7 if st_hvv==605
replace rk_gesa2 = 7 if st_hvv==606
replace rk_gesa2 = 5 if st_hvv==607
replace rk_gesa2 = 7 if st_hvv==608
replace rk_gesa2 = 7 if st_hvv==609
replace rk_gesa2 = 7 if st_hvv==610
replace rk_gesa2 = 7 if st_hvv==611
replace rk_gesa2 = 7 if st_hvv==612
replace rk_gesa2 = 7 if st_hvv==613
replace rk_gesa2 = 7 if st_hvv==702
replace rk_gesa2 = 6 if st_hvv==703
replace rk_gesa2 = 7 if st_hvv==704
replace rk_gesa2 = 1 if st_hvv==706
replace rk_gesa2 = 6 if st_hvv==707
replace rk_gesa2 = 3 if st_hvv==708
replace rk_gesa2 = 6 if st_hvv==709
replace rk_gesa2 = 6 if st_hvv==710
replace rk_gesa2 = 7 if st_hvv==712
replace rk_gesa2 = 6 if st_hvv==713
replace rk_gesa2 = 7 if st_hvv==715
replace rk_gesa2 = 7 if st_hvv==716
replace rk_gesa2 = 6 if st_hvv==717

gen rk_gesa3 = 3 if st_hvv==102
replace rk_gesa3 = 1 if st_hvv==103
replace rk_gesa3 = 6 if st_hvv==104
replace rk_gesa3 = 1 if st_hvv==108
replace rk_gesa3 = 1 if st_hvv==109
replace rk_gesa3 = 1 if st_hvv==110
replace rk_gesa3 = 3 if st_hvv==111
replace rk_gesa3 = 3 if st_hvv==112
replace rk_gesa3 = 2 if st_hvv==114
replace rk_gesa3 = 3 if st_hvv==115
replace rk_gesa3 = 1 if st_hvv==116
replace rk_gesa3 = 1 if st_hvv==117
replace rk_gesa3 = 3 if st_hvv==119
replace rk_gesa3 = 2 if st_hvv==121
replace rk_gesa3 = 1 if st_hvv==201
replace rk_gesa3 = 2 if st_hvv==202
replace rk_gesa3 = 3 if st_hvv==203
replace rk_gesa3 = 6 if st_hvv==204
replace rk_gesa3 = 5 if st_hvv==205
replace rk_gesa3 = 6 if st_hvv==206
replace rk_gesa3 = 6 if st_hvv==207
replace rk_gesa3 = 5 if st_hvv==208
replace rk_gesa3 = 6 if st_hvv==209
replace rk_gesa3 = 5 if st_hvv==210
replace rk_gesa3 = 2 if st_hvv==211
replace rk_gesa3 = 6 if st_hvv==212
replace rk_gesa3 = 1 if st_hvv==213
replace rk_gesa3 = 6 if st_hvv==214
replace rk_gesa3 = 6 if st_hvv==301
replace rk_gesa3 = 2 if st_hvv==302
replace rk_gesa3 = 1 if st_hvv==303
replace rk_gesa3 = 1 if st_hvv==304
replace rk_gesa3 = 3 if st_hvv==305
replace rk_gesa3 = 5 if st_hvv==306
replace rk_gesa3 = 1 if st_hvv==307
replace rk_gesa3 = 6 if st_hvv==308
replace rk_gesa3 = 3 if st_hvv==309
replace rk_gesa3 = 3 if st_hvv==401
replace rk_gesa3 = 2 if st_hvv==402
replace rk_gesa3 = 1 if st_hvv==403
replace rk_gesa3 = 2 if st_hvv==404
replace rk_gesa3 = 2 if st_hvv==405
replace rk_gesa3 = 5 if st_hvv==406
replace rk_gesa3 = 6 if st_hvv==407
replace rk_gesa3 = 1 if st_hvv==408
replace rk_gesa3 = 1 if st_hvv==409
replace rk_gesa3 = 5 if st_hvv==410
replace rk_gesa3 = 5 if st_hvv==411
replace rk_gesa3 = 1 if st_hvv==412
replace rk_gesa3 = 1 if st_hvv==413
replace rk_gesa3 = 6 if st_hvv==501
replace rk_gesa3 = 3 if st_hvv==502
replace rk_gesa3 = 6 if st_hvv==503
replace rk_gesa3 = 1 if st_hvv==504
replace rk_gesa3 = 5 if st_hvv==505
replace rk_gesa3 = 6 if st_hvv==506
replace rk_gesa3 = 6 if st_hvv==507
replace rk_gesa3 = 6 if st_hvv==508
replace rk_gesa3 = 3 if st_hvv==509
replace rk_gesa3 = 6 if st_hvv==510
replace rk_gesa3 = 6 if st_hvv==511
replace rk_gesa3 = 6 if st_hvv==512
replace rk_gesa3 = 3 if st_hvv==513
replace rk_gesa3 = 6 if st_hvv==514
replace rk_gesa3 = 6 if st_hvv==515
replace rk_gesa3 = 2 if st_hvv==516
replace rk_gesa3 = 6 if st_hvv==517
replace rk_gesa3 = 6 if st_hvv==518
replace rk_gesa3 = 3 if st_hvv==601
replace rk_gesa3 = 6 if st_hvv==602
replace rk_gesa3 = 1 if st_hvv==603
replace rk_gesa3 = 6 if st_hvv==604
replace rk_gesa3 = 6 if st_hvv==605
replace rk_gesa3 = 6 if st_hvv==606
replace rk_gesa3 = 5 if st_hvv==607
replace rk_gesa3 = 6 if st_hvv==608
replace rk_gesa3 = 6 if st_hvv==609
replace rk_gesa3 = 6 if st_hvv==610
replace rk_gesa3 = 6 if st_hvv==611
replace rk_gesa3 = 6 if st_hvv==612
replace rk_gesa3 = 6 if st_hvv==613
replace rk_gesa3 = 6 if st_hvv==702
replace rk_gesa3 = 6 if st_hvv==703
replace rk_gesa3 = 6 if st_hvv==704
replace rk_gesa3 = 1 if st_hvv==706
replace rk_gesa3 = 6 if st_hvv==707
replace rk_gesa3 = 3 if st_hvv==708
replace rk_gesa3 = 6 if st_hvv==709
replace rk_gesa3 = 6 if st_hvv==710
replace rk_gesa3 = 6 if st_hvv==712
replace rk_gesa3 = 6 if st_hvv==713
replace rk_gesa3 = 6 if st_hvv==715
replace rk_gesa3 = 6 if st_hvv==716
replace rk_gesa3 = 6 if st_hvv==717

label var rk_gesa "abgewandelte Raumkategorien nach DA Gesa"
label define rk_gesa 2 "Innenstadt" 3 "Zwischenzone" 4 "Stadtrand" 5 "ländl. Raum", modify
label value rk_gesa rk_gesa

label var rk_gesa2 "abgewandelte Raumkategorien nach DA Gesa - diff + angepasst"
label define rk_gesa2 1 "Innenstadt 1" 2 "Innenstadt 2"  3 "Zwischenzone 1" 5 "Zwischenzone 3" 6 "Stadtrand" 7 "ländl. Raum", modify
label value rk_gesa2 rk_gesa2

label value rk_gesa3 rk_gesa2

recode rk_gesa3 (1 2 = 1 "Innenstadt") (3=2 "Zwischenzone 1") (5=3 "Zwischenzone 2") (6=4 "Stadtrand"), gen(rk_gesa4)
gen rk_gesa5 = rk_gesa4
replace rk_gesa5 = 5 if rk_gesa2==7
label define rk_gk4 5 "ländl. HH", add modify
label value rk_gesa5 rk_gesa4


gen hvv_stadt = 1 if krs_hvv==4 & polgk==5
replace hvv_stadt = 2 if krs_hvv==8 & polgk==5
replace hvv_stadt = 3 if krs_hvv==5 & polgk==4 & rtyp==1
replace hvv_stadt = 4 if krs_hvv==5 & polgk==4 & rtyp==3
replace hvv_stadt = 5 if krs_hvv==4 & polgk==4
replace hvv_stadt = 6 if krs_hvv==3 & polgk==4 & rtyp==1
replace hvv_stadt = 7 if krs_hvv==3 & polgk==4 & rtyp==3
replace hvv_stadt = 8 if krs_hvv==2 & polgk==4
replace hvv_stadt = 9 if krs_hvv==7 & polgk==4 & rtyp==1
replace hvv_stadt = 10 if krs_hvv==7 & polgk==4 & rtyp==3
replace hvv_stadt = 11 if krs_hvv==6 & polgk==4

label define hvv_stadt 1 "Norderstedt" 2 "Lüneburg" 3 "Ahrensburg, Reinbek" 4 "Bad Oldesloe" 5 "Henstedt-Ulzburg", modify
label define hvv_stadt 6 "Wedel, Pinneberg, Quickborn" 7 "Elmshorn" 8 "Geesthacht" 9 "Buxtehude" 10 "Stade", modify
label define hvv_stadt 11 "Winsen, Seevetal, Neu Wulmstorf, Buchholz i.d. Nordheide", modify
label value hvv_stadt hvv_stadt

gen aw_ms = 1 if hvv_stadt<. & rtyp==1
replace aw_ms = 2 if hvv_stadt<. & rtyp==3
replace aw_ms = 3 if polgk==1 & rtyp==1
replace aw_ms = 4 if polgk==2 & rtyp==1
replace aw_ms = 5 if polgk==3 & rtyp==1
replace aw_ms = 6 if polgk<4 & rtyp==3

label define aw_ms 1 "Städte um Hamburg" 2 "Städte auf dem Land im HVV" 3 "ländl. Gemeinde im HH-Umland <2.000" 4 "ländl. Gemeinde im HH-Umland [2.000;5.000]" 5 "ländl. Gemeinde im HH-Umland [5.000;20.000]" 6 "ländl. Gemeinde im HVV", modify
label value aw_ms aw_ms

gen auswertungsklassen_raum = aw_ms
replace auswertungsklassen_raum = rk_gesa5 + 6 if missing(aw_ms)
label value auswertungsklassen_raum aw_ms

label define aw_ms 7 "HH - Innenstadt" 8 "HH - Zwischenzone 1" 9 "HH - Zwischenzone 2" 10 "HH - Stadtrand" 11 "ländl. HH", modify

tabout auswertungsklassen_raum verh_perg   [iw=p_gew]  using "M:\Nachfragedaten\Berechnungsergebnisse\verh_besch_hh.txt", replace c(freq row col)  layout(rb)
tabout auswertungsklassen_raum verh_perg   [iw=p_gew] if hp_alter>19 & hp_alter<26  using "M:\Nachfragedaten\Berechnungsergebnisse\verh_besch_hh_20_25.txt", replace c(freq row col)  layout(rb)
tabout auswertungsklassen_raum verh_perg  [iw=p_gew] if hp_alter>15 & hp_alter<20  using "M:\Nachfragedaten\Berechnungsergebnisse\verh_besch_hh_16_19.txt", replace c(freq row col)  layout(rb)

save "`path'MiD_2008_2006_Personen_6.dta", replace


use "`path'MiD_2008_2006_Wege_8.dta", clear



label define jn 0 "nein" 1 "ja", modify

duplicates tag hhid pid st_time en_time w04, gen(doppelter_Weg)
duplicates drop hhid pid st_time en_time w04 w01 w13 hvm, force
label var doppelter_Weg "Weg kam im Datensatz doppelt vor."



* Einzelfallbearbeitung doppelter Weg


* Zeittransformation für Folgetage
replace st_time = 86400*st_dat + st_time
replace en_time = 86400*en_dat + en_time

* Ermittlung Aktivitätendauer
bysort hhid pid: replace akt_dauer = (st_time[_n] - en_time[_n-1])/60 if _n>1
label var akt_dauer "Aktivitätendauer"
* Ermittlung einer Wegekette mit mind. einer neg. Aktivitätendauer
gen neg_time = akt_dauer<0
label var neg_time "negative Aktivitätendauer"
bysort hhid pid: egen p_neg = sum(neg_time)
label var p_neg "Wegekette mit neg. Aktivätendauer"

bysort hhid pid: replace wsid = _n
* verbleibende Wege mit negativer Aktivitätendauer
bysort hhid pid: replace akt_dauer = (st_time[_n] - en_time[_n-1])/60 if _n>1
* Ermittlung einer Wegekette mit mind. einer neg. Aktivitätendauer
gen neg_time2 = akt_dauer<0
label var neg_time2 "negative Aktivitätendauer; nach Prüfung"
bysort hhid pid: egen p_neg2 = sum(neg_time2)
label var p_neg2 "Wegekette mit neg. Aktivätendauer; nach Prüfung"

gen wegedauer = (en_time-st_time)/60
label var wegedauer "Wegedauer nach Plausibilitätsprüfung"
* Prüfung der Wegelängen zur Verkehrsmittelwahl:
* 1) Fälle mit langen Fußwegen zur Arbeit, private Erledigung -> Einzelfallprüfung!
gen tempo2 =  round(wegkm_k/(wegedauer/60),1)
replace tempo2 = . if missing(wegkm_k) & missing(w071)
replace tempo2 = . if (wegkm_k<1 & wegedauer>59) | (wegkm_k<0.5 & wegedauer>29)
* angenommene Geschwindigkeit für Fußgänger: 3 km/h
replace wegkm_k = wegedauer/5/60 if hvm_diff==1 & wegkm_k == 0 & wegedauer<=5 & w04_dzw!=712

replace tempo2 =  round(wegkm_k/(wegedauer/60),1) if tempo2<.

gen VM_anpass = 0
label var VM_anpass "angepasste Verkehrsmittelwahl"

replace pkw_mf=1 if pkw_f==1 & (hp_alter<17 | hp_pkwfs==0)
replace VM_anpass = 1 if pkw_f==1 & (hp_alter<17 | hp_pkwfs==0)
replace pkw_f=0 if pkw_f==1 & (hp_alter<17| hp_pkwfs==0)

replace  w05_3 = 1 if  mrad_f==1 & (hp_alter<17 | hp_pkwfs==0)
replace VM_anpass = 1 if mrad_f==1 & (hp_alter<17 | hp_pkwfs==0)

sort hhid pid wsid


label define w072_2 .a `"keine Angabe"', modify
forvalue i=2/10{
replace w072_`i' = .a if w072_`i'<0
label value w072_`i' w072_2
}

drop zweck_angep
gen zweck_angep = 0
gen begleit = w07

replace  zweck_angep=1 if hp_alter<14 & w04<3 
replace w074 = 1 if hp_alter<14 & w04<3 
replace  w04=11 if hp_alter<14 & w04<3
replace zweck_angep=1 if hp_alter<5 & w04==3
replace w04=32 if hp_alter<5 & w04==3
replace zweck_angep=1 if hp_alter>4 &hp_alter<14 & w04<3
replace w074=1 if hp_alter>4 &hp_alter<14 & w04<3
replace w04=3 if hp_alter>4 & hp_alter<14 & w04<3
replace  zweck_angep=1 if hp_alter<5 & w04<9
replace  w04=11 if hp_alter<5 & w04<9 
replace zweck_angep = 1 if hp_alter<5 & w04_dzw == 501 
replace w074 = 4 if hp_alter<5 & w04_dzw == 501
replace w04 = 11 if hp_alter<5 & w04_dzw == 501
replace zweck_angep = 1 if hp_alter<5 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))
replace w074 = 6 if hp_alter<5 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))
replace w04 = 11 if hp_alter<5 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))
replace zweck_angep = 1 if hp_alter<5 & w04_dzw > 503  & begleit ==0
replace w074 = 8 if hp_alter<5 & w04_dzw > 503  & begleit ==0
replace w04 = 11 if hp_alter<5 & w04_dzw > 503 & begleit ==0
replace zweck_angep = 1 if hp_alter<5 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713))
replace w074 = 9 if hp_alter<5 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713)) 
replace w04 = 11 if hp_alter<5 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713))

replace w13=. if hp_alter<14 & w13==2

label define w074 4 `"periodischer Einkauf"', modify
label define w074 6 `"aperiodischer Einkauf"', modify
label define w074 8 `"Einkaufsbummel"', modify
label define w074 9 `"Rundgang"', modify
label value w074 w074


* Wegeende, Weganfang, Anzahl dokumentierter Wege
version 10
merge hhid pid using "`path'MiD_2008_2006_Personen_6.dta", sort uniqusing keep(rtyp p_gew polgk rtypd7 ktyp ktyp_zsg gtyp bikgk10 krs_hvv sb_hvv st_hvv  s0* hp_alter hp_alter2 Anz_auto_Person PKW_VERF_neu ohne_pw hh_ohne_pkw hh_mofa hh_rad hh_zeitkarte hat_zeitkarte zeitkarte hp_ausb p05_3 hheink_5  hhtyp_4 hhtyp_3 hp_alter2 p052_ka p054_ka hp_besch_aggr p14b hp_besch hp_beruf w12) update replace _merge(update_PkwVerf)
* drop if missing(wsid)



version 12
* Variable w13: umkodieren zu binominaler Variable, die Außenorientierung anzeigt.
recode w13 (3=0 "innerorts") (4=1 "außerorts") (1 2 5 =.d), gen(Zielwahl)
* Labelanpassung w13
label define w13 3 `"and.Z.innerhalb der Stadt oder des Ortes"'  4 `"and.Z.außerhalb der Stadt oder des Ortes"', add modify
label value w13 w13 

bysort hhid pid: gen Anz_W =_N
label var Anz_W "Anzahl Wege Person am Stichtag (nach Bereinigung)"
replace Anz_W = 0 if missing(wsid)

* Als Filterfunktion
bysort hhid pid: gen w_ende = wsid==_N
label var w_ende "letzter Weg des Stichtages" 
bysort hhid pid: gen w_anf = wsid== 1
label var w_anf "erster Weg des Stichtages"
sort hhid pid wsid
bysort hhid pid: replace w01=1 if w01==.a & w13[_n-1]==5 & w04[_n-1]> 3 & w04[_n-1]<11 & wsid!=1
bysort hhid pid: replace w01=1 if w13[_n-1]==1
* bysort hhid pid: replace w01=1 if w01==.a &  w13[_n-1]==5 & w01[_n-1]==1
bysort hhid pid: replace w01=1 if w01==.a &  w13[_n-1]==5

* Wegezwecke anpass, Rückwege
* hwzweck eignet sich nicht für Wegekettenbildung, weil Hin- und Rückweg mit einem Wegezweck versehen sind.
* Deswegen werden die Kategorien aus hwzweck für die Variable Zweck verwendet.
label define w04 33 "Zweitunterkunft (Hotel, Pension, Zweitwohnung)" 34 "Verkehrsknoten", add modify
label value w04 w04

sort hhid pid wsid

gen Zweck = 1 if w04==1
label var Zweck "angepasster Wegezweck"
replace Zweck = 2 if w04==2
replace Zweck = 3 if w04==3 | w04==31 | w04==32 
replace Zweck = 4 if w04==4
replace Zweck = 6 if w04==7
replace Zweck = 10 if w13==5 | w04_dzw==711|w04_dzw==710|w04_dzw==712
/* Diese Zwecke implizieren, ein Rundweg zu sein, daher wird w13 angepasst */
replace w13 = 5 if Zweck == 10

replace Zweck = 5 if w04==5 | w04_dzw==504

replace Zweck = 7 if w04 ==6 | w04==11 | w04_dzw==11 | w04_dzw==716

replace Zweck = 1 if w13==2 & w04==10

replace Zweck = 8 if w04_dzw==701 | w04_dzw==707 | w04==33
replace Zweck = 11 if w04_dzw==501
replace Zweck = 12 if w04_dzw==502|w04_dzw==505
replace Zweck = 13 if w04_dzw==503
replace Zweck = 0 if w13==1 & w04==10
replace Zweck = 0 if w04 ==8

replace Zweck = 10 if w01==1 & w13==1
/* Diese Zwecke implizieren, ein Rundweg zu sein, daher wird w13 angepasst */
replace w13 = 5 if Zweck == 10

* replace Zweck = 14 if w04==3
* replace Zweck = 15 if w04==31
* replace Zweck = 16 if w04==32


* Behandlung der Rückwege
* Hintergrund: Rückwege wurden aus Befragungsökonomischen Gründen eingeführt, um die Interviewlänge zu verkürzen.
* Aus der Logik heraus werden anhand vorheriger Wege bzw. Start- und Zielorte der Wegezweck ermittelt.
* Routine zur Belegung von Rückwegen
* gen miss_akt = missing(Zweck) & w04==9
* bysort hhid pid: egen miss = sum(miss_akt)
* br hhid pid wsid Zweck w04  w04_dzw ST_STD ST_MIN  EN_STD EN_MIN w01 w13 if miss>0

* Fremde Wohnung entspricht einer Unterkunft bzw. Besuch einer fremden Wohnung oder einer sonstigen Bleibe, z.B. Hotel, Pension, Zeltplatz u.a.
* Rückwege von Begleitwegen werden als Weg in eine fremde Wohnung umkodiert.// Änderung abhängig von Begleitzweck!!!
bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & (w04_dzw[_n-2]==701 | w04_dzw[_n-2]==707 | w04_dzw[_n-2]==718 | w04[_n-2]==33)
bysort hhid pid: replace Zweck = 1 if missing(Zweck) & w04==9 & w04[_n-2]==1
bysort hhid pid: replace Zweck = 1 if missing(Zweck) & w04==9 & w01[_n-1]==2
bysort hhid pid: replace Zweck = 2 if missing(Zweck) & w04==9 & w04[_n-2]==2
bysort hhid pid: replace Zweck = 3 if missing(Zweck) & w04==9 & (w04[_n-2]==3 | w04[_n-2]==31 | w04[_n-2]==32 )
bysort hhid pid: replace Zweck = 6 if missing(Zweck) & w04==9 & (w04_dzw[_n-2]==704 | w04_dzw[_n-2]==714 | w04_dzw[_n-2]==713 | w04_dzw[_n-2]==715 | w04_dzw[_n-2]==702)
bysort hhid pid: replace Zweck = 14 if missing(Zweck) & w04==9 & w04[_n-2]==3
bysort hhid pid: replace Zweck = 15 if missing(Zweck) & w04==9 & ( w04[_n-2]==31)
bysort hhid pid: replace Zweck = 16 if missing(Zweck) & w04==9 & ( w04[_n-2]==32 )
bysort hhid pid: replace Zweck = 11 if missing(Zweck) & w04==9 & w04_dzw[_n-2]==501
bysort hhid pid: replace Zweck = 12 if missing(Zweck) & w04==9 & (w04_dzw[_n-2]==502|w04_dzw[_n-2]==505)
bysort hhid pid: replace Zweck = 13 if missing(Zweck) & w04==9 & w04_dzw[_n-2]==503
bysort hhid pid: replace Zweck = 4 if missing(Zweck) & w04==9 & w04[_n-2]==4
bysort hhid pid: replace Zweck = 5 if missing(Zweck) & w04==9 & w04[_n-2]==5
bysort hhid pid: replace Zweck = 7 if missing(Zweck) & w04==9 & Zweck[_n-2]==7
bysort hhid pid: replace Zweck = 0 if missing(Zweck) & w04==9 & w01[_n-2]==1
bysort hhid pid: replace Zweck = 0 if missing(Zweck) & w04==9 & w04[_n-2]==8
bysort hhid pid: replace Zweck = 17 if w04_dzw==704
bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & w04[_n-1]==11 & w04[_n-2]==11 & w04_dzw[_n-3]== 701
bysort hhid pid: replace Zweck = 6 if missing(Zweck) & w04==9 & w04[_n-2]==7
bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & w04[_n-2]==6

bysort hhid pid: replace Zweck = 8 if missing(Zweck) & (w04==9 | w04==10) & (w01[_n-1]==4 |w01[_n-1]==3 | w01[_n-1]==.a) & wsid==2


* Rundweg + andere Aktivität = Freizeit
replace Zweck = 6 if missing(Zweck) & w04==10 & w13 == 5
replace Zweck = 9 if missing(Zweck) & w04==10

bysort hhid pid: replace Zweck = Zweck[_n-2] if w04==9 & w04[_n-2]==10
bysort hhid pid: replace Zweck = Zweck[_n-2] if w04==9 & w04[_n-2]==9



* Behandlung von *weiß nicht*
replace Zweck = 9 if wsid>1 & w04==.c
replace Zweck = 8 if w04==.c & wsid==1

replace Zweck=12 if Zweck==4

label copy HWZWECK Zweck
label value Zweck Zweck
label define Zweck 0 `"Wohnen"' 8 `"fremde Wohnung"' 9 `"Sonstiges"' 10  `"Freizeit ohne Zweck"', add modify
label define Zweck 11 `"tägl. Einkauf"' 12 `"allg. Einkauf"' 13 `"Einkaufsbummel"', add modify
label define Zweck 14 `"Berufsschule"' 15 `"Schule"' 16 `"Kindergarten"' 17 `"Sport"', add modify


* Berufswege: Wege von und zur Arbeit + Wege von und zum Dienstgeschäft für AP 2.2
gen arbeit = Zweck==1 | Zweck==2
bysort hhid pid: replace arbeit = 1 if Zweck[_n+1]==1 | Zweck[_n+1]==2
replace arbeit = 1 if w01==2
label value arbeit jn
label var arbeit "Arbeitsweg"
* Ausbildungswege für AP 2.3
gen ausbildung = Zweck==3
bysort hhid pid: replace ausbildung = 1 if Zweck[_n+1]==3
label value ausbildung jn
label var ausbildung "Aubildungsweg"

* hwzweck angepasst
* fremde Wohnung,Rundweg -> Freizeit; Aggregation Einkaufsgründe
gen hwzweck2 = Zweck

replace hwzweck2 = 6 if hwzweck2==8 | hwzweck2==10
bysort hhid pid: replace hwzweck2 = Zweck[_n-1] if (hwzweck2==0 |hwzweck2==8) & wsid>1

replace hwzweck2 = 6 if Anz_W==1 & (s02_1==1 | s02_2==1) & (hwzweck2==0 | hwzweck2==8)
replace hwzweck2 = 6 if w01!=2 & w13!=2 & hwzweck2==0 & wsid==1
replace hwzweck2 = 9 if Anz_W==1 & (s02_5==1)  & (hwzweck2==0 | hwzweck2==8)
replace hwzweck2 = 4 if hwzweck2==11 | hwzweck2==12 |  hwzweck2==13
replace hwzweck2 = 1 if w01==2 & hwzweck2==0
replace hwzweck2 = 7 if w01==2 & w13==1
replace hwzweck2 = 4 if hwzweck2==11 | hwzweck2==12 |  hwzweck2==13
replace hwzweck2 = 6 if hwzweck2==8 | hwzweck2==10

label var hwzweck2 "Weghauptzweck überarbeitet"
label value hwzweck2 Zweck

* Problem der doppelten Heimwege.
bysort hhid pid: gen dop_home= w04==8 & w04[_n-1]==8
bysort hhid pid: egen dop_home_p = sum(dop_home)
label var dop_home "doppelter Heimweg"
label var dop_home_p "doppelter Heimweg, komplette Wegekette"

* Bildung der spezifischen Auswertungsklassen nach Projektbeschreibung
* 1) Verkehrsmittel nach vorgegebenen Verkehrsmittelklassen
* 2) Distanzklassen
* Definition der Verkehrsmittelkombinationen
gen OEV =  w05_12 | w05_13 | w05_11 |  w05_15 | w05_16 | w05_17 | w05_18
gen MIV =  (w05_4 | w05_5 | w05_7 |  w05_3)
gen  intermodal_weg = MIV + OEV +  w05_2 + w05_14  if w05_14<2 |  w05_2<2 
label var intermodal_weg "intermodaler Weg"

gen VM = 12 if w05_1==1 & intermodal_weg<2
replace VM = 11 if w05_2==1 & intermodal_weg<2
replace VM = 1 if  pkw_f==1 & intermodal_weg<2
replace VM = 2 if pkw_mf==1 & intermodal_weg<2
replace VM = 3 if mrad_f==1 & intermodal_weg<2
replace VM = 4 if mrad_mf==1 & intermodal_weg<2
replace VM = 5 if lkw_f==1 & intermodal_weg<2
replace VM = 6 if lkw_mf==1 & intermodal_weg<2
replace VM = 10 if (w05_15 | w05_16 | w05_17) & intermodal_weg<2
replace VM = 8 if w05_18==1 & wegkm_k>50 & intermodal_weg<2
replace VM = 7 if w05_11 | w05_12 | w05_13 & intermodal_weg<2
replace VM = 9 if w05_14==1 & intermodal_weg<2


replace VM = 13 if intermodal_weg>1 & intermodal_weg<.


label define VM 1 `"Pkw-F"' 2 `"Pkw-MF"' 3 `"Mrad-F"' 4 `"Mrad-MF"' 5 `"Lkw-F"' 6 `"Lkw-MF"' 7 `"ÖPNV"', modify
label define VM 8 `"Flugzeug"' 9 `"Taxi"' 10 `"Fernverkehr"' 11 `"Rad"' 12 `"Fuß"' 13 `"Sonstige"', modify
label value VM VM


gen VM_Kombi = 1 if intermodal_weg < 2
replace VM_Kombi = 3 if intermodal_weg >1 &  OEV & MIV
replace VM_Kombi = 2 if intermodal_weg >1 &  w05_2 == 1
replace VM_Kombi = 5 if missing(VM_Kombi)
* Auf die Definition von Kiss&Ride wird aufgrund des Datensatzaufbaus der MiD verzichtet, da keine hinreichend genauen Aussagen hier getroffen werden können.
label var VM_Kombi "VM_Kombi für Sonderauswertung"

label define VM_Kombi 1 `"Monomodal"' 2 `"Bike&Ride"' 3 `"Park&Ride"' 5 `"sonstige Multimodale"', modify
label value VM_Kombi VM_Kombi

recode VM ( 12=1 "Fuß") ( 11=2 "Rad") ( 7 8 10=3 "ÖV") ( 1 3 5=4 "MIV") ( 2 4 6=5 "MIV-MF") ( 13 9=6 "Sonstige"), gen(VM_6)
replace VM_6 = 6 if intermodal_weg>1 & intermodal_weg<.
replace VM_6 =4 if w05_3==1 & intermodal_weg<2

* drop VM

gen Distanzklasse = 0.5 if  wegkm_k <=0.5
replace Distanzklasse = 1 if wegkm_k>0.5 & wegkm_k <=1
replace Distanzklasse = 2 if wegkm_k>1& wegkm_k <=2
replace Distanzklasse = 5 if wegkm_k>2 & wegkm_k <=5
replace Distanzklasse = 10 if wegkm_k>5 & wegkm_k <=10
replace Distanzklasse = 20 if wegkm_k>10 & wegkm_k <=20
replace Distanzklasse = 50 if wegkm_k>20 & wegkm_k <=50
replace Distanzklasse = 100 if wegkm_k>50 & wegkm_k <=100
replace Distanzklasse = 101 if wegkm_k>100 & wegkm_k < 9000
replace Distanzklasse = . if missing(wsid)
label var Distanzklasse "Distanzklasse für Sonderauswertung"


* Prüfung der Wegelängen zur Verkehrsmittelwahl:


* Plausibiltätsprüfung mit: tab HVM_DIFF  VM, col nofr

* Begleitwege
duplicates tag hhid st_time en_time w04 w13, gen(begl)


* Filter auf Personen mit negativer Aktivitätendauer oder 
gen filter = p_neg2==0 
replace filter = 0 if dop_home==1

* Fuß zählt als 0, Pkw-MF & Pkw-Fahrer zählen als ein Verkehrssystem => Rad, ÖV, Pkw

bysort hhid pid: gen Pkw = VM_6<3
bysort hhid pid: egen Pkw_sum = sum(Pkw)
bysort hhid pid: gen Pkw_tag = Pkw_sum>0
bysort hhid pid: gen OV = VM_6==3
bysort hhid pid: egen OV_sum = sum(OV)
bysort hhid pid: gen OV_tag = OV_sum>0
bysort hhid pid: gen Rad = VM_6==4
bysort hhid pid: egen Rad_sum = sum(Rad)
bysort hhid pid: gen Rad_tag = Rad_sum>0
bysort hhid pid: gen Sonstige = VM_6==6
bysort hhid pid: egen Sonstige_sum = sum(Sonstige)
bysort hhid pid: gen Sonstige_tag = Sonstige_sum>0

drop Pkw_sum OV_sum Rad_sum Sonstige_sum

gen multimodal_tag = (Rad_tag & Pkw_tag) | (Pkw_tag & OV_tag) | (Rad_tag & OV_tag) | (Rad_tag & Sonstige_tag) | (Pkw_tag & Sonstige_tag) | (OV_tag & Sonstige_tag) | intermodal_weg>0
label value multimodal_tag jn
gen Anz_VM_Tag = Rad_tag+Sonstige_tag+Pkw_tag+OV_tag


label var Anz_VM_Tag "Anzahl verwendeter Verkehrssysteme am Stichtag"
label var multimodal_tag "Multimodale Person am Stichtag"

foreach x in  "Pkw" "Rad" "Sonstige" "OV" {
	label var `x' "Weg mit `x'-Nutzung"
	label var `x'_tag "Person mit mind. einen `x'weg"
	label value `x' jn
	label value `x'_tag jn
}

* Bildung der Grundtypen der verhaltenshomogenen Gruppen gem. Protokoll vom 14.09.2011
gen verh_perg = 1 if hp_alter<7
replace verh_perg = 2 if hp_alter>4 & hp_alter<14 & (hp_besch==5 | p14b==9)
replace verh_perg = 3 if hp_alter>8 & hp_alter<17 & (hp_besch==5 | (p14b>9 & p14b<15))
replace verh_perg =4 if hp_alter>16 & hp_besch==5
replace verh_perg =5 if hp_alter>15 & hp_besch==4
replace verh_perg =6 if hp_besch==6
replace verh_perg =7 if hp_besch==1
replace verh_perg =8 if hp_besch==2 | hp_besch==3
replace verh_perg =9 if hp_besch==11 | hp_besch==10
replace verh_perg =10 if missing(verh_perg) & hp_beruf==2
replace verh_perg =11 if hp_alter>64 & hp_beruf==2 & hp_besch==12
replace verh_perg =12 if hp_alter>74 & hp_beruf==2 & hp_besch==12

label define verh_perg 1 `"Kleinkind"' 2 `"Grundschüler"' 3  `"Schüler-Mittelstufe"' 4  `"Schüler-Oberstufe"' 5  `"Berufsschüler"', modify
label define verh_perg 6 `"Student"' 7 `"Vollzeitbeschäftigter"' 8 `"Teilzeitbeschäftigter"' 9 `"nicht erwerbstätig: Hausfrau/-mann"' 10 `"nicht erwerbstätig: sonstige"', modify
label define verh_perg 11 `"aktiver Rentner"' 12  `"inaktiver Rentner"', modify

label value verh_perg verh_perg


save "`path'MiD_2008_2006_Wege_9.dta", replace

gen Zweck_txt = "W" if Zweck==0
replace Zweck_txt = "A" if Zweck==1
replace Zweck_txt = "d" if Zweck==2
replace Zweck_txt = "B" if Zweck==3
replace Zweck_txt = "E" if Zweck==4
replace Zweck_txt = "P" if Zweck==5 
replace Zweck_txt = "F" if Zweck==6
replace Zweck_txt = "Bgl" if Zweck==7
replace Zweck_txt = "FW" if Zweck==8
replace Zweck_txt = "S" if Zweck==9
replace Zweck_txt = "R" if Zweck==10
replace Zweck_txt = "E.p" if Zweck==11
replace Zweck_txt = "E.ap" if Zweck==12
replace Zweck_txt = "E.b" if Zweck==13

* replace Zweck_txt = "B.b" if Zweck==14
* replace Zweck_txt = "B.s" if Zweck==15
* replace Zweck_txt = "B.k" if Zweck==16
replace Zweck_txt = "Sp" if Zweck==17

bysort hhid pid: gen w_kette1 = "W-" + Zweck_txt if w01==1 & wsid==1
bysort hhid pid: replace w_kette1 = "A-" + Zweck_txt if w01==2 & wsid==1
bysort hhid pid: replace w_kette1 = "FW-" + Zweck_txt if w01>2 & wsid==1
bysort hhid pid: replace w_kette1 = w_kette[_n-1] +  "-" + Zweck_txt if wsid>1
label var w_kette1 "Wegemuster Erhebungstag"

bysort hhid pid: gen w_paar = "W-" + Zweck_txt if w01==1 & wsid==1
bysort hhid pid: replace w_paar = "A-" + Zweck_txt if w01==2 & wsid==1
bysort hhid pid: replace w_paar = "FW-" + Zweck_txt if w01>2 & wsid==1
bysort hhid pid: replace w_paar = Zweck_txt[_n-1] + "-" + Zweck_txt if wsid>1
label var w_paar "Wegepaar Erhebungstag"


* Wohnortbezug + Sortierung
gen WWID= Zweck==0 | w01==1
bysort hhid pid: replace WWID = WWID + WWID[_n-1] if wsid>1
bysort hhid pid: replace WWID = WWID - 1 if WWID>1 & Zweck==0
bysort hhid pid: replace WWID = 0  if WWID[_n-1]==0 & wsid==Anz_W
bysort hhid pid: replace WWID = 0 if Anz_W==1 & wsid==1 & w13==1
bysort hhid pid: replace WWID = 0 if Zweck==0 & WWID[_n-1]==0 & wsid>1
bysort hhid pid: replace WWID = 0 if Zweck==0 & wsid==1


bysort hhid pid WWID: gen wwsid =_n if WWID>0
bysort hhid pid WWID: replace wwsid = 0 if WWID==0
replace wwsid = . if missing(Zweck)

bysort hhid pid WWID: gen WW_Anz =_N
bysort hhid pid WWID: gen WW_anf = wwsid==1
bysort hhid pid WWID: gen WW_end = wwsid==_N
label var WWID "Wegkollektiv Bezug Wohnen"

* kurze Ketten mit einer Aktivität, wohnortbezogen: W-Akt-W
bysort hhid pid WWID: gen ww_kette1 = "W-" + Zweck_txt if wwsid==1
* bysort hhid pid: replace ww_kette1 = "FW-" + Zweck_txt if w01>2 & wsid==1 & WWID>0
* bysort hhid pid: replace ww_kette1 = Zweck_txt[_n-1] + "-" + Zweck_txt if wwsid==1 & wsid>1
bysort hhid pid WWID: replace ww_kette1 = ww_kette1[_n-1] +  "-" + Zweck_txt if WWID>0 & missing(ww_kette1)
* Wegekettenschluss für Wohnwege
bysort hhid pid: replace ww_kette1=ww_kette1 + "-W" if Anz_W==1 & WWID>0
bysort hhid pid: replace ww_kette1=ww_kette1 + "-W" if Anz_W==wsid & (Zweck>1 & Zweck!=8) & Anz_W>1 & WWID>0
bysort hhid pid: replace ww_kette1=ww_kette1 + "-W" if ww_kette1=="W-R" & w13==5
label var ww_kette1 "Wegekette wohnbasiert"

* Anpassung der wohnortbezogenen Wegeanzahl nach tatsächlich durchgeführten Wegen
bysort hhid pid WWID: gen WW_Anz_k = _N
bysort hhid pid WWID: replace WW_Anz_k = WW_Anz_k + 1 if  (Zweck>1 & Zweck!=8 & Zweck!=10) & Anz_W>1 & WWID>0 & WW_end

replace ww_kette1 = "" if missing(Zweck)


* Arbeitsortbezug + Sortierung
* 263 Wegeketten mit mehr als einem Arbeitsweg
sort hhid pid wsid
gen WAID = Zweck==1 | w01==2
bysort hhid pid: egen arbeitskette = sum (WAID)
sort hhid pid wsid
label var arbeitskette "Wegekette mit mind. einem Arbeitsweg"
bysort hhid pid: replace WAID = 0 if arbeitskette<2

bysort hhid pid: replace WAID = WAID + WAID[_n-1] if wsid>1 & arbeitskette>1
bysort hhid pid: replace WAID = WAID - 1 if WAID>1 & Zweck==1

* bysort hhid pid: replace WAID = 0 if Zweck==1
* bysort hhid pid: replace WAID = WAID - 1 if WAID>1 & Zweck[_n-1]==1

bysort hhid pid WAID: gen WASID =_n if WAID>0
* bysort hhid pid WAID: replace WAID = WAID-1  if Zweck==1


bysort hhid pid WAID: gen WA_Anz =_N if WAID>0
bysort hhid pid WAID: gen WA_anf = WASID==1 if WAID>0
bysort hhid pid WAID: gen WA_end = WASID==_N if WAID>0
bysort hhid pid WAID: replace WA_end = 0 if Zweck!=1 & wsid==Anz_W

* Ausschluss von Nachtschichtarbeitern (am Anfang und am Ende des Tages ein Arbeitsweg, z.B. bei HHID )
bysort hhid pid WAID: replace WA_end = 0 if Zweck==1 & wsid==WASID[_N] & wsid==Anz_W

label var WAID "Wegkollektiv Bezug Arbeit"
* kurze Ketten mit einer Aktivität, arbeitsortbezogen: A-Akt-W

bysort hhid pid WAID: gen wa_kette1= Zweck_txt if WASID==1 & WAID==1
* bysort hhid pid WAID: replace wa_kette1  = w_paar if WASID==1 & WAID==1 & wsid>1
bysort hhid pid WAID: replace wa_kette1 = wa_kette1[_n-1] +  "-" + Zweck_txt if WAID>0 & missing(wa_kette1) & WASID>1
* bysort hhid pid WAID: replace wa_kette1 = wa_kette1 + "-A" if WA_end==1
label var wa_kette1 "Wegekette arbeitsbasiert"
* Filter für wohn- und arbeitsortbezogene Wege:

gen filter_w = filter & WW_end & WWID>0 & (Zweck!=8 & Zweck!=1 & Zweck!=2)
gen filter_a = filter & WA_end==1 & WAID>0

label var filter_w "Filter für wohnortbasierte Wegeketten"
label var filter_a "Filter für arbeitsortbasierte Wegeketten"


sort hhid pid wsid


* Wege in geschlossenen wohnortsbezogenen Wegeketten
gen komplex = WW_Anz_k  > 2 & WW_Anz<. & WWID>0
replace komplex = . if missing(WWID) | WWID==0
label var komplex "Weg in komplexer wohnortsbezogener Wegekette"
label value komplex jn

* Wege in arbeitsortbezogenen Wegeketten
gen komplex2 = WA_Anz > 3 & WA_Anz<. 
replace komplex2 = . if WAID==0
label var komplex2 "Weg in komplexer arbeitsortbezogener Wegekette"
label value komplex2 jn




drop Zweck_txt ww_kette1 wa_kette1
* tab Zweck komplex if filter & WW_end==0, row

replace w12 = 0 if missing(w12)
replace Anz_W = 0 if wsid==0
gen Anz_W_ges = Anz_W + w12



save "`path'MiD_2008_2006_Wege_10.dta", replace


