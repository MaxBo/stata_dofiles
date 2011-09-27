program define MiDH_P_Label_neu

quietly {
* Korrigiere personenbezogene Werte
capture label drop taet
label define taet 0 "nicht Erwerbstätig" 1 "Vollzeit" 2 "Teilzeit" 3 "Azubi" 4 "Schüler" 5 "Studi" 

recode pErwerbStatus (1=1) (2 3=2) (4=3),gen(pTaetigkeit)
label var pTaetigkeit "Tätigkeit"
label values pTaetigkeit taet
replace pTaetigkeit = 1 if pBeschaeftigung==1 // Vollzeit
replace pTaetigkeit = 2 if pBeschaeftigung==2 | pBeschaeftigung==3 // Teilzeit
replace pTaetigkeit = 3 if pBeschaeftigung==4 | pBeschaeftigung==12 | pHauptbesch==1 | pHauptbesch==9 // Azubi
replace pTaetigkeit = 4 if pBeschaeftigung==5| pBeschaeftigung==6 | pHauptbesch==2 | pHauptbesch==3 // Schüler
replace pTaetigkeit = 5 if pBeschaeftigung==7 | pHauptbesch==4  // Studi
replace pTaetigkeit = 0 if (pBeschaeftigung>=8 & pBeschaeftigung<=11) | (pHauptbesch>=5 & pHauptbesch<=8)   // nicht erwerbstätig
recode pTaetigkeit (./.z = 0) if pAlter >=67
recode pTaetigkeit (./.z = 4) if pAlter <=16

recode pStellung (1 2 5 11=1) (3 6 9 10=2) (4 7 8=3) (12=.v) (13=.h) ,gen(pPosition)
label var pPosition "Berufliche Stellung"
capture label drop stellung
label define stellung 1 "einfache Position" 2 "mittlere Position" 3 "höhere Position" .v "sonstiges" .h "noch nie berufstätig",modify
label values pPosition stellung


*Bildung
recode pAbschluss (1 2=1) (3 = 2) (4=3) (5 6=4) (7/15=5) (./.z=.a),gen(pSchulabschluss)
capture label drop abschluss
label define abschluss 1 "kein/HS" 2 "RS" 3 "FHS" 4 "Abi" 5 "noch (nicht) in Schule" .a "keine Angabe"
label values pSchulabschluss abschluss
label var pSchulabschluss "Schulabschluss"

recode pTicket (0 1 2 = 0) (3 4 5 6 = 1) , gen(zeitkarte)
label var zeitkarte "Zeitkarte"
capture label drop zeitkarte
label define zeitkarte 0 "nein" 1 "ja" .a "keine Angabe"  .b "trifft nicht zu" .c "unplausibel"
label values zeitkarte zeitkarte


}
end
