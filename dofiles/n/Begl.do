clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_6.dta", clear

drop W05_6 W05_21
rename  LEBENSP  LEBENSPH
rename WEGDAUER  WEGMIN_K
rename  BBRGRT  RTYP
rename  BBRDIFFT  RTYPD7
rename W05 HVM_DIFF
rename  BBRKRST  KTYP


