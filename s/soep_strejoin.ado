********** Program zur Generierung der Alters-Dummy-Variablen ************+
*! version 1.0  06jun2009
program define soep_strejoin

quietly {

	dropvars agegroup _age_* _fem_* _fem1_* oa_* nachabgabe
	stjoin
	sort persnr agem

}

end
****************************************************************************
