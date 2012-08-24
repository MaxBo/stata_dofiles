********** Program zum Setzen des Gewichtungsfaktors ************
*! version 1.0  06jun2009

program define soep_stgew2

//syntax varlist, Failure(string) Enter(string)
syntax varlist, Failure(string) Enter(numlist)

di "setze Gewichtungsfaktor `varlist'2:"
di "= dem Längsschnittsgewicht `varlist' des Jahres, in dem das 'Risk Set' beginnt'"
quietly {
//Setze Gewichtungsfaktor für Person auf `varlist'2 des Jahres, in dem Person ins "Risk-Set" eintritt
sort persnr agem 
dropvars `varlist'2 
gen `varlist'2 =.
foreach e of numlist `enter' {
	replace `varlist'2 = `varlist' if `failure'==`e'
}
bysort persnr (agem): replace `varlist'2 = `varlist'2[_n-1] if `varlist'2[_n-1]!=.
bysort persnr (agem): replace `varlist'2 = `varlist'2[_N] if `varlist'2==.
}

end
