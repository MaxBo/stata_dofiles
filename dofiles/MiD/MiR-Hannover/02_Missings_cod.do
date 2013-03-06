***Missings erzeugen***

use "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien.dta", clear

set mem 800m
set more off

* Gemeindekategorie 1 + 2
gen GK2 = POLGK
label value GK2 POLGK
gen GK1 = 1 if POLGK>5
replace GK1 = 2 if POLGK<6
label define GK1 1 `"F/OF"' 2 `"RV ohne F/OF"', modify
label value GK1 GK1
label var GK1 "Gebietskategorie 1"
label var GK2 "Gebietskategorie 2"


foreach x in "P01_1" "P02" "P0221" "HP_BERUF" "P036" "P032" "P031" "P030" "P0222" "P041" "P042" "P051A" "P051B" "P051D" "P06" "P06A" "HP_SEX" "HP_BKAT" "HP_PKWFS" "P16_3" "S03" "S01" "S04"{
recode `x' (7=.b) (8=.c) (9=.a)
label define `x' .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value `x' `x'
}
 
foreach x in " P054" "P052" "HP_TAET" "HP_BESCH" "RBW05" "RBW04" "HHEINK"{
recode `x' (97=.b) (98=.c) (99=.a)
label define `x' .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value `x' `x'
}


foreach x in HP_ALTER  {
recode `x' (997=.b) (998=.c) (999=.a)
label define `x' .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value `x' `x'
}

foreach x in "P20_1" "P20_2" "P20_3" "P20_4" "P20_5" "P20_6" "P20_7" "P20_8" "P20_9" "P20_10" "P20_11" "P20_12" "P20_13" {
recode `x' (7=.b) (8=.c) (9=.s)
label define `x' .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .s `"ZP kann ÖPNV aufgrund Behinderung nicht nutzen"', add modify
label value `x' `x'
}

recode P070 (97=.b) (98=.c) (96=.s)
label define P070 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .s `"fahre nie mit ÖV"', add modify
label value P070 P070

recode P070_A (97=.b) (98=.c) (96=.s)
label define P070_A .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .s `"fahre nie mit ÖV"', add modify
label value P070_A P070_A

recode P092 (8=.c) 
label define P092 .c `"weiß nicht"', add modify
label value P092 P092

recode GESEIN (3=.c)
label define GESEIN .c `"weiß nicht/verweigert"', add modify
label value GESEIN GESEIN

recode PERGRUP* (95=.e)
label define PERGRUP .e `"nicht zuzuordnen"', add modify
label define PERGRUP1 .e `"nicht zuzuordnen"', add modify
label value PERGRUP PERGRUP
label value PERGRUP1 PERGRUP1

recode OV_SEG (95=.e)
label define OV_SEG .e `"nicht zubestimmen"', add modify
label value OV_SEG OV_SEG

recode OEK_STAT (9=.e)
label define OEK_STAT .e `"nicht zuzuordnen"', add modify
label value OEK_STAT OEK_STAT

* Führerscheinbesitz
foreach x in "HP_PKWFS" "P02" "P06" "P092"{
recode `x' (2=0)
label define `x' 1 `"ja"' 0 `"nein"', modify add
label value `x' jn
}



save "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod.dta", replace




use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien.dta", clear

* WEGE
* Umkodierung der Variablen in fehlende Werte für STATA + Labeldefinition
recode W04 (97=.b) (98=.c)
label define W04 .b `"verweigert"' .c `"weiß nicht"', add modify
label value W04 W04

recode W04_DZW (599=.a)(699=.a)(799=.a) (999=.a) (997=.b) (998=.c) (3307=.z)
label define W04_DZW .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .z `"kein Einkaufs-,Freizeit-,Erledigungsweg"', add modify
label value W04_DZW W04_DZW

recode HWZWECK (99=.a)
label define HWZWECK .a `"keine Angabe"', add modify
label value HWZWECK HWZWECK

recode W01 (9=.a) (8=.c) (7=.b) (301=.z) (302=.y) (303=.x)
label define W01 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .z `"bei rbw nicht erhoben"' .y `"ab 2. Weg nicht erhoben"' .x `"1.Weg ist Rückweg"', add modify
label value W01 W01

recode W13 (9=.a) (8=.c) (7=.b) (301=.z) (304=.w) (305=.v)
label define W13 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .z `"bei rbw nicht erhoben"' .w `"bei Rückweg erhoben"' .v `"bei Zweck KiGa/Kita nicht erhoben"', add modify
label value W13 W13

recode W044 (9=.a) (8=.c) (7=.b) (301=.z) (306=.u) (307=.t)
label define W044 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .z `"bei rbw nicht erhoben"' .u `"kein Detailzweck angegeben"' .t `"kein Einkaufs-, Freizeit-, Erledigungsweg"', add modify
label value W044 W044

* Mitfahrer und Fahrer sind schon als fehlende Werte in STATA markiert mit .a oder .b

* label define fahrer 0 `"nicht genannt"' 1 `"genannt"' .z `"bei rbw Fahrer/Mitfahrer nicht erhoben"' .r `"Weg ohne Verkehrsmittel"', add modify
* foreach x in "MRAD_F""MRAD_MF""PKW_F""PKW_MF" "LKW_F" "LKW_MF"{
* recode `x' (301=.z) (501=.r)
* label value `x' fahrer
* }

foreach x in "HVM""HVM_OEV" "HVM_DIFF"{
recode `x' (97=.a)
label define `x' .a `"keine Angabe"', add modify
label value `x' `x'
}


* räumliche Zuordnung war schon okay :)
* foreach x in "bikgk10" "gtyp" "ktyp" "ktyp_zsg" "polgk" "rtyp" "rtypd7" {
* recode `x' (99=.d)
* label define `x' .d `"nicht vorhanden"', add modify
* }

* Label nicht normaler Tag schon auf fehlender Wert .a

foreach x in "S01" "S03" "S04"{
label define `x' .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value `x' `x'
}

recode W061 (7=.b) (8=.c) (9=.a)
label define W061 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value W061 W061

recode W063 (8=.c)
label define W063 .a `"keine Angabe"' .c `"weiß nicht"', add modify
label value W063 W063

recode ANZPERS (94=.d) (97=.b) (98=.c) (301=.z)
label define ANZPERS .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .z `"bei rbw nicht erhoben"' .d `"unplausibler Wert"', add modify
label value ANZPERS ANZPERS

recode W071 (7=.b) (8=.c) (9=.a)
recode W073 (98=.c)
label define W071 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label define W073 .a `"keine Angabe"' .c `"weiß nicht"', add modify
label value W071 W071
label value W073 W073

recode HHEINK (97=.b) (98=.c) (99=.a)
label define HHEINK .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value HHEINK HHEINK

recode OEK_STAT (9=.e)
label define OEK_STAT .e `"nicht zuzuordnen"', add modify
label value OEK_STAT OEK_STAT

recode HP_BESCH (99=.a)
label define HP_BESCH .a `"keine Angabe"', add modify
label value HP_BESCH HP_BESCH

recode HP_PKWFS (7=.b) (8=.c) (9=.a)
label define HP_PKWFS .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value HP_PKWFS HP_PKWFS

recode PERGRUP* (95=.e)
label define PERGRUP .e `"nicht zuzuordnen"', add modify
label define PERGRUP1 .e `"nicht zuzuordnen"', add modify
label value PERGRUP PERGRUP
label value PERGRUP1 PERGRUP1

recode P070 (97=.b) (98=.c) (96=.s)
label define P070 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"' .s `"fahre nie mit ÖV"', add modify
label value P070 P070

recode GESEIN (3=.c)
label define GESEIN .c `"weiß nicht/verweigert"', add modify
label value GESEIN GESEIN

recode OV_SEG (95=.e)
label define OV_SEG .e `"nicht zubestimmen"', add modify
label value OV_SEG OV_SEG

recode HVM (9=.a)
label define HVM .a `"keine Angabe"', add modify
label value HVM HVM

save "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod.dta", replace




use "O:\MiD-H\MIR-2011\stata\Haushalt_Raumkategorien.dta", clear

* Gemeindekategorie 1 + 2
gen GK2 = POLGK
label value GK2 POLGK
gen GK1 = 1 if POLGK>5
replace GK1 = 2 if POLGK<5
label define GK1 1 `"F/OF"' 2 `"RV ohne F/OF"', modify
label value GK1 GK1
label var GK1 "Gebietskategorie 1"
label var GK2 "Gebietskategorie 2"

recode P?NR (0=.)
recode HP_SEX3 (7=.b)
recode HP_SEX4 (7=.b)
label define HP_SEX3 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label define HP_SEX4 .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value HP_SEX3 HP_SEX3
label value HP_SEX4 HP_SEX4


recode HP_PKWFS(7=.b) (8=.c) (9=.a)
label define HP_PKWFS .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value HP_PKWFS HP_PKWFS

recode V32_A(7=.b) (8=.c) (9=.a)
label define V32_A .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value V32_A V32_A

recode V35_A(7=.b) (8=.c) (9=.a)
label define V35_A .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value V35_A V35_A


recode V64_A(7=.b) (8=.c) (9=.a)
label define V64_A .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value V64_A V64_A

recode HP_BESCH (99=.a) (98=.c) (97=.b)
label define HP_BESCH  .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value HP_BESCH  HP_BESCH 

recode V56_A (99=.a) (98=.c) (97=.b)
label define V56_A  .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value V56_A  V56_A 

recode HHEINK (97=.b) (98=.c) (99=.a)
label define HHEINK .a `"keine Angabe"' .b `"verweigert"' .c `"weiß nicht"', add modify
label value HHEINK HHEINK

recode OEK_STAT (9=.e)
label define OEK_STAT .e `"nicht zuzuordnen"', add modify
label value OEK_STAT OEK_STAT

**Anzahl Personen im Haushalt***
recode H01 (1=0 "Lebe allein") (2=1 "Lebe mit Partner, Kindern oder Personen") (3=.a "Wohnheim") (7=.b "verweigert"), gen(HHTyp1)


save "O:\MiD-H\MIR-2011\stata\Haushalt_Raumkategorien_cod.dta", replace








