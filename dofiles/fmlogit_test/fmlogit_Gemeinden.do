use http://fmwww.bc.edu/repec/bocode/c/citybudget.dta, clear
gen ln_tot = ln(tot)
gen ln_tot2 = ln_tot*ln_tot
gen tot2 = tot*tot
fmlogit governing safety education recreation social urbanplanning if tot<50, eta(minorityleft noleft houseval popdens ln_tot ln_tot2 tot2)
estimates store to
replace houseval=1
replace popdens=1
replace noleft=0
replace minorityleft=0
replace tot = _n
replace ln_tot = ln(tot)   if tot<50
replace ln_tot2 = ln_tot*ln_tot   if tot<50
replace tot2 = tot*tot   if tot<50
predict p_safety, pr out(safety)
predict p_education, pr out(education)
predict p_recreation, pr out(recreation)
predict p_social, pr out(social)
predict p_urbanplanning, pr out(urbanplanning)
predict p_governing, pr out( governing)
gen control = p_safety+ p_education+ p_recreation+ p_social+ p_urbanplanning+ p_governing
gen t_safety = p_safety* tot
gen t_education=  p_education* tot
gen t_recreation=  p_recreation* tot
gen t_social=  p_social* tot
gen t_urbanplanning=  p_urbanplanning* tot
gen t_governing=  p_governing* tot
gen e_safety = t_safety - t_safety[_n-1]
gen e_education = t_education - t_education[_n-1]
gen e_recreation = t_recreation - t_recreation[_n-1]
gen e_social = t_social - t_social[_n-1]
gen e_urbanplanning = t_urbanplanning - t_urbanplanning[_n-1]
gen e_governing = t_governing - t_governing[_n-1]
twoway (line p_safety tot, sort) (line p_recreation tot, sort) (line p_education tot, sort) (line p_social tot, sort) (line p_urbanplanning tot, sort) (line p_governing tot, sort)  if tot<50
twoway (line e_safety tot, sort) (line e_recreation tot, sort) (line e_education tot, sort) (line e_social tot, sort) (line e_urbanplanning tot, sort) (line e_governing tot, sort)  if tot<50
