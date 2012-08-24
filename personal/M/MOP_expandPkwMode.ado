********** Program zur Generierung der Variablen für das HH-Pkw/Arbeitsweg 1.Person-Modell ************
* Mobilitätspanel-Daten *
*! version 1.01  19oct2009
************************************************************************

************************************************************************
program define MOP_expandPkwMode

di "generiere eine Zeile je Alternative"
quietly {
*** Interaktion Pkw und Verkehrsmittel Arbeitsweg
gen hhpkwmode = hpkw03*10+mode5

foreach c of numlist 0/3 {
	label define hhpkwmode  `c'1 "C`c'F"  `c'2 "C`c'R"  `c'3 "C`c'O"  `c'4 "C`c'M" `c'5 "C`c'P",add
}
label values hhpkwmode hhpkwmode 
*** 20 Zeilen je Person: je Alternative eine Zeile ***
expand 20
gen _altnum=0
bysort ID JAHR: gen c = int((_n-1)/5)
bysort ID JAHR: gen p = mod((_n-1),5)+1
replace _altnum=c*10+p
label values _altnum hhpkwmode

gen choice = _altnum==hhpkwmode

gen F = p==1
gen R = p==2
gen O = p==3
gen N = F|R
gen M = p==4
gen P = p==5
gen C0 = c==0
gen C1 = c==1
gen C2 = c==2
gen C3 = c==3

gen Pfrei = pkwfrei*P
MOP_VM_Interaktionen

}

end 
************************************************************************


