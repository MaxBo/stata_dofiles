*Do-File zum labeln von MOP-Dateien
*Erzeugt von Max Bohnet am Fri Feb 06 12:38:17 2009

program MOP_StataLabelW
#delimit ;
*Variablen-Labels: ;

label variable ID "Haushalts-ID";
label variable PERSNR "Personen-ID";
label variable JAHR "Erhebungsjahr";
label variable WOTAG "Wochentag ";
label variable BERTAG "Berichtstag";
label variable DATUM "SAS-Datum";
label variable TEMP "Temperatur";
label variable REGEN "Regen";
label variable WNRT "Weg-Nr.";
label variable ABZEIT "Abfahrtszeit";
label variable ZWECK "Wegzweck";
label variable VM1 "1. Verkehrsmittel";
label variable VM2 "2. Verkehrsmittel";
label variable VM3 "3. Verkehrsmittel";
label variable VM4 "4. Verkehrsmittel";
label variable VM5 "5. Verkehrsmittel";
label variable VMDIW "Verkehrsmittel nach DIW-Einteilung";
label variable ANZEIT "Ankunftszeit";
label variable KM "Entfernung ";
label variable DAUER "Dauer";
label variable SPEED "Geschwindigkeit";
label variable WEGGEW "Weg-Gewicht";
label variable KMGEW "KM-Gewicht";

*define ValueLabels: ;

label define VM
	1	"zu Fuß"
	2	"Fahrrad"
	3	"Mofa, Moped, Motorrad"
	4	"PKW als Fahrer"
	5	"PKW als Mitfahrer"
	6	"Bus"
	7	"Straßenbahn"
	8	"U-Bahn / S-Bahn"
	9	"Zug"
	10	"Sonstige"
	11	"Flugzeug"
	.a	"keine Angabe"
	;

label define WOTAG
	1	"Montag"
	2	"Dienstag"
	3	"Mittwoch"
	4	"Donnerstag"
	5	"Freitag"
	6	"Samstag"
	7	"Sonntag"
	;

label define ZWECK
	1	"Arbeit"
	2	"Dienstlich"
	3	"Ausbildung"
	4	"Einkauf, Besorgung"
	5	"Freizeit"
	6	"Serviceweg"
	7	"Nachhauseweg"
	8	"Sonstiges"
	9	"Ferienwohnung, Hotel o.ä."
	10	"2. Wohnsitz"
	70	"Nachhauseweg ohne weitere Info"
	71	"Nachhauseweg von Arbeit"
	72	"Nachhauseweg von Dienstfahrt"
	73	"Nachhauseweg von Ausbildung"
	74	"Nachhauseweg von Einkauf"
	75	"Nachhauseweg von Freizeit"
	76	"Nachhauseweg von einem Serviceweg"
	77	"Rundweg (z.B. Spaziergang)"
	78	"Nachhauseweg bei Auswärtsübernachtung"
	.a	"keine Angabe"
	;


*label Values and recode missings: ;

label values WOTAG WOTAG;
quietly recode ZWECK (99 = .a);
label values ZWECK ZWECK;
label values VM1 VM;
label values VM2 VM;
label values VM3 VM;
label values VM4 VM;
label values VM5 VM;
label values VMDIW VM;

#delimit cr

end
