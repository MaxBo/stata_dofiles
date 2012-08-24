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

program drop vmziel_lf
program vmziel_lf
	version 10.1
	args lnf lambda t_Fuss t_Rad t_OV UH ZZ SW const_Rad const_OV const_PkwMF const_PkwF A B C
	local t_Pkw = 1
 	local function = "E"
// 	local function = "EVA"
// 	local function = "EVA2"
	local J = 13
//	local VMList = "Fuss Rad OV PkwF PkwMF"
	tempvar VM_chosen Ziel_chosen wij VMconst fwij Uziel_lambda num_vm num_vm_chosen den_vm p_vm lambda_I Uj num_ziel num_ziel_chosen den_ziel p_ziel p
	quietly gen double `num_ziel_chosen'=0
	quietly gen double `num_vm_chosen'=0
	quietly gen double `p_ziel'=0

	{
		gen `VM_chosen' = $ML_y1
		gen double `den_vm' = 0
		forvalues vm = 1/5 {
//		foreach vm in `VMList'{
			gen double `den_ziel' = 0
			forvalues j = 0/`J' {
//				if "`vm'" == "Fuss" {	
				if `vm' == 1 {
					quietly gen double `wij' = `t_Fuss' * tFuss_`j'
					quietly gen double `VMconst' = 0
				}
//				else if "`vm'" == "Rad" {	
				else if `vm' == 2 {
					quietly gen double `wij' = `t_Rad' * tRad_`j'
					quietly gen double `VMconst' = `const_Rad'
				}
//				else if "`vm'" == "OV" {	
				else if `vm' == 3 {
					quietly gen double `wij' = `t_OV' * tOV_`j' + `UH' * UH_`j'+ `ZZ' * ZZ_`j'+ `SW' * SW_`j'
					quietly gen double `VMconst' = `const_OV'
				}
//				else if "`vm'" == "PkwMF" {	
				else if `vm' == 4 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j'
					quietly gen double `VMconst' = `const_PkwMF'
				}
//				else if "`vm'" == "PkwF" {	
				else if `vm' == 5 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j' // + `cost_Pkw' * costPkw_`j'
					quietly gen double `VMconst' = `const_PkwF'
				}
				if "`function'" == "E" {
					quietly gen double `fwij' = `A'*`wij'
					quietly gen double `Uziel_lambda' = (`VMconst' + `fwij')/`lambda'
					quietly gen double `num_ziel' = exp(`Uziel_lambda' )
				}
				else if "`function'" == "EVA" {
					quietly gen double `fwij' = -(`A' /(1 + exp(`B' *(1 - `wij' /`C' ))))*ln(1 +`wij')
					quietly gen double `Uziel_lambda' = (`VMconst' + `fwij')/`lambda'
					quietly gen double `num_ziel' = exp(`Uziel_lambda' )
				}
				else if "`function'" == "EVA2" {
					quietly gen double `fwij' = (1 +(`wij' /`C')^`B') ^ `A'
					quietly gen double `Uziel_lambda' = 0
					quietly gen double `num_ziel' = exp(`VMconst'/`lambda')*`fwij' ^(1/`lambda')
				}
				if `j'== 0 {
					quietly replace `num_ziel_chosen' = `num_ziel' if `VM_chosen' == `vm'
				}
				quietly replace `den_ziel' = `den_ziel' + `num_ziel' 
				quietly drop `wij' `VMconst' `fwij' `Uziel_lambda' `num_ziel' 
			}
			quietly gen double `lambda_I' = `lambda' * ln(`den_ziel')
			quietly gen double `Uj' = `lambda_I'
			quietly gen double `num_vm' = exp(`Uj')
			quietly replace `num_vm_chosen' = `num_vm' if `VM_chosen' == `vm'
			quietly replace `p_ziel' = `num_ziel_chosen' / `den_ziel' if `VM_chosen' == `vm'
			quietly replace `den_vm' = `den_vm' + `num_vm'
			quietly drop `den_ziel' `lambda_I' `Uj' `num_vm'
		}
		quietly gen double `p_vm' = `num_vm_chosen' / `den_vm'
		quietly gen double `p' = `p_vm' * `p_ziel' 
		quietly replace `lnf' = ln(`p')*Gewicht
//		sum `p_vm' `p_ziel' `p' `lnf'
//		di `lambda' `beta_e' `const_Rad' `const_Rad'
	}
end

program drop zielvm_lf
program zielvm_lf
	version 10.1
	args lnf lambda t_Fuss t_Rad t_OV UH ZZ SW const_Rad const_OV const_PkwMF const_PkwF A B C
	local t_Pkw = 1
//	local lambda = 1
// 	local function = "E"
 	local function = "EVA"
// 	local function = "EVA2"
	local J = 13
//	local VMList = "Fuss Rad OV PkwF PkwMF"
	tempvar VM_chosen Ziel_chosen wij VMconst fwij Uvm_lambda num_vm num_vm_chosen den_vm p_vm lambda_I Uj num_ziel num_ziel_chosen den_ziel p_Ziel p
	quietly gen double `num_vm_chosen'=0
	{
		gen `VM_chosen' = $ML_y1
		gen double `den_ziel' = 0
		forvalues j = 0/`J' {
			gen double `den_vm' = 0
			forvalues vm = 1/5 {
//			foreach vm in `VMList'{
//				if "`vm'" == "Fuss" {	
				if `vm' == 1 {
					quietly gen double `wij' = `t_Fuss' * tFuss_`j'
					quietly gen double `VMconst' = 0
				}
//				else if "`vm'" == "Rad" {	
				else if `vm' == 2 {
					quietly gen double `wij' = `t_Rad' * tRad_`j'
					quietly gen double `VMconst' = `const_Rad'
				}
//				else if "`vm'" == "OV" {	
				else if `vm' == 3 {
					quietly gen double `wij' = `t_OV' * tOV_`j' + `UH' * UH_`j'+ `ZZ' * ZZ_`j'+ `SW' * SW_`j'
					quietly gen double `VMconst' = `const_OV'
				}
//				else if "`vm'" == "PkwMF" {	
				else if `vm' == 4 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j'
					quietly gen double `VMconst' = `const_PkwMF'
				}
//				else if "`vm'" == "PkwF" {	
				else if `vm' == 5 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j' // + `cost_Pkw' * costPkw_`j'
					quietly gen double `VMconst' = `const_PkwF'
				}
				if "`function'" == "E" {
					quietly gen double `fwij' = `A'*`wij'
					quietly gen double `Uvm_lambda' = (`VMconst' + `fwij')/`lambda'
					quietly gen double `num_vm' = exp(`Uvm_lambda')
				}
				else if "`function'" == "EVA" {
					quietly gen double `fwij' = -(`A' /(1 + exp(`B' *(1 - `wij' /`C' ))))*ln(1 +`wij')
					quietly gen double `Uvm_lambda' = (`VMconst' + `fwij')/`lambda'
					quietly gen double `num_vm' = exp(`Uvm_lambda')
				}
				else if "`function'" == "EVA2" {
					quietly gen double `fwij' = (1 +(`wij' /`C')^`B')^`A'
					quietly gen double `Uvm_lambda' = 0
					quietly gen double `num_vm' = exp(`VMconst'/`lambda')*`fwij' ^(1/`lambda')
				}
//				if ("`VM_chosen'" == "`vm'" & `Ziel_chosen' == `j') {
				if `j'== 0 {
					quietly replace `num_vm_chosen' = `num_vm' if `VM_chosen' == `vm'
				}
				quietly replace `den_vm' = `den_vm' + `num_vm' 
				quietly drop `wij' `VMconst' `fwij' `Uvm_lambda' `num_vm' 
			}
			quietly gen double `lambda_I' = `lambda' * ln(`den_vm')
			quietly gen double `Uj' = lnZP`j' + `lambda_I'
			quietly gen double `num_ziel' = exp(`Uj')
			if `j' == 0 {
				quietly gen double `p_vm' = `num_vm_chosen' / `den_vm'
				quietly gen double `num_ziel_chosen' = `num_ziel'
			}
			quietly replace `den_ziel' = `den_ziel' + `num_ziel'
			quietly drop `den_vm' `lambda_I' `Uj' `num_ziel'
		}
		quietly gen double `p_Ziel' = `num_ziel_chosen' / `den_ziel'
		quietly gen double `p' = `p_vm' * `p_Ziel' 
		quietly replace `lnf' = ln(`p')*Gewicht
//		sum `p_vm' `p_Ziel' `p' `lnf'
//		di `lambda' `beta_e' `const_Rad' `const_Rad'
	}
end

//constraint 1 [t_Fuss]_const=1
//constraint 2 [const_Fuss]_const=0
//constraint 3 [lambda]_const= 1
//ml model lf zielvm_lf (lambda: Ziel VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW /t_Pkw /cost_Pkw /const_Fuss /const_Rad /const_OV /const_PkwF /const_PkwMF /beta_e, constraint(1 2)
//ml model lf zielvm_lf (lambda: Ziel VM = ) /t_Rad /t_OV /UH /ZZ /SW /t_Pkw /cost_Pkw /const_Rad /const_OV /const_PkwF /const_PkwMF /beta_e, constraints(3)

xi i.PkwVerf i.RadVerf,noomit
rename _IPkwVerf_0 Pkw_nie
rename _IPkwVerf_1 Pkw_gelegentlich
rename _IPkwVerf_2 Pkw_immer
rename _IRadVerf_0 Rad_nein
rename _IRadVerf_1 Rad_ja







ml model lf zielvm_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Rad: Rad_*,noconst) /const_OV (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst)  /beta_e
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /beta_e=-0.2
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



ml model lf vmziel_lf (lambda: VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW (Rad: Rad_*,noconst) /const_OV (PkwMF: Pkw_*,noconst) (PkwF: Pkw_*,noconst) /A /B /C 
ml init  /lambda=1 /t_Fuss = .5 /t_Rad=.5 /t_OV=.3 /UH=7 /ZZ=1 /SW=2 /A=1 /B=1 /C=43
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
 
