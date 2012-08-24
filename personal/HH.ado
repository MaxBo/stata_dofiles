*Do-File zum labeln von SPSS-Dateien
*Erzeugt von Max Bohnet am Sat Jan 26 22:41:46 2008

*SPSS2Stata
#delimit ;
program define HH;
*Variablen-Labels: ;

label variable caseid "gesamtStchpr_ID";
label variable h01 "Personen im Haushalt";
label variable h001c "Unterlagen zu Studie erhalten?";
label variable h02 "Haushaltsgröße insgesamt";
label variable h1sex "Geschlecht Person 1";
label variable h2sex "Geschlecht Person 2";
label variable h3sex "Geschlecht Person 3";
label variable h4sex "Geschlecht Person 4";
label variable h5sex "Geschlecht Person 5";
label variable h6sex "Geschlecht Person 6";
label variable h7sex "Geschlecht Person 7";
label variable h8sex "Geschlecht Person 8";
label variable h1alter "Alter der Person 1";
label variable h2alter "Alter der Person 2";
label variable h3alter "Alter der Person 3";
label variable h4alter "Alter der Person 4";
label variable h5alter "Alter der Person 5";
label variable h6alter "Alter der Person 6";
label variable h7alter "Alter der Person 7";
label variable h8alter "Alter der Person 8";
label variable h1beruf "Berufstätigkeit der Person 1";
label variable h2beruf "Berufstätigkeit der Person 2";
label variable h3beruf "Berufstätigkeit der Person 3";
label variable h4beruf "Berufstätigkeit der Person 4";
label variable h5beruf "Berufstätigkeit der Person 5";
label variable h6beruf "Berufstätigkeit der Person 6";
label variable h7beruf "Berufstätigkeit der Person 7";
label variable h8beruf "Berufstätigkeit der Person 8";
label variable h1besch "Beschäftigungsart der Person 1";
label variable h2besch "Beschäftigungsart der Person 2";
label variable h3besch "Beschäftigungsart der Person 3";
label variable h4besch "Beschäftigungsart der Person 4";
label variable h5besch "Beschäftigungsart der Person 5";
label variable h6besch "Beschäftigungsart der Person 6";
label variable h7besch "Beschäftigungsart der Person 7";
label variable h8besch "Beschäftigungsart der Person 8";
label variable h1taet "Tätigkeit der Person 1";
label variable h2taet "Tätigkeit der Person 2";
label variable h3taet "Tätigkeit der Person 3";
label variable h4taet "Tätigkeit der Person 4";
label variable h5taet "Tätigkeit der Person 5";
label variable h6taet "Tätigkeit der Person 6";
label variable h7taet "Tätigkeit der Person 7";
label variable h8taet "Tätigkeit der Person 8";
label variable h1fhs "PKW-Führerscheinbesitz Person 1";
label variable h2fhs "PKW-Führerscheinbesitz Person 2";
label variable h3fhs "PKW-Führerscheinbesitz Person 3";
label variable h4fhs "PKW-Führerscheinbesitz Person 4";
label variable h5fhs "PKW-Führerscheinbesitz Person 5";
label variable h6fhs "PKW-Führerscheinbesitz Person 6";
label variable h7fhs "PKW-Führerscheinbesitz Person 7";
label variable h8fhs "PKW-Führerscheinbesitz Person 8";
label variable h041_1 "Hersteller Pkw 1";
label variable h0412_1 "Baujahr Pkw 1";
label variable h0413_1 "Erwerbsjahr Pkw 1";
label variable h044_1 "Hauptnutzer im HH Pkw 1 ";
label variable h045_1 "Nutzer Person im HH Pkw 1";
label variable h046_1 "Halter Pkw 1";
label variable h047_1 "Zulassungsart Pkw 1";
label variable h048_1 "Antriebsart Pkw 1";
label variable h049_1 "PS- / kW-Angabe Einheit Pkw 1";
label variable h0491_1 "PS Pkw 1";
label variable h0492_1 "kW Pkw 1";
label variable h0410_1 "Hubraum in ccm Pkw 1";
label variable h0411_11 "Stellplatz Garage Pkw1";
label variable h0411_21 "Stellplatz Parkplatz am Haus Pkw1";
label variable h0411_31 "Stellplatz Parkplatz in der Nähe Pkw1";
label variable h0411_41 "Stellplatz unterschiedlich Pkw1";
label variable h0414_1 "Kilometerstand Pkw 1";
label variable h0415_1 "Jahresfahrleistung Pkw 1";
label variable h041_2 "Hersteller Pkw 2";
label variable h0412_2 "Baujahr Pkw 2";
label variable h0413_2 "Erwerbsjahr Pkw 2";
label variable h044_2 "Hauptnutzer im HH Pkw 1 ";
label variable h045_2 "Nutzer Person im HH Pkw 2";
label variable h046_2 "Halter Pkw 2";
label variable h047_2 "Zulassungsart Pkw 2";
label variable h048_2 "Antriebsart Pkw 2";
label variable h049_2 "PS- / kW-Angabe Einheit Pkw 2";
label variable h0491_2 "PS Pkw 2";
label variable h0492_2 "kW Pkw 2";
label variable h0410_2 "Hubraum in ccm Pkw 2";
label variable h0411_12 "Stellplatz Garage Pkw2";
label variable h0411_22 "Stellplatz Parkplatz am Haus Pkw2";
label variable h0411_32 "Stellplatz Parkplatz in der Nähe Pkw2";
label variable h0411_42 "Stellplatz unterschiedlich Pkw2";
label variable h0414_2 "Kilometerstand Pkw 2";
label variable h0415_2 "Jahresfahrleistung Pkw 2";
label variable h041_3 "Hersteller Pkw 3";
label variable h0412_3 "Baujahr Pkw 3";
label variable h0413_3 "Erwerbsjahr Pkw 3";
label variable h044_3 "Hauptnutzer im HH Pkw 1 ";
label variable h045_3 "Nutzer Person im HH Pkw 3";
label variable h046_3 "Halter Pkw 3";
label variable h047_3 "Zulassungsart Pkw 3";
label variable h048_3 "Antriebsart Pkw 3";
label variable h049_3 "PS- / kW-Angabe Einheit Pkw 3";
label variable h0491_3 "PS Pkw 3";
label variable h0492_3 "kW Pkw 3";
label variable h0410_3 "Hubraum in ccm Pkw 3";
label variable h0411_13 "Stellplatz Garage Pkw3";
label variable h0411_23 "Stellplatz Parkplatz am Haus Pkw3";
label variable h0411_33 "Stellplatz Parkplatz in der Nähe Pkw3";
label variable h0411_43 "Stellplatz unterschiedlich Pkw3";
label variable h0414_3 "Kilometerstand Pkw 3";
label variable h0415_3 "Jahresfahrleistung Pkw 3";
label variable h04_1 "Anzahl funktionstüchtige Fahrräder im HH";
label variable h04_2 "Anzahl Motorräder, Mofas etc. im HH";
label variable h04_3 "Anzahl Pkw im HH";
label variable h04_4 "Anzahl Lkw bis 3,5 t im HH";
label variable h04_5 "Anzahl Lkw ab 3,5 t im HH";
label variable h04_6 "Anzahl Lkw ges im HH";
label variable h05 "Wohnlage";
label variable h06_1 "Verfügbare technische Einrichtungen im HH: Telefon Festnetz";
label variable h06_2 "Verfügbare technische Einrichtungen im HH: Handy";
label variable h06_3 "Verfügbare technische Einrichtungen im HH: Computer";
label variable h06_4 "Verfügbare technische Einrichtungen im HH: Internet";
label variable h06_5 "Verfügbare technische Einrichtungen im HH: Nichts davon";
label variable h06_7 "Verfügbare technische Einrichtungen im HH: Verweigert";
label variable h06_8 "Verfügbare technische Einrichtungen im HH: Weiß nicht";
label variable h07 "Netto-Haushaltseinkommensangabe in Euro oder DM?";
label variable h071 "Netto-Haushaltseinkommensangabe in DM";
label variable h071c "Netto-Haushaltseinkommensangabe in DM (1.Nachfrage für Verweigerer)";
label variable h0712c "Netto-Haushaltseinkommensangabe in DM (2.Nachfrage für Verweigerer)";
label variable h0713c "Netto-Haushaltseinkommensangabe in DM (2.Nachfrage für Verweigerer)";
label variable h072 "Netto-Haushaltseinkommensangabe in EURO";
label variable h072c "Netto-Haushaltseinkommensangabe in EURO (1.Nachfrage für Verweigerer)";
label variable h0722c "Netoo-Haushaltseinkommensangabe in EURO (2.Nachfrage für Verweigerer)";
label variable h0723c "Netto-Haushaltseinkommensangabe in EURO (2.Nachfrage für Verweigerer)";
label variable hheink "Netto-Haushaltseinkommen";
label variable wtag "wochentag";
label variable bland "Bundesland";
label variable westost "West-Ost Kennung";
label variable bbr_reg "Regionsgrundtyp";
label variable bbr_dreg "differenzierter Regionstyp";
label variable bbrkrtyp "BBR/BfLR Kreistyp";
label variable ggkpol "Politische Ortsgrößenklasse";
label variable ggkbik "BIK-Regionstypenklasse";
label variable voll_1 "1-Personenregel";
label variable voll_50 "50%-Personenregel";
label variable voll_100 "100%-Personenregel";
label variable erwb1 "Tätigkeit der 1. Person rekodiert";
label variable erwb2 "Tätigkeit der 2. Person rekodiert";
label variable erwb3 "Tätigkeit der 3. Person rekodiert";
label variable erwb4 "Tätigkeit der 4. Person rekodiert";
label variable erwb5 "Tätigkeit der 5. Person rekodiert";
label variable erwb6 "Tätigkeit der 6. Person rekodiert";
label variable erwb7 "Tätigkeit der 7. Person rekodiert";
label variable erwb8 "Tätigkeit der 8. Person rekodiert";
label variable lebensp "Lebensphase";
label variable p_int "Anzahl realisierte Personeninterviews";
label variable p_intgr "Anteil Personeninterviews im HH gruppiert";
label variable hhgr06 "Anzahl der Personen im Haushalt unter 6";
label variable hhgr14 "Anzahl der Personen im Haushalt unter 14";
label variable hhgr18 "Anzahl der Personen im Haushalt unter 18";
label variable stichtag "Datum Stichtag für Haushalt";
label variable gemnr "Gemeindenummer";
label variable stichpro "stichprobenkennung";
label variable befrag "Befragungsart";
label variable gew_ha "Haushaltsgewicht für Aufstockung";
label variable an_schiene "Schienenanschluss";
label variable typ "Gebietstyp";
label variable lage_iv "";
label variable zentralit "";
label variable entfernung "";
label variable zone_1 "";
label variable vz_nr_ne_1 "Verkehrszellennummer";
label variable vzname_n_1 "";
label variable typname "";
label variable zentrtyp "Zentralitaetstyp";
label variable ZTypOrd "Zentralitaetstyp ordinal";
label variable PkwHH3 "Pkw im Haushalt (0,1,2,3+)";
label variable PkwHH2 "Pkw im Haushalt (0, 1, 2+)";
label variable PkwHH1 "Pkw im Haushalt (0, 1+)";
label variable HHgr04 "Haushaltsgröße (0-4+)";
label variable hhgrew "Anzahl Erwachsener";
label variable hhkinder "Kinder im Haushalt";
label variable hhgrewKl "Anzahl Erwachsener (1, 2 oder 3+)";
label variable FRAU_65 "Frauen Summe Jahre über 65";
label variable MANN_65 "Männer Summe Jahre über 65";
label variable hhgr65 "Anzahl Personen über 65";
label variable hhgr1864 "Anzahl Personen zwischen 18 und 64 Jahre";
label variable hh1864Kl "Anzahl Personen zwischen 18 und 64 (in Klassen)";
label variable hhgr65Kl "Anzahl Personen über 65 (0, 1, 2+)";
label variable hh1824 "Anzahl der Personen zwischen 18 und 24 Jahre";
label variable hh1824Kl "Anzahl der Personen zwischen 18 und 24 (0, 1, 2+)";
label variable hh2565 "Anzahl der Personen zwischen 25 und 64";
label variable hh2564Kl "Anzahl der Personen zwischen 25 und 64 (0, 1, 2+)";
label variable ue65un24 "Rentner und 18-24-jähringe im HH";
label variable ZPP750 "Zielpotenzial periodischer Bedarf in 750 m Luftlinie";
label variable ZPP750LN "Zielpotenzial (ln) periodischer Bedarf in 750 m Luftlinie";
label variable ZPP750LG "Zielpotenzial (ln10) periodischer Bedarf in 750 m Luftlinie";
label variable ZPP750Kl "Erreichbarkeit periodischer Bedarf in 750 m Luftlinie";
label variable ZPP750K2 "Erreichbarkeit periodischer Bedarf in 750 m Luftlinie";
label variable ZPP750K3 "Erreichbarkeit periodischer Bedarf in 750 m Luftlinie";
label variable filter_A_ "h04_3 < 8 & hheink <= 8 (FILTER)";
label variable filter1_ "h04_3 < 8 & hheink <= 8 & hhgrewKl = 1 (FILTER)";
label variable filter2_ "h04_3 < 8 & hheink <= 8 & hhgrewKl = 2 (FILTER)";
label variable filter3_ "h04_3 < 8 & hheink <= 8 & hhgrewKl = 3 (FILTER)";

*define ValueLabels: ;

label define Label_0
	1	"Lebe allein"
	9	"Keine Angabe"
	3	"Lebe (allein) in einem Wohnheim"
	2	"Lebe mit anderen Personen im Haushalt"
	7	"Verweigert"
	;

label define Label_1
	1	"Ja, erhalten und gelesen"
	3	"Nein, nicht erhalten"
	2	"Ja, erhalten, aber (noch) nicht gelesen"
	.b	"Switcher werden nicht befragt"
	.a	"PAPI wird nicht befragt"
	;

label define Label_2
	-70	"In Papi nicht erhoben"
	.d	"4-Personen Haushalt"
	.c	"5-Personen Haushalt"
	.b	"6-Personen Haushalt"
	.a	"7-Personen Haushalt"
	.g	"1-Personen Haushalt"
	.f	"2-Personen Haushalt"
	.e	"3-Personen Haushalt"
	1	"Männlich"
	2	"Weiblich"
	9	"Keine Angabe"
	;

label define Label_3
	997	"Verweigert"
	-70	"In Papi nicht erhoben"
	.d	"4-Personen Haushalt"
	.c	"5-Personen Haushalt"
	.b	"6-Personen Haushalt"
	.a	"7-Personen Haushalt"
	999	"Keine Angabe"
	998	"Weiß nicht"
	.f	"2-Personen Haushalt"
	.g	"1-Personen Haushalt"
	.e	"3-Personen Haushalt"
	;

label define Label_4
	.k	"CATI: Befragte über  69 Jahre werden nicht befragt"
	.a	"In Papi nicht erhoben (PAPI)"
	1	"Ja"
	.b	"In Papi nicht erhoben"
	.c	"In Papi nicht erhoben (Switcher)"
	.g	"4-Personen Haushalt"
	.f	"5-Personen Haushalt"
	.e	"6-Personen Haushalt"
	.d	"7-Personen Haushalt"
	.j	"1-Personen Haushalt"
	.i	"2-Personen Haushalt"
	.h	"3-Personen Haushalt"
	.l	"CATI: Befragte unter 15 Jahre werden nicht befragt"
	2	"Nein"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_5
	3	"Auszubildende/r"
	2	"Teilzeit"
	1	"Vollzeit"
	.a	"In Papi nicht erhoben"
	.e	"4-Personen Haushalt"
	.d	"5-Personen Haushalt"
	.c	"6-Personen Haushalt"
	.b	"7-Personen Haushalt"
	.h	"1-Personen Haushalt"
	.g	"2-Personen Haushalt"
	.f	"3-Personen Haushalt"
	.l	"CATI: Befragte unter 15 Jahre werden nicht befragt"
	.j	"CATI: Befragte nicht berufstätig"
	.k	"CATI: Befragte über  69 Jahre werden nicht befragt"
	4	"Nicht berufstätig"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	.i	"CATI: Verweigert/Weiß nicht zur Berufstätigkeit"
	;

label define Label_6
	99	"Keine Angabe"
	98	"Weiß nicht"
	12	"Bin noch berufstätig"
	97	"Verweigert"
	96	"Doppelnennung"
	11	"Anderes"
	10	"Wehr-/Zivildienstleistender"
	.a	"In Papi nicht erhoben"
	.e	"4-Personen Haushalt"
	.d	"5-Personen Haushalt"
	.c	"6-Personen Haushalt"
	.b	"7-Personen Haushalt"
	.h	"1-Personen Haushalt"
	.g	"2-Personen Haushalt"
	.f	"3-Personen Haushalt"
	1	"Kind zu Hause betreut"
	3	"(Vor-) Schüler/in"
	2	"Kind betreut Einrichtung"
	5	"Student/in"
	4	"Auszubildender"
	7	"Vorübergehend freigestellt"
	6	"Zur Zeit arbeitslos"
	9	"Rentner/in"
	8	"Hausfrau/-mann"
	.i	"Auszubildende/r"
	.j	"Berufstätig"
	;

label define Label_7
	1	"Ja"
	.a	"In Papi nicht erhoben"
	.e	"4-Personen Haushalt"
	.d	"5-Personen Haushalt"
	.c	"6-Personen Haushalt"
	.b	"7-Personen Haushalt"
	.h	"1-Personen Haushalt"
	.g	"2-Personen Haushalt"
	.f	"3-Personen Haushalt"
	.i	"CATI: Alter Verweigert/Weiss nicht"
	.j	"CATI: Befragte unter 18 Jahre"
	2	"Nein"
	7	"Verweigert"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_8
	24	"Mercedes Benz"
	25	"Mitsubishi"
	26	"Nissan"
	27	"Porsche"
	20	"Saab"
	21	"Seat"
	22	"Skoda"
	23	"Mazda"
	28	"Rover"
	29	"Suzuki"
	40	"anderer Hersteller"
	18	"Peugeot"
	1	"Alfa Romeo"
	3	"BMW"
	2	"Audi        "
	5	"Citroen"
	4	"Chrysler"
	7	"DAF"
	6	"Daewoo"
	9	"Daimler Benz"
	8	"Daihatsu"
	99	"Keine Angabe"
	98	"weiß nicht"
	38	"Ferrari"
	97	"verweigert"
	11	"Ford"
	10	"Fiat"
	13	"Jaguar"
	12	"Hyundai"
	15	"Lada"
	14	"Jeep"
	17	"Opel"
	16	"Lancia"
	19	"Renault"
	32	"VW"
	31	"Trabant"
	30	"Toyota"
	37	"Subaru"
	36	"Kia"
	35	"Honda"
	34	"Wartburg"
	33	"Volvo"
	.b	"Kein Pkw im HH"
	.a	"Nur ein Pkw im HH"
	;

label define Label_9
	99999	"Keine Angabe"
	99998	"Weiß nicht"
	.c	"Kein Pkw im HH"
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	99994	"Wert unplausibel"
	99997	"Verweigert"
	;

label define Label_10
	.a	"Nur zwei Pkws im HH"
	1	"Ich selbst"
	3	"Nicht zu zuordnen"
	2	"Andere Person"
	.c	"Kein Pkw im HH"
	7	"Verweigert"
	.b	"Nur ein Pkw im HH"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_11
	7	"Person 7"
	.a	"Hauptnutzer des Pkws nicht zu zuordnen (PAPI)"
	6	"Person 6"
	.b	"Hauptnutzer des Pkws nicht zu zuordnen (Switcher)"
	.d	"CATI: Fahrer nicht zu zuordnen"
	.c	"CATI:Befragte verweigert/weiß nicht zum Hauptnutzer des Pkws"
	99	"Keine Angabe"
	98	"Weiß nicht"
	8	"Person 8"
	97	"Verweigert"
	96	"Doppelnennung"
	1	"Person 1"
	3	"Person 3"
	2	"Person 2"
	.g	"Kein Pkw im HH"
	4	"Person 4"
	.e	"Nur zwei Pkws im HH"
	.f	"Nur ein Pkw im HH"
	5	"Person 5"
	;

label define Label_12
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	1	"Privat"
	2	"Anderer Halter"
	.c	"Kein Pkw im HH"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_13
	1	"Als Pkw"
	3	"Lkw ab 3,5 t"
	2	" Lkw bis 3,5 t"
	.a	"Kein Pkw im HH"
	4	"Anderes"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_14
	11	"Benzin"
	3	"Anderes"
	2	"Diesel"
	.a	"Kein Pkw im HH"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_15
	.b	"In Papi nicht erhoben (Switcher)"
	.a	"In Papi nicht erhoben (PAPI)"
	1	"PS"
	2	"KW"
	.e	"Kein Pkw im HH"
	7	"Verweigert"
	.d	"Nur ein Pkw im HH"
	9	"Keine Angabe"
	8	"Weiß nicht"
	.c	"Nur zwei Pkws im HH"
	;

label define Label_16
	9999	"Keine Angabe"
	9998	"Weiß nicht"
	-1	"Kein Pkw im HH"
	-3	"Nur zwei Pkws im HH"
	-10	"CATI: PS/KW-Wert nicht berechenbar aufgr. fehlender Angaben"
	-2	"Nur ein Pkw im HH"
	9997	"Verweigert"
	;

label define Label_17
	7	"Verweigert"
	1	"Ja"
	0	"Nein"
	.c	"Kein Pkw im HH"
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_18
	9999997	"Verweigert"
	.c	"Kein Pkw im HH"
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	9999999	"Keine Angabe"
	9999998	"Weiß nicht"
	;

label define Label_19
	999999	"Keine Angabe"
	999998	"Weiß nicht"
	.c	"Kein Pkw im HH"
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	999997	"Verweigert"
	;

label define Label_20
	7	"Verweigert"
	1	"Als Pkw"
	3	"Lkw ab 3,5 t"
	2	" Lkw bis 3,5 t"
	.c	"Kein Pkw im HH"
	4	"Anderes"
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_21
	7	"Verweigert"
	6	"Doppelnennung"
	1	"Benzin"
	3	"Anderes"
	2	"Diesel"
	.c	"Kein Pkw im HH"
	.a	"Nur zwei Pkws im HH"
	.b	"Nur ein Pkw im HH"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_22
	24	"Mercedes Benz"
	25	"Mitsubishi"
	26	"Nissan"
	27	"Porsche"
	20	"Saab"
	21	"Seat"
	22	"Skoda"
	23	"Mazda"
	28	"Rover"
	29	"Suzuki"
	40	"Anderer Hersteller"
	1	"Alfa Romeo"
	3	"BMW"
	2	"Audi        "
	5	"Citroen"
	4	"Chrysler"
	7	"DAF"
	6	"Daewoo"
	9	"Daimler Benz"
	8	"Daihatsu"
	.b	"Nur ein Pkw im HH"
	99	"Keine Angabe"
	98	"Weiß nicht"
	12	"Hyundai"
	97	"Verweigert"
	11	"Ford"
	10	"Fiat"
	13	"Jaguar"
	38	"Ferrari"
	15	"Lada"
	14	"Jeep"
	17	"Opel"
	16	"Lancia"
	19	"Renault"
	32	"VW"
	31	"Trabant"
	30	"Toyota"
	37	"Subaru"
	36	"Kia"
	35	"Honda"
	34	"Wartburg"
	33	"Volvo"
	.c	"Kein Pkw im HH"
	.a	"Nur zwei Pkws im HH"
	18	"Peugeot"
	;

label define Label_23
	-5	"Wert aufgrund fehlender Angaben nicht berechenbar"
	997	"Verweigert"
	998	"Weiß nicht"
	;

label define Label_24
	1	"Eher gehoben"
	3	"Eher einfach"
	2	"Mittlere Wohnlage"
	4	"Keine dieser Wohnanlage"
	7	"Verweigert"
	6	"Doppelnennung"
	9	"Keine Angabe"
	8	"Weiß nicht"
	;

label define Label_25
	1	"Verfügbar"
	0	"Nicht verfügbar"
	-70	"In CATI nicht erhoben"
	;

label define Label_26
	1	"Trifft zu"
	0	"Trifft nicht zu"
	-50	"In Papi nicht erhoben (Switcher)"
	-80	"In Papi nicht erhoben (PAPI)"
	;

label define Label_27
	.b	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.a	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.d	"In Papi nicht erhoben (Switcher)"
	1	"DM"
	2	"Euro"
	.c	"In Papi nicht erhoben (PAPI)"
	;

label define Label_28
	.c	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.b	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.e	"In PAPI nicht erhoben (Switcher)"
	.a	"Befragte macht die Einkommensangaben in Euro"
	1	"Bis unter 1.000 DM pro Monat"
	98	"Weiß nicht          "
	3	"1.800 DM bis unter 3.000 DM "
	2	"1.000 DM bis unter 1.800 DM "
	5	"4.000 DM bis unter 5.000 DM "
	.d	"In PAPI nicht erhoben (PAPI)"
	7	"6.000 DM bis unter 7.000 DM "
	6	"5.000 DM bis unter 6.000 DM "
	9	"7.500 DM und mehr pro Monat "
	8	"7.000 DM bis unter 7.500 DM "
	97	"Verweigert          "
	4	"3.000 DM bis unter 4.000 DM "
	;

label define Label_29
	.d	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.c	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.f	"In PAPI nicht erhoben (Switcher)"
	.b	"Befragte macht die Einkommensangaben in Euro"
	.a	"Befragte machte Auskunft zum Einkommen"
	1	"Unter 4.000 DM "
	98	"Weiß nicht"
	2	"Mehr als 4.000 DM"
	.e	"In PAPI nicht erhoben (PAPI)"
	97	"Verweigert"
	;

label define Label_30
	.f	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.e	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.a	"Befragte mit mehr als 4000 DM werden in h0713c befragt"
	.h	"In PAPI nicht erhoben (Switcher)"
	.d	"Befragte macht die Einkommensangaben in Euro"
	.c	"Befragte machte Auskunft zum Einkommen"
	.b	"Befragte verweigert Auskunft zum Einkommen"
	1	"Weniger als 1.000 DM pro Monat "
	98	"Weiß nicht"
	3	"Weniger als 3.000 DM   "
	2	"Weniger als 1.800 DM   "
	.g	"In PAPI nicht erhoben (PAPI)"
	97	"Verweigert"
	4	"Zwischen 3.000 und 4.000 DM "
	;

label define Label_31
	.f	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.e	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.a	"Befragte mit weniger als 4000 DM werden in h0712c befragt"
	.h	"In PAPI nicht erhoben (Switcher)"
	.d	"Befragte macht die Einkommensangaben in Euro"
	.c	"Befragte machte Auskunft zum Einkommen"
	.b	"Befragte verweigert Auskunft zum Einkommen"
	98	"Weiß nicht"
	5	"Zwischen 4.000 und 5.000 DM "
	.g	"In PAPI nicht erhoben (PAPI)"
	7	"Mehr als 6.000 DM           "
	6	"Mehr als 5.000 DM           "
	9	"Mehr als 7.500 DM pro Monat "
	8	"Mehr als 7.000 DM           "
	97	"Verweigert                  "
	;

label define Label_32
	.c	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.b	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.a	"Befragte macht die Einkommensangaben in DM"
	1	"bis unter 500 € pro Monat   "
	98	"Weiß nicht              "
	3	"900 € bis unter 1.500 €     "
	2	"500 € bis unter 900 €       "
	5	"2.000 € bis unter 2.600 €   "
	4	"1.500 € bis unter 2.000 €   "
	7	"3.000 € bis unter 3.600 €   "
	6	"2.600 € bis unter 3.000 €   "
	99	"Keine Angabe"
	8	"3.600 € und mehr pro Monat  "
	97	"Verweigert          "
	96	"Doppelnennung"
	;

label define Label_33
	.d	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.c	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.b	"Befragte macht die Einkommensangaben in DM"
	.a	"Befragte machte Auskunft zum Einkommen"
	1	"unter 2.000 € "
	98	"Weiß nicht              "
	2	"mehr als 2.000 € "
	.e	"In PAPI nicht erhoben (PAPI)"
	97	"Verweigert          "
	.f	"In PAPI nicht erhoben (Switcher)"
	;

label define Label_34
	.f	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.e	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.a	"Befragte mit mehr als 2.000 € werden in h0713c befragt"
	.d	"Befragte macht die Einkommensangaben in DM"
	.c	"Befragte machte Auskunft zum Einkommen"
	.b	"Befragte verweigert Auskunft zum Einkommen"
	.g	"In PAPI nicht erhoben (PAPI)"
	1	"weniger als 500 €         "
	98	"Weiß nicht                "
	3	"weniger als 1.5000 €      "
	2	"weniger als 900 €         "
	4	"zwischen 1.500 und 2.000 €"
	97	"Verweigert                "
	.h	"In PAPI nicht erhoben (Switcher)"
	;

label define Label_35
	.f	"CATI: Personen unter 18 Jahre werden nicht befragt"
	.e	"CATI: Personen ohne Altersangaben werden nicht befragt"
	.a	"Befragte mit weniger als 2.000 € werden in h0712c befragt"
	.d	"Befragte macht die Einkommensangaben in DM"
	.c	"Befragte machte Auskunft zum Einkommen"
	.b	"Befragte verweigert Auskunft zum Einkommen"
	98	"weiß nicht                 "
	5	"zwischen 2.000 und 2.6000 €"
	.g	"In PAPI nicht erhoben (PAPI)"
	7	"mehr als 3.000 €           "
	6	"mehr als 2.600 €           "
	8	"mehr als 3.600 €           "
	97	"verweigert                 "
	.h	"In PAPI nicht erhoben (Switcher)"
	;

label define Label_36
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

label define Label_37
	1	"Montag"
	3	"Mittwoch"
	2	"Dienstag"
	5	"Freitag"
	4	"Donnerstag"
	7	"Sonntag"
	6	"Samstag"
	;

label define Label_38
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

label define Label_39
	1	"West"
	2	"Ost"
	;

label define Label_40
	1	"Agglomerationsräume (Regionstyp 1)"
	3	"Ländliche Räume (Regionstyp 3)"
	2	"Verstädterte Räume (Regionstyp 2)"
	;

label define Label_41
	1	"Hochverdichtete Agglomerationsräume"
	3	"Verstädterte Räume höherer Dichte"
	2	"Agglomerationsräume mit herausragenden Zentren"
	5	"Verstädterte Räume mittlerer Dichte ohne Oberzentren"
	4	"Verstädterte Räume mittlerer Dichte mit Oberzentren"
	7	"Ländliche Räume geringerer Dichte"
	6	"Ländliche Räume höherer Dichte"
	;

label define Label_42
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

label define Label_43
	1	"unter 2.000 Einwohner"
	3	"5.000 bis unter 20.000 Einwohner"
	2	"2.000 bis unter 5000 Einwohner"
	5	"50.000 bis unter 100.000 Einwohner"
	4	"20.000 bis unter 50.000 Einwohner"
	7	"500.000 und mehr Einwohner"
	6	"100.000 bis unter 500.000 Einwohner"
	;

label define Label_44
	10	"500000+ Kern"
	1	"unter 2002"
	3	"5000 - u. 20000"
	2	"2000 - u. 5000"
	5	"50000 - u. 100000 Rest"
	4	"20000 - u. 50000"
	7	"100000 - u. 500000 Rest"
	6	"50000 - u. 100000 Kern"
	9	"500000+ Rest"
	8	"100000 - u. 500000 Kern"
	;

label define Label_45
	1	"Kinder"
	0	"KA"
	3	"Auszubildende"
	2	"Schüler"
	5	"Wehr-/Zividienstleistender"
	4	"Student"
	7	"Hausfrau/-mann"
	6	"Freigestellt, Erwerbslos"
	9	"Erwerbstätig"
	8	"Rentner"
	;

label define Label_46
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

label define Label_47
	1	"bis unter 50 %"
	0	"noch keine"
	3	"100 %"
	2	"50 bis unter 100 % "
	9	"k.A. in kh02"
	;

label define Label_48
	1	"CATI"
	2	"PEN"
	;

label define Label_49
	1	"HH-Int schriftlich, Pers/Wegeinterview CATI"
	0	"HH/Pers/Wegeinterview CATI"
	-1	"HH/Pers/Wegeinterview schriftlich"
	;

label define Label_50
	1	"ohne Schienenanschluss"
	0	"an Schiene"
	;

label define Label_51
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

label define Label_52
	.a	"fehlend"
	1	"OZ Kern"
	3	"OZ Umland"
	2	"OZ Rand"
	5	"GZ"
	4	"MZ"
	6	"Ländlicher Bereich"
	;

label define Label_53
	.a	"fehlend"
	1	"OZ Kern"
	3	"MZ"
	2	"OZ Rand"
	5	"GZ"
	4	"OZ Umland"
	6	"Ländlicher Bereich"
	;

label define Label_54
	1	"ja"
	0	"nein"
	;

label define Label_55
	.a	"kein Alter angegeben"
	0	"65 Jahre und jünger"
	;

label define Label_56
	11	"1 P. 18-24 & 1 P. 65+"
	10	"1 P. 65+"
	12	"2 P. 18-24 & 1 P. 65+"
	20	"2 P. 65+"
	21	"1 P. 18-24 & 2 P. 65+"
	22	"2 P. 18-24 & 2 P. 65+"
	1	"1 P. 18-24"
	0	"0 P. 18-24 oder 65+"
	2	"2 P. 18-24"
	;

label define Label_57
	1	"bis 199"
	0	"0"
	3	"2000 bis 3999"
	2	"200 bis 1999"
	5	"über 8000"
	4	"4000 bis 7999"
	;

label define Label_58
	1	"hoch"
	0	"niedrig"
	;

label define Label_59
	1	"200 bis 3999"
	0	"0 bis 199"
	2	"über 4000"
	;

label define Label_60
	1	"Ausgewählt"
	0	"Nicht ausgewählt"
	;


*label Values and recode missings: ;

label values h01 Label_0;
quietly recode h001c (-30.0 = .a);
quietly recode h001c (-20.0 = .b);
quietly recode h001c (-29.0/-21 = .);
label values h001c Label_1;
quietly recode h1sex (-27 = .a);
quietly recode h1sex (-26 = .b);
quietly recode h1sex (-25 = .c);
quietly recode h1sex (-24 = .d);
quietly recode h1sex (-23 = .e);
quietly recode h1sex (-22 = .f);
quietly recode h1sex (-21 = .g);
label values h1sex Label_2;
quietly recode h2sex (-27 = .a);
quietly recode h2sex (-26 = .b);
quietly recode h2sex (-25 = .c);
quietly recode h2sex (-24 = .d);
quietly recode h2sex (-23 = .e);
quietly recode h2sex (-22 = .f);
quietly recode h2sex (-21 = .g);
label values h2sex Label_2;
quietly recode h3sex (-27 = .a);
quietly recode h3sex (-26 = .b);
quietly recode h3sex (-25 = .c);
quietly recode h3sex (-24 = .d);
quietly recode h3sex (-23 = .e);
quietly recode h3sex (-22 = .f);
quietly recode h3sex (-21 = .g);
label values h3sex Label_2;
quietly recode h4sex (-27 = .a);
quietly recode h4sex (-26 = .b);
quietly recode h4sex (-25 = .c);
quietly recode h4sex (-24 = .d);
quietly recode h4sex (-23 = .e);
quietly recode h4sex (-22 = .f);
quietly recode h4sex (-21 = .g);
label values h4sex Label_2;
quietly recode h5sex (-27 = .a);
quietly recode h5sex (-26 = .b);
quietly recode h5sex (-25 = .c);
quietly recode h5sex (-24 = .d);
quietly recode h5sex (-23 = .e);
quietly recode h5sex (-22 = .f);
quietly recode h5sex (-21 = .g);
label values h5sex Label_2;
quietly recode h6sex (-27 = .a);
quietly recode h6sex (-26 = .b);
quietly recode h6sex (-25 = .c);
quietly recode h6sex (-24 = .d);
quietly recode h6sex (-23 = .e);
quietly recode h6sex (-22 = .f);
quietly recode h6sex (-21 = .g);
label values h6sex Label_2;
quietly recode h7sex (-27 = .a);
quietly recode h7sex (-26 = .b);
quietly recode h7sex (-25 = .c);
quietly recode h7sex (-24 = .d);
quietly recode h7sex (-23 = .e);
quietly recode h7sex (-22 = .f);
quietly recode h7sex (-21 = .g);
label values h7sex Label_2;
quietly recode h8sex (-27 = .a);
quietly recode h8sex (-26 = .b);
quietly recode h8sex (-25 = .c);
quietly recode h8sex (-24 = .d);
quietly recode h8sex (-23 = .e);
quietly recode h8sex (-22 = .f);
quietly recode h8sex (-21 = .g);
label values h8sex Label_2;
quietly recode h1alter (-27 = .a);
quietly recode h1alter (-26 = .b);
quietly recode h1alter (-25 = .c);
quietly recode h1alter (-24 = .d);
quietly recode h1alter (-23 = .e);
quietly recode h1alter (-22 = .f);
quietly recode h1alter (-21 = .g);
label values h1alter Label_3;
quietly recode h2alter (-27 = .a);
quietly recode h2alter (-26 = .b);
quietly recode h2alter (-25 = .c);
quietly recode h2alter (-24 = .d);
quietly recode h2alter (-23 = .e);
quietly recode h2alter (-22 = .f);
quietly recode h2alter (-21 = .g);
label values h2alter Label_3;
quietly recode h3alter (-27 = .a);
quietly recode h3alter (-26 = .b);
quietly recode h3alter (-25 = .c);
quietly recode h3alter (-24 = .d);
quietly recode h3alter (-23 = .e);
quietly recode h3alter (-22 = .f);
quietly recode h3alter (-21 = .g);
label values h3alter Label_3;
quietly recode h4alter (-27 = .a);
quietly recode h4alter (-26 = .b);
quietly recode h4alter (-25 = .c);
quietly recode h4alter (-24 = .d);
quietly recode h4alter (-23 = .e);
quietly recode h4alter (-22 = .f);
quietly recode h4alter (-21 = .g);
label values h4alter Label_3;
quietly recode h5alter (-27 = .a);
quietly recode h5alter (-26 = .b);
quietly recode h5alter (-25 = .c);
quietly recode h5alter (-24 = .d);
quietly recode h5alter (-23 = .e);
quietly recode h5alter (-22 = .f);
quietly recode h5alter (-21 = .g);
label values h5alter Label_3;
quietly recode h6alter (-27 = .a);
quietly recode h6alter (-26 = .b);
quietly recode h6alter (-25 = .c);
quietly recode h6alter (-24 = .d);
quietly recode h6alter (-23 = .e);
quietly recode h6alter (-22 = .f);
quietly recode h6alter (-21 = .g);
label values h6alter Label_3;
quietly recode h7alter (-27 = .a);
quietly recode h7alter (-26 = .b);
quietly recode h7alter (-25 = .c);
quietly recode h7alter (-24 = .d);
quietly recode h7alter (-23 = .e);
quietly recode h7alter (-22 = .f);
quietly recode h7alter (-21 = .g);
label values h7alter Label_3;
quietly recode h8alter (-27 = .a);
quietly recode h8alter (-26 = .b);
quietly recode h8alter (-25 = .c);
quietly recode h8alter (-24 = .d);
quietly recode h8alter (-23 = .e);
quietly recode h8alter (-22 = .f);
quietly recode h8alter (-21 = .g);
label values h8alter Label_3;
quietly recode h1beruf (-80 = .a);
quietly recode h1beruf (-70 = .b);
quietly recode h1beruf (-50 = .c);
quietly recode h1beruf (-27 = .d);
quietly recode h1beruf (-26 = .e);
quietly recode h1beruf (-25 = .f);
quietly recode h1beruf (-24 = .g);
quietly recode h1beruf (-23 = .h);
quietly recode h1beruf (-22 = .i);
quietly recode h1beruf (-21 = .j);
quietly recode h1beruf (-6 = .k);
quietly recode h1beruf (-5 = .l);
quietly recode h1beruf (-79/-71 = .);
quietly recode h1beruf (-69/-51 = .);
quietly recode h1beruf (-49/-28 = .);
quietly recode h1beruf (-20/-7 = .);
label values h1beruf Label_4;
quietly recode h2beruf (-80 = .a);
quietly recode h2beruf (-70 = .b);
quietly recode h2beruf (-50 = .c);
quietly recode h2beruf (-27 = .d);
quietly recode h2beruf (-26 = .e);
quietly recode h2beruf (-25 = .f);
quietly recode h2beruf (-24 = .g);
quietly recode h2beruf (-23 = .h);
quietly recode h2beruf (-22 = .i);
quietly recode h2beruf (-21 = .j);
quietly recode h2beruf (-6 = .k);
quietly recode h2beruf (-5 = .l);
quietly recode h2beruf (-79/-71 = .);
quietly recode h2beruf (-69/-51 = .);
quietly recode h2beruf (-49/-28 = .);
quietly recode h2beruf (-20/-7 = .);
label values h2beruf Label_4;
quietly recode h3beruf (-80 = .a);
quietly recode h3beruf (-70 = .b);
quietly recode h3beruf (-50 = .c);
quietly recode h3beruf (-27 = .d);
quietly recode h3beruf (-26 = .e);
quietly recode h3beruf (-25 = .f);
quietly recode h3beruf (-24 = .g);
quietly recode h3beruf (-23 = .h);
quietly recode h3beruf (-22 = .i);
quietly recode h3beruf (-21 = .j);
quietly recode h3beruf (-6 = .k);
quietly recode h3beruf (-5 = .l);
quietly recode h3beruf (-79/-71 = .);
quietly recode h3beruf (-69/-51 = .);
quietly recode h3beruf (-49/-28 = .);
quietly recode h3beruf (-20/-7 = .);
label values h3beruf Label_4;
quietly recode h4beruf (-80 = .a);
quietly recode h4beruf (-70 = .b);
quietly recode h4beruf (-50 = .c);
quietly recode h4beruf (-27 = .d);
quietly recode h4beruf (-26 = .e);
quietly recode h4beruf (-25 = .f);
quietly recode h4beruf (-24 = .g);
quietly recode h4beruf (-23 = .h);
quietly recode h4beruf (-22 = .i);
quietly recode h4beruf (-21 = .j);
quietly recode h4beruf (-6 = .k);
quietly recode h4beruf (-5 = .l);
quietly recode h4beruf (-79/-71 = .);
quietly recode h4beruf (-69/-51 = .);
quietly recode h4beruf (-49/-28 = .);
quietly recode h4beruf (-20/-7 = .);
label values h4beruf Label_4;
quietly recode h5beruf (-80 = .a);
quietly recode h5beruf (-70 = .b);
quietly recode h5beruf (-50 = .c);
quietly recode h5beruf (-27 = .d);
quietly recode h5beruf (-26 = .e);
quietly recode h5beruf (-25 = .f);
quietly recode h5beruf (-24 = .g);
quietly recode h5beruf (-23 = .h);
quietly recode h5beruf (-22 = .i);
quietly recode h5beruf (-21 = .j);
quietly recode h5beruf (-6 = .k);
quietly recode h5beruf (-5 = .l);
quietly recode h5beruf (-79/-71 = .);
quietly recode h5beruf (-69/-51 = .);
quietly recode h5beruf (-49/-28 = .);
quietly recode h5beruf (-20/-7 = .);
label values h5beruf Label_4;
quietly recode h6beruf (-80 = .a);
quietly recode h6beruf (-70 = .b);
quietly recode h6beruf (-50 = .c);
quietly recode h6beruf (-27 = .d);
quietly recode h6beruf (-26 = .e);
quietly recode h6beruf (-25 = .f);
quietly recode h6beruf (-24 = .g);
quietly recode h6beruf (-23 = .h);
quietly recode h6beruf (-22 = .i);
quietly recode h6beruf (-21 = .j);
quietly recode h6beruf (-6 = .k);
quietly recode h6beruf (-5 = .l);
quietly recode h6beruf (-79/-71 = .);
quietly recode h6beruf (-69/-51 = .);
quietly recode h6beruf (-49/-28 = .);
quietly recode h6beruf (-20/-7 = .);
label values h6beruf Label_4;
quietly recode h7beruf (-80 = .a);
quietly recode h7beruf (-70 = .b);
quietly recode h7beruf (-50 = .c);
quietly recode h7beruf (-27 = .d);
quietly recode h7beruf (-26 = .e);
quietly recode h7beruf (-25 = .f);
quietly recode h7beruf (-24 = .g);
quietly recode h7beruf (-23 = .h);
quietly recode h7beruf (-22 = .i);
quietly recode h7beruf (-21 = .j);
quietly recode h7beruf (-6 = .k);
quietly recode h7beruf (-5 = .l);
quietly recode h7beruf (-79/-71 = .);
quietly recode h7beruf (-69/-51 = .);
quietly recode h7beruf (-49/-28 = .);
quietly recode h7beruf (-20/-7 = .);
label values h7beruf Label_4;
quietly recode h8beruf (-80 = .a);
quietly recode h8beruf (-70 = .b);
quietly recode h8beruf (-50 = .c);
quietly recode h8beruf (-27 = .d);
quietly recode h8beruf (-26 = .e);
quietly recode h8beruf (-25 = .f);
quietly recode h8beruf (-24 = .g);
quietly recode h8beruf (-23 = .h);
quietly recode h8beruf (-22 = .i);
quietly recode h8beruf (-21 = .j);
quietly recode h8beruf (-6 = .k);
quietly recode h8beruf (-5 = .l);
quietly recode h8beruf (-79/-71 = .);
quietly recode h8beruf (-69/-51 = .);
quietly recode h8beruf (-49/-28 = .);
quietly recode h8beruf (-20/-7 = .);
label values h8beruf Label_4;
quietly recode h1besch (-70 = .a);
quietly recode h1besch (-27 = .b);
quietly recode h1besch (-26 = .c);
quietly recode h1besch (-25 = .d);
quietly recode h1besch (-24 = .e);
quietly recode h1besch (-23 = .f);
quietly recode h1besch (-22 = .g);
quietly recode h1besch (-21 = .h);
quietly recode h1besch (-8 = .i);
quietly recode h1besch (-7 = .j);
quietly recode h1besch (-6 = .k);
quietly recode h1besch (-5 = .l);
quietly recode h1besch (-69/-28 = .);
quietly recode h1besch (-20/-9 = .);
label values h1besch Label_5;
quietly recode h2besch (-70 = .a);
quietly recode h2besch (-27 = .b);
quietly recode h2besch (-26 = .c);
quietly recode h2besch (-25 = .d);
quietly recode h2besch (-24 = .e);
quietly recode h2besch (-23 = .f);
quietly recode h2besch (-22 = .g);
quietly recode h2besch (-21 = .h);
quietly recode h2besch (-8 = .i);
quietly recode h2besch (-7 = .j);
quietly recode h2besch (-6 = .k);
quietly recode h2besch (-5 = .l);
quietly recode h2besch (-69/-28 = .);
quietly recode h2besch (-20/-9 = .);
label values h2besch Label_5;
quietly recode h3besch (-70 = .a);
quietly recode h3besch (-27 = .b);
quietly recode h3besch (-26 = .c);
quietly recode h3besch (-25 = .d);
quietly recode h3besch (-24 = .e);
quietly recode h3besch (-23 = .f);
quietly recode h3besch (-22 = .g);
quietly recode h3besch (-21 = .h);
quietly recode h3besch (-8 = .i);
quietly recode h3besch (-7 = .j);
quietly recode h3besch (-6 = .k);
quietly recode h3besch (-5 = .l);
quietly recode h3besch (-69/-28 = .);
quietly recode h3besch (-20/-9 = .);
label values h3besch Label_5;
quietly recode h4besch (-70 = .a);
quietly recode h4besch (-27 = .b);
quietly recode h4besch (-26 = .c);
quietly recode h4besch (-25 = .d);
quietly recode h4besch (-24 = .e);
quietly recode h4besch (-23 = .f);
quietly recode h4besch (-22 = .g);
quietly recode h4besch (-21 = .h);
quietly recode h4besch (-8 = .i);
quietly recode h4besch (-7 = .j);
quietly recode h4besch (-6 = .k);
quietly recode h4besch (-5 = .l);
quietly recode h4besch (-69/-28 = .);
quietly recode h4besch (-20/-9 = .);
label values h4besch Label_5;
quietly recode h5besch (-70 = .a);
quietly recode h5besch (-27 = .b);
quietly recode h5besch (-26 = .c);
quietly recode h5besch (-25 = .d);
quietly recode h5besch (-24 = .e);
quietly recode h5besch (-23 = .f);
quietly recode h5besch (-22 = .g);
quietly recode h5besch (-21 = .h);
quietly recode h5besch (-8 = .i);
quietly recode h5besch (-7 = .j);
quietly recode h5besch (-6 = .k);
quietly recode h5besch (-5 = .l);
quietly recode h5besch (-69/-28 = .);
quietly recode h5besch (-20/-9 = .);
label values h5besch Label_5;
quietly recode h6besch (-70 = .a);
quietly recode h6besch (-27 = .b);
quietly recode h6besch (-26 = .c);
quietly recode h6besch (-25 = .d);
quietly recode h6besch (-24 = .e);
quietly recode h6besch (-23 = .f);
quietly recode h6besch (-22 = .g);
quietly recode h6besch (-21 = .h);
quietly recode h6besch (-8 = .i);
quietly recode h6besch (-7 = .j);
quietly recode h6besch (-6 = .k);
quietly recode h6besch (-5 = .l);
quietly recode h6besch (-69/-28 = .);
quietly recode h6besch (-20/-9 = .);
label values h6besch Label_5;
quietly recode h7besch (-70 = .a);
quietly recode h7besch (-27 = .b);
quietly recode h7besch (-26 = .c);
quietly recode h7besch (-25 = .d);
quietly recode h7besch (-24 = .e);
quietly recode h7besch (-23 = .f);
quietly recode h7besch (-22 = .g);
quietly recode h7besch (-21 = .h);
quietly recode h7besch (-8 = .i);
quietly recode h7besch (-7 = .j);
quietly recode h7besch (-6 = .k);
quietly recode h7besch (-5 = .l);
quietly recode h7besch (-69/-28 = .);
quietly recode h7besch (-20/-9 = .);
label values h7besch Label_5;
quietly recode h8besch (-70 = .a);
quietly recode h8besch (-27 = .b);
quietly recode h8besch (-26 = .c);
quietly recode h8besch (-25 = .d);
quietly recode h8besch (-24 = .e);
quietly recode h8besch (-23 = .f);
quietly recode h8besch (-22 = .g);
quietly recode h8besch (-21 = .h);
quietly recode h8besch (-8 = .i);
quietly recode h8besch (-7 = .j);
quietly recode h8besch (-6 = .k);
quietly recode h8besch (-5 = .l);
quietly recode h8besch (-69/-28 = .);
quietly recode h8besch (-20/-9 = .);
label values h8besch Label_5;
quietly recode h1taet (-70 = .a);
quietly recode h1taet (-27 = .b);
quietly recode h1taet (-26 = .c);
quietly recode h1taet (-25 = .d);
quietly recode h1taet (-24 = .e);
quietly recode h1taet (-23 = .f);
quietly recode h1taet (-22 = .g);
quietly recode h1taet (-21 = .h);
quietly recode h1taet (-9 = .i);
quietly recode h1taet (-8 = .j);
quietly recode h1taet (-69/-28 = .);
quietly recode h1taet (-20/-10 = .);
label values h1taet Label_6;
quietly recode h2taet (-70 = .a);
quietly recode h2taet (-27 = .b);
quietly recode h2taet (-26 = .c);
quietly recode h2taet (-25 = .d);
quietly recode h2taet (-24 = .e);
quietly recode h2taet (-23 = .f);
quietly recode h2taet (-22 = .g);
quietly recode h2taet (-21 = .h);
quietly recode h2taet (-9 = .i);
quietly recode h2taet (-8 = .j);
quietly recode h2taet (-69/-28 = .);
quietly recode h2taet (-20/-10 = .);
label values h2taet Label_6;
quietly recode h3taet (-70 = .a);
quietly recode h3taet (-27 = .b);
quietly recode h3taet (-26 = .c);
quietly recode h3taet (-25 = .d);
quietly recode h3taet (-24 = .e);
quietly recode h3taet (-23 = .f);
quietly recode h3taet (-22 = .g);
quietly recode h3taet (-21 = .h);
quietly recode h3taet (-9 = .i);
quietly recode h3taet (-8 = .j);
quietly recode h3taet (-69/-28 = .);
quietly recode h3taet (-20/-10 = .);
label values h3taet Label_6;
quietly recode h4taet (-70 = .a);
quietly recode h4taet (-27 = .b);
quietly recode h4taet (-26 = .c);
quietly recode h4taet (-25 = .d);
quietly recode h4taet (-24 = .e);
quietly recode h4taet (-23 = .f);
quietly recode h4taet (-22 = .g);
quietly recode h4taet (-21 = .h);
quietly recode h4taet (-9 = .i);
quietly recode h4taet (-8 = .j);
quietly recode h4taet (-69/-28 = .);
quietly recode h4taet (-20/-10 = .);
label values h4taet Label_6;
quietly recode h5taet (-70 = .a);
quietly recode h5taet (-27 = .b);
quietly recode h5taet (-26 = .c);
quietly recode h5taet (-25 = .d);
quietly recode h5taet (-24 = .e);
quietly recode h5taet (-23 = .f);
quietly recode h5taet (-22 = .g);
quietly recode h5taet (-21 = .h);
quietly recode h5taet (-9 = .i);
quietly recode h5taet (-8 = .j);
quietly recode h5taet (-69/-28 = .);
quietly recode h5taet (-20/-10 = .);
label values h5taet Label_6;
quietly recode h6taet (-70 = .a);
quietly recode h6taet (-27 = .b);
quietly recode h6taet (-26 = .c);
quietly recode h6taet (-25 = .d);
quietly recode h6taet (-24 = .e);
quietly recode h6taet (-23 = .f);
quietly recode h6taet (-22 = .g);
quietly recode h6taet (-21 = .h);
quietly recode h6taet (-9 = .i);
quietly recode h6taet (-8 = .j);
quietly recode h6taet (-69/-28 = .);
quietly recode h6taet (-20/-10 = .);
label values h6taet Label_6;
quietly recode h7taet (-70 = .a);
quietly recode h7taet (-27 = .b);
quietly recode h7taet (-26 = .c);
quietly recode h7taet (-25 = .d);
quietly recode h7taet (-24 = .e);
quietly recode h7taet (-23 = .f);
quietly recode h7taet (-22 = .g);
quietly recode h7taet (-21 = .h);
quietly recode h7taet (-9 = .i);
quietly recode h7taet (-8 = .j);
quietly recode h7taet (-69/-28 = .);
quietly recode h7taet (-20/-10 = .);
label values h7taet Label_6;
quietly recode h8taet (-70 = .a);
quietly recode h8taet (-27 = .b);
quietly recode h8taet (-26 = .c);
quietly recode h8taet (-25 = .d);
quietly recode h8taet (-24 = .e);
quietly recode h8taet (-23 = .f);
quietly recode h8taet (-22 = .g);
quietly recode h8taet (-21 = .h);
quietly recode h8taet (-9 = .i);
quietly recode h8taet (-8 = .j);
quietly recode h8taet (-69/-28 = .);
quietly recode h8taet (-20/-10 = .);
label values h8taet Label_6;
quietly recode h1fhs (-70 = .a);
quietly recode h1fhs (-27 = .b);
quietly recode h1fhs (-26 = .c);
quietly recode h1fhs (-25 = .d);
quietly recode h1fhs (-24 = .e);
quietly recode h1fhs (-23 = .f);
quietly recode h1fhs (-22 = .g);
quietly recode h1fhs (-21 = .h);
quietly recode h1fhs (-11 = .i);
quietly recode h1fhs (-10 = .j);
quietly recode h1fhs (-69/-28 = .);
quietly recode h1fhs (-20/-12 = .);
label values h1fhs Label_7;
quietly recode h2fhs (-70 = .a);
quietly recode h2fhs (-27 = .b);
quietly recode h2fhs (-26 = .c);
quietly recode h2fhs (-25 = .d);
quietly recode h2fhs (-24 = .e);
quietly recode h2fhs (-23 = .f);
quietly recode h2fhs (-22 = .g);
quietly recode h2fhs (-21 = .h);
quietly recode h2fhs (-11 = .i);
quietly recode h2fhs (-10 = .j);
quietly recode h2fhs (-69/-28 = .);
quietly recode h2fhs (-20/-12 = .);
label values h2fhs Label_7;
quietly recode h3fhs (-70 = .a);
quietly recode h3fhs (-27 = .b);
quietly recode h3fhs (-26 = .c);
quietly recode h3fhs (-25 = .d);
quietly recode h3fhs (-24 = .e);
quietly recode h3fhs (-23 = .f);
quietly recode h3fhs (-22 = .g);
quietly recode h3fhs (-21 = .h);
quietly recode h3fhs (-11 = .i);
quietly recode h3fhs (-10 = .j);
quietly recode h3fhs (-69/-28 = .);
quietly recode h3fhs (-20/-12 = .);
label values h3fhs Label_7;
quietly recode h4fhs (-70 = .a);
quietly recode h4fhs (-27 = .b);
quietly recode h4fhs (-26 = .c);
quietly recode h4fhs (-25 = .d);
quietly recode h4fhs (-24 = .e);
quietly recode h4fhs (-23 = .f);
quietly recode h4fhs (-22 = .g);
quietly recode h4fhs (-21 = .h);
quietly recode h4fhs (-11 = .i);
quietly recode h4fhs (-10 = .j);
quietly recode h4fhs (-69/-28 = .);
quietly recode h4fhs (-20/-12 = .);
label values h4fhs Label_7;
quietly recode h5fhs (-70 = .a);
quietly recode h5fhs (-27 = .b);
quietly recode h5fhs (-26 = .c);
quietly recode h5fhs (-25 = .d);
quietly recode h5fhs (-24 = .e);
quietly recode h5fhs (-23 = .f);
quietly recode h5fhs (-22 = .g);
quietly recode h5fhs (-21 = .h);
quietly recode h5fhs (-11 = .i);
quietly recode h5fhs (-10 = .j);
quietly recode h5fhs (-69/-28 = .);
quietly recode h5fhs (-20/-12 = .);
label values h5fhs Label_7;
quietly recode h6fhs (-70 = .a);
quietly recode h6fhs (-27 = .b);
quietly recode h6fhs (-26 = .c);
quietly recode h6fhs (-25 = .d);
quietly recode h6fhs (-24 = .e);
quietly recode h6fhs (-23 = .f);
quietly recode h6fhs (-22 = .g);
quietly recode h6fhs (-21 = .h);
quietly recode h6fhs (-11 = .i);
quietly recode h6fhs (-10 = .j);
quietly recode h6fhs (-69/-28 = .);
quietly recode h6fhs (-20/-12 = .);
label values h6fhs Label_7;
quietly recode h7fhs (-70 = .a);
quietly recode h7fhs (-27 = .b);
quietly recode h7fhs (-26 = .c);
quietly recode h7fhs (-25 = .d);
quietly recode h7fhs (-24 = .e);
quietly recode h7fhs (-23 = .f);
quietly recode h7fhs (-22 = .g);
quietly recode h7fhs (-21 = .h);
quietly recode h7fhs (-11 = .i);
quietly recode h7fhs (-10 = .j);
quietly recode h7fhs (-69/-28 = .);
quietly recode h7fhs (-20/-12 = .);
label values h7fhs Label_7;
quietly recode h8fhs (-70 = .a);
quietly recode h8fhs (-27 = .b);
quietly recode h8fhs (-26 = .c);
quietly recode h8fhs (-25 = .d);
quietly recode h8fhs (-24 = .e);
quietly recode h8fhs (-23 = .f);
quietly recode h8fhs (-22 = .g);
quietly recode h8fhs (-21 = .h);
quietly recode h8fhs (-11 = .i);
quietly recode h8fhs (-10 = .j);
quietly recode h8fhs (-69/-28 = .);
quietly recode h8fhs (-20/-12 = .);
label values h8fhs Label_7;
quietly recode h041_1 (-2.0 = .a);
quietly recode h041_1 (-1.0 = .b);
label values h041_1 Label_8;
quietly recode h0412_1 (-2.0 = .b);
quietly recode h0412_1 (-1.0 = .c);
quietly recode h0412_1 (-3.0 = .a);
label values h0412_1 Label_9;
quietly recode h0413_1 (-2.0 = .b);
quietly recode h0413_1 (-1.0 = .c);
quietly recode h0413_1 (-3.0 = .a);
label values h0413_1 Label_9;
quietly recode h044_1 (-2.0 = .b);
quietly recode h044_1 (-1.0 = .c);
quietly recode h044_1 (-3.0 = .a);
label values h044_1 Label_10;
quietly recode h045_1 (-1 = .g);
quietly recode h045_1 (-84 = .a);
quietly recode h045_1 (-83 = .b);
quietly recode h045_1 (-81 = .c);
quietly recode h045_1 (-80 = .d);
quietly recode h045_1 (-3 = .e);
quietly recode h045_1 (-2 = .f);
quietly recode h045_1 (-82/-82 = .);
quietly recode h045_1 (-79/-4 = .);
label values h045_1 Label_11;
quietly recode h046_1 (-2.0 = .b);
quietly recode h046_1 (-1.0 = .c);
quietly recode h046_1 (-3.0 = .a);
label values h046_1 Label_12;
quietly recode h047_1 (-1.0 = .a);
label values h047_1 Label_13;
quietly recode h048_1 (-1.0 = .a);
label values h048_1 Label_14;
quietly recode h049_1 (-1 = .e);
quietly recode h049_1 (-80 = .a);
quietly recode h049_1 (-50 = .b);
quietly recode h049_1 (-3 = .c);
quietly recode h049_1 (-2 = .d);
quietly recode h049_1 (-79/-51 = .);
quietly recode h049_1 (-49/-4 = .);
label values h049_1 Label_15;
label values h0491_1 Label_16;
label values h0492_1 Label_16;
quietly recode h0410_1 (-2.0 = .b);
quietly recode h0410_1 (-1.0 = .c);
quietly recode h0410_1 (-3.0 = .a);
label values h0410_1 Label_9;
quietly recode h0411_11 (-2.0 = .b);
quietly recode h0411_11 (-1.0 = .c);
quietly recode h0411_11 (-3.0 = .a);
label values h0411_11 Label_17;
quietly recode h0411_21 (-2.0 = .b);
quietly recode h0411_21 (-1.0 = .c);
quietly recode h0411_21 (-3.0 = .a);
label values h0411_21 Label_17;
quietly recode h0411_31 (-2.0 = .b);
quietly recode h0411_31 (-1.0 = .c);
quietly recode h0411_31 (-3.0 = .a);
label values h0411_31 Label_17;
quietly recode h0411_41 (-2.0 = .b);
quietly recode h0411_41 (-1.0 = .c);
quietly recode h0411_41 (-3.0 = .a);
label values h0411_41 Label_17;
quietly recode h0414_1 (-2.0 = .b);
quietly recode h0414_1 (-1.0 = .c);
quietly recode h0414_1 (-3.0 = .a);
label values h0414_1 Label_18;
quietly recode h0415_1 (-2.0 = .b);
quietly recode h0415_1 (-1.0 = .c);
quietly recode h0415_1 (-3.0 = .a);
label values h0415_1 Label_19;
quietly recode h041_2 (-2.0 = .a);
quietly recode h041_2 (-1.0 = .b);
label values h041_2 Label_8;
quietly recode h0412_2 (-2.0 = .b);
quietly recode h0412_2 (-1.0 = .c);
quietly recode h0412_2 (-3.0 = .a);
label values h0412_2 Label_9;
quietly recode h0413_2 (-2.0 = .b);
quietly recode h0413_2 (-1.0 = .c);
quietly recode h0413_2 (-3.0 = .a);
label values h0413_2 Label_9;
quietly recode h044_2 (-2.0 = .b);
quietly recode h044_2 (-1.0 = .c);
quietly recode h044_2 (-3.0 = .a);
label values h044_2 Label_10;
quietly recode h045_2 (-1 = .g);
quietly recode h045_2 (-84 = .a);
quietly recode h045_2 (-83 = .b);
quietly recode h045_2 (-81 = .c);
quietly recode h045_2 (-80 = .d);
quietly recode h045_2 (-3 = .e);
quietly recode h045_2 (-2 = .f);
quietly recode h045_2 (-82/-82 = .);
quietly recode h045_2 (-79/-4 = .);
label values h045_2 Label_11;
quietly recode h046_2 (-2.0 = .b);
quietly recode h046_2 (-1.0 = .c);
quietly recode h046_2 (-3.0 = .a);
label values h046_2 Label_12;
quietly recode h047_2 (-2.0 = .b);
quietly recode h047_2 (-1.0 = .c);
quietly recode h047_2 (-3.0 = .a);
label values h047_2 Label_20;
quietly recode h048_2 (-2.0 = .b);
quietly recode h048_2 (-1.0 = .c);
quietly recode h048_2 (-3.0 = .a);
label values h048_2 Label_21;
quietly recode h049_2 (-1 = .e);
quietly recode h049_2 (-80 = .a);
quietly recode h049_2 (-50 = .b);
quietly recode h049_2 (-3 = .c);
quietly recode h049_2 (-2 = .d);
quietly recode h049_2 (-79/-51 = .);
quietly recode h049_2 (-49/-4 = .);
label values h049_2 Label_15;
label values h0491_2 Label_16;
label values h0492_2 Label_16;
quietly recode h0410_2 (-2.0 = .b);
quietly recode h0410_2 (-1.0 = .c);
quietly recode h0410_2 (-3.0 = .a);
label values h0410_2 Label_9;
quietly recode h0411_12 (-2.0 = .b);
quietly recode h0411_12 (-1.0 = .c);
quietly recode h0411_12 (-3.0 = .a);
label values h0411_12 Label_17;
quietly recode h0411_22 (-2.0 = .b);
quietly recode h0411_22 (-1.0 = .c);
quietly recode h0411_22 (-3.0 = .a);
label values h0411_22 Label_17;
quietly recode h0411_32 (-2.0 = .b);
quietly recode h0411_32 (-1.0 = .c);
quietly recode h0411_32 (-3.0 = .a);
label values h0411_32 Label_17;
quietly recode h0411_42 (-2.0 = .b);
quietly recode h0411_42 (-1.0 = .c);
quietly recode h0411_42 (-3.0 = .a);
label values h0411_42 Label_17;
quietly recode h0414_2 (-2.0 = .b);
quietly recode h0414_2 (-1.0 = .c);
quietly recode h0414_2 (-3.0 = .a);
label values h0414_2 Label_18;
quietly recode h0415_2 (-2.0 = .b);
quietly recode h0415_2 (-1.0 = .c);
quietly recode h0415_2 (-3.0 = .a);
label values h0415_2 Label_19;
quietly recode h041_3 (-2.0 = .b);
quietly recode h041_3 (-1.0 = .c);
quietly recode h041_3 (-3.0 = .a);
label values h041_3 Label_22;
quietly recode h0412_3 (-2.0 = .b);
quietly recode h0412_3 (-1.0 = .c);
quietly recode h0412_3 (-3.0 = .a);
label values h0412_3 Label_9;
quietly recode h0413_3 (-2.0 = .b);
quietly recode h0413_3 (-1.0 = .c);
quietly recode h0413_3 (-3.0 = .a);
label values h0413_3 Label_9;
quietly recode h044_3 (-2.0 = .b);
quietly recode h044_3 (-1.0 = .c);
quietly recode h044_3 (-3.0 = .a);
label values h044_3 Label_10;
quietly recode h045_3 (-1 = .g);
quietly recode h045_3 (-84 = .a);
quietly recode h045_3 (-83 = .b);
quietly recode h045_3 (-81 = .c);
quietly recode h045_3 (-80 = .d);
quietly recode h045_3 (-3 = .e);
quietly recode h045_3 (-2 = .f);
quietly recode h045_3 (-82/-82 = .);
quietly recode h045_3 (-79/-4 = .);
label values h045_3 Label_11;
quietly recode h046_3 (-2.0 = .b);
quietly recode h046_3 (-1.0 = .c);
quietly recode h046_3 (-3.0 = .a);
label values h046_3 Label_12;
quietly recode h047_3 (-2.0 = .b);
quietly recode h047_3 (-1.0 = .c);
quietly recode h047_3 (-3.0 = .a);
label values h047_3 Label_20;
quietly recode h048_3 (-2.0 = .b);
quietly recode h048_3 (-1.0 = .c);
quietly recode h048_3 (-3.0 = .a);
label values h048_3 Label_21;
quietly recode h049_3 (-1 = .e);
quietly recode h049_3 (-80 = .a);
quietly recode h049_3 (-50 = .b);
quietly recode h049_3 (-3 = .c);
quietly recode h049_3 (-2 = .d);
quietly recode h049_3 (-79/-51 = .);
quietly recode h049_3 (-49/-4 = .);
label values h049_3 Label_15;
label values h0491_3 Label_16;
label values h0492_3 Label_16;
quietly recode h0410_3 (-2.0 = .b);
quietly recode h0410_3 (-1.0 = .c);
quietly recode h0410_3 (-3.0 = .a);
label values h0410_3 Label_9;
quietly recode h0411_13 (-2.0 = .b);
quietly recode h0411_13 (-1.0 = .c);
quietly recode h0411_13 (-3.0 = .a);
label values h0411_13 Label_17;
quietly recode h0411_23 (-2.0 = .b);
quietly recode h0411_23 (-1.0 = .c);
quietly recode h0411_23 (-3.0 = .a);
label values h0411_23 Label_17;
quietly recode h0411_33 (-2.0 = .b);
quietly recode h0411_33 (-1.0 = .c);
quietly recode h0411_33 (-3.0 = .a);
label values h0411_33 Label_17;
quietly recode h0411_43 (-2.0 = .b);
quietly recode h0411_43 (-1.0 = .c);
quietly recode h0411_43 (-3.0 = .a);
label values h0411_43 Label_17;
quietly recode h0414_3 (-2.0 = .b);
quietly recode h0414_3 (-1.0 = .c);
quietly recode h0414_3 (-3.0 = .a);
label values h0414_3 Label_18;
quietly recode h0415_3 (-2.0 = .b);
quietly recode h0415_3 (-1.0 = .c);
quietly recode h0415_3 (-3.0 = .a);
label values h0415_3 Label_19;
quietly recode h04_1 (-27 = .a);
quietly recode h04_1 (-26 = .b);
quietly recode h04_1 (-25 = .c);
quietly recode h04_1 (-24 = .d);
quietly recode h04_1 (-23 = .e);
quietly recode h04_1 (-22 = .f);
quietly recode h04_1 (-21 = .g);
label values h04_1 Label_3;
quietly recode h04_2 (-27 = .a);
quietly recode h04_2 (-26 = .b);
quietly recode h04_2 (-25 = .c);
quietly recode h04_2 (-24 = .d);
quietly recode h04_2 (-23 = .e);
quietly recode h04_2 (-22 = .f);
quietly recode h04_2 (-21 = .g);
label values h04_2 Label_3;
quietly recode h04_3 (-27 = .a);
quietly recode h04_3 (-26 = .b);
quietly recode h04_3 (-25 = .c);
quietly recode h04_3 (-24 = .d);
quietly recode h04_3 (-23 = .e);
quietly recode h04_3 (-22 = .f);
quietly recode h04_3 (-21 = .g);
label values h04_3 Label_3;
quietly recode h04_4 (-27 = .a);
quietly recode h04_4 (-26 = .b);
quietly recode h04_4 (-25 = .c);
quietly recode h04_4 (-24 = .d);
quietly recode h04_4 (-23 = .e);
quietly recode h04_4 (-22 = .f);
quietly recode h04_4 (-21 = .g);
label values h04_4 Label_3;
quietly recode h04_5 (-27 = .a);
quietly recode h04_5 (-26 = .b);
quietly recode h04_5 (-25 = .c);
quietly recode h04_5 (-24 = .d);
quietly recode h04_5 (-23 = .e);
quietly recode h04_5 (-22 = .f);
quietly recode h04_5 (-21 = .g);
label values h04_5 Label_3;
label values h04_6 Label_23;
label values h05 Label_24;
label values h06_1 Label_25;
label values h06_2 Label_25;
label values h06_3 Label_25;
label values h06_4 Label_25;
label values h06_5 Label_26;
label values h06_7 Label_26;
label values h06_8 Label_26;
quietly recode h07 (-61 = .a);
quietly recode h07 (-60 = .b);
quietly recode h07 (-55 = .c);
quietly recode h07 (-50 = .d);
quietly recode h07 (-59/-56 = .);
quietly recode h07 (-54/-51 = .);
label values h07 Label_27;
quietly recode h071 (-61 = .b);
quietly recode h071 (-60 = .c);
quietly recode h071 (-55 = .d);
quietly recode h071 (-50 = .e);
quietly recode h071 (-66 = .a);
quietly recode h071 (-65/-62 = .);
quietly recode h071 (-59/-56 = .);
quietly recode h071 (-54/-51 = .);
label values h071 Label_28;
quietly recode h071c (-61 = .c);
quietly recode h071c (-60 = .d);
quietly recode h071c (-55 = .e);
quietly recode h071c (-50 = .f);
quietly recode h071c (-68 = .a);
quietly recode h071c (-66 = .b);
quietly recode h071c (-67/-67 = .);
quietly recode h071c (-65/-62 = .);
quietly recode h071c (-59/-56 = .);
quietly recode h071c (-54/-51 = .);
label values h071c Label_29;
quietly recode h0712c (-61 = .e);
quietly recode h0712c (-60 = .f);
quietly recode h0712c (-55 = .g);
quietly recode h0712c (-50 = .h);
quietly recode h0712c (-70 = .a);
quietly recode h0712c (-69 = .b);
quietly recode h0712c (-68 = .c);
quietly recode h0712c (-66 = .d);
quietly recode h0712c (-67/-67 = .);
quietly recode h0712c (-65/-62 = .);
quietly recode h0712c (-59/-56 = .);
quietly recode h0712c (-54/-51 = .);
label values h0712c Label_30;
quietly recode h0713c (-71 = .a);
quietly recode h0713c (-69 = .b);
quietly recode h0713c (-68 = .c);
quietly recode h0713c (-66 = .d);
quietly recode h0713c (-61 = .e);
quietly recode h0713c (-60 = .f);
quietly recode h0713c (-55 = .g);
quietly recode h0713c (-50 = .h);
quietly recode h0713c (-70/-70 = .);
quietly recode h0713c (-67/-67 = .);
quietly recode h0713c (-65/-62 = .);
quietly recode h0713c (-59/-56 = .);
quietly recode h0713c (-54/-51 = .);
label values h0713c Label_31;
quietly recode h072 (-61 = .b);
quietly recode h072 (-60 = .c);
quietly recode h072 (-65 = .a);
quietly recode h072 (-64/-62 = .);
label values h072 Label_32;
quietly recode h072c (-61 = .c);
quietly recode h072c (-60 = .d);
quietly recode h072c (-55 = .e);
quietly recode h072c (-50 = .f);
quietly recode h072c (-68 = .a);
quietly recode h072c (-65 = .b);
quietly recode h072c (-67/-66 = .);
quietly recode h072c (-64/-62 = .);
quietly recode h072c (-59/-56 = .);
quietly recode h072c (-54/-51 = .);
label values h072c Label_33;
quietly recode h0722c (-61 = .e);
quietly recode h0722c (-60 = .f);
quietly recode h0722c (-55 = .g);
quietly recode h0722c (-50 = .h);
quietly recode h0722c (-70 = .a);
quietly recode h0722c (-69 = .b);
quietly recode h0722c (-68 = .c);
quietly recode h0722c (-65 = .d);
quietly recode h0722c (-67/-66 = .);
quietly recode h0722c (-64/-62 = .);
quietly recode h0722c (-59/-56 = .);
quietly recode h0722c (-54/-51 = .);
label values h0722c Label_34;
quietly recode h0723c (-71 = .a);
quietly recode h0723c (-69 = .b);
quietly recode h0723c (-68 = .c);
quietly recode h0723c (-65 = .d);
quietly recode h0723c (-61 = .e);
quietly recode h0723c (-60 = .f);
quietly recode h0723c (-55 = .g);
quietly recode h0723c (-50 = .h);
quietly recode h0723c (-70/-70 = .);
quietly recode h0723c (-67/-66 = .);
quietly recode h0723c (-64/-62 = .);
quietly recode h0723c (-59/-56 = .);
quietly recode h0723c (-54/-51 = .);
label values h0723c Label_35;
quietly recode hheink (-61.0 = .a);
quietly recode hheink (-60.0 = .b);
label values hheink Label_36;
label values wtag Label_37;
label values bland Label_38;
label values westost Label_39;
label values bbr_reg Label_40;
label values bbr_dreg Label_41;
label values bbrkrtyp Label_42;
label values ggkpol Label_43;
label values ggkbik Label_44;
label values erwb1 Label_45;
label values erwb2 Label_45;
label values erwb3 Label_45;
label values erwb4 Label_45;
label values erwb5 Label_45;
label values erwb6 Label_45;
label values erwb7 Label_45;
label values erwb8 Label_45;
label values lebensp Label_46;
label values p_intgr Label_47;
label values stichpro Label_48;
label values befrag Label_49;
label values an_schiene Label_50;
label values typ Label_51;
quietly recode zentrtyp (-99.0 = .a);
label values zentrtyp Label_52;
quietly recode ZTypOrd (-99.0 = .a);
label values ZTypOrd Label_53;
label values hhkinder Label_54;
quietly recode FRAU_65 (-99.0 = .a);
label values FRAU_65 Label_55;
quietly recode MANN_65 (-99.0 = .a);
label values MANN_65 Label_55;
label values ue65un24 Label_56;
label values ZPP750Kl Label_57;
label values ZPP750K2 Label_58;
label values ZPP750K3 Label_59;
label values filter_A_ Label_60;
label values filter1_ Label_60;
label values filter2_ Label_60;
label values filter3_ Label_60;

end;
#delimit cr

exit
