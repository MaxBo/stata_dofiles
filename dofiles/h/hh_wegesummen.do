clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_HH_attr2.dta", clear


reshape long HPALTER HP_SEX, i(HHID) j(PNR)

rename PNR PID
sort HHID PID


merge HHID PID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_3.dta", sort uniqmaster keep( Anz_Arbeit Anz_zurArbeit Anz_Eink_per Anz_Eink_aper Anz_Eink_b Anz_Eink Anz_Bilden Anz_KiGa Anz_Begl werktag)
duplicates drop

replace Anz_Arbeit=0 if missing(Anz_Arbeit)
replace Anz_Bilden=0 if missing(Anz_Bilden)
replace Anz_Begl=0 if missing(Anz_Begl)
replace Anz_Eink_per=0 if missing(Anz_Eink_per)
replace Anz_Eink_aper=0 if missing(Anz_Eink_aper)
replace Anz_Eink_b=0 if missing(Anz_Eink_b)
replace Anz_Eink=0 if missing(Anz_Eink)
replace Anz_KiGa=0 if missing(Anz_KiGa)
 
rename PID PNR
drop _merge
reshape wide HPALTER HP_SEX Anz_Arbeit Anz_zurArbeit Anz_Eink_per Anz_Eink_aper Anz_Eink_b Anz_Eink Anz_Bilden Anz_KiGa Anz_Begl werktag, i(HHID) j(PNR)



gen Summe_Arbeit=0
gen Summe_Ausb=0
gen Summe_Begl=0
gen Summe_Eink_per=0
gen Summe_Eink_aper=0
gen Summe_Eink_b=0
gen Summe_Eink=0
gen Summe_KiGa=0



label var Summe_Arbeit "Summe der Arbeitswege aller Haushaltsmitglieder"
label var Summe_Ausb "Summe der mit Bilden verbundenen Wege aller Haushaltsmitglieder"
label var Summe_Begl "Summe der Begleitwege aller Haushaltsmitglieder"
label var Summe_Eink "Summe der Einkaufswege aller Haushaltsmitglieder"
label var Summe_Eink_per "Summe der täglichen Einkaufswege aller Haushaltsmitglieder"
label var Summe_Eink_aper "Summe der Großeinkaufswege aller Haushaltsmitglieder"
label var Summe_Eink_b "Summe der Einkaufsbummel aller Haushaltsmitglieder"

forvalues i=1/8 {
	replace Summe_Arbeit = Summe_Arbeit + Anz_Arbeit`i' if Anz_Arbeit`i'>0
	replace Summe_Ausb = Summe_Ausb + Anz_Bilden`i' if Anz_Bilden`i'>0
	replace Summe_Begl = Summe_Begl + Anz_Begl`i' if Anz_Begl`i'>0
	replace Summe_Eink_per = Summe_Eink_per + Anz_Eink_per`i' if Anz_Eink_per`i'>0
	replace Summe_Eink_aper = Summe_Eink_aper + Anz_Eink_aper`i' if Anz_Eink_aper`i'>0
	replace Summe_Eink_b = Summe_Eink_b + Anz_Eink_b`i' if Anz_Eink_b`i'>0
	replace Summe_Eink = Summe_Eink + Anz_Eink`i' if Anz_Eink`i'>0
	replace Summe_KiGa = Summe_KiGa + Anz_KiGa`i' if Anz_KiGa`i'>0
}
