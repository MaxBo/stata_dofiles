*fasse Value-Labels zusammen und codiere SPSS-Missing-Values f¸r Stata um
*written by Max Bohnet am Thu Nov 13 14:12:59 2008
*erzeugt mit Python-Programm Y:\MiD-H\Stata\genLabels2.py
*Eingangsdateien:
* Y:\MiD-D\Stata\P_Label.txt (in Stata  mit 'label save' erzeugt)
* Y:\MiD-D\Stata\P_label_Zuordnung.txt (manuell erzeugt)
* Y:\MiD-D\Stata\P_replace.txt (manuell erzeugt)


//use "Y:\MiD-D\Stata\MiD_P.dta", clear
label drop _all
gen long id_hhp=caseid*10+pid
label var id_hhp "Identifikationsnummer Haushalt+Person"
label define FRAGEBOG .a `"schriftliches Interview"', modify
label define FRAGEBOG 1 `"CATI: Erwachs ab 14J; Selbst befragt"', modify
label define FRAGEBOG 2 `"CATI: Erwachs ab 14J; Stellvertreterint."', modify
label define FRAGEBOG 3 `"CATI: Kind 10-13J; Selbst befragt"', modify
label define FRAGEBOG 4 `"CATI: Kind 10-13J; Stellvertreterint."', modify
label define FRAGEBOG 5 `"CATI: Kind 0-9J; Stellvertreterint."', modify
label define mobil .b `"Filterbed.:  Proxy ohne Wegeblatt; keine Wegeerfass."', modify
label define mobil .a `"Filterbed.: Selbst ohne Wegeblatt, 3-Tage-Regel; keine Wegee"', modify
label define mobil 0 `"nicht mobil am Stichtag"', modify
label define mobil 1 `"mobil am Stichtag"', modify
label define mobil .z `"nicht bekannt"', modify
label define kinfo .b `"Schriftlicher Fragebogen f¸r Personen ab 14 Jahre"', modify
label define kinfo .a `"CATI-Interview"', modify
label define kinfo 1 `"von Dir alleine"', modify
label define kinfo 2 `"von Dir zusammen mit Deinen Eltern"', modify
label define kinfo 3 `"nur von den Eltern"', modify
label define kinfo .z `"Keine Angabe"', modify
label define psex 1 `"M‰nnlich"', modify
label define psex 0 `"Weiblich"', modify
label define psex .z `"Keine Angabe"', modify
label define palter .x `"Verweigert"', modify
label define palter .y `"Weiﬂ nicht"', modify
label define palter .z `"Keine Angabe"', modify
label define kminsgk .d `"Person am Stichtag nicht mobil"', modify
label define kminsgk .c `"Wegeinformation k.A. oder verweigert"', modify
label define kminsgk .b `"Filterbed.:  Proxy ohne Wegeblatt; keine Wegeerfass."', modify
label define kminsgk .a `"Filterbed.: Selbst ohne Wegebl., 3-Tage-Regel; keine Wegeerf"', modify
label define kminsgk .u `"aufgrund fehlender Nennungen nicht berechenbar"', modify
label define wegtempo .i `"Person am Stichtag nicht mobil"', modify
label define wegtempo .c `"Wegeinformation k.A. oder verweigert"', modify
label define wegtempo .b `"Filterbed.:  Proxy ohne Wegeblatt; keine Wegeerfass."', modify
label define wegtempo .a `"Filterbed.: Selbst ohne Wegebl., 3-Tage-Regel; keine Wegeerf"', modify
label define wegtempo .u `"Wegetempo unplausibel"', modify
label define wegdauer .i `"Person am Stichtag nicht mobil"', modify
label define wegdauer .c `"Wegeinformation k.A. oder verweigert"', modify
label define wegdauer .b `"Filterbed.:  Proxy ohne Wegeblatt; keine Wegeerfass."', modify
label define wegdauer .a `"Filterbed.: Selbst ohne Wegebl., 3-Tage-Regel; keine Wegeerf"', modify
label define wegdauer .u `"aufgrund fehlender Nennungen nicht berechenbar"', modify
label define wtag 1 `"Montag"', modify
label define wtag 2 `"Dienstag"', modify
label define wtag 3 `"Mittwoch"', modify
label define wtag 4 `"Donnerstag"', modify
label define wtag 5 `"Freitag"', modify
label define wtag 6 `"Samstag"', modify
label define wtag 7 `"Sonntag"', modify
label define weganz .f `"Aufgrund Filterbedingungen Wege nicht berechnet"', modify
label define weganz .x `"Verweigert"', modify
label define weganz .z `"Keine Angabe"', modify
label define w12 .j `"Aufgrund Filterbedingungen Wege nicht berechnet"', modify
label define w12 .f `"PAPI:Keine Angaben in der Wegematrix"', modify
label define w12 .e `"PAPI:Kinder mit weniger als 6 Wegen werden nicht befragt"', modify
label define w12 .d `"PAPI:Erwachsene mit weniger als 7 Wegen werden nicht befragt"', modify
label define w12 .c `"Personen mit weniger als 8 Wegen werden nicht befragt"', modify
label define w12 .a `"Aufgrund Filterbedingungen Wege nicht erfasst"', modify
label define wv05 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv05 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv05 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define wv05 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define wv05 .k `"PAPI: Berufst‰tige ohne Angaben zu den Wegen"', modify
label define wv05 .j `"PAPI: Berufst‰tige ohne regelm‰ﬂige berufliche Wege"', modify
label define wv05 .i `"PAPI: Keine Angabe zu den regelm‰ﬂigen beruflichen Wege"', modify
label define wv05 .h `"PAPI: Nicht berufst‰tig "', modify
label define wv05 .g `"Verweigert/Weiﬂ nicht zu beruflichen Wege"', modify
label define wv05 .f `"Keine Regelm‰ﬂigen beruflichen Wege"', modify
label define wv05 .e `"Nicht berufst‰tig"', modify
label define wv05 .d `"Berufst‰tige macht keine Aussage zu den Wegen am Stichtag"', modify
label define wv05 .c `"Berufst‰tige verweigert Aussage zu den Wegen am Stichtag"', modify
label define wv05 .b `"Berufst‰tige ohne Wege am Stichtag"', modify
label define wv05 .a `"Berufst‰tige am Stichtag ohne Wegerfassung"', modify
label define wv05 1 `"zu Fuﬂ"', modify
label define wv05 2 `"Fahrrad"', modify
label define wv05 3 `"Moped, Mofa"', modify
label define wv05 4 `"Motorrad"', modify
label define wv05 5 `"privater Pkw"', modify
label define wv05 6 `"gewerblicher Pkw"', modify
label define wv05 7 `"LKW bis 3,5 t Nutzlast"', modify
label define wv05 8 `"LKW ¸ber 3,5 t Nutzlast"', modify
label define wv05 9 `"Zugmaschine"', modify
label define wv05 10 `"Kleinbus"', modify
label define wv05 11 `"Bus"', modify
label define wv05 12 `"Bahn"', modify
label define wv05 13 `"Flugzeug"', modify
label define wv05 14 `"anderes Verkehrsmittel"', modify
label define wv05 .x `"Verweigert"', modify
label define wv05 .y `"Weiﬂ nicht"', modify
label define wv05 .z `"Keine Angabe"', modify
label define wv04 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv04 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv04 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define wv04 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define wv04 .k `"PAPI: Berufst‰tige ohne Angaben zu den Wegen"', modify
label define wv04 .j `"PAPI: Berufst‰tige ohne regelm‰ﬂige berufliche Wege"', modify
label define wv04 .i `"PAPI: Keine Angabe zu den regelm‰ﬂigen beruflichen Wege"', modify
label define wv04 .h `"PAPI: Nicht berufst‰tig "', modify
label define wv04 .g `"Verweigert/Weiﬂ nicht zu beruflichen Wege"', modify
label define wv04 .f `"Keine Regelm‰ﬂigen beruflichen Wege"', modify
label define wv04 .e `"Nicht berufst‰tig"', modify
label define wv04 .d `"Berufst‰tige macht keine Aussage zu den Wegen am Stichtag"', modify
label define wv04 .c `"Berufst‰tige verweigert Aussage zu den Wegen am Stichtag"', modify
label define wv04 .b `"Berufst‰tige ohne Wege am Stichtag"', modify
label define wv04 .a `"Berufst‰tige am Stichtag ohne Wegerfassung"', modify
label define wv04 .x `"Verweigert"', modify
label define wv04 .y `"Weiﬂ nicht"', modify
label define wv04 .z `"Keine Angabe"', modify
label define wv03 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv03 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv03 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define wv03 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define wv03 .k `"PAPI: Berufst‰tige ohne Angaben zu den Wegen"', modify
label define wv03 .j `"PAPI: Berufst‰tige ohne regelm‰ﬂige berufliche Wege"', modify
label define wv03 .i `"PAPI: Keine Angabe zu den regelm‰ﬂigen beruflichen Wege"', modify
label define wv03 .h `"PAPI: Nicht berufst‰tig "', modify
label define wv03 .g `"Verweigert/Weiﬂ nicht zu beruflichen Wege"', modify
label define wv03 .f `"Keine Regelm‰ﬂigen beruflichen Wege"', modify
label define wv03 .e `"Nicht berufst‰tig"', modify
label define wv03 .d `"Berufst‰tige macht keine Aussage zu den Wegen am Stichtag"', modify
label define wv03 .c `"Berufst‰tige verweigert Aussage zu den Wegen am Stichtag"', modify
label define wv03 .b `"Berufst‰tige ohne Wege am Stichtag"', modify
label define wv03 .a `"Berufst‰tige am Stichtag ohne Wegerfassung"', modify
label define wv03 .x `"Verweigert"', modify
label define wv03 .y `"Weiﬂ nicht"', modify
label define wv03 .z `"Keine Angabe"', modify
label define wv02 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv02 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv02 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define wv02 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define wv02 .k `"PAPI: Berufst‰tige ohne Angaben zu den Wegen"', modify
label define wv02 .j `"PAPI: Berufst‰tige ohne regelm‰ﬂige berufliche Wege"', modify
label define wv02 .i `"PAPI: Keine Angabe zu den regelm‰ﬂigen beruflichen Wege"', modify
label define wv02 .h `"PAPI: Nicht berufst‰tig "', modify
label define wv02 .g `"Verweigert/Weiﬂ nicht zu beruflichen Wege"', modify
label define wv02 .f `"Keine Regelm‰ﬂigen beruflichen Wege"', modify
label define wv02 .e `"Nicht berufst‰tig"', modify
label define wv02 .d `"Berufst‰tige macht keine Aussage zu den Wegen am Stichtag"', modify
label define wv02 .c `"Berufst‰tige verweigert Aussage zu den Wegen am Stichtag"', modify
label define wv02 .b `"Berufst‰tige ohne Wege am Stichtag"', modify
label define wv02 .a `"Berufst‰tige am Stichtag ohne Wegerfassung"', modify
label define wv02 1 `"Besuch / Besichtigung / Besprechung"', modify
label define wv02 2 `"Kundendienst / Erledigung"', modify
label define wv02 3 `"Sozialdienst / Betreuung"', modify
label define wv02 4 `"Transport / Abholung / Zustellung von Waren"', modify
label define wv02 5 `"Personenbefˆrderung"', modify
label define wv02 6 `"anderer Zweck"', modify
label define wv02 .x `"Verweigert"', modify
label define wv02 .y `"Weiﬂ nicht"', modify
label define wv02 11 `"PAPI: Holen, Bringen, Transportieren von G¸tern"', modify
label define wv02 12 `"PAPI: Fahrt zur Erbringung beruflicher Leistungen"', modify
label define wv02 13 `"PAPI: Holen, Bringen, Befˆrdern von Personen"', modify
label define wv02 14 `"PAPI: Sonstige dienstli. oder gesch‰ftli. Erledigungen"', modify
label define wv02 .z `"PAPI: Keine Angabe"', modify
label define wv01 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv01 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv01 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define wv01 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define wv01 .k `"PAPI: Berufst‰tige ohne Angaben zu den Wegen"', modify
label define wv01 .j `"PAPI: Berufst‰tige ohne regelm‰ﬂige berufliche Wege"', modify
label define wv01 .i `"PAPI: Keine Angabe zu den regelm‰ﬂigen beruflichen Wege"', modify
label define wv01 .h `"PAPI: Nicht berufst‰tig "', modify
label define wv01 .g `"Verweigert/Weiﬂ nicht zu beruflichen Wege"', modify
label define wv01 .f `"Keine Regelm‰ﬂigen beruflichen Wege"', modify
label define wv01 .e `"Nicht berufst‰tig"', modify
label define wv01 .d `"Berufst‰tige macht keine Aussage zu den Wegen am Stichtag"', modify
label define wv01 .c `"Berufst‰tige verweigert Aussage zu den Wegen am Stichtag"', modify
label define wv01 .b `"Berufst‰tige ohne Wege am Stichtag"', modify
label define wv01 .a `"Berufst‰tige am Stichtag ohne Wegerfassung"', modify
label define wv01 1 `"Land- und Forstwirtschaft"', modify
label define wv01 2 `"Fischerei und Fischzucht"', modify
label define wv01 3 `"Bergbau"', modify
label define wv01 4 `"verarbeitendes Gewerbe"', modify
label define wv01 5 `"Energie- und Wasserversorgung"', modify
label define wv01 6 `"Baugewerbe"', modify
label define wv01 7 `"Handel"', modify
label define wv01 8 `"Gastgewerbe"', modify
label define wv01 9 `"Verkehr und Nachrichten¸bermittlung"', modify
label define wv01 10 `"Kredit- und Versicherungsgewerbe"', modify
label define wv01 11 `"Dienstleistung"', modify
label define wv01 12 `"ˆffentliche Verwaltung"', modify
label define wv01 13 `"Erziehung und Unterricht"', modify
label define wv01 14 `"Gesundheits-, Veterin‰r- und Sozialwesen"', modify
label define wv01 15 `"sonstige Dienstleistungen"', modify
label define wv01 16 `"exterritoriale Organisationen"', modify
label define wv01 17 `"andere Branche"', modify
label define wv01 .x `"verweigert"', modify
label define wv01 .y `"weiﬂ nicht"', modify
label define wv01 .z `"Keine Angabe"', modify
label define wv0 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv0 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define wv0 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define wv0 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define wv0 .k `"PAPI: Berufst‰tige ohne Angaben zu den Wegen"', modify
label define wv0 .h `"PAPI: Nicht berufst‰tig "', modify
label define wv0 .g `"Verweigert/Weiﬂ nicht zu beruflichen Wege"', modify
label define wv0 .f `"Keine Regelm‰ﬂigen beruflichen Wege"', modify
label define wv0 .e `"Nicht berufst‰tig"', modify
label define wv0 .d `"Berufst‰tige macht keine Aussage zu den Wegen am Stichtag"', modify
label define wv0 .c `"Berufst‰tige verweigert Aussage zu den Wegen am Stichtag"', modify
label define wv0 .b `"Berufst‰tige ohne Wege am Stichtag"', modify
label define wv0 .a `"Berufst‰tige am Stichtag ohne Wegerfassung"', modify
label define wv0 1 `"Ja"', modify
label define wv0 0 `"Nein"', modify
label define wv0 .x `"Verweigert"', modify
label define wv0 .z `"Keine Angabe"', modify
label define normal .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define normal .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define normal .c `"Verweigert/Weiﬂ nicht zum Verlauf des Stichtags"', modify
label define normal .b `"Personen verlebten einen normalen Stichtag"', modify
label define normal .a `"Aufgrund Filterbedingungen werden Wege nicht erhoben"', modify
label define normal 0 `"Trifft nicht zu"', modify
label define normal 1 `"Trifft zu"', modify
label define normal .r `"In CATI nicht erhoben"', modify
label define normal .e `"PAPI: Keine Angabe zum Verlauf des Wochentags"', modify
label define normal .d `"PAPI: Person verlebte einen normalen Wochentag"', modify
label define normal .z `"Keine Angabe"', modify
label define s01 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define s01 .a `"Aufgrund Filterbedingungen werden Wege nicht erhoben"', modify
label define s01 1 `"Ja, war ein normaler Wochentag"', modify
label define s01 2 `"Nein, war kein normaler Wochentag"', modify
label define s01 .x `"Verweigert"', modify
label define s01 .y `"Weiﬂ nicht"', modify
label define s01 .z `"Keine Angabe"', modify
label define s05 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define s05 .f `"Personen waren nicht auﬂer Haus"', modify
label define s05 .d `"Personen waren im Ausland"', modify
label define s05 .a `"Aufgrund Filterbedingungen werden Wege nicht erhoben"', modify
label define s05 1 `"Ja"', modify
label define s05 2 `"Nein"', modify
label define s05 .x `"Verweigert"', modify
label define s05 .y `"Weiﬂ nicht"', modify
label define s05 .z `"Keine Angabe"', modify
label define s04 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define s04 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define s04 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define s04 .a `"Personen ohne Altersangaben werden nicht befragt"', modify
label define s04 1 `"Ja, st‰ndig"', modify
label define s04 2 `"Ja, teilweise"', modify
label define s04 3 `"Nein, gar nicht"', modify
label define s04 .x `"Verweigert"', modify
label define s04 .y `"Weiﬂ nicht"', modify
label define s04 .z `"Keine Angabe"', modify
label define s03 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define s03 1 `"Sonnig"', modify
label define s03 2 `"Leicht bewˆlkt"', modify
label define s03 3 `"Stark bewˆlkt"', modify
label define s03 4 `"Regnerisch"', modify
label define s03 5 `"Schnee"', modify
label define s03 .x `"Verweigert"', modify
label define s03 .y `"Weiﬂ nicht"', modify
label define s03 .z `"Keine Angabe"', modify
label define p08 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p08 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p08 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p08 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p08 1 `"Seit weniger als einem Jahr"', modify
label define p08 2 `"Seit einem bis unter zwei Jahren"', modify
label define p08 3 `"Seit mehr als zwei Jahren"', modify
label define p08 4 `"Seit f¸nf Jahren oder l‰nger"', modify
label define p08 .x `"Verweigert"', modify
label define p08 .y `"Weiﬂ nicht"', modify
label define p08 .z `"Keine Angabe"', modify
label define p09 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p09 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p09 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p09 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p09 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p09 .o `"CARTI: Personen ohne Behinderung werden nicht befragt"', modify
label define p09 1 `"Ja"', modify
label define p09 0 `"Nein"', modify
label define p09 .x `"Verweigert"', modify
label define p09 .y `"Weiﬂ nicht"', modify
label define behindert .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define behindert .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define behindert .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define behindert 0 `"Trifft nicht zu"', modify
label define behindert 1 `"Trifft zu"', modify
label define behindert .z `"Keine Angabe"', modify
label define p18s .q `"In CATI nicht erhoben"', modify
label define p18s .p `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p18s 1 `"war noch nie berufst‰tig"', modify
label define p18s 2 `"Arbeiter(in)"', modify
label define p18s 3 `"Angestellte(r) mit einfacher T‰tigkeit"', modify
label define p18s 4 `"Angestellte(r) mit qualifizierter T‰tigkeit"', modify
label define p18s 5 `"Angestellte(r) mit Leitungsaufgaben"', modify
label define p18s 6 `"Beamter(in) im einfachen Dienst"', modify
label define p18s 7 `"Beamter(in) im mittleren Dienst"', modify
label define p18s 8 `"Beamter(in) im gehobenen/hˆheren Dienst"', modify
label define p18s 9 `"akademischer freier Beruf"', modify
label define p18s 10 `"selbst‰ndig im Handel"', modify
label define p18s 11 `"selbst‰ndiger Landwirt"', modify
label define p18s 12 `"mithelfender Familienangehˆriger"', modify
label define p18s 13 `"Sonstiges"', modify
label define p18s .x `"Verweigert"', modify
label define p18s .y `"Weiﬂ nicht"', modify
label define p18s .z `"Keine Angabe"', modify
label define p17s -175 `"In CATI nicht erhoben"', modify
label define p17s .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p17s 1 `"Vollzeit erwerbst‰tig"', modify
label define p17s 2 `"Teilzeit erwerbst‰tig"', modify
label define p17s 3 `"Geringf¸gig erwerbst‰tig"', modify
label define p17s 4 `"Auszubildende/r"', modify
label define p17s 5 `"Sch¸ler(in), weiterf¸hrende Schule"', modify
label define p17s 6 `"Sch¸ler(in), sonstige Schule"', modify
label define p17s 7 `"Student(in)"', modify
label define p17s 8 `"zurzeit Arbeitslos"', modify
label define p17s 9 `"Vor¸bergehend freigestellt"', modify
label define p17s 10 `"Hausfrau/-mann"', modify
label define p17s 11 `"Rentner/in"', modify
label define p17s 12 `"Wehr-/Zivildienstleistender"', modify
label define p17s 13 `"Anderes"', modify
label define p17s .z `"Keine Angabe"', modify
label define p18 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p18 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p18 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p18 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p18 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p18 1 `"Arbeiter(in)"', modify
label define p18 2 `"Angestellte(r) mit einfacher T‰tigkeit"', modify
label define p18 3 `"Angestellte(r) mit qualifizierter T‰tigkeit"', modify
label define p18 4 `"Angestellte(r) mit Leitungsaufgaben"', modify
label define p18 5 `"Beamter(in) im einfachen Dienst"', modify
label define p18 6 `"Beamter(in) im mittleren Dienst"', modify
label define p18 7 `"Beamter(in) im gehobenen/hˆheren Dienst"', modify
label define p18 8 `"akademischer freier Beruf"', modify
label define p18 9 `"selbst‰ndig im Handel"', modify
label define p18 10 `"selbst‰ndiger Landwirt"', modify
label define p18 11 `"mithelfender Familienangehˆriger"', modify
label define p18 12 `"Sonstiges"', modify
label define p18 13 `"war noch nie berufst‰tig"', modify
label define p18 .x `"Verweigert"', modify
label define p18 .y `"Weiﬂ nicht"', modify
label define p18 .z `"Keine Angabe"', modify
label define p17 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p17 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p17 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p17 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p17 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p17 .d `"Personen in der Ausbildung werden nicht befragt"', modify
label define p17 .c `"Personen mit einer Berufst‰tigkeit werden nicht befragt"', modify
label define p17 1 `"Auszubildender"', modify
label define p17 2 `"Sch¸ler in einer Grundschule"', modify
label define p17 3 `"Sch¸ler(in) weiterf¸hrenden Schule"', modify
label define p17 4 `"Student(in)"', modify
label define p17 5 `"zur Zeit arbeitslos"', modify
label define p17 6 `"vor¸bergehend freigestellt"', modify
label define p17 7 `"Hausfrau / Hausmann"', modify
label define p17 8 `"Rentner(in), Pension‰r(in)"', modify
label define p17 9 `"Wehr- oder Zivildienstleistender"', modify
label define p17 10 `"Sonstiges"', modify
label define p17 .x `"Verweigert"', modify
label define p17 .y `"Weiﬂ nicht"', modify
label define p17 .z `"Keine Angabe"', modify
label define p16 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p16 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p16 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p16 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p16 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p16 .b `"Verweigert/Weiﬂ nicht zur Berufst‰tigkeit"', modify
label define p16 .a `"Personen ohne Berufst‰tigkeit"', modify
label define p16 1 `"Vollzeit erwerbst‰tig"', modify
label define p16 2 `"Teilzeit erwerbst‰tig"', modify
label define p16 3 `"geringf¸gig erwerbst‰tig"', modify
label define p16 4 `"Auszubildende(r)"', modify
label define p16 .x `"Verweigert"', modify
label define p16 .y `"Weiﬂ nicht"', modify
label define p15 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p15 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p15 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p15 .p `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p15 .o `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p15 1 `"Ja"', modify
label define p15 0 `"Nein"', modify
label define p15 .x `"Verweigert"', modify
label define p15 .y `"Weiﬂ nicht"', modify
label define p14 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p14 1 `"Schule ohne Abschluss verlassen"', modify
label define p14 2 `"Volks- oder Hauptschule/POS 8. Klasse"', modify
label define p14 3 `"Mittlere Reife, Realschulabschluss/POS 10. Klasse"', modify
label define p14 4 `"Fachhochschulreife, Berufsausbildung mit Abitur"', modify
label define p14 5 `"Hochschulreife"', modify
label define p14 6 `"anderer Abschluss"', modify
label define p14 7 `"ich bin noch Sch¸ler(in)"', modify
label define p14 8 `"Besuche zur Zeit: Krippe/Kita/Kindergarten"', modify
label define p14 9 `"Besuche zur Zeit: Vorschule/Grundschule"', modify
label define p14 10 `"Besuche zur Zeit: Hauptschule"', modify
label define p14 11 `"Besuche zur Zeit: Realschule"', modify
label define p14 12 `"Besuche zur Zeit: Gymnasium"', modify
label define p14 13 `"Besuche zur Zeit: Gesamtschule"', modify
label define p14 14 `"eine andere Schule/Einrichtung"', modify
label define p14 15 `"Kind besucht keine Einrichtung"', modify
label define p14 .x `"Verweigert"', modify
label define p14 .y `"Weiﬂ nicht"', modify
label define p14 .z `"Keine Angabe"', modify
label define p061_4j .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_4j .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_4j .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_4j .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_4j .n `"PAPI: Keine Angabe zum Besitz eines Lkw-FHS"', modify
label define p061_4j .m `"PAPI: Kein Lkw-FHS"', modify
label define p061_4j .l `"Personen unter 18 Jahre werden nicht zum Lkw-FHS befragt"', modify
label define p061_4j .k `"Verweigert/weiﬂ nicht zum Besitz eines Pkw-FHS"', modify
label define p061_4j .j `"Personen ohne einen Pkw-FHS werden nicht befragt"', modify
label define p061_4j .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_4j .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_4j .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_4j .u `"Wert unplausibel"', modify
label define p061_4j .x `"Verweigert"', modify
label define p061_4j .y `"Weiﬂ nicht"', modify
label define p061_4j .z `"Keine Angabe"', modify
label define p061_3j .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_3j .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_3j .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_3j .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_3j .n `"PAPI: Keine Angabe zum Besitz eines Pkw-FHS"', modify
label define p061_3j .m `"PAPI: Kein Pkw-FHS"', modify
label define p061_3j .j `"Verweigert/weiﬂ nicht zum Besitz eines Pkw-FHS"', modify
label define p061_3j .i `"Personen ohne einen Pkw-FHS werden nicht befragt"', modify
label define p061_3j .h `"Personen unter 16 Jahre werden nicht zum Pkw-FHS befragt"', modify
label define p061_3j .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_3j .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_3j .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_3j .u `"Wert unplausibel"', modify
label define p061_3j .x `"Verweigert"', modify
label define p061_3j .y `"Weiﬂ nicht"', modify
label define p061_3j .z `"Keine Angabe"', modify
label define p061_2j .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_2j .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_2j .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_2j .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_2j .n `"PAPI: Keine Angabe zum Besitz eines Motorrad-FHS"', modify
label define p061_2j .m `"PAPI: Kein Motorrad-FHS"', modify
label define p061_2j .h `"Personen unter 16 Jahre werden nicht zum MotorradFHS befragt"', modify
label define p061_2j .g `"Verweigert/weiﬂ nicht zum Besitz eines Motorrad-FHS"', modify
label define p061_2j .f `"Personen ohne einen Motorrad-FHS werden nicht befragt"', modify
label define p061_2j .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_2j .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_2j .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_2j .u `"Wert unplausibel"', modify
label define p061_2j .x `"Verweigert"', modify
label define p061_2j .y `"Weiﬂ nicht"', modify
label define p061_2j .z `"Keine Angabe"', modify
label define p061_1j .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_1j .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_1j .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_1j .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_1j .n `"PAPI: Keine Angabe zum Besitz eines Mofa-FHS"', modify
label define p061_1j .m `"PAPI: Kein Mofa-FHS"', modify
label define p061_1j .e `"Verweigert/weiﬂ nicht zum Besitz eines Mofa-FHS"', modify
label define p061_1j .d `"Personen ohne einen Mofa-FHS werden nicht befragt"', modify
label define p061_1j .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_1j .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_1j .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_1j .u `"Wert unplausibel"', modify
label define p061_1j .x `"Verweigert"', modify
label define p061_1j .y `"Weiﬂ nicht"', modify
label define p061_1j .z `"Keine Angabe"', modify
label define p061_4 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_4 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_4 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_4 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_4 .l `"Personen unter 18 Jahre werden nicht zum Lkw-FHS befragt"', modify
label define p061_4 .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_4 .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_4 .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_4 1 `"Ja"', modify
label define p061_4 0 `"Nein"', modify
label define p061_4 .x `"Verweigert"', modify
label define p061_4 .y `"Weiﬂ nicht"', modify
label define p061_4 .z `"Keine Angabe"', modify
label define p061_3 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_3 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_3 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_3 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_3 .h `"Personen unter 16 Jahre werden nicht zum Pkw-FHS befragt"', modify
label define p061_3 .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_3 .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_3 .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_3 1 `"Ja"', modify
label define p061_3 0 `"Nein"', modify
label define p061_3 .x `"Verweigert"', modify
label define p061_3 .y `"Weiﬂ nicht"', modify
label define p061_3 .z `"Keine Angabe"', modify
label define p061_2 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_2 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_2 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_2 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_2 .h `"Personen unter 16 Jahre werden nicht zum MotorradFHS befragt"', modify
label define p061_2 .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_2 .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_2 .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_2 1 `"Ja"', modify
label define p061_2 0 `"Nein"', modify
label define p061_2 .x `"Verweigert"', modify
label define p061_2 .y `"Weiﬂ nicht"', modify
label define p061_2 .z `"Keine Angabe"', modify
label define p061_1 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_1 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p061_1 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p061_1 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p061_1 .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p061_1 .b `"Verweigert/Weiﬂ nicht zum Besitz eines FHS"', modify
label define p061_1 .a `"Personen ohne F¸hrerschein werden nicht befragt"', modify
label define p061_1 1 `"Ja"', modify
label define p061_1 0 `"Nein"', modify
label define p061_1 .x `"Verweigert"', modify
label define p061_1 .y `"Weiﬂ nicht"', modify
label define p061_1 .z `"Keine Angabe"', modify
label define p06 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p06 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p06 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p06 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p06 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p06 .c `"Personen unter 15 Jahre werden nicht zum Besitz FHS befragt"', modify
label define p06 1 `"Ja"', modify
label define p06 0 `"Nein"', modify
label define p06 .x `"Verweigert"', modify
label define p06 .y `"Weiﬂ nicht"', modify
label define p13 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p13 .x `"Verweigert"', modify
label define p13 .y `"Weiﬂ nicht"', modify
label define p13 .z `"Keine Angabe"', modify
label define staatsan .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define staatsan .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define staatsan .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define staatsan .p `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define staatsan 0 `"Trifft nicht zu"', modify
label define staatsan 1 `"Trifft zu"', modify
label define staatsan .z `"Keine Angabe"', modify
label define p11 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p11 1 `"M‰nnlich"', modify
label define p11 2 `"Weiblich"', modify
label define p11 .z `"Keine Angabe"', modify
label define reisen .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define reisen .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define reisen .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define reisen .p `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define reisen .d `"PAPI: Keine Angabe zur Anzahl der Reisen"', modify
label define reisen .c `"PAPI: Keine Reisen unternommen"', modify
label define reisen .b `"Verweigert/Weiﬂ nicht zur Anzahl der Reisen"', modify
label define reisen .a `"Personen ohne Reisen werden nicht befragt"', modify
label define reisen .u `"Wert unplausibel"', modify
label define reisen .z `"Keine Angabe"', modify
label define p10 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p10 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p10 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p10 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p10 .u `"Wert unplausibel"', modify
label define p10 .x `"Verweigert"', modify
label define p10 .y `"Weiﬂ nicht"', modify
label define p10 .z `"Keine Angabe"', modify
label define p10as .q `"In CATI nicht erhoben"', modify
label define p10as .p `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p10as 1 `"Ja"', modify
label define p10as 2 `"Nein"', modify
label define p10as .z `"Keine Angabe"', modify
label define p07 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p07 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p07 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p07 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p07 1 `"Einzelfahrschein, Tageskarte"', modify
label define p07 2 `"Mehrfachkarte, Streifenkarte"', modify
label define p07 3 `"Wochenkarte, Monatskarte"', modify
label define p07 4 `"Monatskarte im Abo, Jahreskarte"', modify
label define p07 5 `"Jobticket, Semesterticket"', modify
label define p07 6 `"Anderes"', modify
label define p07 9 `"Fahre nie ÷PNV"', modify
label define p07 .w `"schriftlich: unzul‰ssige Mehrfachnennung"', modify
label define p07 .x `"Verweigert"', modify
label define p07 .y `"Weiﬂ nicht"', modify
label define p07 .z `"Keine Angabe"', modify
label define erreich .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define erreich .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define erreich .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define erreich .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define erreich 1 `"Sehr gut"', modify
label define erreich 2 `"Gut"', modify
label define erreich 3 `"Einigermaﬂen"', modify
label define erreich 4 `"Schlecht"', modify
label define erreich 5 `"Sehr schlecht"', modify
label define erreich .w `"schriftlich: unzul‰ssige Mehrfachnennung"', modify
label define erreich .x `"Verweigert"', modify
label define erreich .y `"Weiﬂ nicht"', modify
label define erreich .z `"Keine Angabe"', modify
label define p054 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p054 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p054 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p054 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p054 1 `"unter 100 Meter"', modify
label define p054 2 `"100 bis unter 200 Meter"', modify
label define p054 3 `"200 bis unter 400 Meter"', modify
label define p054 4 `"400 Metern bis unter einem Kilometer"', modify
label define p054 5 `"ein bis unter 2 Kilometer"', modify
label define p054 6 `"2 bis unter 5 Kilometer"', modify
label define p054 7 `"5 bis unter  10 Kilometer"', modify
label define p054 8 `"weiter als 10 Kilometer"', modify
label define p054 .w `"Wie Bushaltestelle"', modify
label define p054 .x `"Verweigert"', modify
label define p054 .y `"Weiﬂ nicht"', modify
label define p054 .z `"Keine Angabe"', modify
label define p053 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p053 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p053 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p053 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p053 .w `"Wie Bushaltestelle"', modify
label define p053 .x `"Verweigert"', modify
label define p053 .y `"Weiﬂ nicht"', modify
label define p053 .z `"Keine Angabe"', modify
label define p052 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p052 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p052 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p052 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p052 1 `"unter 100 Meter"', modify
label define p052 2 `"100 bis unter 200 Meter"', modify
label define p052 3 `"200 bis unter 400 Meter"', modify
label define p052 4 `"400 Metern bis unter einem Kilometer"', modify
label define p052 5 `"ein bis unter 2 Kilometer"', modify
label define p052 6 `"2 bis unter 5 Kilometer"', modify
label define p052 7 `"5 bis unter  10 Kilometer"', modify
label define p052 8 `"weiter als 10 Kilometer"', modify
label define p052 .x `"Verweigert"', modify
label define p052 .y `"Weiﬂ nicht"', modify
label define p052 .z `"Keine Angabe"', modify
label define p051 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p051 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p051 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p051 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p051 .x `"Verweigert"', modify
label define p051 .y `"Weiﬂ nicht"', modify
label define p051 .z `"Keine Angabe"', modify
label define nutzung .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define nutzung .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define nutzung .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define nutzung .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define nutzung 1 `"(fast) T‰glich"', modify
label define nutzung 2 `"An einem bis drei Tagen pro Woche"', modify
label define nutzung 3 `"An einem bis drei Tagen pro Monat"', modify
label define nutzung 4 `"Seltener als monatlich"', modify
label define nutzung 5 `"Nie"', modify
label define nutzung .x `"Verweigert"', modify
label define nutzung .y `"Weiﬂ nicht"', modify
label define nutzung .z `"Keine Angabe"', modify
label define p022 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p022 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p022 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p022 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p022 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p022 .b `"Verweigert/Weiﬂ nicht zum Besitz eines Fahrrads"', modify
label define p022 .a `"Personen ohne Fahrrad werden nicht befragt"', modify
label define p022 1 `"Leicht"', modify
label define p022 2 `"Etwas umst‰ndlich"', modify
label define p022 3 `"Sehr umst‰ndlich"', modify
label define p022 4 `"Unterschiedlich"', modify
label define p022 .x `"Verweigert"', modify
label define p022 .y `"Weiﬂ nicht"', modify
label define p021 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p021 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p021 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p021 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p021 .p `"Im PAPI-Erwachsenen-Fragebogen nicht erhoben"', modify
label define p021 .b `"Verweigert/Weiﬂ nicht zum Besitz eines Fahrrads"', modify
label define p021 .a `"Personen ohne Fahrrad werden nicht befragt"', modify
label define p021 1 `"In  ein abgeschlossenem Raum unmittelbar im Haus"', modify
label define p021 2 `"In einem abgeschlossenem Raum entfernt vom Haus"', modify
label define p021 3 `"In nicht abgeschlossenem Raum"', modify
label define p021 4 `"Unterschiedlich"', modify
label define p021 5 `"Anderes"', modify
label define p021 .x `"Verweigert"', modify
label define p021 .y `"Weiﬂ nicht"', modify
label define p02 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p02 1 `"Ja"', modify
label define p02 2 `"Nein"', modify
label define p02 .x `"Verweigert"', modify
label define p02 .y `"Weiﬂ nicht"', modify
label define p02 .z `"Keine Angabe"', modify
label define p01 .t `"Proxy kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p01 .s `"Selbst kleiner gleich 13 Jahre werden nicht befragt"', modify
label define p01 .r `"Proxy ab 14 Jahre werden nicht befragt"', modify
label define p01 .q `"Im PAPI-Kinder-Fragebogen nicht erhoben"', modify
label define p01 .a  `"CATI:Personen < 18(Alter aus HH-Matrix) werden nicht befragt"', modify
label define p01 1 `"Jederzeit"', modify
label define p01 2 `"Gelegentlich"', modify
label define p01 3 `"Ausnahmsweise"', modify
label define p01 4 `"Gar nicht"', modify
label define p01 6 `"habe keinen F¸hrerschein"', modify
label define p01 .x `"Verweigert"', modify
label define p01 .y `"Weiﬂ nicht"', modify
label define p01 .z `"Keine Angabe"', modify

label values p031 p032 p033 p034 nutzung
recode p031 p032 p033 p034 (-100=.p) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (9=.z) (-200=.r)
label values s02_1 s02_2 s02_3 s02_4 s02_5 s02_6 s02_7 s02_8 normal
recode s02_1 s02_2 s02_3 s02_4 s02_5 s02_6 s02_7 s02_8 (-60=.d) (-61=.e) (-100=.p) (9=.z) (-51=.b) (-52=.c) (-175=.r) (-10=.a) (7=.x) (-150=.q) (8=.y)
label values weganz_1 weganz_2 weganz_3 weganz
recode weganz_1 weganz_2 weganz_3 (999=.z) (997=.x) (-15=.f) (998=.y)
label values p101_1 p101_2 p101_3 p101_4 p102_1 p102_2 p102_3 p102_4 p102_5 p102_6 reisen
recode p101_1 p101_2 p101_3 p101_4 p102_1 p102_2 p102_3 p102_4 p102_5 p102_6 (994=.u) (-100=.o) (997=.x) (998=.y) (999=.z) (-40=.c) (-41=.d) (-33=.b) (-32=.a) (-175=.q) (-400=.t) (-300=.s) (-150=.p) (-200=.r)
label values p031 p032 p033 p034 nutzung
recode p031 p032 p033 p034 p12_4 p12_5 (-100=.o) (-175=.q) (-400=.t) (-300=.s) (-150=.p) (9=.z) (-200=.r)
label values p09_1 p09_2 p09_3 p09_4  behindert
recode p09_1 p09_2 p09_3 p09_4  (-100=.p) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (9=.z) (-200=.r)
label values p041 p042 erreich
recode p041 p042 (-100=.p) (-400=.t) (-300=.s) (-150=.q) (8=.y) (7=.x) (6=.w) (9=.z) (-200=.r)

recode fragebog (-1=.a)
recode mobil (2=.z) (-1=.a) (-2=.b)
recode kinfo (9=.z) (-1=.a) (-2=.b)
recode psex (9=.z) (2=0)
recode palter (997=.x) (999=.z) (998=.y)
recode kminsgk (-10=.d) (-1=.a) (99994=.u) (-3=.c) (-2=.b)
recode wegtempo (-10=.i) (-1=.a) (9994=.u) (-3=.c) (-2=.b)
recode wegdauer (-10=.i) (-1=.a) (9994=.u) (-3=.c) (-2=.b)
recode w12 (-20=.j) (-10=.a) (-13=.d) (-12=.c) (-15=.f) (-14=.e)
recode wv05 (-60=.e) (98=.y) (-71=.g) (-70=.f) (-51=.b) (-50=.a) (-53=.d) (-52=.c) (-100=.p) (-82=.j) (-83=.k) (-80=.h) (-81=.i) (-300=.s) (-150=.q) (99=.z) (-200=.r) (-400=.t) (97=.x)
recode wv04 (-60=.e) (98=.y) (-71=.g) (-70=.f) (-51=.b) (-50=.a) (-53=.d) (-52=.c) (-100=.p) (-82=.j) (-83=.k) (-80=.h) (-81=.i) (-300=.s) (-150=.q) (99=.z) (-200=.r) (-400=.t) (97=.x)
recode wv03 (-60=.e) (99998=.y) (-71=.g) (-70=.f) (-51=.b) (-50=.a) (-53=.d) (-52=.c) (-100=.p) (99999=.z) (-82=.j) (-83=.k) (-80=.h) (-81=.i) (-300=.s) (-150=.q) (99997=.x) (-200=.r) (-400=.t)
recode wv02 (-60=.e) (99=.z) (-71=.g) (-70=.f) (-51=.b) (-50=.a) (-53=.d) (-52=.c) (-100=.p) (-82=.j) (-83=.k) (-80=.h) (-81=.i) (-300=.s) (-150=.q) (7=.x) (8=.y) (-200=.r) (-400=.t)
recode wv01 (-60=.e) (98=.y) (-71=.g) (-70=.f) (-51=.b) (-50=.a) (-53=.d) (-52=.c) (-100=.p) (-82=.j) (-83=.k) (-80=.h) (-81=.i) (-300=.s) (-150=.q) (99=.z) (-200=.r) (-400=.t) (97=.x)
recode wv0 (-60=.e) (-71=.g) (-70=.f) (-51=.b) (-50=.a) (-53=.d) (-52=.c) (-100=.p) (-83=.k) (-80=.h) (-400=.t) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r)
recode s01 (9=.z) (-10=.a) (8=.y) (7=.x) (-150=.q)
recode s05 (-150=.q) (-400=.t) (-300=.s) (-10=.a) (-13=.d) (-15=.f) (7=.x) (8=.y) (9=.z) (-200=.r)
recode s04 (-29=.a) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (9=.z) (-200=.r)
recode s03 (9=.z) (-150=.q) (7=.x) (8=.y)
recode p08 (-100=.p) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (9=.z) (-200=.r)
recode p09 (-100=.p) (-28=.o) (-400=.t) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r)
recode p18s (99=.z) (-100=.o) (98=.y) (-175=.q) (-400=.t) (-300=.s) (-150=.p) (-200=.r) (97=.x)
recode p17s (99=.z) (-100=.p) (98=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r) (97=.x)
recode p18 (99=.z) (-100=.p) (98=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r) (97=.x)
recode p17 (99=.z) (-100=.p) (98=.y) (-25=.c) (-26=.d) (-400=.t) (-300=.s) (-150=.q) (-200=.r) (97=.x)
recode p16 (-100=.p) (-24=.b) (-23=.a) (-300=.s) (-150=.q) (7=.x) (8=.y) (9=.z) (-200=.r) (-400=.t)
recode p15 (-100=.o) (-175=.q) (-400=.t) (-300=.s) (-150=.p) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r)
recode p14 (99=.z) (-200=.r) (97=.x) (98=.y)
recode p061_4j (9999=.z) (-57=.n) (-56=.m) (9998=.y) (-36=.c) (-35=.b) (-34=.a) (-100=.p) (-44=.k) (-45=.l) (-300=.s) (-150=.q) (-43=.j) (-200=.r) (-400=.t) (9994=.u) (9997=.x)
recode p061_3j (-55=.n) (-54=.m) (-100=.p) (-34=.a) (9998=.y) (-42=.i) (-36=.c) (-35=.b) (-41=.h) (-400=.t) (-300=.s) (-150=.q) (-43=.j) (-200=.r) (9999=.z) (9994=.u) (9997=.x)
recode p061_2j (9994=.u) (9999=.z) (-100=.p) (-41=.h) (-53=.n) (-39=.f) (-38=.e) (-37=.d) (-36=.c) (-35=.b) (-34=.a) (-400=.t) (-300=.s) (-150=.q) (9998=.y) (-52=.m) (-200=.r) (-40=.g) (9997=.x)
recode p061_1j (9999=.z) (-100=.p) (-51=.n) (-50=.m) (-39=.f) (-38=.e) (-37=.d) (-36=.c) (-35=.b) (-34=.a) (-400=.t) (-300=.s) (-150=.q) (9998=.y) (-200=.r) (9994=.u) (9997=.x)
recode p061_4 (-100=.p) (-36=.c) (-35=.b) (-34=.a) (-45=.l) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r) (-400=.t)
recode p061_3 (-100=.p) (-34=.a) (-36=.c) (-35=.b) (-41=.h) (-400=.t) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r)
recode p061_2 (-100=.p) (-34=.a) (-36=.c) (-35=.b) (-41=.h) (-400=.t) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r)
recode p061_1 (-100=.p) (-36=.c) (-35=.b) (-34=.a) (-400=.t) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (9=.z) (-200=.r)
recode p06 (-100=.p) (-36=.c) (-400=.t) (-300=.s) (-150=.q) (2=0) (7=.x) (8=.y) (-200=.r)
recode p13 (-200=.r) (997=.x) (999=.z) (998=.y)
recode p11 (-100=.o) (-175=.q) (-400=.t) (-300=.s) (-150=.p) (9=.z) (-200=.r)
recode p10 (994=.u) (-100=.p) (999=.z) (997=.x) (998=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r)
recode p10as (-100=.o) (-175=.q) (-400=.t) (-300=.s) (-150=.p) (9=.z) (-200=.r)
recode p07 (99=.z) (-100=.p) (98=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r) (97=.x) (96=.w)
recode p054 (99=.z) (-100=.p) (98=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r) (97=.x) (96=.w)
recode p053 (-100=.p) (996=.w) (999=.z) (997=.x) (998=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r)
recode p052 (99=.z) (-100=.p) (98=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r) (97=.x)
recode p051 (-100=.p) (999=.z) (997=.x) (998=.y) (-400=.t) (-300=.s) (-150=.q) (-200=.r)
recode p022 (-100=.p) (-21=.a) (-22=.b) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (-200=.r)
recode p021 (-100=.p) (-21=.a) (-22=.b) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (-200=.r)
recode p02 (9=.z) (-200=.r) (7=.x) (8=.y)
recode p01 (-100=.p) (-20=.a ) (-400=.t) (-300=.s) (-150=.q) (7=.x) (8=.y) (9=.z) (-200=.r)
