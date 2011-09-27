*Do-File zum labeln von MOP-Dateien
*Erzeugt von Max Bohnet am Fri Feb 06 12:38:17 2009

program MOP_StataLabelHH
#delimit ;
*Variablen-Labels: ;

label variable ID "Haushalts-ID";
label variable JAHR "Erhebungsjahr";
label variable BIK "BIK";
label variable RAUMTYP "BIK-Raumtyp";
label variable REGION "Regionstyp";
label variable KREIS "Kreistyp";
label variable GEMEINDE "Gemeindetyp";
label variable PLZ "Postleitzahl";
label variable GKZ "Kreiskennzahl";
label variable EWZahl "Einwohnerzahl";
label variable WETTER "Wetterregion";
label variable UMZUG "Umzug";
label variable LAGE "Lage der Wohnung";
label variable HHTYP "Haushaltstyp";
label variable HHGRO "Haushaltsgr��e";
label variable P0_10 "Kinder (< 10 J)";
label variable EINKO "Haushaltseinkommen";
label variable PKWHH "Anzahl Pkw im Haushalt";
label variable PKWpriv1 "Eigentumsverh�ltnis 1.-Wagen";
label variable PKWpriv2 "Eigentumsverh�ltnis 2.-Wagen";
label variable PKWpriv3 "Eigentumsverh�ltnis 3.-Wagen";
label variable PKWnutz1 "Nutzung 1.-Wagen";
label variable PKWnutz2 "Nutzung 2.-Wagen";
label variable PKWnutz3 "Nutzung 3.-Wagen";
label variable PARKSTR1 "Parken 1.-Wagen";
label variable PARKSTR2 "Parken 2.-Wagen";
label variable PARKSTR3 "Parken 3.-Wagen";
label variable PARKGAR "Parkplatz / Garage (bis 99)";
label variable PARKPROB "Parkprobleme";
label variable HALTBUS "Bushaltestelle in der N�he";
label variable HALTBUSZ "Min zu Fu� zur Bushaltestelle";
label variable HALTSTR "Strabahalt in der N�he";
label variable HALTSTRZ "Min zu Fu� zur Stra�enbahnhaltestelle";
label variable HALTU "U-Bahnhalt in der N�he";
label variable HALTUZ "Min zu Fu� zur U-Bahnhaltestelle";
label variable HALTS "S-Bahnhalt in der N�he";
label variable HALTSZ "Min zu Fu� zur S-Bahnhaltestelle";
label variable HALTZUG "Bahnhof in der N�he";
label variable HALTZUGZ "Min zu Fu� zum Bahnhof";
label variable OEFFZUF "Zufriedenheit mit �V";
label variable EINK1 "Einkauf t�gl. Bedarf";
label variable EINK1KM "KM zu L�den t�gl. Bedarf";
label variable EINK2 "Einkauf weiterer Bedarf";
label variable EINK2KM "KM zu L�den weiterer Bedarf";
label variable KNEIPE "Caf�, Kneipe etc. in der N�he";
label variable KNEIPEKM "KM zu Caf�, Kneipe, etc. ";
label variable KINO "Ausgehen in der N�he";
label variable KINOKM "KM zu Ausgehgelegenheiten";
label variable SPORT "Sportm�gl. in der N�he";
label variable SPORTKM "Min zu Sportm�gl.";
label variable ZWEITW "Zweitwohnsitz, Ferienhaus o.�. ";
label variable ZWEITWKM "KM zu Zweitwohns., Ferienhaus o.�. ";
label variable CARSHAR "Carsharing";
label variable HANDY "Zahl Handys";
label variable PC "PC im Haushalt";
label variable PCWEB "Internet im Haushalt";
label variable GEWHHWO "Haushaltshochrechenfaktor";

*define ValueLabels: ;

label define BIK
	0	"> 500 Tsd EW, Kern"
	1	"> 500 Tsd EW, Rand"
	2	"100 Tsd - 500 Tsd EW, Kern"
	3	"100 Tsd - 500 Tsd EW, Rand"
	4	"50 Tsd - 100 Tsd EW, Kern"
	5	"50 Tsd - 100 Tsd EW, Rand"
	6	"20 Tsd -  50 Tsd EW."
	7	"5 Tsd  -  20 Tsd EW."
	8	"2 Tsd -   5 Tsd EW."
	9	"< 2 Tsd EW."
	;

label define CARSHAR
	1	"Ja"
	2	"Nein"
	.a	"Keine Angabe"
	;

label define EINKO
	1	"bis unter 500 Euro"
	2	"500 - 1000 Euro"
	3	"1000 - 1500 Euro"
	4	"1500 - 2000 Euro"
	5	"2000 - 2500 Euro"
	6	"2500 - 3000 Euro"
	7	"3000 - 3500 Euro"
	8	"3500 Euro und mehr"
	.a	"keine Angabe"
	;

label define EINKSPORT
	1	"ja"
	2	"nein"
	.a	"keine Angabe"
	;

label define EWZahl
	1	"unter 2.000"
	2	"2.000 bis unter 5.000"
	3	"5.000 bis unter 2.0000"
	4	"20.000 bis unter 50.000"
	5	"50.000 bis unter 100.000"
	6	"100.000 bis unter 500.000"
	7	"�ber 500.000"
	;

label define GEMEINDE
	1	"Kernst�dte > 500.000 Einw."
	2	"Kernst�dte < 500.000 Einw."
	3	"Ober / Mittelzentren"
	4	"sonstige Gemeinde"
	5	"Ober / Mittelzentren"
	6	"sonstige Gemeinde"
	7	"Ober / Mittelzentren"
	8	"sonstige Gemeinde"
	9	"Kernst�dte"
	10	"Ober / Mittelzentren"
	11	"sonstige Gemeinde"
	12	"Ober / Mittelzentren"
	13	"sonstige Gemeinde"
	14	"Ober / Mittelzentren"
	15	"sonstige Gemeinde"
	16	"Ober / Mittelzentren"
	17	"sonstige Gemeinde"
	;

label define HALT
	1	"Ja"
	.a	"k.A. / Nein"
	;

label define HHTYP
	1	"1-2 Personen mit Berufst�tigen"
	2	"1-2 Personen ohne Berufst�tige"
	3	"Haushalt mit Kindern (<18 J)"
	4	"3 und mehr Erwachsene"
	;

label define KREIS
	1	"Agglomeration Kernstadt"
	2	"Agglomeration, hochverdichtet"
	3	"Agglomeration, verdichtet"
	4	"l�ndlich in Agglomerationen"
	5	"Kernstadt in verst�dtertem Raum"
	6	"verdichtet in verst�dtertem Raum"
	7	"l�ndlich in verst�dtertem Raum"
	8	"L�ndlich, h�here Dichte"
	9	"L�ndlich, geringere Dichte"
	;

label define LAGE
	1	"Gro�stadt, Innenstadt"
	2	"Gro�stadt, Stadtrand"
	3	"Mittelstadt, Innenstadt"
	4	"Mittelstadt, Stadtrand"
	5	"Kleinstadt"
	6	"kleine Landgemeinde"
	9	"keine Angabe"
	;

label define OEFFZUF
	1	"zufrieden"
	2	"Sollte verbessert werden"
	.a	"keine Angabe"
	;

label define PARKGAR
	1	"Ja"
	.a	"k.A. / Nein"
	;

label define PARKPROB
	1	"Sehr schwierig"
	2	"Schwierig"
	3	"Nicht besonders schwierig"
	4	"�berhaupt nicht schwierig"
	.a	"keine Angabe"
	;

label define PARKSTR
	1	"Stra�enrand"
	2	"Garage / privater Stellplatz"
	.a	"k.A."
	;

label define PC
	1	"Ja"
	2	"Nein"
	.a	"keine Angabe"
	;

label define PCWEB
	1	"Ja"
	2	"Nein"
	.a	"Keine Angabe"
	;

label define PKWnutz
	1	"nur privat"
	2	"privat und dienstlich"
	3	"nur dienstlich"
	.a	"k.A."
	;

label define PKWpriv
	1	"Haushalt ist Eigent�mer"
	2	"Eigene Firma ist Eigent�mer"
	3	"Arbeitgeber ist Eigent�mer"
	4	"Sonstiges"
	.a	"k.A."
	;

label define RAUMTYP
	1	"> 100 Tsd EW., Kern"
	2	"> 100 Tsd EW., Rand"
	3	"20 Tsd - 100 Tsd EW."
	4	"5 Tsd -  20 Tsd EW."
	5	"< 5 Tsd EW."
	;

label define REGION
	1	"Agglomeration, hochverdichtet"
	2	"Agglomeration, mit Zentren"
	3	"Verst�dtert, hohe Dichte"
	4	"Verst�dtert, mit Oberzentren"
	5	"Verst�dtert,  ohne Oberzentren"
	6	"L�ndlich, h�here Dichte"
	7	"L�ndlich, geringe Dichte"
	;

label define UMZUG
	0	"kein Umzug"
	1	"Umzug"
	;

label define WETTER
	1	"Hamburg"
	2	"Essen-Bredeney"
	3	"Flughafen Frankfurt/Main"
	4	"Ulm / M�nsterhausen"
	5	"Berlin-Sch�nefeld"
	6	"Gera-Leumnitz"
	;

label define ZWEITW
	1	"Wohnung nahe Arbeit Ausbildung"
	2	"Ferienwohnung / Ferienhaus"
	3	"Dienstunterkunft (Bund, Zivi)"
	4	"Sonstiges"
	5	"Nein"
	.a	"keine Angaben"
	;


*label Values and recode missings: ;

label values BIK BIK;
label values RAUMTYP RAUMTYP;
label values REGION REGION;
label values KREIS KREIS;
label values GEMEINDE GEMEINDE;
label values EWZahl EWZahl;
label values WETTER WETTER;
label values UMZUG UMZUG;
label values LAGE LAGE;
label values HHTYP HHTYP;
quietly recode EINKO (9 = .a);
label values EINKO EINKO;
label values PKWpriv1 PKWpriv;
label values PKWpriv2 PKWpriv;
label values PKWpriv3 PKWpriv;
label values PKWnutz1 PKWnutz;
label values PKWnutz2 PKWnutz;
label values PKWnutz3 PKWnutz;
label values PARKSTR1 PARKSTR;
label values PARKSTR2 PARKSTR;
label values PARKSTR3 PARKSTR;
quietly recode PARKGAR (9 = .a);
label values PARKGAR PARKGAR;
quietly recode PARKPROB (9 = .a);
label values PARKPROB PARKPROB;
label values HALTBUS HALT;
label values HALTSTR HALT;
label values HALTU HALT;
label values HALTS HALT;
label values HALTZUG HALT;
quietly recode OEFFZUF (9 = .a);
label values OEFFZUF OEFFZUF;
label values EINK1 EINKSPORT;
label values EINK2 EINKSPORT;
label values KNEIPE EINKSPORT;
label values KINO EINKSPORT;
label values SPORT EINKSPORT;
quietly recode ZWEITW (9 = .a);
label values ZWEITW ZWEITW;
quietly recode CARSHAR (9 = .a);
label values CARSHAR CARSHAR;
quietly recode PC (9 = .a);
label values PC PC;
quietly recode PCWEB (9 = .a);
label values PCWEB PCWEB;

#delimit cr

end
