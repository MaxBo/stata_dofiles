********** Program zur Generierung der Alters-Gruppen 18/19 ************+
*! version 1.0  21jun2009
program define soep_splitage

syntax [, A1824]

quietly {
	dropvars agem_backup agegroup
	//gen agem_backup = agem
	if "`a1824'" != "" {	
		noi stsplit agegroup, at(1/6 7(5)72)
	}
	else {
		noi stsplit agegroup, at(7(5)72)
	}
	sort persnr agem 
	replace agegroup= agegroup+18

	if "`a1824'" != "" {	
		forvalues i=18(1)24 {
			gen _age_`i' = (agegroup==`i')
		}
		constraint 100 _age_18=0
	}
	else {
		gen _age_18_24 = (agem>=18 & agem<25)
		constraint 100 _age_18_24=0
	}

	forvalues i=25(5)85 {
		local ii=`i'+4
		gen _age_`i'_`ii' = (agegroup==`i')
	}
	gen _age_90_ = (agegroup==90)
	gen _fem_18_34 = (female==1 & agem>=18 & agem<35)
	gen _fem_35_49 = (female==1 & agem>=35 & agem<50)
	gen _fem_50_64 = (female==1 & agem>=50 & agem<65)
	gen _fem_65_79 = (female==1 & agem>=65 & agem<80)
	gen _fem_80_ = (female==1 & agem>=80 & agem<.)

}

end
****************************************************************************
