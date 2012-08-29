clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge2.dta", clear

replace f30_1 = f30 if missing(f30_1) & Jahr==2010

replace f30_aggr2 = 2 if Jahr==2010 & (f30_1==3 | f30_1==4)
replace f30_aggr2 = 4 if Jahr==2010 & (f30_1==5 | f30_1==6 |f30_1==9 | f30_1==10) 

replace f30_aggr2 = 4 if missing(f30_aggr2) & f30_1==9
replace f30_aggr2 = 2 if f30_1==2 & Jahr==2010