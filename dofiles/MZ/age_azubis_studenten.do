use "O:\MZ\Daten\2006\mz2006.dta", clear
recode EF290 (1 2 3 = 1 "BA2") (4 5 = 2 "BA3") (-1=3 "Uni") (6/9 = .a), gen(BA)
replace BA = 3 if BA==.a & EF291 < 4
tab EF44 BA if EF44 <=45 [iw=EF952], col nof nol
