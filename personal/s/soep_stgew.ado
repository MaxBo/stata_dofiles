********** Program zum Setzen des Gewichtungsfaktors ************
*! version 1.0  06jun2009

program define soep_stgew

syntax varlist, Failure(string) Enter(string)

di "setze Gewichtungsfaktor `varlist'2:"
di "= dem L�ngsschnittsgewicht `varlist' des Jahres, in dem das 'Risk Set' beginnt'"
quietly {
//Setze Gewichtungsfaktor f�r Person auf `varlist'2 des Jahres, in dem Person ins "Risk-Set" eintritt
stset agem ,id(persnr) failure(`failure') origin(time 18) enter(`enter') exit(time .)
dropvars `varlist'2 _tt
gen `varlist'2 = `varlist'
//f�lle erstmal das Gewicht den ersten relevanten Jahres bis zur letzten Beobachtung auf 
stfill `varlist'2 ,base
// l�sche dann die alten Gewichte 
replace `varlist'2 = . if _st==0
// und ersetze die ersten Beobachtungen mit dem Gewicht der letzten Zeile
bysort persnr (agem): replace `varlist'2 = `varlist'2[_N] if `varlist'2==.
}

end
