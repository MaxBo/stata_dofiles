clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\p.dta", clear
label define vorh 1 `"vorhanden"' 0 `"fehlt"'
label define jn 1 `"ja"' 0 `"nein"'

label var ID "Schl�sselnummer des HH (1-7)"
label var Welle "Befragungswelle"
label var Kohorte "Kohorte"
label var persnr "Personennummer im Haushalt"
label var teiln "Teilnehmer an der Erhebung"
label value teiln jn
label var Gruppe "Befragungsgruppe"
label var HHstat "Haushaltsfragebogen"
label define HHstat 1 `"Fragebogen vorhanden"' .a `"Fragebogen fehlt"'
recode HHstat (9=.a)
label value HHstat HHstat

label var anzreisebogen1 "Anzahl versendeter blauer Frageb�gen"
label var anzreisebogen2 "Anzahl r�ckgesendeter blauer Frageb�gen"

label var sex "Geschlecht Mann"
label define sex 1 `"m�nnlich"' 0 `"weiblich"'
recode sex (2=0)
label value sex sex

label var gebjahr "Geburtsjahr"
label var schulab "H�chster erreichter Schulabschluss (W1-W3)"
label define schulab 1 `"Haupt- oder Volksschule"' 2 `"mittl. Reife, POS"' 3 `"Abitur, Fachabi?"' 4 `"Fach-/Hochschulabschluss"' 5 `"noch kein Abschluss"'
label value schulab schulab

label var beruf "T�tigkeit der Person"
label define beruf 1 `"voll berufst�tig"', modify
label define beruf 2 `"teilw. berufst�tig"', modify
label define beruf 3 `"Bundeswehr, Zivildienst, soz. Jahr"', modify
label define beruf 4 `"arbeitslos"', modify
label define beruf 5 `"Ausbildung in Schule/Hochschule"', modify
label define beruf 6 `"Berufsausbildung"', modify
label define beruf 7 `"nicht erwerbst�tig als Hausfrau /-mann"', modify
label define beruf 8 `"Rentner"', modify
label define beruf 9 `"Kleinkind/Kindergarten"', modify
label value beruf beruf

label var FS "F�hrerscheinbesitz der Person(W1-W3)"
label value FS jn
recode FS (1=0) (2=1)
label var FSK1 "F�hrerschein Motorrad"
label var FSK2 "F�hrerschein Lkw"
label var FSK3 "F�hrerschein Pkw"
label var FSK4 "F�hrerschein Mofa/Moped"
label value FSK? jn

label var Bahncard "Bahncardbesitz der Person"
recode Bahncard (1=0) (2=1)
label value Bahncard jn

label var Zeitkarte "Zeitkartenbesitz der Person"
recode Zeitkarte (1=0) (2=1)
label value Zeitkarte jn

label var Vielflieger "Person in Vielfliegerprogramm"
recode Vielflieger (1=0) (2=1)
label value Vielflieger jn

forvalue i=1/3 {
	label var VF`i' "Vielfliegerprogramm `i'"
}

label var zweitw "Verf�gbarkeit Zweitwohnung Teilnehmer 1 (W1-W3)"
recode zweitw (1=0) (2=1)
label value zweitw jn

label var zweitwart "Art der Unterkunft"
label define zweitwart 1 `"Ferienwohnung /-domizil"' 2 `"Unterkunft in N�he des Arbeits-/Ausbildungsort"' 3 `"bei Eltern/Verwandten"' 4 `"Lebenspartner bei Wochenendebeziehungen"' 5 `"Dienstunterkunft bei Wehr-/Zivildienst"'
label value zweitwart zweitwart


label var zweitwland "Land des Zweitwohnsitzes"
label define land 1 `"Deutschland"' 2 `"Ausland"'
label value zweitwland land

label var zweitwlandcode "Code des Zweitwohnlandes"
label var zweitwlandname "Name des Zweitwohnlandes"
label var zweitwbundlandcoded "Code des Bundesland des Zweitwohnsitzes"
label var zweitwstadtcoded "Code der Stadt des Zweitwohnsitzes"
label var  zweitwgkzd "GKZ des Zweitwohnsitzes"
label var  zweitwplzd "PLZ des Zweitwohnsitzes"
label var zweitwstadta "Stadtname des Zweitwohnsitzes"

label var mobtel "Mobiltelefon vorhanden (W1-W3)"
recode mobtel (1=0) (2=1)
label value mobtel jn

label var internet "Internet vorhanden (W1-W3)"
recode internet (1=0) (2=1)
label value internet jn

label var internet1 "Internet PC daheim"
label var internet2 "Internet PC Arbeit"
label var internet3 "Internet privates Mobiltelefon"
label var internet4 "Internet dienstl. Mobiltelefon"
label var internet5 "sonstige"

forvalue i=1/5 {
	replace internet`i'=0 if missing(internet`i')
	}
label value internet? jn

label var bfv "Art der Berufst�tigkeit"
label define bfv 1 `"Berufst�tigkeit im GV/PV, Ziele>100km v. Wohnort"' 2 `"Berufst�tigkeit Handeslvertreter, Ziele>100km v. Wohnort"' 3 `"in einem anderen Bereich"'
label value bfv bfv

label var arbland "Land des Arbeitsplatzes"
label value arbland land

label var arblandcode "Code des Zweitwohnlandes"
label var arblandname "Name des Zweitwohnlandes"
label var arbbundlandcoded "Code des Bundesland des Arbeitsplatzes"
label var arbstadtcoded "Code der Stadt des Arbeitsplatzes"
label var  arbgkzd "GKZ des Arbeitsplatzes"
label var  arbplzd "PLZ des Arbeitsplatzes"
label var arbstadta "Stadtname des Arbeitsplatzes"

label var arblage "Lage des Arbeitsplatzes"
label define hhlage 1 `"innerer Stadtbereich einer Gro�stadt"', modify 
label define hhlage 2 `"Stadtrand bzw. Vorort Gro�stadt"', modify 
label define hhlage 3 `"innerer Stadtbereich einer mittelgro�en Stadt"', modify
label define hhlage 4 `"Stadtrand bzw. Vorort mittelgro�e Stadt"', modify
label define hhlage 5 `"Kleinstadt bzw. gro�e Gemeinde"', modify
label define hhlage 6 `"auf dem Land bzw. kleine Landgemeinde"', modify
label value arblage hhlage

label var kmwohnzuarb "Entfernung von Wohn- zu Arbeitsplatz [km]"
label var arbimhaus "Arbeit liegt im Wohnhaus(W2-W4)"
replace arbimhaus=0 if (beruf<4 | beruf == 6 | beruf==5 | beruf==8)

label var vmarb1 "Fu�"
label var vmarb2 "Fahrrad"
label var vmarb3 "Mofa, Moped, Fahrrad"
label var vmarb4 "Bus"
label var vmarb5 "Stadtbahn, Stra�enbahn"
label var vmarb6 "U-Bahn"
label var vmarb7 "Pkw-Fahrer"
label var vmarb8 "Pkw-Mitfahrer"
label var vmarb9 "Eisenbahn, Zug"
label var vmarb10 "Sonstige"

gen vmarb_multi = vmarb1==1
replace vmarb1 = 0 if missing(vmarb1) & teiln==1 & (beruf<4 | beruf == 6 | beruf==5)
label value vmarb1 jn

forvalue i=2/10 {
	qui replace vmarb`i' = 0 if missing(vmarb`i') & teiln==1 & (beruf<4 | beruf == 6 | beruf==5)
	label value vmarb`i' jn
	qui replace vmarb_multi = vmarb_multi + vmarb`i' if vmarb`i'==1
}
label var vmarb_multi "Multimodalit�t bei der Fahrt zum Arbeitsplatz"


forvalue i=21/24{
	drop MNIS`i'*
}
forvalue i=25/29{
	drop MC`i'*
}
forvalue i=1/25{
	drop DL30a`i'
}
drop DL30gka DL31
drop nutzp* nutzg* 

label var nachfass "Nachfassfragebogen vorhanden"
label value nachfass vorh
label var nachfass1a "Info zur Nachfassaktion (W1)"
label define nachfass1a 1 `"alle Reiseb�gen ben�tigt"' 2 `"vor Osterfeiertagen zur�ckgeschickt"'
label value nachfass1a nachfass1a
label var nachfass1b "Datum der letzten R�ckreise (W1)"

label var nachfass2a "Info zur Nachfassaktion (W2)"
label define nachfass2a 1 `"alle Reiseb�gen ben�tigt"' 2 `"nicht alle Reiseb�gen ben�tigt"'  3 `"ohne Reise im Berichtszeitraum"' .a `"keine Angabe"'
recode nachfass2? (9=.a)
label value nachfass2a nachfass2a
label var nachfass2b "Zus�tzliche Reisen (W2)"
label define nachfass2b 1 `"keine zus�tzlichen Reisen"' 2 `"zus�tzliche Reisen"'  .a `"keine Angabe"'
label value  nachfass2b nachfass2b

label var zureisenges "Anzahl zus�tzl. Reisen (gesamt)"
label var zureisenurl "Anzahl zus�tzl. Urlaubsreisen"
label var zureisenkurz "Anzahl zus�tzl. Kurzurlaubsreisen"
label var zureisentar "Anzahl zus�tzl. Tagesreisen"
label var zureisendir "Anzahl zus�tzl. Dienstreisen"


label var histpkw "Letzte Nutzung Pkw f�r Reise > 100km (W3)"
label var histbahn "Letzte Nutzung Bahn f�r Reise > 100km (W3)"
label var histflug "Letzte Nutzung Flugzeug f�r Reise > 100km (W3)"
label var histbus "Letzte Nutzung Reisebus f�r Reise > 100km (W3)"

label define hist 1 `"< 1 Jahr"', modify
label define hist 2 `"1-3 Jahre"', modify
label define hist 3 `"3-5 Jahre"', modify
label define hist 4 `"5-10 Jahre"', modify
label define hist 5 `"> 10 Jahr"', modify
label define hist 6 `"noch nie"', modify

label value hist* hist

label var nobusi "Person ohne Gesch�ftsreisen"
label value nobusi jn
replace nobusi = 0 if missing(nobusi)

label define wichtig  1 `"sehr wichtig"' 0 `"wichtig"' -1 `"weniger wichtig"'

foreach x in "preis"	"schnell"	"komfort"	"puenktl"	"flexibel"	"sicher"	"unkompl"	"erhols"	"umwelt"	"fortschr"	"sympath"{
	rename g_`x' Dienst`x'
	rename p_`x' Privat`x'
	rename u_`x' Urlaub`x'
	rename a_`x' Auto`x'
	rename b_`x' Bahn`x'
	rename f_`x' Flugzeug`x'
	rename r_`x' Reisebus`x'
}


foreach x in "preis"	"schnell"	"komfort"	"puenktl"	"flexibel"	"sicher"	"unkompl"	"erhols"	"umwelt"	"fortschr"	"sympath"{
	foreach y in "Privat" "Urlaub" "Dienst" "Auto" "Bahn" "Flugzeug" "Reisebus"{
		label value `y'`x' wichtig
		label var `y'`x' "Wichtigkeit des `x' bei `y'reisen (W3)"
		* label var `y'`x' "Wichtigkeit des `x' bei Dienstreisen" if `y'=="g_"
		* label var `y'`x' "Wichtigkeit des `x' bei Urlaubsreisen" if `y'=="u_"
	}
}

foreach x in "preis"	"schnell"	"komfort"	"puenktl"	"flexibel"	"sicher"	"unkompl"	"erhols"	"umwelt"	"fortschr"	"sympath"{
	rename	Dienst`x'	g_`x'
	rename	Privat`x'	p_`x'
	rename	Urlaub`x'	u_`x'
	rename	Auto`x'	a_`x'
	rename	Bahn`x'	b_`x'
	rename	Flugzeug`x'	f_`x'
	rename	Reisebus`x'	r_`x'
}

label define rang .a `"nicht ber�cksichtigt"'
label value rank_* rang
foreach x in "pkw" "bahn" "flug" "bus"{ 
	label var rank_`x' "Rang `x' bei Reiseweite 600km (W3)"
	recode rank_`x' (9=.a)
}

rename rank_pkw rank_1
rename rank_bahn rank_2
rename rank_flug rank_3
rename rank_bus rank_4


reshape long rank_ , i(ID persnr Welle) j(VM)


bysort ID persnr Welle: gen vm_pref_t = 0 if (rank_<5 | rank_==.a) & Welle==3
bysort ID persnr Welle: replace vm_pref_t= VM if rank_==1
bysort ID persnr Welle: egen vm_pref1 = sum(vm_pref_t) 
drop vm_pref_t

bysort ID persnr Welle: gen vm_pref_t2 = 0 if (rank_<5 | rank_==.a) & Welle==3
bysort ID persnr Welle: replace vm_pref_t2= VM if rank_==2
bysort ID persnr Welle: egen vm_pref2 = sum(vm_pref_t2)
drop vm_pref_t2

reshape wide rank_, i(ID persnr Welle) j(VM)

rename	rank_1	rank_pkw
rename	rank_2	rank_bahn
rename	rank_3	rank_flug
rename	rank_4	rank_bus

forvalues i=1/2{
replace vm_pref`i' = . if vm_pref`i'>4
replace vm_pref`i' = . if vm_pref`i'==0
}

label define vm 1 `"Pkw"' 2 `"Bahn"' 3 `"Flug"' 4 `"Reisebus"' 
label value vm_pref? vm
label var vm_pref1 "bevorzugtes Verkehrsmittel"
label var vm_pref2 "zweitbeliebtestes Verkehrsmittel"

label var  vmorienttexte "Kommentare zur Verkehrsmittelwahl im Fernverkehr (W3)"

label var DL30a26 "Ich bin privat gerne unterwegs"
label var DL30a27 "Ich bin gesch�ftlich gerne unterwegs"
label var kontrolnr "Kontrollnummer"

label define dl 1  `"trifft voll zu"' 2 `"trifft �berwiegend zu"' 3 `"trifft eher zu"' 4 `"trifft eher nicht zu"'  6  `"trifft �berhaupt nicht zu"' 5 `"trifft �berwiegend nicht zu"'
label value DL30a2? dl

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\p_label.dta", replace


