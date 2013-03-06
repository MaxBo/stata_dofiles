use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear

set mem 800m
set more off

***Einkauf***

***t�glicher Bedarf***
tab HVM Hann_Umland if W04_DZW == 501 & HWZWECK == 4 [iw=W_GEW], col nof

**** gr��ere Anschaffungen***
tab HVM Hann_Umland if W04_DZW == 502  [iw=W_GEW], col nof


***Einkauf nach Wegel�nge***
***t�glicher Bedarf***
tab WegekmKl Hann_Umland if W04_DZW == 501 [iw=W_GEW], col nof

**** gr��ere Anschaffungen***
tab WegekmKl Hann_Umland if W04_DZW == 502 [iw=W_GEW], col nof

***Einkaufen insgesamt****
tab WegekmKl Hann_Umland if HWZWECK == 4  [iw=W_GEW], col nof

***Einkauf nach Personengruppen
***t�glicher Bedarf***
tab PERGRUP_AUS Hann_Umland if W04_DZW == 501 [iw=W_GEW], col nof

**** gr��ere Anschaffungen***
tab PERGRUP_AUS Hann_Umland if W04_DZW == 502 [iw=W_GEW], col nof

***Einkaufen insgesamt****
tab PERGRUP_AUS Hann_Umland if HWZWECK == 4 [iw=W_GEW], col nof


***Durchschnittliche Wegel�ngen nach t�glicher bedarf***
tabstat WEGKM_D_R W04_DZW if W04_DZW == 501
tabstat WEGKM_D_R W04_DZW Hann_Umland if W04_DZW == 501 & Hann_Umland == 1
tabstat WEGKM_D_R W04_DZW Hann_Umland if W04_DZW == 501 & Hann_Umland == 2

***Durchschnittliche Wegel�ngen nach sonstige Anschaffungen***
tabstat WEGKM_D_R W04_DZW if W04_DZW == 502 
tabstat WEGKM_D_R W04_DZW Hann_Umland if W04_DZW == 502 & Hann_Umland == 1
tabstat WEGKM_D_R W04_DZW Hann_Umland if W04_DZW == 502 & Hann_Umland == 2

***Durchschnittliche Wegel�ngen nach Einkauf insgesamt***
tabstat WEGKM_D_R HWZWECK if HWZWECK == 4
tabstat WEGKM_D_R HWZWECK Hann_Umland if HWZWECK == 4 & Hann_Umland == 1
tabstat WEGKM_D_R HWZWECK Hann_Umland if HWZWECK == 4 & Hann_Umland == 2



use "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta", clear

set mem 800m
set more off

***Einkauf***

***t�glicher Bedarf***
tab Verkm5 Hann_Umland if w041 == 501 & Verkm5 !=-9 [iw=gew_pa], col nof

**** gr��ere Anschaffungen***
tab Verkm5 Hann_Umland if w041 == 502  & Verkm5 !=-9 [iw=gew_pa], col nof


***Einkauf nach Wegel�nge***
***t�glicher Bedarf***
tab WegekmKl Hann_Umland if w041 == 501 [iw=gew_pa], col nof

**** gr��ere Anschaffungen***
tab WegekmKl Hann_Umland if w041 == 502 [iw=gew_pa], col nof

***Einkaufen insgesamt****
tab WegekmKl Hann_Umland if hpzweck == 6 [iw=gew_pa], col nof


***Einkauf nach Personengruppen
***t�glicher Bedarf***
tab PERGRUP_AUS Hann_Umland if w041 == 501 [iw=gew_pa], col nof

**** gr��ere Anschaffungen***
tab PERGRUP_AUS Hann_Umland if w041 == 502 [iw=gew_pa], col nof

***Einkaufen insgesamt****
tab PERGRUP_AUS Hann_Umland if hpzweck == 6 [iw=gew_pa], col nof



***Durchschnittliche Wegel�ngen nach t�glicher bedarf***
tabstat WEGKM_D_R w041 if w041 == 501
tabstat WEGKM_D_R w041 Hann_Umland if w041 == 501 & Hann_Umland == 1
tabstat WEGKM_D_R w041 Hann_Umland if w041 == 501 & Hann_Umland == 2

***Durchschnittliche Wegel�ngen nach sonstige Anschaffungen***
tabstat WEGKM_D_R w041 if w041 == 502
tabstat WEGKM_D_R w041 Hann_Umland if w041 == 502 & Hann_Umland == 1
tabstat WEGKM_D_R w041 Hann_Umland if w041 == 502 & Hann_Umland == 2

***Durchschnittliche Wegel�ngen nach Einkauf insgesamt***
tabstat WEGKM_D_R hpzweck if hpzweck == 6
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 6 & Hann_Umland == 1
tabstat WEGKM_D_R hpzweck Hann_Umland if hpzweck == 6 & Hann_Umland == 2
