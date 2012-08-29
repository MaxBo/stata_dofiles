
use "C:\Sonja_Diss\KiD_2002\Einzelfahrten_100623.dta", clear

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
label variable f02a "Quelladresse1"
label variable f02b "Quelladresse2"
label variable f02c "Quelladresse3"
label variable f02d "Quelladresse4"
label variable f02e "Quelladresse5"
label variable f02f "Quelladresse6"

label variable f03 "Art der Quelle"
label define f03 1`"Umschlagpunkt"' 2 `"Spedition"' 3 `"Baustelle"' 4 `"Eigener Betrieb"' 5 `"Fremder Betrieb"' 6 `"Kundenhaushalt"' 7 `"Sonstiger dienstlich/geschäftlicher Ausgangspunkt"' 8 `"Privater Ausgangspunkt"', modify
label define f03 1 `"ja"', modify
label define f03 2 `"nein"', modify
recode f03 (-1=.a) (-9=.z)
label define f03 .a `"keine Angabe"', modify
label define f03 .z `"Merkmal nicht erhoben"', modify
label value f03 f03

label variable f04 "Fahrtbeginn - Abfahrtszeit"

label variable f05 "Fahrzeugbesetzung"
recode f05 (-9=.z)
label define f05 .z `"Merkmal nicht erhoben"', modify
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
label value f07a f07a

label variable f08a "Zieladresse1"
label variable f08b "Zieladresse2"
label variable f08c "Zieladresse3"
label variable f08d "Zieladresse4"
label variable f08e "Zieladresse5"
label variable f08f "Zieladresse6"



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
recode f12 (-9=.z)
label define f12 .z `"Merkmal nicht erhoben"', modify
label value f12 f12

label variable f13 "Güterart"
label variable f14 "Fahrtweite"
destring f14, replace
recode f14 (-9=.z)
label define f14 .z `"Merkmal nicht erhoben"', modify
label value f14 f14

label variable f15 "Fahrtdauer"
recode f15 (-9=.z)
label define f15 .z `"Merkmal nicht erhoben"', modify
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