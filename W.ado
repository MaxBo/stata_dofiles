*Do-File zum labeln von SPSS-Dateien
*Erzeugt von Max Bohnet am Sat Jan 26 21:55:53 2008

*SPSS2Stata
#delimit ;
program define W;
*Variablen-Labels: ;

label variable caseid "Identifikationsnummer des Haushalts";
label variable pid "Identifikationsnummer der Person im Haushalt";
label variable weg "Wegnummer";
label variable w01 "Ausgangspunkt des ersten Weges";
label variable w111 "Haben Sie wirklich nur den einen Weg am Stichtag zurückgelegt?";
label variable w112 "Waren die bisher angegebenen Wege wirklich alle Wege am Stichtag?";
label variable w04 "Wegzweck";
label variable w041 "Hauptzweck des Einkaufswegs";
label variable w042 "Hauptzweck des Erledigungsweg";
label variable w043 "Hauptzweck der Freizeitaktivität";
label variable w13 "Wegziel";
label variable w05_1 "Genutztes Verkehrsmittel: Zu Fuß";
label variable w05_2 "Genutztes Verkehrsmittel: Fahrrad";
label variable w05_3 "Genutztes Verkehrsmittel: Moped/Mofa";
label variable w05_4 "Genutztes Verkehrsmittel: Motorrad als Fahrer";
label variable w05_5 "Genutztes Verkehrsmittel: Pkw als Mitfahrer";
label variable w05_6 "Genutztes Verkehrsmittel: Pkw als Fahrer";
label variable w05_7 "Genutztes Verkehrsmittel: Lkw bis 3,5 t Nutzlast als Mitfahrer";
label variable w05_7s "Genutztes Verkehrsmittel: Lkw bis 3,5 t Nutzlast PAPI (ohne Differenzierung zwischen Fahrer bzw. Mitfahrer";
label variable w05_8 "Genutztes Verkehrsmittel: Lkw bis 3,5 t Nutzlast als Fahrer";
label variable w05_9 "Genutztes Verkehrsmittel: Anderer Lkw als Mitfahrer";
label variable w05_9s "Genutztes Verkehrsmittel: Anderer Lkw  PAPI (ohne Differenzierung zwischen Fahrer bzw. Mitfahrer";
label variable w05_10 "Genutztes Verkehrsmittel: Anderer Lkw als Fahrer";
label variable w05_11 "Genutztes Verkehrsmittel: Linien-/Stadtbus";
label variable w05_12 "Genutztes Verkehrsmittel: U-Bahn/Straßenbahn";
label variable w05_13 "Genutztes Verkehrsmittel: S-Bahn/Nahverkehrszug";
label variable w05_14 "Genutztes Verkehrsmittel: Taxi";
label variable w05_15 "Genutztes Verkehrsmittel: Schiff/Fähre";
label variable w05_16 "Genutztes Verkehrsmittel: Fernzug";
label variable w05_17 "Genutztes Verkehrsmittel: Reisebus";
label variable w05_18 "Genutztes Verkehrsmittel: Flugzeug";
label variable w05_20 "Genutztes Verkehrsmittel: anderes Verkehrsmittel";
label variable w05_21 "Genutztes Verkehrsmittel: Motorrad al Mitfahrer";
label variable w061 "Waren Sie Fahrer oder Mitfahrer";
label variable w062 "War dies ein Pkw/Lkw aus ihrem Haushalt";
label variable w063 "Welcher Pkw war das denn?";
label variable w07s "Waren Sie alleine unterwegs? (PAPI)";
label variable w07 "Anzahl der Begleiter insgesamt";
label variable w071 "Begleiter aus dem Haushalt?";
label variable w0721 "Person 1 hat Zielperson begleitet";
label variable w0722 "Person 2 hat Zielperson begleitet";
label variable w0723 "Person 3 hat Zielperson begleitet";
label variable w0724 "Person 4 hat Zielperson begleitet";
label variable w0725 "Person 5 hat Zielperson begleitet";
label variable w0726 "Person 6 hat Zielperson begleitet";
label variable w0727 "Person 7 hat Zielperson begleitet";
label variable w0728 "Person 8 hat Zielperson begleitet";
label variable w0729 "Andere Person hat Zielperson begleitet";
label variable w073 "Wer von diesen Personen war auf diesem Weg der Fahrer (Wird gefiltert)";
label variable w08 "Wegeentfernung im km korrigiert";
label variable w03 "Startzeit";
label variable w03_hs "Startzeit (Stundenangabe)";
label variable w03_ms "Startzeit (Minutenangabe)";
label variable w09 "Ankunftszeit";
label variable w09_hs "Ankunftszeit (Stundenangabe)";
label variable w09_ms "Ankunftszeit (Minutenangabe)";
label variable wegdauer "";
label variable hpzweck "Hauptwegezweck";
label variable diwzw1 "Hauptzweck des Einkaufswegs";
label variable diwzw2 "Hauptzweck der Erledigungen";
label variable diwzw3 "Hauptzweck der Freizeitaktivität";
label variable w05 "Hauptverkehrsmittel";
label variable erfwege "";
label variable weganz_1 "Anzahl der erfassten Wege in der Wegematrix";
label variable weganz_2 "Anzahl der Wege inklusive  der weiteren Wege";
label variable weganz_3 "Anzahl der Wege inklusive der beruflichen und der weiteren Wege";
label variable hheink "Netto-Haushaltseinkommen";
label variable lebensp "Lebensphase neu";
label variable ov_seg "ÖPNV-Segmentierung";
label variable pergrup "verhaltenshomogene Personengruppen 9 Gruppen";
label variable pergrup1 "verhaltenshomogene Personengruppen 12 Gruppen";
label variable caseinfo "Erhebungsmethode";
label variable proxy "Form des Interviews";
label variable voll_hh "vollständigeHH";
label variable bland "Bundesland";
label variable westost "West-Ost Kennung";
label variable ggkpol "politische Gemeindegrößenklasse 2000";
label variable ggkbik "10er-BIK-Gemeindegrößenklasse";
label variable bbr_reg "Regionsgrundtyp";
label variable bbr_dreg "differenzierter Regionstyp";
label variable bbrkrtyp "BBR/BfLR Kreistyp";
label variable wtag "wochentag";
label variable p12_1 "Staatsangehörigkeit: deutsch";
label variable p12_2 "Staatsangehörigkeit: türkisch";
label variable p12_3 "Staatsangehörigkeit: italienisch";
label variable p12_4 "Staatsangehörigkeit: griechisch";
label variable p12_5 "Staatsangehörigkeit: anderes";
label variable p01 "Wie oft können Sie als Fahrer/in über ein Auto verfügen?";
label variable p02 "Besitzen Sie zur Zeit ein verkehrstüchtiges Fahrrad?";
label variable p051 "Fußwegentfernung Bushaltestelle in Minuten";
label variable p052 "Fußwegentfernung Bushaltestelle in Metern";
label variable p053 "Fußwegentfernung Bahnhaltestelle in Minuten";
label variable p054 "Fußwegentfernung Bahnhaltestelle in Metern";
label variable p041 "Erreichbarkeit übliche Ziele: mit dem ÖPNV";
label variable p042 "Erreichbarkeit übliche Ziele: mit dem Auto";
label variable p11 "Geschlecht";
label variable p13 "Alter";
label variable p14 "Schulabschluß";
label variable p15 "Sind Sie zur Zeit berufstätig?";
label variable p16 "Sind Sie zur Zeit...";
label variable p17 "Was ist Ihre derzeitige Hauptbeschäftigung?";
label variable p18 "Welche berufliche Stelluing haben Sie derzeit bzw. zuletzt bei Ihrer früheren Erwerbstätigkeit?";
label variable p17s "Was trifft derzeit auf Sie zu?";
label variable p18s "Welche berufliche Stellung haben Sie derzeit bzw. hatten Sie zuletzt?";
label variable p09_1 "Körperliche Behinderung: Gehbehinderung";
label variable p09_2 "Körperliche Behinderung: Sehbehinderung";
label variable p09_3 "Körperliche Behinderung: andere Einschränkung";
label variable p09_4 "Körperliche Behinderung: keine";
label variable p09 "Fühlen Sie sich durch Ihre körperliche Behinderung in Ihrer Mobilität eingeschränkt?";
label variable ks03 "Wetter am Stichtag";
label variable ks04 "Kfz-Verfügbarkeit am Stichtag";
label variable ks01 "Normalität Stichtag";
label variable h02 "Haushaltsgröße insgesamt";
label variable h05 "Wohnlage";
label variable h04_3 "Anzahl Pkw im HH";
label variable h04_6 "Anzahl Lkw ges im HH";
label variable hhgr06 "Anzahl der Personen im Haushalt unter 6";
label variable hhgr14 "Anzahl der Personen im Haushalt unter 14";
label variable hhgr18 "Anzahl der Personen im Haushalt unter 18";
label variable wegtempo "";
label variable stichtag "Datum Stichtag für Person";
label variable palter "Alter der Zielperson";
label variable psex "Geschlecht der Zielperson";
label variable persinfo "Info zum Interviewstatus der Person";
label variable gemnr "Gemeindenummer";
label variable stichpro "stichprobenkennung";
label variable fragebog "Fragebogenvariante";
label variable befrag "Befragungsart";
label variable gew_pa "Personengewicht für Aufstockung";
label variable D_R "";
label variable an_schiene "";
label variable typ "";
label variable lage_iv "";
label variable zentralit "";
label variable entfernung "";
label variable zone_1 "";
label variable vz_nr_ne_1 "";
label variable vzname_n_1 "";
label variable typname "";
label variable zentrtyp "";
label variable filter_ "hheink <= 8  & hheink >0 & pergrup1 = 1 (FILTER)";
label variable WegekmKl "Wegelänge in Km-Klassen";
label variable Verkm5 "Hauptverkehrsmittel(5)";

*define ValueLabels: ;

label define Label_0
	1	"Zu Hause"
	8	"Weiß nicht"
	2	"Woanders"
	9	"Keine Angabe"
	-39	"Frage wird nur am Ausgangspunkt der Wege gestellt"
	;

label define Label_1
	-73	"Bei mehr als einen Weg wird Frage nicht gestellt"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	1	"Ja, nur den einen Weg zurückgelegt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein, noch weitere Wege zurückgelegt"
	7	"Verweigert"
	8	"Weiß nicht"
	;

label define Label_2
	-72	"Wert liegt auf Weg 1"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-70	"Personen mit einem Weg werden nicht befragt"
	-71	"Personen mit 8 erfassten Wegen werden nicht befragt"
	1	"Ja, alle Wege"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein, noch weitere Wege"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_3
	11	"Begleitung Erwachsener"
	10	"Anderes"
	32	"Kita/Kindergarten"
	31	"(Vor-) Schule"
	42	"PAPI: Unterricht (nicht Schule)"
	40	"PAPI: Sport"
	41	"PAPI: Freunde besuchen/treffen"
	99	"Keine Angabe"
	98	"Weiß nicht"
	3	"Erreichen der Ausbildungsstätte"
	1	"Erreichen des Arbeitsplatzes"
	5	"Private Erledigungen"
	4	"Einkauf"
	7	"Freizeitaktivität"
	6	"Bringen/Holen von Personen"
	9	"Rückweg vom vorherigen Weg"
	2	"Dienstlich/Geschäftlich"
	97	"Verweigert"
	8	"Nach Hause"
	;

label define Label_4
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	999	"Keine Angabe"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-1	"Kein Einkaufsweg"
	506	"sonstiger Einkaufszweck"
	504	"Dienstleistungen"
	505	"Bringen/Holen von Personen"
	502	"Sonstige Waren"
	503	"Allgemeiner Einkaufsbummel"
	501	"Täglicher Bedarf"
	;

label define Label_5
	604	"Sonstiges"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	601	"Arztbesuch"
	603	"Private Erledigungen für andere Person"
	602	"Behörde, Bank, Post, Geldautomat"
	717	"Hobby"
	705	"Weiterbildung"
	715	"Jobben in der Freizeit gegen Entgelt"
	714	"Ehrenamt, Verein, politische Aktivität"
	713	"Kirche, Friedhof"
	701	"Besuch/Treffen von Freunden, Verwandten, Bekannten"
	711	"Hund ausführen"
	503	"Allgemeiner Einkaufsbummel"
	999	"Keine Angabe"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-1	"Kein privater Erledigungsweg"
	716	"Begleitung von Kindern"
	504	"Dienstleistungen"
	706	"Gaststätte, Restaurant, Kneipe"
	;

label define Label_6
	708	"Tagesausflug, mehrtägiger Ausflug"
	709	"Urlaub (ab 5 Tage)"
	704	"Sport selbst (z.B. Fußballspiel, Sportverein, etc."
	705	"Weiterbildung"
	706	"Gaststätte, Restaurant, Kneipe"
	707	"Schrebergarten, Wochenendhaus"
	701	"Besuch/Treffen von Freunden, Verwandten, Bekannten"
	702	"Besuch kultureller Einrichtungen"
	703	"Besuch einer Veranstaltungen"
	716	"Begleitung von Kindern"
	503	"Allgemeiner Einkaufsbummel"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	719	"Spielplatz, Spielen auf der Straße"
	718	"Jugendfreizeitheim"
	717	"Hobby"
	999	"Keine Angabe"
	715	"Jobben in der Freizeit gegen Entgelt"
	714	"Ehrenamt, Verein, politische Aktivität"
	713	"Kirche, Friedhof"
	712	"Joggen, Inlineskating"
	711	"Hund ausführen"
	710	"Spaziergang, Spazierfahrt"
	11	"Begleitung Erwachsener"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-1	"Kein Freizeitweg"
	720	"Sonstiges"
	;

label define Label_7
	.a	"Frage nicht gestellt: Rückweg"
	1	"Zu Hause"
	.b	"Frage nicht gestellt: nach Hause"
	3	"Rundweg"
	2	"Weg hatte ein anderes Ziel"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_8
	1	"Genutzt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	9	"Keine Angabe"
	0	"Nicht genutzt"
	;

label define Label_9
	1	"Genutzt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	9	"Keine Angabe"
	-50	"Im CATI nicht erhoben"
	0	"Nicht genutzt"
	;

label define Label_10
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-44	"Pkw/Lkw nicht für Wegzweck genutzt"
	-45	"Kinder kleiner gleich 13 Jahre werden nicht befragt"
	1	"Als Fahrer"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Als Mitfahrer"
	7	"Verweigert"
	;

label define Label_11
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-46	"Kein Pkw/Lkw im Haushalt vorhanden"
	-110	"nicht erhoben"
	-44	"Pkw/Lkw nicht für Wegzweck genutzt"
	1	"Ja"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_12
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-49	"Lkw-Nutzer werden nicht befragt"
	-46	"Kein Pkw/Lkw im Haushalt vorhanden"
	-48	"Vorfrage Verweigert/Weiß nicht,Frage deshalb nicht gestellt"
	-44	"Pkw/Lkw nicht für Weg genutzt"
	-110	"nicht erhoben"
	1	"Fahrzeug 1"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Fahrzeug 3"
	2	"Fahrzeug 2"
	5	"Anderes Fahrzeug"
	7	"Verweigert"
	-47	"Genutzter Pkw/Lkw nicht aus dem Haushalt"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_13
	1	"Alleine"
	0	"Mit Begleitung"
	9	"Keine Angabe"
	-50	"Im CATI nicht erhoben"
	;

label define Label_14
	0	"Alleine"
	-7	"Verweigert"
	-9	"Keine Angabe"
	-8	"Weiß nicht"
	;

label define Label_15
	-73	"Befragte gab keine Auskunft zu der Zahl der Begleitpersonen"
	-72	"Kein Begleiter"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	1	"Ja"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	;

label define Label_16
	-73	"Befragte gab keine Auskunft zu der Zahl der Begleitpersonen"
	-72	"Kein Begleiter"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-74	"Befragte gab keine Auskunft ob Begleitpersonen aus HH ist"
	-71	"Kein begleiter aus dem Haushalt"
	1	"Tifft zu"
	0	"Trifft nicht zu "
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	;

label define Label_17
	10	"Fahrer nicht aus dem Haushalt2"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	12	"nicht erhoben"
	-2	"Kein Pkw/Lkw oder Motorrad-Nutzer"
	1	"Person 1"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Person 3"
	2	"Person 2"
	5	"Person 5"
	4	"Person 4"
	7	"Person 7"
	6	"Person 6"
	8	"Person 8"
	;

label define Label_18
	99999	"keine Angabe (PAPI-Interview)"
	99998	"weiß nicht (CATI-Interview)"
	99997	"verweigert (CATI-Interview)"
	99996	"Angaben unplausibel"
	;

label define Label_19
	999995	"Wegedauer nicht berechenbar"
	999996	"Wegedauer unplausibel"
	;

label define Label_20
	1	"Beruf"
	3	"dienstlich/geschäftlich"
	2	"Ausbildung"
	5	"private Erledigungen"
	4	"Begleitung"
	7	"Freizeit"
	6	"Einkauf"
	8	"sonstiges"
	;

label define Label_21
	999	"Keine Angabe"
	-410	"Papi-Fälle. Einkaufsweg nicht weiter differenziert erhoben"
	-11	"Kein Einkaufsweg"
	-1	"Kein Einkaufsweg"
	506	"Bringen/Holen von Personen"
	504	"Dienstleistungen"
	505	"Begleitung Erwachsener"
	502	"sonstige Waren"
	503	"allgemeiner Einkaufsbummel"
	501	"täglicher Bedarf"
	;

label define Label_22
	604	"sonstiges und zwar"
	601	"Arztbesuch"
	603	"private Erledigung für and. Per."
	602	"Behörde, Bank, Post, Geldautomat"
	717	"Hobby"
	705	"Weiterbildung"
	715	"Jobben"
	714	"Ehrenamt"
	713	"Kirche, Friedhof"
	701	"Besuch oder Treffen"
	711	"Hund ausführen"
	503	"Einkaufsbummel"
	999	"Keine Angabe"
	-1	"Kein privater Erledigungsweg"
	716	"Begleitung von Kindern"
	504	"Dienstleistungen"
	706	"Essen"
	;

label define Label_23
	708	"Tagesausflug, mehrtägiger Ausflug"
	709	"Urlaub (ab 5 Tage)"
	704	"Sport (selbst aktiv)"
	705	"Weiterbildung"
	706	"Essen"
	707	"Schrebergarten, Wochenendhaus"
	701	"Besuch oder Treffen"
	702	"Besuch kultureller Einrichtung"
	703	"Besuch einer Veranstaltung"
	716	"Begleitung von Kindern"
	503	"allgemeiner Einkaufsbummel"
	719	"Spielplatz/Spielen auf der Straße"
	718	"Freizeitheim etc."
	717	"Hobby"
	999	"Keine Angabe"
	715	"Jobben"
	714	"Ehrenamt"
	713	"Kirche, Friedhof"
	712	"Joggen, Inlineskating etc."
	711	"Hund ausführen"
	710	"Spaziergang, Spazierfahrt"
	11	"Begleitung Erwachsener"
	-1	"Kein Freizeitweg"
	720	"Sonstiges und zwar"
	;

label define Label_24
	11	"sonstiges"
	10	"Schiff,Bahn,Bus,Flugzeug"
	1	"zu Fuß"
	0	"noch nicht zugeordnet"
	3	"Mofa/Moped"
	2	"Fahrrad"
	5	"Pkw Mitfahrer"
	4	"Motorrad"
	7	"Lkw"
	6	"Pkw Fahrer"
	9	"Taxi"
	8	"ÖPNV"
	97	"keine Angabe"
	;

label define Label_25
	-46	"Selbst, Inland, < 3 Tage-Regel mit Wegematrix"
	-47	"Selbst, Inland, > 3 Tage-Regel ohne Wegematrix"
	-44	"Selbst, nur Ausland, ohne Wegematrix"
	-45	"Proxy, nur Ausland, ohne Wegematrix"
	-60	"Selbst, keine Wege außer Haus, < 3 Tage-Regel mit Wegematrix"
	-61	"Selbst, Wege außer Haus, < 3 Tage-Regel mit Wegematrix"
	-48	"Proxy, Inland, > 3 Tage-Regel ohne Wegematrix"
	-42	"Selbst, ohne Wblatt, Inland, > 3 Tage-Regel ohne Wegematrix"
	-43	"Proxy, ohne Wblatt, Inland, > 3 Tage-Regel ohne Wegematrix"
	-40	"Selbst, ohne Wblatt, Inland, < 3 Tage-Regel mit Wegematrix"
	-41	"Proxy, ohne Wblatt, Inland, < 3 Tage-Regel ohne Wegematrix"
	-20	"Selbst/Proxy, holt Wblatt, mit Wegematrix"
	-21	"Selbst, holt Wblatt nicht, < 3 Tage-Regel mit Wegematrix"
	-22	"Proxy, holt Wblatt nicht, > 3 Tage-Regel ohne Wegematrix"
	-23	"Selbst, holt Wblatt nicht, < 3 Tage-Regel ohne Wegematrix"
	-91	"PAPI: Person war nicht unterwegs"
	-90	"PAPI: Person war unterwegs"
	-93	"PAPI: Person im Ausland unterwegs gewesen, ohne Wegematrix"
	-92	"PAPI: Keine Angabe zu seinem Mobilitätsverhalten"
	-95	"PAPI: Kinderfragebogen, Kind mobil"
	-94	"PAPI: Person nicht außer Haus gewesen"
	-96	"PAPI: Kinderfragebogen, Kind nicht mobil"
	-11	"Proxy, Wblatt vorliegend, mit Wegematrix"
	-10	"Selbst, Wblatt vorliegend, mit Wegematrix"
	-71	"Selbst/Proxy mit Wegerfass nicht außer Haus (ks02_4)"
	-70	"Selbst/Proxy mit Wegerfass im Ausland unterwegs (ks02_2)"
	-52	"Proxy, ohne Wblatt, KA in kke05, ohne Wegematrix"
	-34	"Selbst, ohne Wblatt, > 3 Tage-Regel ohne Wegematrix"
	-33	"Selbst, ohne Wblatt, < 3 Tage-Regel mit Wegematrix"
	-32	"Selbst, ohne Wblatt, wenig Wege,> 5 Tage-Regel o. Wegematrix"
	-31	"Selbst, ohne Wblatt, wenig Wege,< 5 Tage-Regel mit Wegematri"
	-30	"Proxy, ohne Wblatt, mit Nennung in kke05, ohne Wegematrix"
	-24	"Proxy, holt Wblatt nicht, < 3 Tage-Regel ohne Wegematrix"
	;

label define Label_26
	-15	"Aufgrund Filterbedingungen Wege nicht berechnet"
	997	"Verweigert"
	999	"Keine Angabe"
	;

label define Label_27
	-60	"Person unter 18 Jahre wird nicht befragt"
	-61	"CATI: Befragte ohne Altersangabe werden nicht befragt"
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

label define Label_28
	11	"Mehrpersonenhaushalte"
	10	"Auszubildende, Schüler"
	12	"Nicht zugeordnet aufgrund geringer Besetzung"
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

label define Label_29
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

label define Label_30
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

label define Label_31
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

label define Label_32
	1	"Papi: Erwachsenen-Fragebogen"
	3	"CATI: Switcher, HH-Ebene schriftlich, PW-Ebene telephonisch"
	2	"Papi: Kinder-Fragebogen"
	4	"CATI: HH-Ebene telephonisch, PW-Ebene telephonisch"
	;

label define Label_33
	1	"Selbst"
	2	"Proxy"
	-1	"Nur als PAPI befragt"
	;

label define Label_34
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

label define Label_35
	1	"West"
	2	"Ost"
	;

label define Label_36
	1	"u 2000"
	3	"5000 - u 20000"
	2	"2000 - u 5000"
	5	"50000 - u 100000"
	4	"20000 - u 50000"
	7	"500000+ "
	6	"100000 - u 500000"
	;

label define Label_37
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

label define Label_38
	1	"Agglomerationsräume (Regionstyp 1)"
	3	"Ländliche Räume (Regionstyp 3)"
	2	"Verstädterte Räume (Regionstyp 2)"
	;

label define Label_39
	1	"Hochverdichtete Agglomerationsräume"
	3	"Verstädterte Räume höherer Dichte"
	2	"Agglomerationsräume mit herausragenden Zentren"
	5	"Verstädterte Räume mittlerer Dichte ohne Oberzentren"
	4	"Verstädterte Räume mittlerer Dichte mit Oberzentren"
	7	"Ländliche Räume geringerer Dichte"
	6	"Ländliche Räume höherer Dichte"
	;

label define Label_40
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

label define Label_41
	1	"Montag"
	3	"Mittwoch"
	2	"Dienstag"
	5	"Freitag"
	4	"Donnerstag"
	7	"Sonntag"
	6	"Samstag"
	;

label define Label_42
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Trifft zu"
	0	"Trifft nicht zu"
	9	"Keine Angabe"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_43
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-20	"CATI:Personen < 18(Alter aus HH-Matrix) werden nicht befragt"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Jederzeit"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Ausnahmsweise"
	2	"Gelegentlich"
	4	"Gar nicht"
	7	"Verweigert"
	6	"Nur CATI: habe kein Auto"
	9	"Keine Angabe"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_44
	1	"Ja"
	2	"Nein"
	7	"Verweigert"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_45
	997	"Verweigert"
	996	"Wie Bushaltestelle"
	999	"Keine Angabe"
	998	"Weiß nicht"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_46
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	99	"Keine Angabe"
	98	"Weiß nicht"
	8	"weiter als 10 Kilometer"
	97	"Verweigert"
	96	"Wie Bushaltestelle"
	1	"unter 100 Meter"
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"200 bis unter 400 Meter"
	2	"100 bis unter 200 Meter"
	5	"ein bis unter 2 Kilometer"
	4	"400 Metern bis unter einem Kilometer"
	7	"5 bis unter  10 Kilometer"
	6	"2 bis unter 5 Kilometer"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_47
	1	"Sehr gut"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Einigermaßen"
	2	"Gut"
	5	"Sehr schlecht"
	4	"Schlecht"
	7	"Verweigert"
	6	"Nur CATI: habe kein Auto"
	9	"Keine Angabe"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	;

label define Label_48
	1	"Männlich"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	2	"Weiblich"
	9	"Keine Angabe"
	;

label define Label_49
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
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	99	"Keine Angabe"
	97	"Verweigert"
	8	"Besuche zur Zeit: Krippe/Kita/Kindergarten"
	;

label define Label_50
	1	"Ja"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-28	"CARTI: Personen ohne Behinderung werden nicht befragt"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	2	"Nein"
	7	"Verweigert"
	8	"Weiß nicht"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	;

label define Label_51
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	-24	"Verweigert/Weiß nicht zur Berufstätigkeit"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Vollzeit erwerbstätig"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"geringfügig erwerbstätig"
	2	"Teilzeit erwerbstätig"
	4	"Auszubildende(r)"
	7	"Verweigert"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	8	"Weiß nicht"
	-23	"Personen ohne Berufstätigkeit"
	;

label define Label_52
	99	"Keine Angabe"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	9	"Wehr- oder Zivildienstleistender"
	10	"Sonstiges"
	-25	"Personen mit einer Berufstätigkeit werden nicht befragt"
	-26	"Personen in der Ausbildung werden nicht befragt"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Auszubildender"
	98	"Weiß nicht"
	3	"Schüler(in) weiterführenden Schule"
	2	"Schüler in einer Grundschule"
	5	"zur Zeit arbeitslos"
	4	"Student(in)"
	7	"Hausfrau / Hausmann"
	6	"vorübergehend freigestellt"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	97	"Verweigert"
	8	"Rentner(in), Pensionär(in)"
	;

label define Label_53
	11	"mithelfender Familienangehöriger"
	10	"selbständiger Landwirt"
	-100	"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"
	12	"Sonstiges"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	13	"war noch nie berufstätig"
	-200	"Proxy ab 14 Jahre werden nicht befragt"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Arbeiter(in)"
	98	"Weiß nicht"
	3	"Angestellte(r) mit qualifizierter Tätigkeit"
	2	"Angestellte(r) mit einfacher Tätigkeit"
	5	"Beamter(in) im einfachen Dienst"
	4	"Angestellte(r) mit Leitungsaufgaben"
	7	"Beamter(in) im gehobenen/höheren Dienst"
	6	"Beamter(in) im mittleren Dienst"
	9	"selbständig im Handel"
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	99	"Keine Angabe"
	97	"Verweigert"
	8	"akademischer freier Beruf"
	;

label define Label_54
	11	"Rentner/in"
	10	"Hausfrau/-mann"
	13	"Anderes"
	12	"Wehr-/Zivildienstleistender"
	-175	"In CATI nicht erhoben"
	1	"Vollzeit erwerbstätig"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
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

label define Label_55
	11	"selbständiger Landwirt"
	10	"selbständig im Handel"
	13	"Sonstiges"
	12	"mithelfender Familienangehöriger"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	-175	"In CATI nicht erhoben"
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

label define Label_56
	1	"Sonnig"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Stark bewölkt"
	2	"Leicht bewölkt"
	5	"Schnee"
	4	"Regnerisch"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_57
	-300	"Selbst kleiner gleich 13 Jahre werden nicht befragt"
	-29	"Personen ohne Altersangaben werden nicht befragt"
	-400	"Proxy kleiner gleich 13 Jahre werden nicht befragt"
	1	"Ja, ständig"
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	3	"Nein, gar nicht"
	2	"Ja, teilweise"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_58
	-150	"Im PAPI-Kinder-Fragebogen nicht erhoben"
	1	"Ja, war ein normaler Wochentag"
	-10	"Aufgrund Filterbedingungen werden Wege nicht erhoben"
	2	"Nein, war kein normaler Wochentag"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_59
	1	"Eher gehoben"
	3	"Eher einfach"
	2	"Mittlere Wohnlage"
	4	"Keine dieser Wohnanlage"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_60
	999995	"Wegetempo nicht berechenbar"
	999996	"Wegetempo unplausibel"
	;

label define Label_61
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

label define Label_62
	1	"CATI"
	2	"PEN"
	;

label define Label_63
	1	"CATI: Erwachs ab 14J, Selbst befragt"
	3	"CATI: Kind 10-13J, Selbst befragt"
	2	"CATI: Erwachs ab 14J, Stellvertreterint."
	-1	"schriftliches Interview"
	4	"CATI: Kind 10-13J, Stellvertreterint."
	5	"CATI: Kind 0-9J, Stellvertreterint."
	;

label define Label_64
	1	"HH-Int schriftlich, Pers/Wegeinterview CATI"
	0	"HH/Pers/Wegeinterview CATI"
	-1	"HH/Pers/Wegeinterview schriftlich"
	;

label define Label_65
	1	"ohne Schienenanschluss"
	0	"an Schiene"
	;

label define Label_66
	11	"Ländlicher Bereich mit Schiene"
	10	"GZ ohne"
	12	"Ländlicher Bereich ohne"
	1	"OZ Kern mit Schiene"
	3	"OZ Rand mit Schiene"
	2	"OZ Kern ohne"
	5	"OZ Umland mit Schiene"
	4	"OZ Rand ohne"
	7	"MZ mit Schiene"
	6	"OZ Umland ohne"
	9	"GZ mit Schiene"
	8	"MZ ohne"
	;

label define Label_67
	1	"OZ Kern"
	3	"OZ Umland"
	2	"OZ Rand"
	5	"GZ"
	4	"MZ"
	6	"Ländlicher Bereich"
	;

label define Label_68
	1	"Ausgewählt"
	0	"Nicht ausgewählt"
	;

label define Label_69
	.a	"fehlend"
	10	"5-10 km"
	15	"10-15 km"
	50	"20-50 km"
	1	"0-1 km"
	2	"1-2 km"
	5	"2-5 km"
	20	"15-20 km"
	100	"über 50 km"
	;

label define Label_70
	1	"zu Fuß"
	3	"ÖPNV"
	2	"Fahrrad"
	.a	"missing"
	4	"Pkw-Mitfahrer"
	5	"Kfz-Fahrer"
	;


*label Values and recode missings: ;

label values w01 Label_0;
label values w111 Label_1;
label values w112 Label_2;
label values w04 Label_3;
label values w041 Label_4;
label values w042 Label_5;
label values w043 Label_6;
quietly recode w13 (-20.0 = .a);
quietly recode w13 (-10.0 = .b);
quietly recode w13 (-19.0/-11 = .);
label values w13 Label_7;
label values w05_1 Label_8;
label values w05_2 Label_8;
label values w05_3 Label_8;
label values w05_4 Label_8;
label values w05_5 Label_8;
label values w05_6 Label_8;
label values w05_7 Label_8;
label values w05_7s Label_9;
label values w05_8 Label_8;
label values w05_9 Label_8;
label values w05_9s Label_9;
label values w05_10 Label_8;
label values w05_11 Label_8;
label values w05_12 Label_8;
label values w05_13 Label_8;
label values w05_14 Label_8;
label values w05_15 Label_8;
label values w05_16 Label_8;
label values w05_17 Label_8;
label values w05_18 Label_8;
label values w05_20 Label_8;
label values w05_21 Label_8;
label values w061 Label_10;
label values w062 Label_11;
label values w063 Label_12;
label values w07s Label_13;
label values w07 Label_14;
label values w071 Label_15;
label values w0721 Label_16;
label values w0722 Label_16;
label values w0723 Label_16;
label values w0724 Label_16;
label values w0725 Label_16;
label values w0726 Label_16;
label values w0727 Label_16;
label values w0728 Label_16;
label values w0729 Label_16;
label values w073 Label_17;
label values w08 Label_18;
label values w03_hs Label_3;
label values w03_ms Label_3;
label values w09_hs Label_3;
label values w09_ms Label_3;
label values wegdauer Label_19;
label values hpzweck Label_20;
label values diwzw1 Label_21;
label values diwzw2 Label_22;
label values diwzw3 Label_23;
label values w05 Label_24;
label values erfwege Label_25;
label values weganz_1 Label_26;
label values weganz_2 Label_26;
label values weganz_3 Label_26;
label values hheink Label_27;
label values lebensp Label_28;
label values ov_seg Label_29;
label values pergrup Label_30;
label values pergrup1 Label_31;
label values caseinfo Label_32;
label values proxy Label_33;
label values bland Label_34;
label values westost Label_35;
label values ggkpol Label_36;
label values ggkbik Label_37;
label values bbr_reg Label_38;
label values bbr_dreg Label_39;
label values bbrkrtyp Label_40;
label values wtag Label_41;
label values p12_1 Label_42;
label values p12_2 Label_42;
label values p12_3 Label_42;
label values p12_4 Label_42;
label values p12_5 Label_42;
label values p01 Label_43;
label values p02 Label_44;
label values p051 Label_45;
label values p052 Label_46;
label values p053 Label_45;
label values p054 Label_46;
label values p041 Label_47;
label values p042 Label_47;
label values p11 Label_48;
label values p13 Label_45;
label values p14 Label_49;
label values p15 Label_50;
label values p16 Label_51;
label values p17 Label_52;
label values p18 Label_53;
label values p17s Label_54;
label values p18s Label_55;
label values p09_1 Label_42;
label values p09_2 Label_42;
label values p09_3 Label_42;
label values p09_4 Label_42;
label values p09 Label_50;
label values ks03 Label_56;
label values ks04 Label_57;
label values ks01 Label_58;
label values h05 Label_59;
label values h04_3 Label_45;
label values h04_6 Label_45;
label values wegtempo Label_60;
label values palter Label_45;
label values psex Label_48;
label values persinfo Label_61;
label values stichpro Label_62;
label values fragebog Label_63;
label values befrag Label_64;
label values an_schiene Label_65;
label values typ Label_66;
label values zentrtyp Label_67;
label values filter_ Label_68;
quietly recode WegekmKl (-99.0 = .a);
label values WegekmKl Label_69;
quietly recode Verkm5 (-1.0 = .a);
label values Verkm5 Label_70;

end;
#delimit cr

exit
