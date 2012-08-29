drop t_* l_* anz_w_*
foreach x in  "arbeit" "bilden" "eink_ap" "freizeit" "kindergarten"{

* qui bysort hhid pid: egen anz_w_`x' = sum(`x')
* qui gen t_`x'=`x'*fahrzeit if fahrzeit>0
* qui gen l_`x'=`x'*wegkm_k 
* tabstat t_`x' l_`x'   if `x'==1 & werktag==1 , by(hp_besch)
* tabstat anz_w_`x'  if wsid==1 & werktag==1 , by(hp_besch)
tabstat t_`x' l_`x'   if `x'==1 & werktag==1 , by( hp_altg1)
tabstat anz_w_`x'  if wsid==1 & werktag==1 , by( hp_altg1)

}

