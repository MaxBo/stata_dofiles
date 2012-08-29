* Test zwischen beruflichen und privaten Wegen

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Reisen.dta", clear


gen P101_D = (P101 ==4 | P101 ==5)
label define P101_D 1 `"dienstlich"' 0 `"privat"', modify
label value P101_D P101_D
label variable P101_D "Zweck nach dienstlich / privat"

expand 2

gen P101_DR = P101 ==4
label define P101_DR 1 `"ja"' 0 `"nein"', modify
label value P101_DR P101_DR
label variable P101_DR "Zweck nach Dienstreise"

gen P101_P = P101 ==5
label define P101_P 1 `"ja"' 0 `"nein"', modify
label value P101_P P101_P
label variable P101_P "Pendler"

-------------------------------------------------------------

use "\\Triangel\intern\Datengrundlagen\KiD_MiD_ internerGebrauch\MiD2008\Daten\STATA\STATA_Public Use File\MiD2008_PUF_Reisen.dta", clear
expand 3

gen p101_D = (p101 ==4 | p101 ==5)
label define p101_D 1 `"dienstlich"' 0 `"privat"', modify
label value p101_D p101_D
label variable p101_D "Zweck nach dienstlich / privat"



gen p101_DR = p101 ==4
label define p101_DR 1 `"ja"' 0 `"nein"', modify
label value p101_DR p101_DR
label variable p101_DR "Zweck nach Dienstreise"

gen p101_P = p101 ==5
label define p101_P 1 `"ja"' 0 `"nein"', modify
label value p101_P p101_P
label variable p101_P "Pendler"