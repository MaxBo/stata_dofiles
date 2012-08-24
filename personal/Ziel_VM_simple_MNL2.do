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
	args lnf t_Rad t_OV t_Pkw const_Rad const_OV const_PkwMF const_PkwF beta_e
	local lambda = 1
 	local function = "E"
	local J = 13
	tempvar VM_chosen wij VMconst fwij U num num_chosen den p
	{
		gen `VM_chosen' = $ML_y1
		gen double `den' = 0
		forvalues j = 0/`J' {
			forvalues vm = 1/5 {
//			Fuss	
				if `vm' == 1 {
					quietly gen double `wij' = 1 * tFuss_`j'
					quietly gen double `VMconst' = 0
				}
//			Rad
				else if `vm' == 2 {
					quietly gen double `wij' = `t_Rad' * tRad_`j'
					quietly gen double `VMconst' = `const_Rad'
				}
//			OV
				else if `vm' == 3 {
					quietly gen double `wij' = `t_OV' * widOV_`j' //tOV_`j' + `UH' * UH_`j'+ `ZZ' * ZZ_`j'+ `SW' * SW_`j'
					quietly gen double `VMconst' = `const_OV'
				}
//			PkwMF
				else if `vm' == 4 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j'
					quietly gen double `VMconst' = `const_PkwMF'
				}
//			PkwF	
				else if `vm' == 5 {
					quietly gen double `wij' = `t_Pkw' * tPkw_`j' // + `cost_Pkw' * costPkw_`j'
					quietly gen double `VMconst' = `const_PkwF'
				}
				if "`function'" == "E" {
					quietly gen double `fwij' = `beta_e'*`wij'
				}
				else if "`function'" == "EVA" {
				}
				quietly gen double `U' = `VMconst' + `fwij' + lnZP`j' 
				quietly gen double `num' = exp(`U')
				if `j' == 0 {
					if `VM_chosen' == `vm' {
						quietly gen double `num_chosen' = `num'
					}
				}
				quietly replace `den' = `den' + `num' 
				quietly drop `wij' `VMconst' `fwij' `U' `num' 
			}
		}
		quietly gen double `p' = `num_chosen' / `den' 
		quietly replace `lnf' = ln(`p')*Gewicht
//		sum `p_vm' `p_Ziel' `p' `lnf'
//		di `lambda' `beta_e' `const_Rad' `const_Rad'
	}
end

ml model lf zielvm_lf (t_Rad : VM = ) /t_OV /t_Pkw (const_Rad: _IRadVerf*,noconst) /const_OV (const_PkwMF: _IPkwVerf*,noconst) (const_PkwF: _IPkwVerf*,noconst)  /beta_e 



ml init /t_Rad=1 /t_OV=0.5 /t_Pkw=1 /const_OV=0 /beta_e=-0.2


ml maximize,search(norescale)
 difficult
ml maximize
