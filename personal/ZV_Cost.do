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
local EstPath = "Y:\MiD-H\Estimates\"

capture program drop vmziel_lf
program vmziel_lf
	version 10.1
//	syntax varlist [, function(string)]
	args lnf lambda costOV costPkwF costPark scale_Fuss scale_Rad scale_OV scale_PkwMF scale_PkwF UH ZZ SW const_Fuss const_Rad const_OV const_PkwMF const_PkwF A B C
//	local scale_PkwF = 1
 	local functype = "E"
// 	local functype = "EVA"
// 	local functype = "EVA2"
	local J = 0 //13
//	local VMList = "Fuss Rad OV PkwF PkwMF"
	tempvar VM_chosen Ziel_chosen wij VMconst fwij Uziel_lambda num_vm num_vm_chosen den_vm p_vm lambda_I Uj num_ziel num_ziel_chosen den_ziel p_ziel p
	quietly {
		gen double `num_ziel_chosen'=0
		gen double `num_vm_chosen'=0
		gen double `p_ziel'=0
		gen `VM_chosen' = $ML_y1
		gen double `den_vm' = 0
		forvalues vm = 1/5 {
//		foreach vm in `VMList'{
			gen double `den_ziel' = 0
			forvalues j = 0/`J' {
//				if "`vm'" == "Fuss" {	
				if `vm' == 1 {
					gen double `wij' = `scale_Fuss' *  tFuss_`j' 
					gen double `VMconst' = `const_Fuss'

				}
//				else if "`vm'" == "Rad" {	
				else if `vm' == 2 {
					gen double `wij' = `scale_Rad' * tRad_`j'
					gen double `VMconst' = `const_Rad'
				}
//				else if "`vm'" == "OV" {	
				else if `vm' == 3 {
					gen double `wij' = `scale_OV' * ( tOV_`j' + `UH' * UH_`j'+ `ZZ' * ZZ_`j'+ `SW' * SW_`j' ) + `costOV' *  costOV_`j'
					gen double `VMconst' = `const_OV'
				}
//				else if "`vm'" == "PkwMF" {	
				else if `vm' == 4 {
					gen double `wij' = `scale_PkwMF' *  tPkw_`j' 
					gen double `VMconst' = `const_PkwMF'
				}
//				else if "`vm'" == "PkwF" {	
				else if `vm' == 5 {
					gen double `wij' = `scale_PkwF' *  tPkw_`j' + `costPkwF' * costPkw_`j' + `costPark' * park_`j' // + `cost_Pkw' * costPkw_`j' 
					gen double `VMconst' = `const_PkwF'
				}
				if "`functype'" == "E" {
					gen double `fwij' = `A'*`wij'
					gen double `Uziel_lambda' = (`fwij'+`VMconst')/`lambda'
					gen double `num_ziel' = exp(`Uziel_lambda' )
				}
				else if "`functype'" == "EVA" {
					gen double `fwij' = -(`A' /(1 + exp(`B' *(1 - `wij' /`C' ))))*ln(1 +`wij')
					gen double `Uziel_lambda' = (`VMconst' + `fwij')/`lambda'
					gen double `num_ziel' = exp(`Uziel_lambda' )
				}
				else if "`functype'" == "EVA2" {
					gen double `fwij' = (1 +(`wij' /`C')^`B') ^ `A'
					gen double `Uziel_lambda' = 0
					gen double `num_ziel' = exp(`VMconst'/`lambda')*`fwij' ^(1/`lambda')
				}
				if `j'== 0 {
					replace `num_ziel_chosen' = `num_ziel' if `VM_chosen' == `vm'
				}
				replace `den_ziel' = `den_ziel' + `num_ziel' 
				drop `wij' `fwij' `Uziel_lambda' `num_ziel'  `VMconst' 
			}
			gen double `lambda_I' = `lambda' * ln(`den_ziel')
			gen double `Uj' = `lambda_I'
			gen double `num_vm' = exp(`Uj')
			replace `num_vm_chosen' = `num_vm' if `VM_chosen' == `vm'
			replace `p_ziel' = `num_ziel_chosen' / `den_ziel' if `VM_chosen' == `vm'
			replace `den_vm' = `den_vm' + `num_vm'
			drop `den_ziel' `lambda_I' `Uj' `num_vm'
		}
		gen double `p_vm' = `num_vm_chosen' / `den_vm'
		gen double `p' = `p_vm' * `p_ziel' 
		replace `lnf' = ln(`p')*Gewicht
//		sum `p_vm' `p_ziel' `p' `lnf'
//		di `lambda' `beta_e' `const_Rad' `const_Rad'
	}
end

capture program drop zielvm_lf
program zielvm_lf
	version 10.1
	args lnf lambda scale_Fuss scale_Rad scale_OV UH ZZ SW const_Fuss const_Rad const_OV const_PkwMF const_PkwF A B C
	local scale_Pkw = 1
//	local lambda = 1
 	local function = "E"
// 	local function = "EVA"
// 	local function = "EVA2"
	local J = 13
//	local VMList = "Fuss Rad OV PkwF PkwMF"
	tempvar VM_chosen Ziel_chosen wij VMconst fwij Uvm_lambda num_vm num_vm_chosen den_vm p_vm lambda_I Uj num_ziel num_ziel_chosen den_ziel p_Ziel p
	quietly {
		gen double `num_vm_chosen'=0
		gen `VM_chosen' = $ML_y1
		gen double `den_ziel' = 0
		forvalues j = 0/`J' {
			gen double `den_vm' = 0
			forvalues vm = 1/5 {
//			foreach vm in `VMList'{
//				if "`vm'" == "Fuss" {	
				if `vm' == 1 {
					gen double `wij' = `scale_Fuss' * ( tFuss_`j' + `const_Fuss' )
				}
//				else if "`vm'" == "Rad" {	
				else if `vm' == 2 {
					gen double `wij' = `scale_Rad' * ( tRad_`j' + `const_Rad' )
				}
//				else if "`vm'" == "OV" {	
				else if `vm' == 3 {
					gen double `wij' = `scale_OV' * ( tOV_`j' + `UH' * UH_`j'+ `ZZ' * ZZ_`j'+ `SW' * SW_`j' + `const_OV') + `costOV' * costOV_`j'
				}
//				else if "`vm'" == "PkwMF" {	
				else if `vm' == 4 {
					gen double `wij' = `scale_Pkw' * ( tPkw_`j' + `const_PkwMF')
				}
//				else if "`vm'" == "PkwF" {	
				else if `vm' == 5 {
					gen double `wij' = `scale_Pkw' * (tPkw_`j' + `const_PkwF') //+ `cost_Pkw' * costPkw_`j' + `costPkwF' * costPkw_`j' + `costPark' * park_`j'

				}
				if "`function'" == "E" {
					gen double `fwij' = `A'*`wij'
					gen double `Uvm_lambda' = `fwij'/`lambda'
					gen double `num_vm' = exp(`Uvm_lambda')
				}
				else if "`function'" == "EVA" {
					gen double `fwij' = -(`A' /(1 + exp(`B' *(1 - `wij' /`C' ))))*ln(1 +`wij')
					gen double `Uvm_lambda' = (`VMconst' + `fwij')/`lambda'
					gen double `num_vm' = exp(`Uvm_lambda')
				}
				else if "`function'" == "EVA2" {
					gen double `fwij' = (1 +(`wij' /`C')^`B')^`A'
					gen double `Uvm_lambda' = 0
					gen double `num_vm' = exp(`VMconst'/`lambda')*`fwij' ^(1/`lambda')
				}
//				if ("`VM_chosen'" == "`vm'" & `Ziel_chosen' == `j') {
				if `j'== 0 {
					replace `num_vm_chosen' = `num_vm' if `VM_chosen' == `vm'
				}
				replace `den_vm' = `den_vm' + `num_vm' 
				drop `wij' `fwij' `Uvm_lambda' `num_vm' //`VMconst' 
			}
			gen double `lambda_I' = `lambda' * ln(`den_vm')
			gen double `Uj' = lnZP`j' + `lambda_I'
			gen double `num_ziel' = exp(`Uj')
			if `j' == 0 {
				gen double `p_vm' = `num_vm_chosen' / `den_vm'
				gen double `num_ziel_chosen' = `num_ziel'
			}
			replace `den_ziel' = `den_ziel' + `num_ziel'
			drop `den_vm' `lambda_I' `Uj' `num_ziel'
		}
		gen double `p_Ziel' = `num_ziel_chosen' / `den_ziel'
		gen double `p' = `p_vm' * `p_Ziel' 
		replace `lnf' = ln(`p')*Gewicht
//		sum `p_vm' `p_Ziel' `p' `lnf'
//		di `lambda' `beta_e' `const_Rad' `const_Rad'
	}
end

xi i.PkwVerf i.RadVerf,noomit
rename _IPkwVerf_0 Pkw_nie
rename _IPkwVerf_1 Pkw_gelegentlich
rename _IPkwVerf_2 Pkw_immer
rename _IRadVerf_0 Rad_nein
rename _IRadVerf_1 Rad_ja

constraint 1 [PkwF]Pkw_immer = 0
constraint 2 [lambda]_cons = 1
constraint 3 [UH]_cons = 8
constraint 4 [ZZ]_cons = 1
constraint 5 [SW]_cons = 1
constraint 60 [A]_cons = 1
constraint 6 [cost]_cons = 0
constraint 7 [t_PkwF]_cons = 1
constraint 8 [t_PkwF]_cons = [t_PkwMF]_cons
constraint 9 [cost]_cons = 6
constraint 10 [costOV]_cons = 0
constraint 11 [costPkwF]_cons = 0
constraint 12 [costPark]_cons = 0
constraint 13 [costPark]_cons = [costPkwF]_cons
constraint 14 [costOV]_cons = [costPkwF]_cons

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



ml model lf zielvm_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Fuss: ) (Rad: Rad_*,noconst) (OV: ) (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)  /beta_e , constraint(1)



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
 
