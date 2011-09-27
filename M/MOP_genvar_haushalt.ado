********** Program zur Generierung der Interaktionen Haushalts-Merkmale mit Zahl der Pkw ************
*! version 1.01  20oct2009
************************************************************************

************************************************************************
program define MOP_genvar_haushalt

di "generiere Interaktionen der Haushalts-Variablen mit Pkw-Besitz"
quietly {
**Kinder: Nur Einfluss auf Erstwagen, auf Zweitwagen keinen Einfluss
** Ein oder mehr Kinder: Koeffizienten sind nicht signifikant verschieden **
// gen C0kid1 = C0*(kid1)
// gen C0kid2 = C0*(kid2)
gen C0KIND = C0*(KIND)
gen C23KIND = (C2|C3)*(KIND)

recode hfhs (1=0) (2 3=1),gen(hfhs2)
label var hfhs2 "2 Führerscheine in HH"
gen female1fhs = FRAU * (hfhs2==0)
label var female1fhs "Frau, 1 Fhs im HH"
gen alter15ln = ln(alter-15)
gen alter_fem1fhs = alter * female1fhs 
gen altersq = alter^2
gen altersq_fem1fhs = altersq * female1fhs 
gen alter15ln_fem1fhs = alter15ln * female1fhs 

gen C0alter = alter*C0
gen C0alter15ln = alter15ln*C0
gen C2alter = alter*C2
gen C2alter15ln = alter15ln*C2
gen C0femalefhs = female1fhs *C0
gen C0alter_fem1fhs = alter_fem1fhs*C0
gen C0alter15ln_fem1fhs = alter15ln_fem1fhs*C0

}


end 
************************************************************************


