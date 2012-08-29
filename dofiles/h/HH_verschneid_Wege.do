clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH.dta", clear

replace P1NR=1 if missing(P1NR)

forvalues i=2/8{ 
replace P`i'NR=`i' if H02>`i'-1 & missing(P`i'NR)
replace P`i'NR=0 if H02<=`i'-1 & missing(P`i'NR)
}


reshape long HPALTER HP_SEX HPBESCH HPPKWFS H021_, i(HHID) j(PNR)

rename PNR PID
sort HHID PID


merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_wegattr2.dta", sort uniqmaster keep(HPP_BESCH  BerufVoll BerufTeil soNErwerb Student Azubi OSchüler GSchüler Kleinkind Rentner NErwerb arbeitszeit)
duplicates drop
* merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen.dta", sort uniqmaster keep(HPP_BESCH  HHEINK OEK_STAT) _merge(_merge2)

* duplicates drop

* bysort HHID PID: drop if PID>H02


rename PID PNR
drop _merge 
reshape wide HP_SEX HPALTER HPBESCH HPP_BESCH HPPKWFS H021_ BerufVoll BerufTeil soNErwerb Student Azubi OSchüler GSchüler Kleinkind Rentner NErwerb arbeitszeit, i(HHID) j(PNR)


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_attr.dta", replace
* replace PID=1 if _merge==1


* reshape wide HP_SEX HP_ALTER HP_BESCH  BerufVoll BerufTeil soNErwerb Student Azubi OSchüler GSchüler Kleinkind Rentner NErwerb, i(HHID) j(PNR)

