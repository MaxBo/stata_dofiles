clear
set memory 700m

insheet using "C:\Spitzencluster Luftverkehr\Modell\Daten_und_Materialien\Flughafen\Passagierbefragung\historische_Passagierbefragungen\10\Fluggastbefragung_10_4.txt"


* rename sz  Streckenziel
rename datum_t Tag
rename datum_m Monat
gen Jahr = datum_j+2000
rename uhr_s Stunde
rename uhr_m Minute
rename eintreffzeit f32
* rename v35 f7a

label define geschlecht 1 `"männlich"', modify 
label define geschlecht 2 `"weiblich"', modify 
label value geschlecht geschlecht

label var f1_1 "Reisegrund_Var1"
label var f1_2 "Reisegrund_Var2"
label var f1_3 "Reisegrund_Var3"
label var f1_4 "Reisegrund_Var4"

label define Reisegrund 1 `"geschäftlich"', modify
label define Reisegrund 2 `"privat als Urlaubsreise"', modify
label define Reisegrund 3 `"privat Besuch Verwandte"', modify
label define Reisegrund 4 `"privat Besuch Bekannte"', modify
label define Reisegrund 5 `"privat aus anderem Grund"', modify
label define Reisegrund 6 `"geschäftlich Messe/Kongress"', modify

forvalues i=1/4{
	label value f1_`i' Reisegrund
}
label value hrg Reisegrund

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
label define Ausland 7 `"Dänemark"', modify
label define Ausland 8 `"Estland"', modify
label define Ausland 9 `"Finnland / Lappland"', modify
label define Ausland 10 `"Frankreich"', modify
label define Ausland 11 `"Griechenland"', modify
label define Ausland 12 `"Grönland"', modify
label define Ausland 13 `"Großbritannien / Nordirland / Schottland"', modify
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
label define Ausland 29 `"Österreich"', modify
label define Ausland 30 `"Polen"', modify
label define Ausland 31 `"Portugal"', modify
label define Ausland 32 `"Rumänien"', modify
label define Ausland 33 `"Russland"', modify
label define Ausland 34 `"Schweden"', modify
label define Ausland 35 `"Schweiz"', modify
label define Ausland 36 `"Slowakische Republik"', modify
label define Ausland 37 `"Slowenien"', modify
label define Ausland 38 `"Spanien"', modify
label define Ausland 39 `"Tschechische  Republik"', modify
label define Ausland 40 `"Ukraine"', modify
label define Ausland 41 `"Ungarn"', modify
label define Ausland 42 `"Zypern (Süd)"', modify
label define Ausland 101 `"Kanada"', modify
label define Ausland 102 `"USA "', modify
label define Ausland 111 `"Antigua / Babuda"', modify
label define Ausland 112 `"Antillen nördl.u.südl."', modify
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
label define Ausland 148 `"Niederländische Antillen"', modify
label define Ausland 149 `"Paraguay"', modify
label define Ausland 150 `"Peru"', modify
label define Ausland 151 `"Uruguay"', modify
label define Ausland 152 `"Venezuela"', modify
label define Ausland 161 `"Aethiopien"', modify
label define Ausland 162 `"Ägypten"', modify
label define Ausland 163 `"Algerien"', modify
label define Ausland 164 `"Botswana"', modify
label define Ausland 165 `"Elfenbeinküste"', modify
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
label define Ausland 182 `"Südafrika"', modify
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
label define Ausland 213 `"Türkei"', modify
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
label define Ausland 241 `"Südkorea"', modify
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
* label var ez "Zielflughafen"
label var f10 "Umstiege"
label define f10 1 `"Direktflug"', modify
label define f10 2 `"Flug mit Umstieg"', modify
label value f10 f10

forvalues i=1/3 {
label var f11_`i' "Umstieg_`i'"
}

label var f12 "Quell-/Zielverkehr"
label define f12 1 `"Quellverkehr"', modify
label define f12 2 `"Zielverkehr"', modify
label define f12 3 `"Umsteiger"', modify
label value f12 f12
label value f12n f12

label var f13_1 "Reisedauer in Tagen"
label var f13_2 "Reisedauer in Wochen"
label var f13_3 "Reisedauer in Monaten"



label var f14 "Buchungsort der Reise"
recode f14 (13=22)(3=2) (4=3) (5=4) (7=5) (2=23) (6=24) (8=25) (9=26) (10=19) (11=16) (12=13)
label define f14 1 `"Internet"' 2 `"Reisebüro am Flughafen"' 3 `"anderes Reisebüro"' 4 `"bei der Fluggesellschaft"' 5 `"Sekretariat"'
label define f14 6 `"Aldi / Penny / Budni"', modify
label define f14 7 `"Ausland"', modify
label define f14 8 `"Bertelsmann"', modify
label define f14 9 `"Big X-tra"', modify
label define f14 10 `"Fernsehen"', modify
label define f14 11 `"Firmencharter / Kundenreise / Autofirmen / Banken"', modify
label define f14 12 `"Hotelbuchung direkt"', modify
label define f14 13 `"Sprachreisen: IST / Sprachreiseorganisation / Schüleraustausch / EF"', modify
label define f14 14 `"Lesereise"', modify
label define f14 15 `"NKL"', modify
label define f14 16 `"Schiffsagentur Reederei"', modify
label define f14 17 `"Veranstalter"', modify
label define f14 18 `"Videotext"', modify
label define f14 19 `"Zeitung / Bildzeitung / Zeitschrift"', modify
label define f14 20 `"weiß nicht / Geschenk / Gewinn"', modify
label define f14 21 `"Sonstige BSW"', modify
label define f14 22 `"Lesereise / Reisemesse"', modify
label define f14 23 `"Telefonisch / Call Center im Reisebüro"', modify
label define f14 24 `"Fluggesellschaft direkt am Schalter"', modify
label define f14 25 `"Sonstiges"', modify
label define f14 26 `"Veranstalter / Haspa / Hapimag / Bertelsmann"', modify

label value f14 f14

label var f15 "gebuchte Leistungen"
label define f15 1 `"nur Flug"', modify
label define f15 2 `"Flug und zusätzliche Leistungen"', modify
label value f15 f15

label var f16_1  "gebuchte Leistungen"
label define f16_1 1 `"Flug + Unterkunft zusammen"', modify
label define f16_1 2 `"Flug + Unterkunft getrennt"', modify
label define f16_1 3 `"anderes zusätzliches gebucht"', modify
label var f16_2  "gebuchte Leistungen - Zusatz"
label var f16_3  "gebuchte Leistungen - Zusatz 2"
label value f16_1 f16_1
label value f16_2 f16_1


label var f18  "Reiseklasse"
recode f18 (3=4) (4=3)
label define f18 1 `"First Class"' 2 `"Business Class"' 3 `"Economy Plus"' 4 `"Economy Class"' 5 `"klassenlos / Pauschalreisender"' 
label define f18 6 `"Weiß nicht"', modify
label define f18 7 `"Sonderklasse R 6"', modify
label define f18 8 `"Club Klasse"', modify
label define f18 9 `"Star Class"', modify
label define f18 10 `"Comfort Class"', modify

label var f19_1 "Anzal gemeinsam Reisender"
label var f19_2 "Anzahl Erwachsener"
label var f19_3 "Anzahl Kinder"

label var f20 "Anzahl Begleitender zum Flughafen"
* label var f21_1 "Preis für Pauschalreise"
* label var f21_2 "Ticketpreis"
* label var f22 "Ticketart"
* label define f22 1 `"Hin- und Rückflug"', modify
* label define f22 2 `"One-way-ticket"', modify
* label value f22 f22

label var f24 "Flugtag = Flugbuchungstag"
label var f24_1 "Flugbuchung vor ... Tagen"
label var f24_2 "Flugbuchung vor ... Wochen"
label var f24_3 "Flugbuchung vor ... Monaten"

label var f25 "letztes Verkehrsmittel vor Ankunft am Flughafen"
recode f25(7=16) (9=20) (30=31) (15=14) (13=12) (34=9) (12=11) (14=13) (24=25) (25=26) (26=29) (27=30) (28=17)
label define f25 1 `"Privater oder Firmen-PKW, der gleich zurückgefahren ist"', modify
label define f25 2 `"Privater oder Firmen-PKW, der kurz abgestellt wurde"', modify
label define f25 3 `"Privater oder Firmen-PKW, der abgestellt u. von anderen/Dritten abgeholt wird"', modify
label define f25 4 `"Privater oder Firmen-PKW, der für die Reisedauer abgestellt wurde"', modify
label define f25 5 `"Taxi"', modify
label define f25 6 `"Leihwagen"', modify
label define f25 7 `"Airport-City-Bus vom Hauptbahnhof"', modify
label define f25 8 `"HVV Bus Linie 110 von Ohlsdorf "', modify
label define f25 9 `"Andere HVV-Buslinie"', modify
label define f25 10 `"Fernverkehrs-Linienbus aus Richtung Kiel/Neumünster (Kielius)"', modify
label define f25 11 `"Reisebus z.B. bei Pauschalreise / Gruppenreise / zu Mehreren"', modify
label define f25 12 `"Zubringerdienst = kleinerer Bus / Hotelshuttle / etc. (kein Reisebus!) "', modify
label define f25 13 `"Traveline Bus (Travemünde_Lübeck_Oldesloe_Hamburg)"', modify
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
label define f25 30 `"zu Fuß"', modify
label define f25 31 `"Bus 39"', modify
label define f25 32 `"Bus 26"', modify
label define f25 33 `"Bus 292"', modify
label define f25 20 `"S1"', modify
label define f25 16 `"Flughafentransfer / Sammeltaxi"', modify
label define f25 17 `"Leihwagen mit Chauffeur"', modify
label value f25 f25

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
label var f30_3 "Check-In - 3.Antwort"

label define f30 1 `"FH HH am Automaten"', modify
label define f30 2 `"FH HH am Automaten mit Gepäck"', modify
label define f30 3 `"FH HH am normalen Schalter"', modify
label define f30 4 `"FH HH Vorabend Check-In am normalen Schalter"', modify
label define f30 5 `"Beim Herflug am Automaten"', modify
label define f30 6 `"Beim Herflug am normalen Schalter"', modify
label define f30 7 `"Internet"', modify
label define f30 8 `"Telefonisch"', modify
label define f30 9 `" Vorabend Check-In am Automaten mit Gepäck"', modify
label define f30 10 `"Beim Herflug Vorabend-Check-In"', modify
label define f30 11 `"Internet ohne Gepäck"', modify
label define f30 12 `"Internet am Vorabend"', modify
label define f30 13 `"Gepäck separat"', modify
label define f30 14 `"Sperrgutaschalter"', modify
label define f30 15 `"Robot Check-In (speziell f. Senator)"', modify
label define f30 16 `"Reisebüro"', modify
label define f30 17 `"SMS"', modify

label value f30_1 f30
label value f30_2 f30
label value f30_3 f30

label var f31 "Reise mit Gepäck"
label value f31 f28

label var f32_1 "Eintreffzeit vor planmäßigen Abflug - Stunden"
label var f32_2 "Eintreffzeit vor planmäßigen Abflug - Minuten"

label var f38a_1 "Anzahl jährlicher Flugreisen - geschäftlich"
label var f38b_1 "Anzahl jährlicher Flugreisen ab HAM - geschäftlich"
label var f38a_2 "Anzahl jährlicher Flugreisen - privat"
label var f38b_2 "Anzahl jährlicher Flugreisen ab HAM - privat"

label var f38c "Anzahl jährlicher Flugreisen ab HAM - privat"

label var f74_1 "Anzahl innereupäischer Flüge"
label var f74_2 "Anzahl innerkontinentaler Flüge"

label var f37 "Aufbruchstag"
label define f37 1  `"heute"', modify
label define f37 2  `"gestern"', modify
label value f37 f37

label var f37a_1 "Aufbruchszeit heute Stunde"
label var f37a_2 "Aufbruchszeit heute Minute"
label var f37b_1 "Aufbruchszeit gestern Stunde"
label var f37b_2 "Aufbruchszeit gestern Minute"


label var f46 "Nicht Mitglied in Vielfliegerprogramm"
label value f46 f28

label var alter "Alter"
label var staat_1  "deutsch"
label var staat_2  "andere"
label value staat_2 Ausland

label define f60 1  `"PKW (auch Mietwagen )"', modify
label define f60 2  `"Bus"', modify
label define f60 3  `"U-Bahn / S-Bahn"', modify
label define f60 4  `"Regionalbahn"', modify
label define f60 5  `"ICE / IC"', modify
label define f60 6  `"anderes / k.A."', modify
label define f60 6  `"kein anderes VM vorher"', modify

forvalues i=1/3 {
 label var f60_`i' "anderes Zubringerverkehrsmittel `i'"
 label value f60_`i' f60
}

label var f61 "Zeitkartenbesitz"
label value f61 f28

label var f62_1 "genutzter Fahrausweis 1"
label var f62_2 "genutzter Fahrausweis 2"
label define f62 1 `"Einzelkarte Kurzstrecke 2 1,30€"', modify
label define f62 16 `"Einzelkarte Kurzstrecke 1 2,70€"', modify
label define f62 2 `"Einzelkarte Nahbereich 2 1,65€"', modify
label define f62 17 `"Einzelkarte Nahbereich 1 3,05€"', modify
label define f62 3 `"Einzelkarte Großbereich 2 2,70€"', modify
label define f62 18 `"Einzelkarte Großbereich 1 4,10€"', modify
label define f62 4 `"Einzelkarte 3 Ringe 2 4,40€"', modify
label define f62 19 `"Einzelkarte 3 Ringe 1 5,80€"', modify
label define f62 5 `"Einzelkarte 4 Ringe 2 5,75€"', modify
label define f62 20 `"Einzelkarte 4 Ringe 1 7,15€"', modify
label define f62 6 `"Einzelkarte Gesamtbereich 2 7,20€"', modify
label define f62 21 `"Einzelkarte Gesamtbereich 1 8,60€"', modify

label define f62 7 `"9-Uhr Tageskarte Großbereich 2 5,30€"', modify
label define f62 22 `"9-Uhr Tageskarte Großbereich 1 6,70€"', modify
label define f62 8 `"Ganztageskarte Großbereich 2 6,30€"', modify
label define f62 23 `"Ganztageskarte Großbereich 1 7,70€"', modify
label define f62 10 `"9-Uhr Gruppenkarte Großbereich 2 8,95€"', modify
label define f62 25 `"9-Uhr Gruppenkarte Großbereich 1 10,35€"', modify
label define f62 11 `"Sonstige Tages-/ Gruppenkarten 2 7,20€"', modify
label define f62 26 `"Sonstige Tages-/ Gruppenkarten 1 7,20€"', modify
label define f62 12 `"3-Tage-Karte 2 15,60€"', modify
label define f62 27 `"3-Tage-Karte 1 19,80€"', modify
label define f62 13 `"Rail & Fly Ticket 2"', modify
label define f62 28 `"Rail & Fly Ticket 1"', modify
label define f62 31 `"Airport Ticket / Fluggast KombiTicket 2"', modify
label define f62 32 `"Airport Ticket / Fluggast KombiTicket 1"', modify
label define f62 14 `"Fahren & Fliegen - Fahrtberechtigung 2"', modify
label define f62 29 `"Fahren & Fliegen - Fahrtberechtigung 1"', modify
label define f62 15 `"Sonstiges 2"', modify
label define f62 30 `"Sonstiges 1"', modify

label value f62_1 f62
label value f62_2 f62


gen altersgruppe = 1 if alter<20
replace altersgruppe = 2 if alter <30 & alter >=20
replace altersgruppe = 3 if alter <40 & alter >=30
replace altersgruppe = 4 if alter <50 & alter >=40
replace altersgruppe = 5 if alter <60 & alter >=50
replace altersgruppe = 6 if alter <70 & alter >=60
replace altersgruppe = 7 if alter <80 & alter >=70
replace altersgruppe = 8 if alter <90 & alter >=80
replace altersgruppe = 9 if alter <100 & alter >=90

label define alter 1 `"< 20"', modify
label define alter 2 `"20 - 30"', modify
label define alter 3 `"30 - 40"', modify
label define alter 4 `"40 - 50"', modify
label define alter 5 `"50 - 60"', modify
label define alter 6 `"60 - 70"', modify
label define alter 7 `"70 - 80"', modify
label define alter 8 `"80 - 90"', modify
label define alter 9 `"90 - 100"', modify

label value altersgruppe alter
label var altersgruppe "Altersgruppe (10-Jahre)"

gen altersgruppe2 = 1 if alter<25
replace altersgruppe2 = 2 if alter <45 & alter >=25
replace altersgruppe2 = 3 if alter <65 & alter >=45
replace altersgruppe2 = 4 if alter <100 & alter >=65


label define alter2 1 `"< 25"', modify
label define alter2 2 `"25 - 45"', modify
label define alter2 3 `"45 - 65"', modify
label define alter2 4 `"65 - 100"', modify

label value altersgruppe2 alter2
label var altersgruppe2 "Altersgruppe 25-45-65"

gen f13_aggr = 1 if f13 ==0
replace f13_aggr = 2 if f13>0 & f13<8
replace f13_aggr = 3 if f13>7 & f13<15
replace f13_aggr = 4 if f13>14 & f13<22
replace f13_aggr = 5 if f13>21 & f13<2000

label define f13_aggr 1 `"gleicher Tag"', modify
label define f13_aggr 2 `"bis zu einer Woche"', modify
label define f13_aggr 3 `"14 Tage"', modify
label define f13_aggr 4 `"3 Wochen"', modify
label define f13_aggr 5 `"länger als 3 Wochen"', modify
label value f13_aggr f13_aggr
label var f13_aggr "Gesamtreisedauer zu Wochen zusammengefasst"

gen reise_gemeinsam = 1 if f19_1==1
replace reise_gemeinsam=2 if f19_2==2
replace reise_gemeinsam=3 if f19_2==3
replace reise_gemeinsam=4 if f19_2==4
replace reise_gemeinsam=5 if f19_2==1 & f19_3==1
replace reise_gemeinsam=6 if f19_2==1 & f19_3==2
replace reise_gemeinsam=7 if f19_2==2 & f19_3==1
replace reise_gemeinsam=8 if f19_2==2 & f19_3==2
replace reise_gemeinsam=9 if f19_2==3 & f19_3==1
replace reise_gemeinsam=10 if missing(reise_gemeinsam)

label var reise_gemeinsam "Gruppen gemeinsam Reisender"
label define reise_gemeinsam 1 `"Alleinreisend"', modify
label define reise_gemeinsam 2 `"2 Erwachsene"', modify
label define reise_gemeinsam 3 `"3 Erwachsene"', modify
label define reise_gemeinsam 4 `"4 Erwachsene"', modify
label define reise_gemeinsam 5 `"1 Erwachsener, 1 Kind"', modify
label define reise_gemeinsam 6 `"1 Erwachsener, 2 Kinder"', modify
label define reise_gemeinsam 7 `"2 Erwachsene, 1 Kind"', modify
label define reise_gemeinsam 8 `"2 Erwachsene, 2 Kinder"', modify
label define reise_gemeinsam 9 `"3 Erwachsene, 1 Kind"', modify
label define reise_gemeinsam 10 `"Sonstige"', modify

label value reise_gemeinsam reise_gemeinsam

gen reise_kind = f19_3>0
label var reise_kind "Reise mit Kind"
label define jn 1 `"Ja"', modify
label define jn 0 `"Nein"', modify
label value reise_kind jn

foreach x in "3" "7" {
replace f`x'a="23570" if f`x'a=="23750"
replace f`x'a="03050" if f`x'a=="3050"
replace f`x'a="04155" if f`x'a=="4155"
replace f`x'a="09111" if f`x'a=="9111"
replace f`x'a="01983" if f`x'a=="1983"
replace f`x'a="01139" if f`x'a=="1139"
replace f`x'a="02625" if f`x'a=="2625"
replace f`x'a="09599" if f`x'a=="9599"
replace f`x'a="07429" if f`x'a=="7429"
replace f`x'a="08396" if f`x'a=="8396"
replace f`x'a="09366" if f`x'a=="9366"
replace f`x'a="09629" if f`x'a=="9629"
replace f`x'a="0"+f`x'a if length(f`x'a)==4 & f25==14
replace f`x'a="75172" if f`x'a=="75133"
}

replace f7a="0"+f7a if length(f7a)==4 & f12==2 & destination==150 & substr(f7a, 1, 2)<"20"
replace f7a="0"+f7a if length(f7a)==4 & f12==2 & substr(f7a, 1, 1)=="4"
replace f7a="04177" if f7a=="04178"
replace f7a="0"+f7a  if f7a=="3046"
replace f7a="0"+f7a  if f7a=="2788"


merge f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH)
drop _merge
drop if  missing(lfd)
gen f3aa = f3a if length(f3a)==4
merge f3aa using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung_4steller.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH) update
drop f3aa
drop if  missing(lfd)
rename bundesland bundesland_start
rename kreis kreis_start
rename gemeinde gemeinde_start
rename Bezirke_HH Bezirke_HH_start
rename Stadtteil_HH Stadtteil_HH_start
drop _merge

merge f7a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH)
drop _merge
drop if  missing(lfd)
gen f7aa = f7a if length(f7a)==4
merge f7aa using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung_4steller.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH) update 
drop f7aa
drop if  missing(lfd)
rename bundesland bundesland_wohn
rename kreis kreis_wohn
rename gemeinde gemeinde_wohn
rename Bezirke_HH Bezirke_HH_wohn
rename Stadtteil_HH Stadtteil_HH_wohn


drop _merge
drop if  missing(lfd)

gen innerdeutsch = f9<1000
label value innerdeutsch jn

gen bundesland_zielflughafen = 4 if f9==30
replace bundesland_zielflughafen = 11 if f9==100 | f9==101
replace bundesland_zielflughafen = 9 if f9==80 | f9==90 | f9==675
replace bundesland_zielflughafen = 5 if f9==50 | f9==40
replace bundesland_zielflughafen = 14 if f9==150 | f9==140
replace bundesland_zielflughafen = 16 if f9==160 
replace bundesland_zielflughafen = 10 if f9==120
replace bundesland_zielflughafen = 6 if f9==60
replace bundesland_zielflughafen = 8 if f9==70 | f9==610 | f9==590 | f9==605
replace bundesland_zielflughafen = 1 if f9==240

label value bundesland_zielflughafen BuLa

label var bundesland_zielflughafen "Bundesland des Zielflughafens"
forvalues i=1/3 {
	quietly replace f13_`i'=0 if missing(f13_`i')
	quietly replace f24_`i'=0 if missing(f24_`i')
}

* gen f13 = f13_1 + f13_2*7 + f13_3*30
* replace f13=  reisedauer_d if f13==0 & Jahr==2009
* label var f13 "Gesamtreisedauer [d]"

gen f24_neu = f24
* replace f24_neu = f24_1 + f24_2*7 + f24_3*30 if missing(f24)
* replace f24_neu = 0.5 if f24==1
* replace f24_neu =  vorausbuchungszeit_d if f24_neu==0 & Jahr==2009

forvalues i=1/2 {
	quietly replace f32_`i'=0 if missing(f32_`i')
}

* gen f32 = f32_1*60+f32_2
* replace f32 = eintreffzeit_min if f32==0
* label var f32 "Abfahrtszeit für Abflug"

label var f24_neu "Vorausbuchungszeit Flugreise; 0,5 -> Buchungstag=Flugtag"

* replace f14= buchungsort if missing(f14)

label define f15 1 `"nur Flug"', modify
label define f15 2 `"Flug und zusätzliche Leistungen"', modify
label value f15 f15

label define f16 1 `"nur Flug"', modify
label define f16 2 `"Flug und Unterkunft (getrennt)"', modify
label define f16 3 `"Flug und sonstiges"', modify
label define f16 4 `"Flug, Unterkunft und sonstiges"', modify
label define f16 5 `"Pauschalreise"', modify
label define f16 6 `"Pauschalreise und sonstiges"', modify

label value f16 f16
label var f16 "Gebuchte Leistung für Reisetab"


gen f24_aggr = 1 if f24_neu ==0.5
replace f24_aggr = 2 if f24_neu >0.5 & f24_neu < 8
replace f24_aggr = 3 if f24_neu > 7 & f24_neu < 15
replace f24_aggr = 4 if f24_neu > 14 & f24_neu < 22
replace f24_aggr = 5 if f24_neu > 21 & f24_neu < 29
replace f24_aggr = 6 if f24_neu > 28 & f24_neu < 36
replace f24_aggr = 7 if f24_neu > 35 & f24_neu < 43
replace f24_aggr = 8 if f24_neu > 42 & f24_neu < 50
replace f24_aggr = 9 if f24_neu > 49 & f24_neu < 61
replace f24_aggr = 10 if f24_neu > 60 & f24_neu < 91
replace f24_aggr = 11 if f24_neu > 90 & f24_neu < 121
replace f24_aggr = 12 if f24_neu > 120 & f24_neu < 151
replace f24_aggr = 13 if f24_neu > 150 & f24_neu < 181
replace f24_aggr = 14 if f24_neu > 180 & f24_neu < 211
replace f24_aggr = 15 if f24_neu > 210 & f24_neu < 721

label define f24_aggr 1 `"gleicher Tag"', modify
label define f24_aggr 2 `"1 Woche"', modify
label define f24_aggr 3 `"2 Wochen"', modify
label define f24_aggr 4 `"3 Wochen"', modify
label define f24_aggr 5 `"4 Wochen"', modify
label define f24_aggr 6 `"5 Wochen"', modify
label define f24_aggr 7 `"6 Wochen"', modify
label define f24_aggr 8 `"7 Wochen"', modify
label define f24_aggr 9 `"60 Tage"', modify
label define f24_aggr 10 `"90 Tage"', modify
label define f24_aggr 11 `"120 Tage"', modify
label define f24_aggr 12 `"150 Tage"', modify
label define f24_aggr 13 `"180 Tage"', modify
label define f24_aggr 14 `"210 Tage"', modify
label define f24_aggr 15 `"mehr als 210 Tage"', modify

label value f24_aggr f24_aggr
label var f24_aggr "Flugvorausbuchungszeit"

gen f32_aggr=1 if f32<=30
replace f32_aggr = 2 if f32>30 & f32<=45
replace f32_aggr = 3 if f32>45 & f32<=60
replace f32_aggr = 4 if f32>60 & f32<=75
replace f32_aggr = 5 if f32>75 & f32<=90
replace f32_aggr = 6 if f32>90 & f32<=105
replace f32_aggr = 7 if f32>105 & f32<=120
replace f32_aggr = 8 if f32>120 & f32<=150
replace f32_aggr = 9 if f32>150 & f32<=180
replace f32_aggr = 10 if f32>180 & f32<=210
replace f32_aggr = 11 if f32>210 & f32<=240
replace f32_aggr = 12 if f32>240 & f32<=1440

label define f32_aggr 1 `"<= 30min"', modify
label define f32_aggr 2 `"]30min;45min]"', modify
label define f32_aggr 3 `"]45min;60min]"', modify
label define f32_aggr 4 `"]60min;75min]"', modify
label define f32_aggr 5 `"]75min;90min]"', modify
label define f32_aggr 6 `"]90min;105min]"', modify
label define f32_aggr 7 `"]105min;120min]"', modify
label define f32_aggr 8 `"]120min;150min]"', modify
label define f32_aggr 9 `"]150min;180min]"', modify
label define f32_aggr 10 `"]180min;210min]"', modify
label define f32_aggr 11 `"]210min;240min]"', modify
label define f32_aggr 12 `">240"', modify

label value f32_aggr f32_aggr
label var f32_aggr "Ankunftszeit am Flughafen"

gen f32_aggr2=1 if f32<=30
replace f32_aggr2 = 2 if f32>30 & f32<=60
replace f32_aggr2 = 3 if f32>60 & f32<=90
replace f32_aggr2 = 4 if f32>90 & f32<=120
replace f32_aggr2 = 5 if f32>120 & f32<=150
replace f32_aggr2 = 6 if f32>150 & f32<=180
replace f32_aggr2 = 7 if f32>180 & f32<=210
replace f32_aggr2 = 8 if f32>210 & f32<=240
replace f32_aggr2 = 9 if f32>240 & f32<=1440

label define f32_aggr2 1 `"<= 30min"', modify
label define f32_aggr2 2 `"]30min;60min]"', modify
label define f32_aggr2 3 `"]60min;90min]"', modify
label define f32_aggr2 4 `"]90min;120min]"', modify
label define f32_aggr2 5 `"]120min;150min]"', modify
label define f32_aggr2 6 `"]150min;180min]"', modify
label define f32_aggr2 7 `"]180min;210min]"', modify
label define f32_aggr2 8 `"]210min;240min]"', modify
label define f32_aggr2 9 `">240"', modify

label value f32_aggr2 f32_aggr2
label var f32_aggr2 "Ankunftszeit am Flughafen (9 Kl.)"

label var f12n "Quell-,Zielverkehr, Umsteiger"

gen VM_Zubring_0_diff = 1 if f25==1 | f25==2 | f25 ==5 | f25==6 | f25==12 | f25==16 | f25==7
replace VM_Zubring_0_diff = 2 if f25==3 | f25==4 | f25 ==29 | f25==27 | f25==28
replace VM_Zubring_0_diff = 3 if  missing(VM_Zubring_0_diff)
replace VM_Zubring_0_diff = 5 if  f25==25 | f25==23 | f25==30
replace VM_Zubring_0_diff = 6 if  f25==14
replace VM_Zubring_0_diff = 4 if f25==10 | f25==11 | f25==13

label define vm_diff 1 `"MIV-kur"', modify
label define vm_diff 2 `"MIV-lang"', modify
label define vm_diff 3 `"ÖPNV"', modify
label define vm_diff 4 `"ÖPFV"', modify
label define vm_diff 5 `"NMIV"', modify
label define vm_diff 6 `"Flug"', modify
label value VM_Zubring_0_diff vm_diff
label var VM_Zubring_0_diff "letztes Zubringerfahrzeug differenziert"

label var f32 "Ankunft am HAM vor planmäßigem Abflug"

replace flugart = 1 if charakter=="IT"
replace flugart = 2 if charakter == "LC"
replace flugart = 3 if charakter == "LI"
replace flugart = 4 if charakter == "SO"

label define flugart 1 `"Touristikverkehr"', modify
label define flugart 2 `"Low-Cost-Verkehr"', modify
label define flugart 3 `"Klassischer Linienverkehr"', modify
label define flugart 4 `"sonstiger Verkehr"', modify
label value flugart flugart
label var flugart "Charakter der Flugverbindung"


quietly label define VM_x 1  `"MIV"', modify
quietly label define VM_x 2  `"ÖV"', modify
quietly label define VM_x 3  `"kein weiteres"', modify
quietly label define VM_x 4  `"NMIV"', modify
quietly label define VM_x 5  `"Flugzeug"', modify

forvalues i=1/3 {
quietly gen VM_Zubring_x`i' = 1 if f60_`i'==1
quietly replace VM_Zubring_x`i' = 2 if f60_`i'>1 & f60_`i' < 6
quietly replace VM_Zubring_x`i' = 3 if f60_`i'> 5

quietly label value VM_Zubring_x`i' VM_x
quietly label var VM_Zubring_x`i' "zusätzliche Zubringerverkehrsart `i'"
}

gen VM_Zubring_0 = 1 if VM_Zubring_0_diff <3
replace VM_Zubring_0 = 2 if VM_Zubring_0_diff==3 | VM_Zubring_0_diff==4
replace VM_Zubring_0 = 3 if f25==25
replace VM_Zubring_0 = 4 if VM_Zubring_0_diff == 5
replace VM_Zubring_0 = 5 if VM_Zubring_0_diff == 6
label var VM_Zubring_0 "letztes Zubringerverkehrsart"
label value VM_Zubring_0 VM_x


foreach i in  "0" "x1" "x2" "x3" {
quietly gen VM_Zubring_`i'_txt = "MIV" if VM_Zubring_`i'==1
quietly replace VM_Zubring_`i'_txt = "ÖV" if VM_Zubring_`i'==2
quietly replace VM_Zubring_`i'_txt = "" if VM_Zubring_`i'==3
quietly replace VM_Zubring_`i'_txt = "NMIV" if VM_Zubring_`i'==4
quietly replace VM_Zubring_`i'_txt = "Flug" if VM_Zubring_`i'==5
}

gen VM_Kette = VM_Zubring_x2_txt + "-" + VM_Zubring_x1_txt + "-" + VM_Zubring_0_txt
replace VM_Kette = VM_Zubring_x1_txt + "-" + VM_Zubring_0_txt if missing(VM_Zubring_x2_txt)
replace VM_Kette = VM_Zubring_0_txt if missing(VM_Zubring_x2_txt) & missing(VM_Zubring_x1_txt)

label var VM_Kette "Verkettung der Verkehrsmittel zu Ankunft am HAM"

label define tag 1 `"Montag"', modify
label define tag 2 `"Dienstag"', modify
label define tag 3 `"Mittwoch"', modify
label define tag 4 `"Donnerstag"', modify
label define tag 5 `"Freitag"', modify
label define tag 6 `"Samstag"', modify
label define tag 7 `"Sonntag"', modify

label value wochentag tag

label var wochentag "Wochentag"

gen werktag = wochentag <6
label value werktag jn
label var werktag "Werktag"

label define f38_aggr 1 `"<=10"', modify
label define f38_aggr 2 `"<=20"', modify
label define f38_aggr 3 `"<=30"', modify
label define f38_aggr 4 `"<=40"', modify
label define f38_aggr 5 `"<=50"', modify
label define f38_aggr 6 `"<=60"', modify
label define f38_aggr 7 `"<=70"', modify
label define f38_aggr 8 `"<=80"', modify
label define f38_aggr 9 `"<=90"', modify

replace f38a_1=0 if missing(f38a_1) & f38a_2<300
replace f38a_2=0 if missing(f38a_2) & f38a_1<300
replace f38b_1=0 if missing(f38b_1) & f38a_1<300
replace f38b_2=0 if missing(f38b_2) & f38a_2<300


gen f38=f38a_1+f38a_2 if f38a_1<300 & f38a_2<300
gen f38_HAM=f38b_1+f38b_2 if f38b_1<300 & f38b_2<300

foreach x in "a_1" "a_2" "b_1" "b_2" "" "_HAM"{
quietly gen f38`x'_aggr = 1 if f38`x'<=10
quietly replace f38`x'_aggr = 0 if f38`x'==0
quietly replace f38`x'_aggr = 2 if f38`x'<=20 & f38`x'>10
quietly replace f38`x'_aggr = 3 if f38`x'<=30 & f38`x'>20
quietly replace f38`x'_aggr = 4 if f38`x'<=40 & f38`x'>30
quietly replace f38`x'_aggr = 5 if f38`x'<=50 & f38`x'>40
quietly replace f38`x'_aggr = 6 if f38`x'<=60 & f38`x'>50
quietly replace f38`x'_aggr = 7 if f38`x'<=70 & f38`x'>60
quietly replace f38`x'_aggr = 8 if f38`x'<=80 & f38`x'>70
quietly replace f38`x'_aggr = 9 if f38`x'<=250 & f38`x'>80
quietly gen f38`x'_vf = f38`x'>5 & f38`x'<300

quietly recode f38`x'_vf (0=.) if missing(f38`x')

label value f38`x'_aggr f38_aggr
label value f38`x'_vf jn
}

label var f38a_1_aggr "Anzahl jährlicher Geschäftsreisen (10er)"
label var f38b_1_aggr "Anzahl jährlicher Geschäftsreisen ab HAM (10er)"
label var f38a_2_aggr "Anzahl jährlicher Privatreisen (10er)"
label var f38b_2_aggr "Anzahl jährlicher Privatreisen ab HAM (10er)"
label var f38 "Anzahl Flugreisen im Jahr"
label var f38_aggr "Anzahl Flugreisen im Jahr (10er)" 
label var f38_vf "Vielflieger (>5)"

label var f38a_1_vf "Vielflieger Geschäftsreisen"
label var f38b_1_vf "Vielflieger Geschäftsreisen ab HAM"
label var f38a_2_vf "Vielflieger Privatreisen"
label var f38b_2_vf "Vielflieger Privatreisen ab HAM"

label var f38_HAM "Anzahl jährlicher Flüge ab HAM"
label var f38_HAM_aggr "Anzahl jährlicher Flüge ab HAM (10er)"
label var f38_HAM_vf "Vielflieger ab HAM"

gen f38_ant_HAM_G_ges = f38b_1/f38 if f38<300
gen f38_ant_HAM_P_ges = f38b_2/f38 if f38<300
gen f38_ant_G_ges = f38a_1/f38 if f38<300
gen f38_ant_P_ges = f38a_2/f38 if f38<300
gen f38_ant_HAM_ges = f38_HAM/f38 if f38<300

label var f38_ant_HAM_G_ges "Anteil Geschäftsreisen ab HAM zu Gesamtflugreisen"
label var f38_ant_HAM_P_ges "Anteil Privatreisen ab HAM zu Gesamtflugreisen"
label var f38_ant_G_ges "Anteil der Geschäftsreisen an jährlichen Gesamtreiseaufkommen"
label var f38_ant_P_ges "Anteil der Privatreisen an jährlichen Gesamtreiseaufkommen"
label var f38_ant_HAM_ges "Anteil der Flüge ab Hamburg zur Gesamtfluganzahl"

label define f38_ant_ges_gr4 1 `"<=.25"', modify
label define f38_ant_ges_gr4 2 `"<=.5"', modify
label define f38_ant_ges_gr4 3 `"<=.75"', modify
label define f38_ant_ges_gr4 4 `"<=1"', modify

foreach x in "HAM_G" "HAM_P" "G" "P" "HAM" {
quietly gen f38_ant_`x'_ges_gr4 = 0 if f38_ant_`x'_ges==0
quietly replace f38_ant_`x'_ges_gr4 = 1 if f38_ant_`x'_ges>0 & f38_ant_`x'_ges<=0.25
quietly replace f38_ant_`x'_ges_gr4 = 2 if f38_ant_`x'_ges>0.25 & f38_ant_`x'_ges<=0.5
quietly replace f38_ant_`x'_ges_gr4 = 3 if f38_ant_`x'_ges>0.5 & f38_ant_`x'_ges<=0.75
quietly replace f38_ant_`x'_ges_gr4 = 4 if f38_ant_`x'_ges>0.75 & f38_ant_`x'_ges<=1
label value f38_ant_`x'_ges_gr4 f38_ant_ges_gr4
}

gen zielland = 0

gen wohnland = f8_2 if f8_1==2
replace wohnland = f8_1 if missing(f8_2)
label value wohnland Ausland

gen aufbruchsland = f5_2 if f5_1==2
replace aufbruchsland = f5_1 if missing(f5_2)
label value aufbruchsland Ausland

label var wohnland "Land, in dem der PAX wohnt"
label var zielland "Land, ist Ziel der Flugreise" 
label var aufbruchsland "Land, aus dem der PAX startet" 

replace zielland = 1 if f9 < 1000
replace zielland = 30 if f9 ==1000
replace zielland = 30 if f9 ==1010
replace zielland = 30 if f9 ==1020
replace zielland = 30 if f9 ==1030
replace zielland = 30 if f9 ==1032
replace zielland = 30 if f9 ==1033
replace zielland = 33 if f9 ==1050
replace zielland = 21 if f9 ==1052
replace zielland = 33 if f9 ==1070
replace zielland = 19 if f9 ==1075
replace zielland = 8 if f9 ==1090
replace zielland = 8 if f9 ==1090
replace zielland = 9 if f9 ==1100
replace zielland = 9 if f9 ==1130
replace zielland = 9 if f9 ==1140
replace zielland = 9 if f9 ==1150
replace zielland = 9 if f9 ==1160
replace zielland = 9 if f9 ==1170
replace zielland = 9 if f9 ==1171
replace zielland = 9 if f9 ==1172
replace zielland = 9 if f9 ==1173
replace zielland = 9 if f9 ==1174
replace zielland = 9 if f9 ==1175
replace zielland = 9 if f9 ==1176
replace zielland = 9 if f9 ==1177
replace zielland = 9 if f9 ==1178
replace zielland = 9 if f9 ==1180
replace zielland = 9 if f9 ==1182
replace zielland = 9 if f9 ==1190
replace zielland = 34 if f9 ==1201
replace zielland = 34 if f9 ==1220
replace zielland = 34 if f9 ==1230
replace zielland = 34 if f9 ==1240
replace zielland = 34 if f9 ==1270
replace zielland = 34 if f9 ==1278
replace zielland = 34 if f9 ==1279
replace zielland = 34 if f9 ==1281
replace zielland = 34 if f9 ==1283
replace zielland = 34 if f9 ==1285
replace zielland = 28 if f9 ==1300
replace zielland = 28 if f9 ==1310
replace zielland = 28 if f9 ==1320
replace zielland = 28 if f9 ==1330
replace zielland = 28 if f9 ==1340
replace zielland = 28 if f9 ==1370
replace zielland = 28 if f9 ==1371
replace zielland = 28 if f9 ==1372
replace zielland = 28 if f9 ==1373
replace zielland = 28 if f9 ==1375
replace zielland = 28 if f9 ==1376
replace zielland = 28 if f9 ==1377
replace zielland = 28 if f9 ==1379
replace zielland = 28 if f9 ==1380
replace zielland = 28 if f9 ==1381
replace zielland = 28 if f9 ==1387
replace zielland = 7 if f9 ==1400
replace zielland = 7 if f9 ==1410
replace zielland = 7 if f9 ==1420
replace zielland = 12 if f9 ==1487
replace zielland = 13 if f9 ==1501
replace zielland = 13 if f9 ==1501
replace zielland = 13 if f9 ==1502
replace zielland = 13 if f9 ==1503
replace zielland = 13 if f9 ==1504
replace zielland = 13 if f9 ==1505
replace zielland = 13 if f9 ==1510
replace zielland = 13 if f9 ==1520
replace zielland = 13 if f9 ==1530
replace zielland = 13 if f9 ==1540
replace zielland = 13 if f9 ==1550
replace zielland = 13 if f9 ==1560
replace zielland = 13 if f9 ==1590
replace zielland = 13 if f9 ==1600
replace zielland = 13 if f9 ==1610
replace zielland = 13 if f9 ==1620
replace zielland = 13 if f9 ==1640
replace zielland = 13 if f9 ==1650
replace zielland = 13 if f9 ==1680
replace zielland = 13 if f9 ==1690
replace zielland = 13 if f9 ==1700
replace zielland = 13 if f9 ==1715
replace zielland = 13 if f9 ==1718
replace zielland = 13 if f9 ==1719
replace zielland = 13 if f9 ==1733
replace zielland = 13 if f9 ==1734
replace zielland = 14 if f9 ==1750
replace zielland = 14 if f9 ==1760
replace zielland = 14 if f9 ==1770
replace zielland = 15 if f9 ==1810
replace zielland = 27 if f9 ==1850
replace zielland = 27 if f9 ==1860
replace zielland = 27 if f9 ==1880
replace zielland = 4 if f9 ==1930
replace zielland = 22 if f9 ==1990
replace zielland = 10 if f9 ==2001
replace zielland = 10 if f9 ==2002
replace zielland = 10 if f9 ==2010
replace zielland = 10 if f9 ==2040
replace zielland = 10 if f9 ==2050
replace zielland = 10 if f9 ==2060
replace zielland = 10 if f9 ==2070
replace zielland = 10 if f9 ==2080
replace zielland = 10 if f9 ==2100
replace zielland = 10 if f9 ==2110
replace zielland = 10 if f9 ==2114
replace zielland = 10 if f9 ==2116
replace zielland = 10 if f9 ==2126
replace zielland = 10 if f9 ==2148
replace zielland = 10 if f9 ==2154
replace zielland = 10 if f9 ==2158
replace zielland = 10 if f9 ==2162
replace zielland = 10 if f9 ==2164
replace zielland = 10 if f9 ==2170
replace zielland = 10 if f9 ==2174
replace zielland = 10 if f9 ==2176
replace zielland = 10 if f9 ==2176
replace zielland = 10 if f9 ==2178
replace zielland = 10 if f9 ==2182
replace zielland = 38 if f9 ==2200
replace zielland = 38 if f9 ==2210
replace zielland = 38 if f9 ==2230
replace zielland = 38 if f9 ==2240
replace zielland = 38 if f9 ==2250
replace zielland = 38 if f9 ==2260
replace zielland = 38 if f9 ==2270
replace zielland = 38 if f9 ==2280
replace zielland = 38 if f9 ==2290
replace zielland = 38 if f9 ==2310
replace zielland = 38 if f9 ==2310
replace zielland = 38 if f9 ==2312
replace zielland = 38 if f9 ==2314
replace zielland = 38 if f9 ==2318
replace zielland = 38 if f9 ==2320
replace zielland = 38 if f9 ==2324
replace zielland = 38 if f9 ==2326
replace zielland = 38 if f9 ==2328
replace zielland = 38 if f9 ==2332
replace zielland = 38 if f9 ==2350
replace zielland = 38 if f9 ==2360
replace zielland = 38 if f9 ==2370
replace zielland = 38 if f9 ==2400
replace zielland = 38 if f9 ==2411
replace zielland = 38 if f9 ==2412
replace zielland = 38 if f9 ==2420
replace zielland = 38 if f9 ==2430
replace zielland = 38 if f9 ==2435
replace zielland = 31 if f9 ==2450
replace zielland = 31 if f9 ==2460
replace zielland = 31 if f9 ==2480
replace zielland = 31 if f9 ==2490
replace zielland = 31 if f9 ==2502
replace zielland = 31 if f9 ==2506
replace zielland = 31 if f9 ==2510
replace zielland = 24 if f9 ==2530
replace zielland = 35 if f9 ==2550
replace zielland = 35 if f9 ==2560
replace zielland = 35 if f9 ==2570
replace zielland = 35 if f9 ==2580
replace zielland = 35 if f9 ==2590
replace zielland = 35 if f9 ==2620
replace zielland = 35 if f9 ==2620
replace zielland = 29 if f9 ==2700
replace zielland = 29 if f9 ==2710
replace zielland = 29 if f9 ==2720
replace zielland = 29 if f9 ==2730
replace zielland = 29 if f9 ==2740
replace zielland = 29 if f9 ==2750
replace zielland = 16 if f9 ==2801
replace zielland = 16 if f9 ==2802
replace zielland = 16 if f9 ==2812
replace zielland = 16 if f9 ==2813
replace zielland = 16 if f9 ==2820
replace zielland = 16 if f9 ==2830
replace zielland = 16 if f9 ==2830
replace zielland = 16 if f9 ==2840
replace zielland = 16 if f9 ==2850
replace zielland = 16 if f9 ==2870
replace zielland = 16 if f9 ==2880
replace zielland = 16 if f9 ==2890
replace zielland = 16 if f9 ==2900
replace zielland = 16 if f9 ==2910
replace zielland = 16 if f9 ==2920
replace zielland = 16 if f9 ==2930
replace zielland = 16 if f9 ==2940
replace zielland = 16 if f9 ==2940
replace zielland = 16 if f9 ==2950
replace zielland = 16 if f9 ==2970
replace zielland = 16 if f9 ==2980
replace zielland = 16 if f9 ==2990
replace zielland = 16 if f9 ==2990
replace zielland = 16 if f9 ==3000
replace zielland = 16 if f9 ==3005
replace zielland = 16 if f9 ==3010
replace zielland = 16 if f9 ==3040
replace zielland = 11 if f9 ==3110
replace zielland = 11 if f9 ==3120
replace zielland = 11 if f9 ==3140
replace zielland = 11 if f9 ==3160
replace zielland = 11 if f9 ==3170
replace zielland = 11 if f9 ==3180
replace zielland = 11 if f9 ==3190
replace zielland = 11 if f9 ==3200
replace zielland = 11 if f9 ==3210
replace zielland = 11 if f9 ==3220
replace zielland = 11 if f9 ==3230
replace zielland = 11 if f9 ==3240
replace zielland = 11 if f9 ==3242
replace zielland = 11 if f9 ==3248
replace zielland = 11 if f9 ==3258
replace zielland = 213 if f9 ==3300
replace zielland = 213 if f9 ==3301
replace zielland = 213 if f9 ==3310
replace zielland = 213 if f9 ==3321
replace zielland = 213 if f9 ==3330
replace zielland = 213 if f9 ==3340
replace zielland = 213 if f9 ==3342
replace zielland = 213 if f9 ==3342
replace zielland = 213 if f9 ==3344
replace zielland = 213 if f9 ==3348
replace zielland = 213 if f9 ==3352
replace zielland = 213 if f9 ==3354
replace zielland = 213 if f9 ==3356
replace zielland = 213 if f9 ==3358
replace zielland = 213 if f9 ==3359
replace zielland = 213 if f9 ==3360
replace zielland = 213 if f9 ==3362
replace zielland = 213 if f9 ==3364
replace zielland = 213 if f9 ==3368
replace zielland = 46 if f9 ==3405
replace zielland = 46 if f9 ==3410
replace zielland = 46 if f9 ==3415
replace zielland = 37 if f9 ==3430
replace zielland = 18 if f9 ==3440
replace zielland = 18 if f9 ==3450
replace zielland = 18 if f9 ==3460
replace zielland = 18 if f9 ==3470
replace zielland = 18 if f9 ==3476
replace zielland = 18 if f9 ==3478
replace zielland = 17 if f9 ==3490
replace zielland = 17 if f9 ==3504
replace zielland = 17 if f9 ==3506
replace zielland = 17 if f9 ==3508
replace zielland = 5 if f9 ==3512
replace zielland = 23 if f9 ==3536
replace zielland = 41 if f9 ==3550
replace zielland = 41 if f9 ==3560
replace zielland = 41 if f9 ==3570
replace zielland = 2 if f9 ==3600
replace zielland = 39 if f9 ==3650
replace zielland = 39 if f9 ==3670
replace zielland = 36 if f9 ==3680
replace zielland = 36 if f9 ==3685
replace zielland = 32 if f9 ==3700
replace zielland = 32 if f9 ==3701
replace zielland = 32 if f9 ==3710
replace zielland = 32 if f9 ==3715
replace zielland = 32 if f9 ==3720
replace zielland = 32 if f9 ==3730
replace zielland = 32 if f9 ==3732
replace zielland = 6 if f9 ==3750
replace zielland = 6 if f9 ==3760
replace zielland = 6 if f9 ==3770
replace zielland = 33 if f9 ==3801
replace zielland = 33 if f9 ==3802
replace zielland = 33 if f9 ==3803
replace zielland = 33 if f9 ==3810
replace zielland = 33 if f9 ==3833
replace zielland = 33 if f9 ==3834
replace zielland = 33 if f9 ==3835
replace zielland = 33 if f9 ==3836
replace zielland = 33 if f9 ==3837
replace zielland = 33 if f9 ==3838
replace zielland = 33 if f9 ==3840
replace zielland = 33 if f9 ==3841
replace zielland = 33 if f9 ==3843
replace zielland = 33 if f9 ==3844
replace zielland = 33 if f9 ==3846
replace zielland = 33 if f9 ==3847
replace zielland = 33 if f9 ==3849
replace zielland = 33 if f9 ==3850
replace zielland = 33 if f9 ==3851
replace zielland = 33 if f9 ==3852
replace zielland = 33 if f9 ==3853
replace zielland = 33 if f9 ==3854
replace zielland = 33 if f9 ==3858
replace zielland = 33 if f9 ==3860
replace zielland = 25 if f9 ==3880
replace zielland = 33 if f9 ==3880
replace zielland = 33 if f9 ==3890
replace zielland = 33 if f9 ==3891
replace zielland = 33 if f9 ==3892
replace zielland = 33 if f9 ==3893
replace zielland = 33 if f9 ==3894
replace zielland = 33 if f9 ==3895
replace zielland = 40 if f9 ==3896
replace zielland = 33 if f9 ==3897
replace zielland = 202 if f9 ==3900
replace zielland = 33 if f9 ==3910
replace zielland = 33 if f9 ==3920
replace zielland = 214 if f9 ==3921
replace zielland = 229 if f9 ==3930
replace zielland = 33 if f9 ==3936
replace zielland = 33 if f9 ==3937
replace zielland = 33 if f9 ==3940
replace zielland = 33 if f9 ==3960
replace zielland = 245 if f9 ==3970
replace zielland = 162 if f9 ==4000
replace zielland = 162 if f9 ==4010
replace zielland = 162 if f9 ==4020
replace zielland = 162 if f9 ==4030
replace zielland = 162 if f9 ==4040
replace zielland = 162 if f9 ==4055
replace zielland = 162 if f9 ==4060
replace zielland = 172 if f9 ==4100
replace zielland = 187 if f9 ==4150
replace zielland = 187 if f9 ==4160
replace zielland = 187 if f9 ==4170
replace zielland = 163 if f9 ==4200
replace zielland = 163 if f9 ==4210
replace zielland = 163 if f9 ==4220
replace zielland = 173 if f9 ==4250
replace zielland = 173 if f9 ==4251
replace zielland = 173 if f9 ==4260
replace zielland = 173 if f9 ==4280
replace zielland = 173 if f9 ==4320
replace zielland = 189 if f9 ==4360
replace zielland = 198 if f9 ==4380
replace zielland = 198 if f9 ==4381
replace zielland = 198 if f9 ==4382
replace zielland = 198 if f9 ==4382
replace zielland = 179 if f9 ==4400
replace zielland = 167 if f9 ==4420
replace zielland = 190 if f9 ==4480
replace zielland = 165 if f9 ==4520
replace zielland = 194 if f9 ==4540
replace zielland = 168 if f9 ==4600
replace zielland = 185 if f9 ==4620
replace zielland = 193 if f9 ==4640
replace zielland = 177 if f9 ==4660
replace zielland = 177 if f9 ==4670
replace zielland = 177 if f9 ==4685
replace zielland = 169 if f9 ==4700
replace zielland = 196 if f9 ==4730
replace zielland = 199 if f9 ==4750
replace zielland = 192 if f9 ==4890
replace zielland = 183 if f9 ==4920
replace zielland = 217 if f9 ==4950
replace zielland = 161 if f9 ==4970
replace zielland = 161 if f9 ==4980
replace zielland = 170 if f9 ==5040
replace zielland = 170 if f9 ==5050
replace zielland = 191 if f9 ==5080
replace zielland = 195 if f9 ==5100
replace zielland = 184 if f9 ==5120
replace zielland = 184 if f9 ==5140
replace zielland = 184 if f9 ==5150
replace zielland = 178 if f9 ==5170
replace zielland = 178 if f9 ==5180
replace zielland = 180 if f9 ==5230
replace zielland = 180 if f9 ==5232
replace zielland = 180 if f9 ==5232
replace zielland = 164 if f9 ==5255
replace zielland = 176 if f9 ==5270
replace zielland = 200 if f9 ==5335
replace zielland = 197 if f9 ==5350
replace zielland = 180 if f9 ==5390
replace zielland = 197 if f9 ==5410
replace zielland = 174 if f9 ==5430
replace zielland = 182 if f9 ==5450
replace zielland = 182 if f9 ==5460
replace zielland = 182 if f9 ==5470
replace zielland = 182 if f9 ==5482
replace zielland = 182 if f9 ==5483
replace zielland = 182 if f9 ==5484
replace zielland = 101 if f9 ==5601
replace zielland = 101 if f9 ==5610
replace zielland = 101 if f9 ==5611
replace zielland = 101 if f9 ==5620
replace zielland = 101 if f9 ==5630
replace zielland = 101 if f9 ==5641
replace zielland = 101 if f9 ==5642
replace zielland = 101 if f9 ==5650
replace zielland = 101 if f9 ==5660
replace zielland = 101 if f9 ==5670
replace zielland = 101 if f9 ==5682
replace zielland = 101 if f9 ==5686
replace zielland = 101 if f9 ==5688
replace zielland = 101 if f9 ==5692
replace zielland = 101 if f9 ==5694
replace zielland = 101 if f9 ==5698
replace zielland = 101 if f9 ==5700
replace zielland = 101 if f9 ==5702
replace zielland = 101 if f9 ==5716
replace zielland = 101 if f9 ==5724
replace zielland = 102 if f9 ==5751
replace zielland = 102 if f9 ==5753
replace zielland = 102 if f9 ==5770
replace zielland = 102 if f9 ==5780
replace zielland = 102 if f9 ==5790
replace zielland = 102 if f9 ==5801
replace zielland = 102 if f9 ==5802
replace zielland = 102 if f9 ==5810
replace zielland = 102 if f9 ==5811
replace zielland = 102 if f9 ==5820
replace zielland = 102 if f9 ==5830
replace zielland = 102 if f9 ==5840
replace zielland = 102 if f9 ==5850
replace zielland = 102 if f9 ==5860
replace zielland = 102 if f9 ==5870
replace zielland = 102 if f9 ==5880
replace zielland = 102 if f9 ==5890
replace zielland = 102 if f9 ==5892
replace zielland = 102 if f9 ==5894
replace zielland = 102 if f9 ==5896
replace zielland = 102 if f9 ==5898
replace zielland = 102 if f9 ==5902
replace zielland = 102 if f9 ==5908
replace zielland = 102 if f9 ==5916
replace zielland = 102 if f9 ==5918
replace zielland = 102 if f9 ==5922
replace zielland = 102 if f9 ==5926
replace zielland = 102 if f9 ==5930
replace zielland = 102 if f9 ==5936
replace zielland = 102 if f9 ==5946
replace zielland = 102 if f9 ==5947
replace zielland = 102 if f9 ==5960
replace zielland = 102 if f9 ==5970
replace zielland = 102 if f9 ==5990
replace zielland = 102 if f9 ==6000
replace zielland = 102 if f9 ==6010
replace zielland = 102 if f9 ==6020
replace zielland = 102 if f9 ==6025
replace zielland = 102 if f9 ==6030
replace zielland = 128 if f9 ==6040
replace zielland = 102 if f9 ==6050
replace zielland = 102 if f9 ==6051
replace zielland = 102 if f9 ==6062
replace zielland = 102 if f9 ==6063
replace zielland = 102 if f9 ==6066
replace zielland = 102 if f9 ==6067
replace zielland = 102 if f9 ==6068
replace zielland = 102 if f9 ==6070
replace zielland = 102 if f9 ==6071
replace zielland = 102 if f9 ==6073
replace zielland = 102 if f9 ==6075
replace zielland = 102 if f9 ==6077
replace zielland = 102 if f9 ==6078
replace zielland = 102 if f9 ==6080
replace zielland = 102 if f9 ==6082
replace zielland = 102 if f9 ==6083
replace zielland = 16 if f9 ==6085
replace zielland = 102 if f9 ==6086
replace zielland = 102 if f9 ==6088
replace zielland = 102 if f9 ==6090
replace zielland = 102 if f9 ==6095
replace zielland = 102 if f9 ==6096
replace zielland = 102 if f9 ==6100
replace zielland = 102 if f9 ==6140
replace zielland = 102 if f9 ==6150
replace zielland = 102 if f9 ==6165
replace zielland = 102 if f9 ==6180
replace zielland = 102 if f9 ==6190
replace zielland = 102 if f9 ==6200
replace zielland = 102 if f9 ==6201
replace zielland = 102 if f9 ==6210
replace zielland = 102 if f9 ==6211
replace zielland = 102 if f9 ==6220
replace zielland = 102 if f9 ==6240
replace zielland = 102 if f9 ==6250
replace zielland = 102 if f9 ==6263
replace zielland = 102 if f9 ==6266
replace zielland = 102 if f9 ==6273
replace zielland = 102 if f9 ==6277
replace zielland = 102 if f9 ==6284
replace zielland = 102 if f9 ==6286
replace zielland = 102 if f9 ==6288
replace zielland = 102 if f9 ==6290
replace zielland = 102 if f9 ==6300
replace zielland = 102 if f9 ==6310
replace zielland = 102 if f9 ==6390
replace zielland = 102 if f9 ==6400
replace zielland = 102 if f9 ==6410
replace zielland = 102 if f9 ==6420
replace zielland = 102 if f9 ==6430
replace zielland = 102 if f9 ==6430
replace zielland = 102 if f9 ==6440
replace zielland = 102 if f9 ==6460
replace zielland = 102 if f9 ==6476
replace zielland = 102 if f9 ==6480
replace zielland = 102 if f9 ==6494
replace zielland = 102 if f9 ==6496
replace zielland = 102 if f9 ==6498
replace zielland = 102 if f9 ==6500
replace zielland = 102 if f9 ==6502
replace zielland = 102 if f9 ==6506
replace zielland = 102 if f9 ==6508
replace zielland = 102 if f9 ==6550
replace zielland = 102 if f9 ==6590
replace zielland = 102 if f9 ==6600
replace zielland = 102 if f9 ==6610
replace zielland = 102 if f9 ==6620
replace zielland = 125 if f9 ==6650
replace zielland = 125 if f9 ==6702
replace zielland = 125 if f9 ==6704
replace zielland = 125 if f9 ==6714
replace zielland = 125 if f9 ==6720
replace zielland = 120 if f9 ==6750
replace zielland = 122 if f9 ==6820
replace zielland = 118 if f9 ==6850
replace zielland = 116 if f9 ==6890
replace zielland = 127 if f9 ==6910
replace zielland = 124 if f9 ==6930
replace zielland = 124 if f9 ==6940
replace zielland = 124 if f9 ==6944
replace zielland = 124 if f9 ==6946
replace zielland = 112 if f9 ==6960
replace zielland = 113 if f9 ==6980
replace zielland = 113 if f9 ==6985
replace zielland = 123 if f9 ==7000
replace zielland = 123 if f9 ==7010
replace zielland = 117 if f9 ==7050
replace zielland = 117 if f9 ==7060
replace zielland = 117 if f9 ==7065
replace zielland = 117 if f9 ==7066
replace zielland = 112 if f9 ==7080
replace zielland = 112 if f9 ==7100
replace zielland = 114 if f9 ==7150
replace zielland = 112 if f9 ==7165
replace zielland = 129 if f9 ==7180
replace zielland = 129 if f9 ==7190
replace zielland = 129 if f9 ==7190
replace zielland = 112 if f9 ==7210
replace zielland = 148 if f9 ==7220
replace zielland = 112 if f9 ==7224
replace zielland = 147 if f9 ==7280
replace zielland = 147 if f9 ==7310
replace zielland = 147 if f9 ==7325
replace zielland = 152 if f9 ==7340
replace zielland = 152 if f9 ==7350
replace zielland = 152 if f9 ==7360
replace zielland = 153 if f9 ==7410
replace zielland = 146 if f9 ==7430
replace zielland = 143 if f9 ==7450
replace zielland = 143 if f9 ==7451
replace zielland = 143 if f9 ==7460
replace zielland = 143 if f9 ==7461
replace zielland = 143 if f9 ==7470
replace zielland = 143 if f9 ==7490
replace zielland = 143 if f9 ==7510
replace zielland = 143 if f9 ==7520
replace zielland = 143 if f9 ==7530
replace zielland = 143 if f9 ==7536
replace zielland = 143 if f9 ==7540
replace zielland = 143 if f9 ==7545
replace zielland = 145 if f9 ==7600
replace zielland = 145 if f9 ==7610
replace zielland = 150 if f9 ==7650
replace zielland = 142 if f9 ==7700
replace zielland = 142 if f9 ==7710
replace zielland = 142 if f9 ==7711
replace zielland = 149 if f9 ==7760
replace zielland = 151 if f9 ==7780
replace zielland = 151 if f9 ==7780
replace zielland = 141 if f9 ==7801
replace zielland = 141 if f9 ==7870
replace zielland = 144 if f9 ==7900
replace zielland = 144 if f9 ==7930
replace zielland = 208 if f9 ==8000
replace zielland = 205 if f9 ==8020
replace zielland = 205 if f9 ==8030
replace zielland = 207 if f9 ==8080
replace zielland = 212 if f9 ==8110
replace zielland = 212 if f9 ==8120
replace zielland = 204 if f9 ==8200
replace zielland = 204 if f9 ==8201
replace zielland = 204 if f9 ==8212
replace zielland = 204 if f9 ==8213
replace zielland = 204 if f9 ==8214
replace zielland = 204 if f9 ==8216
replace zielland = 204 if f9 ==8219
replace zielland = 215 if f9 ==8250
replace zielland = 216 if f9 ==8260
replace zielland = 210 if f9 ==8270
replace zielland = 211 if f9 ==8290
replace zielland = 211 if f9 ==8300
replace zielland = 206 if f9 ==8340
replace zielland = 209 if f9 ==8380
replace zielland = 201 if f9 ==8410
replace zielland = 201 if f9 ==8420
replace zielland = 237 if f9 ==8450
replace zielland = 237 if f9 ==8460
replace zielland = 237 if f9 ==8470
replace zielland = 247 if f9 ==8500
replace zielland = 221 if f9 ==8520
replace zielland = 225 if f9 ==8550
replace zielland = 225 if f9 ==8560
replace zielland = 225 if f9 ==8570
replace zielland = 225 if f9 ==8580
replace zielland = 225 if f9 ==8590
replace zielland = 225 if f9 ==8600
replace zielland = 225 if f9 ==8610
replace zielland = 225 if f9 ==8618
replace zielland = 225 if f9 ==8624
replace zielland = 225 if f9 ==8626
replace zielland = 225 if f9 ==8628
replace zielland = 225 if f9 ==8629
replace zielland = 236 if f9 ==8660
replace zielland = 240 if f9 ==8680
replace zielland = 234 if f9 ==8700
replace zielland = 223 if f9 ==8720
replace zielland = 244 if f9 ==8740
replace zielland = 244 if f9 ==8750
replace zielland = 244 if f9 ==8758
replace zielland = 244 if f9 ==8760
replace zielland = 244 if f9 ==8762
replace zielland = 232 if f9 ==8780
replace zielland = 228 if f9 ==8800
replace zielland = 228 if f9 ==8805
replace zielland = 246 if f9 ==8820
replace zielland = 246 if f9 ==8830
replace zielland = 233 if f9 ==8860
replace zielland = 233 if f9 ==8880
replace zielland = 224 if f9 ==8940
replace zielland = 248 if f9 ==8950
replace zielland = 226 if f9 ==8970
replace zielland = 226 if f9 ==8971
replace zielland = 226 if f9 ==8980
replace zielland = 226 if f9 ==8990
replace zielland = 226 if f9 ==8992
replace zielland = 238 if f9 ==9020
replace zielland = 238 if f9 ==9020
replace zielland = 238 if f9 ==9030
replace zielland = 238 if f9 ==9040
replace zielland = 243 if f9 ==9070
replace zielland = 243 if f9 ==9075
replace zielland = 227 if f9 ==9101
replace zielland = 227 if f9 ==9110
replace zielland = 227 if f9 ==9120
replace zielland = 227 if f9 ==9120
replace zielland = 231 if f9 ==9250
replace zielland = 231 if f9 ==9260
replace zielland = 231 if f9 ==9282
replace zielland = 231 if f9 ==9283
replace zielland = 235 if f9 ==9330
replace zielland = 224 if f9 ==9345
replace zielland = 224 if f9 ==9350
replace zielland = 224 if f9 ==9360
replace zielland = 224 if f9 ==9380
replace zielland = 224 if f9 ==9390
replace zielland = 224 if f9 ==9392
replace zielland = 224 if f9 ==9396
replace zielland = 224 if f9 ==9402
replace zielland = 224 if f9 ==9418
replace zielland = 224 if f9 ==9418
replace zielland = 224 if f9 ==9426
replace zielland = 256 if f9 ==9500
replace zielland = 256 if f9 ==9510
replace zielland = 256 if f9 ==9520
replace zielland = 256 if f9 ==9530
replace zielland = 256 if f9 ==9540
replace zielland = 256 if f9 ==9550
replace zielland = 256 if f9 ==9560
replace zielland = 256 if f9 ==9565
replace zielland = 256 if f9 ==9570
replace zielland = 256 if f9 ==9575
replace zielland = 260 if f9 ==9650
replace zielland = 260 if f9 ==9660
replace zielland = 260 if f9 ==9670
replace zielland = 131 if f9 ==9720
replace zielland = 258 if f9 ==9730
replace zielland = 130 if f9 ==9820
replace zielland = 1 if f9 ==5740
replace zielland = 1 if f9 ==9252
replace zielland = 1 if f9 ==1740
replace zielland = 4 if f9 ==3848
replace zielland = 12 if f9 ==3590
replace zielland = 13 if f9 ==6800
replace zielland = 13 if f9 ==4240
replace zielland = 11 if f9 ==3100
replace zielland = 11 if f9 ==3264
replace zielland = 21 if f9 ==1051
replace zielland = 13 if f9 ==1500
replace zielland = 16 if f9 ==2810
replace zielland = 33 if f9 ==3800
replace zielland = 13 if f9 ==7960
replace zielland = 16 if f9 ==2800
replace zielland = 34 if f9 ==1200
replace zielland = 38 if f9 ==2410
replace zielland = 33 if f9 ==3855
replace zielland = 33 if f9 ==3856
replace zielland = 163 if f9 ==8630
replace zielland = 163 if f9 ==9680
replace zielland = 175 if f9 ==1390
replace zielland = 177 if f9 ==7890
replace zielland = 177 if f9 ==9290
replace zielland = 187 if f9 ==8240
replace zielland = 188 if f9 ==6131
replace zielland = 194 if f9 ==3899
replace zielland = 197 if f9 ==5490
replace zielland = 101 if f9 ==7590
replace zielland = 101 if f9 ==7950
replace zielland = 101 if f9 ==4390
replace zielland = 101 if f9 ==3939
replace zielland = 101 if f9 ==9050
replace zielland = 101 if f9 ==7770
replace zielland = 101 if f9 ==3100
replace zielland = 101 if f9 ==3390
replace zielland = 101 if f9 ==3859
replace zielland = 101 if f9 ==5641
replace zielland = 101 if f9 ==5670
replace zielland = 101 if f9 ==5716
replace zielland = 101 if f9 ==5698
replace zielland = 101 if f9 ==5682
replace zielland = 101 if f9 ==5620
replace zielland = 101 if f9 ==5686
replace zielland = 101 if f9 ==5610
replace zielland = 101 if f9 ==5650
replace zielland = 101 if f9 ==5630
replace zielland = 101 if f9 ==5642
replace zielland = 101 if f9 ==5688
replace zielland = 101 if f9 ==5724
replace zielland = 101 if f9 ==5700
replace zielland = 101 if f9 ==5660
replace zielland = 101 if f9 ==5692
replace zielland = 101 if f9 ==5702
replace zielland = 101 if f9 ==5694
replace zielland = 101 if f9 ==5611
replace zielland = 102 if f9 ==8710
replace zielland = 102 if f9 ==5950
replace zielland = 102 if f9 ==6090
replace zielland = 102 if f9 ==6190
replace zielland = 102 if f9 ==6290
replace zielland = 102 if f9 ==6390
replace zielland = 102 if f9 ==6540
replace zielland = 102 if f9 ==6590
replace zielland = 102 if f9 ==6430
replace zielland = 102 if f9 ==5890
replace zielland = 102 if f9 ==6550
replace zielland = 102 if f9 ==5960
replace zielland = 102 if f9 ==6273
replace zielland = 102 if f9 ==5908
replace zielland = 102 if f9 ==5896
replace zielland = 102 if f9 ==6071
replace zielland = 102 if f9 ==6020
replace zielland = 102 if f9 ==5770
replace zielland = 102 if f9 ==5840
replace zielland = 102 if f9 ==5790
replace zielland = 102 if f9 ==6067
replace zielland = 102 if f9 ==6095
replace zielland = 102 if f9 ==5946
replace zielland = 102 if f9 ==6010
replace zielland = 102 if f9 ==6165
replace zielland = 102 if f9 ==5860
replace zielland = 102 if f9 ==5970
replace zielland = 102 if f9 ==5936
replace zielland = 102 if f9 ==6506
replace zielland = 102 if f9 ==5947
replace zielland = 102 if f9 ==5830
replace zielland = 102 if f9 ==6200
replace zielland = 102 if f9 ==5880
replace zielland = 102 if f9 ==5802
replace zielland = 102 if f9 ==6420
replace zielland = 102 if f9 ==6201
replace zielland = 102 if f9 ==6140
replace zielland = 102 if f9 ==5810
replace zielland = 102 if f9 ==5811
replace zielland = 102 if f9 ==6277
replace zielland = 102 if f9 ==5753
replace zielland = 102 if f9 ==6086
replace zielland = 102 if f9 ==6075
replace zielland = 102 if f9 ==5926
replace zielland = 102 if f9 ==6068
replace zielland = 102 if f9 ==6600
replace zielland = 102 if f9 ==6210
replace zielland = 102 if f9 ==6211
replace zielland = 102 if f9 ==5850
replace zielland = 102 if f9 ==5751
replace zielland = 102 if f9 ==6610
replace zielland = 102 if f9 ==6460
replace zielland = 102 if f9 ==6410
replace zielland = 102 if f9 ==6284
replace zielland = 102 if f9 ==5930
replace zielland = 102 if f9 ==6051
replace zielland = 102 if f9 ==6025
replace zielland = 102 if f9 ==6288
replace zielland = 102 if f9 ==6000
replace zielland = 102 if f9 ==6266
replace zielland = 102 if f9 ==6150
replace zielland = 102 if f9 ==6062
replace zielland = 102 if f9 ==6088
replace zielland = 102 if f9 ==6073
replace zielland = 102 if f9 ==6180
replace zielland = 102 if f9 ==6100
replace zielland = 102 if f9 ==6220
replace zielland = 102 if f9 ==6620
replace zielland = 102 if f9 ==6286
replace zielland = 102 if f9 ==6096
replace zielland = 102 if f9 ==5918
replace zielland = 102 if f9 ==6050
replace zielland = 102 if f9 ==6077
replace zielland = 102 if f9 ==6310
replace zielland = 102 if f9 ==5922
replace zielland = 102 if f9 ==5780
replace zielland = 102 if f9 ==6440
replace zielland = 102 if f9 ==5820
replace zielland = 102 if f9 ==6078
replace zielland = 102 if f9 ==5902
replace zielland = 102 if f9 ==5898
replace zielland = 102 if f9 ==6066
replace zielland = 102 if f9 ==5870
replace zielland = 102 if f9 ==6498
replace zielland = 102 if f9 ==5892
replace zielland = 102 if f9 ==6080
replace zielland = 102 if f9 ==6480
replace zielland = 102 if f9 ==6240
replace zielland = 102 if f9 ==6070
replace zielland = 102 if f9 ==6494
replace zielland = 102 if f9 ==5916
replace zielland = 102 if f9 ==6030
replace zielland = 102 if f9 ==6300
replace zielland = 102 if f9 ==6400
replace zielland = 102 if f9 ==6496
replace zielland = 102 if f9 ==6508
replace zielland = 102 if f9 ==6476
replace zielland = 102 if f9 ==6502
replace zielland = 102 if f9 ==6263
replace zielland = 102 if f9 ==5894
replace zielland = 102 if f9 ==6082
replace zielland = 102 if f9 ==5990
replace zielland = 102 if f9 ==6250
replace zielland = 102 if f9 ==6500
replace zielland = 102 if f9 ==6063
replace zielland = 102 if f9 ==6083
replace zielland = 102 if f9 ==6504
replace zielland = 102 if f9 ==5941
replace zielland = 102 if f9 ==6181
replace zielland = 102 if f9 ==5942
replace zielland = 102 if f9 ==6065
replace zielland = 102 if f9 ==6131
replace zielland = 102 if f9 ==6490
replace zielland = 102 if f9 ==5750
replace zielland = 102 if f9 ==6155
replace zielland = 102 if f9 ==5920
replace zielland = 102 if f9 ==3366
replace zielland = 102 if f9 ==6285
replace zielland = 102 if f9 ==6160
replace zielland = 102 if f9 ==6081
replace zielland = 102 if f9 ==5800
replace zielland = 101 if f9 ==5640
replace zielland = 101 if f9 ==5600
replace zielland = 143 if f9 ==9240
replace zielland = 141 if f9 ==7800
replace zielland = 213 if f9 ==3320
replace zielland = 204 if f9 ==8218
replace zielland = 244 if f9 ==8754
replace zielland = 227 if f9 ==9111
replace zielland = 224 if f9 ==9391
replace zielland = 224 if f9 ==9408
replace zielland = 227 if f9 ==9100
replace zielland = 258 if f9 ==5360
replace zielland = 213 if f9 ==3346
replace zielland = 203 if f9 ==8180
replace zielland = 231 if f9 ==9252
replace zielland = 219 if f9 ==5300
replace zielland = 162 if f9 ==4065
replace zielland = 188 if f9 ==8190
replace zielland = 244 if f9 ==8770
replace zielland = 1 if f9 ==9450




label define region 1 `"D"', modify
label define region 2 `"Europa"', modify
label define region 3 `"Afrika"', modify
label define region 4 `"Mittelamerika"', modify
label define region 5 `"Nordamerika"', modify
label define region 6 `"Südamerika"', modify
label define region 7 `"Vorderasien/Vorderer Orient"', modify
label define region 8 `"Hinterasien / Zentralasien"', modify
label define region 9 `"Ausralien / Ozeanien / Antarktis"', modify


foreach x in "ziel" "wohn" "aufbruchs" {
gen `x'region = 1 if `x'land==1
replace `x'region = 2 if `x'land > 1 & `x'land < 50
replace `x'region = 3 if (`x'land > 160 & `x'land < 201) | `x'land == 219
replace `x'region = 4 if `x'land > 110 & `x'land < 132
replace `x'region = 5 if `x'land == 101 | `x'land == 102
replace `x'region = 6 if `x'land > 140 & `x'land < 154
replace `x'region = 7 if `x'land > 200 & `x'land < 218
replace `x'region = 8 if `x'land > 220 & `x'land < 250
replace `x'region = 9 if `x'land > 255 & `x'land < 262
label value `x'region region
label value `x'land Ausland
}
label var zielregion "Endregion der Flugreise"
label var wohnregion "Region, in der der PAX lebt"
label var aufbruchsregion "Region, aus welcher der PAX startet"

* drop innerdeutsch

gen in_dt = aufbruchsregion ==1 & zielregion==1
label value in_dt jn
gen in_eu = aufbruchsregion <3 & zielregion<3
label value in_eu jn
label var in_dt "innerdeutscher Flug"
label var in_eu "innereuropäischer Flug"

gen ziel = 1 if zielregion==1
replace ziel =2 if zielregion<3 & zielregion>1
replace ziel =3 if zielregion>2

label define ziel 1 `"D"', modify
label define ziel 2 `"EU"', modify
label define ziel 3 `"außerhalb EU"', modify

label value ziel ziel
label var ziel "Ziel der Flugreise (3 Kl.)"


tab flugart, gen(flugart_)



save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG10.dta", replace
 

