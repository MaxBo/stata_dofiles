********** Program zum Umcodieren der Personen-Daten ************
*! version 1.01  10oct2009
************************************************************************

************************************************************************
program MOP_recodeP

di "codiere Personen-Daten um"
quietly {


recode AUSFUELLER (9=0)
label define AUSFUELLER 0 "Jemand anderes füllt aus",modify

recode SEX (2=1) (1=0) (9=.a), gen(FRAU)
label var FRAU "Frau/Mann"
label define FRAU 0 "Mann" 1 "Frau" .a "keine Angabe"
label values FRAU FRAU

recode MOBEINSCHR WECHSARB ZEITOPNV BAHNCARD MOPED FAHRRAD (2=0) (-8=.a)
label define MOBEINSCHR 0 "Nein" .a "keine Anagabe",modify
label define WECHSARB 0 "nicht gewechselt",modify
label define ZEITOPNV 0 "Nein",modify
label define BAHNCARD 0 "Nein",modify
label define MOPED 0 "Nein",modify
label define FAHRRAD 0 "Nein",modify

recode  FUSSMIN (0=.d)
label define FUSSMIN .d "k.A. 1994",modify

recode PKWVERF (3=0) (2=1) (1=2),gen(pkwverf)
label var pkwverf "Pkw-Verfügbarkeit"
label define pkwverf 0 "nie" 1 "zeitweise" 2 "immer"
label values pkwverf pkwverf

recode NORMAL (9=.a)
label define NORMAL .a "keine Angabe",modify

recode  KRANK?? URLAUB?? WERK?? ANORM??? (9=0)
label define ANORMWOTAG 0 "Nein",modify

recode GEBJAHR (1=.e)
label define GEBJAHR .e "POT keine Angabe",modify
label values GEBJAHR GEBJAHR

replace GEBJAHR = GEBJAHR+1900 if GEBJAHR<1000
recode GEBJAHR (9999 = .a)
gen alter = JAHR - GEBJAHR
label var alter "Alter in Jahren"
replace alter = .c if alter<0
replace GEBJAHR = .c if alter==.c


}

end
****************************************************************************