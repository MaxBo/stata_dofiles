********** Program zur Generierung der  Variablen zur Zugangszeit ************
*! version 1.01  01112009
************************************************************************

************************************************************************
program define MOP_genvar_ZuZeit

di "generiere Variablen zur Zugangszeit"
quietly {
dropvars _ZUZEIT _ZUSCHIENE C?Zu* C*Sch* 
egen _ZUZEIT = rowmin (HALTBUSZ  HALTSTRZ HALTUZ HALTSZ HALTZUGZ)
egen _ZUSCHIENE = rowmin( HALTSTRZ HALTUZ HALTSZ HALTZUGZ)
gen C0ZuZeit = _ZUZEIT*C0
gen C23ZuZeit = _ZUZEIT*C2
gen C0Sch05 = (_ZUSCHIENE<=5)*C0
gen C23Sch05 = (_ZUSCHIENE<=5)*C2
gen C0Sch0510 = (_ZUSCHIENE>5 & _ZUSCHIENE<=10)*C0
gen C23Sch0510 = (_ZUSCHIENE>5 & _ZUSCHIENE<=10)*(C2|C3)
gen C0Sch1015 = (_ZUSCHIENE>10 & _ZUSCHIENE<=15)*C0
gen C23Sch1015 = (_ZUSCHIENE>10 & _ZUSCHIENE<=15)*(C2|C3)
gen C0Sch1520 = (_ZUSCHIENE>15 & _ZUSCHIENE<=20)*C0
gen C23Sch1520 = (_ZUSCHIENE>15 & _ZUSCHIENE<=20)*(C2|C3)
gen C0Sch2030 = (_ZUSCHIENE>20 & _ZUSCHIENE<=30)*C0
gen C23Sch2030 = (_ZUSCHIENE>20 & _ZUSCHIENE<=30)*(C2|C3)

gen C2ZuSchiene = _ZUSCHIENE*C2
gen C3ZuSchiene = _ZUSCHIENE*C3


}


end 
************************************************************************


