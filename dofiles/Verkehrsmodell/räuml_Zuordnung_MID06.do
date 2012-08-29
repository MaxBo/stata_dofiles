set more off
local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\"

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_6.dta",clear 
rename KRS_HVV krs_hvv
rename POLGK polgk
rename RTYPD7 rtypd7
rename RTYP rtyp
rename KTYP ktyp
* rename  ktyp_zsg
rename BIKGK10 bikgk10
rename BIKSTYP bikstyp
rename STICH_J stich_j
rename HHID hhid
rename PID pid
rename BLAND bland
rename KKZ kkz
rename REGBEZKZ regbezkz
recode krs_hvv (6=8)
replace krs_hvv = krs_hvv+1 if stich_j==2006 & krs_hvv<7
label define krs_hvv 1 "Stadt Hamburg" 2 "Herzogtum Lauenburg" 3 "Pinneberg" 4 "Segeberg" 5 "Storman" 6 "Harburg" 7 "Stade" 8 "Lüneburg", modify
label value krs_hvv krs_hvv  


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_7.dta", replace 

usespss using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_ur\HVV_MiD_2006_2002_Datensätze\SPSS\HVV_MiD_2002_2006_Haushaltsbefragung.sav", clear
drop if JAHR!=2006
save "`path'MiD_2006_HH_ur.dta", replace 

rename HVVTEIL krs_hvv
rename POLGK polgk
rename BBRDIFFT rtypd7
rename BBRGRT rtyp
rename BBRKRST ktyp
* rename  ktyp_zsg
rename BIKGK10 bikgk10
rename BIKSTYP bikstyp
rename JAHR stich_j
rename CASEID hhid
rename BLAND bland
rename KKZ kkz
rename REGBEZKZ regbezkz
* rename CASEID hhid
* rename PID pid

recode krs_hvv (6=8)
replace krs_hvv = krs_hvv+1 if stich_j==2006 & krs_hvv<7
label define krs_hvv 1 "Stadt Hamburg" 2 "Herzogtum Lauenburg" 3 "Pinneberg" 4 "Segeberg" 5 "Storman" 6 "Harburg" 7 "Stade" 8 "Lüneburg", modify
label value krs_hvv krs_hvv  


drop H001C H04?_? H04?_* H04?_? H07 H06_? H07* SWITCHER LOCALTYP LCSTATUS GEMNR
drop H049* H041*

save "`path'MiD_2006_HH_ur2.dta", replace

version 10


use "`path'MiD_2008_2006_Wege_10.dta", clear
merge hhid stich_j using "`path'MiD_2006_HH_ur2.dta", sort keep(bland kkz krs_hvv polgk rtypd7 rtyp ktyp bikgk10 bikstyp ) update replace uniqusing _merge(upd_hhr)

foreach x in "ktyp_zsg" "gtyp" "bikstyp" {
	replace `x'= . if stich_j==2006
 }
* replace krs_hvv = . if stich_j==2006
* replace polgk = . if stich_j==2006
* replace rtyp = . if stich_j ==2006
version 12
* merge m:m hhid pid stich_j using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_7.dta", keepusing(bland kkz krs_hvv polgk rtypd7 rtyp ktyp bikgk10 bikstyp) update    

label define krs_hvv 1 "Stadt Hamburg" 2 "Herzogtum Lauenburg" 3 "Pinneberg" 4 "Segeberg" 5 "Storman" 6 "Harburg" 7 "Stade" 8 "Lüneburg", modify
label value krs_hvv krs_hvv  

save  "`path'MiD_2008_2006_Wege_11.dta", replace

version 10
use "`path'MiD_2008_2006_Personen_6.dta", clear
merge hhid stich_j using "`path'MiD_2006_HH_ur2.dta", sort keep(bland kkz krs_hvv polgk rtypd7 rtyp ktyp bikgk10 bikstyp ) update replace uniqusing _merge(upd_hhr)

foreach x in "ktyp_zsg" "gtyp" "bikstyp" {
	replace `x'= . if stich_j==2006
}

save  "`path'MiD_2008_2006_Personen_7.dta", replace 





