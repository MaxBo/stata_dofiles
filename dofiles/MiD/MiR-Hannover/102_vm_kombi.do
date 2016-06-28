use "O:\MiD-H\MiR-2011\stata\Wege_Raumkategorien_cod.dta", clear
recode WEGKM_K (9000/9999 = .a)
tabstat WEGKM_K [aw=W_GEW], by(VM_KOMBI) stats(N mean median)
tab VM_KOMBI if WEGKM_K > 20 [aw=W_GEW]
tab VM_KOMBI  [aw=W_GEW]

egen kmkl = cut(WEGKM_K), at(0 1 2 3.5 5 7.5 10 15 25 50 100)
tab kmkl HVM, row nof
tab kmkl HVM [iw=W_GEW], row nof
bysort Hann_Umland: tab kmkl HVM [iw=W_GEW], row nof
bysort Hann_Umland: tab kmkl HVM [iw=W_GEW], col nof
bysort Hann_Umland: tab kmkl HVM [iw=W_GEW]
bysort Hann_Umland: tab kmkl HVM
