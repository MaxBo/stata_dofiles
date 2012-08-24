********** Program zur Generierung der Alters-Dummy-Variablen ************+
*! version 1.0  06jun2009
program define soep_genvar_agedummy

quietly {

	xi i.agegroup*female,noomit
	renpfix _Iagegroup_ _age_
	renpfix  _IageXfema_ _fem1_
	forvalues i=25(5)85 {
		local ii=`i'+4
		rename _age_`i' _age_`i'_`ii'
		rename _fem1_`i' _fem1_`i'_`ii'
	}
	rename _age_90 _age_90_
	rename _fem1_90 _fem1_90_
	dropvars _fem1_18-_fem1_24
	gen _fem1_18_24=0
	replace _fem1_18_24=1 if (agem>=18&agem<25&female==1)
	gen _fem_18_34 = 1 if female==1 & agem>=18 & agem<35
	gen _fem_35_49 = 1 if female==1 & agem>=35 & agem<50
	gen _fem_50_64 = 1 if female==1 & agem>=50 & agem<65
	gen _fem_65_79 = 1 if female==1 & agem>=65 & agem<80
	gen _fem_80_ = 1 if female==1 & agem>=80 & agem<.
	recode _fem_* (.=0)

}

end
****************************************************************************
