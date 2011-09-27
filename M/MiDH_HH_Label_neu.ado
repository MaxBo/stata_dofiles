*fasse Value-Labels zusammen und codiere SPSS-Missing-Values für Stata um
*written by Max Bohnet am Thu Nov 13 14:12:59 2008
*erzeugt mit Python-Programm Y:\MiD-H\Stata\genLabels2.py
*Eingangsdateien:
* Y:\MiD-H\Stata\HH_Label.txt (in Stata  mit 'label save' erzeugt)
* Y:\MiD-H\Stata\HH_label_Zuordnung.txt (manuell erzeugt)
* Y:\MiD-H\Stata\HH_replace.txt (manuell erzeugt)

program MiDH_HH_Label_neu

quietly {
	label drop _all
	label define befrag .a `"HH/Pers/Wegeinterview schriftlich"', modify
	label define befrag 0 `"HH/Pers/Wegeinterview CATI"', modify
	label define befrag 1 `"HH-Int schriftlich, Pers/Wegeinterview CATI"', modify
	label define stichpro 1 `"CATI"', modify
	label define stichpro 2 `"PEN"', modify
	label define p_intgr 0 `"noch keine"', modify
	label define p_intgr 1 `"bis unter 50 %"', modify
	label define p_intgr 2 `"50 bis unter 100 % "', modify
	label define p_intgr 3 `"100 %"', modify
	label define p_intgr 9 `"k.A. in kh02"', modify
	label define lebensp 1 `"Alleinstehende Rentner"', modify
	label define lebensp 2 `"Rentner Haushalte"', modify
	label define lebensp 3 `"Alleinlebende"', modify
	label define lebensp 4 `"Zusammenlebende"', modify
	label define lebensp 5 `"Erwachsenen Haushalte"', modify
	label define lebensp 6 `"Haushalte mit Schulkindern"', modify
	label define lebensp 7 `"Haushalte mit Kleinkindern"', modify
	label define lebensp 8 `"Alleinerziehende"', modify
	label define lebensp 9 `"Studenten"', modify
	label define lebensp 10 `"Auszubildende, Schüler"', modify
	label define lebensp 11 `"Mehrpersonenhaushalte"', modify
	label define lebensp .z `"Nicht zugeordnet aufgrund fehlender Nennungen"', modify
	label define erwb .z `"KA"', modify
	label define erwb 1 `"Kinder"', modify
	label define erwb 2 `"Schüler"', modify
	label define erwb 3 `"Auszubildende"', modify
	label define erwb 4 `"Student"', modify
	label define erwb 5 `"Wehr-/Zividienstleistender"', modify
	label define erwb 6 `"Freigestellt, Erwerbslos"', modify
	label define erwb 7 `"Hausfrau/-mann"', modify
	label define erwb 8 `"Rentner"', modify
	label define erwb 9 `"Erwerbstätig"', modify
	label define ggkbik 1 `"unter 2002"', modify
	label define ggkbik 2 `"2000 - u. 5000"', modify
	label define ggkbik 3 `"5000 - u. 20000"', modify
	label define ggkbik 4 `"20000 - u. 50000"', modify
	label define ggkbik 5 `"50000 - u. 100000 Rest"', modify
	label define ggkbik 6 `"50000 - u. 100000 Kern"', modify
	label define ggkbik 7 `"100000 - u. 500000 Rest"', modify
	label define ggkbik 8 `"100000 - u. 500000 Kern"', modify
	label define ggkbik 9 `"500000+ Rest"', modify
	label define ggkbik 10 `"500000+ Kern"', modify
	label define ggkpol 1 `"unter 2.000 Einwohner"', modify
	label define ggkpol 2 `"2.000 bis unter 5000 Einwohner"', modify
	label define ggkpol 3 `"5.000 bis unter 20.000 Einwohner"', modify
	label define ggkpol 4 `"20.000 bis unter 50.000 Einwohner"', modify
	label define ggkpol 5 `"50.000 bis unter 100.000 Einwohner"', modify
	label define ggkpol 6 `"100.000 bis unter 500.000 Einwohner"', modify
	label define ggkpol 7 `"500.000 und mehr Einwohner"', modify
	label define bbrkrtyp 1 `"Agglomerationsräume Kernstädte"', modify
	label define bbrkrtyp 2 `"Agglomerationsräume hochverdichtete Kreise"', modify
	label define bbrkrtyp 3 `"Agglomerationsräume verdichtete Kreise"', modify
	label define bbrkrtyp 4 `"Agglomerationsräume ländliche Kreise"', modify
	label define bbrkrtyp 5 `"Verstädterte Räume Kernstädte"', modify
	label define bbrkrtyp 6 `"Verstädterte Räume verdichtete Kreise"', modify
	label define bbrkrtyp 7 `"Verstädterte Räume ländliche Kreise"', modify
	label define bbrkrtyp 8 `"Ländliche Räume ländliche Kreise höherer Dichte"', modify
	label define bbrkrtyp 9 `"Ländliche Räume ländliche Kreise geringerer Dichte"', modify
	label define bbr_dreg 1 `"Hochverdichtete Agglomerationsräume"', modify
	label define bbr_dreg 2 `"Agglomerationsräume mit herausragenden Zentren"', modify
	label define bbr_dreg 3 `"Verstädterte Räume höherer Dichte"', modify
	label define bbr_dreg 4 `"Verstädterte Räume mittlerer Dichte mit Oberzentren"', modify
	label define bbr_dreg 5 `"Verstädterte Räume mittlerer Dichte ohne Oberzentren"', modify
	label define bbr_dreg 6 `"Ländliche Räume höherer Dichte"', modify
	label define bbr_dreg 7 `"Ländliche Räume geringerer Dichte"', modify
	label define bbr_reg 1 `"Agglomerationsräume (Regionstyp 1)"', modify
	label define bbr_reg 2 `"Verstädterte Räume (Regionstyp 2)"', modify
	label define bbr_reg 3 `"Ländliche Räume (Regionstyp 3)"', modify
	label define westost 1 `"West"', modify
	label define westost 2 `"Ost"', modify
	label define bland 1 `"Schleswig-Holstein"', modify
	label define bland 2 `"Hamburg"', modify
	label define bland 3 `"Niedersachsen"', modify
	label define bland 4 `"Bremen"', modify
	label define bland 5 `"Nordrhein-Westfalen"', modify
	label define bland 6 `"Hessen"', modify
	label define bland 7 `"Rheinland-Pfalz"', modify
	label define bland 8 `"Baden-Württemberg"', modify
	label define bland 9 `"Bayern"', modify
	label define bland 10 `"Saarland"', modify
	label define bland 11 `"Berlin"', modify
	label define bland 12 `"Brandenburg"', modify
	label define bland 13 `"Mecklenburg-Vorpommern"', modify
	label define bland 14 `"Sachsen"', modify
	label define bland 15 `"Sachsen-Anhalt"', modify
	label define bland 16 `"Thüringen"', modify
	label define wtag 1 `"Montag"', modify
	label define wtag 2 `"Dienstag"', modify
	label define wtag 3 `"Mittwoch"', modify
	label define wtag 4 `"Donnerstag"', modify
	label define wtag 5 `"Freitag"', modify
	label define wtag 6 `"Samstag"', modify
	label define wtag 7 `"Sonntag"', modify
	label define eink .g `"CATI: Befragte ohne Altersangabe werden nicht befragt"', modify
	label define eink .h `"Person unter 18 Jahre wird nicht befragt"', modify
	label define eink 1 `"bis unter 500 € pro Monat"', modify
	label define eink 2 `"500 € bis unter 900 €"', modify
	label define eink 3 `"900 € bis unter 1.500 €"', modify
	label define eink 4 `"1.500 € bis unter 2.000 €"', modify
	label define eink 5 `"2.000 € bis unter 2.600 €"', modify
	label define eink 6 `"2.600 € bis unter 3.000 €"', modify
	label define eink 7 `"3.000 € bis unter 3.600 €"', modify
	label define eink 8 `"3.600 € und mehr pro Monat"', modify
	label define eink .w `"Doppelnennung"', modify
	label define eink .x `"verweigert"', modify
	label define eink .y `"weiß nicht"', modify
	label define eink .z `"Keine Angabe"', modify
	label define eink .a `"Befragte mit weniger als 2.000 € werden in h0712c befragt"', modify
	label define eink .c `"Befragte verweigert Auskunft zum Einkommen"', modify
	label define eink .d `"Befragte machte Auskunft zum Einkommen"', modify
	label define eink .f `"Befragte macht die Einkommensangaben in DM"', modify
	label define eink .i `"In PAPI nicht erhoben (PAPI)"', modify
	label define eink .j `"In PAPI nicht erhoben (Switcher)"', modify
	label define eink .b `"Befragte mit mehr als 2.000 € werden in h0713c befragt"', modify
	label define einkDM .a `"Befragte mit weniger als 4000 DM werden in h0712c befragt"', modify
	label define einkDM .c `"Befragte verweigert Auskunft zum Einkommen"', modify
	label define einkDM .d `"Befragte machte Auskunft zum Einkommen"', modify
	label define einkDM .e `"Befragte macht die Einkommensangaben in Euro"', modify
	label define einkDM .g `"CATI: Personen ohne Altersangaben werden nicht befragt"', modify
	label define einkDM .h `"CATI: Personen unter 18 Jahre werden nicht befragt"', modify
	label define einkDM .i `"In PAPI nicht erhoben (PAPI)"', modify
	label define einkDM .j `"In PAPI nicht erhoben (Switcher)"', modify
	label define einkDM 5 `"Zwischen 4.000 und 5.000 DM "', modify
	label define einkDM 6 `"Mehr als 5.000 DM           "', modify
	label define einkDM 7 `"Mehr als 6.000 DM           "', modify
	label define einkDM 8 `"Mehr als 7.000 DM           "', modify
	label define einkDM 9 `"Mehr als 7.500 DM pro Monat "', modify
	label define einkDM .x `"Verweigert                  "', modify
	label define einkDM .y `"Weiß nicht"', modify
	label define einkDM .b `"Befragte mit mehr als 4000 DM werden in h0713c befragt"', modify
	label define einkDM 1 `"Weniger als 1.000 DM pro Monat "', modify
	label define einkDM 2 `"Weniger als 1.800 DM   "', modify
	label define einkDM 3 `"Weniger als 3.000 DM   "', modify
	label define einkDM 4 `"Zwischen 3.000 und 4.000 DM "', modify
	label define DMEuro .g `"CATI: Personen ohne Altersangaben werden nicht befragt"', modify
	label define DMEuro .h `"CATI: Personen unter 18 Jahre werden nicht befragt"', modify
	label define DMEuro .i `"In Papi nicht erhoben (PAPI)"', modify
	label define DMEuro .j `"In Papi nicht erhoben (Switcher)"', modify
	label define DMEuro 1 `"DM"', modify
	label define DMEuro 2 `"Euro"', modify
	label define h06_5 .a `"In Papi nicht erhoben (PAPI)"', modify
	label define h06_5 .b `"In Papi nicht erhoben (Switcher)"', modify
	label define h06_5 0 `"Trifft nicht zu"', modify
	label define h06_5 1 `"Trifft zu"', modify
	label define h06_2 0 `"Nicht verfügbar"', modify
	label define h06_2 1 `"Verfügbar"', modify
	label define h06_1 .a `"In CATI nicht erhoben"', modify
	label define h06_1 0 `"Nicht verfügbar"', modify
	label define h06_1 1 `"Verfügbar"', modify
	label define h05 1 `"Eher gehoben"', modify
	label define h05 2 `"Mittlere Wohnlage"', modify
	label define h05 3 `"Eher einfach"', modify
	label define h05 4 `"Keine dieser Wohnanlage"', modify
	label define h05 .w `"Doppelnennung"', modify
	label define h05 .x `"Verweigert"', modify
	label define h05 .y `"Weiß nicht"', modify
	label define h05 .z `"Keine Angabe"', modify
	label define h04_1 .t `"Wert aufgrund fehlender Angaben nicht berechenbar"', modify
	label define h04_1 .x `"Verweigert"', modify
	label define h04_1 .y `"Weiß nicht"', modify
	label define h0415_ .c `"Nur zwei Pkws im HH"', modify
	label define h0415_ .b `"Nur ein Pkw im HH"', modify
	label define h0415_ .a `"Kein Pkw im HH"', modify
	label define h0415_ .x `"Verweigert"', modify
	label define h0415_ .y `"Weiß nicht"', modify
	label define h0415_ .z `"Keine Angabe"', modify
	label define h0414_ .c `"Nur zwei Pkws im HH"', modify
	label define h0414_ .b `"Nur ein Pkw im HH"', modify
	label define h0414_ .a `"Kein Pkw im HH"', modify
	label define h0414_ .x `"Verweigert"', modify
	label define h0414_ .y `"Weiß nicht"', modify
	label define h0414_ .z `"Keine Angabe"', modify
	label define h0411_1 .c `"Nur zwei Pkws im HH"', modify
	label define h0411_1 .b `"Nur ein Pkw im HH"', modify
	label define h0411_1 .a `"Kein Pkw im HH"', modify
	label define h0411_1 0 `"Nein"', modify
	label define h0411_1 1 `"Ja"', modify
	label define h0411_1 .x `"Verweigert"', modify
	label define h0411_1 .y `"Weiß nicht"', modify
	label define h0411_1 .z `"Keine Angabe"', modify
	label define h0491_ .j `"CATI: PS/KW-Wert nicht berechenbar aufgr. fehlender Angaben"', modify
	label define h0491_ .c `"Nur zwei Pkws im HH"', modify
	label define h0491_ .b `"Nur ein Pkw im HH"', modify
	label define h0491_ .a `"Kein Pkw im HH"', modify
	label define h0491_ .x `"Verweigert"', modify
	label define h0491_ .y `"Weiß nicht"', modify
	label define h0491_ .z `"Keine Angabe"', modify
	label define h049_ .e `"In Papi nicht erhoben (PAPI)"', modify
	label define h049_ .d `"In Papi nicht erhoben (Switcher)"', modify
	label define h049_ .c `"Nur zwei Pkws im HH"', modify
	label define h049_ .b `"Nur ein Pkw im HH"', modify
	label define h049_ .a `"Kein Pkw im HH"', modify
	label define h049_ 1 `"PS"', modify
	label define h049_ 2 `"KW"', modify
	label define h049_ .x `"Verweigert"', modify
	label define h049_ .y `"Weiß nicht"', modify
	label define h049_ .z `"Keine Angabe"', modify
	label define h048_ .c `"Nur zwei Pkws im HH"', modify
	label define h048_ .b `"Nur ein Pkw im HH"', modify
	label define h048_ .a `"Kein Pkw im HH"', modify
	label define h048_ 1 `"Benzin"', modify
	label define h048_ 2 `"Diesel"', modify
	label define h048_ 3 `"Anderes"', modify
	label define h048_ .w `"Doppelnennung"', modify
	label define h048_ .x `"Verweigert"', modify
	label define h048_ .y `"Weiß nicht"', modify
	label define h048_ .z `"Keine Angabe"', modify
	label define h047_ .c `"Nur zwei Pkws im HH"', modify
	label define h047_ .b `"Nur ein Pkw im HH"', modify
	label define h047_ .a `"Kein Pkw im HH"', modify
	label define h047_ 1 `"Als Pkw"', modify
	label define h047_ 2 `" Lkw bis 3,5 t"', modify
	label define h047_ 3 `"Lkw ab 3,5 t"', modify
	label define h047_ 4 `"Anderes"', modify
	label define h047_ .x `"Verweigert"', modify
	label define h047_ .y `"Weiß nicht"', modify
	label define h047_ .z `"Keine Angabe"', modify
	label define h046_ .c `"Nur zwei Pkws im HH"', modify
	label define h046_ .b `"Nur ein Pkw im HH"', modify
	label define h046_ .a `"Kein Pkw im HH"', modify
	label define h046_ 1 `"Privat"', modify
	label define h046_ 2 `"Anderer Halter"', modify
	label define h046_ .w `"Doppelnennung"', modify
	label define h046_ .x `"Verweigert"', modify
	label define h046_ .y `"Weiß nicht"', modify
	label define h046_ .z `"Keine Angabe"', modify
	label define h045_ .h `"Hauptnutzer des Pkws nicht zu zuordnen (PAPI)"', modify
	label define h045_ .g `"Hauptnutzer des Pkws nicht zu zuordnen (Switcher)"', modify
	label define h045_ .e `"CATI:Befragte verweigert/weiß nicht zum Hauptnutzer des Pkws"', modify
	label define h045_ .d `"CATI: Fahrer nicht zu zuordnen"', modify
	label define h045_ .c `"Nur zwei Pkws im HH"', modify
	label define h045_ .b `"Nur ein Pkw im HH"', modify
	label define h045_ .a `"Kein Pkw im HH"', modify
	label define h045_ 1 `"Person 1"', modify
	label define h045_ 2 `"Person 2"', modify
	label define h045_ 3 `"Person 3"', modify
	label define h045_ 4 `"Person 4"', modify
	label define h045_ 5 `"Person 5"', modify
	label define h045_ 6 `"Person 6"', modify
	label define h045_ 7 `"Person 7"', modify
	label define h045_ 8 `"Person 8"', modify
	label define h045_ .w `"Doppelnennung"', modify
	label define h045_ .x `"Verweigert"', modify
	label define h045_ .y `"Weiß nicht"', modify
	label define h045_ .z `"Keine Angabe"', modify
	label define h044_ .c `"Nur zwei Pkws im HH"', modify
	label define h044_ .b `"Nur ein Pkw im HH"', modify
	label define h044_ .a `"Kein Pkw im HH"', modify
	label define h044_ 1 `"Ich selbst"', modify
	label define h044_ 2 `"Andere Person"', modify
	label define h044_ .t `"Nicht zu zuordnen"', modify
	label define h044_ .x `"Verweigert"', modify
	label define h044_ .y `"Weiß nicht"', modify
	label define h044_ .z `"Keine Angabe"', modify
	label define h0412_ .c `"Nur zwei Pkws im HH"', modify
	label define h0412_ .b `"Nur ein Pkw im HH"', modify
	label define h0412_ .a `"Kein Pkw im HH"', modify
	label define h0412_ .x `"Verweigert"', modify
	label define h0412_ .y `"Weiß nicht"', modify
	label define h0412_ .z `"Keine Angabe"', modify
	label define h0412_ .u `"Wert unplausibel"', modify
	label define h041_ .c `"Nur zwei Pkws im HH"', modify
	label define h041_ .b `"Nur ein Pkw im HH"', modify
	label define h041_ .a `"Kein Pkw im HH"', modify
	label define h041_ 1 `"Alfa Romeo"', modify
	label define h041_ 2 `"Audi        "', modify
	label define h041_ 3 `"BMW"', modify
	label define h041_ 4 `"Chrysler"', modify
	label define h041_ 5 `"Citroen"', modify
	label define h041_ 6 `"Daewoo"', modify
	label define h041_ 7 `"DAF"', modify
	label define h041_ 8 `"Daihatsu"', modify
	label define h041_ 9 `"Daimler Benz"', modify
	label define h041_ 10 `"Fiat"', modify
	label define h041_ 11 `"Ford"', modify
	label define h041_ 12 `"Hyundai"', modify
	label define h041_ 13 `"Jaguar"', modify
	label define h041_ 14 `"Jeep"', modify
	label define h041_ 15 `"Lada"', modify
	label define h041_ 16 `"Lancia"', modify
	label define h041_ 17 `"Opel"', modify
	label define h041_ 18 `"Peugeot"', modify
	label define h041_ 19 `"Renault"', modify
	label define h041_ 20 `"Saab"', modify
	label define h041_ 21 `"Seat"', modify
	label define h041_ 22 `"Skoda"', modify
	label define h041_ 23 `"Mazda"', modify
	label define h041_ 24 `"Mercedes Benz"', modify
	label define h041_ 25 `"Mitsubishi"', modify
	label define h041_ 26 `"Nissan"', modify
	label define h041_ 27 `"Porsche"', modify
	label define h041_ 28 `"Rover"', modify
	label define h041_ 29 `"Suzuki"', modify
	label define h041_ 30 `"Toyota"', modify
	label define h041_ 31 `"Trabant"', modify
	label define h041_ 32 `"VW"', modify
	label define h041_ 33 `"Volvo"', modify
	label define h041_ 34 `"Wartburg"', modify
	label define h041_ 35 `"Honda"', modify
	label define h041_ 36 `"Kia"', modify
	label define h041_ 37 `"Subaru"', modify
	label define h041_ 38 `"Ferrari"', modify
	label define h041_ 40 `"Anderer Hersteller"', modify
	label define h041_ .x `"Verweigert"', modify
	label define h041_ .y `"Weiß nicht"', modify
	label define h041_ .z `"Keine Angabe"', modify
	label define h048_ 11 `"Benzin"', modify
	label define h047_ .w `"Doppelnennung"', modify
	label define fhs .h `"In Papi nicht erhoben"', modify
	label define fhs .g `"7-Personen Haushalt"', modify
	label define fhs .f `"6-Personen Haushalt"', modify
	label define fhs .e `"5-Personen Haushalt"', modify
	label define fhs .d `"4-Personen Haushalt"', modify
	label define fhs .c `"3-Personen Haushalt"', modify
	label define fhs .b `"2-Personen Haushalt"', modify
	label define fhs .a `"1-Personen Haushalt"', modify
	label define fhs .j `"CATI: Alter Verweigert/Weiss nicht"', modify
	label define fhs .i `"CATI: Befragte unter 18 Jahre"', modify
	label define fhs 1 `"Ja"', modify
	label define fhs 0 `"Nein"', modify
	label define fhs .x `"Verweigert"', modify
	label define fhs .y `"Weiß nicht"', modify
	label define fhs .z `"Keine Angabe"', modify
	label define taet .h `"In Papi nicht erhoben"', modify
	label define taet .g `"7-Personen Haushalt"', modify
	label define taet .f `"6-Personen Haushalt"', modify
	label define taet .e `"5-Personen Haushalt"', modify
	label define taet .d `"4-Personen Haushalt"', modify
	label define taet .c `"3-Personen Haushalt"', modify
	label define taet .b `"2-Personen Haushalt"', modify
	label define taet .a `"1-Personen Haushalt"', modify
	label define taet .j `"Auszubildende/r"', modify
	label define taet .i `"Berufstätig"', modify
	label define taet 1 `"Kind zu Hause betreut"', modify
	label define taet 2 `"Kind betreut Einrichtung"', modify
	label define taet 3 `"(Vor-) Schüler/in"', modify
	label define taet 4 `"Auszubildender"', modify
	label define taet 5 `"Student/in"', modify
	label define taet 6 `"Zur Zeit arbeitslos"', modify
	label define taet 7 `"Vorübergehend freigestellt"', modify
	label define taet 8 `"Hausfrau/-mann"', modify
	label define taet 9 `"Rentner/in"', modify
	label define taet 10 `"Wehr-/Zivildienstleistender"', modify
	label define taet 11 `"Anderes"', modify
	label define taet 12 `"Bin noch berufstätig"', modify
	label define taet .w `"Doppelnennung"', modify
	label define taet .x `"Verweigert"', modify
	label define taet .y `"Weiß nicht"', modify
	label define taet .z `"Keine Angabe"', modify
	label define besch .h `"In Papi nicht erhoben"', modify
	label define besch .g `"7-Personen Haushalt"', modify
	label define besch .f `"6-Personen Haushalt"', modify
	label define besch .e `"5-Personen Haushalt"', modify
	label define besch .d `"4-Personen Haushalt"', modify
	label define besch .c `"3-Personen Haushalt"', modify
	label define besch .b `"2-Personen Haushalt"', modify
	label define besch .a `"1-Personen Haushalt"', modify
	label define besch .l `"CATI: Verweigert/Weiß nicht zur Berufstätigkeit"', modify
	label define besch .k `"CATI: Befragte nicht berufstätig"', modify
	label define besch .j `"CATI: Befragte über  69 Jahre werden nicht befragt"', modify
	label define besch .i `"CATI: Befragte unter 15 Jahre werden nicht befragt"', modify
	label define besch 1 `"Vollzeit"', modify
	label define besch 2 `"Teilzeit"', modify
	label define besch 3 `"Auszubildende/r"', modify
	label define besch 4 `"Nicht berufstätig"', modify
	label define besch .w `"Doppelnennung"', modify
	label define besch .x `"Verweigert"', modify
	label define besch .y `"Weiß nicht"', modify
	label define besch .z `"Keine Angabe"', modify
	label define beruf .h `"In Papi nicht erhoben (PAPI)"', modify
	label define beruf .i `"In Papi nicht erhoben"', modify
	label define beruf .j `"In Papi nicht erhoben (Switcher)"', modify
	label define beruf .g `"7-Personen Haushalt"', modify
	label define beruf .f `"6-Personen Haushalt"', modify
	label define beruf .e `"5-Personen Haushalt"', modify
	label define beruf .d `"4-Personen Haushalt"', modify
	label define beruf .c `"3-Personen Haushalt"', modify
	label define beruf .b `"2-Personen Haushalt"', modify
	label define beruf .a `"1-Personen Haushalt"', modify
	label define beruf .k `"CATI: Befragte über  69 Jahre werden nicht befragt"', modify
	label define beruf .l `"CATI: Befragte unter 15 Jahre werden nicht befragt"', modify
	label define beruf 1 `"Ja"', modify
	label define beruf 0 `"Nein"', modify
	label define beruf .x `"Verweigert"', modify
	label define beruf .y `"Weiß nicht"', modify
	label define beruf .z `"Keine Angabe"', modify
	label define alter .h `"In Papi nicht erhoben"', modify
	label define alter .g `"7-Personen Haushalt"', modify
	label define alter .f `"6-Personen Haushalt"', modify
	label define alter .e `"5-Personen Haushalt"', modify
	label define alter .d `"4-Personen Haushalt"', modify
	label define alter .c `"3-Personen Haushalt"', modify
	label define alter .b `"2-Personen Haushalt"', modify
	label define alter .a `"1-Personen Haushalt"', modify
	label define alter .x `"Verweigert"', modify
	label define alter .y `"Weiß nicht"', modify
	label define alter .z `"Keine Angabe"', modify
	label define sex .h `"In Papi nicht erhoben"', modify
	label define sex .g `"7-Personen Haushalt"', modify
	label define sex .f `"6-Personen Haushalt"', modify
	label define sex .e `"5-Personen Haushalt"', modify
	label define sex .d `"4-Personen Haushalt"', modify
	label define sex .c `"3-Personen Haushalt"', modify
	label define sex .b `"2-Personen Haushalt"', modify
	label define sex .a `"1-Personen Haushalt"', modify
	label define sex 1 `"Frau"', modify
	label define sex 0 `"Mann"', modify
	label define sex .z `"Keine Angabe"', modify
	label define h001c .b `"PAPI wird nicht befragt"', modify
	label define h001c .a `"Switcher werden nicht befragt"', modify
	label define h001c 1 `"Ja, erhalten und gelesen"', modify
	label define h001c 2 `"Ja, erhalten, aber (noch) nicht gelesen"', modify
	label define h001c 3 `"Nein, nicht erhalten"', modify
	label define h01 1 `"Lebe allein"', modify
	label define h01 2 `"Lebe mit anderen Personen im Haushalt"', modify
	label define h01 3 `"Lebe (allein) in einem Wohnheim"', modify
	label define h01 7 `"Verweigert"', modify
	label define h01 9 `"Keine Angabe"', modify

	label values h0713c h0712c h071c h071 einkDM
	recode h0713c h0712c h071c h071 (-60=.h) (-61=.g) (-71=.a) (-70=.b) (-65=.f) (-66=.e) (-68=.d) (-69=.c) (99=.z) (98=.y) (-55=.i) (96=.w) (97=.x) (-50=.j)
	label values h047_1 h047_2 h047_3 h047_
	recode h047_1 h047_2 h047_3 (-50=.d) (-2=.b) (-80=.e) (7=.x) (-1=.a) (-3=.c) (6=.w) (9=.z) (8=.y)
	label values h041_1 h041_2 h041_3 h041_
	recode h041_1 h041_2 h041_3 (99=.z) (98=.y) (-1=.a) (-3=.c) (-2=.b) (94=.u) (97=.x)
	label values h045_1 h045_2 h045_3 h045_
	recode h045_1 h045_2 h045_3 (-84=.h) (-83=.g) (-80=.d) (-81=.e) (99=.z) (98=.y) (-1=.a) (-3=.c) (-2=.b) (97=.x) (96=.w)
	label values h1besch h2besch h3besch h4besch h5besch h6besch h7besch h8besch besch
	recode h1besch h2besch h3besch h4besch h5besch h6besch h7besch h8besch (-70=.h) (-24=.d) (-25=.e) (-26=.f) (-27=.g) (-21=.a) (-22=.b) (-23=.c) (-5=.i) (-7=.k) (-6=.j) (7=.x) (6=.w) (9=.z) (8=.y) (-8=.l)
	label values h0491_1 h0491_2 h0491_3 h0491_
	recode h0491_? h0492_? (9998=.y) (9999=.z) (-10=.j) (-1=.a) (-3=.c) (-2=.b) (9994=.u) (9997=.x)
	label values h1sex h2sex h3sex h4sex h5sex h6sex h7sex h8sex sex
	recode h1sex h2sex h3sex h4sex h5sex h6sex h7sex h8sex (-70=.h) (-24=.d) (-25=.e) (-26=.f) (-27=.g) (-21=.a) (-22=.b) (-23=.c) (1=0) (2=1) (7=.x) (6=.w) (9=.z) (8=.y)
	label values hheink h0723c h0722c h072c h072 eink
	recode hheink h0723c h0722c h072c h072 (-60=.h) (-61=.g) (-71=.a) (-70=.b) (-65=.f) (-66=.e) (-68=.d) (-69=.c) (99=.z) (98=.y) (-55=.i) (96=.w) (97=.x) (-50=.j)
	label values erwb1 erwb2 erwb3 erwb4 erwb5 erwb6 erwb7 erwb8 erwb
	recode erwb1 erwb2 erwb3 erwb4 erwb5 erwb6 erwb7 erwb8 (0=.z) (-9=.a)
	label values h049_1 h049_2 h049_3 h049_
	recode h049_1 h049_2 h049_3 (-50=.d) (-2=.b) (-80=.e) (7=.x) (-1=.a) (-3=.c) (6=.w) (9=.z) (8=.y)
	label values h1beruf h2beruf h3beruf h4beruf h5beruf h6beruf h7beruf h8beruf beruf
	recode h1beruf h2beruf h3beruf h4beruf h5beruf h6beruf h7beruf h8beruf (2=0) (-70=.i) (-50=.j) (-24=.d) (-25=.e) (-26=.f) (-27=.g) (-21=.a) (-80=.h) (-23=.c) (-5=.l) (-6=.k) (-22=.b) (7=.x) (9=.z) (8=.y)
	label values h07 DMEuro
	recode h07 (-60=.h) (-61=.g) (-71=.a) (-70=.b) (-65=.f) (-66=.e) (-68=.d) (-69=.c) (99=.z) (98=.y) (-55=.i) (96=.w) (97=.x) (-50=.j)
	label values h1alter h2alter h3alter h4alter h5alter h6alter h7alter h8alter alter
	recode h1alter h2alter h3alter h4alter h5alter h6alter h7alter h8alter (997=.x) (-70=.h) (-24=.d) (-25=.e) (-26=.f) (-27=.g) (999=.z) (998=.y) (-22=.b) (-23=.c) (-21=.a)
	label values h1taet h2taet h3taet h4taet h5taet h6taet h7taet h8taet taet
	recode h1taet h2taet h3taet h4taet h5taet h6taet h7taet h8taet (-70=.h) (-24=.d) (-25=.e) (-26=.f) (-27=.g) (-21=.a) (-22=.b) (-23=.c) (99=.z) (98=.y) (-9=.j) (-8=.i) (97=.x) (96=.w)
	label values h0411_?? h0411_1
	recode h0411_??  (-3=.c) (-1=.a) (7=.x) (-2=.b) (9=.z) (8=.y)
	label values h044_1 h044_2 h044_3 h044_
	recode h044_1 h044_2 h044_3 (-3=.c) (3=.t) (-1=.a) (7=.x) (-2=.b) (9=.z) (8=.y)
	label values h046_1 h046_2 h046_3 h046_
	recode h046_1 h046_2 h046_3 (-50=.d) (-2=.b) (-80=.e) (7=.x) (-1=.a) (-3=.c) (6=.w) (9=.z) (8=.y)
	label values h0414_1 h0414_2 h0414_3 h0414_
	recode h0414_? h0415_? (9999994=.u) (9999997=.x) (-1=.a) (-3=.c) (-2=.b) (9999999=.z) (9999998=.y)
	label values h0412_1 h0412_2 h0412_3 h0413_1 h0413_2 h0413_3 h0410_? h0412_
	recode h0412_? h0413_? h0410_?  (99999=.z) (99998=.y) (99994=.u) (99997=.x) (-1=.a) (-3=.c) (-2=.b)
	label values h04_1 h04_2 h04_6 h04_1
	recode h04_1 h04_2 h04_6 (-5=.t) (997=.x) (999=.z) (998=.y)
	label values h0415_1 h0415_2 h0415_3 h0415_
	recode h0415_1 h0415_2 h0415_3 (999999=.z) (999998=.y) (-1=.a) (-3=.c) (-2=.b) (999994=.u) (999997=.x)
	label values h048_1 h048_2 h048_3 h048_
	recode h048_1 h048_2 h048_3 (-50=.d) (-2=.b) (-80=.e) (7=.x) (-1=.a) (-3=.c) (6=.w) (9=.z) (8=.y)
	label values h1fhs h2fhs h3fhs h4fhs h5fhs h6fhs h7fhs h8fhs fhs
	recode h1fhs h2fhs h3fhs h4fhs h5fhs h6fhs h7fhs h8fhs (-70=.h) (-24=.d) (-25=.e) (-26=.f) (-27=.g) (-21=.a) (-22=.b) (-23=.c) (-11=.j) (-10=.i) (7=.x) (6=.w) (9=.z) (8=.y) (2=0)

	recode befrag (-1=.a)
	recode lebensp (12=.z)
	recode h06_5 h06_7 h06_8 (-50=.b) (-80=.a)
	recode h06_1 (-70=.a)
	recode h05 (9=.z) (8=.y) (7=.x) (6=.w)
	recode h001c (-20=.a) (-30=.b)
}
end
