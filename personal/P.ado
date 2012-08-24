*Do-File zum labeln von SPSS-Dateien
*Erzeugt von Max Bohnet am Sat Jan 26 21:37:37 2008

*SPSS2Stata
#delimit ;
program define P;
*Variablen-Labels: ;

label variable caseid "Identifkationsnummer des Haushalts";
label variable pid "Identifkationsnummer der Person im Haushalt";
label variable p01 "Wie oft können Sie als Fahrer/in über ein Auto verfügen?";
label variable p02 "Besitzen Sie zur Zeit ein verkehrstüchtiges Fahrrad?";
label variable p021 "Wo steht Ihr hauptsächlich genutztes Fahrrad üblicherweise über Nacht?";
label variable p022 "Wie gut ist Ihr hauptsächlich genutztes Fahrrad von dem üblichen Stellplatz aus auf die Straße zu bekommen?";
label variable p033 "allgemeine Nutzung: Fahrrad";
label variable p031 "allgemeine Nutzung: Auto";
label variable p032 "allgemeine Nutzung: Bus oder Bahn";
label variable p034 "allgemeine Nutzung: Bahn längere Strecken (ab 100 Km)";
label variable p051 "Fußwegentfernung Bushaltestelle in Minuten";
label variable p052 "Fußwegentfernung Bushaltestelle in Metern";
label variable p053 "Fußwegentfernung Bahnhaltestelle in Minuten";
label variable p054 "Fußwegentfernung Bahnhaltestelle in Metern";
label variable p041 "Erreichbarkeit übliche Ziele: mit dem ÖPNV";
label variable p042 "Erreichbarkeit übliche Ziele: mit dem Auto";
label variable p07 "überwiegende Fahrscheinart ÖPNV";
label variable p10as "Innerhalb der letzten drei Monate Reisen unternommen";
label variable p10 "Anzahl Reisen mit Übernachtung letzte 3 Monate";
label variable p101_1 "Zweck Reisen mit Übernachtung: geschäftlich";
label variable p101_2 "Zweck Reisen mit Übernachtung: kurz privat";
label variable p101_3 "Zweck Reisen mit Übernachtung: lang privat";
label variable p101_4 "Zweck Reisen mit Übernachtung: sonstiges";
label variable p102_1 "Genutzte Verkehrsmittel bei Reisen mit Übernachtung: Auto";
label variable p102_2 "Genutzte Verkehrsmittel bei Reisen mit Übernachtung: Bahn";
label variable p102_3 "Genutzte Verkehrsmittel bei Reisen mit Übernachtung: Reisebus";
label variable p102_4 "Genutzte Verkehrsmittel bei Reisen mit Übernachtung: Flugzeug";
label variable p102_5 "Genutzte Verkehrsmittel bei Reisen mit Übernachtung: Fahrrad ";
label variable p102_6 "Genutzte Verkehrsmittel bei Reisen mit Übernachtung: sonstiges";
label variable p11 "Geschlecht";
label variable p12_1 "Staatsangehörigkeit: deutsch";
label variable p12_2 "Staatsangehörigkeit: türkisch";
label variable p12_3 "Staatsangehörigkeit: italienisch";
label variable p12_4 "Staatsangehörigkeit: griechisch";
label variable p12_5 "Staatsangehörigkeit: anderes";
label variable p13 "Alter";
label variable p06 "Besitzen Sie zur Zeit einen Führerschein?";
label variable p061_1 "Führerscheinbesitz für Moped";
label variable p061_2 "Führerscheinbesitz für Motorrad";
label variable p061_3 "Führerscheinbesitz für Pkw";
label variable p061_4 "Führerscheinbesitz für Lkw";
label variable p061_1j "Jahr des Führerscheinerwerbs für Moped";
label variable p061_2j "Jahr des Führerscheinerwerbs für Motorrad";
label variable p061_3j "Jahr des Führerscheinerwerbs für Pkw";
label variable p061_4j "Jahr des Führerscheinerwerbs für Lkw";
label variable p14 "Schulabschluß";
label variable p15 "Sind Sie zur Zeit berufstätig?";
label variable p16 "Umfang Berufstätigkeit";
label variable p17 "Was ist Ihre derzeitige Hauptbeschäftigung?";
label variable p18 "Welche berufliche Stelluing haben Sie derzeit bzw. zuletzt bei Ihrer früheren Erwerbstätigkeit?";
label variable p17s "Was trifft derzeit auf Sie zu?";
label variable p18s "Welche berufliche Stellung haben Sie derzeit bzw. hatten Sie zuletzt?";
label variable p09_1 "Körperliche Behinderung: Gehbehinderung";
label variable p09_2 "Körperliche Behinderung: Sehbehinderung";
label variable p09_3 "Körperliche Behinderung: andere Einschränkung";
label variable p09_4 "Körperliche Behinderung: keine";
label variable p09 "Fühlen Sie sich durch Ihre körperliche Behinderung in Ihrer Mobilität eingeschränkt?";
label variable p08 "Wohndauer";
label variable s03 "Wetter am Stichtag";
label variable s04 "Kfz-Verfügbarkeit am Stichtag";
label variable s05 "Außer Haus am Stichtag";
label variable s01 "Normalität Stichtag";
label variable s02_1 "Stichtag nicht normal: Urlaub innerhalb Deutschlands";
label variable s02_2 "Stichtag nicht normal: Urlaub außerhalb Deutschlands";
label variable s02_3 "Stichtag nicht normal: war krank";
label variable s02_4 "Stichtag nicht normal: war nicht außer Haus";
label variable s02_5 "Stichtag nicht normal: um eine Kranke Person im HH kümmern";
label variable s02_6 "Stichtag nicht normal: andere Gründe";
label variable s02_7 "Stichtag nicht normal: verweigert";
label variable s02_8 "Stichtag nicht normal: weiß nicht";
label variable wv0 "regelmäßige berufliche Wege am Stichtag (Wirtschaftsverkehr)";
label variable wv01 "Branche";
label variable wv02 "Hauptzweck reg. ber. Wege am Stichtag";
label variable wv03 "Kilometer reg. ber. Wege am Stichtag";
label variable wv04 "Anzahl reg. ber. Wege am Stichtag";
label variable wv05 "Verkehrsmittel reg. ber. Wege am Stichtag";
label variable w12 "Anzahl weiterer Wege";
label variable weganz_1 "Anzahl der erfassten Wege in der Wegematrix";
label variable weganz_2 "Anzahl der Wege inklusive  der weiteren Wege";
label variable weganz_3 "Anzahl der Wege inkl. weitere Wege und Wirtschaftsverkehr";
label variable h02 "Haushaltsgröße insgesamt";
label variable h05 "Wohnlage";
label variable hheink "Netto-Haushaltseinkommen";
label variable lebensp "Lebensphase neu";
label variable ov_seg "ÖPNV-Segmentierung";
label variable pergrup "verhaltenshomogene Personengruppen 9 Gruppen";
label variable pergrup1 "verhaltenshomogene Personengruppen 12 Gruppen";
label variable caseinfo "Erhebungsmethode";
label variable proxy "Form des Interviews";
label variable persinfo "Info zum Interviewstatus der Person";
label variable voll_hh "vollständigeHH";
label variable bland "Bundesland";
label variable westost "West-Ost Kennung";
label variable ggkpol "politische Ortsgrößenklasse";
label variable ggkbik "BIK Regionsgrößenklasse";
label variable bbr_reg "Regionsgrundtyp";
label variable bbr_dreg "differenzierter Regionstyp";
label variable bbrkrtyp "BBR/BfLR Kreistyp";
label variable wtag "wochentag";
label variable wegdauer "Dauer aller Wege am Stichtag (Summe)";
label variable h04_3 "Anzahl Pkw im HH";
label variable h04_6 "Anzahl Lkw ges im HH";
label variable hhgr06 "Anzahl der Personen im Haushalt unter 6";
label variable hhgr14 "Anzahl der Personen im Haushalt unter 14";
label variable hhgr18 "Anzahl der Personen im Haushalt unter 18";
label variable wegtempo "mittleres Wegetempo am Stichtag (Mittelwert)";
label variable kminsgk "insgesamt zurückgelegte Kilometer am Stichtag (Summe)";
label variable stichtag "Datum Stichtag für Person";
label variable palter "Alter der Zielperson";
label variable psex "Geschlecht der Zielperson";
label variable kinfo "Dieser Kinderfragebogen wurde ausgefüllt von...";
label variable mobil "Mobilität am Stichtag";
label variable gemnr "Gemeindenummer";
label variable stichpro "stichprobenkennung";
label variable fragebog "Fragebogenvariante";
label variable befrag "Befragungsart";
label variable gew_pa "Personengewicht für Aufstockung";

*define ValueLabels: ;

label define Label_0
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-20	"CATI:Personen < 18(Alter aus HH-Matrix) werden nicht befragt"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Jederzeit"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Ausnahmsweise"
	2	"Gelegentlich"
	4	"Gar nicht"
	7	"Verweigert"
	6	"habe keinen Führerschein"
	9	"Keine Angabe"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_1
	1	"Ja"
	.h	"Personen ohne Führerschein werden nicht befragt"
	.f	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.g	"Verweigert/Weiß nicht zum Besitz eines FHS"
	.e	"Personen unter 16 Jahre werden nicht zum MotorradFHS befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	8	"Weiß nicht"
	9	"Keine Angabe"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_2
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	.g	"Personen ohne Fahrrad werden nicht befragt"
	.f	"Verweigert/Weiß nicht zum Besitz eines Fahrrads"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"In  ein abgeschlossenem Raum unmittelbar im Haus"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"In nicht abgeschlossenem Raum"
	2	"In einem abgeschlossenem Raum entfernt vom Haus"
	5	"Anderes"
	4	"Unterschiedlich"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_3
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	.g	"Personen ohne Fahrrad werden nicht befragt"
	.f	"Verweigert/Weiß nicht zum Besitz eines Fahrrads"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Leicht"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Sehr umständlich"
	2	"Etwas umständlich"
	4	"Unterschiedlich"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_4
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"(fast) Täglich"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"An einem bis drei Tagen pro Monat"
	2	"An einem bis drei Tagen pro Woche"
	5	"Nie"
	4	"Seltener als monatlich"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_5
	997	"Verweigert"
	996	"Wie Bushaltestelle"
	999	"Keine Angabe"
	998	"Weiß nicht"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_6
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	99	"Keine Angabe"
	98	"Weiß nicht"
	8	"weiter als 10 Kilometer"
	97	"Verweigert"
	96	"Wie Bushaltestelle"
	1	"unter 100 Meter"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"200 bis unter 400 Meter"
	2	"100 bis unter 200 Meter"
	5	"ein bis unter 2 Kilometer"
	4	"400 Metern bis unter einem Kilometer"
	7	"5 bis unter  10 Kilometer"
	6	"2 bis unter 5 Kilometer"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_7
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Sehr gut"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Einigermaßen"
	2	"Gut"
	5	"Sehr schlecht"
	4	"Schlecht"
	7	"Verweigert"
	6	"schriftlich: unzulässige Mehrfachnennung"
	9	"Keine Angabe"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_8
	99	"Keine Angabe"
	98	"Weiß nicht"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Einzelfahrschein, Tageskarte"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Wochenkarte, Monatskarte"
	2	"Mehrfachkarte, Streifenkarte"
	5	"Jobticket, Semesterticket"
	4	"Monatskarte im Abo, Jahreskarte"
	6	"Anderes"
	9	"Fahre nie ÖPNV"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	97	"Verweigert"
	96	"schriftlich: unzulässige Mehrfachnennung"
	;

label define Label_9
	1	"Ja"
	.b	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	9	"Keine Angabe"
	.a	"In CATI nicht erhoben"
	;

label define Label_10
	994	"Wert unplausibel"
	997	"Verweigert"
	999	"Keine Angabe"
	998	"Weiß nicht"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_11
	.i	"Wert unplausibel"
	.g	"Verweigert/Weiß nicht zur Anzahl der Reisen"
	.f	"PAPI: Keine Reisen unternommen"
	.e	"PAPI: Keine Angabe zur Anzahl der Reisen"
	999	"Keine Angabe"
	.h	"Personen ohne Reisen werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_12
	1	"Männlich"
	.a	"Proxy ab 14 Jahre werden nicht befragt"
	2	"Weiblich"
	9	"Keine Angabe"
	;

label define Label_13
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Trifft zu"
	0	"Trifft nicht zu"
	9	"Keine Angabe"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_14
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	.f	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Ja"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_15
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"Personen unter 16 Jahre werden nicht zum Pkw-FHS befragt"
	.f	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.g	"Verweigert/Weiß nicht zum Besitz eines FHS"
	.h	"Personen ohne Führerschein werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Ja"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_16
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.f	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.g	"Verweigert/Weiß nicht zum Besitz eines FHS"
	.h	"Personen ohne Führerschein werden nicht befragt"
	.e	"Personen unter 18 Jahre werden nicht zum Lkw-FHS befragt"
	1	"Ja"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9	"Keine Angabe"
	8	"Weiß nicht"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	;

label define Label_17
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"PAPI: Keine Angabe zum Besitz eines Mofa-FHS"
	.f	"PAPI: Kein Mofa-FHS"
	.g	"Verweigert/weiß nicht zum Besitz eines Mofa-FHS"
	.h	"Personen ohne einen Mofa-FHS werden nicht befragt"
	.i	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.j	"Verweigert/Weiß nicht zum Besitz eines FHS"
	.k	"Personen ohne Führerschein werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	9999	"Keine Angabe"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	9998	"Weiß nicht"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9994	"Wert unplausibel"
	9997	"Verweigert"
	;

label define Label_18
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.g	"Personen unter 16 Jahre werden nicht zum MotorradFHS befragt"
	.i	"Personen ohne einen Motorrad-FHS werden nicht befragt"
	.e	"PAPI: Keine Angabe zum Besitz eines Motorrad-FHS"
	.f	"PAPI: Kein Motorrad-FHS"
	.j	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.h	"Verweigert/weiß nicht zum Besitz eines Motorrad-FHS"
	.l	"Personen ohne Führerschein werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	9999	"Keine Angabe"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	9998	"Weiß nicht"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9994	"Wert unplausibel"
	9997	"Verweigert"
	.k	"Verweigert/Weiß nicht zum Besitz eines FHS"
	;

label define Label_19
	.e	"PAPI: Keine Angabe zum Besitz eines Pkw-FHS"
	.f	"PAPI: Kein Pkw-FHS"
	.i	"Personen unter 16 Jahre werden nicht zum Pkw-FHS befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.h	"Personen ohne einen Pkw-FHS werden nicht befragt"
	.g	"Verweigert/weiß nicht zum Besitz eines Pkw-FHS"
	.k	"Verweigert/Weiß nicht zum Besitz eines FHS"
	.l	"Personen ohne Führerschein werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	9998	"Weiß nicht"
	.j	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9999	"Keine Angabe"
	9994	"Wert unplausibel"
	9997	"Verweigert"
	;

label define Label_20
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"PAPI: Keine Angabe zum Besitz eines Lkw-FHS"
	.f	"PAPI: Kein Lkw-FHS"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.i	"Personen ohne einen Pkw-FHS werden nicht befragt"
	.k	"Verweigert/Weiß nicht zum Besitz eines FHS"
	.l	"Personen ohne Führerschein werden nicht befragt"
	.h	"Verweigert/weiß nicht zum Besitz eines Pkw-FHS"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	9999	"Keine Angabe"
	9998	"Weiß nicht"
	.j	"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	.g	"Personen unter 18 Jahre werden nicht zum Lkw-FHS befragt"
	9994	"Wert unplausibel"
	9997	"Verweigert"
	;

label define Label_21
	11	"Besuche zur Zeit: Realschule"
	10	"Besuche zur Zeit: Hauptschule"
	13	"Besuche zur Zeit: Gesamtschule"
	12	"Besuche zur Zeit: Gymnasium"
	15	"Kind besucht keine Einrichtung"
	14	"eine andere Schule/Einrichtung"
	1	"Schule ohne Abschluss verlassen"
	98	"Weiß nicht"
	3	"Mittlere Reife, Realschulabschluss/POS 10. Klasse"
	2	"Volks- oder Hauptschule/POS 8. Klasse"
	5	"Hochschulreife"
	4	"Fachhochschulreife, Berufsausbildung mit Abitur"
	7	"ich bin noch Schüler(in)"
	6	"anderer Abschluss"
	9	"Besuche zur Zeit: Vorschule/Grundschule"
	.a	"Proxy ab 14 Jahre werden nicht befragt"
	99	"Keine Angabe"
	97	"Verweigert"
	8	"Besuche zur Zeit: Krippe/Kita/Kindergarten"
	;

label define Label_22
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	.f	"Verweigert/Weiß nicht zur Berufstätigkeit"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Vollzeit erwerbstätig"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"geringfügig erwerbstätig"
	2	"Teilzeit erwerbstätig"
	4	"Auszubildende(r)"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	.g	"Personen ohne Berufstätigkeit"
	;

label define Label_23
	99	"Keine Angabe"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	9	"Wehr- oder Zivildienstleistender"
	10	"Sonstiges"
	.g	"Personen mit einer Berufstätigkeit werden nicht befragt"
	.f	"Personen in der Ausbildung werden nicht befragt"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Auszubildender"
	98	"Weiß nicht"
	3	"Schüler(in) weiterführenden Schule"
	2	"Schüler in einer Grundschule"
	5	"zur Zeit arbeitslos"
	4	"Student(in)"
	7	"Hausfrau / Hausmann"
	6	"vorübergehend freigestellt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	97	"Verweigert"
	8	"Rentner(in), Pensionär(in)"
	;

label define Label_24
	11	"mithelfender Familienangehöriger"
	10	"selbständiger Landwirt"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	12	"Sonstiges"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	13	"war noch nie berufstätig"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Arbeiter(in)"
	98	"Weiß nicht"
	3	"Angestellte(r) mit qualifizierter Tätigkeit"
	2	"Angestellte(r) mit einfacher Tätigkeit"
	5	"Beamter(in) im einfachen Dienst"
	4	"Angestellte(r) mit Leitungsaufgaben"
	7	"Beamter(in) im gehobenen/höheren Dienst"
	6	"Beamter(in) im mittleren Dienst"
	9	"selbständig im Handel"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	99	"Keine Angabe"
	97	"Verweigert"
	8	"akademischer freier Beruf"
	;

label define Label_25
	11	"Rentner/in"
	10	"Hausfrau/-mann"
	13	"Anderes"
	12	"Wehr-/Zivildienstleistender"
	.a	"In CATI nicht erhoben"
	1	"Vollzeit erwerbstätig"
	.b	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Geringfügig erwerbstätig"
	2	"Teilzeit erwerbstätig"
	5	"Schüler(in), weiterführende Schule"
	4	"Auszubildende/r"
	7	"Student(in)"
	6	"Schüler(in), sonstige Schule"
	9	"Vorübergehend freigestellt"
	8	"zurzeit Arbeitslos"
	99	"Keine Angabe"
	;

label define Label_26
	11	"selbständiger Landwirt"
	10	"selbständig im Handel"
	13	"Sonstiges"
	12	"mithelfender Familienangehöriger"
	.b	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.a	"In CATI nicht erhoben"
	1	"war noch nie berufstätig"
	98	"Weiß nicht"
	3	"Angestellte(r) mit einfacher Tätigkeit"
	2	"Arbeiter(in)"
	5	"Angestellte(r) mit Leitungsaufgaben"
	4	"Angestellte(r) mit qualifizierter Tätigkeit"
	7	"Beamter(in) im mittleren Dienst"
	6	"Beamter(in) im einfachen Dienst"
	9	"akademischer freier Beruf"
	8	"Beamter(in) im gehobenen/höheren Dienst"
	99	"Keine Angabe"
	97	"Verweigert"
	;

label define Label_27
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.e	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	.f	"CATI: Personen ohne Behinderung werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Ja"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_28
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Seit weniger als einem Jahr"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Seit mehr als zwei Jahren"
	2	"Seit einem bis unter zwei Jahren"
	4	"Seit fünf Jahren oder länger"
	7	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_29
	1	"Sonnig"
	.a	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Stark bewölkt"
	2	"Leicht bewölkt"
	5	"Schnee"
	4	"Regnerisch"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_30
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Personen ohne Altersangaben werden nicht befragt"
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Ja, ständig"
	.c	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Nein, gar nicht"
	2	"Ja, teilweise"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_31
	.a	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	1	"Ja"
	.b	"Aufgrund Filterbedingungen werden Wege nicht erhoben"
	-13	"Personen waren im Ausland"
	2	"Nein"
	-15	"Personen waren nicht außer Haus"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_32
	.a	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	1	"Ja, war ein normaler Wochentag"
	.b	"Aufgrund Filterbedingungen werden Wege nicht erhoben"
	2	"Nein, war kein normaler Wochentag"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_33
	.c	"PAPI: Person verlebte einen normalen Wochentag"
	.b	"PAPI: Keine Angabe zum Verlauf des Wochentags"
	9	"Keine Angabe"
	.e	"Personen verlebten einen normalen Stichtag"
	0	"Trifft nicht zu"
	.d	"Verweigert/Weiß nicht zum Verlauf des Stichtags"
	1	"Trifft zu"
	.f	"Aufgrund Filterbedingungen werden Wege nicht erhoben"
	.a	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	;

label define Label_34
	.d	"PAPI: Person verlebte einen normalen Wochentag"
	.c	"PAPI: Keine Angabe zum Verlauf des Wochentags"
	0	"Trifft nicht zu"
	.a	"In CATI nicht erhoben"
	1	"Trifft zu"
	.b	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	9	"Keine Angabe"
	;

label define Label_35
	.b	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	.d	"Personen verlebten einen normalen Stichtag"
	.a	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Verweigert/Weiß nicht zum Verlauf des Stichtags"
	1	"Trifft zu"
	0	"Trifft nicht zu"
	.e	"Aufgrund Filterbedingungen werden Wege nicht erhoben"
	;

label define Label_36
	.i	"Nicht berufstätig"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.g	"Verweigert/Weiß nicht zu beruflichen Wege"
	.h	"Keine Regelmäßigen beruflichen Wege"
	.l	"Berufstätige ohne Wege am Stichtag"
	.m	"Berufstätige am Stichtag ohne Wegerfassung"
	.j	"Berufstätige macht keine Aussage zu den Wegen am Stichtag"
	.k	"Berufstätige verweigert Aussage zu den Wegen am Stichtag"
	.e	"PAPI: Berufstätige ohne Angaben zu den Wegen"
	.f	"PAPI: Nicht berufstätig "
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Ja"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	9	"Keine Angabe"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_37
	.l	"Berufstätige macht keine Aussage zu den Wegen am Stichtag"
	.f	"PAPI: Berufstätige ohne regelmäßige berufliche Wege"
	.e	"PAPI: Berufstätige ohne Angaben zu den Wegen"
	.h	"PAPI: Nicht berufstätig "
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.k	"Nicht berufstätig"
	1	"Land- und Forstwirtschaft"
	3	"Bergbau"
	2	"Fischerei und Fischzucht"
	5	"Energie- und Wasserversorgung"
	4	"verarbeitendes Gewerbe"
	7	"Handel"
	6	"Baugewerbe"
	9	"Verkehr und Nachrichtenübermittlung"
	8	"Gastgewerbe"
	.i	"Verweigert/Weiß nicht zu beruflichen Wege"
	99	"Keine Angabe"
	98	"weiß nicht"
	.j	"Keine Regelmäßigen beruflichen Wege"
	.n	"Berufstätige ohne Wege am Stichtag"
	.g	"PAPI: Keine Angabe zu den regelmäßigen beruflichen Wege"
	97	"verweigert"
	.o	"Berufstätige am Stichtag ohne Wegerfassung"
	11	"Dienstleistung"
	10	"Kredit- und Versicherungsgewerbe"
	13	"Erziehung und Unterricht"
	12	"öffentliche Verwaltung"
	15	"sonstige Dienstleistungen"
	14	"Gesundheits-, Veterinär- und Sozialwesen"
	17	"andere Branche"
	.m	"Berufstätige verweigert Aussage zu den Wegen am Stichtag"
	16	"exterritoriale Organisationen"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_38
	.f	"PAPI: Berufstätige ohne regelmäßige berufliche Wege"
	.e	"PAPI: Berufstätige ohne Angaben zu den Wegen"
	.h	"PAPI: Nicht berufstätig "
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.k	"Nicht berufstätig"
	1	"Besuch / Besichtigung / Besprechung"
	3	"Sozialdienst / Betreuung"
	2	"Kundendienst / Erledigung"
	5	"Personenbeförderung"
	4	"Transport / Abholung / Zustellung von Waren"
	7	"Verweigert"
	6	"anderer Zweck"
	8	"Weiß nicht"
	.i	"Verweigert/Weiß nicht zu beruflichen Wege"
	99	"PAPI: Keine Angabe"
	.j	"Keine Regelmäßigen beruflichen Wege"
	.g	"PAPI: Keine Angabe zu den regelmäßigen beruflichen Wege"
	.o	"Berufstätige am Stichtag ohne Wegerfassung"
	11	"PAPI: Holen, Bringen, Transportieren von Gütern"
	13	"PAPI: Holen, Bringen, Befördern von Personen"
	12	"PAPI: Fahrt zur Erbringung beruflicher Leistungen"
	.n	"Berufstätige ohne Wege am Stichtag"
	14	"PAPI: Sonstige dienstli. oder geschäftli. Erledigungen"
	.l	"Berufstätige macht keine Aussage zu den Wegen am Stichtag"
	.m	"Berufstätige verweigert Aussage zu den Wegen am Stichtag"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_39
	.k	"Nicht berufstätig"
	99998	"Weiß nicht"
	.i	"Verweigert/Weiß nicht zu beruflichen Wege"
	.j	"Keine Regelmäßigen beruflichen Wege"
	.n	"Berufstätige ohne Wege am Stichtag"
	.o	"Berufstätige am Stichtag ohne Wegerfassung"
	.l	"Berufstätige macht keine Aussage zu den Wegen am Stichtag"
	.m	"Berufstätige verweigert Aussage zu den Wegen am Stichtag"
	99999	"Keine Angabe"
	.f	"PAPI: Berufstätige ohne regelmäßige berufliche Wege"
	.e	"PAPI: Berufstätige ohne Angaben zu den Wegen"
	.h	"PAPI: Nicht berufstätig "
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	99997	"Verweigert"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	.g	"PAPI: Keine Angabe zu den regelmäßigen beruflichen Wege"
	;

label define Label_40
	.f	"PAPI: Berufstätige ohne regelmäßige berufliche Wege"
	.e	"PAPI: Berufstätige ohne Angaben zu den Wegen"
	.h	"PAPI: Nicht berufstätig "
	.a	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	.k	"Nicht berufstätig"
	1	"zu Fuß"
	3	"Moped, Mofa"
	2	"Fahrrad"
	5	"privater Pkw"
	4	"Motorrad"
	7	"LKW bis 3,5 t Nutzlast"
	6	"gewerblicher Pkw"
	9	"Zugmaschine"
	8	"LKW über 3,5 t Nutzlast"
	13	"Flugzeug"
	99	"Keine Angabe"
	98	"Weiß nicht"
	12	"Bahn"
	.g	"PAPI: Keine Angabe zu den regelmäßigen beruflichen Wege"
	97	"Verweigert"
	14	"anderes Verkehrsmittel"
	11	"Bus"
	10	"Kleinbus"
	.i	"Verweigert/Weiß nicht zu beruflichen Wege"
	.j	"Keine Regelmäßigen beruflichen Wege"
	.n	"Berufstätige ohne Wege am Stichtag"
	.o	"Berufstätige am Stichtag ohne Wegerfassung"
	.l	"Berufstätige macht keine Aussage zu den Wegen am Stichtag"
	.m	"Berufstätige verweigert Aussage zu den Wegen am Stichtag"
	.b	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	.d	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	.c	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_41
	-20	"Aufgrund Filterbedingungen Wege nicht berechnet"
	-10	"Aufgrund Filterbedingungen Wege nicht erfasst"
	-13	"PAPI:Erwachsene mit weniger als 7 Wegen werden nicht befragt"
	-12	"Personen mit weniger als 8 Wegen werden nicht befragt"
	-15	"PAPI:Keine Angaben in der Wegematrix"
	-14	"PAPI:Kinder mit weniger als 6 Wegen werden nicht befragt"
	;

label define Label_42
	.a	"Aufgrund Filterbedingungen Wege nicht berechnet"
	997	"Verweigert"
	999	"Keine Angabe"
	;

label define Label_43
	1	"Eher gehoben"
	3	"Eher einfach"
	2	"Mittlere Wohnlage"
	4	"Keine dieser Wohnanlage"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_44
	.b	"Person unter 18 Jahre wird nicht befragt"
	.a	"CATI: Befragte ohne Altersangabe werden nicht befragt"
	1	"bis unter 500 € pro Monat"
	98	"weiß nicht"
	3	"900 € bis unter 1.500 €"
	2	"500 € bis unter 900 €"
	5	"2.000 € bis unter 2.600 €"
	4	"1.500 € bis unter 2.000 €"
	7	"3.000 € bis unter 3.600 €"
	6	"2.600 € bis unter 3.000 €"
	99	"Keine Angabe"
	8	"3.600 € und mehr pro Monat"
	97	"verweigert"
	96	"Doppelnennung"
	;

label define Label_45
	11	"Mehrpersonenhaushalte"
	10	"Auszubildende, Schüler"
	12	"Nicht zugeordnet aufgrund fehlender Nennungen"
	1	"Alleinstehende Rentner"
	3	"Alleinlebende"
	2	"Rentner Haushalte"
	5	"Erwachsenen Haushalte"
	4	"Zusammenlebende"
	7	"Haushalte mit Kleinkindern"
	6	"Haushalte mit Schulkindern"
	9	"Studenten"
	8	"Alleinerziehende"
	;

label define Label_46
	1	"Wenig-Mobile"
	3	"ÖPNV-Captives"
	2	"Fahrradfahrer"
	5	"ÖPNV-Gelegenheitskunden"
	4	"ÖPNV-Stammkunden"
	7	"IV-Stammkunden"
	6	"ÖPNV-Potential"
	9	"Keine Angabe"
	-1	"Nicht zu zuordnen aufgrund Erhebungsform"
	8	"Nicht-Kunden"
	;

label define Label_47
	1	"Erwerbstätige mit verfügbarem Pkw"
	99	"Nicht zu zuordnen"
	3	"Nichterwerbstätige mit verfügbarem Pkw"
	2	"Erwerbstätige ohne Pkw"
	5	"Studenten"
	4	"Nichterwerbstätige ohne Pkw"
	7	"Kinder unter 6 Jahren (immobil)"
	6	"Auszubildende"
	9	"Schüler ab 10 Jahren"
	8	"Schüler unter 10 Jahren"
	;

label define Label_48
	11	"Schüler ab 10 Jahren  mit verfügbarem Pkw"
	10	"Schüler unter 10 Jahren"
	12	"Schüler ab 10 Jahren ohne Pkw"
	1	"Erwerbstätige mit verfügbarem Pkw"
	99	"Nicht zu zuordnen"
	3	"Nichterwerbstätige mit verfügbarem Pkw"
	2	"Erwerbstätige ohne Pkw"
	5	"Studenten  mit verfügbarem Pkw"
	4	"Nichterwerbstätige ohne Pkw"
	7	"Auszubildende  mit verfügbarem Pkw"
	6	"Studenten  ohne Pkw"
	9	"Kinder unter 6 Jahren (immobil)"
	8	"Auszubildende  ohne Pkw"
	;

label define Label_49
	1	"Papi: Erwachsenen-Fragebogen"
	3	"CATI: Switcher, HH-Ebene schriftlich, PW-Ebene telephonisch"
	2	"Papi: Kinder-Fragebogen"
	4	"CATI: HH-Ebene telephonisch, PW-Ebene telephonisch"
	;

label define Label_50
	1	"Selbst"
	2	"Proxy"
	-1	"Nur als PAPI befragt"
	;

label define Label_51
	1	"Selbst ab 14 Jahren"
	3	"Selbst unter 14 Jahren"
	2	"Proxy ab 14 Jahren"
	5	"PAPI: Erwachsenen-Fragebogen"
	4	"Proxy unter 14 Jahren"
	7	"PAPI: Kinder-Fragebogen: zusammen mit Eltern ausgefüllt"
	6	"PAPI: Kinder-Fragebogen: Selbst ausgefüllt"
	9	"PAPI: Kinder-Fragebogen: Keine Angabe zur Auskunftsperson"
	8	"PAPI: Kinder-Fragebogen: Eltern ausgefüllt"
	;

label define Label_52
	11	"Berlin"
	10	"Saarland"
	13	"Mecklenburg-Vorpommern"
	12	"Brandenburg"
	15	"Sachsen-Anhalt"
	14	"Sachsen"
	16	"Thüringen"
	1	"Schleswig-Holstein"
	3	"Niedersachsen"
	2	"Hamburg"
	5	"Nordrhein-Westfalen"
	4	"Bremen"
	7	"Rheinland-Pfalz"
	6	"Hessen"
	9	"Bayern"
	8	"Baden-Württemberg"
	;

label define Label_53
	1	"West"
	2	"Ost"
	;

label define Label_54
	1	"u 2000"
	3	"5000 - u 20000"
	2	"2000 - u 5000"
	5	"50000 - u 100000"
	4	"20000 - u 50000"
	7	"500000+ "
	6	"100000 - u 500000"
	;

label define Label_55
	10	"500000+ Kern"
	1	"unter 2000"
	3	"5000 - u. 20000"
	2	"2000 - u. 5000"
	5	"50000 - u. 100000 Rest"
	4	"20000 - u. 50000"
	7	"100000 - u. 500000 Rest"
	6	"50000 - u. 100000 Kern"
	9	"500000+ Rest"
	8	"100000 - u. 500000 Kern"
	;

label define Label_56
	1	"Agglomerationsräume (Regionstyp 1)"
	3	"Ländliche Räume (Regionstyp 3)"
	2	"Verstädterte Räume (Regionstyp 2)"
	;

label define Label_57
	1	"Hochverdichtete Agglomerationsräume"
	3	"Verstädterte Räume höherer Dichte"
	2	"Agglomerationsräume mit herausragenden Zentren"
	5	"Verstädterte Räume mittlerer Dichte ohne Oberzentren"
	4	"Verstädterte Räume mittlerer Dichte mit Oberzentren"
	7	"Ländliche Räume geringerer Dichte"
	6	"Ländliche Räume höherer Dichte"
	;

label define Label_58
	1	"Agglomerationsräume Kernstädte"
	3	"Agglomerationsräume verdichtete Kreise"
	2	"Agglomerationsräume hochverdichtete Kreise"
	5	"Verstädterte Räume Kernstädte"
	4	"Agglomerationsräume ländliche Kreise"
	7	"Verstädterte Räume ländliche Kreise"
	6	"Verstädterte Räume verdichtete Kreise"
	9	"Ländliche Räume ländliche Kreise geringerer Dichte"
	8	"Ländliche Räume ländliche Kreise höherer Dichte"
	;

label define Label_59
	1	"Montag"
	3	"Mittwoch"
	2	"Dienstag"
	5	"Freitag"
	4	"Donnerstag"
	7	"Sonntag"
	6	"Samstag"
	;

label define Label_60
	.a	"Person am Stichtag nicht mobil"
	.d	"Filterbed.: Selbst ohne Wegebl., 3-Tage-Regel, keine Wegeerf"
	.e	"aufgrund fehlender Nennungen nicht berechenbar"
	.b	"Wegeinformation k.A. oder verweigert"
	.c	"Filterbed.:  Proxy ohne Wegeblatt, keine Wegeerfass."
	;

label define Label_61
	.a	"Nicht berechenbar"
	997	"Verweigert"
	998	"Weiß nicht"
	;

label define Label_62
	.a	"Person am Stichtag nicht mobil"
	.d	"Filterbed.: Selbst ohne Wegebl., 3-Tage-Regel, keine Wegeerf"
	9994	"Wegetempo unplausibel"
	.b	"Wegeinformation k.A. oder verweigert"
	.c	"Filterbed.:  Proxy ohne Wegeblatt, keine Wegeerfass."
	;

label define Label_63
	.a	"Person am Stichtag nicht mobil"
	.d	"Filterbed.: Selbst ohne Wegebl., 3-Tage-Regel, keine Wegeerf"
	.e	"aufgrund fehlender Nennungen nicht berechenbar"
	.b	"Wegeinformation k.A. oder verweigert"
	.c	"Filterbed.:  Proxy ohne Wegeblatt, keine Wegeerfass."
	;

label define Label_64
	1	"von Dir alleine"
	3	"nur von den Eltern"
	2	"von Dir zusammen mit Deinen Eltern"
	.b	"CATI-Interview"
	.a	"Schriftlicher Fragebogen für Personen ab 14 Jahre"
	9	"Keine Angabe"
	;

label define Label_65
	1	"mobil am Stichtag"
	0	"nicht mobil am Stichtag"
	2	"nicht bekannt"
	.b	"Filterbed.: Selbst ohne Wegeblatt, 3-Tage-Regel, keine Wegee"
	.a	"Filterbed.:  Proxy ohne Wegeblatt, keine Wegeerfass."
	;

label define Label_66
	1	"CATI"
	2	"PEN"
	;

label define Label_67
	1	"CATI: Erwachs ab 14J, Selbst befragt"
	3	"CATI: Kind 10-13J, Selbst befragt"
	2	"CATI: Erwachs ab 14J, Stellvertreterint."
	-1	"schriftliches Interview"
	4	"CATI: Kind 10-13J, Stellvertreterint."
	5	"CATI: Kind 0-9J, Stellvertreterint."
	;

label define Label_68
	1	"HH-Int schriftlich, Pers/Wegeinterview CATI"
	0	"HH/Pers/Wegeinterview CATI"
	-1	"HH/Pers/Wegeinterview schriftlich"
	;


*label Values and recode missings: ;

label values p01 Label_0;
quietly recode p02 (-400 = .a);
quietly recode p02 (-300 = .b);
quietly recode p02 (-200 = .c);
quietly recode p02 (-150 = .d);
quietly recode p02 (-41 = .e);
quietly recode p02 (-36 = .f);
quietly recode p02 (-35 = .g);
quietly recode p02 (-34 = .h);
quietly recode p02 (-399/-301 = .);
quietly recode p02 (-299/-201 = .);
quietly recode p02 (-199/-151 = .);
quietly recode p02 (-149/-42 = .);
quietly recode p02 (-40/-37 = .);
label values p02 Label_1;
quietly recode p021 (-400 = .a);
quietly recode p021 (-300 = .b);
quietly recode p021 (-200 = .c);
quietly recode p021 (-150 = .d);
quietly recode p021 (-100 = .e);
quietly recode p021 (-22 = .f);
quietly recode p021 (-21 = .g);
quietly recode p021 (-399/-301 = .);
quietly recode p021 (-299/-201 = .);
quietly recode p021 (-199/-151 = .);
quietly recode p021 (-149/-101 = .);
quietly recode p021 (-99/-23 = .);
label values p021 Label_2;
quietly recode p022 (-400 = .a);
quietly recode p022 (-300 = .b);
quietly recode p022 (-200 = .c);
quietly recode p022 (-150 = .d);
quietly recode p022 (-100 = .e);
quietly recode p022 (-22 = .f);
quietly recode p022 (-21 = .g);
quietly recode p022 (-399/-301 = .);
quietly recode p022 (-299/-201 = .);
quietly recode p022 (-199/-151 = .);
quietly recode p022 (-149/-101 = .);
quietly recode p022 (-99/-23 = .);
label values p022 Label_3;
quietly recode p033 (-400 = .a);
quietly recode p033 (-300 = .b);
quietly recode p033 (-200 = .c);
quietly recode p033 (-150 = .d);
quietly recode p033 (-399/-301 = .);
quietly recode p033 (-299/-201 = .);
quietly recode p033 (-199/-151 = .);
label values p033 Label_4;
quietly recode p031 (-400 = .a);
quietly recode p031 (-300 = .b);
quietly recode p031 (-200 = .c);
quietly recode p031 (-150 = .d);
quietly recode p031 (-399/-301 = .);
quietly recode p031 (-299/-201 = .);
quietly recode p031 (-199/-151 = .);
label values p031 Label_4;
quietly recode p032 (-400 = .a);
quietly recode p032 (-300 = .b);
quietly recode p032 (-200 = .c);
quietly recode p032 (-150 = .d);
quietly recode p032 (-399/-301 = .);
quietly recode p032 (-299/-201 = .);
quietly recode p032 (-199/-151 = .);
label values p032 Label_4;
quietly recode p034 (-400 = .a);
quietly recode p034 (-300 = .b);
quietly recode p034 (-200 = .c);
quietly recode p034 (-150 = .d);
quietly recode p034 (-399/-301 = .);
quietly recode p034 (-299/-201 = .);
quietly recode p034 (-199/-151 = .);
label values p034 Label_4;
quietly recode p051 (-400 = .a);
quietly recode p051 (-300 = .b);
quietly recode p051 (-200 = .c);
quietly recode p051 (-150 = .d);
quietly recode p051 (-399/-301 = .);
quietly recode p051 (-299/-201 = .);
quietly recode p051 (-199/-151 = .);
label values p051 Label_5;
quietly recode p052 (-400 = .a);
quietly recode p052 (-300 = .b);
quietly recode p052 (-200 = .c);
quietly recode p052 (-150 = .d);
quietly recode p052 (-399/-301 = .);
quietly recode p052 (-299/-201 = .);
quietly recode p052 (-199/-151 = .);
label values p052 Label_6;
quietly recode p053 (-400 = .a);
quietly recode p053 (-300 = .b);
quietly recode p053 (-200 = .c);
quietly recode p053 (-150 = .d);
quietly recode p053 (-399/-301 = .);
quietly recode p053 (-299/-201 = .);
quietly recode p053 (-199/-151 = .);
label values p053 Label_5;
quietly recode p054 (-400 = .a);
quietly recode p054 (-300 = .b);
quietly recode p054 (-200 = .c);
quietly recode p054 (-150 = .d);
quietly recode p054 (-399/-301 = .);
quietly recode p054 (-299/-201 = .);
quietly recode p054 (-199/-151 = .);
label values p054 Label_6;
quietly recode p041 (-400 = .a);
quietly recode p041 (-300 = .b);
quietly recode p041 (-200 = .c);
quietly recode p041 (-150 = .d);
quietly recode p041 (-399/-301 = .);
quietly recode p041 (-299/-201 = .);
quietly recode p041 (-199/-151 = .);
label values p041 Label_7;
quietly recode p042 (-400 = .a);
quietly recode p042 (-300 = .b);
quietly recode p042 (-200 = .c);
quietly recode p042 (-150 = .d);
quietly recode p042 (-399/-301 = .);
quietly recode p042 (-299/-201 = .);
quietly recode p042 (-199/-151 = .);
label values p042 Label_7;
quietly recode p07 (-400 = .a);
quietly recode p07 (-300 = .b);
quietly recode p07 (-200 = .c);
quietly recode p07 (-150 = .d);
quietly recode p07 (-399/-301 = .);
quietly recode p07 (-299/-201 = .);
quietly recode p07 (-199/-151 = .);
label values p07 Label_8;
quietly recode p10as (-175 = .a);
quietly recode p10as (-150 = .b);
quietly recode p10as (-174/-151 = .);
label values p10as Label_9;
quietly recode p10 (-400 = .a);
quietly recode p10 (-300 = .b);
quietly recode p10 (-200 = .c);
quietly recode p10 (-150 = .d);
quietly recode p10 (-399/-301 = .);
quietly recode p10 (-299/-201 = .);
quietly recode p10 (-199/-151 = .);
label values p10 Label_10;
quietly recode p101_1 (994.0 = .i);
quietly recode p101_1 (-400 = .a);
quietly recode p101_1 (-300 = .b);
quietly recode p101_1 (-200 = .c);
quietly recode p101_1 (-150 = .d);
quietly recode p101_1 (-41 = .e);
quietly recode p101_1 (-40 = .f);
quietly recode p101_1 (-33 = .g);
quietly recode p101_1 (-32 = .h);
quietly recode p101_1 (-399/-301 = .);
quietly recode p101_1 (-299/-201 = .);
quietly recode p101_1 (-199/-151 = .);
quietly recode p101_1 (-149/-42 = .);
quietly recode p101_1 (-39/-34 = .);
label values p101_1 Label_11;
quietly recode p101_2 (994.0 = .i);
quietly recode p101_2 (-400 = .a);
quietly recode p101_2 (-300 = .b);
quietly recode p101_2 (-200 = .c);
quietly recode p101_2 (-150 = .d);
quietly recode p101_2 (-41 = .e);
quietly recode p101_2 (-40 = .f);
quietly recode p101_2 (-33 = .g);
quietly recode p101_2 (-32 = .h);
quietly recode p101_2 (-399/-301 = .);
quietly recode p101_2 (-299/-201 = .);
quietly recode p101_2 (-199/-151 = .);
quietly recode p101_2 (-149/-42 = .);
quietly recode p101_2 (-39/-34 = .);
label values p101_2 Label_11;
quietly recode p101_3 (994.0 = .i);
quietly recode p101_3 (-400 = .a);
quietly recode p101_3 (-300 = .b);
quietly recode p101_3 (-200 = .c);
quietly recode p101_3 (-150 = .d);
quietly recode p101_3 (-41 = .e);
quietly recode p101_3 (-40 = .f);
quietly recode p101_3 (-33 = .g);
quietly recode p101_3 (-32 = .h);
quietly recode p101_3 (-399/-301 = .);
quietly recode p101_3 (-299/-201 = .);
quietly recode p101_3 (-199/-151 = .);
quietly recode p101_3 (-149/-42 = .);
quietly recode p101_3 (-39/-34 = .);
label values p101_3 Label_11;
quietly recode p101_4 (994.0 = .i);
quietly recode p101_4 (-400 = .a);
quietly recode p101_4 (-300 = .b);
quietly recode p101_4 (-200 = .c);
quietly recode p101_4 (-150 = .d);
quietly recode p101_4 (-41 = .e);
quietly recode p101_4 (-40 = .f);
quietly recode p101_4 (-33 = .g);
quietly recode p101_4 (-32 = .h);
quietly recode p101_4 (-399/-301 = .);
quietly recode p101_4 (-299/-201 = .);
quietly recode p101_4 (-199/-151 = .);
quietly recode p101_4 (-149/-42 = .);
quietly recode p101_4 (-39/-34 = .);
label values p101_4 Label_11;
quietly recode p102_1 (994.0 = .i);
quietly recode p102_1 (-400 = .a);
quietly recode p102_1 (-300 = .b);
quietly recode p102_1 (-200 = .c);
quietly recode p102_1 (-150 = .d);
quietly recode p102_1 (-41 = .e);
quietly recode p102_1 (-40 = .f);
quietly recode p102_1 (-33 = .g);
quietly recode p102_1 (-32 = .h);
quietly recode p102_1 (-399/-301 = .);
quietly recode p102_1 (-299/-201 = .);
quietly recode p102_1 (-199/-151 = .);
quietly recode p102_1 (-149/-42 = .);
quietly recode p102_1 (-39/-34 = .);
label values p102_1 Label_11;
quietly recode p102_2 (994.0 = .i);
quietly recode p102_2 (-400 = .a);
quietly recode p102_2 (-300 = .b);
quietly recode p102_2 (-200 = .c);
quietly recode p102_2 (-150 = .d);
quietly recode p102_2 (-41 = .e);
quietly recode p102_2 (-40 = .f);
quietly recode p102_2 (-33 = .g);
quietly recode p102_2 (-32 = .h);
quietly recode p102_2 (-399/-301 = .);
quietly recode p102_2 (-299/-201 = .);
quietly recode p102_2 (-199/-151 = .);
quietly recode p102_2 (-149/-42 = .);
quietly recode p102_2 (-39/-34 = .);
label values p102_2 Label_11;
quietly recode p102_3 (994.0 = .i);
quietly recode p102_3 (-400 = .a);
quietly recode p102_3 (-300 = .b);
quietly recode p102_3 (-200 = .c);
quietly recode p102_3 (-150 = .d);
quietly recode p102_3 (-41 = .e);
quietly recode p102_3 (-40 = .f);
quietly recode p102_3 (-33 = .g);
quietly recode p102_3 (-32 = .h);
quietly recode p102_3 (-399/-301 = .);
quietly recode p102_3 (-299/-201 = .);
quietly recode p102_3 (-199/-151 = .);
quietly recode p102_3 (-149/-42 = .);
quietly recode p102_3 (-39/-34 = .);
label values p102_3 Label_11;
quietly recode p102_4 (994.0 = .i);
quietly recode p102_4 (-400 = .a);
quietly recode p102_4 (-300 = .b);
quietly recode p102_4 (-200 = .c);
quietly recode p102_4 (-150 = .d);
quietly recode p102_4 (-41 = .e);
quietly recode p102_4 (-40 = .f);
quietly recode p102_4 (-33 = .g);
quietly recode p102_4 (-32 = .h);
quietly recode p102_4 (-399/-301 = .);
quietly recode p102_4 (-299/-201 = .);
quietly recode p102_4 (-199/-151 = .);
quietly recode p102_4 (-149/-42 = .);
quietly recode p102_4 (-39/-34 = .);
label values p102_4 Label_11;
quietly recode p102_5 (994.0 = .i);
quietly recode p102_5 (-400 = .a);
quietly recode p102_5 (-300 = .b);
quietly recode p102_5 (-200 = .c);
quietly recode p102_5 (-150 = .d);
quietly recode p102_5 (-41 = .e);
quietly recode p102_5 (-40 = .f);
quietly recode p102_5 (-33 = .g);
quietly recode p102_5 (-32 = .h);
quietly recode p102_5 (-399/-301 = .);
quietly recode p102_5 (-299/-201 = .);
quietly recode p102_5 (-199/-151 = .);
quietly recode p102_5 (-149/-42 = .);
quietly recode p102_5 (-39/-34 = .);
label values p102_5 Label_11;
quietly recode p102_6 (994.0 = .i);
quietly recode p102_6 (-400 = .a);
quietly recode p102_6 (-300 = .b);
quietly recode p102_6 (-200 = .c);
quietly recode p102_6 (-150 = .d);
quietly recode p102_6 (-41 = .e);
quietly recode p102_6 (-40 = .f);
quietly recode p102_6 (-33 = .g);
quietly recode p102_6 (-32 = .h);
quietly recode p102_6 (-399/-301 = .);
quietly recode p102_6 (-299/-201 = .);
quietly recode p102_6 (-199/-151 = .);
quietly recode p102_6 (-149/-42 = .);
quietly recode p102_6 (-39/-34 = .);
label values p102_6 Label_11;
quietly recode p11 (-200.0 = .a);
label values p11 Label_12;
quietly recode p12_1 (-400 = .a);
quietly recode p12_1 (-300 = .b);
quietly recode p12_1 (-200 = .c);
quietly recode p12_1 (-150 = .d);
quietly recode p12_1 (-399/-301 = .);
quietly recode p12_1 (-299/-201 = .);
quietly recode p12_1 (-199/-151 = .);
label values p12_1 Label_13;
quietly recode p12_2 (-400 = .a);
quietly recode p12_2 (-300 = .b);
quietly recode p12_2 (-200 = .c);
quietly recode p12_2 (-150 = .d);
quietly recode p12_2 (-399/-301 = .);
quietly recode p12_2 (-299/-201 = .);
quietly recode p12_2 (-199/-151 = .);
label values p12_2 Label_13;
quietly recode p12_3 (-400 = .a);
quietly recode p12_3 (-300 = .b);
quietly recode p12_3 (-200 = .c);
quietly recode p12_3 (-150 = .d);
quietly recode p12_3 (-399/-301 = .);
quietly recode p12_3 (-299/-201 = .);
quietly recode p12_3 (-199/-151 = .);
label values p12_3 Label_13;
quietly recode p12_4 (-400 = .a);
quietly recode p12_4 (-300 = .b);
quietly recode p12_4 (-200 = .c);
quietly recode p12_4 (-150 = .d);
quietly recode p12_4 (-399/-301 = .);
quietly recode p12_4 (-299/-201 = .);
quietly recode p12_4 (-199/-151 = .);
label values p12_4 Label_13;
quietly recode p12_5 (-400 = .a);
quietly recode p12_5 (-300 = .b);
quietly recode p12_5 (-200 = .c);
quietly recode p12_5 (-150 = .d);
quietly recode p12_5 (-399/-301 = .);
quietly recode p12_5 (-299/-201 = .);
quietly recode p12_5 (-199/-151 = .);
label values p12_5 Label_13;
quietly recode p13 (-400 = .a);
quietly recode p13 (-300 = .b);
quietly recode p13 (-200 = .c);
quietly recode p13 (-150 = .d);
quietly recode p13 (-399/-301 = .);
quietly recode p13 (-299/-201 = .);
quietly recode p13 (-199/-151 = .);
label values p13 Label_5;
quietly recode p06 (-400 = .a);
quietly recode p06 (-300 = .b);
quietly recode p06 (-200 = .c);
quietly recode p06 (-150 = .d);
quietly recode p06 (-100 = .e);
quietly recode p06 (-36 = .f);
quietly recode p06 (-399/-301 = .);
quietly recode p06 (-299/-201 = .);
quietly recode p06 (-199/-151 = .);
quietly recode p06 (-149/-101 = .);
quietly recode p06 (-99/-37 = .);
label values p06 Label_14;
quietly recode p061_1 (-400 = .a);
quietly recode p061_1 (-300 = .b);
quietly recode p061_1 (-200 = .c);
quietly recode p061_1 (-150 = .d);
quietly recode p061_1 (-41 = .e);
quietly recode p061_1 (-36 = .f);
quietly recode p061_1 (-35 = .g);
quietly recode p061_1 (-34 = .h);
quietly recode p061_1 (-399/-301 = .);
quietly recode p061_1 (-299/-201 = .);
quietly recode p061_1 (-199/-151 = .);
quietly recode p061_1 (-149/-42 = .);
quietly recode p061_1 (-40/-37 = .);
label values p061_1 Label_1;
quietly recode p061_2 (-400 = .a);
quietly recode p061_2 (-300 = .b);
quietly recode p061_2 (-200 = .c);
quietly recode p061_2 (-150 = .d);
quietly recode p061_2 (-41 = .e);
quietly recode p061_2 (-36 = .f);
quietly recode p061_2 (-35 = .g);
quietly recode p061_2 (-34 = .h);
quietly recode p061_2 (-399/-301 = .);
quietly recode p061_2 (-299/-201 = .);
quietly recode p061_2 (-199/-151 = .);
quietly recode p061_2 (-149/-42 = .);
quietly recode p061_2 (-40/-37 = .);
label values p061_2 Label_1;
quietly recode p061_3 (-400 = .a);
quietly recode p061_3 (-300 = .b);
quietly recode p061_3 (-200 = .c);
quietly recode p061_3 (-150 = .d);
quietly recode p061_3 (-41 = .e);
quietly recode p061_3 (-36 = .f);
quietly recode p061_3 (-35 = .g);
quietly recode p061_3 (-34 = .h);
quietly recode p061_3 (-399/-301 = .);
quietly recode p061_3 (-299/-201 = .);
quietly recode p061_3 (-199/-151 = .);
quietly recode p061_3 (-149/-42 = .);
quietly recode p061_3 (-40/-37 = .);
label values p061_3 Label_15;
quietly recode p061_4 (-400 = .a);
quietly recode p061_4 (-300 = .b);
quietly recode p061_4 (-200 = .c);
quietly recode p061_4 (-150 = .d);
quietly recode p061_4 (-45 = .e);
quietly recode p061_4 (-36 = .f);
quietly recode p061_4 (-35 = .g);
quietly recode p061_4 (-34 = .h);
quietly recode p061_4 (-399/-301 = .);
quietly recode p061_4 (-299/-201 = .);
quietly recode p061_4 (-199/-151 = .);
quietly recode p061_4 (-149/-46 = .);
quietly recode p061_4 (-44/-37 = .);
label values p061_4 Label_16;
quietly recode p061_1j (-400 = .a);
quietly recode p061_1j (-300 = .b);
quietly recode p061_1j (-200 = .c);
quietly recode p061_1j (-150 = .d);
quietly recode p061_1j (-51 = .e);
quietly recode p061_1j (-50 = .f);
quietly recode p061_1j (-38 = .g);
quietly recode p061_1j (-37 = .h);
quietly recode p061_1j (-36 = .i);
quietly recode p061_1j (-35 = .j);
quietly recode p061_1j (-34 = .k);
quietly recode p061_1j (-399/-301 = .);
quietly recode p061_1j (-299/-201 = .);
quietly recode p061_1j (-199/-151 = .);
quietly recode p061_1j (-149/-52 = .);
quietly recode p061_1j (-49/-39 = .);
label values p061_1j Label_17;
quietly recode p061_2j (-400 = .a);
quietly recode p061_2j (-300 = .b);
quietly recode p061_2j (-200 = .c);
quietly recode p061_2j (-150 = .d);
quietly recode p061_2j (-53 = .e);
quietly recode p061_2j (-52 = .f);
quietly recode p061_2j (-41 = .g);
quietly recode p061_2j (-40 = .h);
quietly recode p061_2j (-39 = .i);
quietly recode p061_2j (-36 = .j);
quietly recode p061_2j (-35 = .k);
quietly recode p061_2j (-34 = .l);
quietly recode p061_2j (-399/-301 = .);
quietly recode p061_2j (-299/-201 = .);
quietly recode p061_2j (-199/-151 = .);
quietly recode p061_2j (-149/-54 = .);
quietly recode p061_2j (-51/-42 = .);
quietly recode p061_2j (-38/-37 = .);
label values p061_2j Label_18;
quietly recode p061_3j (-400 = .a);
quietly recode p061_3j (-300 = .b);
quietly recode p061_3j (-200 = .c);
quietly recode p061_3j (-150 = .d);
quietly recode p061_3j (-55 = .e);
quietly recode p061_3j (-54 = .f);
quietly recode p061_3j (-43 = .g);
quietly recode p061_3j (-42 = .h);
quietly recode p061_3j (-41 = .i);
quietly recode p061_3j (-36 = .j);
quietly recode p061_3j (-35 = .k);
quietly recode p061_3j (-34 = .l);
quietly recode p061_3j (-399/-301 = .);
quietly recode p061_3j (-299/-201 = .);
quietly recode p061_3j (-199/-151 = .);
quietly recode p061_3j (-149/-56 = .);
quietly recode p061_3j (-53/-44 = .);
quietly recode p061_3j (-40/-37 = .);
label values p061_3j Label_19;
quietly recode p061_4j (-400 = .a);
quietly recode p061_4j (-300 = .b);
quietly recode p061_4j (-200 = .c);
quietly recode p061_4j (-150 = .d);
quietly recode p061_4j (-57 = .e);
quietly recode p061_4j (-56 = .f);
quietly recode p061_4j (-45 = .g);
quietly recode p061_4j (-44 = .h);
quietly recode p061_4j (-43 = .i);
quietly recode p061_4j (-36 = .j);
quietly recode p061_4j (-35 = .k);
quietly recode p061_4j (-34 = .l);
quietly recode p061_4j (-399/-301 = .);
quietly recode p061_4j (-299/-201 = .);
quietly recode p061_4j (-199/-151 = .);
quietly recode p061_4j (-149/-58 = .);
quietly recode p061_4j (-55/-46 = .);
quietly recode p061_4j (-42/-37 = .);
label values p061_4j Label_20;
quietly recode p14 (-200.0 = .a);
label values p14 Label_21;
quietly recode p15 (-400 = .a);
quietly recode p15 (-300 = .b);
quietly recode p15 (-200 = .c);
quietly recode p15 (-150 = .d);
quietly recode p15 (-100 = .e);
quietly recode p15 (-36 = .f);
quietly recode p15 (-399/-301 = .);
quietly recode p15 (-299/-201 = .);
quietly recode p15 (-199/-151 = .);
quietly recode p15 (-149/-101 = .);
quietly recode p15 (-99/-37 = .);
label values p15 Label_14;
quietly recode p16 (-400 = .a);
quietly recode p16 (-300 = .b);
quietly recode p16 (-200 = .c);
quietly recode p16 (-150 = .d);
quietly recode p16 (-100 = .e);
quietly recode p16 (-24 = .f);
quietly recode p16 (-23 = .g);
quietly recode p16 (-399/-301 = .);
quietly recode p16 (-299/-201 = .);
quietly recode p16 (-199/-151 = .);
quietly recode p16 (-149/-101 = .);
quietly recode p16 (-99/-25 = .);
label values p16 Label_22;
quietly recode p17 (-400 = .a);
quietly recode p17 (-300 = .b);
quietly recode p17 (-200 = .c);
quietly recode p17 (-150 = .d);
quietly recode p17 (-100 = .e);
quietly recode p17 (-26 = .f);
quietly recode p17 (-25 = .g);
quietly recode p17 (-399/-301 = .);
quietly recode p17 (-299/-201 = .);
quietly recode p17 (-199/-151 = .);
quietly recode p17 (-149/-101 = .);
quietly recode p17 (-99/-27 = .);
label values p17 Label_23;
quietly recode p18 (-400 = .a);
quietly recode p18 (-300 = .b);
quietly recode p18 (-200 = .c);
quietly recode p18 (-150 = .d);
quietly recode p18 (-100 = .e);
quietly recode p18 (-399/-301 = .);
quietly recode p18 (-299/-201 = .);
quietly recode p18 (-199/-151 = .);
quietly recode p18 (-149/-101 = .);
label values p18 Label_24;
quietly recode p17s (-175.0 = .a);
quietly recode p17s (-150.0 = .b);
quietly recode p17s (-174.0/-151 = .);
label values p17s Label_25;
quietly recode p18s (-175.0 = .a);
quietly recode p18s (-150.0 = .b);
quietly recode p18s (-174.0/-151 = .);
label values p18s Label_26;
quietly recode p09_1 (-400 = .a);
quietly recode p09_1 (-300 = .b);
quietly recode p09_1 (-200 = .c);
quietly recode p09_1 (-150 = .d);
quietly recode p09_1 (-399/-301 = .);
quietly recode p09_1 (-299/-201 = .);
quietly recode p09_1 (-199/-151 = .);
label values p09_1 Label_13;
quietly recode p09_2 (-400 = .a);
quietly recode p09_2 (-300 = .b);
quietly recode p09_2 (-200 = .c);
quietly recode p09_2 (-150 = .d);
quietly recode p09_2 (-399/-301 = .);
quietly recode p09_2 (-299/-201 = .);
quietly recode p09_2 (-199/-151 = .);
label values p09_2 Label_13;
quietly recode p09_3 (-400 = .a);
quietly recode p09_3 (-300 = .b);
quietly recode p09_3 (-200 = .c);
quietly recode p09_3 (-150 = .d);
quietly recode p09_3 (-399/-301 = .);
quietly recode p09_3 (-299/-201 = .);
quietly recode p09_3 (-199/-151 = .);
label values p09_3 Label_13;
quietly recode p09_4 (-400 = .a);
quietly recode p09_4 (-300 = .b);
quietly recode p09_4 (-200 = .c);
quietly recode p09_4 (-150 = .d);
quietly recode p09_4 (-399/-301 = .);
quietly recode p09_4 (-299/-201 = .);
quietly recode p09_4 (-199/-151 = .);
label values p09_4 Label_13;
quietly recode p09 (-400 = .a);
quietly recode p09 (-300 = .b);
quietly recode p09 (-200 = .c);
quietly recode p09 (-150 = .d);
quietly recode p09 (-100 = .e);
quietly recode p09 (-28 = .f);
quietly recode p09 (-399/-301 = .);
quietly recode p09 (-299/-201 = .);
quietly recode p09 (-199/-151 = .);
quietly recode p09 (-149/-101 = .);
quietly recode p09 (-99/-29 = .);
label values p09 Label_27;
quietly recode p08 (-400 = .a);
quietly recode p08 (-300 = .b);
quietly recode p08 (-200 = .c);
quietly recode p08 (-150 = .d);
quietly recode p08 (-399/-301 = .);
quietly recode p08 (-299/-201 = .);
quietly recode p08 (-199/-151 = .);
label values p08 Label_28;
quietly recode s03 (-150.0 = .a);
label values s03 Label_29;
quietly recode s04 (-400 = .a);
quietly recode s04 (-300 = .b);
quietly recode s04 (-150 = .c);
quietly recode s04 (-29 = .d);
quietly recode s04 (-399/-301 = .);
quietly recode s04 (-299/-151 = .);
quietly recode s04 (-149/-30 = .);
label values s04 Label_30;
quietly recode s05 (-150.0 = .a);
quietly recode s05 (-10.0 = .b);
quietly recode s05 (-149.0/-11 = .);
label values s05 Label_31;
quietly recode s01 (-150.0 = .a);
quietly recode s01 (-10.0 = .b);
quietly recode s01 (-149.0/-11 = .);
label values s01 Label_32;
quietly recode s02_1 (-150 = .a);
quietly recode s02_1 (-61 = .b);
quietly recode s02_1 (-60 = .c);
quietly recode s02_1 (-52 = .d);
quietly recode s02_1 (-51 = .e);
quietly recode s02_1 (-10 = .f);
quietly recode s02_1 (-149/-62 = .);
quietly recode s02_1 (-59/-53 = .);
quietly recode s02_1 (-50/-11 = .);
label values s02_1 Label_33;
quietly recode s02_2 (-150 = .a);
quietly recode s02_2 (-61 = .b);
quietly recode s02_2 (-60 = .c);
quietly recode s02_2 (-52 = .d);
quietly recode s02_2 (-51 = .e);
quietly recode s02_2 (-10 = .f);
quietly recode s02_2 (-149/-62 = .);
quietly recode s02_2 (-59/-53 = .);
quietly recode s02_2 (-50/-11 = .);
label values s02_2 Label_33;
quietly recode s02_3 (-150 = .a);
quietly recode s02_3 (-61 = .b);
quietly recode s02_3 (-60 = .c);
quietly recode s02_3 (-52 = .d);
quietly recode s02_3 (-51 = .e);
quietly recode s02_3 (-10 = .f);
quietly recode s02_3 (-149/-62 = .);
quietly recode s02_3 (-59/-53 = .);
quietly recode s02_3 (-50/-11 = .);
label values s02_3 Label_33;
quietly recode s02_4 (-150 = .a);
quietly recode s02_4 (-61 = .b);
quietly recode s02_4 (-60 = .c);
quietly recode s02_4 (-52 = .d);
quietly recode s02_4 (-51 = .e);
quietly recode s02_4 (-10 = .f);
quietly recode s02_4 (-149/-62 = .);
quietly recode s02_4 (-59/-53 = .);
quietly recode s02_4 (-50/-11 = .);
label values s02_4 Label_33;
quietly recode s02_5 (-175 = .a);
quietly recode s02_5 (-150 = .b);
quietly recode s02_5 (-61 = .c);
quietly recode s02_5 (-60 = .d);
quietly recode s02_5 (-174/-151 = .);
quietly recode s02_5 (-149/-62 = .);
quietly recode s02_5 (-59/-10 = .);
label values s02_5 Label_34;
quietly recode s02_6 (-150 = .a);
quietly recode s02_6 (-61 = .b);
quietly recode s02_6 (-60 = .c);
quietly recode s02_6 (-52 = .d);
quietly recode s02_6 (-51 = .e);
quietly recode s02_6 (-10 = .f);
quietly recode s02_6 (-149/-62 = .);
quietly recode s02_6 (-59/-53 = .);
quietly recode s02_6 (-50/-11 = .);
label values s02_6 Label_33;
quietly recode s02_7 (-150 = .a);
quietly recode s02_7 (-100 = .b);
quietly recode s02_7 (-52 = .c);
quietly recode s02_7 (-51 = .d);
quietly recode s02_7 (-10 = .e);
quietly recode s02_7 (-149/-101 = .);
quietly recode s02_7 (-99/-53 = .);
quietly recode s02_7 (-50/-11 = .);
label values s02_7 Label_35;
quietly recode s02_8 (-150 = .a);
quietly recode s02_8 (-100 = .b);
quietly recode s02_8 (-52 = .c);
quietly recode s02_8 (-51 = .d);
quietly recode s02_8 (-10 = .e);
quietly recode s02_8 (-149/-101 = .);
quietly recode s02_8 (-99/-53 = .);
quietly recode s02_8 (-50/-11 = .);
label values s02_8 Label_35;
quietly recode wv0 (-400 = .a);
quietly recode wv0 (-300 = .b);
quietly recode wv0 (-200 = .c);
quietly recode wv0 (-150 = .d);
quietly recode wv0 (-83 = .e);
quietly recode wv0 (-80 = .f);
quietly recode wv0 (-71 = .g);
quietly recode wv0 (-70 = .h);
quietly recode wv0 (-60 = .i);
quietly recode wv0 (-53 = .j);
quietly recode wv0 (-52 = .k);
quietly recode wv0 (-51 = .l);
quietly recode wv0 (-50 = .m);
quietly recode wv0 (-399/-301 = .);
quietly recode wv0 (-299/-201 = .);
quietly recode wv0 (-199/-151 = .);
quietly recode wv0 (-149/-84 = .);
quietly recode wv0 (-82/-81 = .);
quietly recode wv0 (-79/-72 = .);
quietly recode wv0 (-69/-61 = .);
quietly recode wv0 (-59/-54 = .);
label values wv0 Label_36;
quietly recode wv01 (-400 = .a);
quietly recode wv01 (-300 = .b);
quietly recode wv01 (-200 = .c);
quietly recode wv01 (-150 = .d);
quietly recode wv01 (-83 = .e);
quietly recode wv01 (-82 = .f);
quietly recode wv01 (-81 = .g);
quietly recode wv01 (-80 = .h);
quietly recode wv01 (-71 = .i);
quietly recode wv01 (-70 = .j);
quietly recode wv01 (-60 = .k);
quietly recode wv01 (-53 = .l);
quietly recode wv01 (-52 = .m);
quietly recode wv01 (-51 = .n);
quietly recode wv01 (-50 = .o);
quietly recode wv01 (-399/-301 = .);
quietly recode wv01 (-299/-201 = .);
quietly recode wv01 (-199/-151 = .);
quietly recode wv01 (-149/-84 = .);
quietly recode wv01 (-79/-72 = .);
quietly recode wv01 (-69/-61 = .);
quietly recode wv01 (-59/-54 = .);
label values wv01 Label_37;
quietly recode wv02 (-400 = .a);
quietly recode wv02 (-300 = .b);
quietly recode wv02 (-200 = .c);
quietly recode wv02 (-150 = .d);
quietly recode wv02 (-83 = .e);
quietly recode wv02 (-82 = .f);
quietly recode wv02 (-81 = .g);
quietly recode wv02 (-80 = .h);
quietly recode wv02 (-71 = .i);
quietly recode wv02 (-70 = .j);
quietly recode wv02 (-60 = .k);
quietly recode wv02 (-53 = .l);
quietly recode wv02 (-52 = .m);
quietly recode wv02 (-51 = .n);
quietly recode wv02 (-50 = .o);
quietly recode wv02 (-399/-301 = .);
quietly recode wv02 (-299/-201 = .);
quietly recode wv02 (-199/-151 = .);
quietly recode wv02 (-149/-84 = .);
quietly recode wv02 (-79/-72 = .);
quietly recode wv02 (-69/-61 = .);
quietly recode wv02 (-59/-54 = .);
label values wv02 Label_38;
quietly recode wv03 (-400 = .a);
quietly recode wv03 (-300 = .b);
quietly recode wv03 (-200 = .c);
quietly recode wv03 (-150 = .d);
quietly recode wv03 (-83 = .e);
quietly recode wv03 (-82 = .f);
quietly recode wv03 (-81 = .g);
quietly recode wv03 (-80 = .h);
quietly recode wv03 (-71 = .i);
quietly recode wv03 (-70 = .j);
quietly recode wv03 (-60 = .k);
quietly recode wv03 (-53 = .l);
quietly recode wv03 (-52 = .m);
quietly recode wv03 (-51 = .n);
quietly recode wv03 (-50 = .o);
quietly recode wv03 (-399/-301 = .);
quietly recode wv03 (-299/-201 = .);
quietly recode wv03 (-199/-151 = .);
quietly recode wv03 (-149/-84 = .);
quietly recode wv03 (-79/-72 = .);
quietly recode wv03 (-69/-61 = .);
quietly recode wv03 (-59/-54 = .);
label values wv03 Label_39;
quietly recode wv04 (-400 = .a);
quietly recode wv04 (-300 = .b);
quietly recode wv04 (-200 = .c);
quietly recode wv04 (-150 = .d);
quietly recode wv04 (-83 = .e);
quietly recode wv04 (-82 = .f);
quietly recode wv04 (-81 = .g);
quietly recode wv04 (-80 = .h);
quietly recode wv04 (-71 = .i);
quietly recode wv04 (-70 = .j);
quietly recode wv04 (-60 = .k);
quietly recode wv04 (-53 = .l);
quietly recode wv04 (-52 = .m);
quietly recode wv04 (-51 = .n);
quietly recode wv04 (-50 = .o);
quietly recode wv04 (-399/-301 = .);
quietly recode wv04 (-299/-201 = .);
quietly recode wv04 (-199/-151 = .);
quietly recode wv04 (-149/-84 = .);
quietly recode wv04 (-79/-72 = .);
quietly recode wv04 (-69/-61 = .);
quietly recode wv04 (-59/-54 = .);
label values wv04 Label_40;
quietly recode wv05 (-400 = .a);
quietly recode wv05 (-300 = .b);
quietly recode wv05 (-200 = .c);
quietly recode wv05 (-150 = .d);
quietly recode wv05 (-83 = .e);
quietly recode wv05 (-82 = .f);
quietly recode wv05 (-81 = .g);
quietly recode wv05 (-80 = .h);
quietly recode wv05 (-71 = .i);
quietly recode wv05 (-70 = .j);
quietly recode wv05 (-60 = .k);
quietly recode wv05 (-53 = .l);
quietly recode wv05 (-52 = .m);
quietly recode wv05 (-51 = .n);
quietly recode wv05 (-50 = .o);
quietly recode wv05 (-399/-301 = .);
quietly recode wv05 (-299/-201 = .);
quietly recode wv05 (-199/-151 = .);
quietly recode wv05 (-149/-84 = .);
quietly recode wv05 (-79/-72 = .);
quietly recode wv05 (-69/-61 = .);
quietly recode wv05 (-59/-54 = .);
label values wv05 Label_40;
label values w12 Label_41;
quietly recode weganz_1 (-15.0 = .a);
label values weganz_1 Label_42;
quietly recode weganz_2 (-15.0 = .a);
label values weganz_2 Label_42;
quietly recode weganz_3 (-15.0 = .a);
label values weganz_3 Label_42;
label values h05 Label_43;
quietly recode hheink (-61.0 = .a);
quietly recode hheink (-60.0 = .b);
label values hheink Label_44;
label values lebensp Label_45;
label values ov_seg Label_46;
label values pergrup Label_47;
label values pergrup1 Label_48;
label values caseinfo Label_49;
label values proxy Label_50;
label values persinfo Label_51;
label values bland Label_52;
label values westost Label_53;
label values ggkpol Label_54;
label values ggkbik Label_55;
label values bbr_reg Label_56;
label values bbr_dreg Label_57;
label values bbrkrtyp Label_58;
label values wtag Label_59;
quietly recode wegdauer (9994.0 = .e);
quietly recode wegdauer (-1 = .d);
quietly recode wegdauer (-10 = .a);
quietly recode wegdauer (-3 = .b);
quietly recode wegdauer (-2 = .c);
quietly recode wegdauer (-1000/-11 = .);
quietly recode wegdauer (-9/-4 = .);
label values wegdauer Label_60;
quietly recode h04_3 (-400 = .a);
quietly recode h04_3 (-300 = .b);
quietly recode h04_3 (-200 = .c);
quietly recode h04_3 (-150 = .d);
quietly recode h04_3 (-399/-301 = .);
quietly recode h04_3 (-299/-201 = .);
quietly recode h04_3 (-199/-151 = .);
label values h04_3 Label_5;
quietly recode h04_6 (-5.0 = .a);
label values h04_6 Label_61;
quietly recode wegtempo (-1 = .d);
quietly recode wegtempo (-10 = .a);
quietly recode wegtempo (-3 = .b);
quietly recode wegtempo (-2 = .c);
quietly recode wegtempo (-9/-4 = .);
label values wegtempo Label_62;
quietly recode kminsgk (99994.0 = .e);
quietly recode kminsgk (-1 = .d);
quietly recode kminsgk (-10 = .a);
quietly recode kminsgk (-3 = .b);
quietly recode kminsgk (-2 = .c);
quietly recode kminsgk (-1000/-11 = .);
quietly recode kminsgk (-9/-4 = .);
label values kminsgk Label_63;
quietly recode palter (-400 = .a);
quietly recode palter (-300 = .b);
quietly recode palter (-200 = .c);
quietly recode palter (-150 = .d);
quietly recode palter (-399/-301 = .);
quietly recode palter (-299/-201 = .);
quietly recode palter (-199/-151 = .);
label values palter Label_5;
quietly recode psex (-200.0 = .a);
label values psex Label_12;
quietly recode kinfo (-2.0 = .a);
quietly recode kinfo (-1.0 = .b);
label values kinfo Label_64;
quietly recode mobil (-2.0 = .a);
quietly recode mobil (-1.0 = .b);
label values mobil Label_65;
label values stichpro Label_66;
label values fragebog Label_67;
label values befrag Label_68;

end;
#delimit cr

exit
