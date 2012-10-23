
// zusammenlebende in Lebensform
use "O:\MZ\Daten\2006\mz2006.dta", clear
bysort EF3 EF4 EF27: egen anz_pers_lf = count(1)
bysort EF3 EF4 EF27: gen n_lf = _n
bysort EF3 EF4 EF27: egen anz_verhzl_lf = total(EF765==2 | EF765 == 6)
tab anz_pers_lf anz_verhzl_lf if anz_pers_lf<8, row nof
bysort EF770: tab anz_pers_lf anz_verhzl_lf if anz_pers_lf<8, row

// zl: verheiratet und zusammenlebend
gen zl = EF765==2
// Anzahl der Kinder in der Lebensform
recode EF770 (2/9=2), gen(anz_ki_lf)

// Frauen in Lebensformen mit Partner: Anteil der verheirateten Frauen nach Alter
bysort anz_ki_lf: tab EF44 zl if EF762==2 & EF46 == 2 [iw=EF952], row nof

