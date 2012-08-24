********** Program zur Generierung der State-Dependence-Variablen für den Pkw-Besitz ************
*! version 1.01  01nov2009
************************************************************************

***********************************************************************
program define MOP_genvar_StateDep_Pkw

syntax , CARnumbers(numlist)

quietly {
//noi di "lösche Fälle der Panel-Welle 1998"
//keep if year==2003
local pastyear LY


dropvars C`pastyear'_?_C?
noi di "generiere Variablen für State Dependence des Pkw-Besitzes"
// kontrolliere State Dependence mit lagged variablen des Pkw-Besitzes
foreach c of numlist `carnumbers'{
	if `c' != 1{
		foreach cc of numlist `carnumbers'{
			gen C`pastyear'_`cc'_C`c' = C`c'& hpkw03LastY==`cc'
		}
	}
}

}


end 
************************************************************************


