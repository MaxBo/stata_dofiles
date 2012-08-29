set more off

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_ges.dta", clear

label var id "Schlüsselnummer des HH"
label var sex "Geschlecht der Person (Mann)"
label var alter "Alter der Zielperson in Jahren"
label var gebjahr "Geburtsjahr"
label var phh "Anzahl der Personen im Haushalt"
label var phh18 "Anzahl der Kinder unter 18 Jahren im Haushalt"
label var phh14 "Anzahl der Personen ab 14 Jahren im Haushalt"
label var pberuf "Anzahl berufstätiger im Haushalt"
label var wohnstadt "Wohnort (Gemeinde)"
label var wohnplz "Wohnort (PLZ)"
label var wohngkz "Wohnort (GKZ)"
label var wohnbik "Wohnort (BIK)"
label var wohnew "Einwohnerzahl"
label var wohnlage1 "Wohnlage"
label var kmbahnhof "Entfernung zum nächsten Bahnhof [km]"
label var regionstyp "Regionstyp"
label var kreistyp "Kreistyp"
label var gemeindetyp "Gemeindetyp"
label var pkwhh "Anz. Pkw im Haushalt"
label var pkwhhp "Anz. privater Pkw im Haushalt"
label var pkwhhd "Anz. dienstl. Pkw im Haushalt"
label var carshar "Teilnahme an Carsharing"
label var pkwfuehrer "Pkw-Führerscheinbesitz"
label var pkwhaupt "Teilnehmer ist hauptsächlicher Pkw-Nutzer"
label var pkwbes "Pkw-Besitzverhältnis des genutzten Fahrzeuges"
label var pkwnutz "Nutzungshäufigkeit Pkw"
label var bahncard "Bahncard"
label var zeitkarte "ÖV-Zeitkarte"
label var oevnutz "Nutzungshäufigkeit ÖV"
label var vielflieger "Mitglied im Vielfliegerprogramm"
label var fg1 "Vielflieger Lufthansa"
label var fg2 "Vielflieger Deutsche BA"
label var fg3 "Vielflieger British Airways"
label var fg4 "Vielflieger Eurowings"
label var fg5 "Vielflieger Air France"
label var fg6 "Vielflieger KLM"
label var fg7 "Vielflieger Swissair/Qualiflyer"
label var fg8 "Vielflieger SAS"
label var fg9 "Vielflieger United"
label var fg10 "Vielflieger Delta"
label var fg11 "Vielflieger Asiatischer Carrier"
label var fg12 "Vielflieger - keine Angabe"
label var fg13 "Vielflieger - Sonstige"
label var einkomm "HH-Einkommen [7 Klassen]"
label var einkomme "HH-Einkommen [4 Klassen]"
label var schule "Schulabschluss"
label var akadem "Abgeschlossenes Hochschulstudium"
label var berufaus "Abgeschlossene Berufsausbildung"
label var beruf "Berufsstatus"
label var berufumf "Umfang Berufstätigkeit"
label var arblage1 "Lage des Arbeitsplates"
label var arblandcode "Landescode Arbeitsplatz (Ausland)"

****** ++++++++++++ **************

label var anzurl3m "Anzahl Urlaube letzte 3 Monate"
label var anzurlj "Anzahl Urlaube letzte 12 Monate"
label var urldej "Anzahl Urlaube in D (12M)"
label var urleuj "Anzahl Urlaube in übriges Europa (12M)"
label var urlwej "Anzahl Urlaube in Welt (12M)"
label var urlpkwj "Anzahl Urlaube mit dem Pkw (12M)"
label var urlbahnj "Anzahl Urlaube mit dem Bahn (12M)"
label var urlflugj "Anzahl Urlaube mit dem Flugzeug (12M)"
label var urlbusj "Anzahl Urlaube mit dem Reisebus (12M)"
label var urlsonsj "Anzahl Urlaube mit dem Sonstige (12M)"
label var urlwohnj "Anzahl Urlaube mit dem Wohnmobil (12M)"
label var urlmotj "Anzahl Urlaube mit dem Motorrad (12M)"
label var urlschiffj "Anzahl Urlaube mit dem Schiff (12M)"
label var urlarzugj "Anzahl Urlaube mit dem Pkw im Autoreisezug (12M)"
label var urllkwj "Anzahl Urlaube mit dem Lkw (12M)"
label var urlsons2j "Anzahl Urlaube mit dem Sonstige sonstige (12M)"
label var anzkurl3m "Anzahl Kurzurlaube letzte 3 Monate"
label var anzkurlj "Anzahl Kurzurlaube letzte 12 Monate"
label var kurlde3m "Anzahl Kurzurlaube in D (3M)"
label var kurleu3m "Anzahl Kurzurlaube in übriges Europa (3M)"
label var kurlwe3m "Anzahl Kurzurlaube in Welt (3M)"
label var kurlpkw3m "Anzahl Kurzurlaube mit dem Pkw (3M)"
label var kurlbahn3m "Anzahl Kurzurlaube mit dem Bahn (3M)"
label var kurlflug3m "Anzahl Kurzurlaube mit dem Flugzeug (3M)"
label var kurlbus3m "Anzahl Kurzurlaube mit dem Reisebus (3M)"
label var kurlsons3m "Anzahl Kurzurlaube mit dem Sonstige (3M)"
label var kurlwohn3m "Anzahl Kurzurlaube mit dem Wohnmobil (3M)"
label var kurlmot3m "Anzahl Kurzurlaube mit dem Motorrad (3M)"
label var kurlschiff3m "Anzahl Kurzurlaube mit dem Schiff (3M)"
label var kurlarzug3m "Anzahl Kurzurlaube mit dem Pkw im Autoreisezug (3M)"
label var kurllkw3m "Anzahl Kurzurlaube mit dem Lkw (3M)"
label var kurlsons23m "Anzahl Kurzurlaube mit dem Sonstige sonstige (3M)"
label var kurldej "Anzahl Kurzurlaube in D (12M)"
label var kurleuj "Anzahl Kurzurlaube in übriges Europa (12M)"
label var kurlwej "Anzahl Kurzurlaube in Welt (12M)"
label var kurlpkwj "Anzahl Kurzurlaube mit dem Pkw (12M)"
label var kurlbahnj "Anzahl Kurzurlaube mit dem Bahn (12M)"
label var kurlflugj "Anzahl Kurzurlaube mit dem Flugzeug (12M)"
label var kurlbusj "Anzahl Kurzurlaube mit dem Reisebus (12M)"
label var kurlsonsj "Anzahl Kurzurlaube mit dem Sonstige (12M)"
label var kurlwohnj "Anzahl Kurzurlaube mit dem Wohnmobil (12M)"
label var kurlmotj "Anzahl Kurzurlaube mit dem Motorrad (12M)"
label var kurlschiffj "Anzahl Kurzurlaube mit dem Schiff (12M)"
label var kurlarzugj "Anzahl Kurzurlaube mit dem Pkw im Autoreisezug (12M)"
label var kurllkwj "Anzahl Kurzurlaube mit dem Lkw (12M)"
label var kurlsons2j "Anzahl Kurzurlaube mit dem Sonstige sonstige (12M)"
label var anztar3m "Anzahl Tagesreisen letzte 3 Monate"
label var anztarj "Anzahl Tagesreisen letzte 12 Monate"
label var tarpkw3m "Anzahl Tagesreisen mit dem Pkw (3M)"
label var tarbahn3m "Anzahl Tagesreisen mit dem Bahn (3M)"
label var tarflug3m "Anzahl Tagesreisen mit dem Flugzeug (3M)"
label var tarbus3m "Anzahl Tagesreisen mit dem Reisebus (3M)"
label var tarsons3m "Anzahl Tagesreisen mit dem Sonstige (3M)"
label var tarwohn3m "Anzahl Tagesreisen mit dem Wohnmobil (3M)"
label var tarmot3m "Anzahl Tagesreisen mit dem Motorrad (3M)"
label var tarschiff3m "Anzahl Tagesreisen mit dem Schiff (3M)"
label var tararzug3m "Anzahl Tagesreisen mit dem Pkw im Autoreisezug (3M)"
label var tarlkw3m "Anzahl Tagesreisen mit dem Lkw (3M)"
label var tarsons23m "Anzahl Tagesreisen mit dem Sonstige sonstige (3M)"
label var tarpkwj "Anzahl Tagesreisen mit dem Pkw (12M)"
label var tarbahnj "Anzahl Tagesreisen mit dem Bahn (12M)"
label var tarflugj "Anzahl Tagesreisen mit dem Flugzeug (12M)"
label var tarbusj "Anzahl Tagesreisen mit dem Reisebus (12M)"
label var tarsonsj "Anzahl Tagesreisen mit dem Sonstige (12M)"
label var tarwohnj "Anzahl Tagesreisen mit dem Wohnmobil (12M)"
label var tarmotj "Anzahl Tagesreisen mit dem Motorrad (12M)"
label var tarschiffj "Anzahl Tagesreisen mit dem Schiff (12M)"
label var tararzugj "Anzahl Tagesreisen mit dem Pkw im Autoreisezug (12M)"
label var tarlkwj "Anzahl Tagesreisen mit dem Lkw (12M)"
label var tarsons2j "Anzahl Tagesreisen mit dem Sonstige sonstige (12M)"
label var dir "Grundsätzlich Dienst- oder Geschäftsreisen durchgeführt"
label var anzdir3m "Anzahl Dienstreisen letzte 3 Monate"
label var anzdirj "Anzahl Dienstreisen letzte 12 Monate"
label var dirde3m "Anzahl Dienstreisen in D (3M)"
label var direu3m "Anzahl Dienstreisen in übriges Europa (3M)"
label var dirwe3m "Anzahl Dienstreisen in Welt (3M)"
label var dirpkw3m "Anzahl Dienstreisen mit dem Pkw (3M)"
label var dirbahn3m "Anzahl Dienstreisen mit dem Bahn (3M)"
label var dirflug3m "Anzahl Dienstreisen mit dem Flugzeug (3M)"
label var dirbus3m "Anzahl Dienstreisen mit dem Reisebus (3M)"
label var dirsons3m "Anzahl Dienstreisen mit dem Sonstige (3M)"
label var dirwohn3m "Anzahl Dienstreisen mit dem Wohnmobil (3M)"
label var dirmot3m "Anzahl Dienstreisen mit dem Motorrad (3M)"
label var dirschiff3m "Anzahl Dienstreisen mit dem Schiff (3M)"
label var dirarzug3m "Anzahl Dienstreisen mit dem Pkw im Autoreisezug (3M)"
label var dirlkw3m "Anzahl Dienstreisen mit dem Lkw (3M)"
label var dirsons23m "Anzahl Dienstreisen mit dem Sonstige sonstige (3M)"
label var dirdej "Anzahl Dienstreisen in D (12M)"
label var direuj "Anzahl Dienstreisen in übriges Europa (12M)"
label var dirwej "Anzahl Dienstreisen in Welt (12M)"
label var dirpkwj "Anzahl Dienstreisen mit dem Pkw (12M)"
label var dirbahnj "Anzahl Dienstreisen mit dem Bahn (12M)"
label var dirflugj "Anzahl Dienstreisen mit dem Flugzeug (12M)"
label var dirbusj "Anzahl Dienstreisen mit dem Reisebus (12M)"
label var dirsonsj "Anzahl Dienstreisen mit dem Sonstige (12M)"
label var dirwohnj "Anzahl Dienstreisen mit dem Wohnmobil (12M)"
label var dirmotj "Anzahl Dienstreisen mit dem Motorrad (12M)"
label var dirschiffj "Anzahl Dienstreisen mit dem Schiff (12M)"
label var dirarzugj "Anzahl Dienstreisen mit dem Pkw im Autoreisezug (12M)"
label var dirlkwj "Anzahl Dienstreisen mit dem Lkw (12M)"
label var dirsons2j "Anzahl Dienstreisen mit dem Sonstige sonstige (12M)"
label var anzpreisej "Anzahl Privatreisen letzte 12 Monate"
label var pdej "Anzahl Privatreisen in D (12M)"
label var peuj "Anzahl Privatreisen in übriges Europa (12M)"
label var pwej "Anzahl Privatreisen in Welt (12M)"
label var ppkwj "Anzahl Privatreisen mit dem Pkw (12M)"
label var pbahnj "Anzahl Privatreisen mit dem Bahn (12M)"
label var pflugj "Anzahl Privatreisen mit dem Flugzeug (12M)"
label var pbusj "Anzahl Privatreisen mit dem Reisebus (12M)"
label var psonsj "Anzahl Privatreisen mit dem Sonstige (12M)"
label var anzreisej "Anzahl Reisen pro Jahr"
label var dej "Anzahl Reisen in D (12M)"
label var euj "Anzahl Reisen in übriges Europa (12M)"
label var wej "Anzahl Reisen in Welt (12M)"
label var pkwj "Anzahl Reisen mit dem Pkw (12M)"
label var bahnj "Anzahl Reisen mit dem Bahn (12M)"
label var flugj "Anzahl Reisen mit dem Flugzeug (12M)"
label var busj "Anzahl Reisen mit dem Reisebus (12M)"
label var sonsj "Anzahl Reisen mit dem Sonstige (12M)"
label var ranz "Anzahl der berichteten Reiseereignisse"
label var rreih "Reiseberichte in der richtigen Reihenfolge"
label var rvoll "Reiseberichte vollständig/unterbrochen"

****** ++++++++++++ **************
label var arbland "Landesname des Arbeitsplatz"
label var arbstadtcode "Städtecode Arbeitsplatz (D)"
label var arbstadt "Städtename Arbeitsplatz (D)"
label var arbplz "Stadt (PLZ) Arbeitsplatz (D)"
label var arbgkz "Stadt (GKZ) Arbeitsplatz (D)"
label var arblage2 "Lagebeschreibung des Arbeitsplatzes"
label var arblage3 "Heimarbeit: Wohnsitz ist Arbeitsplatz"
label var kmwohn1zuarb "Entfernung Wohnsitz1 zur Arbeit [km]"
label var kmwohn2zuarb "Entfernung Wohnsitz2 zur Arbeit [km]"
label var arbhaufig "Anzahl Arbeitstage pro Woche"
label var arbvm "Hauptverkehrsmittel (Arbeitswege)"
label var arbnetz "Streckenzeitkarte DB vorhanden"
label var arbaltvm "Nutzung alternativer Verkehrsmittel auf dem Weg zur Arbeit"
label var arbaltvm1 "Fuß (alternativ genutztes VM)"
label var arbaltvm2 "Rad (alternativ genutztes VM)"
label var arbaltvm3 "Pkw-MF (alternativ genutztes VM)"
label var arbaltvm4 "Pkw-F (alternativ genutztes VM)"
label var arbaltvm5 "Motorrad/Moped/Motorroller (alternativ genutztes VM)"
label var arbaltvm6 "Bus, Straßenbahn, U-Bahn (alternativ genutztes VM)"
label var arbaltvm7 "S-Bahn (alternativ genutztes VM)"
label var arbaltvm8 "Bahn (alternativ genutztes VM)"
label var arbaltvm9 "Andere (alternativ genutztes VM)"
label var arbaltvm10 "k.A. (alternativ genutztes VM)"
label var dirnetz "Streckenzeitkarte DB vorhanden"
label var bfv "Fernverkehr im Berufsalltag"
label var bfv100 "Ziele im Berufsalltag"
label var bfvde "Ziele im Berufsalltag in D"
label var bfveu "Ziele im Berufsalltag im übrigen Europa"
label var bfvwe "Ziele im Berufsalltag in der Welt"
label var bfvzielka "keine Angabe zu den beruflichen Reisezielen"
label var bfvhaufig "Häufigkeit beruflicher Reisen pro Woche"
label var bfvpkw "überwiegend Pkw-Nutzung für berufl. Reisen"
label var bfvbahn "überwiegend Bahnnutzung für berufl. Reisen"
label var bfvflug "überwiegend Flugzeugnutzung für berufl. Reisen"
label var bfvbus "überwiegend Bus-/Reisebusnutzung für berufl. Reisen"
label var bfvlkw "überwiegend Lkw-Nutzung für berufl. Reisen"
label var bfvsons "überwiegend Nutzung sonst. VM für berufl. Reisen"
label var bfvvmka "keine Angabe zu überwiegend genutzten VM für berufl. Reisen"
label var zweitw "Zweitwohnsitz vorhanden"
label var zweitwanz "Anz. Nebenwohnsitze"
label var zweitwart "Art des Nebenwohnsitzes"
label var zweitwhaufig "Häufigkeit des Besuchs d. Zweitwohnsitzes"
label var zweitwhaufigbez "Besuchshäufigkeit Zweitwohnsitz in folg. Bezugszeitraum"
label var zweitwaufenthalt "Zeitpunkt des Aufenthalts am Zweitwohnsitz"
label var zweitwlage "Zweitwohnsitz in Deutschland/Ausland"
label var zweitwlandcode "Landescode Zweitwohnsitz (Ausland)"
label var zweitwland "Name des Landes mit Zweitwohnsitz"
label var zweitwstadtcode "Städtecode Zweitwohnsitz (D)"
label var zweitwstadt "Stadtname Zweitwohnsitz (D)"
label var zweitwplz "Stadt (PLZ) Zweitwohnsitz (D)"
label var zweitwgkz "Stadt (GKZ) Zweitwohnsitz (D)"
label var wohnlage2 "Wohnlage im Zweitwohnsitz"
label var km1zu2wohn "Entfernung zw. Erst- u. Zweitwohnsitz"
label var zweitwvm "HVM zw. Erst- und Zweitwohnsitz"
label var pc "Verfügbarkeit PC zu Hause"
label var pcwww "Verfügbarkeit Internnet zu Hause/Arbeitsplatz"


****** ++++++++++++ **************


* Reisenbeschreibung

forvalues i=1/7 {
	label var r`i'dat1 "Grobdifferenzierung der `i'. Reise "
	label var r`i'ueb "Anzahl Übernachten im `i'. Reiseverlauf"
	label var r`i'datymd "Datum der Rückkehr von der `i'. Reise [yymmmdd]"
	label var r`i'datcheck "Genauigkeit des berichteten `i'. Reisedatums"
	label var r`i'zweckgpu "Reisezweck der `i'. Reise"
	label var r`i'zweckp "Reisezweck dienstl.-privat der `i'. Reise"
	
	label var r`i'zweckp1 "Urlaub als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp2 "Eink./Besorg./Erldg. als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp3 "Verwandten-/Bekanntenbesuch als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp4 "Städtreise als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp5 "Besuch sportl./kultur. Veranstaltg. als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp6 "Kur-/Krankenhausaufenthalt als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp7 "Ausflug/Wanderung als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp8 "Besichtgg./Besuch Sehenswürdigkeiten als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp9 "Kongress/Tagung als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp10 "Sonstiges als Reisezweck (privat) der `i'. Reise"
	label var r`i'zweckp11 "k.A. als Reisezweck (privat) der `i'. Reise"

	label var r`i'anzpers "Anzahl Reisender auf der `i'. Reise"
	label var r`i'anzkind "Anzahl Kinder (<14 J.) auf der `i'. Reise"
	
	label var r`i'ziel "Reiseziel der `i'. Reise" 
	label var r`i'ziellandcode "Landescode Reiseziel Ausland"
	label var r`i'zielland "Name des besuchten Landes auf der `i'. Reise"
	label var r`i'zielstadtcode "Stadtcode Reiseziel Deutschland auf der `i'. Reise"
	label var r`i'zielstadt "Name des besuchten Stadt auf der `i'. Reise"
	label var r`i'zielstadtplz "Stadt (PLZ) Reiseziel Deutschland auf der `i'. Reise"
	label var r`i'zielstadtgkz "Stadt (GKZ) auf der `i'. Reise"
	label var r`i'dist "Entfernung zum Reiseziel auf der `i'. Reise"
	label var r`i'vm "Hauptverkehrsmittel auf der `i'. Reise"
	label var r`i'vmwahl "Gründe für die Verkehrsmittelwahl auf der `i'. Reise"	
	label var r`i'vmzu "Hauptzugangsverkehrsmittel auf der `i'. Reise (DIW-Kode)"	
	label var r`i'vmzu1 "Fuß (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu2 "Fahrrad (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu3 "Pkw-MF (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu4 "Pkw-F (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu5 "MRad/Moped/Motorroller (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu6 "Bus, Straßenbahn, U-Bahn (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu7 "S-Bahn (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu8 "Bahn (ZugangsVM) auf der `i'. Reise"	
	label var r`i'vmzu10 "k.A. (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu11 "Taxi (ZugangsVM) auf der `i'. Reise"
	label var r`i'vmzu12 "Flughafentransfer (ZugangsVM) auf der `i'. Reise"	
}

************+++++++++********************
* Label für Variablen, Umcodierung

label define hhlage 1 `"innerer Stadtbereich einer Großstadt"', modify 
label define hhlage 2 `"Stadtrand bzw. Vorort Großstadt"', modify 
label define hhlage 3 `"innerer Stadtbereich einer mittelgroßen Stadt"', modify
label define hhlage 4 `"Stadtrand bzw. Vorort mittelgroße Stadt"', modify
label define hhlage 5 `"Kleinstadt bzw. große Gemeinde"', modify
label define hhlage 6 `"auf dem Land bzw. kleine Landgemeinde"', modify
label define hhlage .a `"keine Angabe"', modify
recode wohnlage1 (7=.a)
label value wohnlage1 hhlage  

label define sex 1 `"männlich"' 0 `"weiblich"'
recode sex (2=0)
label value sex sex

label define kA .a `"k.A."', modify
label define jnkA .a `"k.A."' 1 `"ja"' 0`"nein"' , modify

recode kmbahnhof (999=.a)
label value kmbahnhof kA

foreach x in "alter" "phh" "phh18" "pberuf" "wohnbik" {
	recode `x' (0=.a)
	label value `x' kA
}

foreach x in "carshar" "pkwfuehrer" "pkwhaupt" "pkwbes" "zeitkarte" "vielflieger" "akadem" "berufaus" "arbaltvm" "pc" "pcwww" "zweitw" "dir"{
	recode `x' (3=.a) (2=0)
	label value `x' jnkA
}



label define regionstyp 1 "hochverdichtete Agglomerationsräume" 2 "Agglomerationsräume mit herausragenden Zentren" 3 "Verstädterte Räume höherer Dichte" 4 "Verstädterte Räume mittlerer Dichte mit gr. Oberzentrum", modify
label define regionstyp 5 "Verstädterte Räume mittlerer Dichte ohne gr. Oberzentrum" 5 "Ländl. Räume höherer Dichte" 6 "Ländl. Räume geringerer Dichte", modify
label value regionstyp regionstyp

label define kreistyp 1 "Agglomerationsraum: Kernfläche" 2 "AR: Hochverdichtete Kreise" 3 "AR: Verdichtete Kreise" 4 "AR: Ländl. Kreise" /*
*/ 5 "Verstädterte Räume: Kernstädte" 6 "VR: Verdichtet Kreise"  7 "VR: Ländliche Fläche"  8 "Ländl. Räume: ländl. Kreise höherer Dichte" /* 
*/ 9 "LR: ländl. Kreise geringerer Dichte", modify
label value kreistyp kreistyp

label define gemeindetyp 1 "Agglomerationsraum Kernstadt > 500.00 EW" 2 "AR Kernstadt < 500.00 EW" 3 "AR Hochverdichtete Kreise: Ober-Mittelzentren" 4 "AR Hochverdichtete Kreise: sonstige Gemeinden" /* 
*/ 5 "AR Verdichtete Kreise: Ober-Mittelzentren" 6 "AR Verdichtete Kreise: sonstige Gemeinden" 7 "AR Ländliche Kreise: Ober-Mittelzentren" 8 "AR Ländliche Kreise: sonstige Gemeinden" /*
*/ 9 "Verstädterte Räume: Kernstädte"   10 "VR Verdichtete Kreise: Ober-Mittelzentren" 11 "VR Verdichtete Kreise: sonstige Gemeinden" 12 "VR Ländliche Kreise: Ober-Mittelzentren"  /* 
*/ 13 "VR Ländliche Kreise: sonstige Gemeinden" 14 "Ländliche Räume Ländliche Kreise höherer Dichte: Ober-Mittelzentren" 15 "LR Ländliche Kreise höherer Dichte: sonstige Gemeinden" /* 
*/ 16 "LR Ländliche Kreise geringer Dichte: Ober-Mittelzentren" 17 "LR Ländliche Kreise geringer Dichte: sonstige Gemeinden", modify
label value gemeindetyp gemeindetyp

label define pkwbes 1 "priv. Pkw" 2 "priv. genutzter Firmenwagen" .a "k.A.", modify
recode pkwbes (3=.a)
label value pkwbes pkwbes

label define pkwnutz 1 "(fast) immer" 2 "gelegentlich" 3 "(fast) nie" .a "k.A.", modify
recode pkwnutz (4=.a)
label value pkwnutz pkwnutz

label define bahncard 1 "Ja" 2 "Nein" 3 "Nein, aber Kaufabsicht" 4 "Nein, nicht mehr" .a "k.A.", modify
recode bahncard (5=.a)
label value bahncard bahncard
recode bahncard (1=1 "ja") (2/4=0 "nein"), gen(bahncard_jn)


label define oevnutz 1 "nie" 2 "selten" 3 "gelegentlich" 4 "häufig" .a "k.A.", modify
recode oevnutz (5=.a)
label value oevnutz oevnutz

label define einkomm 1 "< 1500 DM" 2 "[1500,3000) DM" 3 "[3000,4500) DM" 4 "[4500,6000) DM" 5 "[6000,7500) DM" 6 ">7500 DM" .a "k.A.", modify
recode einkomm (7=.a)
label value einkomm einkomm

label define einkomme 1 "< 1500 DM / 750€" 2 "[1500,3000) DM / [750,1500)€" 3 "[3000,6000) DM / [1500,3000)€" 4 "> 6000 DM/ > 3000€", modify
label value einkomme einkomme

label define beruf 1 `"Berufstätig"', modify
label define beruf 2 `"Auszubildender/Lehrling"', modify
label define beruf 3 `"Bundeswehr, Zivildienst, soz. Jahr"', modify
label define beruf 4 `"Schüler"', modify
label define beruf 5 `"Fachschüler"', modify
label define beruf 6 `"Student"', modify
label define beruf 7 `"arbeitslos"', modify
label define beruf 8 `"Rentner"', modify
label define beruf 9 `"Hausfrau /-mann"', modify
label define beruf 10 `"Sonstige"', modify
label define beruf .a `"k.A."', modify
recode beruf (11=.a)
label value beruf beruf

label define berufumf 1 "Vollzeit" 2 "Teilzeit (15h-34h)" 3 "Teilzeit (<15h)" .a "k.A.", modify
recode berufumf (4=.a)
label value berufumf berufumf

label define schule 1 `"Haupt- oder Volksschule"' 3 `"mittl. Reife, POS"' 4 `"Abitur, Fachhochschulreife"' 2 `"weiterführende Schule (ohne Abschluss)"' .a `"k.A."'
recode schule (5=.a)
label value schule schule


label define arblage1 1 "im Ausland" 2 "innerhalb Deutschlands" .a "k.A.", modify
recode arblage1 (3=.a)
label value arblage1 arblage1

label define arblage2 1 `"innerer Stadtbereich einer Großstadt"', modify 
label define arblage2 2 `"Stadtrand bzw. Vorort Großstadt"', modify 
label define arblage2 3 `"innerer Stadtbereich einer mittelgroßen Stadt"', modify
label define arblage2 4 `"Stadtrand bzw. Vorort mittelgroße Stadt"', modify
label define arblage2 5 `"Kleinstadt bzw. große Gemeinde"', modify
label define arblage2 6 `"auf dem Land bzw. kleine Landgemeinde"', modify
label define arblage2 7 `"Sonstiges"', modify
label define arblage2 .a `"keine Angabe"', modify
recode arblage2 (8=.a)
label value arblage2 arblage2  
 
label define arblage3 1 "am 1. Wohnsitz" 2 "am 2. Wohnsitz/Aufenthaltsort" .a "k.A."
recode arblage3 (3=.a)
label value arblage3 arblage3

label define arbvm 1 "zu Fuß" 2 "Fahrrad" 3 "Pkw-MF" 4 "Pkw-F" 5 "Motorrad/Moped/Roller" 6 "Bus, Straßenbahn, U-Bahn", modify
label define arbvm 7 "S-Bahn (DB)" 8 "Bahn" 9 "Anderes" .a "k.A.", modify
recode arbvm (10=.a)
label value arbvm arbvm

label define arbnetz 1 "Streckenzeitkarte" 2 "Netzkarte" 3 "Teilnetzkarte" 4 "Nein" .a "k.A.", modify
recode arbnetz (5=.a)
recode dirnetz (5=.a)
label value arbnetz arbnetz
label value dirnetz arbnetz

label define bfv 1 "im PV oder GV tätig" 2 "Handelsvertreter oder Außendienst" 3 "nichts von dem trifft zu" .a "k.A.", modify
label value bfv bfv
recode bfv (4=.a)

label define bfv100 1 "<=100km" 2 ">100km" .a "k.A.", modify
label value bfv100 bfv100
recode bfv100 (3=.a)

label define zweitwanz 1 "einen Nebenwohnsitz" 2 "mehrere Nebenwohnsitze" .a "k.A.", modify
recode zweitwanz (3=.a)
label value zweitwanz zweitwanz

label define zweitwart 1 "Ferienwohnung, Freitzeitdomizil" 2 "Arbeits-/Ausbildungsplatz nahe Unterkunft" 3 "bei Eltern", modify
label define zweitwart 4 "Wohnung des Lebenspartners (Fernbeziehung)" 5 "Zivildienst" 6 "Sonstige" .a "k.A.", modify
recode zweitwart (7=.a)
label value zweitwart zweitwart

label define zweitwhaufigbez 1 "Jahr" 2 "Monat" 3 "Woche" .a "k.A.", modify
recode zweitwhaufigbez (0=.a)
label value zweitwhaufigbez zweitwhaufigbez

label define zweitwaufenthalt 1 "werktags/unter der Woche" 2 "Wochenende" 3 "Urlaub" 4 "Sonstiges" .a "k.A.", modify
recode zweitwaufenthalt (5=.a)
label value zweitwaufenthalt zweitwaufenthalt

recode zweitwlage (3=.a)
label value zweitwlage arblage1

recode wohnlage2 (7=.a)
label value wohnlage2  hhlage

label define zweitwvm 1 "Pkw" 2 "Bahn" 3 "Flugzeug" 4 "Reisezug" 5 "Wohnmobil" 6 "Motorrad/Moped/Roller" 7 "Mietwagen" 8 "Schiff", modify
label define zweitwvm 9 "Pkw mit Autoreisezug" 10 "andere" 11 "Lkw" .a "k.A.", modify
recode zweitwvm (12=.a)
label value zweitwvm zweitwvm


label define rdat1 1 "heute" 2 "2 innerhalb der letzten 7 Tage" 3 "länger her" .a "k.A." 5 "keine weiteren Reisen"
recode r?dat1 (4=.a)
label value r?dat1 rdat1

label define rzweck 1 "dienstlich" 2 "privat" 3 "Urlaub" 4 "Tagesreise".a "k.A.", modify
label value r?zweckgpu rzweck
recode r?zweckp (1=2) (2=1) (3=.a)
label value r?zweckp rzweck

label define rziel 1 "Ausland" 2 "innerhalb Deutschlands" .a "k.A."
recode r?ziel (3=.a)
label value r?ziel rziel

label define rvm 1 "Pkw" 2 "Bahn" 3 "Flugzeug" 4 "Reisezug" 8 "Wohnmobil" 7 "Motorrad/Moped/Roller" 7 "Mietwagen" 10 "Schiff", modify
label define rvm 5 "andere" 9 "Lkw/Lieferwagen" .a "k.A.", modify
recode r?vm (6=.a)
label value r?vm rvm

label define gründe 1 "kurze Reisezeit" 2 "geringe Kosten" 3 "Komfort" 4 "hohe Flexibilität" .a "k.A.", modify
recode r?vmwahl (5=.a)
label value r?vmwahl gründe

label define rvmzu 1 "zu Fuß" 2 "Fahrrad" 3 "Pkw-MF" 4 "Pkw-F" 5 "Motorrad/Moped/Roller" 6 "Bus, Straßenbahn, U-Bahn" 7 "S-Bahn" 8 "Bahn", modify
label define rvmzu 10 "Taxi" 11 "Flughafentransfer" .a "k.A.", modify
recode r?vmzu (9=.a)
label value r?vmzu rvmzu

***********************+++++++++++++++++++*********************************
* Neue Variablen für Parameterschätzungen

gen alter2 = alter*alter
replace phh=phh14 if missing(phh) & phh14>0 & phh14<. & missing(phh18)

gen diff14 = phh - phh14

gen hhtyp_3 = 1 if phh==1
replace hhtyp_3 = 2 if diff14>0 & diff14<.
replace hhtyp_3 = 3 if diff14==0 & phh>1 & phh<.
label define hhtyp_3 1 "Einpersonen-HH" 2 "Haushalt mit Kind" 3 "Mehrpersonen-HH (Erw.)"
label value hhtyp_3 hhtyp_3
label var hhtyp_3 "Haushaltsptyp (3 Kategorien)"

* drop diff14

recode einkomm (1=1 "750€") (2=2 "[750,1500)€") (3 4= 3 "[1500,3000)€") (5 6=4 ">3000 €"), gen(hheink)
replace hheink=einkomme if einkomme<.

recode berufumf (1=1 "Berufstätig - Vollzeit") (2 3= 2 "Berufstätig - Teilzeit") (.=0 "nicht berufstätig"), gen(p_beruf)

recode beruf (1=1 "Berufstätig - Vollzeit") (1=2 "Berufstätig - Teilzeit")  ( 2/5=4 "Schüler/Azubi/Zivi") (6=5 "Student") (7 9 10=6 "nicht berufstätig") (8=7 "Rentner"), gen(perg)
replace perg=2 if p_beruf==2


replace anztarj=0 if missing(anztarj)
replace anzurlj=0 if missing(anzurlj)
replace anzkurlj=0 if missing(anzkurlj)
replace anzdirj=0 if missing(anzdirj)

replace anzreisej=anztarj+anzurlj+anzkurlj+anzdirj

replace dej = anzreisej - euj - wej if missing(dej) & euj<. & wej<.
replace euj = anzreisej - dej - wej if missing(euj) & dej<. & wej<.
replace wej = anzreisej - euj - dej if missing(wej) & euj<. & dej<.

replace dej = anztarj if missing(dej) & missing(urldej) & missing(kurldej) & missing(dirdej) 
replace dej = anztarj + urldej + dirdej if missing(dej) & missing(kurldej)  

gen ant_tr = anztarj/anzreisej
gen ant_url = anzurlj/anzreisej
gen ant_kurl = anzkurlj /anzreisej
gen ant_dr = anzdirj /anzreisej

foreach x in "ant_tr" "ant_url" "ant_kurl" "ant_dr"{
	replace `x'=0 if missing(`x')
	recode `x'(0/0.25=1 "<25%") (0.25/0.5=2 "25% - 50%") (0.5/0.75=3 "50% - 75%") (0.75/1=4 "75% - 100%"), gen(`x'_4)
}

gen reise = anzreisej==0

gen anzreisej_grupp = anzreisej
* recode anzreisej (0=0 "keine")


* Schätzung der Anzahl Reisen im Jahr (allgemein)
* Vielleicht besser gleich Anzahl Dienstreisen, Privat- und Urlaubsreisen gleichzeitig mit nested logit?




* nbreg  anzreisej  alter alter2  i.sex i.hheink i.perg i.hhtyp_3 zweitw if anzreisej<=100, dispersion(mean) nolog

* twoway 
* */ (histogram dej if dej<10, width(1) color(blue) fraction  legend( label (1 "Deutschland") symxsize(7) size(small) ) ) /*
* */ (histogram euj if euj<10, width(1) color(olive) fraction legend( label (2 "Europa") symxsize(7) size(small) ) ) /*
* */ (histogram wej if wej<10, width(1) color(gold) fraction  legend( label (3 "Welt") symxsize(7) size(small) ) )


foreach x in "de" "eu" "we" {
	cumul `x'j, gen(cum_`x')
}

* stack cum_eu euj cum_w wej cum_d dej, into(c Anz_Reise_Jahr) wide clear

* foreach x in "de" "eu" "we" {
* 	gen bew_`x' = 1- cum_`x'
* }
* line bew_d bew_eu bew_we Anz_Reise_Jahr if Anz_Reise_Jahr<50, sort

forvalues i=1/7 {
	rename r`i'dat1 r1dat`i'
	rename r`i'ueb rueb`i'
	rename r`i'datymd rdatymd`i'
	rename r`i'datsas rdatsas`i'
	rename r`i'datcheck rdatcheck`i'
	rename r`i'zweckgpu rzweckgpu`i'
	rename r`i'zweckp rzweckp`i'
	rename r`i'anzpers ranzpers`i'
	rename r`i'anzkind ranzkind`i'
	rename r`i'ziel rziel`i'
	rename r`i'ziellandcode rziellandcode`i'
	rename r`i'zielland rzielland`i'
	rename r`i'zielstadtcode rzielstadtcode`i'
	rename r`i'zielstadt rzielstadt`i'
	rename r`i'zielstadtplz rzielstadtplz`i'
	rename r`i'zielstadtgkz rzielstadtgkz`i'
	rename r`i'dist rdist`i'
	rename r`i'vm rvm`i'
	rename r`i'vmzu rvmzu`i'
	rename r`i'vmwahl rvmwahl`i'
	
		forvalue q=1/12 {
		rename r`i'vmzu`q' rvm`q'zu`i'
		}
		
		forvalue q=1/11 {
		rename r`i'zweckp`q' rzweck`q'p`i'
		}
}

recode perg (1=1 "Vollzeit berufstätig") (2=2 "Teilzeit berufstätig") (4 5 = 5 "Ausbildung") (6=3 "ohne Arbeit")  (7=4 "Rente"), gen(besch)
* recode besch (1 2 = 1 "in Arbeit") (3=2 "ohne Arbeit") (5=3 "in Ausbildung") (4=4 "Rente"), gen(besch_2)
gen rentner = besch==4 | alter>62
label value rentner jn
gen pkw_verf = pkwhh>0

recode schule (1 2 3 = 1 "Schule ohne Beruf") (4=2 "Abi, Fachabi"), gen(bildung)
replace bildung = 3 if berufaus==1
replace bildung = 4 if akadem==1
replace bildung = 5 if (perg==5 | perg==4)
label define bildung 3 "Berufsausbildung" 4 "Uniabschluss" 5 "in Ausbildung", add modify
recode bildung (1 2 = 1 "Schule ohne Beruf") (3=2 "Berufsausbildung") (4=3 "Uniabschluss") (5=4 "in Ausbildung"), gen(bildung_2)
replace pkwbes=0 if missing(pkwbes)
gen dirj = anzdirj>0 
label var dirj "Person mit mind. 1 Dienstreise im Jahr"
gen anzdir = anzdirj if anzdirj>0
label var anzdir "Anzahl Dienstreisen im Jahr, wenn mind. 1 Dienstreise angetreten" 
recode gemeindetyp (1 2= 1 "AR: Kernstadt") (3 4= 2 "AR: Hochverdichteter Kreis") (5 6 = 3 "AR: Verdichteter Kreis") (7 8 = 4 "AR: ländl. Kreis") /*
*/ (9 10 11= 5 "VR: Stadt") (12 13=6 "VR: Land") (14/17=7 "Land"), gen(gemeindetyp2)
recode gemeindetyp (1/8=1 "AR") (9/13=2 "VR") (14/17=3 "LR"), gen(rtyp)
recode gemeindetyp (1/4=1 "AR: Stadt") (5/8=2 "AR: Land") (9/13=3 "VR") (14/17=4 "LR"), gen(rtyp2)
recode rtyp2 (1=1 "AR:Stadt") (2=2 "AR:Land") (3 4 =3 "sonst."), gen(rtyp3)
recode besch (1=1 "Vollzeit") (2=2 "Teilzeit"), gen(besch_dr)

gen wbland = substr(wohngkz,1,2)
destring wbland, replace
label define bland 1 "Schleswig-Holstein" 2 "Hamburg" 3 "Niedersachsen" 4 "Bremen" 5 "Nordrhein-Westfalen" 6 "Hessen" 7 "Rheinland-Pfalz" /*
*/ 8 "Baden-Württemberg" 9 "Bayern" 10 "Saarland" 11 "Berlin" 12 "Brandenburg" 13 "Mecklenburg-Vorpommern" 14 "Sachsen" 15 "Sachsen-Anhalt" 16 "Thüringen", modify
label value wbland bland
gen wkreis =substr(wohngkz,1,5)
destring wkreis, replace
label define kkz 1001 "Flensburg" ,modify
label define kkz 1002 "Kiel" ,modify
label define kkz 1003 "Lübeck" ,modify
label define kkz 1004 "Neumünster" ,modify
label define kkz 1051 "Dithmarschen" ,modify
label define kkz 1053 "Herzogtum Lauenburg" ,modify
label define kkz 1054 "Nordfriesland" ,modify
label define kkz 1055 "Ostholstein" ,modify
label define kkz 1056 "Pinneberg" ,modify
label define kkz 1057 "Plön" ,modify
label define kkz 1058 "Rendsburg-Eckernförde" ,modify
label define kkz 1059 "Schleswig-Flensburg" ,modify
label define kkz 1060 "Segeberg" ,modify
label define kkz 1061 "Steinburg" ,modify
label define kkz 1062 "Stormarn" ,modify
label define kkz 2000 "Hamburg" ,modify
label define kkz 3101 "Braunschweig" ,modify
label define kkz 3102 "Salzgitter" ,modify
label define kkz 3103 "Wolfsburg" ,modify
label define kkz 3151 "Gifhorn" ,modify
label define kkz 3152 "Göttingen" ,modify
label define kkz 3153 "Goslar" ,modify
label define kkz 3154 "Helmstedt" ,modify
label define kkz 3155 "Northeim" ,modify
label define kkz 3156 "Osterode am Harz" ,modify
label define kkz 3157 "Peine" ,modify
label define kkz 3158 "Wolfenbüttel" ,modify
label define kkz 3201 "Hannover" ,modify
label define kkz 3251 "Diepholz" ,modify
label define kkz 3252 "Hameln-Pyrmont" ,modify
label define kkz 3253 "Hannover" ,modify
label define kkz 3254 "Hildesheim" ,modify
label define kkz 3255 "Holzminden" ,modify
label define kkz 3256 "Nienburg (Weser)" ,modify
label define kkz 3257 "Schaumburg" ,modify
label define kkz 3351 "Celle" ,modify
label define kkz 3352 "Cuxhaven" ,modify
label define kkz 3353 "Harburg" ,modify
label define kkz 3354 "Lüchow-Dannenberg" ,modify
label define kkz 3355 "Lüneburg" ,modify
label define kkz 3356 "Osterholz" ,modify
label define kkz 3357 "Rotenburg (Wümme)" ,modify
label define kkz 3358 "Soltau-Fallingbostel" ,modify
label define kkz 3359 "Stade" ,modify
label define kkz 3360 "Uelzen" ,modify
label define kkz 3361 "Verden" ,modify
label define kkz 3401 "Delmenhorst" ,modify
label define kkz 3402 "Emden" ,modify
label define kkz 3403 "Oldenburg (Oldenburg)" ,modify
label define kkz 3404 "Osnabrück" ,modify
label define kkz 3405 "Wilhelmshaven" ,modify
label define kkz 3451 "Ammerland" ,modify
label define kkz 3452 "Aurich" ,modify
label define kkz 3453 "Cloppenburg" ,modify
label define kkz 3454 "Emsland" ,modify
label define kkz 3455 "Friesland" ,modify
label define kkz 3456 "Grafschaft Bentheim" ,modify
label define kkz 3457 "Leer" ,modify
label define kkz 3458 "Oldenburg" ,modify
label define kkz 3459 "Osnabrück" ,modify
label define kkz 3460 "Vechta" ,modify
label define kkz 3461 "Wesermarsch" ,modify
label define kkz 3462 "Wittmund" ,modify
label define kkz 4011 "Bremen" ,modify
label define kkz 4012 "Bremerhaven" ,modify
label define kkz 5111 "Düsseldorf" ,modify
label define kkz 5112 "Duisburg" ,modify
label define kkz 5113 "Essen" ,modify
label define kkz 5114 "Krefeld" ,modify
label define kkz 5116 "Mönchengladbach" ,modify
label define kkz 5117 "Mülheim an der Ruhr" ,modify
label define kkz 5119 "Oberhausen" ,modify
label define kkz 5120 "Remscheid" ,modify
label define kkz 5122 "Solingen" ,modify
label define kkz 5124 "Wuppertal" ,modify
label define kkz 5154 "Kleve" ,modify
label define kkz 5158 "Mettmann" ,modify
label define kkz 5162 "Neuss" ,modify
label define kkz 5166 "Viersen" ,modify
label define kkz 5170 "Wesel" ,modify
label define kkz 5313 "Aachen" ,modify
label define kkz 5314 "Bonn" ,modify
label define kkz 5315 "Köln" ,modify
label define kkz 5316 "Leverkusen" ,modify
label define kkz 5354 "Aachen" ,modify
label define kkz 5358 "Düren" ,modify
label define kkz 5362 "Erftkreis" ,modify
label define kkz 5366 "Euskirchen" ,modify
label define kkz 5370 "Heinsberg" ,modify
label define kkz 5374 "Oberbergischer Kreis" ,modify
label define kkz 5378 "Rheinisch-Bergischer Kreis" ,modify
label define kkz 5382 "Rhein-Sieg-Kreis" ,modify
label define kkz 5512 "Bottrop" ,modify
label define kkz 5513 "Gelsenkirchen" ,modify
label define kkz 5515 "Münster" ,modify
label define kkz 5554 "Borken" ,modify
label define kkz 5558 "Coesfeld" ,modify
label define kkz 5562 "Recklinghausen" ,modify
label define kkz 5566 "Steinfurt" ,modify
label define kkz 5570 "Warendorf" ,modify
label define kkz 5711 "Bielefeld" ,modify
label define kkz 5754 "Gütersloh" ,modify
label define kkz 5758 "Herford" ,modify
label define kkz 5762 "Höxter" ,modify
label define kkz 5766 "Lippe" ,modify
label define kkz 5770 "Minden-Lübbecke" ,modify
label define kkz 5774 "Paderborn" ,modify
label define kkz 5911 "Bochum" ,modify
label define kkz 5913 "Dortmund" ,modify
label define kkz 5914 "Hagen" ,modify
label define kkz 5915 "Hamm" ,modify
label define kkz 5916 "Herne" ,modify
label define kkz 5954 "Ennepe-Ruhr-Kreis" ,modify
label define kkz 5958 "Hochsauerlandkreis" ,modify
label define kkz 5962 "Märkischer Kreis" ,modify
label define kkz 5966 "Olpe" ,modify
label define kkz 5970 "Siegen-Wittgenstein" ,modify
label define kkz 5974 "Soest" ,modify
label define kkz 5978 "Unna" ,modify
label define kkz 6411 "Darmstadt-Dieburg" ,modify
label define kkz 6411 "Darmstadt" ,modify
label define kkz 6412 "Frankfurt am Main" ,modify
label define kkz 6413 "Offenbach am Main" ,modify
label define kkz 6413 "Offenbach" ,modify
label define kkz 6414 "Wiesbaden" ,modify
label define kkz 6431 "Bergstraße" ,modify
label define kkz 6432 "Darmstadt-Dieburg" ,modify
label define kkz 6433 "Groß-Gerau" ,modify
label define kkz 6434 "Hochtaunuskreis" ,modify
label define kkz 6435 "Main-Kinzig-Kreis" ,modify
label define kkz 6436 "Main-Taunus-Kreis" ,modify
label define kkz 6437 "Odenwaldkreis" ,modify
label define kkz 6438 "Offenbach" ,modify
label define kkz 6439 "Rheingau-Taunus-Kreis" ,modify
label define kkz 6440 "Wetteraukreis" ,modify
label define kkz 6531 "Gießen" ,modify
label define kkz 6532 "Lahn-Dill-Kreis" ,modify
label define kkz 6533 "Limburg-Weilburg" ,modify
label define kkz 6534 "Marburg-Biedenkopf" ,modify
label define kkz 6535 "Vogelsbergkreis" ,modify
label define kkz 6611 "Kassel" ,modify
label define kkz 6631 "Fulda" ,modify
label define kkz 6632 "Hersfeld-Rotenburg" ,modify
label define kkz 6633 "Kassel" ,modify
label define kkz 6634 "Schwalm-Eder-Kreis" ,modify
label define kkz 6635 "Waldeck-Frankenberg" ,modify
label define kkz 6636 "Werra-Meißner-Kreis" ,modify
label define kkz 7111 "Mayen-Koblenz" ,modify
label define kkz 7111 "Koblenz" ,modify
label define kkz 7131 "Ahrweiler" ,modify
label define kkz 7132 "Altenkirchen (Westerwald)" ,modify
label define kkz 7133 "Bad Kreuznach" ,modify
label define kkz 7134 "Birkenfeld" ,modify
label define kkz 7135 "Cochem-Zell" ,modify
label define kkz 7137 "Mayen-Koblenz" ,modify
label define kkz 7138 "Neuwied" ,modify
label define kkz 7140 "Rhein-Hunsrück-Kreis" ,modify
label define kkz 7141 "Rhein-Lahn-Kreis" ,modify
label define kkz 7143 "Westerwaldkreis" ,modify
label define kkz 7211 "Trier-Saarburg" ,modify
label define kkz 7211 "Trier" ,modify
label define kkz 7231 "Bernkastel-Wittlich" ,modify
label define kkz 7232 "Bitburg-Prüm" ,modify
label define kkz 7233 "Daun" ,modify
label define kkz 7235 "Trier-Saarburg" ,modify
label define kkz 7311 "Frankenthal (Pfalz)" ,modify
label define kkz 7312 "Kaiserslautern" ,modify
label define kkz 7313 "Landau in der Pfalz" ,modify
label define kkz 7313 "Südliche Weinstraße" ,modify
label define kkz 7314 "Ludwigshafen" ,modify
label define kkz 7314 "Ludwigshafen am Rhein" ,modify
label define kkz 7315 "Mainz-Bingen" ,modify
label define kkz 7315 "Mainz" ,modify
label define kkz 7316 "Neustadt an der Weinstraße" ,modify
label define kkz 7317 "Südwestpfalz" ,modify
label define kkz 7317 "Pirmasens" ,modify
label define kkz 7318 "Speyer" ,modify
label define kkz 7319 "Worms" ,modify
label define kkz 7320 "Zweibrücken" ,modify
label define kkz 7331 "Alzey-Worms" ,modify
label define kkz 7332 "Bad Dürkheim" ,modify
label define kkz 7333 "Donnersbergkreis" ,modify
label define kkz 7334 "Germersheim" ,modify
label define kkz 7335 "Kaiserslautern" ,modify
label define kkz 7336 "Kusel" ,modify
label define kkz 7337 "Südliche Weinstraße" ,modify
label define kkz 7338 "Ludwigshafen" ,modify
label define kkz 7339 "Mainz-Bingen" ,modify
label define kkz 7340 "Südwestpfalz" ,modify
label define kkz 8111 "Stuttgart" ,modify
label define kkz 8115 "Böblingen" ,modify
label define kkz 8116 "Esslingen" ,modify
label define kkz 8117 "Göppingen" ,modify
label define kkz 8118 "Ludwigsburg" ,modify
label define kkz 8119 "Rems-Murr-Kreis" ,modify
label define kkz 8121 "Heilbronn" ,modify
label define kkz 8125 "Heilbronn" ,modify
label define kkz 8126 "Hohenlohekreis" ,modify
label define kkz 8127 "Schwäbisch Hall" ,modify
label define kkz 8128 "Main-Tauber-Kreis" ,modify
label define kkz 8135 "Heidenheim" ,modify
label define kkz 8136 "Ostalbkreis" ,modify
label define kkz 8211 "Baden-Baden" ,modify
label define kkz 8212 "Karlsruhe" ,modify
label define kkz 8215 "Karlsruhe" ,modify
label define kkz 8216 "Rastatt" ,modify
label define kkz 8221 "Rhein-Neckar-Kreis" ,modify
label define kkz 8221 "Heidelberg" ,modify
label define kkz 8222 "Mannheim" ,modify
label define kkz 8225 "Neckar-Odenwald-Kreis" ,modify
label define kkz 8226 "Rhein-Neckar-Kreis" ,modify
label define kkz 8231 "Enzkreis" ,modify
label define kkz 8231 "Pforzheim" ,modify
label define kkz 8235 "Calw" ,modify
label define kkz 8236 "Enzkreis" ,modify
label define kkz 8237 "Freudenstadt" ,modify
label define kkz 8311 "Breisgau-Hochschwarzwald" ,modify
label define kkz 8311 "Freiburg im Breisgau" ,modify
label define kkz 8315 "Breisgau-Hochschwarzwald" ,modify
label define kkz 8316 "Emmendingen" ,modify
label define kkz 8317 "Ortenaukreis" ,modify
label define kkz 8325 "Rottweil" ,modify
label define kkz 8326 "Schwarzwald-Baar-Kreis" ,modify
label define kkz 8327 "Tuttlingen" ,modify
label define kkz 8335 "Konstanz" ,modify
label define kkz 8336 "Lörrach" ,modify
label define kkz 8337 "Waldshut" ,modify
label define kkz 8415 "Reutlingen" ,modify
label define kkz 8416 "Tübingen" ,modify
label define kkz 8417 "Zollernalbkreis" ,modify
label define kkz 8421 "Alb-Donau-Kreis" ,modify
label define kkz 8421 "Ulm" ,modify
label define kkz 8425 "Alb-Donau-Kreis" ,modify
label define kkz 8426 "Biberach" ,modify
label define kkz 8435 "Bodenseekreis" ,modify
label define kkz 8436 "Ravensburg" ,modify
label define kkz 8437 "Sigmaringen" ,modify
label define kkz 9161 "Ingolstadt" ,modify
label define kkz 9162 "München" ,modify
label define kkz 9163 "Rosenheim" ,modify
label define kkz 9171 "Altötting" ,modify
label define kkz 9172 "Berchtesgadener Land" ,modify
label define kkz 9173 "Bad Tölz-Wolfratshausen" ,modify
label define kkz 9174 "Dachau" ,modify
label define kkz 9175 "Ebersberg" ,modify
label define kkz 9176 "Eichstätt" ,modify
label define kkz 9177 "Erding" ,modify
label define kkz 9178 "Freising" ,modify
label define kkz 9179 "Fürstenfeldbruck" ,modify
label define kkz 9180 "Garmisch-Partenkirchen" ,modify
label define kkz 9181 "Landsberg a. Lech" ,modify
label define kkz 9182 "Miesbach" ,modify
label define kkz 9183 "Mühldorf a. Inn" ,modify
label define kkz 9184 "München" ,modify
label define kkz 9185 "Neuburg-Schrobenhausen" ,modify
label define kkz 9186 "Pfaffenhofen a.d. Ilm" ,modify
label define kkz 9187 "Rosenheim" ,modify
label define kkz 9188 "Starnberg" ,modify
label define kkz 9189 "Traunstein" ,modify
label define kkz 9190 "Weilheim-Schongau" ,modify
label define kkz 9261 "Landshut" ,modify
label define kkz 9262 "Passau" ,modify
label define kkz 9263 "Straubing-Bogen" ,modify
label define kkz 9263 "Straubing" ,modify
label define kkz 9271 "Deggendorf" ,modify
label define kkz 9272 "Freyung-Grafenau" ,modify
label define kkz 9273 "Kehlheim" ,modify
label define kkz 9274 "Landshut" ,modify
label define kkz 9275 "Passau" ,modify
label define kkz 9276 "Regen" ,modify
label define kkz 9277 "Rottal-Inn" ,modify
label define kkz 9278 "Straubing-Bogen" ,modify
label define kkz 9279 "Dingolfing-Landau" ,modify
label define kkz 9361 "Amberg-Sulzbach" ,modify
label define kkz 9361 "Amberg" ,modify
label define kkz 9362 "Regensburg" ,modify
label define kkz 9363 "Weiden i.d. OPf." ,modify
label define kkz 9371 "Amberg-Sulzbach" ,modify
label define kkz 9372 "Cham" ,modify
label define kkz 9373 "Neumarkt i.d. OPf." ,modify
label define kkz 9374 "Neustadt a.d. Waldnaab" ,modify
label define kkz 9375 "Regensburg" ,modify
label define kkz 9376 "Schwandorf" ,modify
label define kkz 9377 "Tirschenreuth" ,modify
label define kkz 9461 "Bamberg" ,modify
label define kkz 9462 "Bayreuth" ,modify
label define kkz 9463 "Coburg" ,modify
label define kkz 9464 "Hof" ,modify
label define kkz 9471 "Bamberg" ,modify
label define kkz 9472 "Bayreuth" ,modify
label define kkz 9473 "Coburg" ,modify
label define kkz 9474 "Forchheim" ,modify
label define kkz 9475 "Hof" ,modify
label define kkz 9476 "Kronach" ,modify
label define kkz 9477 "Kulmbach" ,modify
label define kkz 9478 "Lichtenfels" ,modify
label define kkz 9479 "Wunsiedel i. Fichtelgebirge" ,modify
label define kkz 9561 "Ansbach" ,modify
label define kkz 9562 "Erlangen-Höchstadt" ,modify
label define kkz 9562 "Erlangen" ,modify
label define kkz 9563 "Fürth" ,modify
label define kkz 9564 "Nürnberg" ,modify
label define kkz 9565 "Schwabach" ,modify
label define kkz 9571 "Ansbach" ,modify
label define kkz 9572 "Erlangen-Höchstadt" ,modify
label define kkz 9573 "Fürth" ,modify
label define kkz 9574 "Nürnberger Land" ,modify
label define kkz 9575 "Neustadt a.d. Aisch-Bad Windsheim" ,modify
label define kkz 9576 "Roth" ,modify
label define kkz 9577 "Weißenburg-Gunzenhausen" ,modify
label define kkz 9661 "Aschaffenburg" ,modify
label define kkz 9662 "Schweinfurth" ,modify
label define kkz 9662 "Schweinfurt" ,modify
label define kkz 9663 "Würzburg" ,modify
label define kkz 9671 "Aschaffenburg" ,modify
label define kkz 9672 "Bad Kissingen" ,modify
label define kkz 9673 "Rhön-Grabfeld" ,modify
label define kkz 9674 "Haßberge" ,modify
label define kkz 9675 "Kitzingen" ,modify
label define kkz 9676 "Miltenberg" ,modify
label define kkz 9677 "Main-Spessart" ,modify
label define kkz 9678 "Schweinfurth" ,modify
label define kkz 9679 "Würzburg" ,modify
label define kkz 9761 "Augsburg" ,modify
label define kkz 9762 "Kaufbeuren" ,modify
label define kkz 9763 "Kempten (Allgäu)" ,modify
label define kkz 9764 "Memmingen" ,modify
label define kkz 9771 "Aichach-Friedberg" ,modify
label define kkz 9772 "Augsburg" ,modify
label define kkz 9773 "Dillingen a.d. Donau" ,modify
label define kkz 9774 "Günzburg" ,modify
label define kkz 9775 "Neu-Ulm" ,modify
label define kkz 9776 "Lindau (Bodensee)" ,modify
label define kkz 9777 "Ostallgäu" ,modify
label define kkz 9778 "Unterallgäu" ,modify
label define kkz 9779 "Donau-Ries" ,modify
label define kkz 9780 "Oberallgäu" ,modify
label define kkz 10041 "Stadtverband Saarbrücken" ,modify
label define kkz 10042 "Merzig-Wadern" ,modify
label define kkz 10043 "Neunkirchen" ,modify
label define kkz 10044 "Saarlouis" ,modify
label define kkz 10045 "Saarpfalz-Kreis" ,modify
label define kkz 10046 "St.Wendel" ,modify
label define kkz 12051 "Brandenburg an der Havel" ,modify
label define kkz 12052 "Cottbus" ,modify
label define kkz 12053 "Frankfurt (Oder)" ,modify
label define kkz 12054 "Potsdam" ,modify
label define kkz 12060 "Barnim" ,modify
label define kkz 12061 "Dahme-Spreewald" ,modify
label define kkz 12062 "Elbe-Elster" ,modify
label define kkz 12063 "Havelland" ,modify
label define kkz 12064 "Märkisch-Oderland" ,modify
label define kkz 12065 "Oberhavel" ,modify
label define kkz 12066 "Oberspreewald-Lausitz" ,modify
label define kkz 12067 "Oder-Spree" ,modify
label define kkz 12068 "Ostprignitz-Ruppin" ,modify
label define kkz 12069 "Potsdam-Mittelmark" ,modify
label define kkz 12070 "Prignitz" ,modify
label define kkz 12071 "Spree-Neiße" ,modify
label define kkz 12072 "Teltow-Fläming" ,modify
label define kkz 12073 "Uckermark" ,modify
label define kkz 13001 "Greifswald" ,modify
label define kkz 13002 "Neubrandenburg" ,modify
label define kkz 13003 "Rostock" ,modify
label define kkz 13004 "Schwerin" ,modify
label define kkz 13005 "Stralsund" ,modify
label define kkz 13006 "Wismar" ,modify
label define kkz 13051 "Bad Doberan" ,modify
label define kkz 13052 "Demmin" ,modify
label define kkz 13053 "Güstrow" ,modify
label define kkz 13054 "Ludwigslust" ,modify
label define kkz 13055 "Mecklenburg-Strelitz" ,modify
label define kkz 13056 "Müritz" ,modify
label define kkz 13057 "Nordvorpommern" ,modify
label define kkz 13058 "Nordwestmecklenburg" ,modify
label define kkz 13059 "Ostvorpommern" ,modify
label define kkz 13060 "Parchim" ,modify
label define kkz 13061 "Rügen" ,modify
label define kkz 13062 "Uecker-Randow" ,modify
label define kkz 14161 "Chemnitz" ,modify
label define kkz 14166 "Vogtlandkreis" ,modify
label define kkz 14166 "Plauen" ,modify
label define kkz 14167 "Zwickau" ,modify
label define kkz 14171 "Annaberg" ,modify
label define kkz 14173 "Chemnitzer Land" ,modify
label define kkz 14177 "Freiberg" ,modify
label define kkz 14178 "Vogtlandkreis" ,modify
label define kkz 14181 "Mittlerer Erzgebirgskreis" ,modify
label define kkz 14182 "Mittweida" ,modify
label define kkz 14188 "Stollberg" ,modify
label define kkz 14191 "Aue-Schwarzenberg" ,modify
label define kkz 14193 "Zwickauer Land" ,modify
label define kkz 14262 "Dresden" ,modify
label define kkz 14263 "Görlitz" ,modify
label define kkz 14264 "Hoyerswerda" ,modify
label define kkz 14272 "Bautzen" ,modify
label define kkz 14280 "Meißen" ,modify
label define kkz 14284 "Niederschlesischer Oberlausitzkreis" ,modify
label define kkz 14285 "Riesa-Großenhain" ,modify
label define kkz 14286 "Löbau-Zittau" ,modify
label define kkz 14287 "Sächsische Schweiz" ,modify
label define kkz 14290 "Weißeritzkreis" ,modify
label define kkz 14292 "Kamenz" ,modify
label define kkz 14365 "Leipzig" ,modify
label define kkz 14365 "Leipziger Land" ,modify
label define kkz 14374 "Delitzsch" ,modify
label define kkz 14375 "Döbeln" ,modify
label define kkz 14379 "Leipziger Land" ,modify
label define kkz 14383 "Muldentalkreis" ,modify
label define kkz 14389 "Torgau-Oschatz" ,modify
label define kkz 15101 "Dessau" ,modify
label define kkz 15151 "Anhalt-Zerbst" ,modify
label define kkz 15153 "Bernburg" ,modify
label define kkz 15154 "Bitterfeld" ,modify
label define kkz 15159 "Köthen" ,modify
label define kkz 15171 "Wittenberg" ,modify
label define kkz 15202 "Saalkreis" ,modify
label define kkz 15202 "Halle(Saale)" ,modify
label define kkz 15256 "Burgenlandkreis" ,modify
label define kkz 15260 "Mansfelder Land" ,modify
label define kkz 15261 "Merseburg-Querfurt" ,modify
label define kkz 15265 "Saalkreis" ,modify
label define kkz 15266 "Sangerhausen" ,modify
label define kkz 15268 "Weißenfels" ,modify
label define kkz 15303 "Magdeburg" ,modify
label define kkz 15352 "Aschersleben-Staßfurt" ,modify
label define kkz 15355 "Bördekreis" ,modify
label define kkz 15357 "Halberstadt" ,modify
label define kkz 15358 "Jerichower Land" ,modify
label define kkz 15362 "Ohrekreis" ,modify
label define kkz 15363 "Stendal" ,modify
label define kkz 15364 "Quedlinburg" ,modify
label define kkz 15367 "Schönebeck" ,modify
label define kkz 15369 "Wernigerode" ,modify
label define kkz 15370 "Altmarkkreis Salzwedel" ,modify
label define kkz 16051 "Erfurt" ,modify
label define kkz 16052 "Gera" ,modify
label define kkz 16053 "Jena" ,modify
label define kkz 16054 "Suhl" ,modify
label define kkz 16055 "Weimar" ,modify
label define kkz 16056 "Eisenach" ,modify
label define kkz 16061 "Eichsfeld" ,modify
label define kkz 16062 "Nordhausen" ,modify
label define kkz 16063 "Wartburgkreis" ,modify
label define kkz 16064 "Unstrut-Hainich-Kreis" ,modify
label define kkz 16065 "Kyffhäuserkreis" ,modify
label define kkz 16066 "Schmalkalden-Meiningen" ,modify
label define kkz 16067 "Gotha" ,modify
label define kkz 16068 "Sömmerda" ,modify
label define kkz 16069 "Hildburghausen" ,modify
label define kkz 16070 "Ilm-Kreis" ,modify
label define kkz 16071 "Weimarer Land" ,modify
label define kkz 16072 "Sonneberg" ,modify
label define kkz 16073 "Saalfeld-Rudolstadt" ,modify
label define kkz 16074 "Saale-Holzland-Kreis" ,modify
label define kkz 16075 "Saale-Orla-Kreis" ,modify
label define kkz 16076 "Greiz" ,modify
label define kkz 16077 "Altenburger Land" ,modify

label value wkreis kkz
label define kkz 13004 "Schwerin" ,modify
label define kkz 13005 "Stralsund" ,modify
label define kkz 13006 "Wismar" ,modify
label define kkz 13051 "Bad Doberan" ,modify
label define kkz 13052 "Demmin" ,modify
label define kkz 13053 "Güstrow" ,modify
label define kkz 13054 "Ludwigslust" ,modify
label define kkz 13055 "Mecklenburg-Strelitz" ,modify
label define kkz 13056 "Müritz" ,modify
label define kkz 13057 "Nordvorpommern" ,modify
label define kkz 13058 "Nordwestmecklenburg" ,modify
label define kkz 13059 "Ostvorpommern" ,modify
label define kkz 13060 "Parchim" ,modify
label define kkz 13061 "Rügen" ,modify
label define kkz 13062 "Uecker-Randow" ,modify

gen akreis = substr(arbgkz,1,5)
destring akreis, replace
label value akreis kkz
label var akreis "Kreis des Arbeitsortes"

gen weitpendel = kmwohn1zuarb>24 & kmwohn1zuarb<.
recode hheink (1 2 =1 "<1500€") (3=2 "1500€-3000€") (4=3 ">3000€"), gen(hheink_3)
recode anzpreisej (0=0 "keine Reise") (1/6=1 "mind. alle 2 Monate 1 Privatreise") (7/24=2 "1-2 Mal im Monat eine Privatreise") (25/150=3 "mehr als 2 Privatreisen im Monat") (160/.=.), gen(privatr)
replace pberuf=0 if missing(pberuf) & pberuf!=.a
recode pberuf (0=0 "keiner") (1=1 "1 Arbeiter") (2=2 "2 Arbeiter") (3/9=3 "mehr als 2 Arbeiter"), gen(hh_bt)

recode wohnlage1 (1 3=1 "Innenstadt") (2 4=2 "Stadtrand") (5=3 "Kleinstadt") (6=4 "Land"), gen(wohnlage_4)

recode kmbahnhof (0/5=1 "<5km") (6/10=2 "5km-10km") (11/200=3 ">10km"), gen(dist_bhf)
recode anzdirj (0=0 "keine") (1/10=1 "bis 10") (11/20=2 "bis 20")  (21/30=3 "bis 30") (31/40=4 "bis 40") (41/50=5 "bis 50") (51/75=6 "bis 75") (76/100=7 "bis 100" ) (101/200=8 "bis 200"), gen(dir_8)


gen ham_einzug= (wkreis>1002 & wkreis<1054) | (wkreis>1054 & wkreis<1058) | (wkreis>1059 & wkreis<2001) | (wkreis>351 & wkreis<361)  | /*
*/ (wkreis==13006) | wkreis==13058 | wkreis==13054 | wkreis==13055

* Anpassungen an RA
recode wohnew (1/1999=1 "bis 1.999 EW") (2000/4999=2 "2000-4.999 EW") (5000/19999=3 "5000-19.999 EW") (20000/49999=4 "20.000-49.999 EW") (50000/99999=5 "50.000-99.999 EW")  (100000/499999=6 "100.000-499.999 EW") (500000/4000000=7 "500.000 EW und mehr"), gen(pol)
recode pol (1 2 =1 "bis 5000 EW") (3 4=2 "5000-49.999 EW") (5=3 "50.000-99.999 EW") (6=4 "100.000-499.999 EW") (7=5 "500.000 EW und mehr"), gen(polgk)

recode wohnlage_4 (1=1 "Innenstadt") (2 3 = 2 "Stadtrand/Kleinstadt") (4=3 "Land"), gen(wohnlage_3)

gen besch2= besch
replace besch2 = 6 if besch==5 & hh_bt>0
replace besch2 = 7  if besch==3 & hh_bt>0
label define besch 6 "in Ausbildung, Erw. in HH" 7 "ohne Arbeit, Erw. in HH", modify
label value besch2 besch

recode besch2 (1 2 = 1 "arbeitend") (3=2 "ohne Arbeit, kein Erw. in HH") (4=4 "Rentner") (5=5 "Ausbildung, kein Erw. HH") (7=6 "in Ausbildung, Erw. in HH") (6=3 "ohne Arbeit, Erw. in HH"), gen(besch_n)

gen pflex = besch_n==1 | besch==5 | besch==6
gen hhflex = 1 if hh_bt>0 
replace hhflex = 2 if hhtyp_3==2
replace hhflex=0 if hh_bt==0 & hhtyp_3!=2

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_pid.dta", replace
drop r1dat* rueb* rdatymd* rdatsas* rdatcheck* rzweckgpu* rzweckp* rzweck?p* rzweck10p* rzweck11p* ranzpers* ranzkind* rziel* rziellandcode* rzielland* rzielstadtcode* rzielstadt* rzielstadtplz* rzielstadtgkz* rdist* rvm* rvmwahl* rvm?zu* rvm10zu* rvm11zu* rvm12zu*

* logit dirj ib2.besch i.bildung_2 ib2.hhtyp_3 ib3.hheink  alter alter2 i.sex i.bahncard_jn i.pkwbes i.vielflieger i.zweitw ib2.rtyp3 anzpreisej , nolog

* poisson anzdir ib2.besch i.bildung_2 ib2.hhtyp_3 ib3.hheink  alter alter2 i.sex i.bahncard_jn i.pkwbes i.vielflieger i.zweitw ib2.rtyp3 , nolog

* nbreg anzdirj ib2.besch i.bildung_2 ib2.hhtyp_3 ib3.hheink  alter alter2 i.sex i.bahncard_jn i.pkwbes i.vielflieger i.zweitw ib2.rtyp3 anzpreisej c.anzpreisej#c.anzpreisej , nolog

nbreg anzdirj i.besch i.bildung_2  ib3.hheink   i.sex  ib2.privatr , nolog
predict pr_dr


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_pid_red.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_pid.dta", clear
reshape long r1dat rueb rdatymd rdatsas rdatcheck rzweckgpu rzweckp rzweck1p rzweck2p rzweck3p rzweck4p rzweck5p rzweck6p rzweck7p rzweck8p rzweck9p rzweck10p rzweck11p ranzpers ranzkind rziel rziellandcode rzielland rzielstadtcode rzielstadt rzielstadtplz rzielstadtgkz rdist rvm rvmwahl rvmzu rvm1zu rvm2zu rvm3zu rvm4zu rvm5zu rvm6zu rvm7zu rvm8zu rvm9zu rvm10zu rvm11zu rvm12zu, i(id) j(rid)
drop if rdatcheck==999 & rid!=1
drop if missing(rdatcheck) & rid!=1
recode rdist (0.1/300 = 1 "Nachbereich <300") (300.1/600 = 2 "Mittelstrecke nah (300;600]") (600.1/900 = 3 "Mittelstrecke fern (600;900]") (900.1/1200 = 4 "Fernstrecke nah (900;1200]") (900.1/300000 = 5 "Fernstrecke nah (1200;1500]") (1200.1/300000 = 6 "Fernstrecke >1500"), gen(rdist_6) 
recode rdist (0.1/400 = 1 "nah <400") (400.1/800 = 2 "mittel (400;800]") (800.1/1200 = 3 "mittel/fern (800;1200]") (1200.1/300000 = 3 "fern >1200"), gen(rdist_3)
recode rvm ( 1 7 8 9= 1 "MIV") ( 2 4 = 2 "Bahn") ( 3=3 "Flugzeug") ( 5 10 =4 "sonstige" ), gen(rvm_4) 
recode rvmzu (1/2 = 1 "NMIV") (3/5 = 2 "MIV" ) (6/8 = 3 "ÖV") (10=4 "Taxi") (11=5 "Flughafentransfer"), gen(rvmzu_5)

	label var r1dat "Grobdifferenzierung der Reise "
	label var rueb "Anzahl Übernachten im Reiseverlauf"
	label var rdatymd "Datum der Rückkehr von der Reise [yymmmdd]"
	label var rdatcheck "Genauigkeit des berichteten Reisedatums"
	label var rzweckgpu "Reisezweck der Reise"
	label var rzweckp "Reisezweck dienstl.-privat der Reise"
	
	label var rzweck1p "Urlaub als Reisezweck (privat) der Reise"
	label var rzweck2p "Eink./Besorg./Erldg. als Reisezweck (privat) der Reise"
	label var rzweck3p "Verwandten-/Bekanntenbesuch als Reisezweck (privat) der Reise"
	label var rzweck4p "Städtreise als Reisezweck (privat) der Reise"
	label var rzweck5p "Besuch sportl./kultur. Veranstaltg. als Reisezweck (privat) der Reise"
	label var rzweck6p "Kur-/Krankenhausaufenthalt als Reisezweck (privat) der Reise"
	label var rzweck7p "Ausflug/Wanderung als Reisezweck (privat) der Reise"
	label var rzweck8p "Besichtgg./Besuch Sehenswürdigkeiten als Reisezweck (privat) der Reise"
	label var rzweck9p "Kongress/Tagung als Reisezweck (privat) der Reise"
	label var rzweck10p "Sonstiges als Reisezweck (privat) der Reise"
	label var rzweck11p "k.A. als Reisezweck (privat) der Reise"

	label var ranzpers "Anzahl Reisender auf der Reise"
	label var ranzkind "Anzahl Kinder (<14 J.) auf der Reise"
	
	label var rziel "Reiseziel der Reise" 
	label var rziellandcode "Landescode Reiseziel Ausland"
	label var rzielland "Name des besuchten Landes auf der Reise"
	label var rzielstadtcode "Stadtcode Reiseziel Deutschland auf der Reise"
	label var rzielstadt "Name des besuchten Stadt auf der Reise"
	label var rzielstadtplz "Stadt (PLZ) Reiseziel Deutschland auf der Reise"
	label var rzielstadtgkz "Stadt (GKZ) auf der Reise"
	label var rdist "Entfernung zum Reiseziel auf der Reise"
	label var rvm "Hauptverkehrsmittel auf der Reise"
	label var rvmwahl "Gründe für die Verkehrsmittelwahl auf der Reise"	
	label var rvmzu "Hauptzugangsverkehrsmittel auf der Reise (DIW-Kode)"	
	label var rvm1zu "Fuß (ZugangsVM) auf der Reise"
	label var rvm2zu "Fahrrad (ZugangsVM) auf der Reise"
	label var rvm3zu "Pkw-MF (ZugangsVM) auf der Reise"
	label var rvm4zu "Pkw-F (ZugangsVM) auf der Reise"
	label var rvm5zu "MRad/Moped/Motorroller (ZugangsVM) auf der Reise"
	label var rvm6zu "Bus, Straßenbahn, U-Bahn (ZugangsVM) auf der Reise"
	label var rvm7zu "S-Bahn (ZugangsVM) auf der Reise"
	label var rvm8zu "Bahn (ZugangsVM) auf der Reise"	
	label var rvm10zu "k.A. (ZugangsVM) auf der Reise"
	label var rvm11zu "Taxi (ZugangsVM) auf der Reise"
	label var rvm12zu "Flughafentransfer (ZugangsVM) auf der Reise"

	label define jn 0 "nein" 1 "ja"

forvalues i=1/12 {
	replace rvm`i'zu = 0 if missing(rvm`i'zu)
	label value rvm`i'zu jn
}	

gen OEV = rvmzu_5==3
gen MIV = rvmzu_5==2
gen sonst = rvmzu_5==5 | rvmzu_5==4

* keine intermodalen Wege erfasst
gen rvm_intermodal = OEV + MIV + sonst 

gen zielregion = 1 if rziel==2
replace zielregion = 2 if rziellandcode == 11
replace zielregion = 2 if rziellandcode == 12
replace zielregion = 2 if rziellandcode == 13
replace zielregion = 2 if rziellandcode == 14
replace zielregion = 2 if rziellandcode == 15
replace zielregion = 2 if rziellandcode == 21
replace zielregion = 2 if rziellandcode == 22
replace zielregion = 2 if rziellandcode == 31
replace zielregion = 2 if rziellandcode == 32
replace zielregion = 2 if rziellandcode == 33
replace zielregion = 2 if rziellandcode == 40
replace zielregion = 2 if rziellandcode == 51
replace zielregion = 2 if rziellandcode == 52
replace zielregion = 2 if rziellandcode == 60
replace zielregion = 2 if rziellandcode == 70
replace zielregion = 2 if rziellandcode == 80
replace zielregion = 2 if rziellandcode == 90
replace zielregion = 2 if rziellandcode == 91
replace zielregion = 2 if rziellandcode == 101
replace zielregion = 2 if rziellandcode == 102
replace zielregion = 2 if rziellandcode == 103
replace zielregion = 2 if rziellandcode == 111
replace zielregion = 2 if rziellandcode == 112
replace zielregion = 2 if rziellandcode == 115
replace zielregion = 2 if rziellandcode == 116
replace zielregion = 2 if rziellandcode == 118
replace zielregion = 2 if rziellandcode == 119
replace zielregion = 2 if rziellandcode == 120
replace zielregion = 2 if rziellandcode == 121
replace zielregion = 2 if rziellandcode == 122
replace zielregion = 2 if rziellandcode == 123
replace zielregion = 2 if rziellandcode == 124
replace zielregion = 2 if rziellandcode == 125
replace zielregion = 2 if rziellandcode == 126
replace zielregion = 2 if rziellandcode == 130
replace zielregion = 2 if rziellandcode == 131
replace zielregion = 2 if rziellandcode == 132
replace zielregion = 2 if rziellandcode == 133
replace zielregion = 2 if rziellandcode == 134
replace zielregion = 2 if rziellandcode == 135
replace zielregion = 7 if rziellandcode == 136
replace zielregion = 7 if rziellandcode == 137
replace zielregion = 7 if rziellandcode == 138
replace zielregion = 7 if rziellandcode == 139
replace zielregion = 7 if rziellandcode == 140
replace zielregion = 7 if rziellandcode == 141
replace zielregion = 7 if rziellandcode == 142
replace zielregion = 7 if rziellandcode == 143
replace zielregion = 7 if rziellandcode == 144
replace zielregion = 1 if rziellandcode == 150
replace zielregion = 7 if rziellandcode == 190
replace zielregion = 7 if rziellandcode == 201
replace zielregion = 7 if rziellandcode == 202
replace zielregion = 7 if rziellandcode == 203
replace zielregion = 7 if rziellandcode == 204
replace zielregion = 7 if rziellandcode == 205
replace zielregion = 7 if rziellandcode == 206
replace zielregion = 7 if rziellandcode == 207
replace zielregion = 7 if rziellandcode == 208
replace zielregion = 7 if rziellandcode == 209
replace zielregion = 7 if rziellandcode == 210
replace zielregion = 3 if rziellandcode == 211
replace zielregion = 3 if rziellandcode == 212
replace zielregion = 3 if rziellandcode == 213
replace zielregion = 3 if rziellandcode == 214
replace zielregion = 3 if rziellandcode == 301
replace zielregion = 3 if rziellandcode == 303
replace zielregion = 3 if rziellandcode == 304
replace zielregion = 3 if rziellandcode == 311
replace zielregion = 3 if rziellandcode == 312
replace zielregion = 3 if rziellandcode == 313
replace zielregion = 3 if rziellandcode == 314
replace zielregion = 3 if rziellandcode == 315
replace zielregion = 3 if rziellandcode == 316
replace zielregion = 3 if rziellandcode == 317
replace zielregion = 3 if rziellandcode == 401
replace zielregion = 3 if rziellandcode == 402
replace zielregion = 3 if rziellandcode == 403
replace zielregion = 3 if rziellandcode == 404
replace zielregion = 3 if rziellandcode == 405
replace zielregion = 3 if rziellandcode == 406
replace zielregion = 3 if rziellandcode == 407
replace zielregion = 3 if rziellandcode == 408
replace zielregion = 3 if rziellandcode == 409
replace zielregion = 3 if rziellandcode == 410
replace zielregion = 3 if rziellandcode == 411
replace zielregion = 3 if rziellandcode == 412
replace zielregion = 3 if rziellandcode == 413
replace zielregion = 3 if rziellandcode == 414
replace zielregion = 3 if rziellandcode == 415
replace zielregion = 3 if rziellandcode == 416
replace zielregion = 3 if rziellandcode == 417
replace zielregion = 3 if rziellandcode == 418
replace zielregion = 3 if rziellandcode == 419
replace zielregion = 3 if rziellandcode == 420
replace zielregion = 3 if rziellandcode == 421
replace zielregion = 3 if rziellandcode == 422
replace zielregion = 3 if rziellandcode == 423
replace zielregion = 3 if rziellandcode == 424
replace zielregion = 3 if rziellandcode == 425
replace zielregion = 3 if rziellandcode == 426
replace zielregion = 3 if rziellandcode == 428
replace zielregion = 3 if rziellandcode == 429
replace zielregion = 3 if rziellandcode == 430
replace zielregion = 3 if rziellandcode == 431
replace zielregion = 3 if rziellandcode == 432
replace zielregion = 3 if rziellandcode == 433
replace zielregion = 3 if rziellandcode == 434
replace zielregion = 3 if rziellandcode == 435
replace zielregion = 3 if rziellandcode == 436
replace zielregion = 3 if rziellandcode == 437
replace zielregion = 3 if rziellandcode == 438
replace zielregion = 3 if rziellandcode == 439
replace zielregion = 3 if rziellandcode == 440
replace zielregion = 3 if rziellandcode == 441
replace zielregion = 3 if rziellandcode == 442
replace zielregion = 3 if rziellandcode == 443
replace zielregion = 8 if rziellandcode == 501
replace zielregion = 8 if rziellandcode == 502
replace zielregion = 8 if rziellandcode == 503
replace zielregion = 8 if rziellandcode == 504
replace zielregion = 8 if rziellandcode == 505
replace zielregion = 8 if rziellandcode == 506
replace zielregion = 8 if rziellandcode == 507
replace zielregion = 8 if rziellandcode == 508
replace zielregion = 8 if rziellandcode == 509
replace zielregion = 8 if rziellandcode == 510
replace zielregion = 8 if rziellandcode == 511
replace zielregion = 8 if rziellandcode == 512
replace zielregion = 8 if rziellandcode == 513
replace zielregion = 8 if rziellandcode == 514
replace zielregion = 8 if rziellandcode == 515
replace zielregion = 8 if rziellandcode == 516
replace zielregion = 8 if rziellandcode == 517
replace zielregion = 8 if rziellandcode == 519
replace zielregion = 8 if rziellandcode == 520
replace zielregion = 8 if rziellandcode == 521
replace zielregion = 8 if rziellandcode == 522
replace zielregion = 9 if rziellandcode == 601
replace zielregion = 9 if rziellandcode == 602
replace zielregion = 9 if rziellandcode == 603
replace zielregion = 8 if rziellandcode == 604
replace zielregion = 8 if rziellandcode == 606
replace zielregion = 8 if rziellandcode == 607
replace zielregion = 8 if rziellandcode == 608
replace zielregion = 8 if rziellandcode == 609
replace zielregion = 5 if rziellandcode == 710
replace zielregion = 5 if rziellandcode == 720
replace zielregion = 5 if rziellandcode == 730
replace zielregion = 4 if rziellandcode == 802
replace zielregion = 4 if rziellandcode == 803
replace zielregion = 4 if rziellandcode == 804
replace zielregion = 4 if rziellandcode == 805
replace zielregion = 4 if rziellandcode == 806
replace zielregion = 4 if rziellandcode == 807
replace zielregion = 4 if rziellandcode == 808
replace zielregion = 4 if rziellandcode == 809
replace zielregion = 4 if rziellandcode == 810
replace zielregion = 4 if rziellandcode == 812
replace zielregion = 4 if rziellandcode == 813
replace zielregion = 4 if rziellandcode == 814
replace zielregion = 4 if rziellandcode == 815
replace zielregion = 4 if rziellandcode == 816
replace zielregion = 4 if rziellandcode == 817
replace zielregion = 4 if rziellandcode == 818
replace zielregion = 6 if rziellandcode == 901
replace zielregion = 6 if rziellandcode == 902
replace zielregion = 6 if rziellandcode == 903
replace zielregion = 6 if rziellandcode == 904
replace zielregion = 6 if rziellandcode == 905
replace zielregion = 6 if rziellandcode == 907
replace zielregion = 6 if rziellandcode == 908
replace zielregion = 6 if rziellandcode == 909
replace zielregion = 6 if rziellandcode == 910
replace zielregion = 6 if rziellandcode == 911
replace zielregion = 6 if rziellandcode == 912
replace zielregion = 6 if rziellandcode == 913
replace zielregion = 6 if rziellandcode == 914
replace zielregion = 8 if rziellandcode == 970
replace zielregion = 2 if rziellandcode == 980

label define zielregion 1 "Deutschland" 2 "Europa" 3 "Afrika" 4 "Mittelamerika" 5 "Nordamerika" /*
*/ 6 "Südamerika" 7 "Vorderasien/Vorderer Orient" 8 "Hinterasien / Zentralasien" 9 "Ausralien / Ozeanien / Antarktis", modify
label value zielregion zielregion

gen nahbereich = 0 if rziellandcode < .
replace nahbereich = 1 if rziellandcode == 11
replace nahbereich = 1 if rziellandcode == 15
replace nahbereich = 1 if rziellandcode == 31
replace nahbereich = 1 if rziellandcode == 32
replace nahbereich = 1 if rziellandcode == 33
replace nahbereich = 1 if rziellandcode == 40
replace nahbereich = 1 if rziellandcode == 60
replace nahbereich = 1 if rziellandcode == 70
replace nahbereich = 1 if rziellandcode == 80
replace nahbereich = 1 if rziellandcode == 90
replace nahbereich = 1 if rziellandcode == 115
replace nahbereich = 1 if rziellandcode == 125
replace nahbereich = 1 if rziellandcode == 126
replace nahbereich = 1 if rziellandcode == 150
replace nahbereich=1 if rziel==2
label value nahbereich jn

recode zielregion (1=1 "D") (2=2 "Europa") (3/9=3 "interkontinental") , gen(ziel_3) 

drop if missing(rvoll)
recode rueb(999=.a)
label define rueb .a "k.A.", modify
label value rueb rueb

format rdatsas %td
gen rbeginn = rdatsas - rueb
format rbeginn %td

gen r_jahr_e = year(rdatsas)
gen r_jahr_a = year(rbeginn)
label value r_jahr_? jn

label var r_jahr_e "Jahr des Endes der Reise"
label var r_jahr_a "Jahr des Anfangs der Reise"


gen r_wtag_e = dow(rdatsas)
gen r_wtag_a = dow(rbeginn)
recode r_wtag_? (0=7)
label define wtag 1 "Montag" 2 "Dienstag" 3 "Mittwoch" 4 "Donnerstag" 5 "Freitag" 6 "Samstag" 7 "Sonntag", modify
label value r_wtag_? wtag
gen r_modo_a = r_wtag_a<5
gen r_modo_e = r_wtag_e<5
label value r_modo_? jn

label var rbeginn "geschätztes Datum Reisebeginn"

label var r_wtag_e "Wochentag Reiseende"
label var r_wtag_a "Wochentag Reisebeginn"
label var r_modo_a "Werktag (Mo-Do) Reisebeginn"
label var r_modo_e "Werktag (Mo-Do) Reiseende"

merge n:m rdatsas rbeginn wbland using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\datumszuweisung.dta", /*
*/ keepusing(normalertagreisebeginn normalewochereisebeginn normalertagreiseende normalewochereiseende feiertagwoche wochenendfahrt woche_schulferien) update replace

drop if _merge==1
drop _merge
drop if missing(id)

gen norm_beg_fam = normalertagreisebeginn & diff14>0
replace norm_beg_fam = 0 if (woche_schulferien==1 | feiertagwoche>0) & diff14>0
replace norm_beg_fam = .  if diff14==0 

gen norm_beg_nokids = normalertagreisebeginn & diff14==0
replace norm_beg_nokids = 0 if feiertagwoche>0 & diff14==0
replace norm_beg_nokids = . if  diff14>0 


recode rueb (0=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7/430=7 "7++"), gen(rd_7)
recode rdist_? (0=.a)
recode rvm_4 (4=.a)
recode ranzpers (0 1 = 1 "allein") (2=2) (3=3) (4=4) (5/99=5 "4++"), gen(ranzp_5)
recode ranzp_5 (1=1) (2=2 "2") (3 4=3 "3/4") (5=4 ">4"), gen(ranzp_4)

gen rzweck_3=1 if rzweckp==1
forvalues i=2/11 {
	replace rzweck_3 = 2 if rzweck`i'p==1
}
replace rzweck_3 = 3 if rzweck1p==1 | rzweck6p==1
replace rzweck_3 = 4 if (rzweck_3==2 | rzweck_3==3) & rueb==0


label var rzweck_3 "Reisezweck GPU (reisedauerunabh.)"
label value rzweck_3 rzweck

recode rdist (1/200=1 "<200") (201/400=2 "(200,400]") (401/600=3 "(400,600]") (601/800=4 "(600,800]") (801/1000=5 "(800,1000]") (1001/1200=6 "(1000,1200]") (1201/30000=7 ">1200") (0=.a "0 Tage"), gen(rdist_7)
recode rdist (1/200=1 "<200") (201/400=2 "(200,400]") (401/600=3 "(400,600]") (601/800=4 "(600,800]") (801/1200=5 "(800,1200]")  (1201/30000=6 ">1200") (0=.a "0 Tage"), gen(rdist_6n)

gen r_zw_dist6 = rdist_6  if rzweck_3 ==1
replace  r_zw_dist6 = rdist_6 +6  if rzweck_3 ==2
replace  r_zw_dist6 = rdist_6 +12  if rzweck_3 ==3
label var r_zw_dist6 "Reisezweck, Distanzklasse"
label define r_zw_dist 1 "dienstl., < 300" 2 "dienstl., (300;600]" 3 "dienstl., (600;900]" 4 "dienstl., (900;1200]" 5 "dienstl., (1200;1500]", modify
label define r_zw_dist 7 "privat, < 300" 8 "privat, (300;600]" 9 "privat, (600;900]" 10 "privat, (900;1200]" 11 "privat, (1200;1500]", modify
label define r_zw_dist 13 "Urlaub, < 300" 14 "Urlaub, (300;600]" 15 "Urlaub, (600;900]" 16 "Urlaub, (900;1200]" 17 "Urlaub, (1200;1500]", modify
label value r_zw_dist  r_zw_dist

gen r_zw_dist6n = rdist_6n  if rzweck_3 ==1
replace  r_zw_dist6n = rdist_6n +6  if rzweck_3 ==2
replace  r_zw_dist6n = rdist_6n +12  if rzweck_3 ==3
label var r_zw_dist6n "Reisezweck, Distanzklasse (200er)"
label define r_zw_dist6n 1 "dienstl., < 200" 2 "dienstl., (200;400]" 3 "dienstl., (400;600]" 4 "dienstl., (600;800]" 5 "dienstl., (800;1200]" 6 "dienstl., >1200" , modify
label define r_zw_dist6n 7 "privat, < 200" 8 "privat, (200;400]" 9 "privat, (400;600]" 10 "privat, (600;800]" 11 "privat, (800;1200]" 12 "privat, >1200", modify
label define r_zw_dist6n 13 "Urlaub, < 200" 14 "Urlaub, (200;400]" 15 "Urlaub, (400;600]" 16 "Urlaub, (600;800]" 17 "Urlaub, (800;1200]" 18 "Urlaub, >1200", modify
label value r_zw_dist6n  r_zw_dist6n

gen rgruppe = 1 if ranzpers <2
replace rgruppe = 2 if ranzpers == 2 & ranzkind==0
replace rgruppe = 3 if ranzkind==0 & ranzpers>2
replace rgruppe = 4 if ranzkind>0 & ranzpers>1
replace rgruppe = 5 if ranzpers>4 & ranzkind==0
replace rgruppe = 6 if ranzpers>4 & ranzkind>0

label define rgruppe 1 "allein" 2 "zu zweit ohne Kind" 3 "3/4 ohne Kind" 4 "bis zu 4 Personen mit Kind" 5 "mehr als 4 Personen ohne Kind" 6 "mehr als 4 Personen mit Kind", modify
label value rgruppe rgruppe


gen ntag = 1 if normalertagreisebeginn==1 & rzweck_3 == 1
replace ntag = 2 if norm_beg_fam==1 & rzweck_3!=1
replace ntag = 3 if norm_beg_nokids==1 & rzweck_3!=1
replace ntag = 0 if normalertagreisebeginn==0 & missing(ntag)
label define ntag 0 "kein normaler Tag" 1 "dienstl., normaler Tag" 2 "privat, normaler Tag (mit Kindern)" 3 "privat, normaler Tag (keine Kinder)", modify
label value ntag ntag

tabout ntag rzweck_3 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\Verteilung.txt", replace c(freq) layout(rb)



* gen pkw_verf = pkwhh>0

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\A Screening\Daten STATA\screening_rid.dta", replace


