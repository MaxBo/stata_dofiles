clear
set memory 700m
local pathspss "D:\DatenMaxDiss\MiD-Hessen\MiD_2008\SPSS\"
local path "D:\DatenMaxDiss\MiD-Hessen\MiD_2008\STATA\"

* STATA-Import und Speichern der Datei
foreach x in "HH" "Personen" "Wege" {
 usespss using 	"`pathspss'MiD 2008_PUF_`x'_Hessen.sav", saving("`path'MiD_`x'_Hessen.dta")
}

* Gemeindekategorie 1 + 2
gen GK2 = POLGK
label value GK2 POLGK
gen GK1 = 1 if POLGK>5
replace GK1 = 2 if POLGK<6
label define GK1 1 `"F/OF"' 2 `"RV ohne F/OF"', modify
label value GK1 GK1
label var GK1 "Gebietskategorie 1"
label var GK2 "Gebietskategorie 2"

* WEGE
* Umkodierung der Variablen in fehlende Werte für STATA + Labeldefinition
recode W04 (97=.b) (98=.c)
label define W04 .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value W04 W04

recode W04_DZW (599=.a)(699=.a)(799=.a) (999=.a) (997=.b) (998=.c) (3307=.z)
label define W04_DZW .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .z  `"kein Einkaufs-,Freizeit-,Erledigungsweg"', add modify
label value W04_DZW W04_DZW

recode HWZWECK (99=.a)
label define HWZWECK .a `"keine Angabe"', add modify
label value HWZWECK HWZWECK

recode W01 (9=.a) (8=.c) (7=.b) (301=.z) (302=.y) (303=.x)
label define W01 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .z  `"bei rbw nicht erhoben"' .y  `"ab 2. Weg nicht erhoben"' .x  `"1.Weg ist Rückweg"', add modify
label value W01 W01

recode W13 (9=.a) (8=.c) (7=.b) (301=.z) (304=.w) (305=.v)
label define W13 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .z  `"bei rbw nicht erhoben"' .w  `"bei Rückweg erhoben"' .v  `"bei Zweck KiGa/Kita nicht erhoben"', add modify
label value W13 W13

recode W044 (9=.a) (8=.c) (7=.b) (301=.z) (306=.u) (307=.t)
label define W044 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .z  `"bei rbw nicht erhoben"' .u  `"kein Detailzweck angegeben"' .t  `"kein Einkaufs-, Freizeit-, Erledigungsweg"', add modify
label value W044 W044


* Mitfahrer und Fahrer sind schon als fehlende Werte in STATA markiert mit .a oder .b

* label define fahrer 0 `"nicht genannt"' 1 `"genannt"' .z  `"bei rbw Fahrer/Mitfahrer nicht erhoben"' .r  `"Weg ohne Verkehrsmittel"', add modify
* foreach x in "MRAD_F""MRAD_MF""PKW_F""PKW_MF" "LKW_F" "LKW_MF"{
* recode `x' (301=.z) (501=.r)
*  label value `x' fahrer
* }

foreach x in "HVM""HVM_OEV" "HVM_DIFF"{
recode `x'  (97=.a)
label define `x'  .a `"keine Angabe"', add modify
label value `x'  `x' 
}

label define jn 0 `"nein"' 1`"ja"'
* Label der Tarifverbünde + IVM-Gebiet  
foreach x in "IVM" "PV" "RMV" "RMV2" "NVV"{
label value `x' jn
}

* räumliche Zuordnung war schon okay :)
* foreach x in "bikgk10"	"gtyp"	"ktyp"	"ktyp_zsg"	"polgk"	"rtyp"	"rtypd7" {
* recode `x' (99=.d)
* label define `x' .d `"nicht vorhanden"', add modify
* }

* Label nicht normaler Tag schon auf fehlender Wert .a

recode S0? (7=.b) (8=.c)
foreach x in "S01" "S03" "S04"{
	label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
	label value `x' `x'
}

recode W061 (7=.b) (8=.c) (9=.a)
label define W061 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value W061 W061

recode W063 (8=.c)
label define W063 .a `"keine Angabe"'  .c  `"weiß nicht"', add modify
label value W063 W063

recode ANZPERS (94=.d) (97=.b) (98=.c) (301=.z)
label define ANZPERS .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .z  `"bei rbw nicht erhoben"' .d  `"unplausibler Wert"', add modify
label value ANZPERS ANZPERS

recode W071 (7=.b) (8=.c) (9=.a)
recode W073 (98=.c)
label define W071 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label define W073 .a `"keine Angabe"'  .c  `"weiß nicht"', add modify
label value W071 W071
label value W073 W073

recode HHEINK (97=.b) (98=.c) (99=.a)
label define HHEINK .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value HHEINK HHEINK

recode OEK_STAT (9=.e)
label define OEK_STAT .e `"nicht zuzuordnen"', add modify
label value OEK_STAT OEK_STAT

recode HP_BESCH (99=.a)
label define HP_BESCH .a `"keine Angabe"', add modify
label value HP_BESCH HP_BESCH

recode HP_PKWFS (7=.b) (8=.c) (9=.a)
label define HP_PKWFS .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value HP_PKWFS HP_PKWFS

recode PERGRUP* (95=.e)
label define PERGRUP .e `"nicht zuzuordnen"', add modify
label define PERGRUP1 .e `"nicht zuzuordnen"', add modify
label value PERGRUP PERGRUP
label value PERGRUP1 PERGRUP1

recode P070 (97=.b) (98=.c) (96=.s)
label define P070 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .s  `"fahre nie mit ÖV"', add modify
label value P070 P070

recode GESEIN (3=.c)
label define GESEIN .c  `"weiß nicht/verweigert"', add modify
label value GESEIN GESEIN

recode OV_SEG (95=.e)
label define OV_SEG .e `"nicht zubestimmen"', add modify
label value OV_SEG OV_SEG

save "`path'MiD_Wege_Hessen_cod.dta", replace

use "`path'MiD_Personen_Hessen.dta", clear

* Gemeindekategorie 1 + 2
gen GK2 = POLGK
label value GK2 POLGK
gen GK1 = 1 if POLGK>5
replace GK1 = 2 if POLGK<5
label define GK1 1 `"F/OF"' 2 `"RV ohne F/OF"', modify
label value GK1 GK1
label var GK1 "Gebietskategorie 1"
label var GK2 "Gebietskategorie 2"


foreach x in  "P08" "HP_PKWFS" "P01_1" "P02" "P033" "P031" "P032" "P034" "HP_BERUF" "P0411_3" "P0411_4" "P0412_1"  "P0412_2" "P0412_3" "P0412_4" "P0413_1" "P0413_2" "P0413_3" "P0413_4" "P0414_1" "P0414_2" "P0414_3" "P0414_4" "P06"{
recode `x' (7=.b) (8=.c) (9=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value `x' `x'
}
label value P041?_? P0414_1

foreach x in "HHEINK" "P052" "P054" "HP_TAET" "HP_BESCH" "P14A" "P14B" "P14_1"  "P16_1"  {
recode `x' (97=.b) (98=.c) (99=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value `x' `x'
}


foreach x in HP_ALTER P10 {
recode `x' (997=.b) (998=.c) (999=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value `x' `x'
}

recode P070 (97=.b) (98=.c) (96=.s)
label define P070 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .s  `"fahre nie mit ÖV"', add modify
label value P070 P070

recode P070_A (97=.b) (98=.c) (96=.s)
label define P070_A .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .s  `"fahre nie mit ÖV"', add modify
label value P070_A P070_A

foreach x in "P061_1J" {
recode `x' (9997=.b) (9998=.c) (9999=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value `x' `x'
}

recode GESEIN (3=.c)
label define GESEIN .c  `"weiß nicht/verweigert"', add modify
label value GESEIN GESEIN

recode P092 (8=.c) (102=.r) (801=.q)
label define P092 .q `"Person ohne körperliche Einschränkung"'  .r  `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"' .c  `"weiß nicht"', add modify
label value P092 P092

recode S0? (7=.b) (8=.c)
foreach x in "S01" "S03" "S04"{
	label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
	label value `x' `x'
}

label define jn 0 `"nein"' 1`"ja"'
* Label der Tarifverbünde + IVM-Gebiet  
foreach x in "IVM" "PV" "RMV" "RMV2" "NVV"{
label value `x' jn
}

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
foreach x in "HP_PKWFS" "P02"  "P06" "P092"{
recode `x' (2=0)
label define `x' 1 `"ja"' 0  `"nein"', modify add
label value `x' jn
}

save "`path'MiD_Personen_Hessen_cod.dta", replace

use "`path'MiD_HH_Hessen.dta", clear

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
label define HP_SEX3 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label define HP_SEX4 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value HP_SEX3 HP_SEX3
label value HP_SEX4 HP_SEX4

forvalue i=1/8 {
	recode HPPKWFS`i' (7=.b) (8=.c) (9=.a)
	label define HPPKWFS`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
	label value HPPKWFS`i' HPPKWFS`i'

	recode HPBESCH`i' (99=.a)
	label define HPBESCH`i' .a `"keine Angabe"', add modify
	label value HPBESCH`i' HPBESCH`i'
	
	recode H021_`i' (7=.b) (8=.c) (9=.a)
	label define H021_`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
	label value H021_`i' H021_`i'
	
	recode H022_`i' (7=.b) (8=.c) (9=.a)
	label define H022_`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
	label value H022_`i' H022_`i'

	recode H023_`i' (97=.b) (98=.c) (99=.a) (96=.p)
	label define H022_`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"' .p `"unzulässige Mehrfachnennung"', add modify
	label value H022_`i' H022_`i'
}

recode HHEINK (97=.b) (98=.c) (99=.a)
label define HHEINK .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiß nicht"', add modify
label value HHEINK HHEINK

recode OEK_STAT (9=.e)
label define OEK_STAT .e `"nicht zuzuordnen"', add modify
label value OEK_STAT OEK_STAT

save "`path'MiD_HH_Hessen_cod.dta", replace
