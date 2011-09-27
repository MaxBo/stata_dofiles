********** Program zur Generierung von taetigkeit Alter Interaktionen ************
*! version 1.0  06jun2009
program define soep_genvar_oc_age

quietly {
noi di "generiere Interaktionen Alter-Tätigkeit"
dropvars oa_*
gen oa_stud1825=oc_stud*(agem>=18&agem<25)
gen oa_stud2529=oc_stud*(agem>=25&agem<30)
gen oa_appr1825=oc_appr*(agem>=18&agem<25)
gen oa_full1825=oc_full*(agem>=18&agem<25)
gen oa_full2529=oc_full*(agem>=25&agem<30)
gen oa_full5559=oc_full*(agem>=55&agem<60)
gen oa_full6064=oc_full*(agem>=60&agem<65)
gen oa_part1825=oc_part*(agem>=18&agem<25)
gen oa_part2529=oc_part*(agem>=25&agem<30)
gen oa_part5559=oc_part*(agem>=55&agem<60)
gen oa_part6064=oc_part*(agem>=60&agem<65)
}


end
****************************************************************************
