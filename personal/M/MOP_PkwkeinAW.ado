********** Program zur Generierung der Variablen für das HH-Pkw-Modell in Haushalten ohne Arbeitsweg************
*! version 1.01  01nov2009
************************************************************************

************************************************************************
program define MOP_PkwkeinAW

di "generiere eine Zeile je Alternative"
quietly {

*** 3 Zeilen je Person: je Alternative eine Zeile ***
expand 3
bysort ID JAHR pid: gen c=_n-1
gen choice = hpkw02==c

gen C0 = c==0
gen C1 = c==1
gen C2 = c==2
// C3 anlegen, damit keine Fehlermeldungen beim ereugen der Interaktionsterme entstehen
gen C3 = 0

*** behalte nur Haushalte ohne Arbeits-/Ausbildungsweg (nur Nicht-Erwerbstätige/Arbeitslose)***
bysort ID JAHR (pid): keep if (mode5[1]==.x|mode5[1]==.z) & (BERUF==3|BERUF==6|BERUF==7)
}

end 
************************************************************************


