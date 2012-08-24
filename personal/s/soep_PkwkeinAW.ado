********** Program zur Generierung der Variablen für das HH-Pkw-Modell in Haushalten ohne Arbeitsweg************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_PkwkeinAW

di "generiere eine Zeile je Alternative"
quietly {

*** 3 Zeilen je Person: je Alternative eine Zeile ***
expand 3
bysort hhnrakt year pid: gen c=_n-1
gen choice = hpkw012==c

gen C0 = c==0
gen C1 = c==1
gen C2 = c==2
// C3 anlegen, damit keine Fehlermeldungen beim ereugen der Interaktionsterme entstehen
gen C3 = 0

*** behalte nur Haushalte ohne Arbeits-/Ausbildungsweg (nur Nicht-Erwerbstätige/Arbeitslose)***
bysort hhnrakt year (pid): keep if mode5[1]==.z & (taet==5|taet==6)
}

end 
************************************************************************


