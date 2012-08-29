clear 
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_3.dta", clear
keep HHID PID HPP_BESCH HP_ALTER
replace HPP_BESCH= 7 if HP_ALTER<=1 & missing(HPP_BESCH)
sort HHID PID
bysort HHID: gen Anz_Person_HH = PID[_N]
reshape wide HPP_BESCH HP_ALTER,i(HHID) j(PID)

egen HHErw_zu_Haus=anycount(HPP_BESCH?),values(11 10 9)
label var HHErw_zu_Haus "1 Erwachsener zur Betreuung der Kinder daheim"

forvalues i=1/8 {
replace HPP_BESCH`i'= 7 if HP_ALTER`i'<6 & HHErw_zu_Haus>0 & (missing(HPP_BESCH`i')| HPP_BESCH`i'==14)
replace HPP_BESCH`i'=8 if HP_ALTER`i'<6 & HHErw_zu_Haus==0 & (missing(HPP_BESCH`i')| HPP_BESCH`i'==14)
replace HPP_BESCH`i'=5 if HP_ALTER`i'>5 & HP_ALTER`i'<19 & (missing(HPP_BESCH`i')| HPP_BESCH`i'==14)
}

reshape long HPP_BESCH HP_ALTER,i(HHID) j(PID)

replace HPP_BESCH=14 if missing(HPP_BESCH)
replace HPP_BESCH=12 if HP_ALTER>62 & HP_ALTER<130
gen HPP_BESCH_ang = HPP_BESCH
label var HPP_BESCH_ang "Beschäftigung ohne fehlende Werte"
label value HPP_BESCH_ang HPP_BESCH

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\Anpassung_missing_Besch.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_3.dta", clear
merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\Anpassung_missing_Besch.dta", sort unique keep(HPP_BESCH_ang Anz_Person_HH)
drop _merge

drop if PID>Anz_Person_HH & HPP_BESCH_ang==14



