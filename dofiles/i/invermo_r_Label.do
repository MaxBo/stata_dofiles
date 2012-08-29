clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\r.dta", clear
label define vorh 1 `"vorhanden"' 0 `"fehlt"'
label define jn 1 `"ja"' 0 `"nein"'

label var ID "Schlüsselnummer des HH (1-7)"
label var Welle "Befragungswelle"
label var Kohorte "Kohorte"
label var persnr "Personennummer im Haushalt"
label var teiln "Teilnehmer an der Erhebung"
label value teiln jn
label var Gruppe "Befragungsgruppe"

label var anzreisebogen "Anz. versendeter Reisebögen"
label var Reisenr "Reisenummer"
label define r_nr 1 `"älteste (Rück-)Reise im Untersuchungszeitraum (blau)"', modify
label define r_nr 0 `"grüner Reisebericht (retrospektiv)"', modify
label define r_nr 2 `"2.-älteste (Rück-)Reise im Untersuchungszeitraum (blau)"', modify
label define r_nr 3 `"3.-älteste (Rück-)Reise im Untersuchungszeitraum (blau)"', modify
label define r_nr 4 `"4.-älteste (Rück-)Reise im Untersuchungszeitraum (blau)"', modify
label define r_nr 5 `"5.-älteste (Rück-)Reise im Untersuchungszeitraum (blau)"', modify
label value Reisenr r_nr

label var Fraboqual "Fragebogenqualität"
label define bew 1 `"gut"' 2 `"befriedigend"' 3 `"mangelhaft"' 4 `"Rückreise editiert"'
label value Fraboqual bew

label var zweck1 "Besuch von Verwandten, Bekannten, Freunden"
label var zweck2 "Einkauf oder private Besorgungen"
label var zweck3 "Pflege der Gesundheit, Kur-, Fitness- o. Klinikaufenthalt"
label var zweck4 "priv. Tagesreise; Besuch v. Sport- o. Kulturveranstaltungen, Städtereise, Ausflug etc"
label var zweck5 "Urlaubsreise, Kurzurlaub"
label var zweck6 "Reise mit mind. 1 Übernachtung zw. Wohnung u. Arbeitsstätte/Bundeswehr-/Zivildienststandort"
label var zweck7 "Dienst- o. Geschäftsreise"
label var zweck8 "sonst. Reisegrund"
label var zweck9 "Schulische Fahrt, Reise, Studienfahrt, Exkursion"
recode zweck? (.=0)
label value zweck? jn

label var planung  "Beginn der Planungen für die Reise"
label define plan 1 `"am Tag des Reisebeginns"', modify
label define plan 2 `"innerhalb der letzten Woche vor Reiebeginn"', modify
label define plan 3 `"innerhalb des letzten Monats vor Reiebeginn"', modify
label define plan 4 `"früherer Zeitpunkt"', modify
label define plan 5 `"keine Reiseplanung"', modify
label define plan 6 `"Reiseplanung wurde von einer anderen Person oder Institution"', modify
label value planung plan

label var info1 "keine Infos notwendig"
label var info2 "Information im Internet"
label var info3 "Information im Reisebüro"
label var info4 "Information im Bahnhof"
label var info5 "Information im Flughafen"
label var info6 "sonstige Informationsquellen"
label var info7 "Info persönlich besorgt (info3-6 ja)"
label var info8 "Info per Fax/Telefon/E-Mail besorgt (info3-6 ja)"
label var info9 "Info auf sonstige Weise besorgt (info3-6 ja)"
recode info? (.=0)
label value info? jn

label var artbuch1 "keine Reservierung, Buchung o. Tickets notwendig"
label var artbuch2 "Buchung/Reservierung per Internet"
label var artbuch3 "Buchung/Reservierung am Bhf am Tag der Abfahrt"
label var artbuch4 "Buchung/Reservierung am Bhf vorm Tag der Abfahrt"
label var artbuch5 "Buchung/Reservierung im Reisebüro"
label var artbuch6 "Buchung/Reservierung am Flughafen"
label var artbuch7 "Buchung/Reservierung sonstige Möglichkeiten"
label var artbuch8 "Buchung/Reservierungpersönlich besorgt (artbuch 3-7 ja)"
label var artbuch9 "Buchung/Reservierung per Fax/Telefon/E-Mail besorgt (artbuch 3-7 ja)"
label var artbuch10 "Buchung/Reservierung auf sonstige Weise besorgt (artbuch 3-7 ja)"

label var buchung1 "Art der Buchung Reservierung"
label define buch1 1 `"Pauschalreise, Hin & Rück sowie Unterkunft in einem Paket"', modify
label define buch1 2 `"Tickets gekauft & separate Unterkunft gebucht"', modify
label define buch1 3 `"Tickets gekauft, aber keine Unterkunft gebucht"', modify
label define buch1 4 `"keine Tickets gekauft, aber Unterkunft gebucht"', modify
label define buch1 5 `"sonstiges"', modify
label value buchung1 buch1
label var buchung2 "sonst. Buchungen für die Reise 1"
label var buchung3 "sonst. Buchungen für die Reise 2"
label var buchung4 "sonst. Buchungen für die Reise 3"
label define buch 1 `"Fort-/Weiterbildung"' 2 `"Mietfahrzeug"' 3`"Eintrittskarten"' 4 `"Campingplatz"' 5 `"Platzreservierung"' 6 `"sonstiges"'
recode buchung? (97=6)
forvalue i=2/4 {
label value buchung`i' buch
}

label var gruppenreise "organisierte Gruppenreise"
recode gruppenreise (2=0)
label value gruppenreise jn

label var anzpers "Anzahl mitreisender Erwachsener"
label var anzkind "davon Anzahl mitreisender Kinder unter 14"
label var anzpershh "davon Anz. Personen aus HH"
label var alterjung "Alter der jüngsten mitreisenden Person"
label var alteralt "Alter der ältesten mitreisenden Person"

label var gepaeck1 "Art des Gepäcktransports bei der Reise"
label define gepaeck 1 `"kein Gepäck o. nur Handgepäck"' 2 `"Gepäck aufgegeben"' 3 `"Gepäck selbst transportiert"'
label value gepaeck1 gepaeck

label var gepaeck2a "Gepäckart: Koffer, Taschen, Rucksäcke"
label var gepaeck2b "Anzahl der Gepäckstücke"
label var gepaeck3a "Fahrräder"
label var gepaeck3b "Anzahl der Fahrräder"
label var gepaeck4a "sonstiges Gepäck 1"
label var gepaeck4b "sonstiges Gepäck 2"
label var gepaeck4c "sonstiges Gepäck 3"
label var gepaeck4d "sonstiges Gepäck 4"
recode gepaeck?a (.=0)
label value gepaeck?a jn

label define gepaeckz 1 `"Kinderbedarf"', modify
label define gepaeckz 2 `"Sportausrüstung"', modify
label define gepaeckz 3 `"Campingausrüstung"', modify
label define gepaeckz 4 `"Möbelstücke"', modify
label define gepaeckz 5 `"Pflanzen/Blumen"', modify
label define gepaeckz 6 `"techn. Geräte"', modify
label define gepaeckz 7 `"Konsumgüter"', modify
label define gepaeckz 8 `"Rollstuhl"', modify
label define gepaeckz 9 `"Arbeitsmaterial"', modify
label define gepaeckz 10 `"Musikinstrumente"', modify
label define gepaeckz 11 `"sonstiges"', modify
recode gepaeck4? (97=11)
label value gepaeck4? gepaeckz

label var umstaende1 "Infos zur Rückreise bei Reisebeginn"
label define rueckr1 1 `"Tag und Uhrzeit der Rückreise standen exakt fest"', modify
label define rueckr1 2 `"Tag der Rückreise stand fest, Uhrzeit nicht"', modify
label define rueckr1 3 `"Tag und Uhrzeit der Rückreise standen nicht fest"', modify
label value umstaende1 rueckr1

label var umstaende2 "hilfsbedürftige Personen mit gesundheitl. Problemen dabei"
recode umstaende2 (2=0)
label value umstaende2 jn

label var tier "Reise mit Tier"
label define tier 0 `"kein Tier"' 1 `"Hund"' 2 `"Katze"' 3 `"Pferd"' 4 `"sonst. Kleintiere"' 5 `"sonstige Großtiere"'
label value tier tier

label var fahrtkosten "Übernahme der Fahrtkosten"
label define fahrtkost 1 `"Reisender selbst"', modify
label define fahrtkost 2 `"Verwandschaft des Reisenden"', modify
label define fahrtkost 3 `"Arbeitgeber/Dienstherren"', modify
label define fahrtkost 4 `"sonst. Personen/Institutionen"', modify
label value fahrtkosten fahrtkost

label var unterkunft "Übernahme Unterkunft/Verpflegung"
label value unterkunft fahrtkost

label var hvm "Hauptverkehrsmittel der Reise"
label define hvm 1 `"Flugzeug (First/Business)"' 2 `"Flugzeug (Eco/Tourist)"' 3 `"Flugzeug (Charter)"', modify
label define hvm 4 `"Autoreisezug"' 5 `"Eisenbahn (1.Kl.)"' 6 `"Eisenbahn (2.Kl.)"', modify
label define hvm 7 `"Reisebus"' 8 `"Fähre/Schiff"' 9 `"Wohnmobil"' 10 `"Mietwagen"' 11 `"Pkw"' 12 `"Pkw mit Wohnwagen"', modify
label define hvm 13 `"Pkw mit sonstigen Anhängern"' 14 `"Lieferwagen/Lkw"' 15 `"Motorrad/Motorroller"', modify
label define hvm 16 `"Fahrrad"' 17 `"sonstiges (ohne Angaben)"' 18 `"Hausboot"', modify
label value hvm hvm

* Zeitverwendung während der Fahrt entfernt, da kein wesentlicher Erkenntnisgewinn heraus erwartet wird
drop zeitverwendung*

label var altvm0 "keine Alternative betrachtet"
recode altvm0 (.=0)
label value altvm0 jn

label define altvm 1 `"Pkw"'  2 `"Eisenbahn"' 3 `"Flugzeug"'  4 `"Fähre"'  5 `"Schiff"' 6 `"ÖV"'  7 `"Reisebus"'  8 `"Mietwagen"'  9 `"Car-Sharing"'  10 `"Sonstige"'
recode altvm? (97=10)

forvalue i=1/3 {
	label var altvm`i' "Alternative Verkehrsmittel `i'"
	label value altvm`i' altvm
}

label var vmgrund1 "zu langsam/zu lange Reisezeit (Entsch. gegen Alt.)"
label var vmgrund2 "zu teuer/zu hohe Kosten (Entsch. gegen Alt.)"
label var vmgrund3 "zu unbequem/zu wenig Komfort (Entsch. gegen Alt.)"
label var vmgrund4 "zu unflexibel (Entsch. gegen Alt.)"
label var vmgrund5 "zu unbequemer Gepäcktransport (Entsch. gegen Alt.)"
label var vmgrund6 "zu anstrengend/nervenaufreibend (Entsch. gegen Alt.)"
label var vmgrund7 "zu aufwendige Vorbereitung (Entsch. gegen Alt.)"
label var vmgrund8 "zu hohe Staugefahr/ geringe Zuverlässigkeit (Entsch. gegen Alt.)"
label var vmgrund9 "mit Kindern zu aufwendig (Entsch. gegen Alt.)"
label var vmgrund10 "mit Tieren zu aufwendig (Entsch. gegen Alt.)"
label var vmgrund11 "Ziel mit dem VM nur schwer erreichbar (Entsch. gegen Alt.)"
label var vmgrund12 "Pkw vor Ort gebraucht (Entsch. gegen Alt.)"
label var vmgrund13 "Pkw war zu dem Zeitpunkt nicht verfügbar (Entsch. gegen Alt.)"
label var vmgrund14 "sonstiges (Entsch. gegen Alt.)"

forvalue i=1/14 {
	recode vmgrund`i' (.=0) if altvm0==0
	label value vmgrund`i' jn
}

label define vmgrund 1 `"Witterungsverhältnisse"' 2 `"keine Direktverbindung/hohe Zahl an Umstiegen"' 3 `"Ziel nur mit genutzten VM erreichbar"', modify
label define vmgrund 4 `"Ziel mit diesem VM nicht erreichbar"' 5 `"zu große Entfernung Wohnsitz Bhf/FH"' 6 `"Sonstige"', modify

forvalue i=15/19 {
	* tempvar  v=`i'-14
	label var vmgrund`i' "sonstiger Grund `i'"
	label value vmgrund`i' vmgrund
	recode vmgrund`i' (97=6)
}

label var kmreise "Anzahl zurückgelegter km"

label var reiseanfsasdat "Reiseanfang Datum"
label var reiseanfsaszeit "Reiseanfang Uhrzeit"
label var reiseendsasdat "Reiseende Datum"
label var reiseendsaszeit "Reiseende Uhrzeit"

* Etappenvariablen entfernt über: Unterbringun, Verlauf, Ausflüge, Zweck; vielleicht einmal Auswertung im Rahmen einer Projekt-/Masterarbeit?
drop  e?verlauf* e?aus* e?zweck* e2* e3*  e4*

label var e1hvm "HVM längster Reiseabschnitt"
label define lvm 6 `"Pkw/Wohnmobil"'  3 `"Eisenbahn"' 1 `"Flugzeug"'  2 `"Autoreisezig"'  5 `"Schiff/Fähre"' 8 `"Lieferwagen/Lkw"', modify  
label define lvm 10 `"Taxi"'  12 `"Bustransfer"' 4 `"Reisebus"'  7 `"Mietwagen"'  9 `"Motorrad"'  11 `"Sonstige"', modify
label value e1hvm lvm

label var e1hvmstart "Startort des gewählten Verkehrsmittels für längsten Reiseabschnitt"
label define estart 1 `"Startflughafen"' 2 `"Startbhf (D)"' 3 `"Starthafen"' 4 `"Startbhf (Ausl.)"' 5 `"Bushaltestelle"'
label value e1hvmstart estart

label var e1hvmziel "Zielort des gewählten Verkehrsmittels für längsten Reiseabschnitt"
label define eziel 1 `"Zielflughafen"' 2 `"Zielbhf (D)"' 3 `"Zielhafen"' 4 `"Zielbhf (Ausl.)"' 5 `"Bushaltestelle"'
label value e1hvmziel eziel

drop e1hvm? e1hvm1?

label var e1flug1 "Startflughafen"
label var e1bahnd1 "Startbhf"
label var e1hafen1 "Starthafen"
label var e1bahna1 "Startbhf (Ausland)"
label var e1bus1 "Startbushaltestelle"

label var e1flug2 "Zielflughafen"
label var e1bahnd2 "Zielbhf"
label var e1hafen2 "Zielhafen"
label var e1bahna2 "Zielbhf (Ausland)"
label var e1bus2 "Zielbushaltestelle"

label define zugang 1  `"Bus"' 2  `"Bustransfer (W1)"' 3  `"Mietwagen"'  4 `"sonstige"'
forvalue i=12/14{
	recode e1vmzu`i' (97=4)
	label value e1vmzu`i' zugang
}

foreach x in "zu" "ab"{
	label var e1vm`x'1 "`x'gang per Fuß"
	label var e1vm`x'2 "`x'gang per Fahrrad"
	label var e1vm`x'3 "`x'gang per Taxi"
	label var e1vm`x'4 "`x'gang per Motorrad"
	label var e1vm`x'5 "`x'gang per Pkw"
	label var e1vm`x'6 "`x'gang per Eisenbahn"
	label var e1vm`x'7 "`x'gang per S-Bahn"
	label var e1vm`x'8 "`x'gang per U-Bahn, Stadtbahn, Straßenbahn, Linienbus"
	label var e1vm`x'9 "`x'gang per Fähre/Schiff"
	label var e1vm`x'10 "`x'gang per Lieferwagen, Lkw"
	label var e1vm`x'15 "`x'gang per Flughafenzubringerbus"
	label var e1vm`x'11 "`x'gang per sonstige"
	label var e1vm`x'12 "`x'gang per sonstige 1"
}

label var e1vmzu13 "zugang per sonstige 2"
label var e1vmzu14 "zugang per sonstige 3"
recode e1vmab12 (97=4)
label value e1vmab12 zugang

foreach x in "zu" "ab"{
	recode e1vm`x'15 (.=0)
	label value e1vm`x'15 jn
	forvalue i=1/12{
		recode e1vm`x'`i' (.=0)
		label value e1vm`x'`i' jn
	}
}

label var e1ub "Fahrt unterbrochen"
recode e1ub (2=0)
label value e1ub jn

drop e1ub? e1ub?ort? e1ub?zeit? e1ub?art* 

label var e1ueb "Übernachtung am Ziel der Etappe"
label value e1ueb jn
label var e1anzueb "Anzahl Übernachtungen am Ort"
label var e1artueb1 "Übernachtung privat (Verwandte, Bekannte, Gastgeber)"
label var e1artueb2 "Übernachtung Hotel, Pension, Ferienwohnung, Jugendherberge"
label var e1artueb3 "Übernachtung Campingplatz"
label var e1artueb4 "Übernachtung Sonstige"

forvalue i=1/4{
	recode e1artueb`i' (.=0)
}

label var e1artueb5 "Übernachtung Sonstige (det.)"
label define artueb  4  `"Unterkunft in Ausbildungsstätte"' 5  `"Nebenwohnsitz"' 6  `"Klinikum, Kurheim"'  8 `"sonstige"' 7 `"Schiff/Hausboot"', modify
label define artueb 1 `"Übernachtung privat (Verwandte, Bekannte, Gastgeber)"' 2 `"Übernachtung Hotel, Pension, Ferienwohnung, Jugendherberge"', modify
label define artueb 3 `"Übernachtung Campingplatz"' 0 `"keine Übernachtung"', modify 
label value e1artueb5 artueb
recode e1artueb5 (1=4) (2=5) (3=6) (4=7) (9=8) (.=8)

* label var zort1 "Reisezielland"
* label var zort "Beginn der Rückfahrt"
label define ort 1 `"Deutschland"' 2 `"Ausland"'
* label value zort1 ort
* label value zort jn

* label var zantag1 "Tag der Ankunft am Reiseziel"
* label var zanmonat1 "Monat der Ankunft am Reiseziel"
* label var zanjahr1 "Jahr der Ankunft am Reiseziel"

* label var zabtag1 "Tag der Abfahrt am Reiseziel"
* label var zabmonat1 "Monat der Abfahrt am Reiseziel"
* label var zabjahr1 "Jahr der Abfahrt am Reiseziel"


* label var zort1db "besuchtes Bundesland (D)"
* label var zort1dc "besuchter Ort (D)"
* label var zort1aa "besuchtes Land"
* label var zort1ac "besuchter Ort (Ausland)"

drop zan* zab* zort*

label var e1start1 "Startort der Reise"
label define reisestart 1 `"Wohnung"' 2 `"Arbeitsplatz"'
label value e1start1 reisestart

label var e1start2 "Startort der Reise (präz.)"
label define reisestart2 1 `"Zweitwohnsitz"' 2 `"Wohnung von Freunden"' 3 `"von Dienstreise aus"'
label value e1start2 reisestart2
drop e1antag
label var e1anmonat "Anreisemonat"
label var e1ziel1 "Ziel der Etappe"
label value e1ziel1 ort
lab var e1ziellancode "Ziel der 1.Etappe (Ländercode)"
lab var e1zielland "Zielland der Etappe"
 
