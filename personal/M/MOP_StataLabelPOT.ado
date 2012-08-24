*Do-File zum labeln von MOP-Dateien
*Erzeugt von Max Bohnet am Fri Feb 06 12:38:17 2009

program MOP_StataLabelPOT
#delimit ;
*Variablen-Labels: ;

label variable ID "Haushalts-ID";
label variable PERSNR "Personen-ID";
label variable JAHR "Erhebungsjahr";
label variable AUSFUELLER "Ausfüller";
label variable SEX "Geschlecht";
label variable GEBJAHR "Geburtsjahr";
label variable ALTER "Altersklasse";
label variable SCHULAB "Bildungsabschluss";
label variable MOBEINSCHR "gesundheitl. Mobilitätseinschränkungen";
label variable BERUF "Beruf";
label variable WECHSARB "Arbeitsplatzwechsel";
label variable LAGEARB "Lage von Arbeit, Ausbildung";
label variable OEFFERR "ÖV-Erreichbarkeit von Arbeit, Ausbildung";
label variable FUSSMIN "Min zu Fuß von ÖV-Halt zu Arbeit, Ausbildung";
label variable PARKP "Parkplätze bei Arbeit, Ausbildung";
label variable FSPKW "PKW-Führerschein";
label variable FSMOT "Motorad-, Mopedführerschein";
label variable PKWVERF "Pkw-Verfügbarkeit";
label variable ZEITOPNV "ÖPNV-Zeitkarte";
label variable BAHNCARD "Bahncard";
label variable MOPED "Moped";
label variable FAHRRAD "Fahrrad";
label variable ANFTAG "Wochentag des Berichtsbeginns";
label variable DATANF "Datum des Berichtsbeginns";
label variable NORMAL "Besonderheiten während Bericht";
label variable KRANKmo "Krank am Mo";
label variable KRANKdi "Krank am Di";
label variable KRANKmi "Krank am Mi";
label variable KRANKdo "Krank am Do";
label variable KRANKfr "Krank am Fr";
label variable KRANKsa "Krank am Sa";
label variable KRANKso "Krank am So";
label variable WERKmo "Pkw am Mo in Werkstatt ";
label variable WERKdi "Pkw am Di in Werkstatt";
label variable WERKmi "Pkw am Mi in Werkstatt";
label variable WERKdo "Pkw am Do in Werkstatt";
label variable WERKfr "Pkw am Fr in Werkstatt";
label variable WERKsa "Pkw am Sa in Werkstatt";
label variable WERKso "Pkw am So in Werkstatt";
label variable URLAUBmo "Urlaub am Mo";
label variable URLAUBdi "Urlaub am Di";
label variable URLAUBmi "Urlaub am Mi";
label variable URLAUBdo "Urlaub am Do";
label variable URLAUBfr "Urlaub am Fr";
label variable URLAUBsa "Urlaub am Sa";
label variable URLAUBso "Urlaub am So";
label variable ANORM1mo "1. Besonderheit am Mo";
label variable ANORM1di "1. Besonderheit am Di";
label variable ANORM1mi "1. Besonderheit am Mi";
label variable ANORM1do "1. Besonderheit am Do";
label variable ANORM1fr "1. Besonderheit am Fr";
label variable ANORM1sa "1. Besonderheit am Sa";
label variable ANORM1so "1. Besonderheit am So";
label variable ANORM2mo "2. Besonderheit am Mo";
label variable ANORM2di "2. Besonderheit am Di";
label variable ANORM2mi "2. Besonderheit am Mi";
label variable ANORM2do "2. Besonderheit am Do";
label variable ANORM2fr "2. Besonderheit am Fr";
label variable ANORM2sa "2. Besonderheit am Sa";
label variable ANORM2so "2. Besonderheit am So";
label variable GEWHHPWO "Haushalts- und Personenhochrechenfaktor";

*define ValueLabels: ;

label define ALTER
	1	"10 bis 17 Jahre"
	2	"18 bis 25 Jahre"
	3	"26 bis 35 Jahre"
	4	"36 bis 50 Jahre"
	5	"51 bis 59 Jahre"
	6	"60 bis 69 Jahre"
	7	"70 und älter"
	;

label define ANFTAG
	1	"Montag"
	2	"Dienstag"
	3	"Mittwoch"
	4	"Donnerstag"
	5	"Freitag"
	6	"Samstag"
	7	"Sonntag"
	;

label define ANORMWOTAG
	1	"Ja"
	9	"Nein"
	;

label define AUSFUELLER
	1	"Person füllt selbst aus"
	9	"Jemand anderes füllt aus"
	;

label define BAHNCARD
	1	"Ja"
	2	"Nein"
	.a	"keine Angabe"
	;

label define BERUF
	1	"voll berufstätig"
	2	"teilzeitbeschäftigt"
	3	"arbeitslos"
	4	"in Ausbildung"
	5	"in Berufsausbildung"
	6	"Nicht erwerbstätig, Hausfrau"
	7	"in Rente"
	8	"Kleinkind"
	.a	"keine Angabe"
	;

label define FAHRRAD
	1	"Ja"
	2	"Nein"
	.a	"keine Angabe"
	;

label define FSMOT
	0	"nein"
	1	"ja"
	.a	"keine Angabe"
	;

label define FSPKW
	0	"nein"
	1	"ja"
	.a	"keine Angabe"
	;

label define FUSSMIN
	1	"Kürzer als 10 Minuten"
	2	"10 bis 20 Minuten"
	3	"Länger als 20 Minuten"
	.a	"keine Angabe"
	;

label define LAGEARB
	1	"Großstadtkern"
	2	"Großstadtrand"
	3	"Mittelstadt, Kern"
	4	"Mittelstadt, Rand"
	5	"Kleinstadt"
	6	"Land"
	.a	"keine Angabe"
	;

label define MOBEINSCHR
	1	"Ja"
	2	"nein"
	.a	"keine Angabe"
	;

label define MOPED
	1	"Ja"
	2	"Nein"
	.a	"keine Angabe"
	;

label define NORMAL
	1	"Mehr oder weniger wie immer"
	2	"Nicht wie immer"
	;

label define OEFFERR
	1	"Zügige Direktverbindung"
	2	"Langsame Direktverbindung"
	3	"einmaliges Umsteigen"
	4	"mehrmaliges Umsteigen"
	5	"Keine ÖV-Verbindung"
	.a	"keine Angaben"
	;

label define PARKP
	1	"Sehr schwierig"
	2	"Schwierig"
	3	"Nicht besonders schwierig"
	4	"Überhaupt nicht schwierig"
	.a	"keine Angabe"
	;

label define PKWVERF
	1	"Ja, regelmäßig"
	2	"nach Absprache"
	3	"Nein"
	.a	"keine Angabe"
	;

label define SCHULAB
	1	"Volks / Hauptschule ohne Lehre"
	2	"Volks / Hauptschule mit Lehre"
	3	"Mittlerer Schulabschluß, Mittlere Reife"
	4	"Abitur, Fachhochschule, Hochschule"
	5	"(Noch) kein Abschluß"
	.a	"keine Angabe"
	;

label define SEX
	1	"männlich"
	2	"weiblich"
	;

label define WECHSARB
	1	"gewechselt"
	2	"nicht gewechselt"
	.a	"keine Angabe"
	;

label define ZEITOPNV
	1	"Ja"
	2	"Nein"
	.a	"keine Angabe"
	;


*label Values and recode missings: ;

label values AUSFUELLER AUSFUELLER;
label values SEX SEX;
label values ALTER ALTER;
quietly recode SCHULAB (9 = .a);
label values SCHULAB SCHULAB;
quietly recode MOBEINSCHR (9 = .a);
label values MOBEINSCHR MOBEINSCHR;
quietly recode BERUF (9 = .a);
label values BERUF BERUF;
quietly recode WECHSARB (9 = .a);
label values WECHSARB WECHSARB;
quietly recode LAGEARB (9 = .a);
label values LAGEARB LAGEARB;
quietly recode OEFFERR (9 = .a);
label values OEFFERR OEFFERR;
quietly recode FUSSMIN (9 = .a);
label values FUSSMIN FUSSMIN;
quietly recode PARKP (9 = .a);
label values PARKP PARKP;
quietly recode FSPKW (9 = .a);
label values FSPKW FSPKW;
quietly recode FSMOT (9 = .a);
label values FSMOT FSMOT;
quietly recode PKWVERF (9 = .a);
label values PKWVERF PKWVERF;
quietly recode ZEITOPNV (9 = .a);
label values ZEITOPNV ZEITOPNV;
quietly recode BAHNCARD (9 = .a);
label values BAHNCARD BAHNCARD;
quietly recode MOPED (9 = .a);
label values MOPED MOPED;
quietly recode FAHRRAD (9 = .a);
label values FAHRRAD FAHRRAD;
label values ANFTAG ANFTAG;
label values NORMAL NORMAL;
label values KRANKmo ANORMWOTAG;
label values KRANKdi ANORMWOTAG;
label values KRANKmi ANORMWOTAG;
label values KRANKdo ANORMWOTAG;
label values KRANKfr ANORMWOTAG;
label values KRANKsa ANORMWOTAG;
label values KRANKso ANORMWOTAG;
label values WERKmo ANORMWOTAG;
label values WERKdi ANORMWOTAG;
label values WERKmi ANORMWOTAG;
label values WERKdo ANORMWOTAG;
label values WERKfr ANORMWOTAG;
label values WERKsa ANORMWOTAG;
label values WERKso ANORMWOTAG;
label values URLAUBmo ANORMWOTAG;
label values URLAUBdi ANORMWOTAG;
label values URLAUBmi ANORMWOTAG;
label values URLAUBdo ANORMWOTAG;
label values URLAUBfr ANORMWOTAG;
label values URLAUBsa ANORMWOTAG;
label values URLAUBso ANORMWOTAG;
label values ANORM1mo ANORMWOTAG;
label values ANORM1di ANORMWOTAG;
label values ANORM1mi ANORMWOTAG;
label values ANORM1do ANORMWOTAG;
label values ANORM1fr ANORMWOTAG;
label values ANORM1sa ANORMWOTAG;
label values ANORM1so ANORMWOTAG;
label values ANORM2mo ANORMWOTAG;
label values ANORM2di ANORMWOTAG;
label values ANORM2mi ANORMWOTAG;
label values ANORM2do ANORMWOTAG;
label values ANORM2fr ANORMWOTAG;
label values ANORM2sa ANORMWOTAG;
label values ANORM2so ANORMWOTAG;

#delimit cr

end
