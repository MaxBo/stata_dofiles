clear
set memory 700m

insheet using "C:\Spitzencluster Luftverkehr\Modell\Daten_und_Materialien\Flughafen\Passagierbefragung\historische_Passagierbefragungen\06\Rohdaten_06_gesamt_Arb_vers3.txt"


rename sz  Streckenziel
rename datum_t Tag
rename datum_m Monat
gen Jahr = datum_j+2000
rename uhr_s Stunde
rename uhr_m Minute


label define geschlecht 1 `"m�nnlich"', modify 
label define geschlecht 2 `"weiblich"', modify 
label value geschlecht geschlecht

label var f1_1 "Reisegrund_Var1"
label var f1_2 "Reisegrund_Var2"
label var f1_3 "Reisegrund_Var3"
label var f1_4 "Reisegrund_Var4"

label define Reisegrund 1 `"gesch�ftlich"', modify
label define Reisegrund 2 `"privat als Urlaubsreise"', modify
label define Reisegrund 3 `"privat Besuch Verwandte/Bekannte"', modify
label define Reisegrund 4 `"privat aus anderem Grund"', modify

forvalues i=1/4{
	label value f1_`i' Reisegrund
}

label var f3a "Postleitzahl_Startort"
label var f5_1 "Aufbruchsland"
label define f5_1 1 `"Deutschland"', modify
label define f5_1 2 `"Ausland"', modify
label value f5_1 f5_1
label var  f5_2 "Aufbruchsland_Ausland"

label define Ausland 1 `"BRD"', modify
label define Ausland 2 `"Albanien"', modify
label define Ausland 3 `"Armenien"', modify
label define Ausland 4 `"Belgien"', modify
label define Ausland 5 `"Bosnien"', modify
label define Ausland 6 `"Bulgarien"', modify
label define Ausland 7 `"D�nemark"', modify
label define Ausland 8 `"Estland"', modify
label define Ausland 9 `"Finnland / Lappland"', modify
label define Ausland 10 `"Frankreich"', modify
label define Ausland 11 `"Griechenland"', modify
label define Ausland 12 `"Gr�nland"', modify
label define Ausland 13 `"Gro�britannien / Nordirland / Schottland"', modify
label define Ausland 14 `"Irland"', modify
label define Ausland 15 `"Island"', modify
label define Ausland 16 `"Italien"', modify
label define Ausland 17 `"Jugoslawien (Serbien/Montenegro/Kosovo)"', modify
label define Ausland 18 `"Kroatien"', modify
label define Ausland 19 `"Lettland"', modify
label define Ausland 20 `"Liechtenstein"', modify
label define Ausland 21 `"Litauen"', modify
label define Ausland 22 `"Luxemburg"', modify
label define Ausland 23 `"Macedonien"', modify
label define Ausland 24 `"Malta"', modify
label define Ausland 25 `"Moldavien"', modify
label define Ausland 26 `"Monaco"', modify
label define Ausland 27 `"Niederlande"', modify
label define Ausland 28 `"Norwegen"', modify
label define Ausland 29 `"�sterreich"', modify
label define Ausland 30 `"Polen"', modify
label define Ausland 31 `"Portugal"', modify
label define Ausland 32 `"Rum�nien"', modify
label define Ausland 33 `"Russland"', modify
label define Ausland 34 `"Schweden"', modify
label define Ausland 35 `"Schweiz"', modify
label define Ausland 36 `"Slowakische Republik"', modify
label define Ausland 37 `"Slowenien"', modify
label define Ausland 38 `"Spanien"', modify
label define Ausland 39 `"Tschechische  Republik"', modify
label define Ausland 40 `"Ukraine"', modify
label define Ausland 41 `"Ungarn"', modify
label define Ausland 42 `"Zypern (S�d)"', modify
label define Ausland 101 `"Kanada"', modify
label define Ausland 102 `"USA "', modify
label define Ausland 111 `"Antigua / Babuda"', modify
label define Ausland 112 `"Antillen n�rdl.u.s�dl."', modify
label define Ausland 113 `"Bahamas"', modify
label define Ausland 114 `"Barbeidos"', modify
label define Ausland 115 `"Bermudas"', modify
label define Ausland 116 `"Costa Rica"', modify
label define Ausland 117 `"Dominikanische Republik"', modify
label define Ausland 118 `"El Salvador"', modify
label define Ausland 119 `"Equador"', modify
label define Ausland 120 `"Guatemala"', modify
label define Ausland 121 `"Haiti"', modify
label define Ausland 122 `"Honduras"', modify
label define Ausland 123 `"Jamaica"', modify
label define Ausland 124 `"Kuba"', modify
label define Ausland 125 `"Mexico"', modify
label define Ausland 126 `"Nicaragua"', modify
label define Ausland 127 `"Panama"', modify
label define Ausland 128 `"Puerto Rico"', modify
label define Ausland 129 `"Trinidad und Tobago"', modify
label define Ausland 141 `"Argentinien"', modify
label define Ausland 142 `"Bolivien"', modify
label define Ausland 143 `"Brasilien"', modify
label define Ausland 144 `"Chile"', modify
label define Ausland 145 `"Ecuador"', modify
label define Ausland 146 `"Guajana"', modify
label define Ausland 147 `"Kolumbien"', modify
label define Ausland 148 `"Niederl�ndische Antillen"', modify
label define Ausland 149 `"Paraguay"', modify
label define Ausland 150 `"Peru"', modify
label define Ausland 151 `"Uruguay"', modify
label define Ausland 152 `"Venezuela"', modify
label define Ausland 161 `"Aethiopien"', modify
label define Ausland 162 `"�gypten"', modify
label define Ausland 163 `"Algerien"', modify
label define Ausland 164 `"Botswana"', modify
label define Ausland 165 `"Elfenbeink�ste"', modify
label define Ausland 166 `"Eritrea"', modify
label define Ausland 167 `"Gambia"', modify
label define Ausland 168 `"Ghana"', modify
label define Ausland 169 `"Kamerun"', modify
label define Ausland 170 `"Kenia"', modify
label define Ausland 171 `"Kongo"', modify
label define Ausland 172 `"Lybien"', modify
label define Ausland 173 `"Marokko"', modify
label define Ausland 174 `"Mauritius"', modify
label define Ausland 175 `"Mosambik"', modify
label define Ausland 176 `"Namibia"', modify
label define Ausland 177 `"Nigeria"', modify
label define Ausland 178 `"Sambia"', modify
label define Ausland 179 `"Senegal"', modify
label define Ausland 180 `"Simbabwe und Seychellen"', modify
label define Ausland 181 `"Somali"', modify
label define Ausland 182 `"S�dafrika"', modify
label define Ausland 183 `"Sudan"', modify
label define Ausland 184 `"Tansania"', modify
label define Ausland 185 `"Togo"', modify
label define Ausland 186 `"Tschad"', modify
label define Ausland 187 `"Tunesien"', modify
label define Ausland 188 `"Zaire"', modify
label define Ausland 189 `"Mali"', modify
label define Ausland 201 `"Arabische Emirate "', modify
label define Ausland 214 `"Aserbaidschan"', modify
label define Ausland 202 `"Georgien"', modify
label define Ausland 203 `"Irak"', modify
label define Ausland 204 `"Iran"', modify
label define Ausland 205 `"Israel"', modify
label define Ausland 206 `"Jemen"', modify
label define Ausland 207 `"Jordanien"', modify
label define Ausland 208 `"Libanon"', modify
label define Ausland 209 `"Oman"', modify
label define Ausland 210 `"Quatar / Katar"', modify
label define Ausland 211 `"Saudi Arabien"', modify
label define Ausland 212 `"Syrien"', modify
label define Ausland 213 `"T�rkei"', modify
label define Ausland 221 `"Afghanistan"', modify
label define Ausland 222 `"Bali"', modify
label define Ausland 223 `"Birma"', modify
label define Ausland 224 `"China"', modify
label define Ausland 225 `"Indien"', modify
label define Ausland 226 `"Indonesien"', modify
label define Ausland 227 `"Japan"', modify
label define Ausland 228 `"Kambodscha"', modify
label define Ausland 229 `"Kasachstan"', modify
label define Ausland 230 `"Kirgisistan"', modify
label define Ausland 231 `"Korea"', modify
label define Ausland 232 `"Laos"', modify
label define Ausland 233 `"Malaysia"', modify
label define Ausland 234 `"Malediven"', modify
label define Ausland 235 `"Mongolei"', modify
label define Ausland 236 `"Nepal"', modify
label define Ausland 237 `"Pakistan"', modify
label define Ausland 238 `"Philippinen"', modify
label define Ausland 239 `"Singapur"', modify
label define Ausland 240 `"Skri Lanka"', modify
label define Ausland 241 `"S�dkorea"', modify
label define Ausland 242 `"Tadschikistan"', modify
label define Ausland 243 `"Taiwan"', modify
label define Ausland 244 `"Thailand"', modify
label define Ausland 245 `"Usbekistan"', modify
label define Ausland 246 `"Vietnam"', modify
label define Ausland 256 `"Australien"', modify
label define Ausland 257 `"Antarktis allg. Staat nicht zuzuordnen"', modify
label define Ausland 258 `"Fidgi-Inseln"', modify
label define Ausland 259 `"Kiribati"', modify
label define Ausland 260 `"Neuseeland"', modify
label define Ausland 261 `"Tasmanien"', modify

label value f5_2 Ausland

label var f7a "Postleitzahl_Wohnort"
label var f8_1 "Wohnland" 
label value f8_1 f5_1
label var f8_2 "Wohnland_Ausland"
label value f8_2 Ausland
label var f9 "Zielflughafen_Code"
label var ez "Zielflughafen"
label var f10 "Umstiege"
label define f10 1 `"Direktflug"', modify
label define f10 2 `"Flug mit Umstieg"', modify
label value f10 f10

forvalues i=1/6 {
label var f11_`i' "Umstieg_`i'"
}

label var f12 "Quell-/Zielverkehr"
label define f12 1 `"Quellverkehr"', modify
label define f12 2 `"Zielverkehr"', modify
label value f12 f12

label var f13_1 "Reisedauer in Tagen"
label var f13_2 "Reisedauer in Wochen"
label var f13_3 "Reisedauer in Monaten"

label var f14 "Buchungsort der Reise"
label define f14 1 `"Internet"' 2 `"Reiseb�ro am Flughafen"' 3 `"anderes Reiseb�ro"' 4 `"bei der Fluggesellschaft"' 5 `"Sekretariat"'
label define f14 6 `"Aldi / Penny / Budni"', modify
label define f14 7 `"Ausland"', modify
label define f14 8 `"Bertelsmann"', modify
label define f14 9 `"Big X-tra"', modify
label define f14 10 `"Fernsehen"', modify
label define f14 11 `"Firmencharter / Kundenreise / Autofirmen / Banken"', modify
label define f14 12 `"Hotelbuchung direkt"', modify
label define f14 13 `"IST Sprachschule"', modify
label define f14 14 `"Lesereise"', modify
label define f14 15 `"NKL"', modify
label define f14 16 `"Schiffsagentur Reederei"', modify
label define f14 17 `"Veranstalter"', modify
label define f14 18 `"Videotext"', modify
label define f14 19 `"Zeitung / Bildzeitung"', modify
label define f14 20 `"wei� nicht / Geschenk / Gewinn"', modify
label define f14 21 `"Sonstige BSW"', modify
label define f14 22 `"Reisemesse"', modify
label value f14 f14

label var f15 "gebuchte Leistungen"
label define f15 1 `"nur Flug"', modify
label define f15 2 `"Flug und zus�tzliche Leistungen"', modify

label var f16_1  "gebuchte Leistungen"
label define f16_1 1 `"Flug + Unterkunft zusammen"', modify
label define f16_1 2 `"Flug + Unterkunft getrennt"', modify
label define f16_1 3 `"anderes zus�tzliches gebucht"', modify
label var f16_2  "gebuchte Leistungen - Zusatz"
label value f16_1 f16_1
label value f16_2 f16_1

label var f18  "Reiseklasse"
label define f18 1 `"First Class"' 2 `"Business Class"' 3 `"Economy Plus"' 4 `"Economy Class"' 5 `"klassenlos / Pauschalreisender"' 
label define f18 6 `"Wei� nicht"', modify
label define f18 7 `"Sonderklasse R 6"', modify
label define f18 8 `"Club Klasse"', modify
label define f18 9 `"Star Class"', modify
label define f18 10 `"Comfort Class"', modify

label var f19_1 "Anzal gemeinsam Reisender"
label var f19_2 "Anzahl Erwachsener"
label var f19_3 "Anzahl Kinder"

label var f20 "Anzahl Begleitender zum Flughafen"
label var f21_1 "Preis f�r Pauschalreise"
label var f21_2 "Ticketpreis"
label var f22 "Ticketart"
label define f22 1 `"Hin- und R�ckflug"', modify
label define f22 2 `"One-way-ticket"', modify
label value f22 f22

label var f23 "Sondertarife"
label define f23 1 `"Normaltarif"', modify
label define f23 2 `"Vielfliegerprogramm"', modify
label define f23 3 `"PAD Sondertarif"', modify
label define f23 4 `"Last Minute"', modify
label define f23 5 `"Fr�hbucherrabatt"', modify
label define f23 6 `"unbekannt"', modify
label define f23 18 `"Sonstiges"', modify
label define f23 7 `"Sondertarif allg./Multispezial / Jubil�umstarif / Rabattgewinn Penny / BSW-Angebot / tags�ber / Hagebau Partner Card"', modify
label define f23 8 `"Firmentarif"', modify
label define f23 9 `"Sondertarif 14/10 - 7/5 "', modify
label define f23 19 `"Langzeitsondertarif"', modify
label define f23 11 `"Studenten-/ Sch�ler-/ Senioren-/ Jugend-Tarif"', modify
label define f23 12 `"Gruppenreise"', modify
label define f23 13 `"Messerabatt"', modify
label value f23 f23

label var f24 "Flugtag = Flugbuchungstag"
label var f24_1 "Flugbuchung vor ... Tagen"
label var f24_2 "Flugbuchung vor ... Wochen"
label var f24_3 "Flugbuchung vor ... Monaten"

label var f25 "letztes Verkehrsmittel vor Ankunft am Flughafen"
label define f25 1 `"Privater oder Firmen-PKW, der gleich zur�ckgefahren ist"', modify
label define f25 2 `"Privater oder Firmen-PKW, der kurz abgestellt wurde"', modify
label define f25 3 `"Privater oder Firmen-PKW, der abgestellt u. von anderen/Dritten abgeholt wird"', modify
label define f25 4 `"Privater oder Firmen-PKW, der f�r die Reisedauer abgestellt wurde"', modify
label define f25 5 `"Taxi"', modify
label define f25 6 `"Leihwagen"', modify
label define f25 7 `"Airport-City-Bus vom Hauptbahnhof"', modify
label define f25 8 `"HVV Bus Linie 110 von Ohlsdorf "', modify
label define f25 9 `"Andere HVV-Buslinie"', modify
label define f25 10 `"Fernverkehrs-Linienbus aus Richtung Kiel/Neum�nster (Kielius)"', modify
label define f25 11 `"Reisebus z.B. bei Pauschalreise / Gruppenreise / zu Mehreren"', modify
label define f25 12 `"Zubringerdienst = kleinerer Bus / Hotelshuttle / etc. (kein Reisebus!) "', modify
label define f25 13 `"Traveline Bus (Travem�nde_L�beck_Oldesloe_Hamburg)"', modify
label define f25 14 `"Flugzeug"', modify
label define f25 21 `"C-Maxx-Autoservice"', modify
label define f25 22 `"DRK Krankentransport"', modify
label define f25 23 `"Fahrrad"', modify
label define f25 24 `"HVV Bus, anderer"', modify
label define f25 25 `"Keines / kein Verkehrsmittel"', modify
label define f25 26 `"Lufthansashuttle von Luftwerft"', modify
label define f25 27 `"Mitarbeiterparkplatz"', modify
label define f25 28 `"Park & Fly extern / Valet Parking"', modify
label define f25 29 `"Roller, Motorroller"', modify
label define f25 30 `"zu Fu�"', modify

label var f26_1 "vorangegangener Flug - Fluggesellschaft (Code)"
label var f26_2 "vorangegangener Flug - Flugnummer"
label var f26_3 "vorangegangener Flug - letzter Flughafen"
label var f26_4 "vorangegangener Flug - Aufbruchflughafen"

label define f26_1 1 `"Aero Svit Airlines"', modify
label define f26_1 2 `"Aeroflot"', modify
label define f26_1 3 `"Air Baltic"', modify
label define f26_1 4 `"Air Berlin"', modify
label define f26_1 5 `"Air Cairo"', modify
label define f26_1 6 `"Air Canada"', modify
label define f26_1 7 `"Air China"', modify
label define f26_1 8 `"Air Europa"', modify
label define f26_1 9 `"Air France"', modify
label define f26_1 10 `"Air Lingus"', modify
label define f26_1 11 `"Air Malta"', modify
label define f26_1 12 `"Air New Zealand"', modify
label define f26_1 13 `"Air Nippon Airways"', modify
label define f26_1 14 `"Air transat"', modify
label define f26_1 15 `"Air Via Bulgaria Airways"', modify
label define f26_1 16 `"Alitalia"', modify
label define f26_1 17 `"Amber Air"', modify
label define f26_1 18 `"Amc Airlines"', modify
label define f26_1 19 `"American Airlines"', modify
label define f26_1 20 `"Atlasjet International Condor"', modify
label define f26_1 21 `"Augsburg Airways"', modify
label define f26_1 22 `"Austrian Airlines"', modify
label define f26_1 23 `"Blue 1"', modify
label define f26_1 24 `"British Airways"', modify
label define f26_1 25 `"British Midland Airways"', modify
label define f26_1 26 `"Brussels Airlines"', modify
label define f26_1 27 `"Bulgarian Air Charter"', modify
label define f26_1 28 `"Cathay Pacific Airways"', modify
label define f26_1 29 `"cirrus"', modify
label define f26_1 30 `"Condor"', modify
label define f26_1 31 `"Continental"', modify
label define f26_1 32 `"Croatia Airlines"', modify
label define f26_1 33 `"Crossair"', modify
label define f26_1 34 `"CSA Czech Airlines"', modify
label define f26_1 35 `"dba"', modify
label define f26_1 36 `"Delta Airlines"', modify
label define f26_1 37 `"Deutsche Lufthansa"', modify
label define f26_1 38 `"easy-Jet"', modify
label define f26_1 39 `"Egypt Air"', modify
label define f26_1 40 `"Emirates"', modify
label define f26_1 41 `"Estonia Air"', modify
label define f26_1 42 `"Eurowings"', modify
label define f26_1 43 `"Finnair"', modify
label define f26_1 44 `"Firmenflugzeug"', modify
label define f26_1 45 `"Free Bird Airines"', modify
label define f26_1 46 `"Futura"', modify
label define f26_1 47 `"Germania"', modify
label define f26_1 48 `"Germanwings"', modify
label define f26_1 49 `"Hahn Air"', modify
label define f26_1 50 `"Hamburg international"', modify
label define f26_1 51 `"Hapag Lloyd Express"', modify
label define f26_1 52 `"Hapagfly"', modify
label define f26_1 53 `"Iberia"', modify
label define f26_1 54 `"Inter Airlines"', modify
label define f26_1 55 `"Intersky Luftfahrt GmbH"', modify
label define f26_1 56 `"Iran Air"', modify
label define f26_1 57 `"Japan Airlines"', modify
label define f26_1 58 `"Karthago Airlines"', modify
label define f26_1 59 `"KLM"', modify
label define f26_1 60 `"LGW,  Luftfahrtges. Walter"', modify
label define f26_1 61 `"Lithuanian Airlines"', modify
label define f26_1 62 `"LOT"', modify
label define f26_1 63 `"LTE International Airways"', modify
label define f26_1 64 `"LTU"', modify
label define f26_1 65 `"Luftfahrtgesellschaft Walter"', modify
label define f26_1 66 `"Luxair"', modify
label define f26_1 67 `"Malev"', modify
label define f26_1 68 `"MAT Macedonian Airlines"', modify
label define f26_1 69 `"MNG Airlines"', modify
label define f26_1 70 `"Nordic Leisure"', modify
label define f26_1 71 `"North West Airlines"', modify
label define f26_1 72 `"Norwegian"', modify
label define f26_1 73 `"Norwegian "', modify
label define f26_1 74 `"Nouvelair Tunisie "', modify
label define f26_1 75 `"OLT"', modify
label define f26_1 76 `"Onur Air"', modify
label define f26_1 77 `"Pegasus Airlines"', modify
label define f26_1 78 `"PGA Portugalia Airline"', modify
label define f26_1 79 `"Pulkovo Aviation Enterprise"', modify
label define f26_1 80 `"Quantas Airways"', modify
label define f26_1 81 `"SAS"', modify
label define f26_1 82 `"Singapur Airlines"', modify
label define f26_1 83 `"Sky Airlines"', modify
label define f26_1 84 `"South Africa Airways"', modify
label define f26_1 85 `"Spanair"', modify
label define f26_1 86 `"Sun Express"', modify
label define f26_1 87 `"Swiss International"', modify
label define f26_1 88 `"Sylt Air"', modify
label define f26_1 89 `"TAP Air Portugal"', modify
label define f26_1 90 `"TTA"', modify
label define f26_1 91 `"Tunisair"', modify
label define f26_1 92 `"Turkish Airlines"', modify
label define f26_1 93 `"United Airlines"', modify
label define f26_1 94 `"US Airlways"', modify
label define f26_1 95 `"Varig Airlines"', modify
label define f26_1 96 `"VLM Airlines"', modify
label define f26_1 97 `"Volav Airlines"', modify

label value f26_1 f26_1

label var f27 "Parkplatz"
label define f27 1 `"P1"', modify
label define f27 2 `"P2"', modify
label define f27 3 `"P3"', modify
label define f27 4 `"P4"', modify
label define f27 5 `"P5"', modify
label define f27 6 `"P6"', modify
label define f27 7 `"P7"', modify
label define f27 8 `"P8"', modify
label define f27 9 `"P9"', modify
label define f27 10 `"Sonstige"', modify

label var f28 "Holidayparkplatznutzung"
label define f28 1 `"Ja"', modify
label define f28 2 `"Nein"', modify
label value f28 f28

label var f30_1 "Check-In - 1.Antwort"
label var f30_2 "Check-In - 2.Antwort"
label define f30 1 `"FH HH am Automaten"', modify
label define f30 2 `"FH HH am Automaten mit Gep�ck"', modify
label define f30 3 `"FH HH am normalen Schalter"', modify
label define f30 4 `"FH HH Vorabend Check-In am normalen Schalter"', modify
label define f30 5 `"Beim Herflug am Automaten"', modify
label define f30 6 `"Beim Herflug am normalen Schalter"', modify
label define f30 7 `"Internet"', modify
label define f30 8 `"Telefonisch"', modify
label define f30 9 `" Vorabend Check-In am Automaten mit Gep�ck"', modify
label define f30 10 `"Beim Herflug Vorabend-Check-In"', modify
label define f30 11 `"Internet ohne Gep�ck"', modify
label define f30 12 `"Internet am Vorabend"', modify
label define f30 13 `"Gep�ck separat"', modify
label define f30 14 `"Sperrgutaschalter"', modify
label define f30 15 `"Robot Check-In (speziell f. Senator)"', modify
label define f30 16 `"Reiseb�ro"', modify
label define f30 17 `"SMS"', modify

label value f30_1 f30
label value f30_2 f30

label var f31 "Reise mit Gep�ck"
label value f31 f28

label var f32_1 "Aufbruch von Startort vor planm��igen Abflug - Stunden"
label var f32_2 "Aufbruch von Startort vor planm��igen Abflug - Minuten"

label var f38a_1 "Anzahl j�hrlicher Flugreisen - gesch�ftlich"
label var f38b_1 "Anzahl j�hrlicher Flugreisen ab HAM - gesch�ftlich"
label var f38a_2 "Anzahl j�hrlicher Flugreisen - privat"
label var f38b_2 "Anzahl j�hrlicher Flugreisen ab HAM - privat"

label define f39 6 `"M�nchen"', modify
label define f39 7 `"Frankfurt"', modify
label define f39 8 `"D�sseldorf"', modify
label define f39 9 `"Kopenhagen"', modify
label define f39 10 `"Dresden"', modify
label define f39 11 `"Billund"', modify
label define f39 12 `"Rostock"', modify
label define f39 13 `"andere: Z�rich / Paris / Stuttgart / Wien / Malaga / Linz / Amsterdam"', modify
label define f39 14 `"Dortmund"', modify
label define f39 15 `"K�ln/Bonn"', modify
label define f39 16 `"Paderborn"', modify
label define f39 17 `"Finkenwerder"', modify

forvalues i=1/4 {
 label var f39_`i' "anderer Flughafen `i'"
 label value f39_`i' f39
}

label var f39_01 "Anzahl Fl�ge im Jahr ab Bremen"
label var f39_02 "Anzahl Fl�ge im Jahr ab M�nster/Osnabr�ck"
label var f39_03 "Anzahl Fl�ge im Jahr ab L�beck"
label var f39_04 "Anzahl Fl�ge im Jahr ab Hannover"
label var f39_05 "Anzahl Fl�ge im Jahr ab Berlin"

label var f40 "Quell-/Zielverkehr"
label value f40 f12

label var f40a_1 "Fl�ge nach FRA - Anzahl Fl�ge im Jahr"
label var f40a_2 "Fl�ge nach FRA - Anzahl Bahnfahrten im Jahr"
label var f40a_3 "Fl�ge nach FRA - Anzahl Kfz im Jahr"
label var f40a_4 "FRA nie Ziel"
label var f40b_1 "Fl�ge nach DUS - Anzahl Fl�ge im Jahr"
label var f40b_2 "Fl�ge nach DUS - Anzahl Bahnfahrten im Jahr"
label var f40b_3 "Fl�ge nach DUS - Anzahl Kfz im Jahr"
label var f40b_4 "DUS nie Ziel"

label var f41 "Zufriedenheit mit Direktflugangebot"
label define f41 1 `"gerade richtig"', modify
label define f41 2 `"eher zu gering"', modify
label define f41 3 `"viel zu gering"', modify
label value f41 f41

forvalues i=1/5 {
 label var f42_`i' "fehlendes Ziel `i'"
}

label define f48 1  `"Verkehr"', modify
label define f48 2  `"�bersichtlichkeit"', modify
label define f48 3  `"Informationsm�glichkeiten"', modify
label define f48 4  `"Wartezeiten bei Abfertigung"', modify
label define f48 5  `"Sauberkeit"', modify
label define f48 6  `"Sicherheit"', modify
label define f48 7  `"Freundlichkeit Angestellter FH"', modify
label define f48 8  `"Ambiente"', modify
label define f48 9  `"Gastronomie"', modify
label define f48 10  `"Shopping"', modify
label define f48 11  `"Sanit�ranlangen"', modify


forvalues i=1/3 {
 label var f48_`i' "wichtiges Merkmal des Flughafens `i'"
 label value f48_`i' f48
}

label var f49_4 "Beurteilung verkehrsg�nstige Lage HAM (Schulnoten 1-5)"

label var alter "Alter"
label var staat_1  "deutsch"
label var staat_2  "andere"
label value staat_2 Ausland

label var f52 "Besch�ftigungsart"
label define f52 1  `"Selbst�ndige / Freie Berufe"', modify
label define f52 2  `"Leitende Angestellte"', modify
label define f52 3  `"Sonstige Angestellte / Beamte"', modify
label define f52 4  `"Facharbeiter / nicht selbst�ndige Handwerker"', modify
label define f52 5  `"Sonstige Arbeiter"', modify
label define f52 6  `"Landwirt / m.u.o. Hochschulreife"', modify
label define f52 7  `"Sch�ler / Student / Azubi / Zivil- o. Wehrdienstleistender"', modify
label define f52 8  `"Hausfrau /-mann"', modify
label define f52 9  `"Nicht mehr berufst�tig / arbeitslos / Rentner"', modify
label value f52 f52

label var f53 "Haushaltsnettoeinkommen"
label define f53 1  `"< 750 �"', modify
label define f53 2  `"750 - 1250"', modify
label define f53 3  `"1250 - 2000"', modify
label define f53 4  `"2000 - 2500"', modify
label define f53 5  `"2500 - 3000"', modify
label define f53 6  `"3000<"', modify
label value f53 f53

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06.dta", replace 

