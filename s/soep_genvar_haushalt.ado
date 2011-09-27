********** Program zur Generierung der Interaktionen Haushalts-Merkmale mit Zahl der Pkw ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_genvar_haushalt

di "generiere Interaktionen der Haushalts-Variablen mit Pkw-Besitz"
quietly {
**Kinder: Nur Einfluss auf Erstwagen, auf Zweitwagen keinen Einfluss
** Ein oder mehr Kinder: Koeffizienten sind nicht signifikant verschieden **
// gen C0kid1 = C0*(kid1)
// gen C0kid2 = C0*(kid2)
gen C0kid = C0*(kid1|kid2)
gen C23kid = (C2|C3)*(kid1|kid2)

recode hfhs (1=0) (2 3=1),gen(hfhs2)
label var hfhs2 "2 Führerscheine in HH"
gen female1fhs = female * (hfhs2==0)
label var female1fhs "Frau, 1 Fhs im HH"
gen age15ln = ln(age-15)
gen age_fem1fhs = age * female1fhs 
gen agesq_fem1fhs = agesq * female1fhs 
gen age15ln_fem1fhs = age15ln * female1fhs 

gen C0age = age*C0
gen C0age15ln = age15ln*C0
gen C2age = age*C2
gen C2age15ln = age15ln*C2
gen C0femalefhs = female1fhs *C0
gen C0age_fem1fhs = age_fem1fhs*C0
gen C0age15ln_fem1fhs = age15ln_fem1fhs*C0

}


end 
************************************************************************


