clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", clear

sort HHID PID WSIDN

bysort HHID PID: gen home = 0
bysort HHID PID: replace home =1 if Zweck == "Wohnen" | (_n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101)))
label var home "heimbasierte Aktivität"

label define home 1 "heimbasiert"
label define home 0 "nicht heimbasiert"

label value home home

bysort HHID PID: gen ha = 0
bysort HHID PID: replace ha =1 if Zweck == "Wohnen" | (_n==1 & (W01 == 1  | (WSOURCE == 1 & WSIDN ==101)))
bysort HHID PID: replace ha =2 if Zweck == "Arbeit"

 