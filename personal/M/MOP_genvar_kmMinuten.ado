********** Program zur Generierung der Variablen für die Regressions-Modellschätzung und Vorhersage der alternativen Reisezeiten ************
*! version 1.01  20102009
************************************************************************

************************************************************************
program define MOP_genvar_kmMinuten

quietly {

noi di "generiere Variablen für Reisezeiten/Entfernungen "

*** bilde Variablen für die Regressions-Modellschätzung der Reisezeiten***
recode mode (1=1 Fuss) (2=2 Rad) (3 5=4 andMIV) (4=5 PkwF) (6/9=3 OV) (10=.e Sonstiges),gen(mode5)

gen Minute = minutes(dauer)
gen _kmln = ln(km+2)
gen _km05 = km^.5
gen _oDirektSchnell = OEFFER==1
gen _oDirektLangsam = OEFFER==2
gen _oUmst1 = OEFFER==3
gen _oUmst2 = OEFFER==4
gen _oKeinOV = OEFFER==5


gen _kmDirSchnell = km*_oDirektSchnell
gen _kmlnDirSchnell = _kmln*_oDirektSchnell
gen _km2DirSchnell = (km^2)*_oDirektSchnell
gen _km05DirSchnell = (km^.5)*_oDirektSchnell
gen _kmDirLang = km*_oDirektLang
gen _kmlnDirLang = _kmln*_oDirektLang
gen _km2DirLang = (km^2)*_oDirektLang
gen _km05DirLang = (km^.5)*_oDirektLang
gen _kmUmst1 = km*_oUmst1
gen _kmlnUmst1 = _kmln*_oUmst1
gen _km2Umst1 = (km^2)*_oUmst1
gen _km05Umst1 = (km^.5)*_oUmst1
gen _kmUmst2 = km*_oUmst2
gen _kmlnUmst2 = _kmln*_oUmst2
gen _km2Umst2 = (km^2)*_oUmst2
gen _km05Umst2 = (km^.5)*_oUmst2


gen _kmAInn = km*(LAGEARB==1)

gen _kmWGZen = km*(LAGE==1)
gen _kmWGRand = km*(LAGE==2)
gen _kmWMZent = km*(LAGE==3)
gen _kmWMRand = km*(LAGE==4)
gen _kmWKlein = km*(LAGE==5)
gen _kmWLand = km*(LAGE==6)
gen _km05WGZen = _km05*(LAGE==1)
gen _km05WGRand = _km05*(LAGE==2)
gen _km05WMZent = _km05*(LAGE==3)
gen _km05WMRand = _km05*(LAGE==4)
gen _km05WKlein = _km05*(LAGE==5)
gen _km05WLand = _km05*(LAGE==6)
gen _kmGross = km*(LAGE==1|LAGE==2)


gen _km05ApGZen = _km05*(LAGEARB==1)
gen _km05ApGRand = _km05*(LAGEARB==2)
gen _km05ApMZen = _km05*(LAGEARB==3)
gen _km05ApMRand = _km05*(LAGEARB==4)
gen _km05ApKlein = _km05*(LAGEARB==5)
gen _km05ApLand = _km05*(LAGEARB==6)

gen _km05APZen = _km05*(LAGEARB==1|LAGEARB==2|LAGEARB==3)
gen _km05APPer = _km05*(LAGEARB==4|LAGEARB==5|LAGEARB==6)
gen _kmAPZen = km*(LAGEARB==1|LAGEARB==2|LAGEARB==3)
gen _kmAPPer = km*(LAGEARB==4|LAGEARB==5|LAGEARB==6)


egen _ZUZEIT = rowmin (HALTBUSZ  HALTSTRZ HALTUZ HALTSZ HALTZUGZ)
egen _ZUSCHIENE = rowmin( HALTSTRZ HALTUZ HALTSZ HALTZUGZ)
gen _ABZEIT1020 = FUSSMIN==2
gen _ABZEIT20 = FUSSMIN==3
gen _ABZEIT010 = FUSSMIN==0
gen _ABZEIT0kA = FUSSMIN>=.

gen _WoGrZentrum = LAGE==1
gen _WoGrRand = LAGE==2
gen _WoMzZentrum = LAGE==3
gen _ApGrZentrum = LAGEARB==1
gen _ApGrRand = LAGEARB==2
gen _ApMzZentrum = LAGEARB==3

gen _ParkSehrSchw = (PARKP==1)
gen _ParkSchw = (PARKP==2)
gen _ParkNichtSo = (PARKP==3)
gen _ParkkA = (PARKP>=.)


**************************************************************************


}

end

