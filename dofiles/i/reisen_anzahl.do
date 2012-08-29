set more off
local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\"
local path2 "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Reiseanalyse\"

use "`path'screening_pid_red.dta", clear


* nbreg anzdirj i.besch i.bildung_2  ib3.hheink   i.sex  ib2.privatr , nolog
nbreg anzdirj i.besch i.bildung_2  ib3.hheink   i.sex  , nolog
estimates save "`path'anz_dir.ster", replace
predict pr_dir
* nbreg anzpreisej i.besch i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4 i.hh_bt  i.hhtyp alter alter2 i.sex i.pkwbes i.bahncard_jn  if anzpreisej<150, nolog

nbreg anzkurlj i.hhflex i.pflex  i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4   alter alter2 i.sex i.pkwbes i.zweitw  if anzpreisej<150, nolog
estimates save "`path'anz_kurl.ster", replace
predict pr_kurl
nbreg anzurlj i.hhflex i.pflex i.besch i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4 i.hh_bt  i.hhtyp alter alter2 i.sex i.pkwbes i.bahncard_jn  i.zweitw if anzpreisej<150, nolog
estimates save "`path'anz_url.ster", replace
predict pr_url
nbreg anztarj i.hhflex i.pflex i.besch i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4 i.hh_bt  i.hhtyp alter alter2 i.sex i.pkwbes i.bahncard_jn  i.zweitw if anzpreisej<150, nolog
estimates save "`path'anz_tar.ster", replace
predict pr_tar

save "`path'screening_pid_red_est.dta", replace



outreg2 using "`path'berechnung_dir.txt", replace noast tstat sideway

keep in 1 
keep besch bildung_2 hheink sex privatr
set obs 360

forvalues i=1/5 {
replace besch = `i' if mod(_n,5)== `i'-1
}

sort besch
 
forvalues i=1/3 {
replace bildung_2 = `i' if mod(_n,3)== `i'-1
}

sort besch bildung

forvalues i=1/4 {
replace hheink = `i' if mod(_n,4)== `i'-1
}

sort besch bildung_2 hheink

forvalues i=1/2 {
replace sex = `i' if mod(_n,2)== `i'-1
}

sort besch bildung_2 hheink sex

forvalues i=1/3 {
replace privatr = `i' if mod(_n,3)== `i'-1
}

sort besch bildung_2 hheink sex privatr

xi i.besch i.bildung_2  i.hheink   i.sex  i.privatr

estimates use "`path'anz_dir.ster"
predict anzdir_dis
predict stddir, stdp
gen anzdir=rpoisson(anzdir_dis)
gen anzdir=rnbinomial(anz_dir, anz_dir/200)


local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\"
set more off
use "`path'screening_pid_red.dta", clear


nbreg anzpreisej i.besch i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4 i.hh_bt  i.hhtyp alter alter2 i.sex i.pkw_verf i.bahncard_jn  if anzpreisej<150, nolog
nbreg anzkurlj i.hhflex i.pflex  i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4   alter alter2 i.sex i.pkw_verf i.zweitw  if anzpreisej<150, nolog
nbreg anzurlj i.besch i.bildung_2##ib3.hheink i.rtyp##i.wohnlage_4 i.hh_bt  i.hhtyp alter alter2 i.sex i.pkw_verf i.bahncard_jn  i.zweitw if anzpreisej<150, nolog

use "`path2'RA_00_03_05_08_ang.dta", clear

* starker Einfluss des Jahres, deshalb auf jeden Fall immer mit Jahresfilter arbeiten!
nbreg r_anz ib3.hheink_5##i.s6a i.besch i.hhtyp   ib3.polgk if Jahr==2003, nolog

local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\"
set more off
use "`path'screening_rid.dta", clear

merge n:m id using "`path'screening_pid_red_est.dta", keepusing(pr_*) nogen

* recode ranzpersonen


* drop pr tr pr_nk tr_nk ur ur_nk dr

tab rzweck_3, gen(rzweck3_)
logit rzweck3_1 i.besch i.bildung_2  ib3.hheink i.bildung_2 i.sex i1.rtyp alter alter2 pr_dir if normalertagreisebeginn==1, nolog
predict dr

* kein statistischer Zusammenhang zwischen Anzahl Privatreisen und Reise an einem normalen Tag!
* => Anteile aus Tabelle und zu Wahrscheinlichkeiten umwandeln! -> über cumul-Befehl
logit rzweck3_2  pr_kurl  i.pflex alter alter2 i.sex ib3.hheink if ntag==2, nolog
predict pr

logit rzweck3_2 pr_tar   i.pflex alter alter2 i.sex ib3.hheink if ntag==2, nolog
predict tr

logit rzweck3_3 pr_url   alter alter2 i.sex ib3.hheink if ntag==2 , nolog
predict ur

logit rzweck3_2 pr_tar pr_kurl    i.pflex alter alter2 i.sex ib3.hheink if ntag==3, nolog
predict pr_nk

logit rzweck3_2 pr_tar pr_kurl    i.pflex alter alter2 i.sex ib3.hheink if ntag==3, nolog
predict tr_nk

logit rzweck3_3 pr_url  alter alter2 i.sex ib3.hheink if ntag==3 , nolog
predict ur_nk

* gen pr_url = rpoisson(ur)
* logit rzweck3_1 anzdirj i.besch if r_modo_a==1 , nolog
* predict dr
* gen pr_dir =rpoisson(dr)



* +++++++++++++++ Verkehrsmittelwahl im Fernverkehr ++++++++++++++++++++++++++++++++++++++++++++

set more off
local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\"
local path2 "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Reiseanalyse\"

use "`path'screening_rid.dta", clear

* tab  rvmwahl rvm_4, col nofr
* tab rd_7 rvmwahl, col nofr

* mlogit rvm_4  i.rd_7#c.rdist ib2.rzweck_3 ib4.rdist_7   ib2.rgruppe  pkwfuehrer pkw_verf bahncard_jn zeitkarte i.rtyp##i.dist_bhf alter alter2, nolog base(3)
* mlogit rvm_4  i.rd_7#c.rdist ib2.rzweck_3 ib4.rdist_7   ib2.rgruppe  pkwfuehrer pkw_verf bahncard_jn zeitkarte i1.rtyp i.dist_bhf alter alter2, nolog base(3)
* Entfernung zum Bhf ohne Auswirkung, aber in MiD schon
mlogit rvm_4  i.rd_7#c.rdist ib2.rzweck_3 ib4.rdist_7   ib2.rgruppe  pkwfuehrer pkw_verf bahncard_jn zeitkarte i1.rtyp  alter alter2, nolog base(3)
predict rmode_*

quietly tab rvm_4 ,matrow(vars)
gen float cum2=0
gen rvm_schätz_aggr=.
gen float random2=runiform()
forvalues i= 1/3 {
	replace cum2 = cum2 + rmode_`i' if rmode_`i' <.
	replace rvm_schätz_aggr=vars[`i',1] if (cum2>=random2 & rvm_schätz_aggr ==.)
}
label value rvm_schätz_aggr rvm_4

egen rvm_schätz_max = rmax(rmode_?)
gen rvm_smax=.
forvalues i=1/3 {
	replace rvm_smax = vars[`i',1] if  rvm_schätz_max==rmode_`i'
}

* cumul  rd_7 if normalertagreisebeginn==1, gen(ant_rz_rd)  by(rzweck_3) equ

set more off
local path_mid "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD-Reisen\"

use "`path_mid'MiD_2008_Personen.dta", clear

merge n:m hhid pid using "`path_mid'MiD_Personen_cod_bereinig_def_wege.dta", gen(p_attr) keepusing(hh_ohne_pkw hh_mofa hh_rad hat_zeitkarte hh_zeitkarte zeitkarte p052_ka p054_ka hp_ausb ohne_pw PKW_VERF_neu Pkw_eigen2 p05_3 hheink_5  hhtyp_4 hhtyp_3 hp_besch_aggr verh_perg)
drop if p_attr==2

recode p101 (4=1 "geschäftlich") (1=3 "Urlaub") (2 3 5 6=2 "privat"), gen(rzweck_3) 


label var rzweck_3 "Hauptreisegrund (GPU)"
label define rzweck_3 1 "geschäftlich" 2 "privat" 3 "Urlaub", modify
label value rzweck_3 rzweck_3

gen rvm_3 = 1 if p1013_1==1
replace rvm_3=2 if p1013_2==1
replace rvm_3=3 if p1013_4==1

label var rvm_3 "HVM der Reise (Pkw, Bahn, Flug)"
label define rvm_3 1 "Pkw" 2 "Bahn" 3 "Flugzeug", modify

gen hh_pkw = h04_3>0 &  h04_3<.

recode p1014 (0=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7/100=7 "7++"), gen(rd_7)
recode p1016 (1/200=1 "<200") (201/400=2 "(200,400]") (401/600=3 "(400,600]") (601/800=4 "(600,800]") (801/1000=5 "(800,1000]") (1001/1200=6 "(1000,1200]") (1201/30000=7 ">1200") (0=.a "0 Tage"), gen(rdist_7)
recode p1016 (1/200=1 "<200") (201/400=2 "(200,400]") (401/600=3 "(400,600]") (601/800=4 "(600,800]") (801/1200=5 "(800,1200]")  (1201/30000=6 ">1200") (0=.a "0 Tage"), gen(rdist_6n)

recode p1015 (0=0 "allein") (1=1 "zu zweit") (2 3=2 "3/4") (5/10=3 ">4"), gen(rgruppe)
recode p054_ka (1/6=1 "<5km")  (7=2 "5km-10km") (8=3 ">10km"), gen(dist_bhf)

mlogit rvm_3 i.rzweck_3 i.rd_7#c.p1016 i.rdist_7 i.rgruppe c.hp_alter##c.hp_alter hp_pkwfs i.PKW_VERF_neu ib2.rtyp##i.dist_bhf [iw=r_gew], nolog base(3)
predict rmode_*

quietly tab rvm_3 ,matrow(vars)
gen float cum2=0
gen rvm_schätz_aggr=.
gen float random2=runiform()
forvalues i= 1/3 {
	replace cum2 = cum2 + rmode_`i' if rmode_`i' <.
	replace rvm_schätz_aggr=vars[`i',1] if (cum2>=random2 & rvm_schätz_aggr ==.)
}
label value rvm_schätz_aggr rvm_3

egen rvm_schätz_max = rmax(rmode_?)
gen rvm_smax=.
forvalues i=1/3 {
	replace rvm_smax = vars[`i',1] if  rvm_schätz_max==rmode_`i'
}
label value rvm_smax rvm_3