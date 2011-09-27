clear
odbc load, dsn("Excel-Dateien;DBQ=Y:\INKAR\ROR3.xls") table("ROR$")
format Kennziffer %5s
format Raumeinheit %30s

foreach vn of varlist * {
	label var `vn' `vn'
	}
rename Siedlungsdichte SieDich
rename Haushaltseinkommen HHEink
rename Hochbetagte Einw75
rename Erwerbsquote ErwerbQu
rename Beschäftigtenquote BeschQu
rename Arbeitslosenquote ArblosQu
rename Mehrfamilienhäuser MFamHaus


sum PkwDichte HHEink ArblosQu Einw75 ErwerbQu SieDich MFamHaus ,sep(0) 


reg PkwDichte HHEink ArblosQu MFamHaus

drop moto_resi
predict moto_resi,r
twoway (scatter PkwDichte HHEink, mlabel(Raumeinheit ) mlabsize(tiny))


corr HHEink ArblosQu Einw75 ErwerbQu SieDich MFamHaus 

rename EW Einw
label var Einw "Einwohner"
gen NettoEink = Eink / Einw
label var NettoEink "Netto-Pro-Kopf-Einkommen"
gen Motorisierung = Pkw / (Einw/1000)
label var Motorisierung "Pkw je 1.000 Einwohner"
gen EinwDichte = Einw / ( Siedlungs_V * 100)
label var EinwDichte "Einwohner je ha Siedlungsfläche"
gen BeschDichte = Arbeitsplätze / (Siedlungs_V * 100)
label var BeschDichte "Arbeitsplätze je ha Siedlungsfläche"

gen EinwDichte_Fl = Einw / ( Fläche * 100)
label var EinwDichte_Fl  "Einwohner je ha Gesamtfläche"
gen BeschDichte_Fl  = Arbeitsplätze / (Fläche  * 100)
label var BeschDichte_Fl  "Arbeitsplätze je ha Gesamtfläche"

gen ErwerbsfQuote = Pers_im_erwf_Alter / Einw
label var ErwerbsfQuote "Anteil Personen im erwerbsfähigen Alter an Einwohnern"
gen EWP_Quote = Erwerbspersonen / Einw
label var EWP_Quote "Erwerbspersonen je Einwohner"
gen Hochb_Quote = Hochbetagte / Einw
label var Hochb_Quote "Hochbetagte je Einwohner"
gen ALQuote= Arbeitslose / Erwerbspersonen
gen ALQuote2= Arbeitslose / Pers_im_erwf_Alter
gen UebernQoute = Uebernachtungen / Einw
gen Quo18_25 = EW_18_25 / Einw
gen Quo25_30 = EW_25_30 / Einw
gen Quo30_50 = EW_30_50 / Einw
gen Quo50_65 = EW_50_65 / Einw
gen HHGr = Wohnungen / Einw

reg Moto Netto EinwDichte BeschDichte ALQuote
drop moto_resi
predict moto_resi,r
twoway (scatter moto_resi Motorisierung if abs(moto_resi) >= 25 [fweight = Einw], mlabel(AR_Name) mlabsize(tiny))