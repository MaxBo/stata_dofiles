********** Program zur Generierung der Variablen-Interaktionen Führerschein-Besitz und Pkw-Besitz ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define MOP_genvar_Fhs

di "generiere Konstanten für Pkw-Besitz nach HH-Führerschein-Besitz"
quietly {
dropvars hfhs*C* 
*** Anzahl Führerscheine im Haushalt: Nicht/sehr schwach besetzte Fälle werden zusammengefasst ***
gen hfhs1C0 = C0*hfhs==1
//gen hfhs1C1 = C1*hfhs==1
gen hfhs1C2 = C2*hfhs==1
gen hfhs2C0 = C0*hfhs==2
//gen hfhs2C1 = C1*hfhs==2
gen hfhs2C2 = C2*hfhs==2
gen hfhs2C3 = C3*hfhs==2
//gen hfhs3C1 = C1*hfhs==3
//gen hfhs3C0 = C0*hfhs==3
gen hfhs3C2 = C2*hfhs==3
gen hfhs3C3 = C3*hfhs==3
//gen hfhs4_C1 = C1*hfhs>=4&hfhs<.
gen hfhs4_C2 = C2*hfhs>=4&hfhs<.
gen hfhs4_C3 = C3*hfhs>=4&hfhs<.

replace _sample=0 if (hfhs>=4&hfhs<.)&C0
replace _sample=0 if (hfhs==0)&(C2|C3)
replace _sample=0 if (hfhs==1)&C3


}


end 
************************************************************************


