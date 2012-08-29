clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_3.dta", clear

drop ErwQu_mj* ErwQu_ne*

gen ErwQu_mj =  HHErwerb/ HHGRue14
label var ErwQu_mj "Erwerbstätigenquote mit über 14-jährigen roh"
gen ErwQu_ne =  HHErwerb/ HHErwachsene
label var ErwQu_ne "Erwerbstätigenquote mit über 18-jährigen roh"

gen ErwQu_mj_kl = 1 if ErwQu_mj==0
replace ErwQu_mj_kl = 2 if ErwQu_mj>0 & ErwQu_mj<0.26
replace ErwQu_mj_kl = 3 if ErwQu_mj>0.25 & ErwQu_mj<0.51
replace ErwQu_mj_kl = 4 if ErwQu_mj>0.5 & ErwQu_mj<0.76
replace ErwQu_mj_kl = 5 if ErwQu_mj>0.75 & ErwQu_mj<1.01
replace ErwQu_mj_kl = 6 if ErwQu_mj>1 & ErwQu_mj<4

gen ErwQu_ne_kl = 1 if ErwQu_ne==0
replace ErwQu_ne_kl = 2 if ErwQu_ne>0 & ErwQu_ne<0.26
replace ErwQu_ne_kl = 3 if ErwQu_ne>0.25 & ErwQu_ne<0.51
replace ErwQu_ne_kl = 4 if ErwQu_ne>0.5 & ErwQu_ne<0.76
replace ErwQu_ne_kl = 5 if ErwQu_ne>0.75 & ErwQu_ne<1.01
replace ErwQu_ne_kl = 6 if ErwQu_ne>1 & ErwQu_ne<4

label var ErwQu_ne_kl "Erwerbstätigenquote mit über 18-jährigen"
label var ErwQu_mj_kl "Erwerbstätigenquote mit über 14-jährigen"
label drop ErwQu_mj_kl
label define ErwQu_mj_kl 1 `"keine Erwerbstätigen"'  2 `"einer von vieren arbeitet"' 3 `"einer von zwei arbeitet"' 4  `"von vier arbeiten drei"' 5 `"alle erwerbstätig"' 6 `"alle erwerbstätig + Azubi"'

label value ErwQu_mj_kl ErwQu_mj_kl
label value ErwQu_ne_kl ErwQu_mj_kl

tab ErwQu_mj_kl, gen(ErwQu_mj_)
tab ErwQu_ne_kl, gen(ErwQu_ne_)

