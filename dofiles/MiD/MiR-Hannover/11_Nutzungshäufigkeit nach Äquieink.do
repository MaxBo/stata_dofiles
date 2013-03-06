use "O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod.dta", clear

set mem 800m
set more off


****Nutzungshäufigkeit nach Äquivalenzeinkommen***

***unter 1000 Euro***
tab Autonutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 1  [iw = P_GEW], col nof

***1000 bis 1500 Euro****
tab Autonutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof

*** 1500 bis 2000 Euro****
tab Autonutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof

***über 2000 Euro****
tab Autonutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof
tab Autonutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof




***unter 1000 Euro***
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof

***1000 bis 1500 Euro****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof

*** 1500 bis 2000 Euro****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof

***über 2000 Euro****
tab Fahrradnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof
tab Fahrradnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof



***unter 1000 Euro***
tab Bahnnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof

***1000 bis 1500 Euro****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof

*** 1500 bis 2000 Euro****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof

***über 2000 Euro****
tab Bahnnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof
tab Bahnnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof



***unter 1000 Euro***
tab Fußnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 1 [iw = P_GEW], col nof

***1000 bis 1500 Euro****
tab Fußnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 2 [iw = P_GEW], col nof

*** 1500 bis 2000 Euro****
tab Fußnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 3 [iw = P_GEW], col nof

***über 2000 Euro****
tab Fußnutzung  Regins if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof
tab Fußnutzung Hann_Umland if HP_ALTER >= 14 & hheink_aeq4 == 4 [iw = P_GEW], col nof


***2002***
use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear

set mem 800m
set more off

****Nutzungshäufigkeit nach Äquivalenzeinkommen***

***unter 00 Euro***
tab Autonutzung  Regins if palter >= 14 & hheink_aeq4 == 1 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 1 [iw = gew_pa], col nof

***1000 bis 1500 Euro****
tab Autonutzung  Regins if palter >= 14 & hheink_aeq4 == 2 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 2 [iw = gew_pa], col nof

***1500 bis 2000 Euro****
tab Autonutzung  Regins if palter >= 14 & hheink_aeq4 == 3 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 3 [iw = gew_pa], col nof

***über 2000 Euro****
tab Autonutzung  Regins if palter >= 14 & hheink_aeq4 == 4 [iw = gew_pa], col nof
tab Autonutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 4 [iw = gew_pa], col nof


***unter 1000 Euro***
tab Fahrradnutzung  Regins if palter >= 14 & hheink_aeq4 == 1 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 1 [iw = gew_pa], col nof

***1000 bis 1500 Euro****
tab Fahrradnutzung  Regins if palter >= 14 & hheink_aeq4 == 2 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 2 [iw = gew_pa], col nof

***1500 bis 2000 Euro****
tab Fahrradnutzung  Regins if palter >= 14 & hheink_aeq4 == 3 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 3 [iw = gew_pa], col nof

***über 2000 Euro****
tab Fahrradnutzung  Regins if palter >= 14 & hheink_aeq4 == 4 [iw = gew_pa], col nof
tab Fahrradnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 4 [iw = gew_pa], col nof



***unter 1000 Euro***
tab Bahnnutzung  Regins if palter >= 14 & hheink_aeq4 == 1 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 1 [iw = gew_pa], col nof

***1000 bis 1500 Euro****
tab Bahnnutzung  Regins if palter >= 14 & hheink_aeq4 == 2 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 2 [iw = gew_pa], col nof

***1500 bis 2000 Euro****
tab Bahnnutzung  Regins if palter >= 14 & hheink_aeq4 == 3 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 3 [iw = gew_pa], col nof

***über 2000 Euro****
tab Bahnnutzung  Regins if palter >= 14 & hheink_aeq4 == 4 [iw = gew_pa], col nof
tab Bahnnutzung Hann_Umland if palter >= 14 & hheink_aeq4 == 4 [iw = gew_pa], col nof
