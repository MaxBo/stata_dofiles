********** Program zur Generierung der Variablen für das Arbeitsweg 2.-x.Person-Modell ************
* Mobilitätspanel-Daten *
*! version 1.01  19oct2009
************************************************************************

************************************************************************
program define MOP_expandMode

di "generiere eine Zeile je Alternative"
quietly {
*** Interaktion Pkw und Verkehrsmittel Arbeitsweg

*** 20 Zeilen je Person: je Alternative eine Zeile ***
expand 5
bysort ID JAHR pid: gen p = _n

gen choice = p==mode5

gen F = p==1
gen R = p==2
gen O = p==3
gen N = F|R
gen M = p==4
gen P = p==5

gen Pfrei = pkwfrei*P
MOP_VM_Interaktionen

}

end 
************************************************************************


