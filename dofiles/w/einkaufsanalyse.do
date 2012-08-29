clear
set memory 700m
use  "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_6n.dta", clear

drop ek_per
gen ek_ana = 1 if Zweck == 3
replace ek_ana = 2 if Zweck ==4
replace ek_ana =3 if Zweck == 4 & W04_DZW==503

label var ek_ana "Analyse der Einkaufswege (3 Klassen)"

label define ek_ana 1 `"periodischer Einkauf"' 2 `"aperiodischer Einkauf"' 3 `"Einkaufsbummel"'
label value ek_ana ek_ana

 
