set more off

* Zuordnung der Raumtypen zur PLZ Dtl.
insheet using "S:\Modell\Daten_Materialien\Strukturdaten\Regionstypen_BBSR\PLZ_Raumtypen.txt", clear

tostring f3a f7a, replace

label define regionstyp 1 "Agglomerationsraum"  2 "Verst�dterte Raum"  3 "L�ndlicher Raum", modify
label value rtyp regionstyp

label define kreistyp 1 "Agglomerationsraum: Kernfl�che" 2 "AR: Hochverdichtete Kreise" 3 "AR: Verdichtete Kreise" 4 "AR: L�ndl. Kreise" /*
*/ 5 "Verst�dterte R�ume: Kernst�dte" 6 "VR: Verdichtet Kreise"  7 "VR: L�ndliche Fl�che"  8 "L�ndl. R�ume: l�ndl. Kreise h�herer Dichte" /* 
*/ 9 "LR: l�ndl. Kreise geringerer Dichte", modify
label value ktyp kreistyp

label define gemeindetyp 1 "Agglomerationsraum Kernstadt > 500.00 EW" 2 "AR Kernstadt < 500.00 EW" 3 "AR Hochverdichtete Kreise: Ober-Mittelzentren" 4 "AR Hochverdichtete Kreise: sonstige Gemeinden" /* 
*/ 5 "AR Verdichtete Kreise: Ober-Mittelzentren" 6 "AR Verdichtete Kreise: sonstige Gemeinden" 7 "AR L�ndliche Kreise: Ober-Mittelzentren" 8 "AR L�ndliche Kreise: sonstige Gemeinden" /*
*/ 9 "Verst�dterte R�ume: Kernst�dte"   10 "VR Verdichtete Kreise: Ober-Mittelzentren" 11 "VR Verdichtete Kreise: sonstige Gemeinden" 12 "VR L�ndliche Kreise: Ober-Mittelzentren"  /* 
*/ 13 "VR L�ndliche Kreise: sonstige Gemeinden" 14 "L�ndliche R�ume L�ndliche Kreise h�herer Dichte: Ober-Mittelzentren" 15 "LR L�ndliche Kreise h�herer Dichte: sonstige Gemeinden" /* 
*/ 16 "LR L�ndliche Kreise geringer Dichte: Ober-Mittelzentren" 17 "LR L�ndliche Kreise geringer Dichte: sonstige Gemeinden", modify
label value biktyp gemeindetyp

label var rtyp "Regionstyp (3)"
label var ktyp "Kreistyp (9)"
label var biktyp "BIK 17 Raumregionen"


save "S:\Modell\Daten_Materialien\Strukturdaten\Regionstypen_BBSR\PLZ_Raumtypen.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_merge2.dta" , clear

* Definition einer Auslandsvariablen
gen f5 = f5_2
replace f5 = 1  if missing(f5_2)
label value f5 Ausland

gen f8 = f8_2
replace f8 = 1  if missing(f8_2)
label value f8 Ausland

* PLZ-Korrektur
	replace f3a  = "0"+"1129" if f3a == "1129" & f5==1
	replace f3a  = "0"+"1159" if f3a == "1159" & f5==1
	replace f3a  = "0"+"1187" if f3a == "1187" & f5==1
	replace f3a  = "1589"+"0" if f3a == "1589" & f5==1
	replace f3a  = "0"+"1728" if f3a == "1728" & f5==1
	replace f3a  = "0"+"1979" if f3a == "1979" & f5==1
	replace f3a  = "0"+"2826" if f3a == "2826" & f5==1
	replace f3a  = "0"+"3099" if f3a == "3099" & f5==1
	replace f3a  = "0"+"4910" if f3a == "4910" & f5==1
	replace f3a  = "0"+"7749" if f3a == "7749" & f5==1

	replace f7a  = "0"+"1129" if f7a == "1129" & f8==1
	replace f7a  = "0"+"1159" if f7a == "1159" & f8==1
	replace f7a  = "0"+"1187" if f7a == "1187" & f8==1
	replace f7a  = "1589"+"0" if f7a == "1589" & f8==1
	replace f7a  = "0"+"1728" if f7a == "1728" & f8==1
	replace f7a  = "0"+"1979" if f7a == "1979" & f8==1
	replace f7a  = "0"+"2826" if f7a == "2826" & f8==1
	replace f7a  = "0"+"3099" if f7a == "3099" & f8==1
	replace f7a  = "0"+"4910" if f7a == "4910" & f8==1
	replace f7a  = "0"+"7749" if f7a == "7749" & f8==1

	

merge m:m f5 f3a using "S:\Modell\Daten_Materialien\Strukturdaten\Regionstypen_BBSR\PLZ_Raumtypen.dta", keepusing(rtyp ktyp biktyp) gen(raum_start)	

foreach i in "rtyp" "ktyp" "biktyp" {
	rename `i'  `i'_start	
}

merge m:m f8 f7a using "S:\Modell\Daten_Materialien\Strukturdaten\Regionstypen_BBSR\PLZ_Raumtypen.dta", keepusing(rtyp ktyp biktyp) gen(raum_wohn)	

foreach i in "rtyp" "ktyp" "biktyp" {
	rename `i'  `i'_wohn	
}

drop if missing(Jahr)

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10_raum.dta" , replace





 
 

