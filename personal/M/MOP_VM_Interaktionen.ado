********** Program zur Generierung der Variablen für das HH-Pkw/Arbeitsweg 1.Person-Modell ************
*! version 1.01  20102009
************************************************************************

************************************************************************
program define MOP_VM_Interaktionen

di "bilde Interaktions-Variablen mit Verkehrsmitteln"
quietly {
gen _sample = (mode5<.)

noi di "generiere Variablen für Reisezeiten/Entfernungen "

*** generiere Variablen für Reisezeiten/Entfernungen ***
gen MPtmiv = (M|P)*pMinPkw
gen Otov = O*pMinOV
recode Otov (.=0)
gen Rtrad = R*pMinRad
gen Ftfuss = F*pMinFuss
gen Nkm=N*km
recode Nkm (.=0)

noi di "generiere Variablen für Hauptbeschäftigung "

*** generiere Variablen für Hauptbeschäftigung und Geschlecht***
*** Referenzkategorie: Nicht-Erwerbstätige (insb. Schüler) ***
replace _sample = 0 if BERUF ==3|BERUF==6|BERUF==7
dropvars o?_* FRAU_?
//gen oO_Vollzeit = O*BERUF==1
gen oO_Teilzeit = O*BERUF==2
gen oO_Azubi = O*BERUF==5
gen oO_SchStudent = O*BERUF==4
//gen oO_nErwBERUF = O*BERUF>4 
//gen oF_Vollzeit = F*BERUF==1
gen oF_Teilzeit = F*BERUF==2
gen oF_Azubi = F*BERUF==5
gen oF_SchStudent = F*BERUF==4
//gen oF_nErwBERUF = F*BERUF>4
//gen oR_Vollzeit = R*BERUF==1
gen oR_Teilzeit = R*BERUF==2
gen oR_Azubi = R*BERUF==5
gen oR_SchStudent = R*BERUF==4
//gen oR_nErwBERUF = R*BERUF>4
//gen oM_Vollzeit = M*BERUF==1
gen oM_Teilzeit = M*BERUF==2
gen oM_Azubi = M*BERUF==5
gen oM_SchStudent = M*BERUF==4
//gen oM_nErwBERUF = M*BERUF>4

gen FRAU_O = O*FRAU
gen FRAU_R = R*FRAU
gen FRAU_F = F*FRAU
gen FRAU_M = M*FRAU

dropvars ?Park*
gen PParkSehrSchw = P*(PARKP==1)
gen PParkSchw = P*(PARKP==2)
gen PParkNichtSo = P*(PARKP==3)
gen PParkkA = P*(PARKP>=.)
gen MParkSehrSchw = M*(PARKP==1)
gen MParkSchw = M*(PARKP==2)
gen MParkNichtSo = M*(PARKP==3)
gen MParkkA = M*(PARKP>=.)

dropvars OZu* OAb* Ozufrieden
egen OZuZeit = rowmin (HALTBUSZ  HALTSTRZ HALTUZ HALTSZ HALTZUGZ)
replace OZuZeit = O * OZuZeit
egen OZuSchiene = rowmin( HALTSTRZ HALTUZ HALTSZ HALTZUGZ)
replace OZuSchiene = O * OZuSchiene 
label var OZuZeit "Fussweg Wohnung-Hst"
label var OZuSchiene "Fussweg Wohnung-Bhf"
gen OAbZeit1020 = O * (FUSSMIN==2)
gen OAbZeit20 = O * (FUSSMIN==3)
gen OAbZeitkA = O * (FUSSMIN>=.)
label var OAbZeit1020 "Hst-Arbeit 10-20 Min"
label var OAbZeit20 "Hst-Arbeit 20+ Min"
label var OAbZeitkA "Hst-Arbeit kA"
gen Ozufrieden = (OEFFZU==1)*O


gen hweitfhsP = (hweitfhs>1)*P*(pkwfrei==1)
label var hweitfhsP "Konkurrenz um letzten Pkw"
//gen Ppkwfrei1 = P*(pkw2_frei==1) //referenz
gen Ppkwfrei2 = P*(pkw2_frei==2)
gen Ppkwfrei3 = P*(pkw2_frei>=3&pkw2_frei<.)
label var Ppkwfrei2 "2 Pkws frei für Personen 234)
label var Ppkwfrei3 "3+ Pkws frei für Personen 234)



*************************************************************************
***** schließe (quasi) unmögliche Alternativen aus dem Choice-Set aus ***
*************************************************************************
noi di "schließe (quasi) unmögliche Alternativen aus dem Choice-Set aus"

*** wenn kein Führerschein, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & fhs==0
capture confirm var CO
if !_rc {
	*** kein Auto und eigener Pkw nicht möglich ***
	replace _sample = 0 if P & C0
}
*** wenn kein HH-Auto frei, dann Nutzung eigenen Autos nicht möglich ***
replace _sample = 0 if P & pkwfrei==0
*** wenn Angabe, dass ÖPNV nicht möglich ***
replace _sample = 0 if O & (OEFFER==5)
*** wenn Entfernung über 4 km, dann Fuss nicht möglich ***
replace _sample = 0 if F & (km>4&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 20 Minuten, dann Fuss nicht möglich ***
replace _sample = 0 if F & (km>=. & (pMinPkw>=20&pMinPkw<.))
*** wenn Entfernung über 25 km, dann Rad nicht möglich ***
replace _sample = 0 if R & (km>25&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 35 Minuten, dann Rad nicht möglich ***
replace _sample = 0 if R & (km>=. & (pMinPkw>=35&pMinPkw<.))


*** markiere Personen, die wegen Missing Values gar nicht betrachtet werden sollen (_hhmissing=1) ***
// wenn ÖV möglich, aber Reisezeit nicht bekannt
bysort JAHR ID PERSNR: egen _tovmiss = total (O & pMinOV>=.&_sample==1)

// wenn MIV möglich, aber Reisezeit nicht bekannt
bysort JAHR ID PERSNR: egen _tmivmiss = total ((M|P) & pMinPkw>=.&_sample==1)

// wenn Fuss/Rad möglich, aber Entfernung nicht bekannt
bysort JAHR ID PERSNR: egen _kmmiss = total (N & km>=.&_sample==1)

***// wenn Person zu Hause arbeitet (Angaben zur Pendelzeit sind dann nicht sinnvoll auswertbar
***bysort JAHR ID PERSNR: egen _worksathome = total(commutefreq==1)

// wenn eines dieser Kriterien zutrifft, dann schließe die ganze Person aus
***replace _hhmissing= 1 if _tovmiss|_tmivmiss|_kmmiss|_worksathome
replace _hhmissing= 1 if _tovmiss|_tmivmiss|_kmmiss

dropvars _tovmiss _tmivmiss _kmmiss _worksathome
noi di "setze Personen mit fehlenden Angaben zu relevanten Alternativen auf missing"
noi replace _sample = 0 if _hhmissing

}

end

