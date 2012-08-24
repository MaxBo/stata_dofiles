********** Program zur Generierung der Variablen f¸r das HH-Pkw/Arbeitsweg 1.Person-Modell ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_VM_Interaktionen

di "bilde Interaktions-Variablen mit Verkehrsmitteln"
quietly {

noi di "generiere Variablen f¸r Reisezeiten/Entfernungen "

*** generiere Variablen f¸r Reisezeiten/Entfernungen ***
gen MPtmiv = (M|P)*tmiv
gen Otov = O*tov
recode Otov (.=0)
gen Rtrad = R*trad
gen Ftfuss = F*tfuss
gen Nkm=N*km
recode Nkm (.=0)

noi di "generiere Variablen f¸r Hauptbesch‰ftigung "

*** generiere Variablen f¸r Hauptbesch‰ftigung und Geschlecht***
*** Referenzkategorie: Nicht-Erwerbst‰tige (insb. Sch¸ler) ***
dropvars o?_* female?
gen oO_Vollzeit = O*taet==1
gen oO_Teilzeit = O*taet==2
gen oO_Azubi = O*taet==3
gen oO_Student = O*taet==4
//gen oO_nErwtaet = O*taet>4 
gen oF_Vollzeit = F*taet==1
gen oF_Teilzeit = F*taet==2
gen oF_Azubi = F*taet==3
gen oF_Student = F*taet==4
//gen oF_nErwtaet = F*taet>4
gen oR_Vollzeit = R*taet==1
gen oR_Teilzeit = R*taet==2
gen oR_Azubi = R*taet==3
gen oR_Student = R*taet==4
//gen oR_nErwtaet = R*taet>4
gen oM_Vollzeit = M*taet==1
gen oM_Teilzeit = M*taet==2
gen oM_Azubi = M*taet==3
gen oM_Student = M*taet==4
//gen oM_nErwtaet = M*taet>4

gen femaleO = O*female
gen femaleR = R*female
gen femaleF = F*female
gen femaleM = M*female

dropvars acO*
noi di "generiere Variablen f¸r ÷V-Zugang"
gen acOtram2 = (tramaccess==2)*O
gen acOmetro2 = (metroaccess==2)*O
gen acOrail2 = (railaccess==2)*O


gen hweitfhsP = (hweitfhs>1)*P*(pkwfrei==1)
label var hweitfhsP "Konkurrenz um letzten Pkw"
//gen Ppkwfrei1 = P*(pkw2_frei==1) //referenz
gen Ppkwfrei2 = P*(pkw2_frei==2)
gen Ppkwfrei3 = P*(pkw2_frei>=3&pkw2_frei<.)
label var Ppkwfrei2 "2 Pkws frei f¸r Personen 234)
label var Ppkwfrei3 "3+ Pkws frei f¸r Personen 234)



*************************************************************************
***** schlieﬂe (quasi) unmˆgliche Alternativen aus dem Choice-Set aus ***
*************************************************************************
noi di "schlieﬂe (quasi) unmˆgliche Alternativen aus dem Choice-Set aus"

gen _sample = (mode5<.)
*** wenn kein F¸hrerschein, dann Nutzung eigenen Autos nicht mˆglich ***
replace _sample = 0 if P & fhs01==0
capture confirm var CO
if !_rc {
	*** kein Auto und eigener Pkw nicht mˆglich ***
	replace _sample = 0 if P & C0
}
*** wenn kein HH-Auto frei, dann Nutzung eigenen Autos nicht mˆglich ***
replace _sample = 0 if P & pkwfrei==0
*** wenn Angabe, dass ÷PNV nicht mˆglich ***
replace _sample = 0 if O & tov==.d
*** wenn Entfernung ¸ber 4 km, dann Fuss nicht mˆglich ***
replace _sample = 0 if F & (km>4&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 20 Minuten, dann Fuss nicht mˆglich ***
replace _sample = 0 if F & (km>=. & (tmiv>=20&tmiv<.))
*** wenn Entfernung ¸ber 25 km, dann Rad nicht mˆglich ***
replace _sample = 0 if R & (km>25&km<.)
*** wenn Entfernung nicht bekannt, aber MIV-Reisezeit mind. 35 Minuten, dann Rad nicht mˆglich ***
replace _sample = 0 if R & (km>=. & (tmiv>=35&tmiv<.))


*** markiere Personen, die wegen Missing Values gar nicht betrachtet werden sollen (_hhmissing=1) ***
// wenn ÷V mˆglich, aber Reisezeit nicht bekannt
bysort persnryear: egen _tovmiss = total (O & tov>=.&_sample==1)

// wenn MIV mˆglich, aber Reisezeit nicht bekannt
bysort persnryear: egen _tmivmiss = total ((M|P) & tmiv>=.&_sample==1)

// wenn Fuss/Rad mˆglich, aber Entfernung nicht bekannt
bysort persnryear: egen _kmmiss = total (N & km>=.&_sample==1)

// wenn Person zu Hause arbeitet (Angaben zur Pendelzeit sind dann nicht sinnvoll auswertbar
bysort persnryear: egen _worksathome = total(commutefreq==1)

// wenn eines dieser Kriterien zutrifft, dann schlieﬂe die ganze Person aus
replace _hhmissing= 1 if _tovmiss|_tmivmiss|_kmmiss|_worksathome

drop _tovmiss _tmivmiss _kmmiss _worksathome
noi di "setze Personen mit fehlenden Angaben zu relevanten Alternativen auf missing"
noi replace _sample = 0 if _hhmissing

}

end

