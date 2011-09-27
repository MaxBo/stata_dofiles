********** Program zur Generierung der Alters-Gruppen 18/19 ************+
*! version 1.0  06jun2009
program define soep_splitage1819

quietly {
	dropvars agem_backup
	gen agem_backup = agem
	stsplit agegroup, at(1/6 7(5)72)
	replace agegroup= agegroup+18
	soep_genvar_agedummy
}

end
****************************************************************************
