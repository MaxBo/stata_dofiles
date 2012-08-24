********** Program zur Generierung der Dummy-Variablen für Jahre ************+
*! version 1.0  27oct2009
program define MOP_genvar_year

quietly {

noi di "generiere Dummy-Variablen für Erhebungswellen"
/* ist gegenüber 2004 nicht signifikant - keine Trends ablesbar*/

gen C02005 = C0*JAHR==2005
gen C02006 = C0*JAHR==2006
gen C02007 = C0*JAHR==2007
gen C22005 = C2*JAHR==2005
gen C22006 = C2*JAHR==2006
gen C22007 = C2*JAHR==2007
gen C32005 = C3*JAHR==2005
gen C32006 = C3*JAHR==2006
gen C32007 = C3*JAHR==2007



}

end
****************************************************************************
