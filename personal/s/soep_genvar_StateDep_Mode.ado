********** Program zur Generierung der State-Dependence-Variablen für die Verkehrsmittelwahl ************
*! version 1.01  06jun2009
************************************************************************

***********************************************************************
program define soep_genvar_StateDep_Mode

quietly {
noi di "lösche Fälle der Panel-Welle 1998"
keep if year==2003

dropvars ??mode98
noi di "generiere Variablen für State Dependence der Verkehrsmittelwahl"
// kontrolliere State Dependence mit lagged variablen der Verkehrsmittelwahl
gen OOmode98 = O*mode98==1
gen RRmode98 = R*mode98==2
gen FFmode98 = F*mode98==3
gen MMmode98 = M*mode98==4
gen PMmode98 = M*mode98==5
gen PPmode98 = P*mode98==5
gen MPmode98 = P*mode98==4

}


end 
************************************************************************


