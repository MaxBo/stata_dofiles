*Do-File zum labeln von MOP-Dateien
*Erzeugt von Max Bohnet am Fri Feb 06 12:38:17 2009

program MOP_StataLabelPT
#delimit ;
*Variablen-Labels: ;

label variable ID "Haushalts-ID";
label variable PERSNR "Personen-ID";
label variable JAHR "Erhebungsjahr";
label variable GEWHHPWO "Haushalts- und Personenhochrechenfaktor";
label variable WOTAG "Wochentag";
label variable BERTAG "Berichtstag";
label variable DATUM "Datum";
label variable KRANK "Krank";
label variable WERK "Pkw in Werkstatt";
label variable URLAUB "Urlaub";
label variable ANORM1 "1. Besonderheit";
label variable ANORM2 "2. Besonderheit";
label variable TEMP "Temperatur";
label variable REGEN "Regen";
label variable MOBIL "Mobil";
label variable WEGEgew "Tages-Wegezahl (entf.-gew.)";
label variable KMSUMgew "Tages-KM (entf.-gew.)";
label variable DAUSUMgew "Tages-Mobilitätsdauer (entf.-gew.)";
label variable WEGEungew "Tages-Wegezahl";
label variable KMSUMungew "Tages-KM";
label variable DAUSUMungew "Tages-Mobilitätsdauer";
label variable AnzFUSS "Anzahl Wege zu Fuss (entf.-gew)";
label variable km_FUSS "Entfernung zu Fuss (entf.-gew)";
label variable dau_FUSS "Dauer zu Fuss (entf.-gew)";
label variable AnzRAD "Anzahl Wege mit dem Rad (entf.-gew)";
label variable km_RAD "Entfernung mit dem Rad (entf.-gew)";
label variable dau_RAD "Dauer mit dem Rad (entf.-gew)";
label variable AnzMIV "Anzahl Wege mit MIV als Fahrer (entf.-gew)";
label variable km_MIV "Entfernung mit MIV als Fahrer (entf.-gew)";
label variable dau_MIV "Dauer mit MIV als Fahrer (entf.-gew)";
label variable AnzpkwM "Anzahl Wege mit MIV als Mitfahrer (entf.-gew)";
label variable km_pkwM "Entfernung mit MIV als Mitfahrer (entf.-gew)";
label variable dau_pkwM "Dauer mit MIV als Mitfahrer (entf.-gew)";
label variable AnzPKW "Anzahl Wege mit dem Pkw gesamt (entf.-gew)";
label variable km_PKW "Entfernung mit dem Pkw gesamt (entf.-gew)";
label variable dau_PKW "Dauer mit dem Pkw gesamt (entf.-gew)";
label variable AnzOV "Anzahl Wege mit dem ÖV insgesamt (entf.-gew)";
label variable km_OV "Entfernung mit dem ÖV insgesamt (entf.-gew)";
label variable dau_OV "Dauer mit dem ÖV insgesamt (entf.-gew)";
label variable AnzZug "Anzahl Wege mit dem Zug (entf.-gew)";
label variable km_Zug "Entfernung mit dem Zug (entf.-gew)";
label variable dau_Zug "Dauer mit dem Zug (entf.-gew)";
label variable AnzOVs "Anzahl Wege mit U- / S-Bahn (entf.-gew)";
label variable km_OVs "Entfernung mit U- / S-Bahn (entf.-gew)";
label variable dau_OVs "Dauer mit U- / S-Bahn (entf.-gew)";
label variable AnzBus "Anzahl Wege mit dem Bus (entf.-gew)";
label variable km_Bus "Entfernung mit dem Bus (entf.-gew)";
label variable dau_Bus "Dauer mit dem Bus (entf.-gew)";
label variable AnzARB "Anzahl Wege zur Arbeit (entf.-gew)";
label variable km_Arb "Entfernung von Wegen zur Arbeit (entf.-gew)";
label variable dau_Arb "Dauer von Wegen zur Arbeit (entf.-gew)";
label variable AnzAUSB "Anzahl Wege zur Ausbildung (entf.-gew)";
label variable km_AUSB "Entfernung von Wegen zur Ausbildung (entf.-gew)";
label variable dau_AUSB "Dauer von Wegen zur Ausbildung (entf.-gew)";
label variable AnzEINK "Anzahl Wege zum Einkaufen (entf.-gew)";
label variable km_Eink "Entfernung von Wegen zum Einkaufen (entf.-gew)";
label variable dau_Eink "Dauer von Wegen zum Einkaufen (entf.-gew)";
label variable AnzFREI "Anzahl Wege zur Freizeit (entf.-gew)";
label variable km_Frei "Entfernung von Wegen zur Freizeit (entf.-gew)";
label variable dau_Frei "Dauer von Wegen zur Freizeit (entf.-gew)";
label variable AnzSERV "Anzahl Wege zu Servicezwecken (entf.-gew)";
label variable km_Serv "Entfernung von Wegen zu Servicezwecken (entf.-gew)";
label variable dau_Serv "Dauer von Wegen zu Servicezwecken (entf.-gew)";
label variable AnzDIEN "Anzahl Wege dienstlich (entf.-gew)";
label variable km_Dien "Entfernung von Wegen dienstlich (entf.-gew)";
label variable dau_Dien "Dauer von Wegen dienstlich (entf.-gew)";
label variable AnzHEIM "Anzahl Wege nach Hause (entf.-gew)";
label variable km_Heim "Entfernung von Wegen nach Hause (entf.-gew)";
label variable dau_Heim "Dauer von Wegen nach Hause (entf.-gew)";
label variable musterZW "Zweckabfolge der Tages-Wege";
label variable musterVM "VM-Abfolge der Tages-Wege";

*define ValueLabels: ;

label define ANORM1
	0	"nein"
	1	"ja"
	;

label define ANORM2
	0	"nein"
	1	"ja"
	;

label define KRANK
	0	"nicht krank"
	1	"krank"
	;

label define MOBIL
	0	"nein"
	1	"Ja"
	;

label define URLAUB
	0	"kein Urlaub"
	1	"Urlaub"
	;

label define WERK
	0	"nicht in der Werkstatt"
	1	"in der Werkstatt"
	;

label define WOTAG
	1	"Montag"
	2	"Dienstag"
	3	"Mittwoch"
	4	"Donnerstag"
	5	"Freitag"
	6	"Samstag"
	7	"Sonntag"
	;


*label Values and recode missings: ;

label values WOTAG WOTAG;
label values KRANK KRANK;
label values WERK WERK;
label values URLAUB URLAUB;
label values ANORM1 ANORM1;
label values ANORM2 ANORM2;
label values MOBIL MOBIL;

#delimit cr

end
