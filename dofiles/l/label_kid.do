
use "C:\Sonja_Diss\KiD_2002\Einzelfahrten_040826.dta", clear

label define F01 .b `"keine Angabe: erste Fahrt oder mehr als 12 Fahrten"', modify
label define F01 .a `"keine Angabe"', modify
label value F01 F01

* recode F02B (-1=.a) (-9=.z)
* label define F02B .a `"keine Angabe"', modify
* label define F02B .z `"Merkmal nicht erhoben"', modify
* label value F02B F02B


label define F07A 6 `"p: Fahrt zum Arbeitsplatz"', modify
label define F07A 7 `"p: Fahrt zur Ausbildung"', modify
label define F07A 8 `"p: Privater Einkauf"', modify
label define F07A 9 `"p: Freizeit, Erholung"', modify
label define F07A 10 `"p: Holen, Bringen, Befördern von Personen (privat)"', modify
label define F07A 11 `"p: sonstige private Erledigung"', modify
label define F07A 12 `"p: Fahrt nach Hause"', modify

label define F07A 21 `"dienstlich/geschäftliche Erledigung"', modify
label define F07A 22 `"private Erledigung"', modify
label value F07A F07A

label variable F08A "Zieladresse1"
label variable F08B "Zieladresse2"
label variable F08C "Zieladresse3"
label variable F08D "Zieladresse4"
label variable F08E "Zieladresse5"
label variable F08F "Zieladresse6"



label variable F09 "Art des Ziels"
label define F09 1 `"Umschlagpunkt (Bahnhof, Hafen, GVZ etc.)"', modify
label define F09 2 `"Spedition"', modify
label define F09 3 `"Baustelle"', modify
label define F09 4 `"Eigener Betrieb"', modify
label define F09 5 `"Fremder Betrieb"', modify
label define F09 6 `"Kundenhaushalt"', modify
label define F09 7 `"sonstiges dienstliches/privates Ziel"', modify
label define F09 8 `"privates Ziel"', modify
recode F09 (-1=.a) (-9=.z)
label define F09 .a `"keine Angabe"', modify
label define F09 .z `"Merkmal nicht erhoben"', modify
label value F09 F09

* label variable F10 "Fahrtende - Ankunftszeit"
label variable F10A "Fahrtende - Ankunftszeit: Uhrzeit"
label variable F10B "Ankunftsdatum bei Fahrtende"

* label variable F11 "Form der Ladung"
* recode F11 (-9=.z)
* label define F11 .z `"Merkmal nicht erhoben"', modify
* label value F11 F11

label variable F11A "Form der Ladung - keine Güter"
label define F11A 1 `"ja"', modify
label define F11A 2 `"nein"', modify
recode F11A (-1=.a) (-9=.z)
label define F11A .a `"keine Angabe"', modify
label define F11A .z `"Merkmal nicht erhoben"', modify
label value F11A F11A

label variable F11B "Form der Ladung - Fküssige Massengüter"
label define F11B 1 `"ja"', modify
label define F11B 2 `"nein"', modify
recode F11B (-1=.a) (-9=.z)
label define F11B .a `"keine Angabe"', modify
label define F11B .z `"Merkmal nicht erhoben"', modify
label value F11B F11B

label variable F11C "Form der Ladung - Trockene Massengüter"
label define F11C 1 `"ja"', modify
label define F11C 2 `"nein"', modify
recode F11C (-1=.a) (-9=.z)
label define F11C .a `"keine Angabe"', modify
label define F11C .z `"Merkmal nicht erhoben"', modify
label value F11C F11C

label variable F11D "Form der Ladung - Behälter/Wechselaufbau bis 6m"
label define F11D 1 `"ja"', modify
label define F11D 2 `"nein"', modify
recode F11D (-1=.a) (-9=.z)
label define F11D .a `"keine Angabe"', modify
label define F11D .z `"Merkmal nicht erhoben"', modify
label value F11D F11D

label variable F11E "Form der Ladung - Behälter/Wechselaufbau über 6m"
label define F11E 1 `"ja"', modify
label define F11E 2 `"nein"', modify
recode F11E (-1=.a) (-9=.z)
label define F11E .a `"keine Angabe"', modify
label define F11E .z `"Merkmal nicht erhoben"', modify
label value F11E F11E

label variable F11F "Form der Ladung - Fahrzeuge ohne eigenen Antrieb"
label define F11F 1 `"ja"', modify
label define F11F 2 `"nein"', modify
recode F11F (-1=.a) (-9=.z)
label define F11F .a `"keine Angabe"', modify
label define F11F .z `"Merkmal nicht erhoben"', modify
label value F11F F11F

label variable F11G "Form der Ladung - Fahrzeuge mit eigenem Antrieb"
label define F11G 1 `"ja"', modify
label define F11G 2 `"nein"', modify
recode F11G (-1=.a) (-9=.z)
label define F11G .a `"keine Angabe"', modify
label define F11G .z `"Merkmal nicht erhoben"', modify
label value F11G F11G

label variable F11H "Form der Ladung - Palettiertes Gut"
label define F11H 1 `"ja"', modify
label define F11H 2 `"nein"', modify
recode F11H (-1=.a) (-9=.z)
label define F11H .a `"keine Angabe"', modify
label define F11H .z `"Merkmal nicht erhoben"', modify
label value F11H F11H

label variable F11I "Form der Ladung - Gebundene Güter"
label define F11I 1 `"ja"', modify
label define F11I 2 `"nein"', modify
recode F11I (-1=.a) (-9=.z)
label define F11I .a `"keine Angabe"', modify
label define F11I .z `"Merkmal nicht erhoben"', modify
label value F11I F11I

label variable F11J "Form der Ladung - Andere Güter"
label define F11J 1 `"ja"', modify
label define F11J 2 `"nein"', modify
recode F11J (-1=.a) (-9=.z)
label define F11J .a `"keine Angabe"', modify
label define F11J .z `"Merkmal nicht erhoben"', modify
label value F11J F11J

label variable F12 "Gewicht der Ladung"
recode F12 (-9=.z)
label define F12 .z `"Merkmal nicht erhoben"', modify
label value F12 F12

label variable F13 "Güterart"
label variable F14 "Fahrtweite"
destring F14, replace
recode F14 (-9=.z)
label define F14 .z `"Merkmal nicht erhoben"', modify
label value F14 F14

label variable F15 "Fahrtdauer"
recode F15 (-9=.z)
label define F15 .z `"Merkmal nicht erhoben"', modify
label value F15 F15

label variable F16 "Art der Fahrt"
label define F16 1 `"Einzelfahrt"', modify
label define F16 2 `"Mehrfahrtenfahrt"', modify
recode F16 (-1=.a) (-9=.z)
label define F16 .a `"keine Angabe"', modify
label define F16 .z `"Merkmal nicht erhoben"', modify
label value F16 F16

label variable F17 "Fahrtabschnitte"

label variable F80 "Geschlecht des Fahrers"
label define F80 1 `"männlich"', modify
label define F80 2 `"weiblich"', modify
recode F80 (-1=.a) (-9=.z)
label define F80 .a `"keine Angabe"', modify
label define F80 .z `"Merkmal nicht erhoben"', modify
label value F80 F80

label variable F81 "Alter des Fahrers"
label define F81 1 `"bis 29 Jahre"', modify
label define F81 2 `"30 bis 44 Jahre"', modify
label define F81 3 `"45 bis 59 Jahre"', modify
label define F81 4 `"60 Jahre und älter"', modify
recode F81 (-1=.a) (-9=.z)
label define F81 .a `"keine Angabe"', modify
label define F81 .z `"Merkmal nicht erhoben"', modify
label value F81 F81