********** Program zur Generierung der Alters-Gruppen 18/19 ************+
*! version 1.0  21jun2009
program define soep_numfailures

quietly {
noi di "subjects with (multiples) failures:"
dropvars nf
stgen nf = nfailures()
replace nf=nf+1
noi tab nf if _d==1
dropvars nachabgabe
gen nachabgabe = nf>1&nf<.
drop nf
}

end
****************************************************************************
