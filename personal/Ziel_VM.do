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



program drop zielvm_lf
program zielvm_lf
	version 10.1
//	args lnf lambda t_Fuss t_Rad t_OV UH ZZ SW t_Pkw cost_Pkw const_Fuss const_Rad const_OV const_PkwF const_PkwMF beta_e
	args lnf lambda t_Rad t_OV UH ZZ SW t_Pkw cost_Pkw const_Rad const_OV const_PkwF const_PkwMF beta_e
 	local function = "E"
	local J = 13
//	local VMList = "Fuss Rad OV PkwF PkwMF"
	tempvar VM_chosen Ziel_chosen wij VMconst fwij Uvm_lambda num_vm num_vm_chosen den_vm p_vm lambda_I Uj num_ziel num_ziel_chosen den_ziel p_Ziel p
	{
		gen int `Ziel_chosen' = $ML_y1
		gen `VM_chosen' = $ML_y2
		gen double `den_ziel' = 0
		forvalues j = 0/`J' {
			gen double `den_vm' = 0
			forvalues vm = 1/5 {
//			foreach vm in `VMList'{
//				if "`vm'" == "Fuss" {	
				if `vm' == 1 {
					quietly gen double `wij' = 1 * tFuss_`j'
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
//				else if "`vm'" == "PkwF" {	
				else if `vm' == 4 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j' + `cost_Pkw' * costPkw_`j'
					quietly gen double `VMconst' = `const_PkwF'
				}
//				else if "`vm'" == "PkwMF" {	
				else if `vm' == 5 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j'
					quietly gen double `VMconst' = `const_PkwMF'
				}
				if "`function'" == "E" {
					quietly gen double `fwij' = `beta_e'*`wij'
				}
				else if "`function'" == "EVA" {
				}
				quietly gen double `Uvm_lambda' = (`VMconst' + `fwij')/`lambda'
				quietly gen double `num_vm' = exp(`Uvm_lambda')
//				if ("`VM_chosen'" == "`vm'" & `Ziel_chosen' == `j') {
				if (`VM_chosen' == `vm' & `Ziel_chosen' == `j') {
					quietly gen double `num_vm_chosen' = `num_vm'
				}
				quietly replace `den_vm' = `den_vm' + `num_vm' 
				quietly drop `wij' `VMconst' `fwij' `Uvm_lambda' `num_vm' 
			}
			quietly gen double `lambda_I' = `lambda' * ln(`den_vm')
			quietly gen double `Uj' = lnZP`j' + `lambda_I'
			quietly gen double `num_ziel' = exp(`Uj')
			if `Ziel_chosen' == `j'{
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
//constraint 1 [t_Fuss]:_const=1
//constraint 2 [const_Fuss]:_const=0
//ml model lf zielvm_lf (lambda: Ziel VM = ) /t_Fuss /t_Rad /t_OV /UH /ZZ /SW /t_Pkw /cost_Pkw /const_Fuss /const_Rad /const_OV /const_PkwF /const_PkwMF /beta_e, constraint(1 2)

ml model lf zielvm_lf (lambda: Ziel VM = ) /t_Rad /t_OV /UH /ZZ /SW /t_Pkw /cost_Pkw /const_Rad /const_OV /const_PkwF /const_PkwMF /beta_e

//ml init /lambda=1 /t_Fuss=1 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /t_Pkw=2 /cost_Pkw=6 /const_Fuss=0 /const_Rad=0 /const_OV=0 /const_PkwF=0 /const_PkwMF =-1 /beta_e=-0.2
ml init /lambda=1 /t_Rad=1 /t_OV=0.5 /UH=5 /ZZ=2 /SW=2 /t_Pkw=1 /cost_Pkw=6 /const_Rad=-1 /const_OV=0 /const_PkwF=0 /const_PkwMF =-2 /beta_e=-0.2


ml maximize,search(norescale)
 
