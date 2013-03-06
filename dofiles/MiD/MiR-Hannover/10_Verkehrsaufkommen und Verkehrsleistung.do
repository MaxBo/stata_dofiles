use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod_neu.dta", clear
set mem 800m
set more off


***Verkehrsaufkommen nach Verkehrsmitteln (Anzahl der Wege)***

***Region insgesamt**
tab WID [iw=W_HOCH]
tab WID if HVM == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HVM == 2 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HVM == 3 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HVM == 4 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HVM == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]

***Stadt Hannover***
tab WID if REGION == 1 [iw=W_HOCH]
tab WID if REGION == 1 & HVM == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if REGION == 1 & HVM == 2 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if REGION == 1 & HVM == 3 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if REGION == 1 & HVM == 4 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if REGION == 1 & HVM == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]

***Umland***
tab WID if Hann_Umland == 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HVM == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HVM == 2 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HVM == 3 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HVM == 4 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HVM == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]



***Verkehrsaufkommen nach Wegezweck***
***Region insgesamt**
tab WID if HWZWECK == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HWZWECK == 3 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HWZWECK == 4 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HWZWECK == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HWZWECK == 6 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if HWZWECK == 7 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]

***Stadt Hannover***
tab WID if Hann_Umland == 1 & HWZWECK == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 1 & HWZWECK == 3 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 1 & HWZWECK == 4 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 1 & HWZWECK == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 1 & HWZWECK == 6 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 1 & HWZWECK == 7 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]

***Umland***
tab WID if Hann_Umland == 2 & HWZWECK == 1 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HWZWECK == 3 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HWZWECK == 4 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HWZWECK == 5 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HWZWECK == 6 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]
tab WID if Hann_Umland == 2 & HWZWECK == 7 & WEGKM_K <=100 & HWZWECK != 2 [iw=W_HOCH]




***Verkehrsleistung zurückgelegte Kilometer, Angaben in Mio. Personenkilometer pro Tag***
use "O:\MiD-H\MIR-2011\stata\Personen_Wege.dta", clear

***Fahrleistung berechnen***

gen Fahrleistung = P_HOCH*(WEGKM_D_R)


***Verkehrsleistung Modal Split***
***für Verkehrsleistung [iw=Fahrleistung]***

tab HVM Regins if HWZWECK != 2 [iw=Fahrleistung], col
tab HVM Hann_Umland if HWZWECK != 2 [iw=Fahrleistung], col


***Verkehrsleistung nach Wegezweck
tab HWZWECK Hann_Umland if HWZWECK != 2 [iw=Fahrleistung], col
tab HWZWECK Regins if HWZWECK != 2 [iw=Fahrleistung], col

***Verkehrsleistung nach Personengruppe

tab PERGRUP_NEU Hann_Umland if HWZWECK != 2 [iw=Fahrleistung], col
tab PERGRUP_NEU Regins if HWZWECK != 2 [iw=Fahrleistung], col


***Verkehrsleistung nach Personengruppe_Auswertung

tab PERGRUP_AUS Hann_Umland if HWZWECK != 2  [iw=Fahrleistung], col
tab PERGRUP_AUS Regins if HWZWECK != 2 [iw=Fahrleistung], col

***Verkehrsleistung nach Äquivalenzeinkommen

tab hheink_aeq4 Hann_Umland if HWZWECK != 2 [iw=Fahrleistung], col
tab hheink_aeq4 Regins if HWZWECK != 2 [iw=Fahrleistung], col


save "O:\MiD-H\MIR-2011\stata\Personen_Wege.dta", replace


***Verkehrsaufkommen und Verkehrsleistung 2002****
use "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", clear
set mem 800m
set more off

***Hochrechnungsfaktor für 2002 nicht verfügbar!
***Muss zunächst berechnet werden

***Hochrechnungsfaktor = Einwohner/Befragte * gew_pa

gen P_HOCH = 1125878/10514*gew_pa


sort caseid pid
save "O:\MiD-H\MiR2002\Stata\P_REGION2.dta", replace

merge  caseid pid using "O:\MiD-H\MiR2002\Stata\Wege_Raumkategorien_neu.dta"

recode w08 (9000/99999 = .a) (100/9000 = .b)


gen Fahrleistung = P_HOCH*w08

save "O:\MiD-H\MiR2002\Stata\Personen_Wege_Raumkategorien.dta", replace

use "O:\MiD-H\MiR2002\Stata\Personen_Wege_Raumkategorien.dta", clear


tab Verkm5 Regins if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col
tab Verkm5 Hann_Umland if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col

***Verkehrsleistung nach Wegezweck
tab hpzweck Regins if Verkm5 != -9 & hpzweck != 3 & hpzweck !=8 [iw=Fahrleistung], col
tab hpzweck Hann_Umland if Verkm5 != -9 & hpzweck != 3 & hpzweck !=8 [iw=Fahrleistung], col

***Verkehrsleistung nach Personengruppe
tab PERGRUP_NEU Regins if Verkm5 != -9 & hpzweck != 3  [iw=Fahrleistung], col
tab PERGRUP_NEU Hann_Umland if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col

***Verkehrsleistung nach Personengruppe_Auswertung
tab PERGRUP_AUS Regins if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col
tab PERGRUP_AUS Hann_Umland if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col

***Verkehrsleistung nach Äquivalenzeinkommen
tab hheink_aeq4 Regins if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col
tab hheink_aeq4 Hann_Umland if Verkm5 != -9 & hpzweck != 3 [iw=Fahrleistung], col


save "O:\MiD-H\MiR2002\Stata\Personen_Wege_Raumkategorien.dta", replace


**Verkehrsaufkommen
use "O:\MiD-H\MiR2002\Stata\W_HOCH_WEGEDATENSATZ.dta", clear


***Region insgesamt**
tab weg [iw=P_HOCH]
tab weg if Verkm5 == 1 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Verkm5 == 2 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Verkm5 == 3 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Verkm5 == 4 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Verkm5 == 5 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]


***Stadt Hannover***
tab weg if Hann_Umland == 1 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & Verkm5 == 1 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & Verkm5 == 2 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & Verkm5 == 3 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & Verkm5 == 4 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & Verkm5 == 5 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]

***Umland***
tab weg if Hann_Umland == 2  [iw=P_HOCH]
tab weg if Hann_Umland == 2 & Verkm5 == 1 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & Verkm5 == 2 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & Verkm5 == 3 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & Verkm5 == 4 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & Verkm5 == 5 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]

***Verkehrsaufkommen nach Wegezweck**
***Region insgesamt**

tab weg if hpzweck == 1 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if hpzweck == 2 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if hpzweck == 4 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if hpzweck == 5 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if hpzweck == 6 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if hpzweck == 7 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]


***Stadt Hannover***
tab weg if Hann_Umland == 1 & hpzweck == 1 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & hpzweck == 2 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & hpzweck == 4 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & hpzweck == 5 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & hpzweck == 6 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 1 & hpzweck == 7 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]

***Umland***

tab weg if Hann_Umland == 2 & hpzweck == 1 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & hpzweck == 2 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & hpzweck == 4 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & hpzweck == 5 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & hpzweck == 6 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
tab weg if Hann_Umland == 2 & hpzweck == 7 & w08 <=100 & hpzweck != 3 [iw=P_HOCH]
