********** Program zur Generierung der Variablen-Interaktionen Führerschein-Besitz und Pkw-Besitz und -Nutzung ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define MOP_genvar_FhsPkw

di "generiere Variablen für die Konkurrenz um die Pkw-Nutzung nach HH-Führerschein-Besitz"
quietly {

dropvars C??P C??M

gen C23P= (C2|C3)&P
gen C13M= (C1|C2|C3)&M


dropvars C?Pfhs*

*** Konkurrenz um Pkw ***
gen C1Pfhs2 = hfhs==2 & C1 & P
gen C1Pfhs3 = hfhs==3 & C1 & P
gen C1Pfhs4_ = hfhs>=4&hfhs<. & C1 & P
gen C2Pfhs3 = hfhs==3 & C2 & P
gen C2Pfhs4_ = hfhs>=4&hfhs<. & C2 & P
gen C3Pfhs4_ = hfhs>=4&hfhs<. & C3 & P


}


end 
************************************************************************


