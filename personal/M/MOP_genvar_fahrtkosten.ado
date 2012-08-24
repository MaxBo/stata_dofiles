********** Program zur Generierung der Fahrtkosten-Variablen ************+
*! version 1.0  06jun2009
program define MOP_genvar_fahrtkosten

di "berechne Fahrtkosten ÖPNV und Pkw"
quietly {
// berechne Kosten einer Fahrt mit Monatskarte: Mindestpreis: 50 ct./Fahrt oder 19€/Monat
gen cozk = 19*2*(.5+.07*km)
label var cozk "Fahrtkosten Zeitkarte"
//twoway function y=2*19*(.5+0.07*(x)),range(0 50) xtitle(km) ytitle(€/Monat) ylabel(0(20)160)

// berechne Kosten einer Fahrt mit Einzelkarte
gen coek = 1.5+0.175*(km-5)
replace coek = 1.5 if coek<1.5
// twoway function y=(x<5)*1.5+(x>=5)*(1.5+0.175*(x-5)),range(0 100) xtitle(km) ytitle(€/Fahrt) ylabel(0(1)20)
label var cozk "Fahrtkosten Einzelkarte"
// berechne Kosten einer Fahrt mit Pkw (1 € Parkgebühr und 10 ct variable Kosten je km)
gen copkw = 19*2*(1+0.10*km)
label var copkw "Fahrtkosten Pkw"

gen varcost = 0
replace varcost = copkw if (M|P)
replace varcost = cozk if O

*****************************************************************************************************
*********************** Sowohl die Fahrtkosten MIV und ÖV sind linear von den km abhängig, ************
*********************** wie auch die Reisezeiten im Fuss- und Radverkehr        **********************
*** Daher ist ein Modell, dass Reisezeiten und -kosten in dieser Form einbezieht, nicht definiert, ****
*** werden die Fahrtkosten nicht auf das Einkommen bezogen, macht eine Einbeziehung daher keinen Sinn   ****
***  Ansonsten sind aber immer noch die großen Messfehler ***
**** und die Kostenwahrnehmung im Berufsverkehr (Pendlerpauschale) zu beachten ****
*********************************************************************************************************

}

end
****************************************************************************
