clear
set memory 700m
local pathspss "X:\Daten\KiD_MiD_ internerGebrauch\MiD2008\Daten\SPSS\SPSS_Public Use File\"
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
set more off
version 10

* STATA-Import und Speichern der Datei
foreach x in "Haushalte" "Personen" "Auto" "Wege"  {
 usespss using 	"`pathspss'MiD2008_PUF_`x'.sav", saving("`path'MiD_`x'.dta")
}


* WEGE
* Umkodierung der Variablen in fehlende Werte f¸r STATA + Labeldefinition
recode w04 (97=.b) (98=.c)
label define w04 .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value w04 w04

recode w04_dzw (599=.a)(699=.a)(799=.a) (999=.a) (997=.b) (998=.c) (3307=.z)
label define w04_dzw .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .z  `"kein Einkaufs-,Freizeit-,Erledigungsweg"', add modify
label value w04_dzw w04_dzw

recode hwzweck (99=.a)
label define hwzweck .a `"keine Angabe"', add modify
label value hwzweck hwzweck

recode w01 (9=.a) (8=.c) (7=.b) (301=.z) (302=.y) (303=.x)
label define w01 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .z  `"bei rbw nicht erhoben"' .y  `"ab 2. Weg nicht erhoben"' .x  `"1.Weg ist R¸ckweg"', add modify
label value w01 w01

recode w13 (9=.a) (8=.c) (7=.b) (301=.z) (304=.w) (305=.v)
label define w13 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .z  `"bei rbw nicht erhoben"' .w  `"bei R¸ckweg erhoben"' .v  `"bei Zweck KiGa/Kita nicht erhoben"', add modify
label value w13 w13

recode w044 (9=.a) (8=.c) (7=.b) (301=.z) (306=.u) (307=.t)
label define w044 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .z  `"bei rbw nicht erhoben"' .u  `"kein Detailzweck angegeben"' .t  `"kein Einkaufs-, Freizeit-, Erledigungsweg"', add modify
label value w044 w044


label define fahrer 0 `"nicht genannt"' 1 `"genannt"' .z  `"bei rbw Fahrer/Mitfahrer nicht erhoben"' .r  `"Weg ohne Verkehrsmittel"', add modify
foreach x in "mrad_f""mrad_mf""pkw_f""pkw_mf" "lkw_f" "lkw_mf"{
recode `x' (301=.z) (501=.r)
label value `x' fahrer
}

foreach x in "hvm""hvm_oev" "hvm_diff"{
recode `x'  (97=.a)
label define `x'  .a `"keine Angabe"', add modify
label value `x'  `x' 
}

label define jn 0 `"nein"' 1`"ja"'

recode hp_sex (9=.a)
label define hp_sex .a `"keine Angabe"', add modify
label value hp_sex hp_sex

recode s0? (7=.b) (8=.c)
foreach x in "s01" "s03" "s04"{
	label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value `x' `x'
}

recode w061 (7=.b) (8=.c) (9=.a)
label define w061 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value w061 w061

recode w063 (8=.c)
label define w063 .a `"keine Angabe"'  .c  `"weiﬂ nicht"', add modify
label value w063 w063

recode anzpers (94=.d) (97=.b) (98=.c) (301=.z)
label define anzpers .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .z  `"bei rbw nicht erhoben"' .d  `"unplausibler Wert"', add modify
label value anzpers anzpers

recode w071 (7=.b) (8=.c) (9=.a)
recode w073 (98=.c)
label define w071 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label define w073 .a `"keine Angabe"'  .c  `"weiﬂ nicht"', add modify
label value w071 w071
label value w073 w073

recode hheink (97=.b) (98=.c) (99=.a)
label define hheink .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value hheink hheink

recode oek_stat (9=.e)
label define oek_stat .e `"nicht zuzuordnen"', add modify
label value oek_stat oek_stat

recode hp_besch (99=.a)
label define hp_besch .a `"keine Angabe"', add modify
label value hp_besch hp_besch

recode hp_pkwfs (7=.b) (8=.c) (9=.a)
label define hp_pkwfs .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value hp_pkwfs hp_pkwfs

recode pergrup* (95=.e)
label define pergrup .e `"nicht zuzuordnen"', add modify
label define pergrup1 .e `"nicht zuzuordnen"', add modify
label value pergrup pergrup
label value pergrup1 pergrup1

recode p070 (97=.b) (98=.c) (96=.s)
label define p070 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .s  `"fahre nie mit ÷V"', add modify
label value p070 p070

recode gesein (3=.c)
label define gesein .c  `"weiﬂ nicht/verweigert"', add modify
label value gesein gesein

recode ov_seg (95=.e)
label define ov_seg .e `"nicht zubestimmen"', add modify
label value ov_seg ov_seg

save "`path'MiD_Wege_cod.dta", replace

use "`path'MiD_Personen.dta", clear



foreach x in  "p08" "hp_pkwfs" "p01_1" "p02" "p033" "p031" "p032" "p034" "hp_beruf" "p0411_3" "p0411_4" "p0412_1"  "p0412_2" "p0412_3" "p0412_4" "p0413_1" "p0413_2" "p0413_3" "p0413_4" "p0414_1" "p0414_2" "p0414_3" "p0414_4" "p06"{
recode `x' (7=.b) (8=.c) (9=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value `x' `x'
}
label value p041?_? p0414_1
label value p032 p031 
label value p034 p031 

foreach x in "hheink" "p052" "p054" "hp_taet" "hp_besch" "p14a" "p14b" "p14_1"  "p16_1"  {
recode `x' (97=.b) (98=.c) (99=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value `x' `x'
}
label values p054 p052

foreach x in hp_alter p10 {
recode `x' (997=.b) (998=.c) (999=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value `x' `x'
}

recode p070 (97=.b) (98=.c) (96=.s)
label define p070 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .s  `"fahre nie mit ÷V"', add modify
label value p070 p070

recode p070_a (97=.b) (98=.c) (96=.s)
label define p070_a .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .s  `"fahre nie mit ÷V"', add modify
label value p070_a p070_a

foreach x in "p061_1j"  "p061_2j"  "p061_3j"  "p061_4j"{
recode `x' (9997=.b) (9998=.c) (9999=.a)
label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value `x' `x'
}

recode gesein (3=.c)
label define gesein .c  `"weiﬂ nicht/verweigert"', add modify
label value gesein gesein

recode p092 (8=.c) (102=.r) (801=.q)
label define p092 .q `"Person ohne kˆrperliche Einschr‰nkung"'  .r  `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"' .c  `"weiﬂ nicht"', add modify
label value p092 p092

recode s0? (7=.b) (8=.c)
foreach x in "s01" "s03" "s04"{
	label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value `x' `x'
}

label define jn 0 `"nein"' 1`"ja"'

recode hp_sex (9=.a)
label define hp_sex .a `"keine Angabe"', add modify
label value hp_sex hp_sex

recode pergrup* (95=.e)
label define pergrup .e `"nicht zuzuordnen"', add modify
label define pergrup1 .e `"nicht zuzuordnen"', add modify
label value pergrup pergrup
label value pergrup1 pergrup1

recode ov_seg (95=.e)
label define ov_seg .e `"nicht zubestimmen"', add modify
label value ov_seg ov_seg

recode oek_stat (9=.e)
label define oek_stat .e `"nicht zuzuordnen"', add modify
label value oek_stat oek_stat

* F¸hrerscheinbesitz
foreach x in "hp_pkwfs" "p02"  "p06" "p092"{
recode `x' (2=0)
label define `x' 1 `"ja"' 0  `"nein"', modify add
label value `x' jn
}

save "`path'MiD_Personen_cod.dta", replace

use "`path'MiD_Haushalte.dta", clear

recode p?nr (0=.)
recode hp_sex3 (7=.b)
recode hp_sex4 (7=.b)
label define hp_sex3 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label define hp_sex4 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value hp_sex3 hp_sex3
label value hp_sex4 hp_sex4

forvalue i=1/8 {
	recode hppkwfs`i' (7=.b) (8=.c) (9=.a)
	label define hppkwfs`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value hppkwfs`i' hppkwfs`i'

	recode hpbesch`i' (99=.a)
	label define hpbesch`i' .a `"keine Angabe"', add modify
	label value hpbesch`i' hpbesch`i'
	
	recode  hp_beru`i' (7=.b) (8=.c) (9=.a)
	label define hp_beru`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value hp_beru`i' hp_beru`i'
	
	recode hp_bkat`i' (7=.b) (8=.c) (9=.a)
	label define hp_bkat`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value hp_bkat`i' hp_bkat`i'

	recode hp_taet`i' (97=.b) (98=.c) (99=.a) (96=.p)
	label define hp_taet`i' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"' .p `"unzul‰ssige Mehrfachnennung"', add modify
	label value hp_taet`i' hp_taet`i'
}

recode hheink (97=.b) (98=.c) (99=.a)
label define hheink .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value hheink hheink

recode oek_stat (9=.e)
label define oek_stat .e `"nicht zuzuordnen"', add modify
label value oek_stat oek_stat

save "`path'MiD_HH_cod.dta", replace

use "`path'MiD_Auto.dta", clear


recode hheink (97=.b) (98=.c) (99=.a)
label define hheink .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
label value hheink hheink

recode oek_stat (9=.e)
label define oek_stat .e `"nicht zuzuordnen"', add modify
label value oek_stat oek_stat

recode h04_3 (98=.c) (99=.a)
label define h04_3  .a `"keine Angabe"'  .c  `"weiﬂ nicht"', add modify

recode besch_hn (99=.a)
label define besch_hn  .a `"keine Angabe"', add modify
 
recode sex_hn (2=0)
label define sex_hn 0 `"weiblich"', add modify

recode h046 (7=.b) (8=.c) (9=.a)
label define h046 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify

recode h041 (97=.b) (98=.c) (99=.a)
label define h041 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify

recode h044 (97=.b) (98=.c) (99=.a)
label define h044 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify

recode h048 (7=.b) (8=.c) (9=.a)
label define h048 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify

recode h0411 (7=.b) (8=.c) (9=.a)
label define h0411 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify

recode h0416 (7=.b) (8=.c) (9=.a)
label define h0416 .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify

recode seg_kba (95=.e)
label define seg_kba  .e `"nicht zuzuordnen"', add modify


gen pid = h044
recode pid (96=.e)
label define pid  .e `"nicht zuzuordnen"', add modify
label value pid pid


save "`path'MiD_Auto_cod.dta", replace
