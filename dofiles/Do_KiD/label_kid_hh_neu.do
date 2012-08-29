clear
set memory 700m
insheet using "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.txt"
* use "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.txt", clear

label variable k00 "Fahrzeug-ID"
label variable f00 "Fahrten-ID"

label variable f01 "Fahrerwechsel"
label define f01 1 `"ja"', modify
label define f01 2 `"nein"', modify
recode f01 (-1=.a) (-9=.z)
label define f01 .a `"keine Angabe"', modify
label define f01 .z `"Merkmal nicht erhoben"', modify
* label define f01 .b `"keine Angabe: erste Fahrt oder mehr als 12 Fahrten"', modify
label value f01 f01

* label variable f02 "Quelladresse"
label variable f02a "Quelle GKS - Fahrzeugstandort"
label variable f02b "Quelle - Land"
label variable f02c "Quelle - Fahrzeugstandort"
label variable f02d "Quelle - X-Koordinate"
label variable f02e "Quelle - Y-Koordinate"
label variable f02f "Quelle - Genauigkeit der Geokoordinate"
label define f02f 1 `"Gemeinde"' 2 `"Postleitzahlgebiet"' 3 `"Straße"' 4 `"Straßenabschnitt"', modify

recode f02a (-1=.a) (-9=.z)
label define f02a .a `"keine Angabe"', modify
label define f02a .z `"Merkmal nicht erhoben"', modify
label value f02a f02a

recode f02d (-1=.a) (-9=.z)
label define f02d .a `"keine Angabe"', modify
label define f02d .z `"Merkmal nicht erhoben"', modify
label value f02d f02d

recode f02e (-1=.a) (-9=.z)
label define f02e .a `"keine Angabe"', modify
label define f02e .z `"Merkmal nicht erhoben"', modify
label value f02e f02e

recode f02f (-1=.a) (-9=.z)
label define f02f .a `"keine Angabe"', modify
label define f02f .z `"Merkmal nicht erhoben"', modify
label value f02f f02f



label variable f03 "Art der Quelle"
label define f03 1`"Umschlagpunkt"' 2 `"Spedition"' 3 `"Baustelle"' 4 `"Eigener Betrieb"' 5 `"Fremder Betrieb"' 6 `"Kundenhaushalt"' 7 `"Sonstiger dienstlich/geschäftlicher Ausgangspunkt"' 8 `"Privater Ausgangspunkt"', modify
recode f03 (-1=.a) (-9=.z)
label define f03 .a `"keine Angabe"', modify
label define f03 .z `"Merkmal nicht erhoben"', modify
label value f03 f03

label variable f04 "Fahrtbeginn - Abfahrtszeit"

label variable f05 "Fahrzeugbesetzung"
recode f05 (-9=.z) (-1=.a)
label define f05 .z `"Merkmal nicht erhoben"', modify
label define f05 .a `"keine Angabe"', modify
label value f05 f05

label variable f06 "Anhänger"
label define f06 1 `"ja"', modify
label define f06 2 `"nein"', modify
recode f06 (-1=.a) (-9=.z)
label define f06 .a `"keine Angabe"', modify
label define f06 .z `"Merkmal nicht erhoben"', modify
label value f06 f06


* recode F02B (-1=.a) (-9=.z)
* label define F02B .a `"keine Angabe"', modify
* label define F02B .z `"Merkmal nicht erhoben"', modify
* label value F02B F02B
label variable f07a "Fahrtzweck"
label define f07a 1 `"d/g: Holen, Bringen, Transportieren  von Gütern, Waren, Material, Maschinen, Geräten etc."', modify
label define f07a 2 `"d/g: Fahrt zur Erbringung beruflicher Leistungen (Montage, Reparatur, Beratung, Besuch, Betreuung, etc."', modify
label define f07a 3 `"d/g: Holen, Bringen, Befördern von Personen (d/g)"', modify
label define f07a 4 `"d/g: sonstige dienstlich/geschäftliche Erledigungen"', modify
label define f07a 5 `"d/g: Rückfahrt zum Betrieb"', modify
label define f07a 6 `"p: Fahrt zum Arbeitsplatz"', modify
label define f07a 7 `"p: Fahrt zur Ausbildung"', modify
label define f07a 8 `"p: Privater Einkauf"', modify
label define f07a 9 `"p: Freizeit, Erholung"', modify
label define f07a 10 `"p: Holen, Bringen, Befördern von Personen (privat)"', modify
label define f07a 11 `"p: sonstige private Erledigung"', modify
label define f07a 12 `"p: Fahrt nach Hause"', modify

label define f07a 21 `"dienstlich/geschäftliche Erledigung"', modify
label define f07a 22 `"private Erledigung"', modify
recode f07a (-1=.a) (-9=.z)
label define f07a .a `"keine Angabe"', modify
label define f07a .z `"Merkmal nicht erhoben"', modify
label value f07a f07a


label variable f07b "Nutzungsart"
label define f07b 1 `"ja"', modify
label define f07b 2 `"nein"', modify
recode f07b (-1=.a) (-9=.z)
label define f07b .a `"keine Angabe"', modify
label define f07b .z `"Merkmal nicht erhoben"', modify
label value f07b f07b

label variable f08a "Ziel GKS - Fahrzeugstandort"
label variable f08b "Ziel - Land"
label variable f08c "Ziel - Fahrzeugstandort"
label variable f08d "Ziel - X-Koordinate"
label variable f08e "Ziel - Y-Koordinate"
label variable f08f "Ziel - Genauigkeit der Geokoordinate"
label define f08f 1 `"Gemeinde"' 2 `"Postleitzahlgebiet"' 3 `"Straße"' 4 `"Straßenabschnitt"', modify

recode f08a (-1=.a) (-9=.z)
label define f08a .a `"keine Angabe"', modify
label define f08a .z `"Merkmal nicht erhoben"', modify
label value f08a f08a

recode f08d (-1=.a) (-9=.z)
label define f08d .a `"keine Angabe"', modify
label define f08d .z `"Merkmal nicht erhoben"', modify
label value f08d f08d

recode f08e (-1=.a) (-9=.z)
label define f08e .a `"keine Angabe"', modify
label define f08e .z `"Merkmal nicht erhoben"', modify
label value f08e f08e

recode f08f (-1=.a) (-9=.z)
label define f08f .a `"keine Angabe"', modify
label define f08f .z `"Merkmal nicht erhoben"', modify
label value f08f f08f

label variable f09 "Art des Ziels"
label define f09 1 `"Umschlagpunkt (Bahnhof, Hafen, GVZ etc.)"', modify
label define f09 2 `"Spedition"', modify
label define f09 3 `"Baustelle"', modify
label define f09 4 `"Eigener Betrieb"', modify
label define f09 5 `"Fremder Betrieb"', modify
label define f09 6 `"Kundenhaushalt"', modify
label define f09 7 `"sonstiges dienstliches/privates Ziel"', modify
label define f09 8 `"privates Ziel"', modify
recode f09 (-1=.a) (-9=.z)
label define f09 .a `"keine Angabe"', modify
label define f09 .z `"Merkmal nicht erhoben"', modify
label value f09 f09

* label variable f10 "Fahrtende - Ankunftszeit"
label variable f10a "Fahrtende - Ankunftszeit: Uhrzeit"
label variable f10b "Ankunftsdatum bei Fahrtende"

* label variable F11 "Form der Ladung"
* recode F11 (-9=.z)
* label define F11 .z `"Merkmal nicht erhoben"', modify
* label value F11 F11

label variable f11a "Form der Ladung - keine Güter"
label define f11a 1 `"ja"', modify
label define f11a 2 `"nein"', modify
recode f11a (-1=.a) (-9=.z)
label define f11a .a `"keine Angabe"', modify
label define f11a .z `"Merkmal nicht erhoben"', modify
label value f11a f11a

label variable f11b "Form der Ladung - Flüssige Massengüter"
label define f11b 1 `"ja"', modify
label define f11b 2 `"nein"', modify
recode f11b (-1=.a) (-9=.z)
label define f11b .a `"keine Angabe"', modify
label define f11b .z `"Merkmal nicht erhoben"', modify
label value f11b f11b

label variable f11c "Form der Ladung - Trockene Massengüter"
label define f11c 1 `"ja"', modify
label define f11c 2 `"nein"', modify
recode f11c (-1=.a) (-9=.z)
label define f11c .a `"keine Angabe"', modify
label define f11c .z `"Merkmal nicht erhoben"', modify
label value f11c f11c

label variable f11d "Form der Ladung - Behälter/Wechselaufbau bis 6m"
label define f11d 1 `"ja"', modify
label define f11d 2 `"nein"', modify
recode f11d (-1=.a) (-9=.z)
label define f11d .a `"keine Angabe"', modify
label define f11d .z `"Merkmal nicht erhoben"', modify
label value f11d f11d

label variable f11e "Form der Ladung - Behälter/Wechselaufbau über 6m"
label define f11e 1 `"ja"', modify
label define f11e 2 `"nein"', modify
recode f11e (-1=.a) (-9=.z)
label define f11e .a `"keine Angabe"', modify
label define f11e .z `"Merkmal nicht erhoben"', modify
label value f11e f11e

label variable f11f "Form der Ladung - Fahrzeuge ohne eigenen Antrieb"
label define f11f 1 `"ja"', modify
label define f11f 2 `"nein"', modify
recode f11f (-1=.a) (-9=.z)
label define f11f .a `"keine Angabe"', modify
label define f11f .z `"Merkmal nicht erhoben"', modify
label value f11f f11f

label variable f11g "Form der Ladung - Fahrzeuge mit eigenem Antrieb"
label define f11g 1 `"ja"', modify
label define f11g 2 `"nein"', modify
recode f11g (-1=.a) (-9=.z)
label define f11g .a `"keine Angabe"', modify
label define f11g .z `"Merkmal nicht erhoben"', modify
label value f11g f11g

label variable f11h "Form der Ladung - Palettiertes Gut"
label define f11h 1 `"ja"', modify
label define f11h 2 `"nein"', modify
recode f11h (-1=.a) (-9=.z)
label define f11h .a `"keine Angabe"', modify
label define f11h .z `"Merkmal nicht erhoben"', modify
label value f11h f11h

label variable f11i "Form der Ladung - Gebundene Güter"
label define f11i 1 `"ja"', modify
label define f11i 2 `"nein"', modify
recode f11i (-1=.a) (-9=.z)
label define f11i .a `"keine Angabe"', modify
label define f11i .z `"Merkmal nicht erhoben"', modify
label value f11i f11i

label variable f11j "Form der Ladung - Andere Güter"
label define f11j 1 `"ja"', modify
label define f11j 2 `"nein"', modify
recode f11j (-1=.a) (-9=.z)
label define f11j .a `"keine Angabe"', modify
label define f11j .z `"Merkmal nicht erhoben"', modify
label value f11j f11j

label variable f12 "Gewicht der Ladung"
recode f12 (-9=.z) (-1=.a)
label define f12 .z `"Merkmal nicht erhoben"', modify
label define f12 .a `"keine Angabe"', modify
label value f12 f12

label variable f13 "Güterart"
label variable f14 "Fahrtweite"
destring f14, replace
recode f14 (-9=.z) (-1=.a)
label define f14 .z `"Merkmal nicht erhoben"', modify
label define f14 .a `"keine Angabe"', modify
label value f14 f14

label variable f15 "Fahrtdauer"
recode f15 (-9=.z) (-1=.a)
label define f15 .z `"Merkmal nicht erhoben"', modify
label define f15 .a `"keine Angabe"', modify
label value f15 f15

label variable f16 "Art der Fahrt"
label define f16 1 `"Einzelfahrt"', modify
label define f16 2 `"Mehrfahrtenfahrt"', modify
recode f16 (-1=.a) (-9=.z)
label define f16 .a `"keine Angabe"', modify
label define f16 .z `"Merkmal nicht erhoben"', modify
label value f16 f16

label variable f17 "Fahrtabschnitte"

label variable f80 "Geschlecht des Fahrers"
label define f80 1 `"männlich"', modify
label define f80 2 `"weiblich"', modify
recode f80 (-1=.a) (-9=.z)
label define f80 .a `"keine Angabe"', modify
label define f80 .z `"Merkmal nicht erhoben"', modify
label value f80 f80

label variable f81 "Alter des Fahrers"
label define f81 1 `"bis 29 Jahre"', modify
label define f81 2 `"30 bis 44 Jahre"', modify
label define f81 3 `"45 bis 59 Jahre"', modify
label define f81 4 `"60 Jahre und älter"', modify
recode f81 (-1=.a) (-9=.z)
label define f81 .a `"keine Angabe"', modify
label define f81 .z `"Merkmal nicht erhoben"', modify
label value f81 f81

split  f04, parse(":") gen(Abfahrt)
rename Abfahrt1 Ab_std
label variable Ab_std "Abfahrtsstunde"
destring Ab_std, replace
recode Ab_std (-1=.a) (-9=.z)
label define Ab_std .a `"keine Angabe"', modify
label define Ab_std .z `"Merkmal nicht erhoben"', modify
label value Ab_std Ab_std

rename Abfahrt2 Ab_min
label variable Ab_min "Abfahrtsminute"
destring Ab_min, replace
recode Ab_min (-1=.a) (-9=.z)
label define Ab_min .a `"keine Angabe"', modify
label define Ab_min .z `"Merkmal nicht erhoben"', modify
label value Ab_min Ab_min,

split  f10a, parse(":") gen(Ankunft)
rename Ankunft1 An_std
label variable An_std "Ankunftsstunde"
destring An_std, replace
recode An_std (-1=.a) (-9=.z)
label define An_std .a `"keine Angabe"', modify
label define An_std .z `"Merkmal nicht erhoben"', modify
label value An_std An_std

rename Ankunft2 An_min
label variable An_min "Ankunftsminute"
destring An_min, replace
recode An_min(-1=.a) (-9=.z)
label define An_min .a `"keine Angabe"', modify
label define An_min .z `"Merkmal nicht erhoben"', modify
label value An_min An_min


split f10b, parse(".") gen(Dat_an)
rename Dat_an1 An_Tag
rename Dat_an2 An_Monat
rename Dat_an3 An_Jahr
label variable An_Tag "Tag der Ankunft"
label variable An_Monat "Erhebungsmonat"
label variable An_Jahr "Erhebungsjahr"
destring An_Tag, replace
destring An_Monat, replace
destring An_Jahr, replace

recode An_Tag(-1=.a) (-9=.z)
label define An_Tag .a `"keine Angabe"', modify
label define An_Tag .z `"Merkmal nicht erhoben"', modify
label value An_Tag An_Tag

replace An_Monat= .a if f10b == "-1"
replace An_Monat= .z if f10b == "-9"
label define An_Monat .a `"keine Angabe"' , modify
label define An_Monat .z `"Merkmal nicht erhoben"', modify
label value An_Monat An_Monat

replace An_Jahr = .a if f10b == "-1"
replace An_Jahr = .z if f10b == "-9"
label define An_Jahr .a `"keine Angabe"', modify
label define An_Jahr .z `"Merkmal nicht erhoben"', modify
label value An_Jahr An_Jahr


save "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.dta", replace
