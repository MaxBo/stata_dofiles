clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_11_schätz.dta", clear




forvalues i=1/10 {
quietly gen ank_zufall_`i' = rnormal(t,stdf) if f32<=240 & werktag==1 & vm_diff_6==0 
}
gen su_ank_zu = ank_zufall_1
* quietly egen mean_ank_zu = mean(ank_zufall)

forvalues i=2/10 {
quietly replace su_ank_zu = ank_zufall_`i' + su_ank_zu
}

gen ank_zu_mw = su_ank_zu/3
