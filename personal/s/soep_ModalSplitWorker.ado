********** Program zur Generierung der Variablen für das reine Arbeitsweg-Verkehrsmittelwahl-Modell ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_ModalSplitWorker

di "generiere eine Zeile je Alternative"
quietly {
*** 5 Zeilen je Person: je Alternative eine Zeile ***
expand 5
bysort hhnrakt year pid: gen _altnum = _n
label val _altnum mode5

gen choice = _altnum==mode5
//gen X = _altnum==0
gen O = _altnum==1
gen R = _altnum==2
gen F = _altnum==3
gen M = _altnum==4
gen P = _altnum==5
gen N = F|R

}
soep_VM_Interaktionen


end 
************************************************************************


