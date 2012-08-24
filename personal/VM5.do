insheet using "Y:\data\biogeme\Beruf\Sample\WegeBeruf14.dat", case clear
drop v*
forvalues j = 0/9 {
	rename tFuss_0`j' tFuss_`j'
	rename tRad_0`j' tRad_`j'
	rename tOV_0`j' tOV_`j'
	rename UH_0`j' UH_`j'
	rename UZ_0`j' UZ_`j'
	rename ZZ_0`j' ZZ_`j'
	rename SW_0`j' SW_`j'
	rename costOV_0`j' costOV_`j'
	rename widOV_0`j' widOV_`j'
	rename BH_0`j' BH_`j'
	rename tPkw_0`j' tPkw_`j'
	rename costPkw_0`j' costPkw_`j'
	rename park_0`j' park_`j'
	rename widPkw_0`j' widPkw_`j'
}
forvalues j = 1/13 {
	dropvars *`j'
}



capture label drop VM PkwVerf
label define VM 1 "Fuss" 2 "Rad" 3 "ÖPNV" 4 "Pkw-Mitfahrer" 5 "Pkw-Fahrer"
label values VM VM

label define PkwVerf 0 "nie" 1 "zeitweise" 2 "immer"
label values PkwVerf PkwVerf

mlogit VM Distanz,trace

mlogit VM wage Distanz PkwVerf

dropvars PkwNie PkwZeitweise 
gen PkwNie = PkwVerf==0
gen PkwZeitweise = PkwVerf==1
mlogit VM wage Distanz PkwNie PkwZeitweise 


mlogit VM wage Distanz PkwNie PkwZeitweise RadVerf

rename tFuss_0 RZ1
rename tRad_0 RZ2
rename tOV_0 RZ3
rename tPkw_0 RZ4
gen RZ5 = RZ4

reshape long RZ , i(Id)

bysort Id (VM): gen VM5 = _n
gen chosen = VM==VM5

gen F = VM5==1
gen R = VM5==2
gen O = VM5==3
gen M = VM5==4
gen P = VM5==5

gen _sample = 1
replace _sample = 0 if R & (RadVerf==0)

gen Umstiegshaufigkeit = UH_0 * O
gen Umstiegszeit = UZ_0 * O
gen Zugangszeit = ZZ_0 * O
gen Startwartezeit = SW_0 * O

gen cost = costOV_0 * O + costPkw * P
gen park = park_0 * (M|P)

gen PkwNie_Fahrer = P * PkwNie
gen PkwNie_MitFahrer = M * PkwNie

gen PkwZeite_Fahrer = P * PkwZeitweise 
gen PkwZeitw_MitFahrer = M * PkwZeitweise 

clogit chosen F R O M RZ  Startwartezeit park cost /*
*/  PkwNie_MitFahrer  PkwZeitw_MitFahrer PkwNie_Fahrer PkwZeite_Fahrer  /*
*/ if _sample, group(Id)

capture label drop lb_VM3
nlogitgen VM3 = VM5(FussRad: 1|2, OV: 3, MIV: 4|5)
capture label drop lb_VM2
nlogitgen VM2 = VM5(NichtMotorisiert: 1|2, Motorisiert: 3|4|5)

nlogittree VM5 VM3 if _sample, choice(chosen)
nlogittree VM5 VM2 if _sample, choice(chosen)

capture label drop lb_Mot3
nlogitgen Mot3 = VM5(FussRad: 1|2, Zusammen: 3|4, alleine: 5)

nlogittree VM5 Mot3 VM2 if _sample, choice(chosen)


nlogit chosen F R O M RZ  Startwartezeit park cost /*
*/  if _sample ||VM2:  ||Mot3:  ||VM5: PkwNie PkwZeitweise /*
*/ , noconst case(Id)

nlogit chosen F R O M RZ  Startwartezeit park cost PkwNie_MitFahrer  PkwZeitw_MitFahrer PkwNie_Fahrer PkwZeite_Fahrer /*
*/  if _sample ||VM2:  ||Mot3:  ||VM5: /*
*/ , noconst case(Id)


nlogit chosen F R O M RZ  Startwartezeit park cost PkwNie_MitFahrer  PkwZeitw_MitFahrer PkwNie_Fahrer PkwZeite_Fahrer /*
*/  if _sample ||VM2:  ||VM5: /*
*/ , noconst case(Id)

nlogit chosen F R O M RZ   Startwartezeit park cost PkwNie_MitFahrer  PkwZeitw_MitFahrer PkwNie_Fahrer PkwZeite_Fahrer /*
*/  if _sample ||VM2: ||VM5: /*
*/ , noconst case(Id)


gen costwage = cost/wage


capture program drop zielvm_lf
program zielvm_lf
	version 10.1
	args lnf scale_Fuss scale_Rad scale_OV scale_PkwMF scale_PkwF UH ZZ SW const_Fuss const_Rad const_OV const_PkwMF const_PkwF A B C lambda
	local J = 13
	tempvar VM_chosen Ziel_chosen wij VMconst num_vm num_vm_chosen den_vm p_vm num_ziel num_ziel_chosen den_ziel p_Ziel p const
	quietly {
		gen double `num_vm_chosen'=0
		gen `VM_chosen' = $ML_y1
		gen double `den_ziel' = 0
		forvalues j = 0/`J' {
			gen double `den_vm' = 0
			forvalues vm = 1/5 {
				if `vm' == 1 {
					gen double `wij' = `scale_Fuss' * ( tFuss_`j' )
					gen double `const'=`const_Fuss'
				}
				else if `vm' == 2 {
					gen double `wij' = `scale_Rad' * ( tRad_`j' )
					gen double `const'=`const_Rad'
				}
				else if `vm' == 3 {
					gen double `wij' = `scale_OV' * ( tOV_`j' + `UH' * UH_`j'+ `ZZ' * ZZ_`j'+ `SW' * SW_`j')  //+ `costOV' * costOV_`j' 
					gen double `const'= `const_OV'
				}
				else if `vm' == 4 {
					gen double `wij' = `scale_PkwMF' * ( tPkw_`j' ) 
					gen double `const'= `const_PkwMF'
				}
				else if `vm' == 5 {
					gen double `wij' = `scale_PkwF' * (tPkw_`j' )  //+ `cost_Pkw' * costPkw_`j' + `costPkwF' * costPkw_`j' + `costPark' * park_`j'
					gen double `const'= `const_PkwF'
				}
//E
//				gen double `num_vm' = exp(`A'*`wij'+`const')
// EVA 
//				gen double `num_vm' = exp((-`A' /(1 + exp(`B' *(1 - `wij' /`C' ))))*ln(1 +`wij')+`const')
//				gen double `num_vm' = exp(((-`A' /(1 + exp(`B' *(1 - `wij' /`C' ))))*ln(1 +`wij')+`const')/`lambda')
//EVA2
				gen double `num_vm' = ((1 +(`wij' /`C' )^`B' )^`A')*exp(`const')
//				gen double `num_vm' = exp((1 +(`wij' /`C')^`B')^`A'+`const')

				if `j'== 0 {
					replace `num_vm_chosen' = `num_vm' if `VM_chosen' == `vm'
				}
				replace `den_vm' = `den_vm' + `num_vm' 
				drop `wij' `num_vm' `const'
			}
			gen double `num_ziel' = exp(lnZP`j' + `den_vm')
//			gen double `num_ziel' = exp(lnZP`j' + `lambda' * ln(`den_vm'))
			if `j' == 0 {
				gen double `p_vm' = `num_vm_chosen' / `den_vm'
				gen double `num_ziel_chosen' = `num_ziel'
			}
			replace `den_ziel' = `den_ziel' + `num_ziel'
			drop `den_vm' `num_ziel'
		}
		gen double `p_Ziel' = `num_ziel_chosen' / `den_ziel'
		gen double `p' = `p_vm' * `p_Ziel' 
		replace `lnf' = ln(`p')*Gewicht
	}
end

xi i.PkwVerf i.RadVerf,noomit
rename _IPkwVerf_0 Pkw_nie
rename _IPkwVerf_1 Pkw_gelegentlich
rename _IPkwVerf_2 Pkw_immer
rename _IRadVerf_0 Rad_nein
rename _IRadVerf_1 Rad_ja

constraint 1 [PkwF]Pkw_immer = 0
constraint 8 [sc_PkwF]_cons = [sc_PkwMF]_cons
constraint 7 [sc_Fuss]_cons = 1
constraint 2 [lambda]_cons = 1



constraint 3 [UH]_cons = 8
constraint 4 [ZZ]_cons = 1.6
constraint 5 [SW]_cons = 1.8
constraint 60 [A]_cons = 1
constraint 6 [cost]_cons = 0
constraint 9 [cost]_cons = 6
constraint 10 [costOV]_cons = 0
constraint 11 [costPkwF]_cons = 0
constraint 12 [costPark]_cons = 0
constraint 13 [costPark]_cons = [costPkwF]_cons
constraint 14 [costOV]_cons = [costPkwF]_cons

ml model lf zielvm_lf (sc_Fuss : VM = ) /sc_Rad /sc_OV /sc_PkwMF /sc_PkwF  /UH /ZZ /SW (Fuss: ) (Rad: ) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A , constraint(1 7 8)
ml init /sc_Rad=1 /sc_OV=1 /sc_PkwMF=1 /A=-.02

ml model lf zielvm_lf (sc_Fuss : VM = ) /sc_Rad /sc_OV /sc_PkwMF /sc_PkwF  /UH /ZZ /SW (Fuss: ) (Rad: ) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C , constraint(1 7 8)
ml init /sc_Rad=1 /sc_OV=1 /sc_PkwMF=1 /A=1 /B=5 /C=43
ml search
ml maximize,difficult
estimates store MNL_EVA2
estimates save "`EstPath'MNL_EVA2",replace
matrix b0 = e(b)
ml init  /A=-3 /B=3 /C=20

ml init  /A=-2 /B=2 /C=25


ml model lf zielvm_lf (sc_Fuss : VM = ) /sc_Rad /sc_OV /sc_PkwMF /sc_PkwF  /UH /ZZ /SW (Fuss: ) (Rad: ) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C /lambda, constraint(1 2 7 8) // (1 2 7 8)
ml init b0 ,skip
ml search
ml maximize
estimates save "`EstPath'VM_Ziel_NL_EVA",replace

estimates use "`EstPath'VM_Ziel_EVA"

ml maximize, search(norescale) difficult

ml maximize,difficult

ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C , constraint(1/5)
//ml init  /lambda=1 /t_Fuss = .5 /t_Rad=.5 /t_OV=.3 /UH=7 /ZZ=1 /SW=2 /A=1 /B=1 /C=43
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=.5 /t_OV=.3 /A=1 /B=5 /C=43
ml search
ml maximize,difficult
estimates store VM_Ziel_EVA
estimates save "`EstPath'VM_Ziel_EVA",replace
matrix b0 = e(b)

ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C , constraint(1/5)
ml init  b0,skip
ml maximize, search(norescale) difficult

ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C , constraint(1/6)
ml init  b0,skip
ml init  /B=3 /C=10
ml search
ml maximize,difficult
estimates store VM_Ziel_EVA2
estimates save "`EstPath'VM_Ziel_EVA2",replace



ml model lf vmziel_lf (lambda: VM = )  /costOV /costPkwF /costPark /t_Fuss /t_Rad /t_OV /t_PkwMF /t_PkwF /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A , constraint(1 2 3 4 5 7 13 14) //10 11 
estimates restore VM_Ziel_EVA
matrix b0 = e(b)
ml init  b1,skip
ml init   /A=-.02 /t_PkwMF = 1
ml init /costOV = 6 /costPkwF = 6 /costPark = 6
ml search
ml maximize, difficult
estimates store VM_Ziel_E
estimates save "`EstPath'VM_Ziel_E",replace
matrix b1 = e(b)



ml model lf zielvm_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)  /beta_e , constraint(1 2)



ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)  /beta_e , constraint(1 2)
ml init  /lambda=1 /t_Fuss = 1 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /beta_e=-0.02
ml search
ml maximize
estimates store Ziel_VM_E
estimates save "`EstPath'Ziel_VM_E"

ml model lf zielvm_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Rad: Rad_*,noconst) /const_OV (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)   /A /B /C 
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /A=1 /B=1 /C=43
ml search
ml maximize
estimates store Ziel_VM_EVA
estimates save "`EstPath'Ziel_VM_EVA"

ml model lf zielvm_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Rad: Rad_*,noconst) /const_OV (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)  /A /B /C 
ml init  b0,skip
ml maximize,search(norescale)difficult
estimates store Ziel_VM_EVA2
estimates save "`EstPath'Ziel_VM_EVA2"



ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C , constraint(1 3 4 5)
//ml init  /lambda=1 /t_Fuss = .5 /t_Rad=.5 /t_OV=.3 /UH=7 /ZZ=1 /SW=2 /A=1 /B=1 /C=43
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=.5 /t_OV=.3 /A=1 /B=1 /C=43
ml maximize
estimates store VM_Ziel_EVA
estimates save "`EstPath'VM_Ziel_EVA"


ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Rad: Rad_*,noconst) /const_OV (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C 
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /A=-2.5 /B=1 /C=30
ml search
ml maximize,search(norescale)difficult
estimates store VM_Ziel_EVA2
estimates save "`EstPath'VM_Ziel_EVA2"


ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW /const_Rad /const_OV /constPkwMF /constPkwF /beta_e
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /beta_e=-0.2
ml search
ml maximize
estimates store VM_Ziel_const

ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Rad: Rad_*,noconst) /const_OV (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)  /beta_e
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /beta_e=-0.2
ml search
ml maximize
estimates store VM_Ziel_E
estimates save "`EstPath'VM_Ziel_E"




ml init b0
ml init  /lambda=1 
 
