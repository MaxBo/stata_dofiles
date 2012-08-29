clear
set memory 700m
local path "X:\Daten\Modell_MRH\Nachfragedaten\MID_D\"
set more off

use "`path'MiD_HH_cod.dta", clear
reshape long hpalter hp_sex hpbesch hppkwfs hp_beru hp_taet hp_bkat , i(hhid) j(pid)
drop if pid>h02

rename hpalter hp_alter
rename hpbesch hp_besch
rename hppkwfs hp_pkwfs


save "`path'MiD_HH_cod_transform.dta", replace

use "`path'MiD_Wege_cod.dta", clear
* ohne rbw
drop if wsource == 1



*****************++++++++++++++++***************************

* Umwidmung sonstiger Wegezwecke
replace w04 = 1 if w04_sons == "1. Teil der Fahrt zum Arbeitsort (Berufspendler)"
replace w04 = 4 if w04_sons == "1. Teil des Weges zum Einkauf"
replace w04 = 8 if w04_sons == "1. Wohnsitz"
replace w04 = 7 if w04_sons == "2. Hunderunde"
replace w04 = 1 if w04_sons == "2. Teil der Fahrt zum Arbeitsort (Berufspendler)"
replace w04 = 5 if w04_sons == "2. Wohnung anschauen"
replace w04 = 8 if w04_sons == "2. wohung"
replace w04 = 7 if w04_sons == "3. Hunderunde"
replace w04 = 7 if w04_sons == "Aachen"
replace w04 = 6 if w04_sons == "Abgeholt"
replace w04 = 5 if w04_sons == "Abholen von Material"
replace w04 = 5 if w04_sons == "Abholung einer Maschine"
replace w04 = 5 if w04_sons == "Ábholung von geparktem Auto"
replace w04 = 5 if w04_sons == "Abholung Wohnwagen aus Werkstatt"
replace w04 = 7 if w04_sons == "Ad. ist zu seinen Großeltern gegangen"
replace w04 = 7 if w04_sons == "Aktivierung der Beine."
replace w04 = 5 if w04_sons == "Alte Wohnung aufraumen"
replace w04 = 5 if w04_sons == "aLTGELAS WEG BRINGEN"
replace w04 = 5 if w04_sons == "Altglasentsorgung"
replace w04 = 5 if w04_sons == "Altpapier"
replace w04 = 34 if w04_sons == "am Zielbahnhof angekommen"
replace w04 = 7 if w04_sons == "anderer Ort"
replace w04 = 2 if w04_sons == "Andre war mit seinem Praktikumschef unterwegs"
replace w04 = 7 if w04_sons == "ANGELN"
replace w04 = 5 if w04_sons == "Anhänger aus der Garage geholt"
replace w04 = 2 if w04_sons == "ANKOMMEN AM eINSATZORT"
replace w04 = 7 if w04_sons == "Ankunft beim Vater"
replace w04 = 5 if w04_sons == "Anmelden der Tochter bei der Fahrschule"
replace w04 = 5 if w04_sons == "Anmelden in der fahrschule"
replace w04 = 2 if w04_sons == "Anreise nach Augsburg zur Schulung"
replace w04 = 2 if w04_sons == "Ansicht des überwemmten Schewimmbads"
replace w04 = 2 if w04_sons == "Ansicht von überschwemmten Gärten"
replace w04 = 5 if w04_sons == "Apotheke"
replace w04 = 2 if w04_sons == "Arbeit am See"
replace w04 = 1 if w04_sons == "Arbeit in der Landwirtschaft"
replace w04 = 1 if w04_sons == "arbeiten (anderer Arbeitsplatz)"
replace w04 = 6 if w04_sons == "Arbeitsaufnahme vom Sohn"
replace w04 = 5 if w04_sons == "Arbeitsgericht"
replace w04 = 4 if w04_sons == "Arbeitsschuhe abgeholt"
replace w04 = 5 if w04_sons == "Arbeitsstelle des Freundes aufgesucht zwecks Abholung"
replace w04 = 1 if w04_sons == "Arbeitsweg"
replace w04 = 5 if w04_sons == "Arzt"
replace w04 = 5 if w04_sons == "Arzt besuch"
replace w04 = 5 if w04_sons == "Arztbesuch"
replace w04 = 5 if w04_sons == "Arztbesuch, Krankenhaus, Untersuchung"
replace w04 = 5 if w04_sons == "Arztbesuich"
replace w04 = 34 if w04_sons == "auf dem weg zum FLUGHAFEN"
replace w04 = 7 if w04_sons == "Auf der Feier"
replace w04 = 1 if w04_sons == "Auf die Baustelle"
replace w04 = 1 if w04_sons == "Auf die bestelle"
replace w04 = 4 if w04_sons == "aufsuchen eines Trödelmarktes"
replace w04 = 4 if w04_sons == "Auroverkauf"
replace w04 = 5 if w04_sons == "Aushilfsarbeit"
replace w04 = 5 if w04_sons == "Auto abgeholt"
replace w04 = 5 if w04_sons == "Auto abgestellt"
replace w04 = 5 if w04_sons == "Auto abholen"
replace w04 = 5 if w04_sons == "Auto abstellen"
replace w04 = 5 if w04_sons == "Auto angeschaut"
replace w04 = 5 if w04_sons == "Auto aus dem Parkhaus holen"
replace w04 = 5 if w04_sons == "Auto aus garage geholt (ausserhalb vom Grundstück)"
replace w04 = 5 if w04_sons == "Auto besorgen"
replace w04 = 5 if w04_sons == "Auto geholt"
replace w04 = 5 if w04_sons == "Auto holen"
replace w04 = 5 if w04_sons == "Auto in die Garage gebracht"
replace w04 = 5 if w04_sons == "Auto in Garage"
replace w04 = 5 if w04_sons == "auto in garage bringen"
replace w04 = 5 if w04_sons == "Auto in Werkstatt abholen"
replace w04 = 5 if w04_sons == "Auto in Werkstatt bringen"
replace w04 = 5 if w04_sons == "Auto in werkstatt gebracht"
replace w04 = 4 if w04_sons == "Auto Kaufen"
replace w04 = 5 if w04_sons == "Auto übernehmen vom Ehemann"
replace w04 = 5 if w04_sons == "Auto vor Wirtshaus abholen"
replace w04 = 5 if w04_sons == "Auto waschem"
replace w04 = 5 if w04_sons == "Auto waschen"
replace w04 = 5 if w04_sons == "Auto weg bringen"
replace w04 = 5 if w04_sons == "Auto wegbringen"
replace w04 = 5 if w04_sons == "Auto zum Parkplatz gebracht"
replace w04 = 5 if w04_sons == "Auto zum TüV bringen"
replace w04 = 5 if w04_sons == "Auto zurück gebracht"
replace w04 = 4 if w04_sons == "Autohaus besucht"
replace w04 = 5 if w04_sons == "Autotausch mit Ehemann"
replace w04 = 5 if w04_sons == "Autowerkstadt"
replace w04 = 5 if w04_sons == "Auto-Werkstatt"
replace w04 = 5 if w04_sons == "AZTBESUCH"
replace w04 = 5 if w04_sons == "Babysitten"
replace w04 = 34 if w04_sons == "Bahnhof"
replace w04 = 5 if w04_sons == "Bank"
replace w04 = 1 if w04_sons == "Bau"
replace w04 = 1 if w04_sons == "Baustelle"
replace w04 = 7 if w04_sons == "Beerdiegungsessen"
replace w04 = 7 if w04_sons == "Beerdigung"
replace w04 = 6 if w04_sons == "Begeltung zum Kigas der Schwester"
replace w04 = 5 if w04_sons == "Begleitung"
replace w04 = 5 if w04_sons == "Begleitung der Frau"
replace w04 = 5 if w04_sons == "Begleitung der Person X"
replace w04 = 5 if w04_sons == "begleitung des ehemannes"
replace w04 = 5 if w04_sons == "begleitung des vaters"
replace w04 = 5 if w04_sons == "Begleitung Erwachsener"
replace w04 = 5 if w04_sons == "Begleitung Ihres Ehemannes"
replace w04 = 5 if w04_sons == "Begleitung Mutter ins Krankenhaus"
replace w04 = 5 if w04_sons == "Begleitung seiner Mutter"
replace w04 = 5 if w04_sons == "Begleitung Tochter"
replace w04 = 2 if w04_sons == "Behindertenwerkstatt"
replace w04 = 5 if w04_sons == "Behördengang"
replace w04 = 7 if w04_sons == "Bei den Kindern ihrer Tochter"
replace w04 = 5 if w04_sons == "Benzin holen"
replace w04 = 5 if w04_sons == "Benzin weggebracht"
replace w04 = 5 if w04_sons == "Bereuung bei der Oma"
replace w04 = 7 if w04_sons == "Bergerhausen"
replace w04 = 2 if w04_sons == "berufliche Fahrt - Dentallabor"
replace w04 = 5 if w04_sons == "Berufsorientierungskurs"
replace w04 = 7 if w04_sons == "Besichtigung im Rahmen der Ausbildung"
replace w04 = 5 if w04_sons == "Besorgungen"
replace w04 = 5 if w04_sons == "Besprechung beim Kirchenvorstand"
replace w04 = 5 if w04_sons == "Besprechung in einer Kirchengemeinde"
replace w04 = 7 if w04_sons == "Besuch"
replace w04 = 7 if w04_sons == "Besuch bei der Oma"
replace w04 = 7 if w04_sons == "Besuch bei Eltern"
replace w04 = 7 if w04_sons == "Besuch bei Freunden"
replace w04 = 7 if w04_sons == "Besuch bei Oma"
replace w04 = 7 if w04_sons == "Besuch beim Bruder"
replace w04 = 7 if w04_sons == "besuch der Cousine"
replace w04 = 7 if w04_sons == "Besuch der Freundin"
replace w04 = 7 if w04_sons == "Besuch der Großeltern"
replace w04 = 3 if w04_sons == "Besuch der RWTH Aachen"
replace w04 = 7 if w04_sons == "Besuch des Bauernhofes"
replace w04 = 7 if w04_sons == "Besuch des eigenen Weinbergs"
replace w04 = 5 if w04_sons == "Besuch des Gottesdienstes"
replace w04 = 7 if w04_sons == "Besuch des Nachbarn"
replace w04 = 7 if w04_sons == "Besuch des Schwiegervaters im Krankenhaus"
replace w04 = 7 if w04_sons == "Besuch des Vater"
replace w04 = 7 if w04_sons == "Besuch des Weinbergs"
replace w04 = 3 if w04_sons == "Besuch einer anderen Schule"
replace w04 = 7 if w04_sons == "besuch eines autohauses"
replace w04 = 7 if w04_sons == "Besuch Elektroausstellung"
replace w04 = 7 if w04_sons == "Besuch im Autohaus"
replace w04 = 7 if w04_sons == "Besuch im Krankenhaus"
replace w04 = 7 if w04_sons == "Besuch machen"
replace w04 = 5 if w04_sons == "Besuch und Singen im Altenheim"
replace w04 = 7 if w04_sons == "Besuch von Elektroausstellung"
replace w04 = 7 if w04_sons == "besuch von nachbaren"
replace w04 = 7 if w04_sons == "Besuchsort"
replace w04 = 5 if w04_sons == "Betreuung der Mutter"
replace w04 = 5 if w04_sons == "Betreuung einer Nachbarin"
replace w04 = 1 if w04_sons == "Betriebspraktikum"
replace w04 = 2 if w04_sons == "Bewerbungsgespräch"
replace w04 = 5 if w04_sons == "Bilder aufhägen"
replace w04 = 3 if w04_sons == "Bildung"
replace w04 = 1 if w04_sons == "bis zur Grenze , weiter zur Arbeit"
replace w04 = 5 if w04_sons == "Blumengießen"
replace w04 = 5 if w04_sons == "Blutabnahme beim Arzt"
replace w04 = 2 if w04_sons == "Botengang"
replace w04 = 5 if w04_sons == "Briefkasten"
replace w04 = 5 if w04_sons == "briefkasten des Sohnes geleehrt"
replace w04 = 5 if w04_sons == "Briefkasten geleehrt (Sohn)"
replace w04 = 5 if w04_sons == "Brot zu de Caritas bringen"
replace w04 = 6 if w04_sons == "Bruder zum Flughafen gefahren"
replace w04 = 7 if w04_sons == "Bücherei"
replace w04 = 4 if w04_sons == "Bummel"
replace w04 = 4 if w04_sons == "Bummel und Veranstaltung der Diakonie"
replace w04 = 2 if w04_sons == "Bundeswehr"
replace w04 = 7 if w04_sons == "Café nach Beerdigung"
replace w04 = 7 if w04_sons == "Cantine"
replace w04 = 7 if w04_sons == "Chor Auftritt"
replace w04 = 6 if w04_sons == "Cousine von der Schule anholen"
replace w04 = 5 if w04_sons == "das auto an der tankstelle waschen"
replace w04 = 5 if w04_sons == "das Auto von der Garage geholt"
replace w04 = 7 if w04_sons == "Der Weg zur Mittagspause"
replace w04 = 5 if w04_sons == "Dialyse"
replace w04 = 6 if w04_sons == "Die Tochter zum Kinderarzt gebracht."
replace w04 = 2 if w04_sons == "dienstlich"
replace w04 = 2 if w04_sons == "Dienstlich zum Amtsgericht"
replace w04 = 2 if w04_sons == "Dienstreise"
replace w04 = 5 if w04_sons == "Dinge Trasportiert"
replace w04 = 7 if w04_sons == "Disco"
replace w04 = 7 if w04_sons == "Eerreichen des urlaubszieles"
replace w04 = 11 if w04_sons == "Ehefrau vom Krankenhaus abgeholt"
replace w04 = 11 if w04_sons == "Ehefrau zum friseur gefahren"
replace w04 = 11 if w04_sons == "Eheman begleitet zu einer Angebotsabgabe"
replace w04 = 5 if w04_sons == "Ehrenamt"
replace w04 = 5 if w04_sons == "Ehrenamt in der Gemeinde"
replace w04 = 5 if w04_sons == "ehrenamtlich"
replace w04 = 5 if w04_sons == "ehrenamtlich tätig"
replace w04 = 5 if w04_sons == "ehrenamtliche Tätigkeit"
replace w04 = 7 if w04_sons == "ein Frühstück ausserhalb"
replace w04 = 5 if w04_sons == "Ein Transport"
replace w04 = 2 if w04_sons == "Einen Beleg abholen"
replace w04 = 6 if w04_sons == "einkaufen des täglichen bedarfs und kind von der schule abholen"
replace w04 = 5 if w04_sons == "Einsatz bei der freiwilligen Feuerwehr"
replace w04 = 7 if w04_sons == "Eis essen"
replace w04 = 5 if w04_sons == "Elternabend"
replace w04 = 5 if w04_sons == "Elternabend / Feuerwehr"
replace w04 = 5 if w04_sons == "Elternabend / Jugendfeuerwehr"
replace w04 = 5 if w04_sons == "elternabend in die schule"
replace w04 = 5 if w04_sons == "Elternabend Kinderladehn"
replace w04 = 5 if w04_sons == "Elterndienst im Kindergarten"
replace w04 = 5 if w04_sons == "Elternsprechtag"
replace w04 = 5 if w04_sons == "Enkel versorgt"
replace w04 = 5 if w04_sons == "Entsorgung von Glas"
replace w04 = 5 if w04_sons == "Erde mit Traktor transportiert"
replace w04 = 5 if w04_sons == "erledigung"
replace w04 = 5 if w04_sons == "Erledigungen"
replace w04 = 5 if w04_sons == "Erledigungen für den Führerschein gemacht"
replace w04 = 1 if w04_sons == "Erreichen der Baustelle"
replace w04 = 5 if w04_sons == "Erreichen der Baustelle für Eigenheim"
replace w04 = 7 if w04_sons == "Erreichen der Wohnung des Vaters"
replace w04 = 33 if w04_sons == "Erreichen der Zweitwohnung"
replace w04 = 34 if w04_sons == "Erreichen des Bahnhofes Wesel"
replace w04 = 34 if w04_sons == "Erreichen des Bahnhofs"
replace w04 = 7 if w04_sons == "Erreichen des Besuchsziel"
replace w04 = 7 if w04_sons == "Erreichen des Besuchsziels"
replace w04 = 34 if w04_sons == "Erreichen des Flughafens"
replace w04 = 5 if w04_sons == "erreichen des Parkplatzes des Arbeitgebers"
replace w04 = 1 if w04_sons == "Erreichen des Praktikumsplatzes"
replace w04 = 3 if w04_sons == "Erreichen eines Seminares"
replace w04 = 5 if w04_sons == "Ersatzteile holen"
replace w04 = 7 if w04_sons == "Essen"
replace w04 = 7 if w04_sons == "essen gehen"
replace w04 = 5 if w04_sons == "etwas vergessen"
replace w04 = 7 if w04_sons == "Excursion"
replace w04 = 33 if w04_sons == "fahren zu einen hotel"
replace w04 = 5 if w04_sons == "Fahrrad reparieren"
replace w04 = 5 if w04_sons == "Fahrschule"
replace w04 = 5 if w04_sons == "Fahrschüler"
replace w04 = 5 if w04_sons == "Fahrschulunterricht"
replace w04 = 5 if w04_sons == "Fahrstunde"
replace w04 = 33 if w04_sons == "fahrt ins hotel"
replace w04 = 7 if w04_sons == "Fahrt ins krankenhaus"
replace w04 = 7 if w04_sons == "Fahrt mit der Motoryacht aug der Elde-Wasserstrasse und Störkanal nach Schwerin"
replace w04 = 6 if w04_sons == "Fahrt nzum Haus, um Gattin mitzunehmrn"
replace w04 = 6 if w04_sons == "Fahrt um Kinder abzuholen"
replace w04 = 7 if w04_sons == "fahrt zu einem 10Km-K-Lauf"
replace w04 = 7 if w04_sons == "Fahrt zu ihre Freund"
replace w04 = 34 if w04_sons == "Fahrt zum Bus"
replace w04 = 7 if w04_sons == "Fahrt zum Heimatort"
replace w04 = 7 if w04_sons == "Fahrt zum Noric Walking"
replace w04 = 7 if w04_sons == "Fahrt zum Sportheim"
replace w04 = 7 if w04_sons == "Fahrt zur Geburtstagsfeier"
replace w04 = 7 if w04_sons == "Fahrt zur Hochzeit"
replace w04 = 7 if w04_sons == "Fahrt zur Kirche"
replace w04 = 7 if w04_sons == "Fahrt zur Kur"
replace w04 = 7 if w04_sons == "Fahrt zur Mittagspause"
replace w04 = 5 if w04_sons == "Fahrt zur Musikschule"
replace w04 = 7 if w04_sons == "Fahrt zur Mutter"
replace w04 = 7 if w04_sons == "Fahrt zur Oma"
replace w04 = 5 if w04_sons == "Fahrzeug Überführung"
replace w04 = 7 if w04_sons == "Familie besuchen"
replace w04 = 7 if w04_sons == "Familien besuch"
replace w04 = 7 if w04_sons == "Familienfeier"
replace w04 = 7 if w04_sons == "Familienfrühstück"
replace w04 = 7 if w04_sons == "feier"
replace w04 = 33 if w04_sons == "Ferienhaus"
replace w04 = 5 if w04_sons == "Ferien-Kinderbetreuung"
replace w04 = 5 if w04_sons == "Feuerwehrgrundlehrgang"
replace w04 = 5 if w04_sons == "Feurewehrhaus"
replace w04 = 7 if w04_sons == "Fiedhof"
replace w04 = 7 if w04_sons == "Fiedhof Dormagen"
replace w04 = 5 if w04_sons == "Finanzamt"
replace w04 = 5 if w04_sons == "flaschen entsorgen"
replace w04 = 5 if w04_sons == "flaschenwegbrigen"
replace w04 = 4 if w04_sons == "Flohmarkt"
replace w04 = 34 if w04_sons == "Flug nach Stuttgart"
replace w04 = 5 if w04_sons == "Fördergruppe"
replace w04 = 5 if w04_sons == "Fortbildung"
replace w04 = 5 if w04_sons == "Fortbildungsbesuch"
replace w04 = 5 if w04_sons == "Fortsetzung der Schulung"
replace w04 = 6 if w04_sons == "Frau zu Mittag nach hause holen"
replace w04 = 6 if w04_sons == "Frau zur  Arbeit gefahren"
replace w04 = 7 if w04_sons == "Freidhof"
replace w04 = 1 if w04_sons == "Freiwilliges Soziales Jahr"
replace w04 = 7 if w04_sons == "Freizeit"
replace w04 = 7 if w04_sons == "Freunde besucht"
replace w04 = 7 if w04_sons == "Freundin aufgesucht"
replace w04 = 7 if w04_sons == "Friedhof"
replace w04 = 7 if w04_sons == "Friedhofsbesuch"
replace w04 = 4 if w04_sons == "Friseur"
replace w04 = 5 if w04_sons == "Friseurtermin"
replace w04 = 4 if w04_sons == "Frisör"
replace w04 = 7 if w04_sons == "Frühstück"
replace w04 = 5 if w04_sons == "Fussballschuhe säubern"
replace w04 = 5 if w04_sons == "Fusspflege"
replace w04 = 5 if w04_sons == "Fußpflege für Für Ehemann"
replace w04 = 5 if w04_sons == "Gang zum Parkplatz"
replace w04 = 5 if w04_sons == "Gang zur Kfz-werkstatt"
replace w04 = 5 if w04_sons == "Ganztagsbetreuung"
replace w04 = 5 if w04_sons == "Garage"
replace w04 = 5 if w04_sons == "Garage Aufräumen"
replace w04 = 7 if w04_sons == "Gartenabfall wegbringen"
replace w04 = 7 if w04_sons == "Gartenarbeit beim Bruder"
replace w04 = 7 if w04_sons == "Gartenbesuch"
replace w04 = 33 if w04_sons == "Gastwohnung"
replace w04 = 7 if w04_sons == "Geburtstagsfeier"
replace w04 = 2 if w04_sons == "Geländeübung Bundeswehr"
replace w04 = 7 if w04_sons == "Gemeinde Fest"
replace w04 = 5 if w04_sons == "Gepäck abholen"
replace w04 = 4 if w04_sons == "Geschäft war geschlossen"
replace w04 = 5 if w04_sons == "Geschäftlich zur Bank"
replace w04 = 2 if w04_sons == "Geschäftseröffnung"
replace w04 = 7 if w04_sons == "Geschäftseröffnung von Freunden"
replace w04 = 4 if w04_sons == "Geschenk einkaufen"
replace w04 = 6 if w04_sons == "Geschwister von der Kita abholen"
replace w04 = 5 if w04_sons == "Gläser zum Glascontainer gebracht"
replace w04 = 7 if w04_sons == "Großelter"
replace w04 = 7 if w04_sons == "Großeltern besuchen"
replace w04 = 7 if w04_sons == "Gruppenstunde bei Maltesern"
replace w04 = 7 if w04_sons == "Gymmnastik"
replace w04 = 7 if w04_sons == "Gymnastik"
replace w04 = 5 if w04_sons == "Handy zur Reperatur"
replace w04 = 5 if w04_sons == "Hasen Füttern"
replace w04 = 3 if w04_sons == "Hat die Uni besucht von der schule aus"
replace w04 = 2 if w04_sons == "Hausbesuch"
replace w04 = 8 if w04_sons == "Heimreise"
replace w04 = 8 if w04_sons == "Heimreise mit dem Zug"
replace w04 = 7 if w04_sons == "Heißluftballon geflogen"
replace w04 = 1 if w04_sons == "herrichtung des gästehauses"
replace w04 = 5 if w04_sons == "Hessenwahl"
replace w04 = 5 if w04_sons == "Hilfe beim Umzug"
replace w04 = 7 if w04_sons == "Hinfahrt zur Gartenanlage"
replace w04 = 6 if w04_sons == "Hinfahrt zur Rehaklinik"
replace w04 = 7 if w04_sons == "Hochzeitsfeier"
replace w04 = 5 if w04_sons == "Hochzeitsvorbereitungen"
replace w04 = 5 if w04_sons == "Holz holen"
replace w04 = 5 if w04_sons == "Holz sägen"
replace w04 = 5 if w04_sons == "HORT"
replace w04 = 2 if w04_sons == "Hospitation"
replace w04 = 33 if w04_sons == "Hotel"
replace w04 = 33 if w04_sons == "Hotel in der Stadt der ehrenamtlichen Aktivität"
replace w04 = 5 if w04_sons == "Hund abholen"
replace w04 = 5 if w04_sons == "Hund bei den eltern abgegeben"
replace w04 = 5 if w04_sons == "Hund bei einer Freundin abgeben"
replace w04 = 7 if w04_sons == "Hund gassi führen"
replace w04 = 7 if w04_sons == "Hunderunde"
replace w04 = 7 if w04_sons == "Hundespaziergang"
replace w04 = 5 if w04_sons == "ich mußte zu meinem Verputzer wegen einer Reklamation"
replace w04 = 5 if w04_sons == "Im Rahmen des Umzugs"
replace w04 = 33 if w04_sons == "ims Hotel"
replace w04 = 7 if w04_sons == "in den Garten des Sohnes"
replace w04 = 32 if w04_sons == "in den Kindergarten"
replace w04 = 7 if w04_sons == "in den Osterurlaub gefahren"
replace w04 = 7 if w04_sons == "in den urlaub gefahren"
replace w04 = 33 if w04_sons == "in den zweitwohnsitz"
replace w04 = 7 if w04_sons == "in der Kantine essen"
replace w04 = 33 if w04_sons == "in die kaserne"
replace w04 = 7 if w04_sons == "in die Kirche"
replace w04 = 7 if w04_sons == "in die Kirsche"
replace w04 = 7 if w04_sons == "in die mensa"
replace w04 = 33 if w04_sons == "in die Pension"
replace w04 = 33 if w04_sons == "in die Unterkunft"
replace w04 = 33 if w04_sons == "in die Zweitwohnung"
replace w04 = 33 if w04_sons == "in die Zweitwohnung nach München"
replace w04 = 33 if w04_sons == "in eine Wohngruppe"
replace w04 = 33 if w04_sons == "in seine Wohnung in Berlin"
replace w04 = 33 if w04_sons == "In Zweitwohnung"
replace w04 = 32 if w04_sons == "inden Kindergarten"
replace w04 = 5 if w04_sons == "InfoBesuch im IT shop"
replace w04 = 5 if w04_sons == "information zu einem geburtstagsgeschenk"
replace w04 = 5 if w04_sons == "Informationen einholen"
replace w04 = 33 if w04_sons == "ins Ferienhaus zurück"
replace w04 = 33 if w04_sons == "ins Hotel"
replace w04 = 33 if w04_sons == "internat"
replace w04 = 5 if w04_sons == "Internet-Unterricht für Senioren"
replace w04 = 5 if w04_sons == "ist zur wohnungsbesichtigung gegangen"
replace w04 = 5 if w04_sons == "Jugendhilfeausschuss"
replace w04 = 5 if w04_sons == "Katzen von nachbarn füttern"
replace w04 = 32 if w04_sons == "KG"
replace w04 = 6 if w04_sons == "Kind zum Freund gebracht"
replace w04 = 6 if w04_sons == "Kinder in die Schule fahren"
replace w04 = 32 if w04_sons == "Kinderclub"
replace w04 = 32 if w04_sons == "Kindergarten"
replace w04 = 7 if w04_sons == "Kirche"
replace w04 = 7 if w04_sons == "Kirchenbesuch"
replace w04 = 7 if w04_sons == "Kirchgang"
replace w04 = 7 if w04_sons == "kirchliche Trauung"
replace w04 = 5 if w04_sons == "Kirschen flücken"
replace w04 = 7 if w04_sons == "Klarinettenunterricht"
replace w04 = 7 if w04_sons == "klassenfahrt"
replace w04 = 5 if w04_sons == "Kleinmöbel weiter gegeben"
replace w04 = 7 if w04_sons == "Klinik"
replace w04 = 2 if w04_sons == "Konferenz in der FH"
replace w04 = 5 if w04_sons == "Konfirmantenunterricht"
replace w04 = 2 if w04_sons == "Kongress Besuch"
replace w04 = 5 if w04_sons == "Kontrollgang am Friedhof"
replace w04 = 5 if w04_sons == "Kosmetikerin"
replace w04 = 5 if w04_sons == "Kranken Gymnastik"
replace w04 = 7 if w04_sons == "Krankenbesuch"
replace w04 = 7 if w04_sons == "Krankenbesuche"
replace w04 = 5 if w04_sons == "Krankengym"
replace w04 = 5 if w04_sons == "Krankengymnasti"
replace w04 = 5 if w04_sons == "Krankengymnastiik"
replace w04 = 5 if w04_sons == "Krankengymnastik"
replace w04 = 5 if w04_sons == "Krankengymnastikl"
replace w04 = 7 if w04_sons == "Krankenhaus"
replace w04 = 5 if w04_sons == "Krankenkasse"
replace w04 = 7 if w04_sons == "Krenkenbesuch"
replace w04 = 5 if w04_sons == "Kühe gefüttert"
replace w04 = 2 if w04_sons == "Kundenbesuch"
replace w04 = 7 if w04_sons == "Landschulheim"
replace w04 = 5 if w04_sons == "Leergut weggebracht"
replace w04 = 5 if w04_sons == "Lehrgang"
replace w04 = 6 if w04_sons == "Mann begleitetet beim Verteilen von Eier"
replace w04 = 7 if w04_sons == "Massage"
replace w04 = 5 if w04_sons == "Mediathek"
replace w04 = 7 if w04_sons == "Mensa aufgesucht"
replace w04 = 5 if w04_sons == "Mietshaus renovierung"
replace w04 = 5 if w04_sons == "Milch weggebracht"
replace w04 = 1 if w04_sons == "Minijob"
replace w04 = 7 if w04_sons == "mit dem Hund raus"
replace w04 = 7 if w04_sons == "mit dem Kindergarten zum Bauernhof"
replace w04 = 7 if w04_sons == "Mit dem Pferd draussen"
replace w04 = 7 if w04_sons == "Mit den Hunden draussen"
replace w04 = 11 if w04_sons == "Mit der Schwester unterwegs"
replace w04 = 6 if w04_sons == "Mit der Tochter zum Zahnarzt"
replace w04 = 7 if w04_sons == "mit Ehemann spazieren gegangen"
replace w04 = 5 if w04_sons == "Mit Freunden aufräumen"
replace w04 = 7 if w04_sons == "Mittag essen"
replace w04 = 7 if w04_sons == "Mittagessen"
replace w04 = 5 if w04_sons == "Mittagsbetreuung"
replace w04 = 7 if w04_sons == "Mittagspause"
replace w04 = 5 if w04_sons == "Müll Entsogung"
replace w04 = 5 if w04_sons == "Müll in Container"
replace w04 = 5 if w04_sons == "Müll wegbringen"
replace w04 = 5 if w04_sons == "Müll zur Wiederverwertungsstelle gebracht"
replace w04 = 5 if w04_sons == "Mülltonne"
replace w04 = 5 if w04_sons == "musste Baum bei Oma abliefern"
replace w04 = 7 if w04_sons == "Mutter im Geschäft besucht"
replace w04 = 7 if w04_sons == "Nach dem Grundstück sehen"
replace w04 = 8 if w04_sons == "nach hause"
replace w04 = 33 if w04_sons == "nach Hause in die Zweitwohnung"
replace w04 = 7 if w04_sons == "nach Hause zu den Cousinen"
replace w04 = 8 if w04_sons == "nach Hause zum Quartier"
replace w04 = 7 if w04_sons == "nach Hause zur Mutter"
replace w04 = 7 if w04_sons == "Nach Magdeburg"
replace w04 = 7 if w04_sons == "nach speyer"
replace w04 = 5 if w04_sons == "Nachbarschaftshilfe"
replace w04 = 5 if w04_sons == "Nachfrage bei EON"
replace w04 = 7 if w04_sons == "Nachhilfe"
replace w04 = 5 if w04_sons == "Nachhilfe geben"
replace w04 = 5 if w04_sons == "Nebenjob"
replace w04 = 5 if w04_sons == "Nebentätigkeit"
replace w04 = 2 if w04_sons == "nebenverdienst,zeitung austragen"
replace w04 = 7 if w04_sons == "neue Strasse anschauen"
replace w04 = 33 if w04_sons == "neue Wohnung zum Renovieren"
replace w04 = 33 if w04_sons == "Neuen Wohung"
replace w04 = 8 if w04_sons == "Norbert hat sie von der Bushaltestelle abgeholt und nach Hause gefahren"
replace w04 = 5 if w04_sons == "Notfall, Krankenhaus"
replace w04 = 7 if w04_sons == "Oma im Garten geholfen"
replace w04 = 7 if w04_sons == "Ortswechsel bei Weiterbildung"
replace w04 = 5 if w04_sons == "Papier entsorgen"
replace w04 = 5 if w04_sons == "Pappe Entsorgt"
replace w04 = 34 if w04_sons == "Park and Ride Parkplatz"
replace w04 = 5 if w04_sons == "Parken des Autos vom Handwerker"
replace w04 = 5 if w04_sons == "Parkhaus"
replace w04 = 6 if w04_sons == "Parkplatz um Benjamin abzuholen"
replace w04 = 5 if w04_sons == "Pediküre"
replace w04 = 7 if w04_sons == "Pferd aufs Feld gestellt"
replace w04 = 7 if w04_sons == "Pferd wieder rein gestellt"
replace w04 = 5 if w04_sons == "Pflege"
replace w04 = 5 if w04_sons == "Pflege der Tante"
replace w04 = 5 if w04_sons == "Pflege einer älteren Dame"
replace w04 = 5 if w04_sons == "Physieotherapie"
replace w04 = 5 if w04_sons == "Physiotherapie"
replace w04 = 7 if w04_sons == "Pilze sammeln"
replace w04 = 5 if w04_sons == "Pkw der Ehefrau zum Parkplatz gefahren"
replace w04 = 5 if w04_sons == "Plakate aufgehängt"
replace w04 = 5 if w04_sons == "Post aus leerstehender Wohnung holen"
replace w04 = 1 if w04_sons == "Praktikum"
replace w04 = 5 if w04_sons == "Probe in der Musikschule"
replace w04 = 5 if w04_sons == "Probefahrt"
replace w04 = 5 if w04_sons == "Reifen wechsel"
replace w04 = 8 if w04_sons == "Reisetaschen der Enkelkinder nach Hause (der Kinder) gebracht"
replace w04 = 7 if w04_sons == "Reiten"
replace w04 = 33 if w04_sons == "retour zur Unterkunft"
replace w04 = 5 if w04_sons == "Röntgen"
replace w04 = 7 if w04_sons == "Rückfahrt vom Arbeitsplatz und Treffen mit der Mutter"
replace w04 = 8 if w04_sons == "Rückfahrt vom Krankenhaus nach Hause"
replace w04 = 8 if w04_sons == "Rückfahrt vom Urlaub"
replace w04 = 33 if w04_sons == "Rückfahrt von Arbeitsstelle zur Unterkunft"
replace w04 = 33 if w04_sons == "Rückfahrt zum Hotel"
replace w04 = 33 if w04_sons == "Rückfaht zum Urlaubsort"
replace w04 = 8 if w04_sons == "Rückkehr aus dem Urlaub"
replace w04 = 33 if w04_sons == "Rückkehr ins Basiscamp Hotel"
replace w04 = 33 if w04_sons == "Rückkehr ins Basislager"
replace w04 = 33 if w04_sons == "Rückkehr ins Hotel"
replace w04 = 7 if w04_sons == "Rückkehr zu den Kindern"
replace w04 = 33 if w04_sons == "Rückkehr zum Hotel"
replace w04 = 7 if w04_sons == "Rückkehr zum Schlafen bei ihrem Freund"
replace w04 = 33 if w04_sons == "Rückkehr zur Basis"
replace w04 = 33 if w04_sons == "Rückkkehr zum Basiscamp"
replace w04 = 9 if w04_sons == "Rückweg"
replace w04 = 9 if w04_sons == "Rückweg als Beifahrer"
replace w04 = 33 if w04_sons == "Rückweg ins Hotel"
replace w04 = 8 if w04_sons == "Rückweg vom Urlaub"
replace w04 = 9 if w04_sons == "Rückweg vom vorherigen Weg"  & w04!=8
replace w04 = 7 if w04_sons == "Rückweg zu Bekannten vom einkauf"
replace w04 = 7 if w04_sons == "Rückweg zu den Bekannten"
replace w04 = 9 if w04_sons == "Rückweg zum 1. Ausgangspunkt"
replace w04 = 7 if w04_sons == "Rückweg zum Freund"
replace w04 = 7 if w04_sons == "Rückweg zum Haus der Tochter"
replace w04 = 33 if w04_sons == "Rückweg zum Hotel"
replace w04 = 7 if w04_sons == "Rückweg zur Bekannten"
replace w04 = 33 if w04_sons == "Rückweg zur Pension"
replace w04 = 33 if w04_sons == "Rückweg zur Unterkunft"
replace w04 = 7 if w04_sons == "Rum gefahren"
replace w04 = 7 if w04_sons == "Rundgang auf dem Flohmarkt"
replace w04 = 7 if w04_sons == "Rundweg"
replace w04 = 5 if w04_sons == "Rüstung leihen"
replace w04 = 5 if w04_sons == "Saal suchen"
replace w04 = 7 if w04_sons == "Satdtbesichtigung Neukloster"
replace w04 = 34 if w04_sons == "S-Bahn"
replace w04 = 5 if w04_sons == "Schulaugaben Hilfe"
replace w04 = 5 if w04_sons == "Schulausflug"
replace w04 = 5 if w04_sons == "Schulausflug (Sportveranstaltung)"
replace w04 = 3 if w04_sons == "Schule"
replace w04 = 5 if w04_sons == "Schülerlotzin"
replace w04 = 5 if w04_sons == "Schulprojekt mit Behinderten"
replace w04 = 5 if w04_sons == "Schulschwimmen"
replace w04 = 5 if w04_sons == "Schulschwimmen im Freibad"
replace w04 = 5 if w04_sons == "Schulsport"
replace w04 = 6 if w04_sons == "Schwester zum Autoglaser begleitet"
replace w04 = 7 if w04_sons == "Schwimmen"
replace w04 = 7 if w04_sons == "Schwimmunterricht"
replace w04 = 3 if w04_sons == "Seminarfach fürs Kolloquium (für die Schule)"
replace w04 = 6 if w04_sons == "Sohn begleitet, im Auto gewartet"
replace w04 = 6 if w04_sons == "Sohn zur Arbeit begleitet"
replace w04 = 7 if w04_sons == "Sonntagsgottesdienst"
replace w04 = 5 if w04_sons == "Sparkasse"
replace w04 = 7 if w04_sons == "Sparziergang"
replace w04 = 7 if w04_sons == "Spaziegang"
replace w04 = 7 if w04_sons == "Spazierengehen auf ärztliche Verordnung hin"
replace w04 = 7 if w04_sons == "Spazierfahrt"
replace w04 = 7 if w04_sons == "Spaziergang"
replace w04 = 7 if w04_sons == "Spaziergang - Mittagspause"
replace w04 = 7 if w04_sons == "Spaziergang mit dem hund"
replace w04 = 7 if w04_sons == "Spaziergang mit den Hunden"
replace w04 = 7 if w04_sons == "Spielen"
replace w04 = 5 if w04_sons == "Sport"
replace w04 = 6 if w04_sons == "Sportkamaraden nach Hause gefahren"
replace w04 = 5 if w04_sons == "Sportplatz/ Sponsorenlauf"
replace w04 = 5 if w04_sons == "Sportunterricht"
replace w04 = 5 if w04_sons == "Sportunterricht schwchwimmen"
replace w04 = 7 if w04_sons == "Stadbesichtigung Neukloster"
replace w04 = 7 if w04_sons == "Stadt"
replace w04 = 7 if w04_sons == "Stadt besichtigung"
replace w04 = 7 if w04_sons == "Stadtbummel"
replace w04 = 4 if w04_sons == "stand am bahnhof"
replace w04 = 5 if w04_sons == "Standesamt"
replace w04 = 4 if w04_sons == "Startpunkt des Einkaufs"
replace w04 = 7 if w04_sons == "Startpunkt des Weihnachtsmarktbesuchs"
replace w04 = 5 if w04_sons == "Staubsaugerrepertatur"
replace w04 = 6 if w04_sons == "Tageskind nach Hause bringen"
replace w04 = 32 if w04_sons == "Tagesmutter"
replace w04 = 5 if w04_sons == "Tannenbaum entsorgen"
replace w04 = 5 if w04_sons == "Tannenbäume verkaufen"
replace w04 = 7 if w04_sons == "Tante"
replace w04 = 6 if w04_sons == "Tochter bei Schwiegereltern abgeholt"
replace w04 = 6 if w04_sons == "Tochter in den Kindergarten gebracht"
replace w04 = 5 if w04_sons == "toxchter beim hausbau helfen"
replace w04 = 7 if w04_sons == "Training"
replace w04 = 7 if w04_sons == "Trauerfeier"
replace w04 = 7 if w04_sons == "Treffen"
replace w04 = 7 if w04_sons == "Treffpunkt"
replace w04 = 7 if w04_sons == "Treffpunkt Geschäft"
replace w04 = 7 if w04_sons == "Treffpunkt mit Frau"
replace w04 = 7 if w04_sons == "Trompetenunterricht"
replace w04 = 7 if w04_sons == "Türkei"
replace w04 = 7 if w04_sons == "Turnen"
replace w04 = 5 if w04_sons == "TüV"
replace w04 = 5 if w04_sons == "Umschulung"
replace w04 = 5 if w04_sons == "Umtausch von einem Artikel"
replace w04 = 5 if w04_sons == "Umtausch von Ware"
replace w04 = 5 if w04_sons == "Umzug"
replace w04 = 5 if w04_sons == "Umzugshilfe"
replace w04 = 1 if w04_sons == "Unipraktikum an einer Schule"
replace w04 = 3 if w04_sons == "Universätität"
replace w04 = 3 if w04_sons == "Universität"
replace w04 = 7 if w04_sons == "Urlaub in Italien"
replace w04 = 8 if w04_sons == "Urlaubsrückreise"
replace w04 = 5 if w04_sons == "Veranstaltung in der Schule"
replace w04 = 5 if w04_sons == "Versammlung"
replace w04 = 7 if w04_sons == "Verwandte besucht"
replace w04 = 2 if w04_sons == "vom Einkaufen um Kunden im Rahmen der beruflichen Wege"
replace w04 = 7 if w04_sons == "Vom Einkaufen zum Garten"
replace w04 = 7 if w04_sons == "von der Arbeit zur Oma gefahren"
replace w04 = 8 if w04_sons == "von der klassenfahrt"
replace w04 = 7 if w04_sons == "von zuhause zum Studenwohnheim"
replace w04 = 2 if w04_sons == "Vorstellungsgespräch"
replace w04 = 5 if w04_sons == "Wagen aus Garage geholt"
replace w04 = 5 if w04_sons == "wagen hollen"
replace w04 = 5 if w04_sons == "Wagen zur Garage gefahren"
replace w04 = 5 if w04_sons == "Wahl, Büregrentscheid"
replace w04 = 5 if w04_sons == "Wählen"
replace w04 = 2 if w04_sons == "WALDARBEITEN"
replace w04 = 7 if w04_sons == "Wanderen"
replace w04 = 7 if w04_sons == "Wanderung"
replace w04 = 5 if w04_sons == "Wäscherei"
replace w04 = 7 if w04_sons == "Wassergymnastik"
replace w04 = 5 if w04_sons == "Weg in die Werkstatt"
replace w04 = 33 if w04_sons == "Weg ins Hotel"
replace w04 = 33 if w04_sons == "Weg ins Hotel zur Übernachtung"
replace w04 = 7 if w04_sons == "Weg ins Krankenhaus"
replace w04 = 7 if w04_sons == "Weg nach Halle (Heimatort)"
replace w04 = 7 if w04_sons == "Weg nach Neukloster"
replace w04 = 7 if w04_sons == "Weg vom Ziel des Berglaufes zur Hütte nahe Gipfelkreuz"
replace w04 = 7 if w04_sons == "Weg zu dem Geschäft der Eltern"
replace w04 = 7 if w04_sons == "Weg zu den Eltern"
replace w04 = 7 if w04_sons == "Weg zu den Großeltern"
replace w04 = 5 if w04_sons == "Weg zu den Schwiegereltern"
replace w04 = 7 if w04_sons == "Weg zu einem Treffpunkt"
replace w04 = 7 if w04_sons == "Weg zu einem Vortrag"
replace w04 = 7 if w04_sons == "Weg zu einer Geburtstagsfeier"
replace w04 = 7 if w04_sons == "Weg zu einer Veranstaltung"
replace w04 = 7 if w04_sons == "Weg zu Treffpunkt für Fahrgemeinschaft zur Schule"
replace w04 = 7 if w04_sons == "Weg zum Ausgangspunkt der Wanderung"
replace w04 = 5 if w04_sons == "weg zum Auto"
replace w04 = 4 if w04_sons == "Weg zum Bäcker"
replace w04 = 34 if w04_sons == "Weg zum Bahnhof"
replace w04 = 4 if w04_sons == "Weg zum Blumenfachhandel"
replace w04 = 34 if w04_sons == "Weg zum Bus"
replace w04 = 7 if w04_sons == "Weg zum eigenen Garten"
replace w04 = 4 if w04_sons == "Weg zum Fahrradhändler"
replace w04 = 4 if w04_sons == "Weg zum Feinkostladen"
replace w04 = 7 if w04_sons == "Weg zum Feld"
replace w04 = 7 if w04_sons == "Weg zum Ferienort(zur Ostsee)"
replace w04 = 7 if w04_sons == "Weg zum Flohmarkt"
replace w04 = 7 if w04_sons == "Weg zum Flugplatz"
replace w04 = 5 if w04_sons == "Weg zum Friedhof"
replace w04 = 5 if w04_sons == "Weg zum Friseur"
replace w04 = 7 if w04_sons == "Weg zum Garten"
replace w04 = 5 if w04_sons == "Weg zum Geburtstag"
replace w04 = 5 if w04_sons == "Weg zum Geburtstagskind"
replace w04 = 7 if w04_sons == "Weg zum Gottesdienst"
replace w04 = 33 if w04_sons == "Weg zum Hotel"
replace w04 = 7 if w04_sons == "Weg zum Jahrmarkt"
replace w04 = 7 if w04_sons == "Weg zum Jugendzentrum"
replace w04 = 32 if w04_sons == "Weg zum Kindergarten"
replace w04 = 7 if w04_sons == "Weg zum Motorradclub"
replace w04 = 5 if w04_sons == "Weg zum Müllkontainer"
replace w04 = 5 if w04_sons == "Weg zum Optiker"
replace w04 = 5 if w04_sons == "Weg zum Postkasten"
replace w04 = 1 if w04_sons == "Weg zum Praktikum"
replace w04 = 1 if w04_sons == "Weg zum Praktikumsbetrieb"
replace w04 = 5 if w04_sons == "Weg zum Rathaus"
replace w04 = 3 if w04_sons == "Weg zum Schulkurs"
replace w04 = 5 if w04_sons == "Weg zum Schulungsraum"
replace w04 = 5 if w04_sons == "Weg zum Solarium"
replace w04 = 5 if w04_sons == "Weg zum Sportunterricht"
replace w04 = 7 if w04_sons == "Weg zum Stadtbummel"
replace w04 = 7 if w04_sons == "weg zum Theater"
replace w04 = 5 if w04_sons == "Weg zum Tierarzt"
replace w04 = 7 if w04_sons == "Weg zum Urlaub"
replace w04 = 8 if w04_sons == "Weg zum Wohnheim"
replace w04 = 1 if w04_sons == "Weg zum Zweitjob"
replace w04 = 1 if w04_sons == "Weg zur 2, berufl. Tätigkeit"
replace w04 = 5 if w04_sons == "Weg zur Aufführung"
replace w04 = 3 if w04_sons == "Weg zur Ausbildung"
replace w04 = 5 if w04_sons == "Weg zur Autowerkstatt"
replace w04 = 4 if w04_sons == "Weg zur Bäckerei"
replace w04 = 4 if w04_sons == "Weg zur Bäckerei zum Frühstück"
replace w04 = 5 if w04_sons == "Weg zur Baustelle"
replace w04 = 7 if w04_sons == "Weg zur Beerdigung"
replace w04 = 3 if w04_sons == "Weg zur Berufsschule"
replace w04 = 34 if w04_sons == "Weg zur Fähre"
replace w04 = 5 if w04_sons == "Weg zur Fahrschule"
replace w04 = 7 if w04_sons == "Weg zur Familienfeier"
replace w04 = 7 if w04_sons == "Weg zur Feier"
replace w04 = 7 if w04_sons == "Weg zur Feuerwehr"
replace w04 = 5 if w04_sons == "Weg zur Garage"
replace w04 = 7 if w04_sons == "Weg zur Gartenanlage"
replace w04 = 5 if w04_sons == "Weg zur Kantine"
replace w04 = 33 if w04_sons == "Weg zur Kaserne vom Biwak"
replace w04 = 5 if w04_sons == "Weg zur Kirche"
replace w04 = 5 if w04_sons == "Weg zur kirchlichen Trauung"
replace w04 = 5 if w04_sons == "Weg zur Klavierschule"
replace w04 = 5 if w04_sons == "Weg zur Komunalwahl"
replace w04 = 5 if w04_sons == "Weg zur Krankengymnastik"
replace w04 = 5 if w04_sons == "Weg zur Lesung"
replace w04 = 7 if w04_sons == "Weg zur Mutter(Schülerlotzin)"
replace w04 = 7 if w04_sons == "Weg zur Nachbarin"
replace w04 = 5 if w04_sons == "Weg zur Nachhilfeschülerin"
replace w04 = 5 if w04_sons == "Weg zur Oma"
replace w04 = 5 if w04_sons == "Weg zur Post"
replace w04 = 5 if w04_sons == "Weg zur Praxis"
replace w04 = 7 if w04_sons == "Weg zur Probefahrt"
replace w04 = 5 if w04_sons == "Weg zur Reha"
replace w04 = 7 if w04_sons == "Weg zur Rheinpromenade"
replace w04 = 5 if w04_sons == "Weg zur Sonnenbank"
replace w04 = 7 if w04_sons == "Weg zur Sportveranstaltung"
replace w04 = 34 if w04_sons == "Weg zur Strassenbahnhaltestelle"
replace w04 = 7 if w04_sons == "Weg zur Studien-WG"
replace w04 = 32 if w04_sons == "Weg zur Tagesmutter"
replace w04 = 5 if w04_sons == "Weg zur Tankstelle"
replace w04 = 7 if w04_sons == "Weg zur Theateraufführung"
replace w04 = 5 if w04_sons == "Weg zur Trauung"
replace w04 = 3 if w04_sons == "Weg zur Uni"
replace w04 = 3 if w04_sons == "Weg zur Universität"
replace w04 = 7 if w04_sons == "Weg zur Veranstaltung im Ehrenamt"
replace w04 = 5 if w04_sons == "Weg zur Versicherung"
replace w04 = 7 if w04_sons == "Weg zur Weiterbildung"
replace w04 = 7 if w04_sons == "Weg zur Weiterbildungsstätte"
replace w04 = 5 if w04_sons == "Weg zur werkstatt der Hochschule"
replace w04 = 5 if w04_sons == "Weg zur Wohnung des Vaters"
replace w04 = 33 if w04_sons == "Weg zur Zweitwohnung"
replace w04 = 33 if w04_sons == "Weg zurück ins Hotel"
replace w04 = 1 if w04_sons == "Wege in der Fabrikhalle"
replace w04 = 7 if w04_sons == "Weihnachtsmarkt"
replace w04 = 4 if w04_sons == "Wein und Blumen"
replace w04 = 7 if w04_sons == "Weiterbildung"
replace w04 = 2 if w04_sons == "Werbetour"
replace w04 = 5 if w04_sons == "Werkstatt"
replace w04 = 5 if w04_sons == "Werkzeug ausgeliehen"
replace w04 = 5 if w04_sons == "Werkzeug holen"
replace w04 = 5 if w04_sons == "Wertstoffhof"
replace w04 = 5 if w04_sons == "Wohnungsbesichtigung"
replace w04 = 5 if w04_sons == "Wohungsbetreuung"
replace w04 = 8 if w04_sons == "wollte nach Hause, Bus fuhr dann nicht mehr weiter"
replace w04 = 6 if w04_sons == "wollte Sohn von der Schule abholen, dieser war aber nicht mehr dort"
replace w04 = 6 if w04_sons == "wurde abgeholt"
replace w04 = 5 if w04_sons == "Zahnarzt"
replace w04 = 5 if w04_sons == "Zahnarztbesuch"
replace w04 = 2 if w04_sons == "Zeitung austragen"
replace w04 = 2 if w04_sons == "Zeitungen austragen"
replace w04 = 4 if w04_sons == "Ziel Einkauf, aber etwas vergessen und deshalb zurück"
replace w04 = 7 if w04_sons == "Ziel zum Hundeausführen"
replace w04 = 7 if w04_sons == "zm Resraurant"
replace w04 = 5 if w04_sons == "zu den Grosseltern"
replace w04 = 5 if w04_sons == "zu den Großeltern, um dann mit Mutter nach Hause zu fahren"
replace w04 = 5 if w04_sons == "zu einem anderen Friedhof"
replace w04 = 5 if w04_sons == "zu einem Vortrag in die Uniklinik gefahren"
replace w04 = 5 if w04_sons == "zu Friedhof"
replace w04 = 5 if w04_sons == "Zu Fuß zur Garage"
replace w04 = 8 if w04_sons == "zu Hause in Göttingen"
replace w04 = 33 if w04_sons == "zu ihrem Zweitwohnsitz"
replace w04 = 32 if w04_sons == "zu KITA"
replace w04 = 5 if w04_sons == "zu meinem Freund (mein zweites zu Hause)"
replace w04 = 8 if w04_sons == "zu seiner neuen Wohnung gefahen"
replace w04 = 34 if w04_sons == "Zugfahrt zum Zielbahnhof"
replace w04 = 7 if w04_sons == "zum  Fiedhof"
replace w04 = 5 if w04_sons == "Zum Altkleiderkontainer gefahren"
replace w04 = 7 if w04_sons == "Zum Angeln"
replace w04 = 7 if w04_sons == "zum ausgangspunkt der wanderung"
replace w04 = 5 if w04_sons == "Zum Auto um Öl einzufüllen"
replace w04 = 5 if w04_sons == "Zum Auto Waschen"
replace w04 = 4 if w04_sons == "Zum Autohaus"
replace w04 = 34 if w04_sons == "zum Bahnhof"
replace w04 = 34 if w04_sons == "Zum Bahnhof gefahren"
replace w04 = 34 if w04_sons == "zum bahnhoff"
replace w04 = 7 if w04_sons == "Zum Ball"
replace w04 = 5 if w04_sons == "Zum Briefkasten"
replace w04 = 33 if w04_sons == "zum Campingplatz"
replace w04 = 7 if w04_sons == "Zum essen"
replace w04 = 7 if w04_sons == "Zum Essen Rast eingelegt"
replace w04 = 33 if w04_sons == "zum Ferienhaus"
replace w04 = 7 if w04_sons == "Zum Flohmarkt"
replace w04 = 34 if w04_sons == "Zum Flughafen"
replace w04 = 7 if w04_sons == "zum Freund"
replace w04 = 7 if w04_sons == "zum Freund gefahren"
replace w04 = 7 if w04_sons == "zum Freund vom Sohn gefahren"
replace w04 = 5 if w04_sons == "zum Fridhof"
replace w04 = 5 if w04_sons == "zum Friedhof"
replace w04 = 5 if w04_sons == "zum Friehof"
replace w04 = 7 if w04_sons == "zum Frühstück"
replace w04 = 7 if w04_sons == "Zum garten"
replace w04 = 33 if w04_sons == "zum Hotel"
replace w04 = 33 if w04_sons == "zum Hotel gegangen"
replace w04 = 33 if w04_sons == "zum Hotel zurück"
replace w04 = 7 if w04_sons == "Zum Krankenhaus"
replace w04 = 4 if w04_sons == "Zum Markt"
replace w04 = 5 if w04_sons == "Zum Müllplatz"
replace w04 = 5 if w04_sons == "Zum Parkhaus"
replace w04 = 5 if w04_sons == "zum Parkplatz"
replace w04 = 7 if w04_sons == "zum Resraurant"
replace w04 = 7 if w04_sons == "zum Restaurant"
replace w04 = 7 if w04_sons == "zum Schrebergarten"
replace w04 = 34 if w04_sons == "zum Schulbus"
replace w04 = 5 if w04_sons == "zum Schulungsraum"
replace w04 = 7 if w04_sons == "Zum Schutzenfest"
replace w04 = 5 if w04_sons == "Zum Seminar nach Bochum"
replace w04 = 5 if w04_sons == "Zum Seminarort"
replace w04 = 7 if w04_sons == "Zum Skat"
replace w04 = 5 if w04_sons == "Zum Sohn in die werkstatt"
replace w04 = 7 if w04_sons == "zum Sport"
replace w04 = 7 if w04_sons == "zum Sportplatz"
replace w04 = 7 if w04_sons == "zum Startpunkt der Stadtbesichtigung"
replace w04 = 7 if w04_sons == "zum Startpunkt der Wanderung"
replace w04 = 7 if w04_sons == "zum Startpunkt des bummels"
replace w04 = 4 if w04_sons == "zum Startpunkt des Einkaufs"
replace w04 = 4 if w04_sons == "zum Startpunkt des Einkaufsbummels"
replace w04 = 7 if w04_sons == "zum Startpunkt Gassigehen erreicht"
replace w04 = 7 if w04_sons == "zum Startpunpt der fahrradtour"
replace w04 = 7 if w04_sons == "zum treffpunkt"
replace w04 = 7 if w04_sons == "zum Trödelmarkt"
replace w04 = 5 if w04_sons == "Zum TüV"
replace w04 = 33 if w04_sons == "zum Übernachtungszimmer gegangen"
replace w04 = 5 if w04_sons == "zum Verputzer"
replace w04 = 7 if w04_sons == "zum Weihnachtsmarkt"
replace w04 = 7 if w04_sons == "Zum wochenmarkt"
replace w04 = 8 if w04_sons == "Zum Wohnheim"
replace w04 = 5 if w04_sons == "ZUM ZAHNARZT"
replace w04 = 1 if w04_sons == "zum Zivildienst"
replace w04 = 33 if w04_sons == "zum zweiten Wohnsitz"
replace w04 = 5 if w04_sons == "Zur Apotheke"
replace w04 = 7 if w04_sons == "zur Arbeitsstelle der Mutter gegangen"
replace w04 = 5 if w04_sons == "Zur Auto Werkstatt"
replace w04 = 5 if w04_sons == "Zur Autowerkstatt"
replace w04 = 5 if w04_sons == "zur Bank gefahren"
replace w04 = 5 if w04_sons == "Zur Baustelle"
replace w04 = 1 if w04_sons == "zur bundeswehr"
replace w04 = 34 if w04_sons == "zur Bushaltestelle"
replace w04 = 34 if w04_sons == "zur Bushaltestelle auf dem Weg zur Schule"
replace w04 = 7 if w04_sons == "zur Cafeteria"
replace w04 = 7 if w04_sons == "zur Cafeteria Mittagessen"
replace w04 = 7 if w04_sons == "zur Ehrenamtlichen Tätigkeit"
replace w04 = 7 if w04_sons == "Zur einer Wanderung"
replace w04 = 5 if w04_sons == "Zur Fahrschule"
replace w04 = 7 if w04_sons == "Zur Feier"
replace w04 = 7 if w04_sons == "zur Freundin gegangen"
replace w04 = 5 if w04_sons == "Zur Fusspflege"
replace w04 = 5 if w04_sons == "zur Garage"
replace w04 = 34 if w04_sons == "zur Haltestelle"
replace w04 = 5 if w04_sons == "Zur Kantine früstücken"
replace w04 = 33 if w04_sons == "zur Kaserne"
replace w04 = 5 if w04_sons == "zur Messe gefahren"
replace w04 = 5 if w04_sons == "Zur Müllwiederverwertung"
replace w04 = 7 if w04_sons == "zur Mutter gegangen"
replace w04 = 5 if w04_sons == "zur Mutter ins Büro"
replace w04 = 33 if w04_sons == "zur neuen Wohnung"
replace w04 = 33 if w04_sons == "Zur Neuen Wohung"
replace w04 = 5 if w04_sons == "zur oma"
replace w04 = 5 if w04_sons == "zur Oma zur Betreuung"
replace w04 = 33 if w04_sons == "zur Pension"
replace w04 = 3 if w04_sons == "Zur Schule"
replace w04 = 5 if w04_sons == "zur Schwiegermutter gegangen und Brötchen hingebracht"
replace w04 = 7 if w04_sons == "zur Sporthalle gegangen"
replace w04 = 32 if w04_sons == "zur Tagesmutter"
replace w04 = 5 if w04_sons == "zur Tankstelle gefahren"
replace w04 = 5 if w04_sons == "Zur Therapie"
replace w04 = 3 if w04_sons == "zur Universität gefahren"
replace w04 = 33 if w04_sons == "zur Unterkunft"
replace w04 = 33 if w04_sons == "zur Unterkunft (arbeitet auf Montage)"
replace w04 = 33 if w04_sons == "zur Unterkunft am Arbeitsort"
replace w04 = 33 if w04_sons == "zur Unterkunft am Urlaubsort"
replace w04 = 33 if w04_sons == "zur Unterkunft in der Studienstadt"
replace w04 = 5 if w04_sons == "Zur Videothek"
replace w04 = 5 if w04_sons == "zur Waffenkammer"
replace w04 = 7 if w04_sons == "Zur Wanderung"
replace w04 = 5 if w04_sons == "zur Weiterbildung"
replace w04 = 5 if w04_sons == "Zur Werkstatt"
replace w04 = 33 if w04_sons == "zur wöchentlichen Wohnung"
replace w04 = 5 if w04_sons == "zur Wohnung der Gastgeberin"
replace w04 = 34 if w04_sons == "Zur Yachthafen"
replace w04 = 33 if w04_sons == "zur Zweitwohnung"
replace w04 = 33 if w04_sons == "zurück in das Hotel"
replace w04 = 33 if w04_sons == "Zurück ins Ferienhaus"
replace w04 = 33 if w04_sons == "zurück ins Hotel"
replace w04 = 33 if w04_sons == "zurück ins Übernachtungszimmer"
replace w04 = 8 if w04_sons == "zurück nach Hause"
replace w04 = 5 if w04_sons == "zurück zu dem Besuch"
replace w04 = 5 if w04_sons == "zurück zu den Eltern"
replace w04 = 5 if w04_sons == "zurück zu den Freunden"
replace w04 = 5 if w04_sons == "zurück zu den Großeltern"
replace w04 = 5 if w04_sons == "zurück zu den Kindern"
replace w04 = 5 if w04_sons == "zurück zu der Mutter"
replace w04 = 8 if w04_sons == "ZURÜCK ZU DER WOHNUNG WO SIE MOMENTAN  WOHNT"
replace w04 = 5 if w04_sons == "zurück zu meinen Gastgebern"
replace w04 = 5 if w04_sons == "zurück zu seiner Freundin"
replace w04 = 5 if w04_sons == "zurück zu Verwandten"
replace w04 = 4 if w04_sons == "Zurück zum Aotuhaus"
replace w04 = 1 if w04_sons == "zurück zum Arbeitsplatz"
replace w04 = 33 if w04_sons == "zurück zum Ferienhaus"
replace w04 = 5 if w04_sons == "zurück zum Haus der Freundin"
replace w04 = 33 if w04_sons == "zurück zum Hotel"
replace w04 = 5 if w04_sons == "zurück zum Schulungsraum"
replace w04 = 5 if w04_sons == "Zurück zum Vater"
replace w04 = 33 if w04_sons == "zurück zum Zweitwohnsitz"
replace w04 = 5 if w04_sons == "zurück zur Bekannten"
replace w04 = 33 if w04_sons == "zurück zur Fereinwohnung"
replace w04 = 33 if w04_sons == "zurück zur Ferienunterkunft"
replace w04 = 33 if w04_sons == "zurück zur Ferienwohnung"
replace w04 = 5 if w04_sons == "zurück zur Freundin"
replace w04 = 5 if w04_sons == "zurück zur Garage"
replace w04 = 33 if w04_sons == "zurück zur Kaserne"
replace w04 = 33 if w04_sons == "zurück zur Pension"
replace w04 = 5 if w04_sons == "zurück zur Schwiegermutter"
replace w04 = 8 if w04_sons == "Zurück zur Studentenwohnung"
replace w04 = 7 if w04_sons == "zurück zur Tochter mit Enkel"
replace w04 = 33 if w04_sons == "zurück zur Unterkunft"
replace w04 = 7 if w04_sons == "zurück zur Unterkunft (Konfirmandenfreizeit)"
replace w04 = 33 if w04_sons == "zurück zur Unterkunft (Urlaubsort)"
replace w04 = 5 if w04_sons == "zurück zur Wohnung der Freundin"
replace w04 = 5 if w04_sons == "zurück zur Wohnung der Gastgeberin"
replace w04 = 33 if w04_sons == "zurück zur Zweitwohnung"
replace w04 = 33 if w04_sons == "zurück zur Zweitwohnung am Arbeitsort"
replace w04 = 33 if w04_sons == "Zweit Wohnug"
replace w04 = 1 if w04_sons == "zweite arbeitsstelle"
replace w04 = 33 if w04_sons == "zweitwohnsitz"
replace w04 = 33 if w04_sons == "Zweitwohnung"
replace w04 = 34 if w04_sons == "Zwischenstation Bahnhof"

replace w04_dzw = 503 if w04_sons == "1. Teil des Weges zum Einkauf"
replace w04_dzw = 711 if w04_sons == "2. Hunderunde"
replace w04_dzw = 604 if w04_sons == "2. Wohnung anschauen"
replace w04_dzw = 711 if w04_sons == "3. Hunderunde"
replace w04_dzw = 708 if w04_sons == "Aachen"
replace w04_dzw = 604 if w04_sons == "Abholen von Material"
replace w04_dzw = 604 if w04_sons == "Abholung einer Maschine"
replace w04_dzw = 604 if w04_sons == "Ábholung von geparktem Auto"
replace w04_dzw = 504 if w04_sons == "Abholung Wohnwagen aus Werkstatt"
replace w04_dzw = 701 if w04_sons == "Ad. ist zu seinen Großeltern gegangen"
replace w04_dzw = 712 if w04_sons == "Aktivierung der Beine."
replace w04_dzw = 604 if w04_sons == "Alte Wohnung aufraumen"
replace w04_dzw = 604 if w04_sons == "aLTGELAS WEG BRINGEN"
replace w04_dzw = 604 if w04_sons == "Altglasentsorgung"
replace w04_dzw = 604 if w04_sons == "Altpapier"
replace w04_dzw = 708 if w04_sons == "anderer Ort"
replace w04_dzw = 717 if w04_sons == "ANGELN"
replace w04_dzw = 604 if w04_sons == "Anhänger aus der Garage geholt"
replace w04_dzw = 701 if w04_sons == "Ankunft beim Vater"
replace w04_dzw = 604 if w04_sons == "Anmelden der Tochter bei der Fahrschule"
replace w04_dzw = 604 if w04_sons == "Anmelden in der fahrschule"
replace w04_dzw = 504 if w04_sons == "Apotheke"
replace w04_dzw = 602 if w04_sons == "Arbeitsgericht"
replace w04_dzw = 504 if w04_sons == "Arbeitsschuhe abgeholt"
replace w04_dzw = 701 if w04_sons == "Arbeitsstelle des Freundes aufgesucht zwecks Abholung"
replace w04_dzw = 601 if w04_sons == "Arzt"
replace w04_dzw = 601 if w04_sons == "Arzt besuch"
replace w04_dzw = 601 if w04_sons == "Arztbesuch"
replace w04_dzw = 601 if w04_sons == "Arztbesuch, Krankenhaus, Untersuchung"
replace w04_dzw = 601 if w04_sons == "Arztbesuich"
replace w04_dzw = 720 if w04_sons == "Auf der Feier"
replace w04_dzw = 503 if w04_sons == "aufsuchen eines Trödelmarktes"
replace w04_dzw = 502 if w04_sons == "Auroverkauf"
replace w04_dzw = 715 if w04_sons == "Aushilfsarbeit"
replace w04_dzw = 604 if w04_sons == "Auto abgeholt"
replace w04_dzw = 604 if w04_sons == "Auto abgestellt"
replace w04_dzw = 604 if w04_sons == "Auto abholen"
replace w04_dzw = 604 if w04_sons == "Auto abstellen"
replace w04_dzw = 504 if w04_sons == "Auto angeschaut"
replace w04_dzw = 604 if w04_sons == "Auto aus dem Parkhaus holen"
replace w04_dzw = 604 if w04_sons == "Auto aus garage geholt (ausserhalb vom Grundstück)"
replace w04_dzw = 604 if w04_sons == "Auto besorgen"
replace w04_dzw = 604 if w04_sons == "Auto geholt"
replace w04_dzw = 604 if w04_sons == "Auto holen"
replace w04_dzw = 604 if w04_sons == "Auto in die Garage gebracht"
replace w04_dzw = 604 if w04_sons == "Auto in Garage"
replace w04_dzw = 604 if w04_sons == "auto in garage bringen"
replace w04_dzw = 504 if w04_sons == "Auto in Werkstatt abholen"
replace w04_dzw = 504 if w04_sons == "Auto in Werkstatt bringen"
replace w04_dzw = 504 if w04_sons == "Auto in werkstatt gebracht"
replace w04_dzw = 502 if w04_sons == "Auto Kaufen"
replace w04_dzw = 604 if w04_sons == "Auto übernehmen vom Ehemann"
replace w04_dzw = 604 if w04_sons == "Auto vor Wirtshaus abholen"
replace w04_dzw = 604 if w04_sons == "Auto waschem"
replace w04_dzw = 604 if w04_sons == "Auto waschen"
replace w04_dzw = 604 if w04_sons == "Auto weg bringen"
replace w04_dzw = 604 if w04_sons == "Auto wegbringen"
replace w04_dzw = 604 if w04_sons == "Auto zum Parkplatz gebracht"
replace w04_dzw = 604 if w04_sons == "Auto zum TüV bringen"
replace w04_dzw = 604 if w04_sons == "Auto zurück gebracht"
replace w04_dzw = 502 if w04_sons == "Autohaus besucht"
replace w04_dzw = 604 if w04_sons == "Autotausch mit Ehemann"
replace w04_dzw = 504 if w04_sons == "Autowerkstadt"
replace w04_dzw = 504 if w04_sons == "Auto-Werkstatt"
replace w04_dzw = 601 if w04_sons == "AZTBESUCH"
replace w04_dzw = 715 if w04_sons == "Babysitten"
replace w04_dzw = 602 if w04_sons == "Bank"
replace w04_dzw = 706 if w04_sons == "Beerdiegungsessen"
replace w04_dzw = 713 if w04_sons == "Beerdigung"
replace w04_dzw = 716 if w04_sons == "Begeltung zum Kigas der Schwester"
replace w04_dzw = 11 if w04_sons == "Begleitung"
replace w04_dzw = 11 if w04_sons == "Begleitung der Frau"
replace w04_dzw = 11 if w04_sons == "Begleitung der Person X"
replace w04_dzw = 11 if w04_sons == "begleitung des ehemannes"
replace w04_dzw = 11 if w04_sons == "begleitung des vaters"
replace w04_dzw = 11 if w04_sons == "Begleitung Erwachsener"
replace w04_dzw = 11 if w04_sons == "Begleitung Ihres Ehemannes"
replace w04_dzw = 11 if w04_sons == "Begleitung Mutter ins Krankenhaus"
replace w04_dzw = 11 if w04_sons == "Begleitung seiner Mutter"
replace w04_dzw = 716 if w04_sons == "Begleitung Tochter"
replace w04_dzw = 602 if w04_sons == "Behördengang"
replace w04_dzw = 701 if w04_sons == "Bei den Kindern ihrer Tochter"
replace w04_dzw = 604 if w04_sons == "Benzin holen"
replace w04_dzw = 604 if w04_sons == "Benzin weggebracht"
replace w04_dzw = 605 if w04_sons == "Bereuung bei der Oma"
replace w04_dzw = 708 if w04_sons == "Bergerhausen"
replace w04_dzw = 705 if w04_sons == "Berufsorientierungskurs"
replace w04_dzw = 708 if w04_sons == "Besichtigung im Rahmen der Ausbildung"
replace w04_dzw = 604 if w04_sons == "Besorgungen"
replace w04_dzw = 714 if w04_sons == "Besprechung beim Kirchenvorstand"
replace w04_dzw = 714 if w04_sons == "Besprechung in einer Kirchengemeinde"
replace w04_dzw = 701 if w04_sons == "Besuch"
replace w04_dzw = 701 if w04_sons == "Besuch bei der Oma"
replace w04_dzw = 701 if w04_sons == "Besuch bei Eltern"
replace w04_dzw = 701 if w04_sons == "Besuch bei Freunden"
replace w04_dzw = 701 if w04_sons == "Besuch bei Oma"
replace w04_dzw = 701 if w04_sons == "Besuch beim Bruder"
replace w04_dzw = 701 if w04_sons == "besuch der Cousine"
replace w04_dzw = 701 if w04_sons == "Besuch der Freundin"
replace w04_dzw = 701 if w04_sons == "Besuch der Großeltern"
replace w04_dzw = 708 if w04_sons == "Besuch des Bauernhofes"
replace w04_dzw = 701 if w04_sons == "Besuch des eigenen Weinbergs"
replace w04_dzw = 713 if w04_sons == "Besuch des Gottesdienstes"
replace w04_dzw = 701 if w04_sons == "Besuch des Nachbarn"
replace w04_dzw = 701 if w04_sons == "Besuch des Schwiegervaters im Krankenhaus"
replace w04_dzw = 701 if w04_sons == "Besuch des Vater"
replace w04_dzw = 708 if w04_sons == "Besuch des Weinbergs"
replace w04_dzw = 503 if w04_sons == "besuch eines autohauses"
replace w04_dzw = 503 if w04_sons == "Besuch Elektroausstellung"
replace w04_dzw = 503 if w04_sons == "Besuch im Autohaus"
replace w04_dzw = 701 if w04_sons == "Besuch im Krankenhaus"
replace w04_dzw = 701 if w04_sons == "Besuch machen"
replace w04_dzw = 714 if w04_sons == "Besuch und Singen im Altenheim"
replace w04_dzw = 503 if w04_sons == "Besuch von Elektroausstellung"
replace w04_dzw = 701 if w04_sons == "besuch von nachbaren"
replace w04_dzw = 709 if w04_sons == "Besuchsort"
replace w04_dzw = 605 if w04_sons == "Betreuung der Mutter"
replace w04_dzw = 605 if w04_sons == "Betreuung einer Nachbarin"
replace w04_dzw = 604 if w04_sons == "Bilder aufhägen"
replace w04_dzw = 603 if w04_sons == "Blumengießen"
replace w04_dzw = 601 if w04_sons == "Blutabnahme beim Arzt"
replace w04_dzw = 602 if w04_sons == "Briefkasten"
replace w04_dzw = 603 if w04_sons == "briefkasten des Sohnes geleehrt"
replace w04_dzw = 603 if w04_sons == "Briefkasten geleehrt (Sohn)"
replace w04_dzw = 603 if w04_sons == "Brot zu de Caritas bringen"
replace w04_dzw = 602 if w04_sons == "Bücherei"
replace w04_dzw = 503 if w04_sons == "Bummel"
replace w04_dzw = 503 if w04_sons == "Bummel und Veranstaltung der Diakonie"
replace w04_dzw = 706 if w04_sons == "Café nach Beerdigung"
replace w04_dzw = 706 if w04_sons == "Cantine"
replace w04_dzw = 717 if w04_sons == "Chor Auftritt"
replace w04_dzw = 716 if w04_sons == "Cousine von der Schule anholen"
replace w04_dzw = 604 if w04_sons == "das auto an der tankstelle waschen"
replace w04_dzw = 604 if w04_sons == "das Auto von der Garage geholt"
replace w04_dzw = 706 if w04_sons == "Der Weg zur Mittagspause"
replace w04_dzw = 601 if w04_sons == "Dialyse"
replace w04_dzw = 603 if w04_sons == "Dinge Trasportiert"
replace w04_dzw = 703 if w04_sons == "Disco"
replace w04_dzw = 709 if w04_sons == "Eerreichen des urlaubszieles"
replace w04_dzw = 11 if w04_sons == "Ehefrau vom Krankenhaus abgeholt"
replace w04_dzw = 11 if w04_sons == "Ehefrau zum friseur gefahren"
replace w04_dzw = 11 if w04_sons == "Eheman begleitet zu einer Angebotsabgabe"
replace w04_dzw = 714 if w04_sons == "Ehrenamt"
replace w04_dzw = 714 if w04_sons == "Ehrenamt in der Gemeinde"
replace w04_dzw = 714 if w04_sons == "ehrenamtlich"
replace w04_dzw = 714 if w04_sons == "ehrenamtlich tätig"
replace w04_dzw = 714 if w04_sons == "ehrenamtliche Tätigkeit"
replace w04_dzw = 706 if w04_sons == "ein Frühstück ausserhalb"
replace w04_dzw = 603 if w04_sons == "Ein Transport"
replace w04_dzw = 716 if w04_sons == "einkaufen des täglichen bedarfs und kind von der schule abholen"
replace w04_dzw = 714 if w04_sons == "Einsatz bei der freiwilligen Feuerwehr"
replace w04_dzw = 706 if w04_sons == "Eis essen"
replace w04_dzw = 703 if w04_sons == "Elternabend"
replace w04_dzw = 703 if w04_sons == "Elternabend / Feuerwehr"
replace w04_dzw = 703 if w04_sons == "Elternabend / Jugendfeuerwehr"
replace w04_dzw = 703 if w04_sons == "elternabend in die schule"
replace w04_dzw = 703 if w04_sons == "Elternabend Kinderladehn"
replace w04_dzw = 714 if w04_sons == "Elterndienst im Kindergarten"
replace w04_dzw = 703 if w04_sons == "Elternsprechtag"
replace w04_dzw = 605 if w04_sons == "Enkel versorgt"
replace w04_dzw = 604 if w04_sons == "Entsorgung von Glas"
replace w04_dzw = 604 if w04_sons == "Erde mit Traktor transportiert"
replace w04_dzw = 604 if w04_sons == "erledigung"
replace w04_dzw = 604 if w04_sons == "Erledigungen"
replace w04_dzw = 604 if w04_sons == "Erledigungen für den Führerschein gemacht"
replace w04_dzw = 604 if w04_sons == "Erreichen der Baustelle für Eigenheim"
replace w04_dzw = 701 if w04_sons == "Erreichen der Wohnung des Vaters"
replace w04_dzw = 701 if w04_sons == "Erreichen des Besuchsziel"
replace w04_dzw = 701 if w04_sons == "Erreichen des Besuchsziels"
replace w04_dzw = 604 if w04_sons == "erreichen des Parkplatzes des Arbeitgebers"
replace w04_dzw = 604 if w04_sons == "Ersatzteile holen"
replace w04_dzw = 706 if w04_sons == "Essen"
replace w04_dzw = 706 if w04_sons == "essen gehen"
replace w04_dzw = 604 if w04_sons == "etwas vergessen"
replace w04_dzw = 708 if w04_sons == "Excursion"
replace w04_dzw = 504 if w04_sons == "Fahrrad reparieren"
replace w04_dzw = 705 if w04_sons == "Fahrschule"
replace w04_dzw = 710 if w04_sons == "Fahrschüler"
replace w04_dzw = 705 if w04_sons == "Fahrschulunterricht"
replace w04_dzw = 710 if w04_sons == "Fahrstunde"
replace w04_dzw = 701 if w04_sons == "Fahrt ins krankenhaus"
replace w04_dzw = 708 if w04_sons == "Fahrt mit der Motoryacht aug der Elde-Wasserstrasse und Störkanal nach Schwerin"
replace w04_dzw = 712 if w04_sons == "fahrt zu einem 10Km-K-Lauf"
replace w04_dzw = 701 if w04_sons == "Fahrt zu ihre Freund"
replace w04_dzw = 701 if w04_sons == "Fahrt zum Heimatort"
replace w04_dzw = 712 if w04_sons == "Fahrt zum Noric Walking"
replace w04_dzw = 718 if w04_sons == "Fahrt zum Sportheim"
replace w04_dzw = 701 if w04_sons == "Fahrt zur Geburtstagsfeier"
replace w04_dzw = 701 if w04_sons == "Fahrt zur Hochzeit"
replace w04_dzw = 713 if w04_sons == "Fahrt zur Kirche"
replace w04_dzw = 709 if w04_sons == "Fahrt zur Kur"
replace w04_dzw = 706 if w04_sons == "Fahrt zur Mittagspause"
replace w04_dzw = 717 if w04_sons == "Fahrt zur Musikschule"
replace w04_dzw = 701 if w04_sons == "Fahrt zur Mutter"
replace w04_dzw = 701 if w04_sons == "Fahrt zur Oma"
replace w04_dzw = 604 if w04_sons == "Fahrzeug Überführung"
replace w04_dzw = 701 if w04_sons == "Familie besuchen"
replace w04_dzw = 701 if w04_sons == "Familien besuch"
replace w04_dzw = 701 if w04_sons == "Familienfeier"
replace w04_dzw = 701 if w04_sons == "Familienfrühstück"
replace w04_dzw = 701 if w04_sons == "feier"
replace w04_dzw = 716 if w04_sons == "Ferien-Kinderbetreuung"
replace w04_dzw = 705 if w04_sons == "Feuerwehrgrundlehrgang"
replace w04_dzw = 714 if w04_sons == "Feurewehrhaus"
replace w04_dzw = 713 if w04_sons == "Fiedhof"
replace w04_dzw = 713 if w04_sons == "Fiedhof Dormagen"
replace w04_dzw = 602 if w04_sons == "Finanzamt"
replace w04_dzw = 604 if w04_sons == "flaschen entsorgen"
replace w04_dzw = 604 if w04_sons == "flaschenwegbrigen"
replace w04_dzw = 503 if w04_sons == "Flohmarkt"
replace w04_dzw = 714 if w04_sons == "Fördergruppe"
replace w04_dzw = 705 if w04_sons == "Fortbildung"
replace w04_dzw = 705 if w04_sons == "Fortbildungsbesuch"
replace w04_dzw = 705 if w04_sons == "Fortsetzung der Schulung"
replace w04_dzw = 11 if w04_sons == "Frau zur  Arbeit gefahren"
replace w04_dzw = 713 if w04_sons == "Freidhof"
replace w04_dzw = 701 if w04_sons == "Freunde besucht"
replace w04_dzw = 701 if w04_sons == "Freundin aufgesucht"
replace w04_dzw = 713 if w04_sons == "Friedhof"
replace w04_dzw = 713 if w04_sons == "Friedhofsbesuch"
replace w04_dzw = 504 if w04_sons == "Friseur"
replace w04_dzw = 604 if w04_sons == "Friseurtermin"
replace w04_dzw = 504 if w04_sons == "Frisör"
replace w04_dzw = 706 if w04_sons == "Frühstück"
replace w04_dzw = 604 if w04_sons == "Fussballschuhe säubern"
replace w04_dzw = 504 if w04_sons == "Fusspflege"
replace w04_dzw = 504 if w04_sons == "Fußpflege für Für Ehemann"
replace w04_dzw = 604 if w04_sons == "Gang zum Parkplatz"
replace w04_dzw = 504 if w04_sons == "Gang zur Kfz-werkstatt"
replace w04_dzw = 605 if w04_sons == "Ganztagsbetreuung"
replace w04_dzw = 604 if w04_sons == "Garage"
replace w04_dzw = 604 if w04_sons == "Garage Aufräumen"
replace w04_dzw = 707 if w04_sons == "Gartenabfall wegbringen"
replace w04_dzw = 707 if w04_sons == "Gartenarbeit beim Bruder"
replace w04_dzw = 707 if w04_sons == "Gartenbesuch"
replace w04_dzw = 701 if w04_sons == "Geburtstagsfeier"
replace w04_dzw = 702 if w04_sons == "Gemeinde Fest"
replace w04_dzw = 604 if w04_sons == "Gepäck abholen"
replace w04_dzw = 505 if w04_sons == "Geschäft war geschlossen"
replace w04_dzw = 602 if w04_sons == "Geschäftlich zur Bank"
replace w04_dzw = 701 if w04_sons == "Geschäftseröffnung von Freunden"
replace w04_dzw = 502 if w04_sons == "Geschenk einkaufen"
replace w04_dzw = 604 if w04_sons == "Gläser zum Glascontainer gebracht"
replace w04_dzw = 701 if w04_sons == "Großelter"
replace w04_dzw = 701 if w04_sons == "Großeltern besuchen"
replace w04_dzw = 714 if w04_sons == "Gruppenstunde bei Maltesern"
replace w04_dzw = 704 if w04_sons == "Gymmnastik"
replace w04_dzw = 704 if w04_sons == "Gymnastik"
replace w04_dzw = 504 if w04_sons == "Handy zur Reperatur"
replace w04_dzw = 604 if w04_sons == "Hasen Füttern"
replace w04_dzw = 720 if w04_sons == "Heißluftballon geflogen"
replace w04_dzw = 604 if w04_sons == "Hessenwahl"
replace w04_dzw = 603 if w04_sons == "Hilfe beim Umzug"
replace w04_dzw = 707 if w04_sons == "Hinfahrt zur Gartenanlage"
replace w04_dzw = 11 if w04_sons == "Hinfahrt zur Rehaklinik"
replace w04_dzw = 701 if w04_sons == "Hochzeitsfeier"
replace w04_dzw = 604 if w04_sons == "Hochzeitsvorbereitungen"
replace w04_dzw = 604 if w04_sons == "Holz holen"
replace w04_dzw = 604 if w04_sons == "Holz sägen"
replace w04_dzw = 604 if w04_sons == "HORT"
replace w04_dzw = 604 if w04_sons == "Hund abholen"
replace w04_dzw = 604 if w04_sons == "Hund bei den eltern abgegeben"
replace w04_dzw = 604 if w04_sons == "Hund bei einer Freundin abgeben"
replace w04_dzw = 711 if w04_sons == "Hund gassi führen"
replace w04_dzw = 711 if w04_sons == "Hunderunde"
replace w04_dzw = 711 if w04_sons == "Hundespaziergang"
replace w04_dzw = 504 if w04_sons == "ich mußte zu meinem Verputzer wegen einer Reklamation"
replace w04_dzw = 604 if w04_sons == "Im Rahmen des Umzugs"
replace w04_dzw = 707 if w04_sons == "in den Garten des Sohnes"
replace w04_dzw = 709 if w04_sons == "in den Osterurlaub gefahren"
replace w04_dzw = 709 if w04_sons == "in den urlaub gefahren"
replace w04_dzw = 706 if w04_sons == "in der Kantine essen"
replace w04_dzw = 713 if w04_sons == "in die Kirche"
replace w04_dzw = 713 if w04_sons == "in die Kirsche"
replace w04_dzw = 706 if w04_sons == "in die mensa"
replace w04_dzw = 505 if w04_sons == "InfoBesuch im IT shop"
replace w04_dzw = 505 if w04_sons == "information zu einem geburtstagsgeschenk"
replace w04_dzw = 604 if w04_sons == "Informationen einholen"
replace w04_dzw = 714 if w04_sons == "Internet-Unterricht für Senioren"
replace w04_dzw = 604 if w04_sons == "ist zur wohnungsbesichtigung gegangen"
replace w04_dzw = 714 if w04_sons == "Jugendhilfeausschuss"
replace w04_dzw = 603 if w04_sons == "Katzen von nachbarn füttern"
replace w04_dzw = 716 if w04_sons == "Kinder in die Schule fahren"
replace w04_dzw = 713 if w04_sons == "Kirche"
replace w04_dzw = 713 if w04_sons == "Kirchenbesuch"
replace w04_dzw = 713 if w04_sons == "Kirchgang"
replace w04_dzw = 713 if w04_sons == "kirchliche Trauung"
replace w04_dzw = 604 if w04_sons == "Kirschen flücken"
replace w04_dzw = 717 if w04_sons == "Klarinettenunterricht"
replace w04_dzw = 708 if w04_sons == "klassenfahrt"
replace w04_dzw = 604 if w04_sons == "Kleinmöbel weiter gegeben"
replace w04_dzw = 701 if w04_sons == "Klinik"
replace w04_dzw = 705 if w04_sons == "Konfirmantenunterricht"
replace w04_dzw = 713 if w04_sons == "Kontrollgang am Friedhof"
replace w04_dzw = 504 if w04_sons == "Kosmetikerin"
replace w04_dzw = 704 if w04_sons == "Kranken Gymnastik"
replace w04_dzw = 701 if w04_sons == "Krankenbesuch"
replace w04_dzw = 701 if w04_sons == "Krankenbesuche"
replace w04_dzw = 704 if w04_sons == "Krankengym"
replace w04_dzw = 704 if w04_sons == "Krankengymnasti"
replace w04_dzw = 704 if w04_sons == "Krankengymnastiik"
replace w04_dzw = 704 if w04_sons == "Krankengymnastik"
replace w04_dzw = 704 if w04_sons == "Krankengymnastikl"
replace w04_dzw = 701 if w04_sons == "Krankenhaus"
replace w04_dzw = 602 if w04_sons == "Krankenkasse"
replace w04_dzw = 701 if w04_sons == "Krenkenbesuch"
replace w04_dzw = 604 if w04_sons == "Kühe gefüttert"
replace w04_dzw = 718 if w04_sons == "Landschulheim"
replace w04_dzw = 604 if w04_sons == "Leergut weggebracht"
replace w04_dzw = 705 if w04_sons == "Lehrgang"
replace w04_dzw = 720 if w04_sons == "Massage"
replace w04_dzw = 504 if w04_sons == "Mediathek"
replace w04_dzw = 706 if w04_sons == "Mensa aufgesucht"
replace w04_dzw = 604 if w04_sons == "Mietshaus renovierung"
replace w04_dzw = 604 if w04_sons == "Milch weggebracht"
replace w04_dzw = 711 if w04_sons == "mit dem Hund raus"
replace w04_dzw = 708 if w04_sons == "mit dem Kindergarten zum Bauernhof"
replace w04_dzw = 710 if w04_sons == "Mit dem Pferd draussen"
replace w04_dzw = 711 if w04_sons == "Mit den Hunden draussen"
replace w04_dzw = 711 if w04_sons == "mit Ehemann spazieren gegangen"
replace w04_dzw = 604 if w04_sons == "Mit Freunden aufräumen"
replace w04_dzw = 706 if w04_sons == "Mittag essen"
replace w04_dzw = 706 if w04_sons == "Mittagessen"
replace w04_dzw = 605 if w04_sons == "Mittagsbetreuung"
replace w04_dzw = 706 if w04_sons == "Mittagspause"
replace w04_dzw = 604 if w04_sons == "Müll Entsogung"
replace w04_dzw = 604 if w04_sons == "Müll in Container"
replace w04_dzw = 604 if w04_sons == "Müll wegbringen"
replace w04_dzw = 604 if w04_sons == "Müll zur Wiederverwertungsstelle gebracht"
replace w04_dzw = 604 if w04_sons == "Mülltonne"
replace w04_dzw = 603 if w04_sons == "musste Baum bei Oma abliefern"
replace w04_dzw = 701 if w04_sons == "Mutter im Geschäft besucht"
replace w04_dzw = 710 if w04_sons == "Nach dem Grundstück sehen"
replace w04_dzw = 701 if w04_sons == "nach Hause zu den Cousinen"
replace w04_dzw = 701 if w04_sons == "nach Hause zur Mutter"
replace w04_dzw = 708 if w04_sons == "Nach Magdeburg"
replace w04_dzw = 708 if w04_sons == "nach speyer"
replace w04_dzw = 603 if w04_sons == "Nachbarschaftshilfe"
replace w04_dzw = 504 if w04_sons == "Nachfrage bei EON"
replace w04_dzw = 705 if w04_sons == "Nachhilfe"
replace w04_dzw = 715 if w04_sons == "Nachhilfe geben"
replace w04_dzw = 715 if w04_sons == "Nebenjob"
replace w04_dzw = 715 if w04_sons == "Nebentätigkeit"
replace w04_dzw = 710 if w04_sons == "neue Strasse anschauen"
replace w04_dzw = 601 if w04_sons == "Notfall, Krankenhaus"
replace w04_dzw = 707 if w04_sons == "Oma im Garten geholfen"
replace w04_dzw = 705 if w04_sons == "Ortswechsel bei Weiterbildung"
replace w04_dzw = 604 if w04_sons == "Papier entsorgen"
replace w04_dzw = 604 if w04_sons == "Pappe Entsorgt"
replace w04_dzw = 604 if w04_sons == "Parken des Autos vom Handwerker"
replace w04_dzw = 604 if w04_sons == "Parkhaus"
replace w04_dzw = 504 if w04_sons == "Pediküre"
replace w04_dzw = 604 if w04_sons == "Pferd aufs Feld gestellt"
replace w04_dzw = 604 if w04_sons == "Pferd wieder rein gestellt"
replace w04_dzw = 605 if w04_sons == "Pflege"
replace w04_dzw = 605 if w04_sons == "Pflege der Tante"
replace w04_dzw = 605 if w04_sons == "Pflege einer älteren Dame"
replace w04_dzw = 720 if w04_sons == "Physieotherapie"
replace w04_dzw = 720 if w04_sons == "Physiotherapie"
replace w04_dzw = 604 if w04_sons == "Pkw der Ehefrau zum Parkplatz gefahren"
replace w04_dzw = 714 if w04_sons == "Plakate aufgehängt"
replace w04_dzw = 604 if w04_sons == "Post aus leerstehender Wohnung holen"
replace w04_dzw = 717 if w04_sons == "Probe in der Musikschule"
replace w04_dzw = 710 if w04_sons == "Probefahrt"
replace w04_dzw = 604 if w04_sons == "Reifen wechsel"
replace w04_dzw = 710 if w04_sons == "Reiten"
replace w04_dzw = 601 if w04_sons == "Röntgen"
replace w04_dzw = 701 if w04_sons == "Rückfahrt vom Arbeitsplatz und Treffen mit der Mutter"
replace w04_dzw = 701 if w04_sons == "Rückkehr zu den Kindern"
replace w04_dzw = 701 if w04_sons == "Rückkehr zum Schlafen bei ihrem Freund"
replace w04_dzw = 701 if w04_sons == "Rückweg zu Bekannten vom einkauf"
replace w04_dzw = 701 if w04_sons == "Rückweg zu den Bekannten"
replace w04_dzw = 701 if w04_sons == "Rückweg zum Freund"
replace w04_dzw = 701 if w04_sons == "Rückweg zum Haus der Tochter"
replace w04_dzw = 701 if w04_sons == "Rückweg zur Bekannten"
replace w04_dzw = 710 if w04_sons == "Rum gefahren"
replace w04_dzw = 703 if w04_sons == "Rundgang auf dem Flohmarkt"
replace w04_dzw = 710 if w04_sons == "Rundweg"
replace w04_dzw = 604 if w04_sons == "Rüstung leihen"
replace w04_dzw = 604 if w04_sons == "Saal suchen"
replace w04_dzw = 710 if w04_sons == "Satdtbesichtigung Neukloster"
replace w04_dzw = 603 if w04_sons == "Schulaugaben Hilfe"
replace w04_dzw = 708 if w04_sons == "Schulausflug"
replace w04_dzw = 708 if w04_sons == "Schulausflug (Sportveranstaltung)"
replace w04_dzw = 603 if w04_sons == "Schülerlotzin"
replace w04_dzw = 603 if w04_sons == "Schulprojekt mit Behinderten"
replace w04_dzw = 704 if w04_sons == "Schulschwimmen"
replace w04_dzw = 704 if w04_sons == "Schulschwimmen im Freibad"
replace w04_dzw = 704 if w04_sons == "Schulsport"
replace w04_dzw = 704 if w04_sons == "Schwimmen"
replace w04_dzw = 704 if w04_sons == "Schwimmunterricht"
replace w04_dzw = 713 if w04_sons == "Sonntagsgottesdienst"
replace w04_dzw = 602 if w04_sons == "Sparkasse"
replace w04_dzw = 710 if w04_sons == "Sparziergang"
replace w04_dzw = 710 if w04_sons == "Spaziegang"
replace w04_dzw = 710 if w04_sons == "Spazierengehen auf ärztliche Verordnung hin"
replace w04_dzw = 710 if w04_sons == "Spazierfahrt"
replace w04_dzw = 710 if w04_sons == "Spaziergang"
replace w04_dzw = 710 if w04_sons == "Spaziergang - Mittagspause"
replace w04_dzw = 711 if w04_sons == "Spaziergang mit dem hund"
replace w04_dzw = 711 if w04_sons == "Spaziergang mit den Hunden"
replace w04_dzw = 719 if w04_sons == "Spielen"
replace w04_dzw = 704 if w04_sons == "Sport"
replace w04_dzw = 704 if w04_sons == "Sportplatz/ Sponsorenlauf"
replace w04_dzw = 704 if w04_sons == "Sportunterricht"
replace w04_dzw = 704 if w04_sons == "Sportunterricht schwchwimmen"
replace w04_dzw = 710 if w04_sons == "Stadbesichtigung Neukloster"
replace w04_dzw = 708 if w04_sons == "Stadt"
replace w04_dzw = 710 if w04_sons == "Stadt besichtigung"
replace w04_dzw = 503 if w04_sons == "Stadtbummel"
replace w04_dzw = 505 if w04_sons == "stand am bahnhof"
replace w04_dzw = 602 if w04_sons == "Standesamt"
replace w04_dzw = 503 if w04_sons == "Startpunkt des Einkaufs"
replace w04_dzw = 703 if w04_sons == "Startpunkt des Weihnachtsmarktbesuchs"
replace w04_dzw = 504 if w04_sons == "Staubsaugerrepertatur"
replace w04_dzw = 604 if w04_sons == "Tannenbaum entsorgen"
replace w04_dzw = 604 if w04_sons == "Tannenbäume verkaufen"
replace w04_dzw = 701 if w04_sons == "Tante"
replace w04_dzw = 604 if w04_sons == "toxchter beim hausbau helfen"
replace w04_dzw = 704 if w04_sons == "Training"
replace w04_dzw = 701 if w04_sons == "Trauerfeier"
replace w04_dzw = 701 if w04_sons == "Treffen"
replace w04_dzw = 701 if w04_sons == "Treffpunkt"
replace w04_dzw = 701 if w04_sons == "Treffpunkt Geschäft"
replace w04_dzw = 701 if w04_sons == "Treffpunkt mit Frau"
replace w04_dzw = 717 if w04_sons == "Trompetenunterricht"
replace w04_dzw = 709 if w04_sons == "Türkei"
replace w04_dzw = 704 if w04_sons == "Turnen"
replace w04_dzw = 504 if w04_sons == "TüV"
replace w04_dzw = 705 if w04_sons == "Umschulung"
replace w04_dzw = 502 if w04_sons == "Umtausch von einem Artikel"
replace w04_dzw = 502 if w04_sons == "Umtausch von Ware"
replace w04_dzw = 604 if w04_sons == "Umzug"
replace w04_dzw = 604 if w04_sons == "Umzugshilfe"
replace w04_dzw = 709 if w04_sons == "Urlaub in Italien"
replace w04_dzw = 703 if w04_sons == "Veranstaltung in der Schule"
replace w04_dzw = 714 if w04_sons == "Versammlung"
replace w04_dzw = 701 if w04_sons == "Verwandte besucht"
replace w04_dzw = 707 if w04_sons == "Vom Einkaufen zum Garten"
replace w04_dzw = 701 if w04_sons == "von der Arbeit zur Oma gefahren"
replace w04_dzw = 701 if w04_sons == "von zuhause zum Studenwohnheim"
replace w04_dzw = 604 if w04_sons == "Wagen aus Garage geholt"
replace w04_dzw = 604 if w04_sons == "wagen hollen"
replace w04_dzw = 604 if w04_sons == "Wagen zur Garage gefahren"
replace w04_dzw = 604 if w04_sons == "Wahl, Büregrentscheid"
replace w04_dzw = 604 if w04_sons == "Wählen"
replace w04_dzw = 712 if w04_sons == "Wanderen"
replace w04_dzw = 712 if w04_sons == "Wanderung"
replace w04_dzw = 504 if w04_sons == "Wäscherei"
replace w04_dzw = 704 if w04_sons == "Wassergymnastik"
replace w04_dzw = 504 if w04_sons == "Weg in die Werkstatt"
replace w04_dzw = 701 if w04_sons == "Weg ins Krankenhaus"
replace w04_dzw = 701 if w04_sons == "Weg nach Halle (Heimatort)"
replace w04_dzw = 708 if w04_sons == "Weg nach Neukloster"
replace w04_dzw = 712 if w04_sons == "Weg vom Ziel des Berglaufes zur Hütte nahe Gipfelkreuz"
replace w04_dzw = 701 if w04_sons == "Weg zu dem Geschäft der Eltern"
replace w04_dzw = 701 if w04_sons == "Weg zu den Eltern"
replace w04_dzw = 701 if w04_sons == "Weg zu den Großeltern"
replace w04_dzw = 701 if w04_sons == "Weg zu den Schwiegereltern"
replace w04_dzw = 701 if w04_sons == "Weg zu einem Treffpunkt"
replace w04_dzw = 703 if w04_sons == "Weg zu einem Vortrag"
replace w04_dzw = 701 if w04_sons == "Weg zu einer Geburtstagsfeier"
replace w04_dzw = 703 if w04_sons == "Weg zu einer Veranstaltung"
replace w04_dzw = 701 if w04_sons == "Weg zu Treffpunkt für Fahrgemeinschaft zur Schule"
replace w04_dzw = 712 if w04_sons == "Weg zum Ausgangspunkt der Wanderung"
replace w04_dzw = 604 if w04_sons == "weg zum Auto"
replace w04_dzw = 501 if w04_sons == "Weg zum Bäcker"
replace w04_dzw = 502 if w04_sons == "Weg zum Blumenfachhandel"
replace w04_dzw = 707 if w04_sons == "Weg zum eigenen Garten"
replace w04_dzw = 504 if w04_sons == "Weg zum Fahrradhändler"
replace w04_dzw = 501 if w04_sons == "Weg zum Feinkostladen"
replace w04_dzw = 710 if w04_sons == "Weg zum Feld"
replace w04_dzw = 709 if w04_sons == "Weg zum Ferienort(zur Ostsee)"
replace w04_dzw = 703 if w04_sons == "Weg zum Flohmarkt"
replace w04_dzw = 720 if w04_sons == "Weg zum Flugplatz"
replace w04_dzw = 713 if w04_sons == "Weg zum Friedhof"
replace w04_dzw = 504 if w04_sons == "Weg zum Friseur"
replace w04_dzw = 707 if w04_sons == "Weg zum Garten"
replace w04_dzw = 701 if w04_sons == "Weg zum Geburtstag"
replace w04_dzw = 701 if w04_sons == "Weg zum Geburtstagskind"
replace w04_dzw = 713 if w04_sons == "Weg zum Gottesdienst"
replace w04_dzw = 703 if w04_sons == "Weg zum Jahrmarkt"
replace w04_dzw = 718 if w04_sons == "Weg zum Jugendzentrum"
replace w04_dzw = 714 if w04_sons == "Weg zum Motorradclub"
replace w04_dzw = 604 if w04_sons == "Weg zum Müllkontainer"
replace w04_dzw = 504 if w04_sons == "Weg zum Optiker"
replace w04_dzw = 602 if w04_sons == "Weg zum Postkasten"
replace w04_dzw = 602 if w04_sons == "Weg zum Rathaus"
replace w04_dzw = 705 if w04_sons == "Weg zum Schulungsraum"
replace w04_dzw = 504 if w04_sons == "Weg zum Solarium"
replace w04_dzw = 704 if w04_sons == "Weg zum Sportunterricht"
replace w04_dzw = 503 if w04_sons == "Weg zum Stadtbummel"
replace w04_dzw = 703 if w04_sons == "weg zum Theater"
replace w04_dzw = 601 if w04_sons == "Weg zum Tierarzt"
replace w04_dzw = 709 if w04_sons == "Weg zum Urlaub"
replace w04_dzw = 703 if w04_sons == "Weg zur Aufführung"
replace w04_dzw = 504 if w04_sons == "Weg zur Autowerkstatt"
replace w04_dzw = 501 if w04_sons == "Weg zur Bäckerei"
replace w04_dzw = 604 if w04_sons == "Weg zur Baustelle"
replace w04_dzw = 713 if w04_sons == "Weg zur Beerdigung"
replace w04_dzw = 705 if w04_sons == "Weg zur Fahrschule"
replace w04_dzw = 701 if w04_sons == "Weg zur Familienfeier"
replace w04_dzw = 701 if w04_sons == "Weg zur Feier"
replace w04_dzw = 714 if w04_sons == "Weg zur Feuerwehr"
replace w04_dzw = 604 if w04_sons == "Weg zur Garage"
replace w04_dzw = 707 if w04_sons == "Weg zur Gartenanlage"
replace w04_dzw = 706 if w04_sons == "Weg zur Kantine"
replace w04_dzw = 713 if w04_sons == "Weg zur Kirche"
replace w04_dzw = 713 if w04_sons == "Weg zur kirchlichen Trauung"
replace w04_dzw = 717 if w04_sons == "Weg zur Klavierschule"
replace w04_dzw = 604 if w04_sons == "Weg zur Komunalwahl"
replace w04_dzw = 704 if w04_sons == "Weg zur Krankengymnastik"
replace w04_dzw = 703 if w04_sons == "Weg zur Lesung"
replace w04_dzw = 701 if w04_sons == "Weg zur Mutter(Schülerlotzin)"
replace w04_dzw = 701 if w04_sons == "Weg zur Nachbarin"
replace w04_dzw = 715 if w04_sons == "Weg zur Nachhilfeschülerin"
replace w04_dzw = 701 if w04_sons == "Weg zur Oma"
replace w04_dzw = 602 if w04_sons == "Weg zur Post"
replace w04_dzw = 601 if w04_sons == "Weg zur Praxis"
replace w04_dzw = 710 if w04_sons == "Weg zur Probefahrt"
replace w04_dzw = 704 if w04_sons == "Weg zur Reha"
replace w04_dzw = 710 if w04_sons == "Weg zur Rheinpromenade"
replace w04_dzw = 504 if w04_sons == "Weg zur Sonnenbank"
replace w04_dzw = 703 if w04_sons == "Weg zur Sportveranstaltung"
replace w04_dzw = 701 if w04_sons == "Weg zur Studien-WG"
replace w04_dzw = 502 if w04_sons == "Weg zur Tankstelle"
replace w04_dzw = 702 if w04_sons == "Weg zur Theateraufführung"
replace w04_dzw = 720 if w04_sons == "Weg zur Trauung"
replace w04_dzw = 714 if w04_sons == "Weg zur Veranstaltung im Ehrenamt"
replace w04_dzw = 602 if w04_sons == "Weg zur Versicherung"
replace w04_dzw = 705 if w04_sons == "Weg zur Weiterbildung"
replace w04_dzw = 705 if w04_sons == "Weg zur Weiterbildungsstätte"
replace w04_dzw = 717 if w04_sons == "Weg zur werkstatt der Hochschule"
replace w04_dzw = 701 if w04_sons == "Weg zur Wohnung des Vaters"
replace w04_dzw = 703 if w04_sons == "Weihnachtsmarkt"
replace w04_dzw = 502 if w04_sons == "Wein und Blumen"
replace w04_dzw = 705 if w04_sons == "Weiterbildung"
replace w04_dzw = 504 if w04_sons == "Werkstatt"
replace w04_dzw = 604 if w04_sons == "Werkzeug ausgeliehen"
replace w04_dzw = 604 if w04_sons == "Werkzeug holen"
replace w04_dzw = 604 if w04_sons == "Wertstoffhof"
replace w04_dzw = 604 if w04_sons == "Wohnungsbesichtigung"
replace w04_dzw = 604 if w04_sons == "Wohungsbetreuung"
replace w04_dzw = 716 if w04_sons == "wollte Sohn von der Schule abholen, dieser war aber nicht mehr dort"
replace w04_dzw = 601 if w04_sons == "Zahnarzt"
replace w04_dzw = 601 if w04_sons == "Zahnarztbesuch"
replace w04_dzw = 505 if w04_sons == "Ziel Einkauf, aber etwas vergessen und deshalb zurück"
replace w04_dzw = 711 if w04_sons == "Ziel zum Hundeausführen"
replace w04_dzw = 706 if w04_sons == "zm Resraurant"
replace w04_dzw = 701 if w04_sons == "zu den Grosseltern"
replace w04_dzw = 701 if w04_sons == "zu den Großeltern, um dann mit Mutter nach Hause zu fahren"
replace w04_dzw = 713 if w04_sons == "zu einem anderen Friedhof"
replace w04_dzw = 705 if w04_sons == "zu einem Vortrag in die Uniklinik gefahren"
replace w04_dzw = 713 if w04_sons == "zu Friedhof"
replace w04_dzw = 604 if w04_sons == "Zu Fuß zur Garage"
replace w04_dzw = 701 if w04_sons == "zu meinem Freund (mein zweites zu Hause)"
replace w04_dzw = 713 if w04_sons == "zum  Fiedhof"
replace w04_dzw = 604 if w04_sons == "Zum Altkleiderkontainer gefahren"
replace w04_dzw = 717 if w04_sons == "Zum Angeln"
replace w04_dzw = 712 if w04_sons == "zum ausgangspunkt der wanderung"
replace w04_dzw = 604 if w04_sons == "Zum Auto um Öl einzufüllen"
replace w04_dzw = 604 if w04_sons == "Zum Auto Waschen"
replace w04_dzw = 502 if w04_sons == "Zum Autohaus"
replace w04_dzw = 703 if w04_sons == "Zum Ball"
replace w04_dzw = 604 if w04_sons == "Zum Briefkasten"
replace w04_dzw = 706 if w04_sons == "Zum essen"
replace w04_dzw = 706 if w04_sons == "Zum Essen Rast eingelegt"
replace w04_dzw = 703 if w04_sons == "Zum Flohmarkt"
replace w04_dzw = 701 if w04_sons == "zum Freund"
replace w04_dzw = 701 if w04_sons == "zum Freund gefahren"
replace w04_dzw = 701 if w04_sons == "zum Freund vom Sohn gefahren"
replace w04_dzw = 713 if w04_sons == "zum Fridhof"
replace w04_dzw = 713 if w04_sons == "zum Friedhof"
replace w04_dzw = 713 if w04_sons == "zum Friehof"
replace w04_dzw = 706 if w04_sons == "zum Frühstück"
replace w04_dzw = 707 if w04_sons == "Zum garten"
replace w04_dzw = 701 if w04_sons == "Zum Krankenhaus"
replace w04_dzw = 501 if w04_sons == "Zum Markt"
replace w04_dzw = 604 if w04_sons == "Zum Müllplatz"
replace w04_dzw = 604 if w04_sons == "Zum Parkhaus"
replace w04_dzw = 604 if w04_sons == "zum Parkplatz"
replace w04_dzw = 706 if w04_sons == "zum Resraurant"
replace w04_dzw = 706 if w04_sons == "zum Restaurant"
replace w04_dzw = 707 if w04_sons == "zum Schrebergarten"
replace w04_dzw = 705 if w04_sons == "zum Schulungsraum"
replace w04_dzw = 703 if w04_sons == "Zum Schutzenfest"
replace w04_dzw = 705 if w04_sons == "Zum Seminar nach Bochum"
replace w04_dzw = 705 if w04_sons == "Zum Seminarort"
replace w04_dzw = 717 if w04_sons == "Zum Skat"
replace w04_dzw = 504 if w04_sons == "Zum Sohn in die werkstatt"
replace w04_dzw = 704 if w04_sons == "zum Sport"
replace w04_dzw = 704 if w04_sons == "zum Sportplatz"
replace w04_dzw = 710 if w04_sons == "zum Startpunkt der Stadtbesichtigung"
replace w04_dzw = 708 if w04_sons == "zum Startpunkt der Wanderung"
replace w04_dzw = 503 if w04_sons == "zum Startpunkt des bummels"
replace w04_dzw = 503 if w04_sons == "zum Startpunkt des Einkaufs"
replace w04_dzw = 503 if w04_sons == "zum Startpunkt des Einkaufsbummels"
replace w04_dzw = 711 if w04_sons == "zum Startpunkt Gassigehen erreicht"
replace w04_dzw = 708 if w04_sons == "zum Startpunpt der fahrradtour"
replace w04_dzw = 701 if w04_sons == "zum treffpunkt"
replace w04_dzw = 503 if w04_sons == "zum Trödelmarkt"
replace w04_dzw = 504 if w04_sons == "Zum TüV"
replace w04_dzw = 504 if w04_sons == "zum Verputzer"
replace w04_dzw = 703 if w04_sons == "zum Weihnachtsmarkt"
replace w04_dzw = 703 if w04_sons == "Zum wochenmarkt"
replace w04_dzw = 601 if w04_sons == "ZUM ZAHNARZT"
replace w04_dzw = 504 if w04_sons == "Zur Apotheke"
replace w04_dzw = 701 if w04_sons == "zur Arbeitsstelle der Mutter gegangen"
replace w04_dzw = 504 if w04_sons == "Zur Auto Werkstatt"
replace w04_dzw = 504 if w04_sons == "Zur Autowerkstatt"
replace w04_dzw = 602 if w04_sons == "zur Bank gefahren"
replace w04_dzw = 604 if w04_sons == "Zur Baustelle"
replace w04_dzw = 706 if w04_sons == "zur Cafeteria"
replace w04_dzw = 706 if w04_sons == "zur Cafeteria Mittagessen"
replace w04_dzw = 714 if w04_sons == "zur Ehrenamtlichen Tätigkeit"
replace w04_dzw = 708 if w04_sons == "Zur einer Wanderung"
replace w04_dzw = 705 if w04_sons == "Zur Fahrschule"
replace w04_dzw = 701 if w04_sons == "Zur Feier"
replace w04_dzw = 701 if w04_sons == "zur Freundin gegangen"
replace w04_dzw = 503 if w04_sons == "Zur Fusspflege"
replace w04_dzw = 604 if w04_sons == "zur Garage"
replace w04_dzw = 706 if w04_sons == "Zur Kantine früstücken"
replace w04_dzw = 703 if w04_sons == "zur Messe gefahren"
replace w04_dzw = 604 if w04_sons == "Zur Müllwiederverwertung"
replace w04_dzw = 701 if w04_sons == "zur Mutter gegangen"
replace w04_dzw = 701 if w04_sons == "zur Mutter ins Büro"
replace w04_dzw = 701 if w04_sons == "zur oma"
replace w04_dzw = 605 if w04_sons == "zur Oma zur Betreuung"
replace w04_dzw = 701 if w04_sons == "zur Schwiegermutter gegangen und Brötchen hingebracht"
replace w04_dzw = 704 if w04_sons == "zur Sporthalle gegangen"
replace w04_dzw = 604 if w04_sons == "zur Tankstelle gefahren"
replace w04_dzw = 601 if w04_sons == "Zur Therapie"
replace w04_dzw = 504 if w04_sons == "Zur Videothek"
replace w04_dzw = 604 if w04_sons == "zur Waffenkammer"
replace w04_dzw = 708 if w04_sons == "Zur Wanderung"
replace w04_dzw = 705 if w04_sons == "zur Weiterbildung"
replace w04_dzw = 504 if w04_sons == "Zur Werkstatt"
replace w04_dzw = 701 if w04_sons == "zur Wohnung der Gastgeberin"
replace w04_dzw = 701 if w04_sons == "zurück zu dem Besuch"
replace w04_dzw = 701 if w04_sons == "zurück zu den Eltern"
replace w04_dzw = 701 if w04_sons == "zurück zu den Freunden"
replace w04_dzw = 701 if w04_sons == "zurück zu den Großeltern"
replace w04_dzw = 701 if w04_sons == "zurück zu den Kindern"
replace w04_dzw = 701 if w04_sons == "zurück zu der Mutter"
replace w04_dzw = 701 if w04_sons == "zurück zu meinen Gastgebern"
replace w04_dzw = 701 if w04_sons == "zurück zu seiner Freundin"
replace w04_dzw = 701 if w04_sons == "zurück zu Verwandten"
replace w04_dzw = 502 if w04_sons == "Zurück zum Aotuhaus"
replace w04_dzw = 701 if w04_sons == "zurück zum Haus der Freundin"
replace w04_dzw = 705 if w04_sons == "zurück zum Schulungsraum"
replace w04_dzw = 701 if w04_sons == "Zurück zum Vater"
replace w04_dzw = 701 if w04_sons == "zurück zur Bekannten"
replace w04_dzw = 701 if w04_sons == "zurück zur Freundin"
replace w04_dzw = 604 if w04_sons == "zurück zur Garage"
replace w04_dzw = 701 if w04_sons == "zurück zur Schwiegermutter"
replace w04_dzw = 701 if w04_sons == "zurück zur Tochter mit Enkel"
replace w04_dzw = 718 if w04_sons == "zurück zur Unterkunft (Konfirmandenfreizeit)"
replace w04_dzw = 701 if w04_sons == "zurück zur Wohnung der Freundin"
replace w04_dzw = 701 if w04_sons == "zurück zur Wohnung der Gastgeberin"

drop if w04_sons == "verwerfen - Programmfehler" | w04_sons == "VERWERFEN PROGRAMMFEHLER" | w04_sons == "Weg ist zu verwerfen: EDV-Problem" 
replace w04=. if w04_sons == "kein Weg gemacht"

sort hhid pid wsid

*	1) Doppelte Wege eliminieren 
*	2) Einzelfallprüfungen, Wegezeitenanpassung 
*	3) Neuberechnung Aktivitätendauer für mögliche zweischichtige Filterung
*	4) am Ende der Prüfung x Wege mit neg. Aktivitätendauer, x Fällen bei Wegekettenbetrachtung

* Behandlung von Wegeketten mit Duplikaten
duplicates tag hhid pid st_time en_time w04, gen(doppelter_Weg)
duplicates drop hhid pid st_time en_time w04 w01 w13 hvm, force
label var doppelter_Weg "Weg kam im Datensatz doppelt vor."

* Einzelfallbearbeitung doppelter Weg


* Zeittransformation für Folgetage
replace st_time = 86400*st_dat + st_time
replace en_time = 86400*en_dat + en_time

* Ermittlung Aktivitätendauer
bysort hhid pid: gen akt_dauer = (st_time[_n] - en_time[_n-1])/60 if _n>1
label var akt_dauer "Aktivitätendauer"
* Ermittlung einer Wegekette mit mind. einer neg. Aktivitätendauer
gen neg_time = akt_dauer<0
label var neg_time "negative Aktivitätendauer"
bysort hhid pid: egen p_neg = sum(neg_time)
label var p_neg "Wegekette mit neg. Aktivätendauer"

* Einzelfallbearbeitung Weganfangs- und -endzeit
* br hhid pid wsid st_std st_min  en_std en_min w04 w01 w13   if p_neg==1
drop if hhid==203198 & pid==2 & wsid==2
drop if hhid==203198 & pid==4 & wsid==3

drop if hhid==202239 & pid==1 & wsid==2
drop if hhid==206909 & pid==3 & wsid==2
drop if hhid==209292 & (pid==2| pid==5) & wsid==6
drop if hhid==211604 & pid==2 & wsid==5

drop if hhid==201466 & pid==4 & (wsid==2 | wsid==3)
drop if hhid==214263 & pid==2 & wsid==2
drop if hhid==231115 & pid==3 & (wsid==6 | wsid==5)


* Problemkind :(
drop if hhid==203198 & pid==3 & wsid==4

replace w04= 31 if hhid==213989 & pid==3 & wsid==1
replace w04_dzw= 11 if hhid==213989 & pid==3 & wsid==1
replace w04=8 if hhid==233228 & pid==1 & wsid==7

drop if hhid==213989 & pid==3 & (wsid==2 | wsid==7 | wsid==9)
drop if hhid==233228 & pid==1 & wsid==6


drop if hhid == 201441 & pid==1 & wsid == 3
drop if hhid == 203198 & pid==3 & wsid == 4
drop if hhid == 203654 & pid==4 & wsid == 3
drop if hhid == 205262 & pid==1 & wsid == 4
drop if hhid == 206440 & pid==4 & wsid == 4
drop if hhid == 207922 & pid==3 & wsid == 5
drop if hhid == 213593 & pid==2 & wsid == 6
drop if hhid == 214263 & pid==3 & wsid == 1
drop if hhid == 214428 & pid==1 & wsid == 2
drop if hhid == 216571 & pid==1 & wsid == 2
drop if hhid == 219189 & pid==3 & wsid == 3
drop if hhid == 219203 & pid==1 & wsid == 2
drop if hhid == 219456 & pid==1 & wsid == 3
drop if hhid == 223600 & pid==2 & wsid == 3
drop if hhid == 225750 & pid==3 & wsid == 3
drop if hhid == 225750 & pid==4 & wsid == 4
drop if hhid == 226058 & pid==2 & wsid == 2
drop if hhid == 226526 & pid==1 & wsid == 6
drop if hhid == 227074 & pid==2 & wsid == 2
drop if hhid == 227074 & pid==3 & wsid == 3
drop if hhid == 227189 & pid==2 & wsid == 2
drop if hhid == 229489 & pid==1 & wsid == 4
drop if hhid == 230193 & pid==1 & wsid == 4
drop if hhid == 230593 & pid==1 & wsid == 8
drop if hhid == 230949 & pid==2 & wsid == 2
drop if hhid == 231194 & pid==1 & wsid == 3
drop if hhid == 232588 & pid==1 & wsid == 4
drop if hhid == 232914 & pid==1 & wsid == 6
drop if hhid == 233632 & pid==2 & wsid == 4
drop if hhid == 234302 & pid==1 & wsid == 2
drop if hhid == 235912 & pid==2 & wsid == 1
drop if hhid == 235912 & pid==3 & wsid == 2
drop if hhid == 236873 & pid==4 & wsid == 2
drop if hhid == 236920 & pid==1 & wsid == 6
drop if hhid == 237498 & pid==2 & wsid == 1
drop if hhid == 242584 & pid==5 & wsid == 3
drop if hhid == 242851 & pid==3 & wsid == 5
drop if hhid == 242887 & pid==3 & wsid == 3
drop if hhid == 244355 & pid==4 & wsid == 4
drop if hhid == 244355 & pid==4 & wsid == 5
drop if hhid == 244622 & pid==3 & wsid == 6
drop if hhid == 245640 & pid==2 & wsid == 4
drop if hhid == 245701 & pid==4 & wsid == 4
drop if hhid == 245947 & pid==1 & wsid == 2
drop if hhid == 246439 & pid==1 & wsid == 3
drop if hhid == 246503 & pid==2 & wsid == 2
drop if hhid == 248076 & pid==2 & wsid == 3
drop if hhid == 250073 & pid==2 & wsid == 7
drop if hhid == 251887 & pid==2 & wsid == 2
drop if hhid == 251887 & pid==3 & wsid == 2
drop if hhid == 252428 & pid==2 & wsid == 1
drop if hhid == 252733 & pid==2 & wsid == 4
drop if hhid == 252975 & pid==2 & wsid == 3
drop if hhid == 253508 & pid==1 & wsid == 3
drop if hhid == 254396 & pid==4 & wsid == 5
drop if hhid == 254660 & pid==1 & wsid == 3
drop if hhid == 254910 & pid==2 & wsid == 2
drop if hhid == 254934 & pid==4 & wsid == 3
drop if hhid == 255041 & pid==4 & wsid == 3
drop if hhid == 255425 & pid==1 & wsid == 5
drop if hhid == 258922 & pid==2 & wsid == 4
drop if hhid == 259769 & pid==1 & wsid == 2
drop if hhid == 260822 & pid==2 & wsid == 2
drop if hhid == 264393 & pid==2 & wsid == 2
drop if hhid == 264852 & pid==3 & wsid == 2
drop if hhid == 265548 & pid==1 & wsid == 2
drop if hhid == 270300 & pid==3 & wsid == 2
drop if hhid == 271477 & pid==1 & wsid == 2
drop if hhid == 273864 & pid==3 & wsid == 2
drop if hhid == 274066 & pid==2 & wsid == 2
drop if hhid == 274729 & pid==4 & wsid == 2
drop if hhid == 276556 & pid==4 & wsid == 2
drop if hhid == 281406 & pid==4 & wsid == 4
drop if hhid == 284476 & pid==6 & wsid == 2
drop if hhid == 339726 & pid==2 & wsid == 6
drop if hhid == 339726 & pid==3 & wsid == 2
drop if hhid == 340671 & pid==2 & wsid == 2
drop if hhid == 341062 & pid==2 & wsid == 5
drop if hhid == 345763 & pid==2 & wsid == 1
drop if hhid == 347281 & pid==3 & wsid == 2
drop if hhid == 350008 & pid==1 & wsid == 3
drop if hhid == 351363 & pid==3 & wsid == 2
drop if hhid == 353460 & pid==2 & wsid == 2
drop if hhid == 355175 & pid==2 & wsid == 7
drop if hhid == 355995 & pid==1 & wsid == 2
drop if hhid == 361432 & pid==1 & wsid == 3
drop if hhid == 362706 & pid==2 & wsid == 2
drop if hhid == 365095 & pid==3 & wsid == 3
drop if hhid == 373242 & pid==2 & wsid == 2
drop if hhid == 374637 & pid==2 & wsid == 4
drop if hhid == 447525 & pid==2 & wsid == 4
drop if hhid == 447682 & pid==3 & wsid == 3
drop if hhid == 448524 & pid==1 & wsid == 2
drop if hhid == 451909 & pid==2 & wsid == 2
drop if hhid == 452916 & pid==3 & wsid == 2
drop if hhid == 453034 & pid==1 & wsid == 1
drop if hhid == 454477 & pid==2 & wsid == 2
drop if hhid == 455941 & pid==4 & wsid == 7
drop if hhid == 456906 & pid==2 & wsid == 2
drop if hhid == 456968 & pid==1 & wsid == 2
drop if hhid == 458585 & pid==1 & wsid == 6
drop if hhid == 459554 & pid==4 & wsid == 2
drop if hhid == 460840 & pid==1 & wsid == 1
drop if hhid == 460952 & pid==1 & wsid == 2
drop if hhid == 461407 & pid==2 & wsid == 2
drop if hhid == 461545 & pid==4 & wsid == 5
drop if hhid == 462055 & pid==5 & wsid == 2
drop if hhid == 520242 & pid==2 & wsid == 3



* teilweise Mitnahme im Pkw und Fortsetzung des Weges mit ÖV, teilweise Erledigung dazwischen
replace st_time = st_time + 2*60*60  if hhid==204488 & (pid==2 | pid==3) & wsid==3
replace st_time = st_time + 1*60*60  if hhid==213154 &  pid==1 & wsid==3
replace st_time = st_time +    3*60  if hhid==214263 & pid==2 & wsid==3
replace st_time = st_time +    5*60  if hhid==231115 & pid==3 & wsid==4
replace en_time = en_time - 15*60 if hhid == 211604 & pid == 2 & wsid == 4
replace en_time = en_time - 5*60 if hhid == 211842 & pid == 1 & wsid == 1
replace st_time = st_time + 5*60 if hhid == 212090 & pid == 1 & wsid == 4
replace en_time = en_time - 3*60*60 if hhid == 212365 & pid == 2 & wsid == 5
replace en_time = en_time - 65*60 if hhid == 217021 & pid == 1 & wsid == 3
replace st_time = st_time + 6*60 if hhid == 221830 & pid == 1 & wsid == 6
replace st_time = st_time + 10*60 if hhid == 227809 & pid == 1 & wsid == 4
replace en_time = en_time - 3*60*60 if hhid == 234356 & pid == 3 & wsid == 2
replace en_time = en_time - 2*60 if hhid == 237382 & pid == 4 & wsid == 5
replace st_time = st_time + 8*60 if hhid == 242969 & pid == 2 & wsid == 4
replace st_time = st_time + 20*60 if hhid == 244355 & pid == 2 & wsid == 2
replace st_time = st_time + 10*60 if hhid == 245624 & pid == 2 & wsid == 1
replace en_time = en_time - 60*60 if hhid == 249911 & pid == 2 & wsid == 4
replace st_time = st_time + 7*60 if hhid == 251586 & pid == 2 & wsid == 1
replace st_time = st_time + 7*60 if hhid == 251586 & pid == 4 & wsid == 2
replace st_time = st_time +25*60 if hhid == 253126 & pid == 1 & wsid == 2
replace en_time = en_time - 5*60 if hhid == 253480 & pid == 2 & wsid == 7
replace en_time = en_time - 60*60 if hhid == 254723 & pid == 1 & wsid == 1
replace st_time = st_time + 10*60 if hhid == 256754 & pid == 2 & wsid == 3
replace en_time = en_time - 1*60 if hhid == 257980 & pid == 2 & wsid == 2
replace st_time = st_time + 1*60 if hhid == 257980 & pid == 2 & wsid == 3
replace en_time = en_time - 4*60 if hhid == 258431 & pid == 1 & wsid == 1
replace st_time = st_time + 20*60 if hhid == 259248 & pid == 2 & wsid == 3
replace st_time = st_time + 2*60 if hhid == 260174 & pid == 2 & wsid == 5
replace st_time = st_time + 5*60 if hhid == 261246 & pid == 2 & wsid == 10
replace st_time = st_time + 10*60 if hhid == 263099 & pid == 1 & wsid == 4
replace st_time = st_time + 10*60 if hhid == 263099 & pid == 2 & wsid == 5
replace en_time = en_time - 1*60 if hhid == 264295 & pid == 1 & wsid == 2
replace st_time = st_time + 2*60 if hhid == 264881 & pid == 1 & wsid == 3
replace st_time = st_time + 3*60 if hhid == 266944 & pid == 1 & wsid == 8
replace en_time = en_time -5*60 if hhid == 274245 & pid == 1 & wsid == 3
replace st_time = st_time + 5*60 if hhid == 279846 & pid == 1 & wsid == 3
replace st_time = st_time + 20*60 if hhid == 281406 & pid == 1 & wsid == 2
replace st_time = st_time + 10*60 if hhid == 285735 & pid == 5 & wsid == 3
replace st_time = st_time + 10*60 if hhid == 286883 & pid == 1 & wsid == 4
replace st_time = st_time + 16*60 if hhid == 287410 & pid == 1 & wsid == 6
replace st_time = st_time + 10*60 if hhid == 341070 & pid == 3 & wsid == 7
replace st_time = st_time + 10*60 if hhid == 344536 & pid == 1 & wsid == 5
replace st_time = st_time + 20*60 if hhid == 346376 & pid == 1 & wsid == 4
replace st_time = st_time + 10*60 if hhid == 346991 & pid == 1 & wsid == 10
replace st_time = st_time + 10*60 if hhid == 347008 & pid == 1 & wsid == 7
replace st_time = st_time + 5*60 if hhid == 347607 & pid == 3 & wsid == 2
replace en_time = en_time - 60*60 if hhid == 349702 & pid == 2 & wsid == 1
replace en_time = en_time - 15*60 if hhid == 356202 & pid == 1 & wsid == 2
replace en_time = en_time - 5*60 if hhid == 359945 & pid == 4 & wsid == 2
replace st_time = st_time + 1*60 if hhid == 361931 & pid == 2 & wsid == 4
replace en_time = en_time - 10*60*60 if hhid == 364899 & pid == 1 & wsid == 1
replace en_time = en_time - 10*60*60 if hhid == 364899 & pid == 2 & wsid == 1
replace en_time = en_time - 10*60 if hhid == 365266 & pid == 1 & wsid == 5
replace st_time = st_time + 2*60 if hhid == 369333 & pid == 2 & wsid == 2
replace st_time = st_time + 3*60 if hhid == 375209 & pid == 2 & wsid == 2
replace st_time = st_time + 5*60 if hhid == 448057 & pid == 2 & wsid == 6
replace st_time = st_time + 10*60*60 if hhid == 451971 & pid == 1 & wsid == 1
replace st_time = st_time + 5*60 if hhid == 453766 & pid == 1 & wsid == 5
replace en_time = en_time + 8*60 if hhid == 454477 & pid == 2 & wsid == 1
replace st_time = st_time + 30*60 if hhid == 455069 & pid == 2 & wsid == 1
replace st_time = st_time + 10*60 if hhid == 455941 & pid == 2 & wsid == 2
replace st_time = st_time + 15*60 if hhid == 463599 & pid == 1 & wsid == 5


replace w13 =  3  if hhid == 227189 & pid == 2 & wsid == 1
replace w13 = 4 if hhid == 251586 & pid == 4 & wsid == 1
replace w13 = 4 if hhid == 251887 & pid == 2 & wsid == 1
replace w01 = 1 if hhid == 252428 & pid == 2 & wsid == 2
replace w13 = 5 if hhid ==274066 & pid == 22 & wsid == 1
replace w04 = 1 if hhid ==274245 & pid == 21 & wsid == 4
replace w05_2 = 1 if hhid ==274729 & pid == 24 & wsid == 3
replace w13 = 3 if hhid == 281406 & pid == 4 & wsid == 3
replace w01 = 1 if hhid == 453034 & pid == 1 & wsid == 2
replace w13 = 1 if hhid == 455941 & pid == 4 & wsid == 6

* Zusatz
drop if hhid == 225322 & pid==2 & wsid == 1
drop if hhid == 225322 & pid==2 & wsid == 3
drop if hhid == 235539 & pid==2 & wsid == 8
drop if hhid == 239079 & pid==3 & wsid == 3
drop if hhid == 239079 & pid==3 & wsid == 7
drop if hhid == 239079 & pid==4 & wsid == 2
drop if hhid == 239079 & pid==4 & wsid == 4
drop if hhid == 239079 & pid==4 & wsid == 5
drop if hhid == 239079 & pid==4 & wsid == 6
drop if hhid == 239079 & pid==4 & wsid == 10
drop if hhid == 258063 & pid==2 & wsid == 2
drop if hhid == 258063 & pid==2 & wsid == 4
drop if hhid == 258063 & pid==2 & wsid == 8
drop if hhid == 269581 & pid==1 & wsid == 1
drop if hhid == 276556 & pid==1 & wsid == 1
drop if hhid == 276556 & pid==1 & wsid == 3
drop if hhid == 281098 & pid==2 & wsid == 2
drop if hhid == 281098 & pid==2 & wsid == 4
drop if hhid == 345763 & pid==1 & wsid == 2
drop if hhid == 345763 & pid==1 & wsid == 3
drop if hhid == 453068 & pid==1 & wsid == 1
drop if hhid == 453068 & pid==1 & wsid == 5
drop if hhid == 461437 & pid==4 & wsid == 1
drop if hhid == 461437 & pid==4 & wsid == 4

* Aktualisierung Wegenummerierung
sort hhid pid st_time en_time
bysort hhid pid: replace wsid = _n
sort hhid pid wsid
* verbleibende Wege mit negativer Aktivitätendauer
bysort hhid pid: replace akt_dauer = (st_time[_n] - en_time[_n-1])/60
* Ermittlung einer Wegekette mit mind. einer neg. Aktivitätendauer
gen neg_time2 = akt_dauer<0
label var neg_time2 "negative Aktivitätendauer; nach Prüfung"
bysort hhid pid: egen p_neg2 = sum(neg_time2)
label var p_neg2 "Wegekette mit neg. Aktivätendauer; nach Prüfung"

gen wegedauer = (en_time-st_time)/60
label var wegedauer "Wegedauer nach Plausibilitätsprüfung"

* br hhid pid wsid neg_time ST_STD ST_MIN EN_STD EN_MIN  ANZPERS w071  w074 w04 w01 w13 HVM   doppelter_Weg if p_neg2>0

* Prüfung der Attributierung, Wegezweck & Alter: plausibel


* Prüfung der Wegelängen zur Verkehrsmittelwahl:
* 1) Fälle mit langen Fußwegen zur Arbeit, private Erledigung -> Einzelfallprüfung!
gen tempo2 =  round(wegkm_k/(wegedauer/60),1)
replace tempo2 = . if missing(wegkm_k) & missing(w071)
replace tempo2 = . if (wegkm_k<1 & wegedauer>59) | (wegkm_k<0.5 & wegedauer>29)
* angenommene Geschwindigkeit für Fußgänger: 3 km/h
replace wegkm_k = wegedauer/5/60 if hvm_diff==1 & wegkm_k == 0 & wegedauer<=5 & w04_dzw!=712

replace tempo2 =  round(wegkm_k/(wegedauer/60),1) if tempo2<.



* Plausibiltätsprüfung mit: tab hvm_diff  VM, col nofr

* Datenkonsistenz zw. den Datensätzen prüfen, so dass überall die gleichen Attribute stehen!, Orientierung an DS mit Originalerhebung

* Bei 51 Fällen wurden fehlende Werte ergänzt.
version 10
merge hhid pid using "`path'MiD_Personen_cod.dta", sort keep(hheink oek_stat ov_seg hp_sex hp_alter hhtyp h04_3 h02 pergrup pergrup1 lebensph gesein hp_besch hp_pkwfs w12 p14b p16_1) _merge(Update_Pers) update replace uniqusing
* drop if missing(wsid) 

merge hhid pid using "`path'MiD_HH_cod_transform.dta", sort keep(h02 h04_1 h04_2 h04_3 hheink oek_stat hhtyp rtyp polgk) uniqusing _merge(update_HH) update replace
merge hhid pid using "`path'MiD_HH_cod_transform.dta", sort keep(hp_besch hp_alter hp_beru hp_taet hp_bkat) uniqusing _merge(update_HH2) update

* drop if missing(wsid)
* version 12
* Prüfung der Attributierung, Führerscheinbesitz & Alter: 11 Pkw-Fahrer + 2 Motorradfahrer  <17
* Beeinigung: Pkw-Fahrer zu Mitfahrer, Motorradfahrer zu Mofafahrern
gen VM_anpass = 0
label var VM_anpass "angepasste Verkehrsmittelwahl"

replace pkw_mf=1 if pkw_f==1 & (hp_alter<17 | hp_pkwfs==0)
replace VM_anpass = 1 if pkw_f==1 & (hp_alter<17 | hp_pkwfs==0)
replace pkw_f=0 if pkw_f==1 & (hp_alter<17| hp_pkwfs==0)

replace  w05_3 = 1 if  mrad_f==1 & (hp_alter<17 | hp_pkwfs==0)
replace VM_anpass = 1 if mrad_f==1 & (hp_alter<17 | hp_pkwfs==0)

sort hhid pid wsid


label define w072_2 .a `"keine Angabe"', modify
forvalue i=2/10{
replace w072_`i' = .a if w072_`i'<0
label value w072_`i' w072_2
}


gen zweck_angep = 0

replace  zweck_angep=1 if hp_alter<14 & w04<3 
replace w074 = 1 if hp_alter<14 & w04<3 
replace  w04=11 if hp_alter<14 & w04<3
replace zweck_angep=1 if hp_alter<5 & w04==3
replace w04=32 if hp_alter<5 & w04==3
replace zweck_angep=1 if hp_alter>4 &hp_alter<14 & w04<3
replace w074=1 if hp_alter>4 &hp_alter<14 & w04<3
replace w04=3 if hp_alter>4 & hp_alter<14 & w04<3
replace  zweck_angep=1 if hp_alter<5 & w04<9
replace  w04=11 if hp_alter<5 & w04<9 
replace zweck_angep = 1 if hp_alter<5 & w04_dzw == 501 
replace w074 = 4 if hp_alter<5 & w04_dzw == 501
replace w04 = 11 if hp_alter<5 & w04_dzw == 501
replace zweck_angep = 1 if hp_alter<5 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))
replace w074 = 6 if hp_alter<5 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))
replace w04 = 11 if hp_alter<5 & ((w04_dzw > 501 & w04_dzw < 600) | (w04==4 & w04_dzw==.a))
replace zweck_angep = 1 if hp_alter<5 & w04_dzw > 503  & begleit ==0
replace w074 = 8 if hp_alter<5 & w04_dzw > 503  & begleit ==0
replace w04 = 11 if hp_alter<5 & w04_dzw > 503 & begleit ==0
replace zweck_angep = 1 if hp_alter<5 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713))
replace w074 = 9 if hp_alter<5 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713)) 
replace w04 = 11 if hp_alter<5 & ((w01 == 1 & w13 == 1) | w13 == 5 | (w04_dzw>709 & w04_dzw<713))

replace w13=. if hp_alter<14 & w13==2

label define w074 4 `"periodischer Einkauf"', modify
label define w074 6 `"aperiodischer Einkauf"', modify
label define w074 8 `"Einkaufsbummel"', modify
label define w074 9 `"Rundgang"', modify
label value w074 w074





save "`path'MiD_Wege_cod_bereinig.dta", replace


keep if (hhid == 203198 & pid==3) | /*
*/ (hhid == 206440 & pid==4 ) | /*
*/ (hhid == 214263 & pid==3 ) | /*
*/ (hhid == 235912 & pid==2 ) | /*
*/ (hhid == 237498 & pid==2 ) | /*
*/ (hhid == 252428 & pid==2) | /*
*/ (hhid == 254910 & pid==2) | /*
*/ (hhid == 345763 & pid==2) | /*
*/ (hhid == 453034 & pid==1) | /*
*/ (hhid == 460840 & pid==1) | /*
*/ (hhid == 461437 & pid==4)

drop if hhid == 203198 & pid==3 & wsid == 4
drop if hhid == 206440 & pid==4 & wsid == 4
drop if hhid == 214263 & pid==3 & wsid == 1
drop if hhid == 235912 & pid==2 & wsid == 1
drop if hhid == 237498 & pid==2 & wsid == 1
drop if hhid == 252428 & pid==2 & wsid == 1
drop if hhid == 254910 & pid==2 & wsid == 2
drop if hhid == 345763 & pid==2 & wsid == 1
drop if hhid == 453034 & pid==1 & wsid == 1
drop if hhid == 460840 & pid==1 & wsid == 1

drop if hhid == 461437 & pid==4 & wsid == 2
drop if hhid == 461437 & pid==4 & wsid == 4
drop if hhid == 461437 & pid==4 & wsid == 6
drop if hhid == 461437 & pid==4 & wsid == 8




save "`path'MiD_Wege_cod_bereinig_klein.dta", replace

use "`path'MiD_Wege_cod_bereinig.dta", clear

drop if (hhid == 203198 & pid==3) | /*
*/ (hhid == 206440 & pid==4 ) | /*
*/ (hhid == 214263 & pid==3 ) | /*
*/ (hhid == 235912 & pid==2 ) | /*
*/ (hhid == 237498 & pid==2 ) | /*
*/ (hhid == 252428 & pid==2) | /*
*/ (hhid == 254910 & pid==2) | /*
*/ (hhid == 345763 & pid==2) | /*
*/ (hhid == 453034 & pid==1) | /*
*/ (hhid == 460840 & pid==1) | /*
*/ (hhid == 461437 & pid==4)



append using "`path'MiD_Wege_cod_bereinig_klein.dta" 

sort hhid pid st_time en_time
bysort hhid pid: replace wsid = _n
sort hhid pid wsid
* verbleibende Wege mit negativer Aktivitätendauer
bysort hhid pid: replace akt_dauer = (st_time[_n] - en_time[_n-1])/60
* Ermittlung einer Wegekette mit mind. einer neg. Aktivitätendauer
replace neg_time2 = akt_dauer<0

bysort hhid pid: egen p_neg3 = sum(neg_time2)
label var p_neg2 "Wegekette mit neg. Aktivätendauer; nach Prüfung 3"

replace wegedauer = (en_time-st_time)/60
save "`path'MiD_Wege_cod_bereinig2.dta", replace
