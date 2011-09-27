odbc load, dsn("Excel-Dateien;DBQ=Y:\INKAR\Analyseregionen.xls") table("AR_Abs$")
label var EW "Einwohner"
gen NettoEink = Eink / EW
label var NettoEink "Netto-Pro-Kopf-Einkommen"
gen Motorisierung = Pkw / (EW*1000)
label var Motorisierung "Pkw je 1.000 Einwohner"
gen EWDichte = EW / ( Siedlungs_V * 100)
label var EWDichte "Einwohner je ha"
gen EWDichte_2 = EWDichte ^2
gen BeschDichte = Arbeitsplätze / (Siedlungs_V * 100)
label var BeschDichte "Arbeitsplätze je ha"
gen ErwerbsfQuote = Pers_im_erwf_Alter / EW
label var ErwerbsfQuote "Anteil Personen im erwerbsfähigen Alter an Einwohnern"
gen EWP_Quote = Erwerbspersonen / EW
label var EWP_Quote "Erwerbspersonen je Einwohner"
gen Hochb_Quote = Hochbetagte / EW
label var Hochb_Quote "Hochbetagte je Einwohner"
gen ALQuote= Arbeitslose / Erwerbspersonen
gen UebernQoute = Uebernachtungen / EW
reg Moto EWDichte ALQuote [pw = EW]
drop moto_resi
predict moto_resi,r
twoway (scatter moto_resi Motorisierung if abs(moto_resi) >= 25 [fweight = EW], mlabel(AR_Name) mlabsize(tiny))