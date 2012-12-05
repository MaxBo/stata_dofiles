use "O:\MZ\Daten\2006\mz2006.dta", clear
bysort EF3 EF8: gen p_in_geb = _n
keep if p_in_geb == 1
tab EF1 EF494 [iw= EF960] if EF635 <= 2, row nof
use "O:\MZ\Daten\2006\mz2006.dta", clear
bysort EF3 EF9: gen p_in_whg = _n
keep if p_in_whg == 1
tab EF491 EF495, mi
