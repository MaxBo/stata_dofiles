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
label variable HHGRO "Haushaltsgröße";
label variable P0_10 "Kinder (< 10 J)";
label variable EINKO "Haushaltseinkommen";
label variable PKWHH "Anzahl Pkw im Haushalt";
label variable PKWpriv1 "Eigentumsverhältnis 1.-Wagen";
label variable PKWpriv2 "Eigentumsverhältnis 2.-Wagen";
label variable PKWpriv3 "Eigentumsverhältnis 3.-Wagen";
label variable PKWnutz1 "Nutzung 1.-Wagen";
label variable PKWnutz2 "Nutzung 2.-Wagen";
label variable PKWnutz3 "Nutzung 3.-Wagen";
label variable PARKSTR1 "Parken 1.-Wagen";
label variable PARKSTR2 "Parken 2.-Wagen";
label variable PARKSTR3 "Parken 3.-Wagen";
label variable PARKGAR "Parkplatz / Garage (bis 99)";
label variable PARKPROB "Parkprobleme";
label variable HALTBUS "Bushaltestelle in der Nähe";
label variable HALTBUSZ "Min zu Fuß zur Bushaltestelle";
label variable HALTSTR "Strabahalt in der Nähe";
label variable HALTSTRZ "Min zu Fuß zur Straßenbahnhaltestelle";
label variable HALTU "U-Bahnhalt in der Nähe";
label variable HALTUZ "Min zu Fuß zur U-Bahnhaltestelle";
label variable HALTS "S-Bahnhalt in der Nähe";
label variable HALTSZ "Min zu Fuß zur S-Bahnhaltestelle";
label variable HALTZUG "Bahnhof in der Nähe";
label variable HALTZUGZ "Min zu Fuß zum Bahnhof";
label variable OEFFZUF "Zufriedenheit mit ÖV";
label variable EINK1 "Einkauf tägl. Bedarf";
label variable EINK1KM "KM zu Läden tägl. Bedarf";
label variable EINK2 "Einkauf weiterer Bedarf";
label variable EINK2KM "KM zu Läden weiterer Bedarf";
label variable KNEIPE "Café, Kneipe etc. in der Nähe";
label variable KNEIPEKM "KM zu Café, Kneipe, etc. ";
label variable KINO "Ausgehen in der Nähe";
label variable KINOKM "KM zu Ausgehgelegenheiten";
label variable SPORT "Sportmögl. in der Nähe";
label variable SPORTKM "Min zu Sportmögl.";
label variable ZWEITW "Zweitwohnsitz, Ferienhaus o.ä. ";
label variable ZWEITWKM "KM zu Zweitwohns., Ferienhaus o.ä. ";
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
	7	"über 500.000"
	;

label define GEMEINDE
	1	"Kernstädte > 500.000 Einw."
	2	"Kernstädte < 500.000 Einw."
	3	"Ober / Mittelzentren"
	4	"sonstige Gemeinde"
	5	"Ober / Mittelzentren"
	6	"sonstige Gemeinde"
	7	"Ober / Mittelzentren"
	8	"sonstige Gemeinde"
	9	"Kernstädte"
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
	1	"1-2 Personen mit Berufstätigen"
	2	"1-2 Personen ohne Berufstätige"
	3	"Haushalt mit Kindern (<18 J)"
	4	"3 und mehr Erwachsene"
	;

label define KREIS
	1	"Agglomeration Kernstadt"
	2	"Agglomeration, hochverdichtet"
	3	"Agglomeration, verdichtet"
	4	"ländlich in Agglomerationen"
	5	"Kernstadt in verstädtertem Raum"
	6	"verdichtet in verstädtertem Raum"
	7	"ländlich in verstädtertem Raum"
	8	"Ländlich, höhere Dichte"
	9	"Ländlich, geringere Dichte"
	;

label define LAGE
	1	"Großstadt, Innenstadt"
	2	"Großstadt, Stadtrand"
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
	4	"überhaupt nicht schwierig"
	.a	"keine Angabe"
	;

label define PARKSTR
	1	"Straßenrand"
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
	1	"Haushalt ist Eigentümer"
	2	"Eigene Firma ist Eigentümer"
	3	"Arbeitgeber ist Eigentümer"
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
	3	"Verstädtert, hohe Dichte"
	4	"Verstädtert, mit Oberzentren"
	5	"Verstädtert,  ohne Oberzentren"
	6	"Ländlich, höhere Dichte"
	7	"Ländlich, geringe Dichte"
	;

label define UMZUG
	0	"kein Umzug"
	1	"Umzug"
	;

label define WETTER
	1	"Hamburg"
	2	"Essen-Bredeney"
	3	"Flughafen Frankfurt/Main"
	4	"Ulm / Münsterhausen"
	5	"Berlin-Schönefeld"
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
