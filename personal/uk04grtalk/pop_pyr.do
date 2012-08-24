sysuse pop2000, clear
replace maletotal = -maletotal/1e+6
replace femtotal = femtotal/1e+6
gen zero = 0

#delimit ;
twoway 
bar maletotal agegrp, horizontal xvarlab(Males)   ||
bar  femtotal agegrp, horizontal xvarlab(Females) ||
sc  agegrp zero     , mlabel(agegrp) 
mlabcolor(black) msymbol(i)
xtitle("Population in millions") ytitle("")
plotregion(style(none))
ysca(noline) ylabel(none)
xsca(noline titlegap(-3.5))
xlabel(-12 "12" -10 "10" -8 "8" -6 "6" -4 "4" 4(2)12 
	, tlength(0) 
grid gmin gmax)
legend(order(1 "Males" 2 "Females"))
title("US Male and Female Population by Age, 2000")
note("Source:  U.S. Census Bureau, Census 2000, Tables 1, 2 and 3")
;
#delimit cr

