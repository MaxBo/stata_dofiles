***Verkehrsleistung pro Kopf***
**2002***

use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear
bysort caseid pid: egen fuﬂ_fl_ges = total(w08 * (Verkm5 == 1))
bysort caseid pid: egen rad_fl_ges = total(w08 * (Verkm5 == 2))
bysort caseid pid: egen oev_fl_ges = total(w08 * (Verkm5 == 3))
bysort caseid pid: egen mivm_fl_ges = total(w08 * (Verkm5 == 4))
bysort caseid pid: egen mivf_fl_ges = total(w08 * (Verkm5 == 5))
bysort caseid pid: egen sonst_fl_ges = total(w08 * (Verkm5 == -9))
bysort caseid pid: egen fl_ges = total(w08)
keep if weg == 1

save "O:\MiD-H\MiR2002\Stata\fl_ges_neu.dta", replace

use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear


sort caseid pid
recode mobil (2=.c)

save "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", replace

use "O:\MiD-H\MiR2002\Stata\fl_ges_neu.dta", clear

merge caseid pid using "O:\MiD-H\MiR2002\Stata\P_REGION2.dta"

save "O:\MiD-H\MiR2002\Stata\fl_ges_P_neu.dta", replace

use "O:\MiD-H\MiR2002\Stata\fl_ges_P_neu.dta", clear
* ersetze Fahrleistung pro Tag = 0 nur bei den Personen, die nicht mobil am Stichtag waren, nicht bei denen, die aus sonstigen Gr¸nden nichts berichtet haben
replace fl_ges = 0 if fl_ges ==. & mobil==0
replace mivf_fl_ges = 0 if mivf_fl_ges ==. & mobil==0
replace mivm_fl_ges = 0 if mivm_fl_ges ==. & mobil==0
replace oev_fl_ges = 0 if oev_fl_ges ==. & mobil==0
replace rad_fl_ges = 0 if rad_fl_ges ==. & mobil==0
replace fuﬂ_fl_ges = 0 if fuﬂ_fl_ges ==. & mobil==0

tabstat *fl_ges if w08<= 100 & hpzweck != 3, stats(mean n) by(Hann_Umland)
* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if w08<= 100 & hpzweck != 3 [aw=gew_pa], stats(mean n) by(Hann_Umland)
* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=gew_pa]


tabstat *fl_ges if wtag <=5, stats(mean n) by(Hann_Umland)
* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if wtag <= 5 [aw=gew_pa], stats(mean n) by(Hann_Umland)
* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=gew_pa]



tabstat *fl_ges, stats(mean n) by(hheink_aeq4)
tabstat *fl_ges if Hann_Umland == 1 , stats(mean n) by(hheink_aeq4)
tabstat *fl_ges if Hann_Umland == 2 , stats(mean n) by(hheink_aeq4)

* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if w08 <=100 & hpzweck != 3 [aw=gew_pa], stats(mean n) by(hheink_aeq4)
tabstat *fl_ges if Hann_Umland == 1 & w08 <=100 & hpzweck != 3 [aw=gew_pa], stats(mean n) by(hheink_aeq4)
tabstat *fl_ges if Hann_Umland == 2 & w08 <=100 & hpzweck != 3  [aw=gew_pa], stats(mean n) by(hheink_aeq4)
* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=gew_pa]


tabstat *fl_ges if wtag <=5, stats(mean n) by(Hann_Umland)
* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if wtag <= 5 [aw=gew_pa], stats(mean n) by(Hann_Umland)
* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=gew_pa]

***Nach Personengruppe
tabstat fl_ges, stats(mean) by(PERGRUP_AUS)

**Stadt Hannover
tabstat fl_ges if Hann_Umland == 1, stats(mean) by(PERGRUP_AUS)

***Umland
tabstat fl_ges if Hann_Umland == 2, stats(mean) by(PERGRUP_AUS)






***Verkehrsleistung pro Kopf***
**2011***

use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear

bysort HHID PID: egen fuﬂ_fl_ges = total(WEGKM_K * (HVM == 1))
bysort HHID PID: egen rad_fl_ges = total(WEGKM_K * (HVM == 2))
bysort HHID PID: egen oev_fl_ges = total(WEGKM_K * (HVM == 5))
bysort HHID PID: egen mivm_fl_ges = total(WEGKM_K * (HVM == 3))
bysort HHID PID: egen mivf_fl_ges = total(WEGKM_K * (HVM == 4))
bysort HHID PID: egen fl_ges = total(WEGKM_K)
keep if WID == 1

save "O:\MiD-H\MiR-2011\stata\fl_ges_neu.dta", replace

use "O:\MiD-H\MiR-2011\stata\personen_Raumkategorien_cod.dta", clear

sort HHID PID
recode MOBIL (9=.c)

save "O:\MiD-H\MiR-2011\stata\personen_Raumkategorien_cod.dta", replace

use "O:\MiD-H\MiR-2011\stata\fl_ges_neu.dta", clear

merge HHID PID using "O:\MiD-H\MiR-2011\stata\personen_Raumkategorien_cod.dta"

save "O:\MiD-H\MiR-2011\stata\fl_ges_P_neu.dta", replace

use "O:\MiD-H\MiR-2011\stata\fl_ges_P_neu.dta", clear
* ersetze Fahrleistung pro Tag = 0 nur bei den Personen, die nicht mobil am Stichtag waren, nicht bei denen, die aus sonstigen Gr¸nden nichts berichtet haben
replace fl_ges = 0 if fl_ges ==. & MOBIL==0
replace mivf_fl_ges = 0 if mivf_fl_ges ==. & MOBIL==0
replace mivm_fl_ges = 0 if mivm_fl_ges ==. & MOBIL==0
replace oev_fl_ges = 0 if oev_fl_ges ==. & MOBIL==0
replace rad_fl_ges = 0 if rad_fl_ges ==. & MOBIL==0
replace fuﬂ_fl_ges = 0 if fuﬂ_fl_ges ==. & MOBIL==0

tabstat *fl_ges if WEGKM_K <=100 & HWZWECK !=2, stats(mean n) by(Hann_Umland)
* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if WEGKM_K <=100 & HWZWECK !=2 [aw=P_GEW], stats(mean n) by(Hann_Umland)
* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=P_GEW]


tabstat *fl_ges if STICHTAG <=5, stats(mean n) by(Hann_Umland)
* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if STICHTAG <= 5 [aw=P_GEW], stats(mean n) by(Hann_Umland)
* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=P_GEW]



* Mit Gewichtung (irgendwie geht nur aw)
tabstat *fl_ges if WEGKM_K <=100 & HWZWECK !=2 [aw=P_GEW], stats(mean n) by(hheink_aeq4)
tabstat *fl_ges if WEGKM_K <=100 & HWZWECK !=2 & Hann_Umland == 1 [aw=P_GEW], stats(mean n) by(hheink_aeq4)
tabstat *fl_ges if WEGKM_K <=100 & HWZWECK !=2 & Hann_Umland == 2 [aw=P_GEW], stats(mean n) by(hheink_aeq4)

* Alternativ
bysort Hann_Umland: sum *fl_ges [aw=P_GEW]



***Nach Personengruppen
tabstat fl_ges, stats(mean) by(PERGRUP_AUS)

*Stadt Hannover

tabstat fl_ges if Hann_Umland == 1, stats(mean) by(PERGRUP_AUS) 

*Umland

tabstat fl_ges if Hann_Umland == 2, stats(mean) by(PERGRUP_AUS) 



