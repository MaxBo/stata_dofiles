clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_6.dta", clear

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

label variable HP_BESCH "Tätigkeit"