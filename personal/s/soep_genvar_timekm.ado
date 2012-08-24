********** Program zur Imputation fehlender Reisezeiten ************
*! version 1.0  06jun2009
program define soep_genvar_timekm

quietly {

rename minbycar tmiv
rename minbypubtr tov
rename kmcommute km
replace km = 0.25 if km==0 // um ln(0)-Probleme zu vermeiden
gen kmln = ln(km)

noi di "schätze fehlende Werte für Reisezeiten"

*** imputiere fehlenden Wert füt tmiv
// wenn nicht angegeben wurde, wie lange man ausschließlich mit Pkw brauchen würde
// dafür aber die Dauer des Arbeitsweges angegeben ist und dass Pkw genutzt wurde
replace tmiv=mincommute if tmiv>=. & mincommute<. & (mode5==4|mode5==5)
// sonst imputiere Reisezeit aus Kilometern
replace tmiv=6 + 0.7*km + 3*kmln if km<. & tmiv>=.
// twoway function y=6 + 0.7*x+ 3*ln(x),range(0 50) xtitle(km) ytitle(min)
*** Geschwindigkeit Radverkehr: 12 km/h, also 5 min/km
gen trad = km*5
*** Geschwindigkeit Fuss: 4 km/h, also 15 min/km
gen tfuss = km*15
gen workathome = commutefreq==1


}

end
****************************************************************************
