gen grund_aggr = 3
replace grund_aggr = 2 if P101 ==4
replace grund_aggr = 1 if P101 <= 2
label define grund_aggr 1 `"leisure"' 2 `"business"' 3 `"other"', modify
label value grund_aggr grund_aggr



gen grund_aggr = 3
replace grund_aggr = 2 if reisegrund_hrg ==1
replace grund_aggr = 1 if reisegrund_hrg == 3 | reisegrund_hrg == 4
label define grund_aggr 1 `"leisure"' 2 `"business"' 3 `"other"', modify
label value grund_aggr grund_aggr






gen vm_aggr = 4
replace vm_aggr = 3 if  HVM_R ==4
replace vm_aggr = 2 if  HVM_R ==2
replace vm_aggr = 1 if  HVM_R ==1
label define vm_aggr 1 `"car"' 2 `"rail"' 3 `"airplane"' 4 `"other"', modify
label value vm_aggr vm_aggr