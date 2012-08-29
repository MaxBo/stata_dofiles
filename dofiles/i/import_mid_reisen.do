set more off

usespss using "X:\Daten\KiD_MiD_ internerGebrauch\MiD 2002 - public user file\spss\mid2002_basis_personends.sav", clear

* Anpassung der Variablennamen MiD 2002 zur MiD 2008
rename CASEID hhid
rename PID pid
rename P01 p01
rename P02 p02
rename P021 p021
rename P022 p022
rename P033 p033
rename P031 p031
rename P032 p032
rename P034 p034
rename P051 p051
rename P052 p052
rename P053 p053
rename P054 p054
rename P041 p041
rename P042 p042
rename P07 p07
rename P10AS p10as
rename P10 p10
rename P101_1 p101_1
rename P101_2 p101_2
rename P101_3 p101_3
rename P101_4 p101_4
rename P102_1 p1013_1
rename P102_2 p1013_2
rename P102_3 p1013_3
rename P102_4 p1013_4
rename P102_5 p1013_5
rename P102_6 p1013_7
rename P11 hp_sex
rename P12_1 p12_1
rename P12_2 p12_2
rename P12_3 p12_3
rename P12_4 p12_4
rename P12_5 p12_5
rename P13 hp_alter
rename P06 hp_pkwfs
rename P061_1 p061_1
rename P061_2 p061_2
rename P061_3 p061_3
rename P061_4 p061_4
rename P061_1J p061_1j
rename P061_2J p061_2j
rename P061_3J p061_3j
rename P061_4J p061_4j
rename P14 p14
rename P15 p15
rename P16 p16
rename P17 p17
rename P18 p18
rename P17S p17s
rename P18S p18s
rename P09_1 p09_1
rename P09_2 p09_2
rename P09_3 p09_3
rename P09_4 p09_4
rename P09 p09
rename P08 p08
rename S03 s03
rename S04 s04
rename S05 s05
rename S01 s01
rename S02_1 s02_1
rename S02_2 s02_2
rename S02_3 s02_3
rename S02_4 s02_4
rename S02_5 s02_5
rename S02_6 s02_6
rename S02_7 s02_7
rename S02_8 s02_8
rename WV0 wv0
rename WV01 wv01
rename WV02 wv02
rename WV03 wv03
rename WV04 wv04
rename WV05 wv05
rename W12 w12
rename WEGANZ_1 weganz_1
rename WEGANZ_2 weganz_2
rename WEGANZ_3 weganz_3
rename H02 h02
rename H05 h05
rename HHEINK hheink
rename LEBENSP lebensp
rename OV_SEG ov_seg
rename PERGRUP pergrup
rename PERGRUP1 pergrup1
rename CASEINFO caseinfo
rename PROXY proxy
rename PERSINFO persinfo
rename VOLL_HH voll_hh
rename BLAND bland
rename WESTOST westost
rename GGKPOL polgk
rename GGKBIK ggkbik
rename BBR_REG rtyp
rename BBR_DREG rtypd7
rename BBRKRTYP bbrkrtyp
rename WTAG wtag
rename WEGDAUER wegdauer
rename H04_3 h04_3
rename H04_6 h04_6
rename HHGR06 hhgr06
rename HHGR14 hhgr14
rename HHGR18 hhgr18
rename WEGTEMPO wegtempo
rename KMINSGK kminsgk
rename GEW_PB gew_pb
rename STICHTAG stichtag
rename PALTER palter
rename PSEX psex
rename KINFO kinfo
rename MOBIL mobil
rename GEMNR gemnr
rename FRAGEBOG fragebog




save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD-Reisen\MiD_2002_Personen.dta", replace


usespss using "X:\Daten\KiD_MiD_ internerGebrauch\MiD2008\Daten\SPSS\SPSS_Public Use File\MiD2008_PUF_Reisen.sav", clear

foreach x in "p101" "hheink" "hp_besch" {
	recode `x' (97=.b) (98=.c) (99=.a)
	label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value `x' `x'
}

foreach x in "p1012" "hvm_r" "hp_sex" "hp_pkwfs"{
	recode `x' (7=.b) (8=.c) (9=.a)
	label define `x' .a `"keine Angabe"'  .b  `"verweigert"' .c  `"weiﬂ nicht"', add modify
	label value `x' `x'	
}

foreach x in "oek_stat" "pergrup" "pergrup1" {
	recode `x' (95=.e)
	label define `x' .e "nicht zuzuordnen", add modify
	label value `x' `x'
}

recode gesein (3=.b)
label define gesein  .b "verweigert, weiﬂ nicht", add modify
label value gesein gesein

recode p1016 (0.1/300 = 1 "Nachbereich <300") (300.1/600 = 2 "Mittelstrecke nah (300;600]") (600.1/900 = 3 "Mittelstrecke fern (600;900]") (900.1/1200 = 4 "Fernstrecke nah (900;1200]") (900.1/300000 = 5 "Fernstrecke nah (1200;1500]") (1200.1/300000 = 6 "Fernstrecke >1500"), gen(rdist_6) 
recode p1016 (0.1/400 = 1 "nah <400") (400.1/800 = 2 "mittel (400;800]") (800.1/1200 = 3 "mittel/fern (800;1200]") (1200.1/300000 = 3 "fern >1200"), gen(rdist_3)

gen intermodal = p1013_1 + p1013_2 + p1013_3 + p1013_4 + p1013_5 + p1013_6 + p1013_7
gen park_ride = p1013_1==1 & p1013_2==1 & intermodal==2

gen rvmzu_flug = 1 if intermodal==2 & p1013_1==1 & p1013_4==1
replace rvmzu_flug = 2 if (intermodal==2 | intermodal==3) & (p1013_2==1 | p1013_3==1) & p1013_4==1
replace rvmzu_flug = 4 if intermodal==2 & (p1013_5==1 | p1013_6==1 | p1013_7==1) & p1013_4==1
replace rvmzu_flug = 5 if intermodal>2 & p1013_1==1 & (p1013_2==1 | p1013_3==1) & p1013_4==1
replace rvmzu_flug = 6 if intermodal>2 & p1013_1==1 & (p1013_7==1 | p1013_6==1 | p1013_5==1) & p1013_4==1
replace rvmzu_flug = 7 if intermodal>2 & (p1013_2==1 | p1013_2==1) & (p1013_7==1 | p1013_6==1 | p1013_5==1) & p1013_4==1
replace rvmzu_flug = 4 if intermodal>2 & (p1013_5==1 | p1013_6==1 | p1013_7==1) & p1013_4==1 & missing(rvmzu_flug)
replace rvmzu_flug = .a if missing(rvmzu_flug) & p1013_4==1


label define rvmzu_flug 1 "Pkw" 2 "÷V" 3 "Reisebus" 4 "sonstiges" 5 "Park&Ride"  /*
*/ 6 "Pkw & sonstiges" 7 "÷V & sonstiges" .a "keine Angabe", modify
label value rvmzu_flug rvmzu_flug


recode rvmzu_flug ( 1 6=1 "MIV") ( 2 7= 2 "÷V") ( 5=3 "Park&Ride") ( 4 =4 "sonstige" ), gen(rvmzu_flug_4) 


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD-Reisen\MiD_2008_Personen.dta", replace

