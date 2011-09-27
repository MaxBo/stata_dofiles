********** Program zur Generierung der Alters-Gruppen 18/25 ************+
*! version 1.0  06jun2009
program define soep_splitage1825

quietly {
	dropvars agem_backup agegroup
	gen agem_backup = agem
	stsplit agegroup, at(7(5)72)
	replace agegroup= agegroup+18
	soep_genvar_agedummy
}

end
****************************************************************************
