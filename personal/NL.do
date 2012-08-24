insheet using "Y:\data\biogeme\Beruf\Sample\WegeBeruf14.dat", case clear
drop v*
local J = 13
local Con2Index = `J'
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
reshape long ZP lnZP tFuss_ tRad_ tOV_ UH_ UZ_ ZZ_ SW_ costOV_ widOV_ BH_ tPkw_ costPkw_ park_ widPkw_, i(Id) j(ZielNr)

rename tFuss_ t_1
rename tRad_ t_2
rename tOV_ t_3
rename tPkw_ t_4
gen t_5 = t_4
rename costOV_  cost_3
rename costPkw_  cost_5

rename park_ park_5
rename UH_ UH_3
rename UZ_ UZ_3
rename ZZ_ ZZ_3
rename SW_ SW_3
rename widOV_ wid_3
rename widPkw_ wid_5
gen wid_1 = t_1
gen wid_2 = t_2
gen wid_4 = t_4


gen double Id_Ziel = Id * 100 + ZielNr
format Id_Ziel %15.0g
reshape long t_ cost_ park_ UH_ UZ_ ZZ_ SW_ wid_, i(Id_Ziel) j(VMNr)
gen Alt = VMNr * 100 + ZielNr 
recode t_ cost_ UH_ UZ_ ZZ_ SW_ wid_ park_ (.=0)
gen chosen = (AltNr == Alt)
constraint define `J'+1+`j' [0]lnZP = 1

forvalues j = 1/13 {
	constraint define `j' `j'_tau = 0_tau
	constraint define `++Con2Index' [`j']lnZP = [0]lnZP 
}

nlogit chosen t_ UH_ SW_ || ZielNr: lnZP, base(0) || Alt:, case(Id) ,constraints(1/26)

