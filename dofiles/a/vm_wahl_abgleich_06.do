clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_6.dta", clear

gen MRAD_F = 1 if  W05_3 ==1 & W05_4==1
replace MRAD_F = 0 if  W05_3 ==1 & W05_4==0
replace MRAD_F = .b if  W05_3 !=1
gen MRAD_MF = 1 if  W05_3 ==1 & W05_21==1
replace MRAD_MF = 0 if  W05_3 ==1 & W05_21==0
replace MRAD_MF = .b if  W05_3 !=1

gen PKW_MF = 1 if  W05_5 ==1
replace PKW_MF = 0 if  W05_5 ==0
replace PKW_MF = .b if  W05_5>1|W05_6>1
gen PKW_F = 1 if  W05_6 ==1
replace PKW_F = 0 if  W05_6 ==0
replace PKW_F = .b if  W05_5>1|W05_6>1

replace W05_5=1 if PKW_MF==1|PKW_F==1
replace W05_5=0 if PKW_MF==0 & PKW_F==0
replace W05_5=.b if PKW_F>1

gen LKW_MF = 1 if  W05_7 ==1 | W05_9 ==1
replace LKW_MF = 0 if  W05_7 ==0 | W05_9 ==0
replace LKW_MF = .b if  W05_7>1|W05_8>1|W05_9>1|W05_10>1
gen LKW_F = 1 if  W05_8 ==1 | W05_10 ==1
replace LKW_F = 0 if  W05_8 ==0 | W05_10 ==0
replace LKW_F = .b if  W05_7>1|W05_8>1|W05_9>1|W05_10>1

rename W05_7 W05_24

gen W05_7=1 if LKW_MF==1|LKW_F==1
replace W05_7=0 if LKW_MF==0 & LKW_F==0
replace W05_7=0 if LKW_MF>1 & LKW_F>1

rename P13 HP_ALTER
rename P11 HP_SEX
rename WEGTEMPK TEMPO
rename  HVVTEIL KRS_HVV
rename W03 ST_TIME
rename W09 EN_TIME
rename STICHTAG  STICHTAG2
rename WTAG  STICHTAG
rename JAHR  STICH_J
rename GEW_PA W_GEW
rename W0721 W072_1
rename W0722 W072_2
rename W0723 W072_3
rename W0724 W072_4
rename W0725 W072_5
rename W0726 W072_6
rename W0727 W072_7
rename W0728 W072_8
rename W0729 W072_9

