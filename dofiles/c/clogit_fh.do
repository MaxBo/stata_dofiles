clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge_red.dta", clear

label define hvm_c2a 1`"mivk"', modify
label define hvm_c2a 2`"mivl"', modify
label define hvm_c2a 3`"oepnv"', modify
label define hvm_c2a 5`"nmiv"', modify
label define hvm_c2a 7`"pr"', modify
label define hvm_c2a 8`"taxi"', modify

label value hvm_neu_t hvm_c2a

* rename t_miv tmiv
* rename t_oev toev
* rename t_miv_l tmiv_l

forval i = 1/6 {
rename u_halt_`i' uhalt_`i'
}
rename u_bahn ubahn

label define hvm_c2b 1`"miv"', modify
label define hvm_c2b 2`"oepnv"', modify
label define hvm_c2b 3`"nmiv"', modify
label value hvm_aggr hvm_c2b

* replace c_1=c_1+cp_1
replace c_2=c_2+cp_2 if c_2<.|cp_2<.
* replace t_8=t_1+10

quietly case2alt, choice(hvm_neu_t) case(lfd_jahr) altnum(vm_aggr) alt(t_ uh_ c_ cp_) casevars(s_bahnanschluss  tz_1 jz_1 f13 f31 reise_allein hrg3_1 ziel_1 f61 ca_wohn_diff_1 herkunft_2 alter alter2 geschlecht l_miv)
label value vm_aggr hvm_neu 


foreach  x in "1" "2" "3" "5" "7" "8" {
	foreach i in "t_" "uh_" "c_" "cp_"{
		quietly gen `i'`x'=`i'
		}
}
	
foreach  x in "1" "2" "3" "5" "7" "8" {
	foreach i in "t_" "uh_" "c_" "cp_"{
		foreach y in "mivk" "mivl" "oepnv" "nmiv" "pr" "taxi" {
			quietly replace `i'`x'=0 if `y'==0 & vm_aggr!=`x'
		}
	}
}



* gen season_ticket = oepnv*f61 | oepnv*f61
* gen s_bahnan = oepnv*s_bahnanschlus 

* gen luggage = f31*miv

* gen alone = oepnv*reise_allein
* gen early = oepnv*tz_1
* gen business = miv*hrg3_1
* gen inner_german = miv*ziel_1

drop t_ uh_ c_ cp_ t_miv_hilf
* gen einschränkung = l_miv<2.5
* Conditional Logitmodel
* clogit choice t_* uh_* c_* cp_* oepnvXs_bahnanschluss oepnvXtz_1 oepnvXjz_1  oepnvXreise_allein oepnvXhrg3_1  oepnvXf61 oepnvXca_wohn_diff_1 oepnvXherkunft_2 oepnvXalter oepnvXalter2  mivkXhrg3_1 mivkXziel_1  mivkXca_wohn_diff_1 mivkXherkunft_2 mivkXalter mivkXalter    mivlXjz_1 mivlXf13  mivlXhrg3_1 mivlXf61 mivlXherkunft_2   mivlXgeschlecht   prXtz_1  prXca_wohn_diff_1 prXherkunft_2 prXgeschlecht     if Stunde<25, group(lfd_jahr)
* clogit choice t_* uh_3 uh_7 c_* cp_1 cp_2 oepnvXs_bahnanschluss oepnvXtz_1 oepnvXjz_1  oepnvXreise_allein  oepnvXf61 oepnvXca_wohn_diff_1 oepnvXherkunft_2 mivkXhrg3_1 mivkXziel_1   mivkXherkunft_2 mivkXalter mivkXalter2  mivlXjz_1  mivlXhrg3_1 mivlXf61 mivlXherkunft_2     mivlXgeschlecht   prXf31  prXalter prXalter2  prXca_wohn_diff_1 if Stunde<25, group(lfd_jahr) level(99)

* clogit choice t_*  uh_3 uh_7 c_* cp_1 cp_2 oepnvXs_bahnanschluss oepnvXtz_1 oepnvXjz_1 oepnvXf61 oepnvXca_wohn_diff_1 oepnvXherkunft_2 mivkXhrg3_1 mivkXziel_1   mivkXherkunft_2 mivkXalter mivkXalter2  mivlXjz_1  mivlXhrg3_1 mivlXf61 mivlXherkunft_2     mivlXgeschlecht    prXf31  prXalter prXalter2  prXca_wohn_diff_1  if Stunde<25, group(lfd_jahr)
* clogit choice t_*  uh_3 uh_7 c_*  oepnvXs_bahnanschluss oepnvXtz_1 oepnvXjz_1 oepnvXreise_allein   oepnvXhrg3_1 oepnvXf61 oepnvXca_wohn_diff_1 oepnvXherkunft_2 oepnvXalter oepnvXalter2  mivkXhrg3_1 mivkXziel_1   mivkXalter mivkXalter2  mivlXjz_1  mivlXf61 mivlXherkunft_2  mivlXgeschlecht  prXalter prXalter2  prXca_wohn_diff_1 mivk mivl oepnv nmiv pr taxi if Stunde<25, group(lfd_jahr)
clogit choice t_*  uh_3 uh_7 c_*  oepnvXs_bahnanschluss oepnvXtz_1 oepnvXjz_1    oepnvXhrg3_1 oepnvXf61 oepnvXca_wohn_diff_1 oepnvXherkunft_2 oepnvXalter oepnvXalter2  mivkXhrg3_1 mivkXziel_1   mivkXalter mivkXalter2  mivlXjz_1  mivlXf61 mivlXherkunft_2  prXf61 prXf31   mivlXgeschlecht prXs_bahnanschluss prXf61 prXalter prXalter2  prXca_wohn_diff_1   taxiXtz_1 taxiXreise_allein taxiXhrg3_1 taxiXziel_1 taxiXca_wohn_diff_1 taxiXherkunft_2 taxiXalter taxiXalter2   mivk mivl oepnv nmiv pr taxi if Stunde<25, group(lfd_jahr)

predict prob_vm
* Schätzung als DUM (deterministic utility model)

bysort lfd_jahr: egen max_prob=max(prob_vm)
gen vm_schätz= max_prob==prob_vm

* Schätzung als RUM (random utility maximisation)


gen cum=0
bysort lfd_jahr: replace cum=prob_vm if _n==1
bysort lfd_jahr: replace cum=cum[_n-1]+prob_vm[_n] if _n>1
bysort lfd_jahr: gen rum = runiform() if _n==1
bysort lfd_jahr: replace rum = rum[1]
bysort lfd_jahr: gen rumchoice = (rum<= cum)
bysort lfd_jahr: gen rumchoice1 =  rumchoice
bysort lfd_jahr:  replace rumchoice1 = 0 if rumchoice==1 & rumchoice[_n-1]==1

* drop rum rumchoice



