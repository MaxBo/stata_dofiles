clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Personen_2.dta", clear

drop p034 p18 p17s wegtempo switcher h04_6 palter psex kinfo fragebog gemnr

rename h02 H02
rename h05 H05
rename hheink HHEINK
rename ov_seg OV_SEG
rename pergrup PERGRUP
rename pergrup1 PERGRUP1
rename h04_3 H04_3
rename p01 P01_1
rename p02 P02
rename	p033	P033
rename	p031	P031
rename	p032	P032
rename	p051	P051
rename	p052	P052
rename	p053	P053
rename	p054	P054
rename hhgr06 HHGR06
rename hhgr14 HHGR14
rename hhgr18 HHGR18
rename   bbrgrt  RTYP
rename  bbrdifft  RTYPD7
rename p13 HP_ALTER
rename p11 HP_SEX
rename  bbrkrst  KTYP
rename p08 P08
rename  bikstyp   GTYP
forvalues i=1/8{
  rename s02_`i' S02_`i'
}
rename rbw0 RBW0

forvalues i=1/5{
  rename rbw0`i' RBW0`i'
}
rename RBW01 RBW1

forvalues i=1/3{
  rename  weganz_`i'  WEGE`i'
}
rename s01 S01
forvalues i=3/5{
 rename s0`i' S0`i'
}

rename kminsgk ANKM 
rename wegdauer ANZMIN
rename gew_pa P_GEW
rename mobil MOBIL
rename bland BLAND
rename polgk POLGK
rename p07 P070
rename p07n P070_A
rename p06 P06
rename p14 P14A
rename wtag STICHTAG
rename jahr STICH_J
rename westost WESTOST
rename  hvvteil  KRS_HVV
rename  bikgk10 BIKGK10
rename p16 P16
rename p17 P17

bysort HHID PID: gen HP_BESCH =  1 if P16==1
bysort HHID PID: replace HP_BESCH =  2 if P16==2
bysort HHID PID: replace HP_BESCH =  3 if P16==3
bysort HHID PID: replace HP_BESCH =  4 if P16==4
bysort HHID PID: replace HP_BESCH =  5 if P17<4
bysort HHID PID: replace HP_BESCH =  6 if P17==4
bysort HHID PID: replace HP_BESCH =  9 if P17==5
bysort HHID PID: replace HP_BESCH =  10 if P17==6
bysort HHID PID: replace HP_BESCH =  11 if P17==7
bysort HHID PID: replace HP_BESCH =  12 if P17==8
bysort HHID PID: replace HP_BESCH =  13 if P17==9
bysort HHID PID: replace HP_BESCH =  14 if P17==10
bysort HHID PID: replace HP_BESCH =  .a if missing(HP_BESCH)

* rename p17 p17alt 
gen HP_TAET = P17
recode HP_TAET (2=3) (3=3) (4=5) (5=6) (6=7) (7=8) (8=9) (9=10) (10=11)

gen HP_PKWFS=P06

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Personen_3.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Personen_angep.dta", clear
append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Personen_3.dta"
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen.dta", replace


