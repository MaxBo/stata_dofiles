clear
set memory 700m

insheet using "C:\Spitzencluster Luftverkehr\Modell\Daten_und_Materialien\Flughafen\Passagierbefragung\historische_Passagierbefragungen\09\Fluggastbefragung09.txt"


rename sz  Streckenziel
rename datum_t Tag
rename datum_m Monat
gen Jahr = datum_j+2000
rename uhr_s Stunde
rename uhr_m Minute

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
label define Reisegrund 3 `"privat Besuch Verwandte/Bekannte"', modify
label define Reisegrund 4 `"privat aus anderem Grund"', modify

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
label var ez "Zielflughafen"
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
label value f12 f12

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

label var f16_1  "gebuchte Leistungen"
label define f16_1 1 `"Flug + Unterkunft zusammen"', modify
label define f16_1 2 `"Flug + Unterkunft getrennt"', modify
label define f16_1 3 `"anderes zusätzliches gebucht"', modify
label var f16_2  "gebuchte Leistungen - Zusatz"
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
label var f21_1 "Preis für Pauschalreise"
label var f21_2 "Ticketpreis"
label var f22 "Ticketart"
label define f22 1 `"Hin- und Rückflug"', modify
label define f22 2 `"One-way-ticket"', modify
label value f22 f22

label var f23 "Sondertarife"
recode f23 (10=19) 
label define f23 1 `"Normaltarif"', modify
label define f23 2 `"Vielfliegerprogramm"', modify
label define f23 3 `"PAD Sondertarif"', modify
label define f23 4 `"Last Minute"', modify
label define f23 5 `"Frühbucherrabatt"', modify
label define f23 6 `"unbekannt"', modify
label define f23 18 `"Sonstiges"', modify
label define f23 7 `"Sondertarif allg./Multispezial / Jubiläumstarif / Rabattgewinn Penny / BSW-Angebot / tagsüber / Hagebau Partner Card"', modify
label define f23 8 `"Firmentarif"', modify
label define f23 9 `"Sondertarif 14/10 - 7/5 "', modify
label define f23 19 `"Langzeitsondertarif"', modify
label define f23 11 `"Studenten-/ Schüler-/ Senioren-/ Jugend-Tarif"', modify
label define f23 12 `"Gruppenreise"', modify
label define f23 13 `"Messerabatt"', modify
label define f23 14 `"Seemannsticket"', modify
label define f23 15 `"Journalistenrabatt / Pressetarif"', modify
label define f23 16 `"Sonderaktion Lidl / SPAR Angebot / Aldi "', modify
label define f23 33 `"Cross-Ticket"', modify
label define f23 19 `"Gabelflug"', modify
label define f23 20 `"Vivador"', modify
label define f23 21 `"Flex"', modify
label define f23 22 `"Special Action 50% / Special offer LH"', modify
label define f23 25 `"Angestelltentarif"', modify
label define f23 26 `"Bonus bei Zeitungsabo"', modify
label define f23 23 `"zwei für eins"', modify
label define f23 24 `"Flug bezahlt / Aufenthalt geschenkt"', modify
label define f23 27 `"Schnupperangebot"', modify
label define f23 28 `"Jubiläumsrabatt, z.B. 10 J L-tur"', modify
label define f23 29 `"Jubiläumsrabatt, z.B. 10 J L-tur"', modify
label define f23 30 `"Internetrabatt"', modify
label define f23 31 `"Angebot der Woche"', modify
label define f23 32 `"150-€-Rabatt"', modify

label value f23 f23

label var f24 "Flugtag = Flugbuchungstag"
label var f24_1 "Flugbuchung vor ... Tagen"
label var f24_2 "Flugbuchung vor ... Wochen"
label var f24_3 "Flugbuchung vor ... Monaten"

label var f25 "letztes Verkehrsmittel vor Ankunft am Flughafen"
recode f25(34=24) (30=31) (27=30) (26=29) (24=25) (25=26) (15=14) (14=13) (13=12) (12=11) (8=7) (9=20) (7=16)
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

label var f32_1 "Aufbruch von Startort vor planmäßigen Abflug - Stunden"
label var f32_2 "Aufbruch von Startort vor planmäßigen Abflug - Minuten"

label var f38a_1 "Anzahl jährlicher Flugreisen - geschäftlich"
label var f38b_1 "Anzahl jährlicher Flugreisen ab HAM - geschäftlich"
label var f38a_2 "Anzahl jährlicher Flugreisen - privat"
label var f38b_2 "Anzahl jährlicher Flugreisen ab HAM - privat"

* label define f39 6 `"München"', modify
* label define f39 7 `"Frankfurt"', modify
* label define f39 8 `"Düsseldorf"', modify
* label define f39 9 `"Kopenhagen"', modify
* label define f39 10 `"Dresden"', modify
* label define f39 11 `"Billund"', modify
* label define f39 12 `"Rostock"', modify
* label define f39 13 `"andere: Zürich / Paris / Stuttgart / Wien / Malaga / Linz / Amsterdam"', modify
* label define f39 14 `"Dortmund"', modify
* label define f39 15 `"Köln/Bonn"', modify
* label define f39 16 `"Paderborn"', modify
* label define f39 17 `"Finkenwerder"', modify

* forvalues i=1/4 {
*  label var f39_`i' "anderer Flughafen `i'"
*  label var f39b_`i' "anderer Flughafen `i'"
*  label value f39_`i' f39
* }

label var f39_1 "Q: Anzahl Flüge im Jahr ab Bremen"
label var f39_2 "Q: Anzahl Flüge im Jahr ab Münster/Osnabrück"
label var f39_3 "Q: Anzahl Flüge im Jahr ab Lübeck"
label var f39_4 "Q: Anzahl Flüge im Jahr ab Hannover"
label var f39_5 "Q: Anzahl Flüge im Jahr ab Berlin"
label var f39_6 "Q: Anzahl Flüge im Jahr ab Frankfurt am Main (FRA)"
label var f39_7 "Q: Anzahl Flüge im Jahr ab Düsseldorf"

label var f39b_1 "Z: Anzahl Flüge im Jahr ab Bremen"
label var f39b_2 "Z: Anzahl Flüge im Jahr ab Münster/Osnabrück"
label var f39b_3 "Z: Anzahl Flüge im Jahr ab Lübeck"
label var f39b_4 "Z: Anzahl Flüge im Jahr ab Hannover"
label var f39b_5 "Z: Anzahl Flüge im Jahr ab Berlin"
label var f39b_8 "Z: Anzahl Flüge im Jahr ab HAM"


* label var f40 "Quell-/Zielverkehr"
* label value f40 f12

* label var f40a_1 "Flüge nach FRA - Anzahl Flüge im Jahr"
* label var f40a_2 "Flüge nach FRA - Anzahl Bahnfahrten im Jahr"
* label var f40a_3 "Flüge nach FRA - Anzahl Kfz im Jahr"
* label var f40a_4 "FRA nie Ziel"
* label var f40b_1 "Flüge nach DUS - Anzahl Flüge im Jahr"
* label var f40b_2 "Flüge nach DUS - Anzahl Bahnfahrten im Jahr"
* label var f40b_3 "Flüge nach DUS - Anzahl Kfz im Jahr"
* label var f40b_4 "DUS nie Ziel"

* label var f41 "Zufriedenheit mit Direktflugangebot"
* label define f41 1 `"gerade richtig"', modify
* label define f41 2 `"eher zu gering"', modify
* label define f41 3 `"viel zu gering"', modify
* label value f41 f41

* forvalues i=1/5 {
*  label var f42_`i' "fehlendes Ziel `i'"
* }
label var f46 "Nicht Mitglied in Vielfliegerprogramm"
label value f46 f28

label define f48 1  `"Verkehr"', modify
label define f48 2  `"Übersichtlichkeit"', modify
label define f48 3  `"Informationsmöglichkeiten"', modify
label define f48 4  `"Wartezeiten bei Abfertigung"', modify
label define f48 5  `"Sauberkeit"', modify
label define f48 6  `"Sicherheit"', modify
label define f48 7  `"Freundlichkeit Angestellter FH"', modify
label define f48 8  `"Ambiente"', modify
label define f48 9  `"Gastronomie"', modify
label define f48 10  `"Shopping"', modify
label define f48 11  `"Anderes / Sanitäranlangen"', modify


forvalues i=1/3 {
 label var f48_`i' "wichtiges Merkmal des Flughafens `i'"
 label value f48_`i' f48
}

* label var f49_4 "Beurteilung verkehrsgünstige Lage HAM (Schulnoten 1-5)"

label var alter "Alter"
label var staat_1  "deutsch"
label var staat_2  "andere"
label value staat_2 Ausland

label var f52 "Beschäftigungsart"
label define f52 1  `"Selbständige / Freie Berufe"', modify
label define f52 2  `"Leitende Angestellte"', modify
label define f52 3  `"Sonstige Angestellte / Beamte"', modify
label define f52 4  `"Facharbeiter / nicht selbständige Handwerker"', modify
label define f52 5  `"Sonstige Arbeiter"', modify
label define f52 6  `"Landwirt / m.u.o. Hochschulreife"', modify
label define f52 7  `"Schüler / Student / Azubi / Zivil- o. Wehrdienstleistender"', modify
label define f52 8  `"Hausfrau /-mann"', modify
label define f52 9  `"Nicht mehr berufstätig / arbeitslos / Rentner"', modify
label value f52 f52

* label var f53 "Haushaltsnettoeinkommen"
* label define f53 1  `"< 750 €"', modify
* label define f53 2  `"750 - 1250"', modify
* label define f53 3  `"1250 - 2000"', modify
* label define f53 4  `"2000 - 2500"', modify
* label define f53 5  `"2500 - 3000"', modify
* label define f53 6  `"3000<"', modify
* label value f53 f53

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

label var f62 "genutzter Fahrausweis"
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

label value f62 f62

label var f63 "Unternehmen"
recode f63(899=871) (1398=613) (998=29) (1066=29) (447=48) (1175=48) (739=48) (74=48) (1321=518) (1249=1215) (1356=1355) (1160=60) (905=841) (604=5) (1003=354) (71=16) (371=16) (635=16) (659=16) (909=741)  
* Studi Rest umcodieren lassen, so dass gleiche Unternehmen zusammengefasst + Branchendatei

label define f63 1311 `"A & C "', modify
label define f63 1107 `"A & O "', modify
label define f63 641 `"Aachen Münchener"', modify
label define f63 639 `"AAK Hull"', modify
label define f63 1436 `"ABM – Amro"', modify
label define f63 899 `"Accentur"', modify
label define f63 871 `"Accenture"', modify
label define f63 156 `"Accor"', modify
label define f63 865 `"acer"', modify
label define f63 303 `"Aceto"', modify
label define f63 520 `"Ackermann"', modify
label define f63 1360 `"Actemium"', modify
label define f63 1232 `"Adidas"', modify
label define f63 238 `"Adler Vertriebs GmbH"', modify
label define f63 690 `"Advokat"', modify
label define f63 703 `"AEG"', modify
label define f63 1331 `"Aerotec"', modify
label define f63 422 `"Agentur für Arbeit"', modify
label define f63 95 `"Ahlmann  ACO"', modify
label define f63 482 `"Aida Cruising"', modify
label define f63 553 `"Air Berlin"', modify
label define f63 987 `"Air Industrie"', modify
label define f63 667 `"Air Transport  IATA"', modify
label define f63 11 `"Airbus"', modify
label define f63 272 `"Airbus"', modify
label define f63 492 `"Airbus"', modify
label define f63 77 `"AKDB"', modify
label define f63 242 `"Akenur"', modify
label define f63 1233 `"AL-A LTD"', modify
label define f63 832 `"Albert Schweitzer Inst."', modify
label define f63 1326 `"ALD"', modify
label define f63 353 `"Aldi "', modify
label define f63 31 `"Alfons H."', modify
label define f63 1295 `"Alfons Köster"', modify
label define f63 968 `"Allg. Unfallversicherung"', modify
label define f63 9 `"Allianz"', modify
label define f63 631 `"Allins & Morrison"', modify
label define f63 377 `"Alltours"', modify
label define f63 956 `"Alpha Laser"', modify
label define f63 1257 `"Alpia"', modify
label define f63 26 `"Alstertouristik"', modify
label define f63 923 `"Alter Meierhof"', modify
label define f63 584 `"Aluminium Oxid"', modify
label define f63 1040 `"Aluminiumwerk Finkenwerder"', modify
label define f63 1217 `"Amila"', modify
label define f63 654 `"AMS"', modify
label define f63 103 `"Amuseral Kunsstofftransportbänder"', modify
label define f63 1013 `"Andreas Stihl AG & Co KG"', modify
label define f63 1008 `"Andritz Hydro"', modify
label define f63 1069 `"Angermann"', modify
label define f63 13 `"Anwaltskanzlei"', modify
label define f63 451 `"AOK "', modify
label define f63 561 `"AON"', modify
label define f63 1314 `"APM Global"', modify
label define f63 1162 `"Apollo"', modify
label define f63 1096 `"Arag"', modify
label define f63 538 `"Aral"', modify
label define f63 1256 `"Arbeit und Mehr"', modify
label define f63 825 `"Arcelor/ Metall"', modify
label define f63 1336 `"Architektbüro Gem"', modify
label define f63 1339 `"Arcoma"', modify
label define f63 613 `"ARD"', modify
label define f63 1398 `"ARD / ZDF"', modify
label define f63 542 `"Arena Sponsoring"', modify
label define f63 1079 `"Arkwright"', modify
label define f63 29 `"Armee"', modify
label define f63 998 `"Armee"', modify
label define f63 1066 `"Armee"', modify
label define f63 712 `"Armee US"', modify
label define f63 548 `"Arsenal Research"', modify
label define f63 830 `"Ärztekammer"', modify
label define f63 48 `"Arztpraxis"', modify
label define f63 447 `"Arztpraxis"', modify
label define f63 1175 `"Arztpraxis "', modify
label define f63 739 `"Arztpraxis HNO"', modify
label define f63 75 `"Arztpraxis Kardiologe"', modify
label define f63 1080 `"ASB Arbeiter Samariter Bund"', modify
label define f63 1193 `"ASC Alster ShippingCharting"', modify
label define f63 579 `"Askland"', modify
label define f63 3 `"Asklepius Krankenhaus"', modify
label define f63 632 `"Aspen -Re - Europe"', modify
label define f63 22 `"Astra Zeneca"', modify
label define f63 1073 `"Atlantik Multibauer"', modify
label define f63 453 `"ATLAPA"', modify
label define f63 381 `"Audi"', modify
label define f63 421 `"Augustinus"', modify
label define f63 413 `"Aurubis /Nordd. Affenerie"', modify
label define f63 953 `"Auswärtiges Amt"', modify
label define f63 10 `"Autobahnmeisterei"', modify
label define f63 350 `"Autohaus Evers"', modify
label define f63 512 `"Autohaus Nissan"', modify
label define f63 1192 `"Autokraft"', modify
label define f63 528 `"AV - Net"', modify
label define f63 444 `"Avant techo"', modify
label define f63 1170 `"Avanti"', modify
label define f63 775 `"AVL  Zöllner"', modify
label define f63 107 `"AVODAQ"', modify
label define f63 414 `"Avon "', modify
label define f63 130 `"AXA"', modify
label define f63 709 `"Axel Springer"', modify
label define f63 270 `"B& S Card Service"', modify
label define f63 856 `"BA  Arbeitsamt"', modify
label define f63 822 `"Baby Basket GmbH"', modify
label define f63 1221 `"Bacardi"', modify
label define f63 443 `"Balance of Power"', modify
label define f63 850 `"Barmer"', modify
label define f63 946 `"Bartec"', modify
label define f63 1198 `"BASF"', modify
label define f63 6 `"Basler "', modify
label define f63 146 `"BAT"', modify
label define f63 885/989 `"Bauamt"', modify
label define f63 989 `"Baubranche/ Bauamt"', modify
label define f63 707 `"Bauer"', modify
label define f63 1024 `"Bauer Frischdienst"', modify
label define f63 111 `"Bauer Verlag"', modify
label define f63 1188 `"Bauhof"', modify
label define f63 967 `"Baumit"', modify
label define f63 1196 `"Bauträger HH"', modify
label define f63 1088 `"Bayern Chemie"', modify
label define f63 496 `"Bayern LB"', modify
label define f63 457 `"Bayrische Eisenbahn Ges. Wirtschaftsministerium"', modify
label define f63 291 `"Bayrischer Rundfunk"', modify
label define f63 102 `"BCD Travel"', modify
label define f63 1058 `"BCD Travel GmbH Deutschland."', modify
label define f63 609 `"Beaform & Tronic BTT"', modify
label define f63 1330 `"Bearing"', modify
label define f63 320 `"Bedford "', modify
label define f63 940 `"Behörde"', modify
label define f63 459 `"Behrenberg "', modify
label define f63 176 `"Beiersdorf"', modify
label define f63 675 `"Beiersdorf TESA"', modify
label define f63 1202 `"Belandris"', modify
label define f63 30 `"Belfinger & Berger"', modify
label define f63 710 `"Berger"', modify
label define f63 1388 `"Bergwald Flower"', modify
label define f63 247 `"Bertelsmann"', modify
label define f63 123 `"Berufsfeuerwehr HH"', modify
label define f63 466 `"Berufsgenossenschaft"', modify
label define f63 1006 `"Berufsschule"', modify
label define f63 1174 `"Berufsschule"', modify
label define f63 759 `"Best Western Hotel"', modify
label define f63 925 `"Beutler"', modify
label define f63 1043 `"Bezirksamt"', modify
label define f63 839 `"BFL Linsenhofen"', modify
label define f63 439 `"Big Dutchman"', modify
label define f63 761 `"Biobrotladen"', modify
label define f63 1416 `"Biotronik AG"', modify
label define f63 1309 `"BIT Service GmbH"', modify
label define f63 12 `"Blohm & Voss"', modify
label define f63 1433 `"Blumenkamp Alsterresidenz"', modify
label define f63 723 `"BMA "', modify
label define f63 717 `"BMI Bundesministerium Inneres"', modify
label define f63 246 `"BMW"', modify
label define f63 67 `"Bockwolt"', modify
label define f63 1357 `"Bogdehl"', modify
label define f63 27 `"Boing"', modify
label define f63 625 `"Bolze Groupe"', modify
label define f63 1316 `"BOOS"', modify
label define f63 555 `"Borschein & Söhrensen"', modify
label define f63 820 `"Bosch"', modify
label define f63 791 `"Boskoles"', modify
label define f63 153 `"BP"', modify
label define f63 1372 `"Brainjoin"', modify
label define f63 253 `"Brandplattforum "', modify
label define f63 971 `"Brankmann & Damm"', modify
label define f63 966 `"BRK Altenpflege"', modify
label define f63 1342 `"BRK Bayrisches Rotes Kreuz"', modify
label define f63 268 `"BSH Bundesamt Seeschifffahrt.."', modify
label define f63 298 `"BSN"', modify
label define f63 1180 `"Budde Heinrich und Partner"', modify
label define f63 376 `"BUKH"', modify
label define f63 1358 `"Bullerei"', modify
label define f63 1094 `"Bundesrepublik Deutschland"', modify
label define f63 1184 `"Bundesverwaltung"', modify
label define f63 37 `"Bundeswehr"', modify
label define f63 452 `"Bundeswehrkrankenhaus"', modify
label define f63 600 `"Burda"', modify
label define f63 117 `"Burgmanns Industrie"', modify
label define f63 1194 `"Buxonderbot"', modify
label define f63 563 `"BVG Berufsgenossenschaft"', modify
label define f63 7 `"C & A "', modify
label define f63 518 `"Cap Gemini"', modify
label define f63 1321 `"Capgeminie"', modify
label define f63 1057 `"Cappus"', modify
label define f63 1237 `"Cargill  "', modify
label define f63 446 `"Caritas"', modify
label define f63 678 `"Casa Verde"', modify
label define f63 601 `"Casio Europe"', modify
label define f63 1382 `"Cathay Pacific"', modify
label define f63 847 `"Celle"', modify
label define f63 1000 `"Cenkoo GmbH"', modify
label define f63 137 `"Central Park"', modify
label define f63 231 `"Chama"', modify
label define f63 1275 `"CHG"', modify
label define f63 251 `"Chirurgische Klinik Stuttgart"', modify
label define f63 774 `"Christian Fischbauer"', modify
label define f63 1279 `"Christl & Schuhwalter"', modify
label define f63 1349 `"CHV"', modify
label define f63 1353 `"CIB "', modify
label define f63 1067 `"Ciber"', modify
label define f63 1151 `"Cinst AG"', modify
label define f63 1413 `"Citroen"', modify
label define f63 571 `"City Bank"', modify
label define f63 359 `"City Markt"', modify
label define f63 1410 `"Civko"', modify
label define f63 843 `"Clairence"', modify
label define f63 629 `"Clasen "', modify
label define f63 73 `"CNC"', modify
label define f63 1153 `"Coca Cola"', modify
label define f63 580 `"Colgate / Palmolive"', modify
label define f63 96 `"Colt Telekom"', modify
label define f63 63 `"COM Direkt Bank"', modify
label define f63 1227 `"Commerzbank"', modify
label define f63 1031 `"Comnivest"', modify
label define f63 880 `"Computercounter"', modify
label define f63 1119 `"Condor "', modify
label define f63 943 `"Condurum"', modify
label define f63 56 `"Confratercität"', modify
label define f63 924 `"Conktec"', modify
label define f63 1430 `"Conoco Philips"', modify
label define f63 784 `"Conrad"', modify
label define f63 554 `"Consolis"', modify
label define f63 462 `"Consulting"', modify
label define f63 183 `"Continental"', modify
label define f63 1015 `"Cornway  GmbH"', modify
label define f63 257 `"CORSO "', modify
label define f63 1290 `"Costa Kreutzfahrt"', modify
label define f63 855 `"CP Kelco Germany GmbH"', modify
label define f63 715 `"CPI"', modify
label define f63 588 `"Cpkelco"', modify
label define f63 586 `"CPO"', modify
label define f63 369 `"CPS Color"', modify
label define f63 738 `"Crusius"', modify
label define f63 903 `"CSC"', modify
label define f63 616 `"CWT"', modify
label define f63 569 `"Daimler / Benz AG"', modify
label define f63 49 `"Daimler /Mercedes "', modify
label define f63 1101 `"DAK"', modify
label define f63 1083 `"Dana "', modify
label define f63 1379 `"Dänische Staatsbahn"', modify
label define f63 593 `"Danske Bank"', modify
label define f63 283 `"Dat Backhus"', modify
label define f63 1209 `"DB Schenker"', modify
label define f63 937 `"DC Antarctica"', modify
label define f63 926 `"Decathlon"', modify
label define f63 533 `"Degrat "', modify
label define f63 1241 `"Deichmann"', modify
label define f63 405 `"DEKRA"', modify
label define f63 136 `"Dekuna Touristik"', modify
label define f63 1114 `"Delavat"', modify
label define f63 988 `"Delius Clasing"', modify
label define f63 1306 `"Deloitte & Touch"', modify
label define f63 630 `"Design Agentur"', modify
label define f63 692 `"Desy"', modify
label define f63 718 `"Deutsche Bahn"', modify
label define f63 1035 `"Deutsche Botschaft"', modify
label define f63 88 `"Deutsche Post"', modify
label define f63 1426 `"Deutsche Rentenversicherung"', modify
label define f63 87 `"Deutsche Telekom"', modify
label define f63 1105 `"Deutsche Zentrale f Tourismus"', modify
label define f63 1037 `"Deutsches Hilfswerk"', modify
label define f63 278 `"Deutsches Rotes Kreuz"', modify
label define f63 429 `"Dexiana"', modify
label define f63 167 `"DFDS"', modify
label define f63 236 `"DHL  Post"', modify
label define f63 467 `"Diakonie"', modify
label define f63 124 `"Diakonisches Krankenhaus"', modify
label define f63 210 `"Die Zeit"', modify
label define f63 1068 `"Diehl Airtubienen"', modify
label define f63 1210 `"Diek & Schell Coburg"', modify
label define f63 141 `"Dietmar Linde & Söhne"', modify
label define f63 1033 `"Dillinger"', modify
label define f63 501 `"DJG München"', modify
label define f63 536 `"DLRG"', modify
label define f63 1077 `"DLS"', modify
label define f63 868 `"DMP"', modify
label define f63 233 `"DNS"', modify
label define f63 869 `"Donaseminare"', modify
label define f63 351 `"Doni Haste Vesta"', modify
label define f63 543 `"Donicusa"', modify
label define f63 53 `"Dörfner"', modify
label define f63 835 `"Douglas"', modify
label define f63 777 `"DPD"', modify
label define f63 1287 `"DPV Deutscher Presse Verlag"', modify
label define f63 973 `"Dr. Beckmann"', modify
label define f63 1014 `"Dr. Kleinfeld  CEC"', modify
label define f63 982 `"Dr. Riedlinger& Partner"', modify
label define f63 530 `"Dr. Scheller "', modify
label define f63 1260 `"Dragenspharma"', modify
label define f63 269 `"Dräger"', modify
label define f63 754 `"Dräger"', modify
label define f63 131 `"Dresdner Bank"', modify
label define f63 1424 `"Drom"', modify
label define f63 1084 `"Dukas"', modify
label define f63 1369 `"Dumrarth & Fassnacht"', modify
label define f63 688 `"Dunlop-Hilfer"', modify
label define f63 790 `"Durag"', modify
label define f63 1392 `"E.R. Schifffahrt GmbH & Cie"', modify
label define f63 1222 `"e3"', modify
label define f63 112 `"EAE"', modify
label define f63 950 `"ECCO"', modify
label define f63 265 `"ECH Will"', modify
label define f63 252 `"Edeka "', modify
label define f63 1435 `"Edelmann"', modify
label define f63 450 `"EDS"', modify
label define f63 1176 `"Ehren von"', modify
label define f63 1171 `"Einwohnermeldeamt"', modify
label define f63 1347 `"Elbe Werkstätten"', modify
label define f63 36 `"Elektr.- Meier"', modify
label define f63 193 `"Eletrobnas"', modify
label define f63 700 `"Ellopack"', modify
label define f63 250 `"ELTEL"', modify
label define f63 224 `"EMF"', modify
label define f63 1273 `"EMH"', modify
label define f63 974 `"Enercom "', modify
label define f63 356 `"Engel & Völkers"', modify
label define f63 194 `"EON"', modify
label define f63 1206 `"Erbo"', modify
label define f63 399 `"E-real -Zander GmbH"', modify
label define f63 782 `"Ergo Konzern"', modify
label define f63 1215 `"Erik Stahlkamp GmbH"', modify
label define f63 1249 `"Erik Stahlkamp GmbH"', modify
label define f63 1161 `"Ernst & Joung"', modify
label define f63 1421 `"ESKA  GmbH"', modify
label define f63 1038 `"ESRF"', modify
label define f63 234 `"Esso Deutschland"', modify
label define f63 1341 `"ESW"', modify
label define f63 662 `"EU"', modify
label define f63 448 `"Euler & Hermes "', modify
label define f63 454 `"Euler & Hermes "', modify
label define f63 788 `"Eurobus"', modify
label define f63 240 `"Eurogate"', modify
label define f63 1001 `"Europäische Kommission"', modify
label define f63 1116 `"Europäische Wirtschaftverband Bier"', modify
label define f63 1367 `"Europäisches Patentamt"', modify
label define f63 673 `"Europarat "', modify
label define f63 622 `"Europcar"', modify
label define f63 547 `"EVB  Reisebüro"', modify
label define f63 610 `"Eviatek"', modify
label define f63 857 `"Expediance"', modify
label define f63 190 `"Experiens "', modify
label define f63 1190 `"Expert"', modify
label define f63 42 `"EZKB"', modify
label define f63 1078 `"F.A.Cesar"', modify
label define f63 698 `"Famila"', modify
label define f63 340 `"Fanzilotel"', modify
label define f63 615 `"Feige Abfülltechnik"', modify
label define f63 816 `"Felsenkeller"', modify
label define f63 863 `"Fendt Caravan"', modify
label define f63 789 `"Ferdinand Holzmann"', modify
label define f63 889 `"Fette"', modify
label define f63 310 `"FHH"', modify
label define f63 720 `"FHS"', modify
label define f63 936 `"Fielmann"', modify
label define f63 514 `"Fielmann Optik"', modify
label define f63 35 `"Finanzamt"', modify
label define f63 1200 `"FIS"', modify
label define f63 127 `"Fisch Bruhn"', modify
label define f63 958 `"Fischereihafenrestaurant"', modify
label define f63 222 `"FJA"', modify
label define f63 1391 `"Flensburger Schiffbaugesellschaft mbH & Co KG"', modify
label define f63 1126 `"Flind Grube"', modify
label define f63 908 `"Fluela"', modify
label define f63 725 `"Flughafen Düsseldorf"', modify
label define f63 1425 `"Flughafen München"', modify
label define f63 235 `"FML Aviation"', modify
label define f63 780 `"Fonar"', modify
label define f63 1269 `"Forschungszentrum Jülich"', modify
label define f63 669 `"Frame Texx"', modify
label define f63 896 `"Franz Tölke"', modify
label define f63 742 `"Free Energie"', modify
label define f63 1434 `"Frequenz"', modify
label define f63 570 `"Freudenberg"', modify
label define f63 893 `"Freudenburg"', modify
label define f63 842 `"Fricopan Back GmbH"', modify
label define f63 1250 `"G & H "', modify
label define f63 558 `"Galerie"', modify
label define f63 786 `"Gastroback"', modify
label define f63 821 `"GBT GmbH"', modify
label define f63 763 `"Geb. Oskar"', modify
label define f63 756 `"Gebr. Heinemann"', modify
label define f63 1319 `"Gen EI"', modify
label define f63 1282 `"General Dynenecs"', modify
label define f63 119 `"Generali"', modify
label define f63 1307 `"Generall Elektric"', modify
label define f63 428 `"Genossenschaft. Volksbank"', modify
label define f63 776 `"Genzunec"', modify
label define f63 1387 `"Gericht"', modify
label define f63 304 `"Germ. Lloyd"', modify
label define f63 656 `"German Wings"', modify
label define f63 315 `"Gerry Weber"', modify
label define f63 859 `"Gesamtverband Versicherungen HH"', modify
label define f63 200 `"GFA"', modify
label define f63 1028 `"GFI"', modify
label define f63 66 `"GFK"', modify
label define f63 1395 `"GFP"', modify
label define f63 1120 `"Gladigau"', modify
label define f63 314 `"Global Knowhedge"', modify
label define f63 433 `"Gloria Theater"', modify
label define f63 837 `"Glosser "', modify
label define f63 1169 `"GmsH"', modify
label define f63 1355 `"Go Yellow Media AG"', modify
label define f63 1356 `"go Yellow Media AG"', modify
label define f63 1318 `"Godeland"', modify
label define f63 814 `"Golfino"', modify
label define f63 525 `"Göning Public"', modify
label define f63 753 `"Google"', modify
label define f63 384 `"Gothaer"', modify
label define f63 1148 `"great media"', modify
label define f63 970 `"Grey"', modify
label define f63 760 `"Griesser"', modify
label define f63 1298 `"Grothe GmbH"', modify
label define f63 1385 `"Grundfos"', modify
label define f63 82 `"Gruner & Jahr"', modify
label define f63 706 `"GSK   Aspen"', modify
label define f63 378 `"GTU"', modify
label define f63 980 `"Günther"', modify
label define f63 526 `"Günther Holding"', modify
label define f63 1327 `"GUS"', modify
label define f63 223 `"H & C "', modify
label define f63 1351 `"H & J Brüggen"', modify
label define f63 189 `"H & M "', modify
label define f63 651 `"H & S "', modify
label define f63 389 `"H.P. Marketing Consulting"', modify
label define f63 297 `"Haase"', modify
label define f63 731 `"Hafen City UNI"', modify
label define f63 682 `"Hafen HH"', modify
label define f63 196 `"Haferkamp "', modify
label define f63 1122 `"Hagemann"', modify
label define f63 680 `"Hagennh Marine Kane"', modify
label define f63 1111 `"Hako Werke"', modify
label define f63 770 `"HALA"', modify
label define f63 719 `"Hambaumen"', modify
label define f63 565 `"Hamburg / Münchener "', modify
label define f63 108 `"Hamburg Mannheimer"', modify
label define f63 1047 `"Hamburger Arbeit Wilhelmsburg"', modify
label define f63 284 `"Hanse Merkur"', modify
label define f63 1401 `"Hansen Creativ"', modify
label define f63 172 `"Hansenet"', modify
label define f63 60 `"Hapag Lloyd"', modify
label define f63 1160 `"Hapag Lloyd"', modify
label define f63 861 `"Harburg & Freudenberger"', modify
label define f63 875 `"Harder & Sohn"', modify
label define f63 214 `"Hartmann Lehr"', modify
label define f63 90 `"Haspa"', modify
label define f63 133 `"Hauni  Körber"', modify
label define f63 1340 `"Havi-Lift & Transport"', modify
label define f63 660 `"Hays HH"', modify
label define f63 403 `"HDI Gerling"', modify
label define f63 898 `"HEE"', modify
label define f63 614 `"Heidke Rostock"', modify
label define f63 840 `"Heinkel"', modify
label define f63 44 `"Heinz Kung AG"', modify
label define f63 979 `"Heitkamp "', modify
label define f63 828 `"HEK Hanseatische Krankenkasse"', modify
label define f63 1376 `"HeLa Herman Laue "', modify
label define f63 665 `"Hemsley & Fraser"', modify
label define f63 24 `"Henke"', modify
label define f63 1113 `"Henkel"', modify
label define f63 841 `"Hermes"', modify
label define f63 905 `"Hermes"', modify
label define f63 204 `"Heuer & Sachs "', modify
label define f63 537 `"HH Chemie"', modify
label define f63 319 `"HH Süd "', modify
label define f63 442 `"HH Wasserwerke"', modify
label define f63 463 `"HHLA"', modify
label define f63 1277 `"High medical technologie"', modify
label define f63 346 `"HNO Klinik"', modify
label define f63 5 `"Hochbahn "', modify
label define f63 604 `"Hochland"', modify
label define f63 290 `"Honywell"', modify
label define f63 313 `"Hörnung"', modify
label define f63 637 `"Hotel Bayern"', modify
label define f63 160 `"Hoyer"', modify
label define f63 592 `"HSG Zander"', modify
label define f63 677 `"HSH Nordbank"', modify
label define f63 743 `"Huber Suaner"', modify
label define f63 93 `"HVV"', modify
label define f63 929 `"Hydro"', modify
label define f63 392 `"Hypo Vereinsbank"', modify
label define f63 1248 `"I & K Software GmbH"', modify
label define f63 208 `"Ibau"', modify
label define f63 904 `"Iberotel"', modify
label define f63 151 `"IBM"', modify
label define f63 769 `"IBM"', modify
label define f63 205 `"Icon"', modify
label define f63 572 `"IDS"', modify
label define f63 326 `"Iduna"', modify
label define f63 591 `"Ikea"', modify
label define f63 249 `"Immowelt"', modify
label define f63 1213 `"Imperial Tobacco"', modify
label define f63 1010 `"Implika"', modify
label define f63 1238 `"Imtec"', modify
label define f63 128 `"Industrial Textil"', modify
label define f63 477 `"Industrie & Handelskammer"', modify
label define f63 391 `"Inea AG"', modify
label define f63 1352 `"Info AG"', modify
label define f63 323 `"Ing. Büro"', modify
label define f63 483 `"Ing. Deba"', modify
label define f63 605 `"Ingenics AG"', modify
label define f63 461 `"Inno Games"', modify
label define f63 1310 `"Innoverre"', modify
label define f63 245 `"Institut f. Schadensverhütung"', modify
label define f63 1300 `"Institut für angewante Ökologie"', modify
label define f63 557 `"Integrales Stuttgart"', modify
label define f63 550 `"Intern. School HH"', modify
label define f63 1393 `"Internationale Forschung"', modify
label define f63 752 `"Interone"', modify
label define f63 1055 `"Interrium GmbH  (??)"', modify
label define f63 1246 `"Interschalt"', modify
label define f63 57 `"Intersell AG"', modify
label define f63 97 `"Intura"', modify
label define f63 1017 `"IRI"', modify
label define f63 881 `"IT Werke"', modify
label define f63 933 `"Itergo"', modify
label define f63 113 `"Jahn & Jahnsen"', modify
label define f63 199 `"Jahn & Zink"', modify
label define f63 1140 `"Jahreszeiten Verlag"', modify
label define f63 794 `"Jahr-Top Spezial"', modify
label define f63 15 `"Jakke"', modify
label define f63 539 `"Jansen IT"', modify
label define f63 771 `"Jansen Lilog"', modify
label define f63 78 `"JCB"', modify
label define f63 732 `"JDA"', modify
label define f63 1313 `"Jedox AG"', modify
label define f63 938 `"Jefrend Infuture"', modify
label define f63 1400 `"JF- Stoll"', modify
label define f63 574 `"JL"', modify
label define f63 532 `"Joh.Friedrich Behrens AG"', modify
label define f63 289 `"Johanniter Krankenhaus"', modify
label define f63 213 `"Johnson & Johnson"', modify
label define f63 1308 `"Johnson Controls"', modify
label define f63 1359 `"Johnson Herztech"', modify
label define f63 1363 `"Johseph Witt GmbH"', modify
label define f63 505 `"Jugendamt Lübeck"', modify
label define f63 506 `"Julaimen"', modify
label define f63 807 `"June"', modify
label define f63 527 `"Jung v. Mah."', modify
label define f63 961 `"Junges Blent"', modify
label define f63 134 `"Jungheinrich"', modify
label define f63 767 `"Justiz"', modify
label define f63 607 `"Kabs"', modify
label define f63 704 `"Käfer"', modify
label define f63 595 `"Kampas Nordsee"', modify
label define f63 493 `"Kanebo"', modify
label define f63 612 `"Kannegießer"', modify
label define f63 1229 `"Kantonalverwaltung"', modify
label define f63 1252 `"Karkustics"', modify
label define f63 425 `"Karoon Hotel"', modify
label define f63 101 `"Kars"', modify
label define f63 408 `"Karstadt "', modify
label define f63 170 `"KAS"', modify
label define f63 279 `"KCA Deutag"', modify
label define f63 1317 `"KCA Deutag"', modify
label define f63 296 `"Kelko"', modify
label define f63 83 `"Kemler "', modify
label define f63 1003 `"Kemner"', modify
label define f63 354 `"Kemper"', modify
label define f63 934 `"KFZ Detlefs"', modify
label define f63 729 `"KGU Consulting"', modify
label define f63 110 `"KHS"', modify
label define f63 16 `"Kindergarten"', modify
label define f63 71 `"Kindergarten"', modify
label define f63 371 `"Kindergarten"', modify
label define f63 635 `"Kindergarten"', modify
label define f63 659 `"Kindergarten"', modify
label define f63 1147 `"Kings College"', modify
label define f63 848 `"Kion Wiesb."', modify
label define f63 741 `"Kirche"', modify
label define f63 909 `"Kirche"', modify
label define f63 977 `"KKH"', modify
label define f63 1297 `"Klett Alianz"', modify
label define f63 1235 `"Klima Invest"', modify
label define f63 1354 `"Klimatechnik"', modify
label define f63 844 `"Klinik Mittelburg"', modify
label define f63 495 `"Klinikum rechts d Isar"', modify
label define f63 711 `"Klink"', modify
label define f63 1406 `"KMW Krauss Maffei _ Wegmann"', modify
label define f63 636 `"Knaak Krane"', modify
* label define f63 1132 `"Kock`s Hotel"', modify
label define f63 227 `"Kodak"', modify
label define f63 1064 `"Kohlhoff"', modify
label define f63 186 `"Kommunale Krankenpflege"', modify
label define f63 1373 `"König & Cie"', modify
label define f63 1150 `"Konsulat"', modify
label define f63 23 `"Köpnichg"', modify
label define f63 681 `"Körber  Hauni"', modify
label define f63 583 `"KPMG"', modify
label define f63 696 `"KPMG"', modify
label define f63 202 `"Krankenhaus"', modify
label define f63 243 `"Krankenhaus"', modify
label define f63 410 `"Krankenhaus"', modify
label define f63 522 `"Krankenhaus"', modify
label define f63 939 `"Krankenhaus"', modify
label define f63 1384 `"Krankenhaus"', modify
label define f63 877 `"Kraues"', modify
label define f63 132 `"Kreiskrankenhaus Rendsburg"', modify
label define f63 1414 `"Kreutzer"', modify
label define f63 1312 `"Kroll Consulting"', modify
label define f63 109 `"Krones"', modify
label define f63 415 `"Krongaard"', modify
label define f63 1283 `"Krüger Anlagentechnik"', modify
label define f63 144 `"Kühne & Nagel"', modify
label define f63 58 `"Kurierdienst DSL"', modify
label define f63 1046 `"Kurt Bärer"', modify
label define f63 862 `"Kurverwaltung"', modify
label define f63 322 `"KVB München"', modify
label define f63 395 `"KVG Consulting GmbH"', modify
label define f63 1189 `"KVP"', modify
label define f63 1142 `"L.A.H.Cuxh."', modify
label define f63 412 `"La Renachito"', modify
label define f63 827 `"Labwest"', modify
label define f63 1218 `"Lachenmeier"', modify
label define f63 730 `"Laliss"', modify
label define f63 374 `"Land SH Gericht"', modify
label define f63 498 `"Landa.Denkmalpflege Bay."', modify
label define f63 705 `"Landbäckerei Ihle"', modify
label define f63 1291 `"Landesdenkmalpflege Rheinland Pfalz"', modify
label define f63 400 `"Landesregierung"', modify
label define f63 503 `"Landesregierung Meck.Pom"', modify
label define f63 879 `"Landesregierung Schwerin"', modify
label define f63 1348 `"Landeszeitung"', modify
label define f63 829 `"Landhaus Flottbek"', modify
label define f63 14 `"Landwirtschaftliche Universität"', modify
label define f63 1431 `"Lebenshilfe Buxtehude"', modify
label define f63 476 `"Lebenshilfewerk"', modify
label define f63 910 `"Leefen"', modify
label define f63 886 `"Lenia Gmbh"', modify
label define f63 1419 `"Lerche"', modify
label define f63 494 `"Levy Galerie "', modify
label define f63 1135 `"LGS"', modify
label define f63 1004 `"Lidl"', modify
label define f63 1224 `"Liebheer "', modify
label define f63 398 `"Liebheer Aerospace"', modify
label define f63 121 `"Life-Inter Technik"', modify
label define f63 259 `"Lilly "', modify
label define f63 1417 `"Lima- Lto"', modify
label define f63 693 `"Linde AG"', modify
label define f63 1165 `"Lindner Ag"', modify
label define f63 1143 `"Linear Technik"', modify
label define f63 894 `"Lloyd"', modify
label define f63 921 `"Lohmann Animale LAH"', modify
label define f63 1303 `"Lohmsum"', modify
label define f63 906 `"Loiren"', modify
label define f63 1423 `"Lorupia"', modify
label define f63 1049 `"Louis Hagel"', modify
label define f63 523 `"Lüdeke HH"', modify
label define f63 54 `"Lufthansa"', modify
label define f63 1408 `"LVB Betriebskrankenkasse"', modify
label define f63 1103 `"M & M Aerospace"', modify
label define f63 1199 `"M4 Models"', modify
label define f63 768 `"Macys"', modify
label define f63 1045 `"Maersk"', modify
label define f63 306 `"Mahle"', modify
label define f63 262 `"Maler Kruse"', modify
label define f63 1344 `"MAN"', modify
label define f63 1368 `"Mannheimer"', modify
label define f63 824 `"Marcantroy"', modify
label define f63 1429 `"Mare"', modify
label define f63 985 `"Marine"', modify
label define f63 1258 `"Marinen Krankenhaus"', modify
label define f63 271 `"Marinshine"', modify
label define f63 713 `"Markant"', modify
label define f63 1104 `"Marketing Manufaktur"', modify
label define f63 1208 `"Marrco"', modify
label define f63 1034 `"MÄRSK"', modify
label define f63 441 `"Maschinenfabrik Kiel"', modify
label define f63 478 `"Matmi"', modify
label define f63 736 `"Mauritz"', modify
label define f63 76 `"Max Bahr"', modify
label define f63 1289 `"Max Plank Institut"', modify
label define f63 135 `"Max Rustral"', modify
label define f63 59 `"Mayflower Christian Academy"', modify
label define f63 697 `"MC Gregor"', modify
label define f63 355 `"Mc. Donalds"', modify
label define f63 165 `"Medart"', modify
label define f63 633 `"Media Edge"', modify
label define f63 900 `"Media Entaison"', modify
label define f63 70 `"Media Markt"', modify
label define f63 598 `"Medizinische Hochschule"', modify
label define f63 1097 `"Medos AG Aachen"', modify
label define f63 64 `"Meeritz"', modify
label define f63 273 `"Menk "', modify
label define f63 1195 `"Messehallen Husum"', modify
label define f63 449 `"Metro Group"', modify
label define f63 1276 `"Metronic"', modify
label define f63 779 `"Meyer Haustechnik"', modify
label define f63 813 `"Micro Stategy"', modify
label define f63 1427 `"Microsoft"', modify
label define f63 1365 `"Miele "', modify
label define f63 282 `"Minimax"', modify
label define f63 2 `"Minuteman ( Hako USA)"', modify
label define f63 1265 `"Mitteldeutsche Zeitung"', modify
label define f63 913 `"MLM"', modify
label define f63 642 `"MM Warburg"', modify
label define f63 687 `"MMP Cesar"', modify
label define f63 1081 `"Möbel Höffner"', modify
label define f63 86 `"Möbel Kraft"', modify
label define f63 955 `"Möbel Sonnen"', modify
label define f63 488 `"Mobilcom"', modify
label define f63 218 `"MOL"', modify
label define f63 266 `"MORANTES"', modify
label define f63 475 `"Morgenpost"', modify
label define f63 1375 `"Motormann Roboteck"', modify
label define f63 589 `"MPC"', modify
label define f63 294 `"MPC HEK"', modify
label define f63 184 `"MTU Friedrichshafen"', modify
label define f63 267 `"Muk"', modify
label define f63 460 `"Müller "', modify
label define f63 577 `"Müller  Marketing Insight"', modify
label define f63 1030 `"Münchener Tageszeitung"', modify
label define f63 620 `"Münters"', modify
label define f63 1133 `"Musikschule"', modify
label define f63 1296 `"Musikschule"', modify
label define f63 683 `"Mutter &Kindheim"', modify
label define f63 1023 `"MVZ Altona"', modify
label define f63 1337 `"N.I.Teijin shopi Europ GmbH"', modify
label define f63 603 `"Naha"', modify
label define f63 627 `"Navisco"', modify
label define f63 361 `"NDR"', modify
label define f63 617 `"Nestle"', modify
label define f63 1019 `"Netcologne"', modify
label define f63 750 `"Netjet"', modify
label define f63 1152 `"Neuapostolische Kirche"', modify
label define f63 1173 `"Neuenfelder Maschienenfabrik"', modify
label define f63 409 `"Neuwell Rubbermed"', modify
label define f63 1181 `"Newell"', modify
label define f63 922 `"News aktuell"', modify
label define f63 1220 `"Next ID"', modify
label define f63 695 `"NGO"', modify
label define f63 1036 `"Niebelungen Verlag"', modify
label define f63 1371 `"Niederegger"', modify
label define f63 387 `"Niehoff"', modify
label define f63 1061 `"NKK Progamm "', modify
label define f63 1127 `"Nokia"', modify
label define f63 327 `"Nokia Siemens"', modify
label define f63 1333 `"Nordex"', modify
label define f63 852 `"Nordsee"', modify
label define f63 163 `"Novonardes"', modify
label define f63 99 `"Novotel"', modify
label define f63 1322 `"NXP"', modify
label define f63 1386 `"Nycomed"', modify
label define f63 602 `"Nytsyn"', modify
label define f63 348 `"O2"', modify
label define f63 1346 `"Oberhaus Appartment"', modify
label define f63 301 `"Ocean Quest"', modify
label define f63 891 `"öffentlicher Dienst"', modify
label define f63 995 `"öffentlicher Dienst"', modify
label define f63 1041 `"öffentlicher Dienst"', modify
label define f63 1044 `"öffentlicher Dienst"', modify
label define f63 1394 `"öffentlicher Dienst"', modify
label define f63 397 `"öffentlicher Dienst "', modify
label define f63 479 `"öffentlicher Dienst "', modify
label define f63 676 `"öffentlicher Dienst "', modify
label define f63 1329 `"Ogilvy"', modify
label define f63 324 `"Oldenbuer Möbelwaren"', modify
label define f63 237 `"OLG Frankfurt"', modify
label define f63 674 `"Olympik Marseille"', modify
label define f63 1112 `"Onet Röhnkliniken"', modify
label define f63 1 `"Opel"', modify
label define f63 1438 `"Oracle"', modify
label define f63 219 `"ORLEN"', modify
label define f63 187 `"OSLOVVS"', modify
label define f63 52 `"Osram"', modify
label define f63 1095 `"Öttinger"', modify
label define f63 287 `"Otto  "', modify
label define f63 248 `"Otto Freizeit / Touristik"', modify
label define f63 1145 `"OÜ Männiku Shekoda"', modify
label define f63 256 `"P&P Shipping"', modify
label define f63 105 `"Panasonic"', modify
label define f63 876 `"Pantaenius"', modify
label define f63 1026 `"Paperlux"', modify
label define f63 1137 `"Parazelsius Klinik"', modify
label define f63 684 `"Parexel"', modify
label define f63 792 `"Peek &Cloppenburg"', modify
label define f63 241 `"Pelmar "', modify
label define f63 714 `"Pentax"', modify
label define f63 1251 `"Pentax"', modify
label define f63 274 `"Pepsico"', modify
label define f63 325 `"Perf. Consulting"', modify
label define f63 1345 `"Permacon"', modify
label define f63 357 `"Peter Dohle"', modify
label define f63 941 `"Pflege GmbH Weinhude"', modify
label define f63 195 `"Pflegecenter  Altenheim"', modify
label define f63 1361 `"PH Schwäbisch Gemünder Hochschule"', modify
label define f63 587 `"Phichips"', modify
label define f63 91 `"Philips"', modify
label define f63 489 `"Philips"', modify
label define f63 762 `"Philips"', modify
label define f63 89 `"Phonehouse"', modify
label define f63 1011 `"Piaggio"', modify
label define f63 919 `"Plath"', modify
label define f63 884 `"Pleon"', modify
label define f63 1092 `"Plustek Technologie"', modify
label define f63 992 `"Polaroid"', modify
label define f63 1048 `"Polizei"', modify
label define f63 18 `"Polzug"', modify
label define f63 1211 `"Post"', modify
label define f63 573 `"Postbank"', modify
label define f63 142 `"Power"', modify
label define f63 510 `"Prada "', modify
label define f63 611 `"Pranda "', modify
label define f63 308 `"Prasser Sander"', modify
label define f63 1338 `"Praxis Behrend"', modify
label define f63 1076 `"Premiere"', modify
label define f63 299 `"PREO Softwear AG"', modify
label define f63 809 `"Presswatch"', modify
label define f63 568 `"Privat Airline"', modify
label define f63 230 `"Privat Klinik Hirstlauch"', modify
label define f63 226 `"Privates Pflegeheim"', modify
label define f63 758 `"Pro Soft "', modify
label define f63 1389 `"Professionell Fitness Club"', modify
label define f63 455 `"Promotion & Event"', modify
label define f63 721 `"Promtex"', modify
label define f63 1292 `"Property one GmbH"', modify
label define f63 106 `"Proximity"', modify
label define f63 1159 `"psycho/sozial. Beratungsstelle"', modify
label define f63 529 `"PTV  AG"', modify
label define f63 1240 `"Publics"', modify
label define f63 867 `"Punch Grafilix"', modify
label define f63 1214 `"PVG"', modify
label define f63 385 `"PVS"', modify
label define f63 618 `"Quasar"', modify
label define f63 799 `"Queis"', modify
label define f63 1364 `"Quelle"', modify
label define f63 663 `"Quest "', modify
label define f63 870 `"QuicK Pack GmbH"', modify
label define f63 342 `"R & V "', modify
label define f63 1098 `"Rabe – tell"', modify
label define f63 649 `"Radbruch"', modify
label define f63 169 `"Radi Medikal"', modify
label define f63 1207 `"Radio HH"', modify
label define f63 40 `"Radium Hospital"', modify
label define f63 959 `"Raifeisenbank"', modify
label define f63 883 `"Raiffeisen"', modify
label define f63 949 `"Rainball"', modify
label define f63 954 `"Ranstad"', modify
label define f63 161 `"Rapp"', modify
label define f63 1378 `"Ratje "', modify
label define f63 491 `"RCI Renault & Ciric"', modify
label define f63 826 `"Rechtsanwalt Becker & Partner"', modify
label define f63 1149 `"Rechtsanwaltskanzlei Warmbold"', modify
label define f63 895 `"Redwood Softwear"', modify
label define f63 490 `"Rege HH"', modify
label define f63 652 `"Regioklinik"', modify
label define f63 694 `"Reha Zentrum"', modify
label define f63 1219 `"Reinhold & Makta"', modify
label define f63 1334 `"Reiter Energiering"', modify
label define f63 716 `"Repower"', modify
label define f63 45 `"Restaurant Krögers"', modify
label define f63 1266 `"Retillo"', modify
label define f63 341 `"Retjan"', modify
label define f63 1271 `"Rewe Konzern"', modify
label define f63 560 `"Rezidor"', modify
label define f63 722 `"Rezidor"', modify
label define f63 239 `"Rheinetall"', modify
label define f63 521 `"Rheinmetall"', modify
label define f63 468 `"Richers"', modify
label define f63 655 `"Richter & Heln "', modify
label define f63 114 `"Ricklinger Landbrauerei"', modify
label define f63 996 `"Rickmers"', modify
label define f63 317 `"Ridl Inter. Dozent für Hafen"', modify
label define f63 594 `"Riemser"', modify
label define f63 576 `"Ritter"', modify
label define f63 1304 `"Ritter GmbH"', modify
label define f63 365 `"RKS"', modify
label define f63 92 `"Robin Wood"', modify
label define f63 485 `"Röhlig"', modify
label define f63 480 `"Rohm & Haag"', modify
label define f63 1060 `"Rolf Meyer"', modify
label define f63 783 `"Rolls Roys"', modify
label define f63 25 `"Rosig"', modify
label define f63 260 `"Rossmann"', modify
label define f63 1185 `"Rotes Kreuz"', modify
label define f63 628 `"Roto Frank AG"', modify
label define f63 1366 `"Rowohlt Verlag"', modify
label define f63 866 `"Royal Meridian"', modify
label define f63 1146 `"RPM"', modify
label define f63 120 `"RWE / DEA"', modify
label define f63 1247 `"S. M. Elektronik"', modify
label define f63 1141 `"S4M solutions 4 media"', modify
label define f63 1022 `"Sagem Orga."', modify
label define f63 797 `"Saint Gabain"', modify
label define f63 534 `"SAIPEM"', modify
label define f63 215 `"SAL "', modify
label define f63 1106 `"Saliemt"', modify
label define f63 1268 `"Saline Lüneburg"', modify
label define f63 851 `"Salzburg AG"', modify
label define f63 873 `"Sam Elektroniks"', modify
label define f63 1253 `"Sana Krankenhäuser"', modify
label define f63 1390 `"Sanacorp  AG"', modify
label define f63 1056 `"Sander"', modify
label define f63 419 `"Sanitätshaus"', modify
label define f63 1163 `"Sanofir Pasteur MSD"', modify
label define f63 535 `"Sanreo"', modify
label define f63 228 `"SAP"', modify
label define f63 658 `"Sarasin"', modify
label define f63 804 `"SAS"', modify
label define f63 417 `"SASOL"', modify
label define f63 942 `"Saturn"', modify
label define f63 1075 `"Scala Wohnen"', modify
label define f63 474 `"Schlesw. Versicherungskontor"', modify
label define f63 911 `"Schlott AG"', modify
label define f63 72 `"Schlüter"', modify
label define f63 206 `"Schmidt Römhild"', modify
label define f63 524 `"Schmidts Tivoli"', modify
label define f63 68 `"Scholz und Frensen"', modify
label define f63 531 `"Schröder "', modify
label define f63 596 `"Schröder "', modify
label define f63 888 `"Schüco"', modify
label define f63 55 `"Schulbehörde Kultusministerium"', modify
label define f63 17 `"Schule"', modify
label define f63 437 `"Schule"', modify
label define f63 626 `"Schule"', modify
label define f63 724 `"Schule"', modify
label define f63 1335 `"Schule"', modify
label define f63 263 `"Schule / Bildung"', modify
label define f63 552 `"Schulz SHK"', modify
label define f63 198 `"Schwartauer Werke "', modify
label define f63 1050 `"Schwarz"', modify
label define f63 471 `"Scottish Power"', modify
label define f63 916 `"Seadvill"', modify
label define f63 1183 `"Seco Tool"', modify
label define f63 465 `"Semco SA"', modify
label define f63 39 `"Senter Malerforreting"', modify
label define f63 62 `"SGS"', modify
label define f63 787 `"Sharp"', modify
label define f63 765 `"Shuttle"', modify
label define f63 972 `"Siebenwust"', modify
label define f63 84 `"Siemens"', modify
label define f63 209 `"Siemens"', modify
label define f63 1121 `"Siggelkow"', modify
label define f63 846 `"Sigl. GmbH"', modify
label define f63 1239 `"Sihi"', modify
label define f63 469 `"Sika"', modify
label define f63 1280 `"Silbersack HH"', modify
label define f63 969 `"Silicon"', modify
label define f63 1418 `"Simon Voss AG"', modify
label define f63 892 `"Situs"', modify
label define f63 1404 `"Sivalbp"', modify
label define f63 1245 `"Smith / Nepkew"', modify
label define f63 650 `"SMK"', modify
label define f63 1168 `"Smurfit Kappa"', modify
label define f63 599 `"Soelund"', modify
label define f63 1128 `"Soft Chip HH"', modify
label define f63 1437 `"Softwarerloft"', modify
label define f63 1396 `"Sogeti High Tech GmbH"', modify
label define f63 1255 `"Solartermie Direkt GmbH"', modify
label define f63 1284 `"Sommerfestspiele"', modify
label define f63 28 `"Sonderanlagenbau Nord GmbH"', modify
label define f63 1099 `"Sonderjütlands Synphonieorchester"', modify
label define f63 484 `"Sonntag"', modify
label define f63 352 `"Sonntags Blitz"', modify
label define f63 1178 `"SOVAG"', modify
label define f63 1244 `"Sovereign Speed GmbH"', modify
label define f63 1186 `"Sozialamt"', modify
label define f63 179 `"Sozialbehörde"', modify
label define f63 47 `"Sozialversicherung  "', modify
label define f63 757 `"Spar"', modify
label define f63 358 `"Sparkasse"', modify
label define f63 726 `"Sparkasse"', modify
label define f63 728 `"Spiel und Freizeit"', modify
label define f63 845 `"Sport Chick"', modify
label define f63 887 `"Sport Fibe"', modify
label define f63 472 `"Spott Media"', modify
label define f63 411 `"SPP Utility"', modify
label define f63 1315 `"SQS"', modify
label define f63 811 `"SRA"', modify
label define f63 104 `"St Oliver"', modify
label define f63 1428 `"St. Vincent Haus "', modify
label define f63 364 `"Staat"', modify
label define f63 1005 `"Staat"', modify
label define f63 1167 `"Staat Estland"', modify
label define f63 634 `"Staatsanwaltschaft"', modify
label define f63 1012 `"Stadt Heide"', modify
label define f63 1274 `"Stadt HH"', modify
label define f63 174 `"Stadtkrankenhaus"', modify
label define f63 432 `"Stadtrat"', modify
label define f63 4 `"Stadtverwaltung"', modify
label define f63 944 `"Stadtverwaltung /Forstverwaltung"', modify
label define f63 1115 `"Stadtwerke Kiel"', modify
label define f63 878 `"Stadtwerke Schwerin"', modify
label define f63 420 `"Stage Intertaiment"', modify
label define f63 229 `"Stahl Gruber GmbH"', modify
label define f63 858 `"Stand.Kessel.Baung."', modify
label define f63 964 `"Start GmbH"', modify
label define f63 1439 `"Statoil Hydro ASA"', modify
label define f63 1085 `"Staufenberg"', modify
label define f63 157 `"Steiger"', modify
label define f63 100 `"Steinmetz"', modify
label define f63 438 `"Stern"', modify
label define f63 541 `"Steuerkanzlei"', modify
label define f63 98 `"Stibel Eltron"', modify
label define f63 149 `"Stiftung Alsterdorf"', modify
label define f63 430 `"Still"', modify
label define f63 497 `"Stockheim Catering GmbH"', modify
label define f63 1018 `"Stockmann"', modify
label define f63 734 `"Stoma "', modify
label define f63 872 `"Strabag"', modify
label define f63 1021 `"Stratt Solar"', modify
label define f63 544 `"Studio HH"', modify
label define f63 927 `"Stuhl"', modify
label define f63 116 `"Submission "', modify
label define f63 918 `"Subshell"', modify
label define f63 481 `"Südbank"', modify
label define f63 640 `"Südzucker"', modify
label define f63 1267 `"Suiurfit Kufspa"', modify
label define f63 61 `"Sunedition"', modify
label define f63 1062 `"Suter one"', modify
label define f63 51 `"SV Böblingen"', modify
label define f63 41 `"Swiss Air"', modify
label define f63 781 `"T- Mobile"', modify
label define f63 217 `"T Systems"', modify
label define f63 46 `"Taaleecn"', modify
label define f63 1204 `"Tageszeitung Bremerhaven"', modify
label define f63 1381 `"Tageszeitung Passau"', modify
label define f63 915 `"Taka Airlines"', modify
label define f63 302 `"Taylor"', modify
label define f63 519 `"TBWA"', modify
label define f63 416 `"Tchibo"', modify
label define f63 737 `"Tech Data"', modify
label define f63 897 `"Teehandel"', modify
label define f63 559 `"Teppichhandel"', modify
label define f63 912 `"Terminalen"', modify
label define f63 154 `"Terra"', modify
label define f63 675 `"TESA siehe Beiersdorf"', modify
label define f63 162 `"Tetra Pak"', modify
label define f63 902 `"Teucate"', modify
label define f63 1191 `"Thales"', modify
label define f63 981 `"The Brand Unicon"', modify
label define f63 150 `"The Grand Hotel Eastbourn"', modify
label define f63 562 `"The Markworks"', modify
label define f63 1071 `"Theater"', modify
label define f63 755 `"Theben AG"', modify
label define f63 785 `"Thomas Cook"', modify
label define f63 261 `"Thyssen & Krupp"', modify
label define f63 435 `"Ticket Master"', modify
label define f63 1063 `"TIETO"', modify
label define f63 1100 `"TK"', modify
label define f63 166 `"TK/MS"', modify
label define f63 990 `"Tmqs GmbH"', modify
label define f63 623 `"TNS"', modify
label define f63 1383 `"TNT Airways"', modify
label define f63 564 `"TNT Express"', modify
label define f63 993 `"Tokio Elektron"', modify
label define f63 152 `"Tom Tailor"', modify
label define f63 201 `"Ton Halle"', modify
label define f63 1117 `"Tonndortf"', modify
label define f63 1305 `"Toom "', modify
label define f63 232 `"Toombaumarkt"', modify
label define f63 1270 `"Torex "', modify
label define f63 1223 `"Total"', modify
label define f63 69 `"Tourismus"', modify
label define f63 1109 `"Tourist Buwlo Supply GmbH"', modify
label define f63 983 `"Trales"', modify
label define f63 733 `"Trans Therm"', modify
label define f63 440 `"Trans Unix"', modify
label define f63 551 `"Transport Reasurch "', modify
label define f63 1403 `"Travel DDB"', modify
label define f63 1164 `"Travel Reisen"', modify
label define f63 1285 `"Treudelkamp "', modify
label define f63 766 `"Triumph Aaly"', modify
label define f63 945 `"Tronical"', modify
label define f63 445 `"TU Harburg"', modify
label define f63 546 `"TUI Leger Travel"', modify
label define f63 1144 `"TUI Reisebüro"', modify
label define f63 802 `"Tuifly"', modify
label define f63 19 `"Turbo Meda"', modify
label define f63 812 `"TÜV Rheinland"', modify
label define f63 773 `"UBA Software"', modify
label define f63 578 `"UHU"', modify
label define f63 1328 `"Umwelt"', modify
label define f63 388 `"Uni"', modify
label define f63 920 `"Uni"', modify
label define f63 390 `"Uni Bologna"', modify
label define f63 874 `"Uni Calmas"', modify
label define f63 838 `"Uni Edingburgh"', modify
label define f63 798 `"Uni Emory Georgia"', modify
label define f63 1139 `"Uni England"', modify
label define f63 582 `"Uni Flensburg"', modify
label define f63 1262 `"Uni Helsinki"', modify
label define f63 509 `"Uni HH"', modify
label define f63 1231 `"Uni Köln"', modify
label define f63 1228 `"Uni Konstanz"', modify
label define f63 1288 `"Uni Lübeck"', modify
label define f63 702 `"Uni München "', modify
label define f63 657 `"Uni München LMU"', modify
label define f63 125 `"Uni Nogroda"', modify
label define f63 1125 `"Uni Oldenburg Forschung"', modify
label define f63 504 `"Uni Paris"', modify
label define f63 1422 `"Uni Potzdam"', modify
label define f63 994 `"Uni Stockholm"', modify
label define f63 307 `"Uni Toronto"', modify
label define f63 180 `"Uni Zürich"', modify
label define f63 424 `"Uniklinik Athen"', modify
label define f63 1350 `"Uniklinik Brest"', modify
label define f63 1230 `"Uniklinik Düseldorf"', modify
label define f63 74 `"Uniklinik Eppendorf / UKE"', modify
label define f63 32 `"Uniklinik Kiel"', modify
label define f63 608 `"Uniklinik München"', modify
label define f63 619 `"Uniklinik UKSH"', modify
label define f63 122 `"Unilever"', modify
label define f63 145 `"Unilever"', modify
label define f63 360 `"Union Matex"', modify
label define f63 1243 `"Universalmusik"', modify
label define f63 370 `"Universität"', modify
label define f63 624 `"Universität Bremen"', modify
label define f63 81 `"UPS"', modify
label define f63 1325 `"USU AG"', modify
label define f63 280 `"UTAX GmbH"', modify
label define f63 1254 `"UWG Biotech AG"', modify
label define f63 836 `"Vailland"', modify
label define f63 288 `"Vajara Viddya"', modify
label define f63 914 `"Valora Konsulting"', modify
label define f63 192 `"Vattenfall"', modify
label define f63 379 `"VBA"', modify
label define f63 975 `"Velox"', modify
label define f63 740 `"Velux"', modify
label define f63 293 `"Venta"', modify
label define f63 689 `"Veolia"', modify
label define f63 793 `"Vereinigte Bühne Wien"', modify
label define f63 1156 `"Vereinigte Papierwarenfabrik"', modify
label define f63 932 `"Vereinte Nationen"', modify
label define f63 679 `"Verging"', modify
label define f63 566 `"Versicherungsmakler"', modify
label define f63 621 `"Vertex"', modify
label define f63 487 `"Verwaltung"', modify
label define f63 1187 `"Vier Jahreszeiten"', modify
label define f63 1082 `"Viktoria"', modify
label define f63 948 `"Visac"', modify
label define f63 1415 `"Visos GmbH"', modify
label define f63 434 `"VIVOR"', modify
label define f63 281 `"Vodafon"', modify
label define f63 1029 `"Vola"', modify
label define f63 295 `"Volksbank"', modify
label define f63 1402 `"Volksbank "', modify
label define f63 1293 `"Volksfürsorge"', modify
label define f63 126 `"Volvo"', modify
label define f63 638 `"Volz "', modify
label define f63 1138 `"Voss Chemie GmbH"', modify
label define f63 148 `"Vossloh"', modify
label define f63 20 `"Vox Baltica "', modify
label define f63 545 `"VR West"', modify
label define f63 456 `"VW"', modify
label define f63 1242 `"VW ROU"', modify
label define f63 708 `"Wächter & Wächter"', modify
label define f63 901 `"Wall Mat"', modify
label define f63 744 `"Warburg"', modify
label define f63 508 `"Warner Brothers"', modify
label define f63 1278 `"Warth & Klein"', modify
label define f63 436 `"Wational Health"', modify
label define f63 1263 `"WDR"', modify
label define f63 1412 `"Weber  Poll"', modify
label define f63 746 `"Wecomed"', modify
label define f63 1377 `"Weigth Watchers"', modify
label define f63 540 `"Weinmann"', modify
label define f63 311 `"Wempe"', modify
label define f63 997 `"Wenka Nixdorf"', modify
label define f63 275 `"Wenkel "', modify
label define f63 796 `"Werners & Werners"', modify
label define f63 1212 `"Westers"', modify
label define f63 1409 `"Westklinikum HH"', modify
label define f63 1323 `"Wibo"', modify
label define f63 1032 `"Wiener Goldschmiede"', modify
label define f63 653 `"Wilson"', modify
label define f63 173 `"Wincor Nixdorf"', modify
label define f63 349 `"Wind 7 AG"', modify
label define f63 991 `"Windtest"', modify
label define f63 1264 `"Wirtschaftsbehörde MÜNCHEN"', modify
label define f63 643 `"Wirtschaftsverband HH"', modify
label define f63 50 `"Wissenschaft"', modify
label define f63 404 `"Wissenschaft/Lehre/Foprschung"', modify
label define f63 383 `"Wissenschaftliches Institut Literaturarchiv"', modify
label define f63 664 `"Witt  Weiden"', modify
label define f63 1039 `"Woolworth"', modify
label define f63 1324 `"Wordline"', modify
label define f63 747 `"Writz BBDO"', modify
label define f63 1154 `"WRW GmbH"', modify
label define f63 386 `"WTV"', modify
label define f63 1052 `"Wulf"', modify
label define f63 118 `"Xella"', modify
label define f63 426 `"Xenoco"', modify
label define f63 931 `"XING"', modify
label define f63 517 `"Yamaha Motors"', modify
label define f63 171 `"Yxlon X-Ray GmbH "', modify
label define f63 686 `"Zahnarzt"', modify
label define f63 1420 `"ZDF"', modify
label define f63 960 `"Zeit-Verlag"', modify
label define f63 418 `"ZOLL"', modify
label define f63 727 `"Zum Durmbräu"', modify
label define f63 947 `"Zunder"', modify
label define f63 1370 `"Züricher Bank"', modify
label define f63 1299 `"Züricher Tagesblatt"', modify
label define f63 1272 `"Zuser GmbH"', modify
label define f63 833 `"ZVO Zweckverband Ostholstein"', modify

label value f63 f63






save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG09.dta", replace 

