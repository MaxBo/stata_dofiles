*fasse Value-Labels zusammen und codiere SPSS-Missing-Values für Stata um
*written by Max Bohnet & Sonja Löwa am Tue Mar 02 18:19:36 2010
*erzeugt mit Python-Programm C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD2008_Datensätze\Stata\genLabels2.py
*Eingangsdateien:
* C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD2008_Datensätze\Stata\Wege_Label.txt (in Stata  mit 'label save' erzeugt)
* C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD2008_Datensätze\Stata\Wege_replace.txt (manuell erzeugt)


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MID_2008_Dtl\STATA\STATA_Public Use File\MiD2008_PUF_Wege.dta", clear
label drop _all
gen long id_hhp=hhid*10+pid
label var id_hhp "Identifikationsnummer Haushalt+Person"
gen long id_hhpw=id_hhp*10+wsid
label var id_hhpw "Identifikationsnummer Haushalt+Person+Weg"
label define st_dat 0 `"Stichtag"', modify
label define st_dat 1 `"Folgetag"', modify
label define gtyp 1 `"Kern- und Großstädte >= 500.000 E. in Agglomerationsräumen"', modify
label define gtyp 2 `"Kern- und Großstädte unter 500.000 E. in Agglomerationsräume"', modify
label define gtyp 3 `"OZ/MZ in hochverd. Kreisen von Agglomerationsräumen"', modify
label define gtyp 4 `"sonstige Gemeinden in hochverd. Kreisen von Agglomerationsrä"', modify
label define gtyp 5 `"OZ/MZ in verd. Kreisen von Agglomerationsräumen"', modify
label define gtyp 6 `"sonstige Gemeinden in verd. Kreisen von Agglomerationsräumen"', modify
label define gtyp 7 `"OZ/MZ in ländlichen Kreisen von Agglomerationsräumen"', modify
label define gtyp 8 `"sonstige Gemeinden in ländlichen Kreisen von Agglomerationsr"', modify
label define gtyp 9 `"Kern- und Großstädte in Verstädterten Räumen"', modify
label define gtyp 10 `"OZ/MZ in verd. Kreisen von Verstädterten Räumen"', modify
label define gtyp 11 `"sonstige Gemeinden in verd. Kreisen von Verstädterten Räumen"', modify
label define gtyp 12 `"OZ/MZ in ländlichen Kreisen von Verstädterten Räumen"', modify
label define gtyp 13 `"sonstige Gemeinden in ländlichen Kreisen von Verstädterten R"', modify
label define gtyp 14 `"OZ/MZ in Kreisen höherer Dichte von Ländlichen Räumen"', modify
label define gtyp 15 `"sonstige Gemeinden in Kreisen höherer Dichte von Ländlichen "', modify
label define gtyp 16 `"OZ/MZ in Kreisen geringerer Dichte von Ländlichen Räumen"', modify
label define gtyp 17 `"sonstige Gemeinden in Kreisen geringerer Dichte von Ländlich"', modify
label define gtyp .c `"nicht zuzuordnen"', modify
label define ktyp_zsg 1 `"Kernstaedte"', modify
label define ktyp_zsg 2 `"Verdichtete Kreise"', modify
label define ktyp_zsg 3 `"Laendliche Kreise"', modify
label define ktyp_zsg .c `"nicht zuzuordnen"', modify
label define ktyp 1 `"Agglomerationsraum - Kernstädte"', modify
label define ktyp 2 `"Agglomerationsraum - Hochverdichtete Kreise"', modify
label define ktyp 3 `"Agglomerationsraum - Verdichtete Kreise"', modify
label define ktyp 4 `"Agglomerationsraum - Ländliche Kreise"', modify
label define ktyp 5 `"Verstädterte Räume - Kernstädte"', modify
label define ktyp 6 `"Verstädterte Räume - Verdichtete Kreise"', modify
label define ktyp 7 `"Verstädterte Räume - Ländliche Kreise"', modify
label define ktyp 8 `"Ländliche Räume- ländliche Kreise höherer Dichte"', modify
label define ktyp 9 `"Ländliche Räume - Ländliche Kreise geringerer Dichte"', modify
label define ktyp .c `"nicht zuzuordnen"', modify
label define rtypd7 1 `"Hochverdichtete Agglomerationsräume"', modify
label define rtypd7 2 `"Agglomerationsräume mit herausragenden Zentren"', modify
label define rtypd7 3 `"Verstädterte Räume höherer Dichte"', modify
label define rtypd7 4 `"Verstädterte Räume mittlerer Dichte"', modify
label define rtypd7 5 `"Verstädterte Räume mittlerer Dichte ohne große Oberzentren"', modify
label define rtypd7 6 `"Ländliche Räume höherer Dichte"', modify
label define rtypd7 7 `"Ländliche Räume geringerer Dichte"', modify
label define rtypd7 .c `"nicht zuzuordnen"', modify
label define rtyp 1 `"Agglomerationsräume"', modify
label define rtyp 2 `"Verstädterte Räume"', modify
label define rtyp 3 `"Ländliche Räume"', modify
label define rtyp .c `"nicht zuzuordnen"', modify
label define co2weg .h `"Wert nicht zu berechnen"', modify
label define pergrup1 1 `"Berufstätige(r) mit verfügbarem Pkw"', modify
label define pergrup1 2 `"Berufstätige(r) ohne Pkw"', modify
label define pergrup1 3 `"Nicht-Berufstätige(r) mit verfügbarem Pkw"', modify
label define pergrup1 4 `"Nicht-Berufstätige(r) ohne Pkw"', modify
label define pergrup1 5 `"Student(in) mit verfügbarem Pkw"', modify
label define pergrup1 6 `"Student(in) ohne Pkw"', modify
label define pergrup1 7 `"Auszubildende(r) mit verfügbarem Pkw"', modify
label define pergrup1 8 `"Auszubildende(r) ohne Pkw"', modify
label define pergrup1 9 `"Kind 0-6 Jahre"', modify
label define pergrup1 10 `"Schüler(in) 7-10 Jahre"', modify
label define pergrup1 11 `"Schüler(in) ab 11 Jahren mit verfügbarem Pkw"', modify
label define pergrup1 12 `"Schüler(in) ab 11 Jahren ohne Pkw"', modify
label define pergrup1 .c `"nicht zuzuordnen"', modify
label define pergrup 1 `"Berufstätige(r) mit verfügbarem Pkw"', modify
label define pergrup 2 `"Berufstätige(r) ohne Pkw"', modify
label define pergrup 3 `"Nicht-Berufstätige(r) mit verfügbarem Pkw"', modify
label define pergrup 4 `"Nicht-Berufstätige(r) ohne Pkw"', modify
label define pergrup 5 `"Student(in)"', modify
label define pergrup 6 `"Auszubildende(r)"', modify
label define pergrup 7 `"Kind 0-6 Jahre"', modify
label define pergrup 8 `"Schüler(in) 7-10 Jahre"', modify
label define pergrup 9 `"Schüler(in) ab 11 Jahren"', modify
label define pergrup .c `"nicht zuzuordnen"', modify
label define gesein 1 `"Person mit gesundheitlicher Einschränkung"', modify
label define gesein 2 `"Person ohne gesundheitliche Einschränkung"', modify
label define gesein .f `"verweigert, weiß nicht"', modify
label define gesein .m `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"', modify
label define p070 1 `"Einzelfahrschein, Tageskarte, Kurzstrecke"', modify
label define p070 2 `"Mehrfachkarte, Streifenkarte"', modify
label define p070 3 `"Wochenkarte, Monatskarte ohne Abonnement"', modify
label define p070 4 `"Monatskarte im Abonnement, Jahreskarte (Umweltabo etc.)"', modify
label define p070 5 `"Jobticket, Firmenabo"', modify
label define p070 6 `"anderes"', modify
label define p070 .u `"fahre nie mit öffentlichen Verkehrsmitteln"', modify
label define p070 .f `"verweigert"', modify
label define p070 .g `"weiß nicht"', modify
label define p070 .m `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"', modify
label define p070 .v `"Kind 10-13 J. (Selbst) mit Wegeprotokoll"', modify
label define p070 .n `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define p070 .o `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define p070 .w `"Ki. 10-13 J. (Selbst) o. Wegeprot. (StTag <= 3 Tage/ Ausl.)"', modify
label define p070 .x `"Kind 10-13 J. (Selbst) o. Wegeprot. (StTag > 3 Tage)"', modify
label define anzpers .e `"unplausibler Wert"', modify
label define anzpers .f `"verweigert"', modify
label define anzpers .g `"weiß nicht"', modify
label define anzpers .i `"bei rbW nicht erhoben"', modify
label define w07 0 `"allein unterwegs"', modify
label define w07 .e `"unplausibler Wert"', modify
label define w07 .f `"verweigert"', modify
label define w07 .g `"weiß nicht"', modify
label define w07 .i `"bei rbW nicht erhoben"', modify
label define saison 1 `"Winter"', modify
label define saison 2 `"Frühjahr"', modify
label define saison 3 `"Sommer"', modify
label define saison 4 `"Herbst"', modify
label define lebensph 1 `"Berufstätige(r) - Vollzeit (incl. Azubi, Zivi)"', modify
label define lebensph 2 `"Berufstätige(r) - Teilzeit"', modify
label define lebensph 3 `"Schüler"', modify
label define lebensph 4 `"Student"', modify
label define lebensph 5 `"Kind"', modify
label define lebensph 6 `"Hausfrau | Hausmann (incl. Elternzeit)"', modify
label define lebensph 7 `"Rentner (in) | Pensionär(in)"', modify
label define lebensph 8 `"Sonstiges"', modify
label define hhtyp 1 `"Einpersonenhh_Person 18 bis < 30 Jahre"', modify
label define hhtyp 2 `"Einpersonenhh_Person 30 bis < 60 Jahre"', modify
label define hhtyp 3 `"Einpersonenhh_Person 60 Jahre und älter"', modify
label define hhtyp 4 `"HH mit zwei Erwachsenen_jüngste Person 18 bis < 30 Jahre"', modify
label define hhtyp 5 `"HH mit zwei Erwachsenen_jüngste Person 30 bis < 60 Jahre"', modify
label define hhtyp 6 `"HH mit zwei Erwachsenen_jüngste Person 60 Jahre und älter"', modify
label define hhtyp 7 `"HH mit drei und mehr erwachsenen Personen"', modify
label define hhtyp 8 `"HH mit mindestens einem Kind unter 6 Jahre"', modify
label define hhtyp 9 `"HH mit mindestens einem Kind unter 14 Jahre"', modify
label define hhtyp 10 `"HH mit mindestens einem Kind unter 18 Jahre"', modify
label define hhtyp 11 `"Alleinerziehende"', modify
label define hhtyp .k `"Alter von mind. 1 HH-Mitglied nicht bekannt"', modify
label define hhtyp .n `"kein Privathaushalt"', modify
label define hhtyp .c `"nicht zuzuordnen"', modify
label define hp_altg3 1 `"0 - 4 Jahre"', modify
label define hp_altg3 2 `"5 - 10"', modify
label define hp_altg3 3 `"11 - 13"', modify
label define hp_altg3 4 `"14 - 17"', modify
label define hp_altg3 5 `"18 - 29"', modify
label define hp_altg3 6 `"30 - 39"', modify
label define hp_altg3 7 `"40 - 49"', modify
label define hp_altg3 8 `"50 - 59"', modify
label define hp_altg3 9 `"60 - 64"', modify
label define hp_altg3 10 `"65 - 74"', modify
label define hp_altg3 11 `"75 und älter"', modify
label define hp_altg3 .a `"keine Angabe"', modify
label define hp_altg2 1 `"0 - 9 Jahre"', modify
label define hp_altg2 2 `"10 - 19"', modify
label define hp_altg2 3 `"20 - 29"', modify
label define hp_altg2 4 `"30 - 39"', modify
label define hp_altg2 5 `"40 - 49"', modify
label define hp_altg2 6 `"50 - 59"', modify
label define hp_altg2 7 `"60 - 69"', modify
label define hp_altg2 8 `"70 - 79"', modify
label define hp_altg2 9 `"80 und älter"', modify
label define hp_altg2 .a `"keine Angabe"', modify
label define hp_altg1 1 `"0 - 5 Jahre"', modify
label define hp_altg1 2 `"6 - 9"', modify
label define hp_altg1 3 `"10 - 13"', modify
label define hp_altg1 4 `"14 - 17"', modify
label define hp_altg1 5 `"18 - 24"', modify
label define hp_altg1 6 `"25 - 44"', modify
label define hp_altg1 7 `"45 - 59"', modify
label define hp_altg1 8 `"60 - 64"', modify
label define hp_altg1 9 `"65 und älter"', modify
label define hp_altg1 .a `"keine Angabe"', modify
label define ov_seg 1 `"Wenig-Mobile"', modify
label define ov_seg 2 `"Fahrradfahrer"', modify
label define ov_seg 3 `"ÖPNV-Captives"', modify
label define ov_seg 4 `"ÖPNV-Stammkunden"', modify
label define ov_seg 5 `"ÖPNV-Gelegenheitskunden"', modify
label define ov_seg 6 `"ÖPNV-Potential"', modify
label define ov_seg 7 `"IV-Stammkunden"', modify
label define ov_seg .b `"nicht zu bestimmen"', modify
label define westost 1 `"West"', modify
label define westost 2 `"Ost"', modify
label define h02 .f `"verweigert"', modify
label define h02 .g `"weiß nicht"', modify
label define h02 .a `"keine Angabe"', modify
label define oek_stat 1 `"sehr niedrig"', modify
label define oek_stat 2 `"niedrig"', modify
label define oek_stat 3 `"mittel"', modify
label define oek_stat 4 `"hoch"', modify
label define oek_stat 5 `"sehr hoch"', modify
label define oek_stat .c `"nicht zuzuordnen"', modify
label define tempo .i `"bei rbW nicht zu bestimmen"', modify
label define tempo .e `"Angabe unplausibel"', modify
label define tempo .h `"Wert nicht zu berechnen"', modify
label define hwzweck 1 `"Arbeit"', modify
label define hwzweck 2 `"dienstlich"', modify
label define hwzweck 3 `"Ausbildung"', modify
label define hwzweck 4 `"Einkauf"', modify
label define hwzweck 5 `"Erledigung"', modify
label define hwzweck 6 `"Freizeit"', modify
label define hwzweck 7 `"Begleitung"', modify
label define hwzweck .a `"keine Angabe"', modify
label define wegmin_k .i `"bei rbW nicht zu bestimmen"', modify
label define wegmin_k .e `"Angabe unplausibel"', modify
label define wegkm_k .e `"Angabe unplausibel"', modify
label define wegkm_k .f `"verweigert"', modify
label define wegkm_k .g `"weiß nicht"', modify
label define w063 1 `"Auto 1"', modify
label define w063 2 `"Auto 2"', modify
label define w063 3 `"Auto 3"', modify
label define w063 5 `"anderes Fahrzeug"', modify
label define w063 .f `"verweigert"', modify
label define w063 .g `"weiß nicht"', modify
label define w063 .i `"bei rbW nicht erhoben"', modify
label define w063 0 `"HH ohne Auto"', modify
label define w063 .p `"HH mit mehr als 4 Autos"', modify
label define w063 .q `"Weg ohne Autonutzung"', modify
label define w063 .r `"Weg mit Autonutzung, aber ohne Nutzung eines HH-Autos"', modify
label define st_stdg 1 `"vor 5 Uhr"', modify
label define st_stdg 2 `"5 bis vor 7"', modify
label define st_stdg 3 `"7 bis vor 9"', modify
label define st_stdg 4 `"9 bis vor 11"', modify
label define st_stdg 5 `"11 bis vor 14"', modify
label define st_stdg 6 `"14 bis vor 17"', modify
label define st_stdg 7 `"17 bis vor 20"', modify
label define st_stdg 8 `"20 bis vor 22"', modify
label define st_stdg 9 `"nach 22 Uhr"', modify
label define st_stdg .i `"bei rbW nicht erhoben"', modify
label define bikgk10 1 `"unter 2.000 Einw."', modify
label define bikgk10 2 `"2.000 bis unter 5.000 Einw."', modify
label define bikgk10 3 `"5.000 bis unter 20.000 Einw."', modify
label define bikgk10 4 `"20.000 bis unter 50.000 Einw."', modify
label define bikgk10 5 `"50.000 bis unter 100.000 Einw., Strukturtyp 2/3/4"', modify
label define bikgk10 6 `"50.000 bis unter 100.000 Einw., Strukturtyp 1"', modify
label define bikgk10 7 `"100.000 bis unter 500.000 Einw., Strukturtyp 2/3/4"', modify
label define bikgk10 8 `"100.000 bis unter 500.000 Einw., Strukturtyp 1"', modify
label define bikgk10 9 `"500.000 und mehr Einw., Strukturtyp 2/3/4"', modify
label define bikgk10 10 `"500.000 und mehr Einw., Strukturtyp 1"', modify
label define bikgk10 .c `"nicht zuzuordnen"', modify
label define polgk 1 `"unter 2.000 Einw."', modify
label define polgk 2 `"2.000 bis unter 5.000 Einw."', modify
label define polgk 3 `"5.000 bis unter 20.000 Einw."', modify
label define polgk 4 `"20.000 bis unter 50.000 Einw."', modify
label define polgk 5 `"50.000 bis unter 100.000 Einw."', modify
label define polgk 6 `"100.000 bis unter 500.000 Einw."', modify
label define polgk 7 `"500.000 und mehr Einw."', modify
label define polgk .c `"nicht zuzuordnen"', modify
label define bland 1 `"Schleswig-Holstein"', modify
label define bland 2 `"Hamburg"', modify
label define bland 3 `"Niedersachsen"', modify
label define bland 4 `"Bremen"', modify
label define bland 5 `"Nordrhein-Westfalen"', modify
label define bland 6 `"Hessen"', modify
label define bland 7 `"Rheinland-Pfalz"', modify
label define bland 8 `"Baden-Württemberg"', modify
label define bland 9 `"Bayern"', modify
label define bland 10 `"Saarland"', modify
label define bland 11 `"Berlin"', modify
label define bland 12 `"Brandenburg"', modify
label define bland 13 `"Mecklenburg-Vorpommern"', modify
label define bland 14 `"Sachsen"', modify
label define bland 15 `"Sachsen-Anhalt"', modify
label define bland 16 `"Thüringen"', modify
label define s02_1 0 `"nicht genannt"', modify
label define s02_1 1 `"genannt"', modify
label define s02_1 602 `"Person mit normalem Stichtag"', modify
label define s02_1 607 `"Person ohne Info zur Normalität des Stichtags"', modify
label define s01 1 `"ja, normaler Tag"', modify
label define s01 2 `"nein, kein normaler Tag"', modify
label define s01 .f `"verweigert"', modify
label define s01 .g `"weiß nicht"', modify
label define s04 1 `"ja, ständig"', modify
label define s04 2 `"ja, teilweise"', modify
label define s04 3 `"nein, gar nicht"', modify
label define s04 .f `"verweigert"', modify
label define s04 .g `"weiß nicht"', modify
label define s04 .m `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"', modify
label define s04 .v `"Kind 10-13 J. (Selbst) mit Wegeprotokoll"', modify
label define s04 .n `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define s04 .o `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define s04 .w `"Ki. 10-13 J. (Selbst) o. Wegeprot. (StTag <= 3 Tage/ Ausl.)"', modify
label define s04 .x `"Kind 10-13 J. (Selbst) o. Wegeprot. (StTag > 3 Tage)"', modify
label define s04 .y `"Personen unter 15 J."', modify
label define s03 1 `"sonnig"', modify
label define s03 2 `"leicht bewölkt, heiter"', modify
label define s03 3 `"stark bewölkt"', modify
label define s03 4 `"regnerisch"', modify
label define s03 5 `"es hat geschneit"', modify
label define s03 .f `"verweigert"', modify
label define s03 .g `"weiß nicht"', modify
label define s03 .n `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define s03 .o `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define hp_pkwfs 1 `"ja"', modify
label define hp_pkwfs 2 `"nein"', modify
label define hp_pkwfs .f `"verweigert"', modify
label define hp_pkwfs .g `"weiß nicht"', modify
label define hp_pkwfs .a `"keine Angabe"', modify
label define hp_besch 1 `"Berufstätige(r) - Vollzeit"', modify
label define hp_besch 2 `"Berufstätige(r) - Teilzeit (11 bis unter 35 Stunden/ Woche)"', modify
label define hp_besch 3 `"Berufstätige(r) ohne Angabe zum Umfang"', modify
label define hp_besch 4 `"Auszubildende(r)"', modify
label define hp_besch 5 `"Schüler(in) (einschließlich Vorschule)"', modify
label define hp_besch 6 `"Student(in)"', modify
label define hp_besch 7 `"Kind zu Hause betreut"', modify
label define hp_besch 8 `"Kind betreut im Kindergarten, Krippe, Tagesmutter etc."', modify
label define hp_besch 9 `"zurzeit arbeitslos"', modify
label define hp_besch 10 `"vorübergeh. freigest. (z.B. Mutterschaftsurl., Elternzeit)"', modify
label define hp_besch 11 `"Hausfrau | Hausmann"', modify
label define hp_besch 12 `"Rentner(in) | Pensionär(in)"', modify
label define hp_besch 13 `"Wehr- oder Zivildienstleistende(r), Freiwilligendienst"', modify
label define hp_besch 14 `"andere Tätigkeit"', modify
label define hp_besch .a `"keine Angabe"', modify
label define hp_alter .e `"unplausibler Wert"', modify
label define hp_alter .f `"verweigert"', modify
label define hp_alter .g `"weiß nicht"', modify
label define hp_alter .a `"keine Angabe"', modify
label define hp_sex 1 `"männlich"', modify
label define hp_sex 2 `"weiblich"', modify
label define hp_sex .f `"verweigert"', modify
label define hp_sex .g `"weiß nicht"', modify
label define hp_sex .a `"keine Angabe"', modify
label define hheink 1 `"bis unter 500 Euro"', modify
label define hheink 2 `"500 Euro bis unter 900 Euro"', modify
label define hheink 3 `"900 Euro bis unter 1.500 Euro"', modify
label define hheink 4 `"1.500 Euro bis unter 2.000 Euro"', modify
label define hheink 5 `"2.000 Euro bis unter 2.600 Euro"', modify
label define hheink 6 `"2.600 Euro bis unter 3.000 Euro"', modify
label define hheink 7 `"3.000 Euro bis unter 3.600 Euro"', modify
label define hheink 8 `"3.600 Euro bis unter 4.000 Euro"', modify
label define hheink 9 `"4.000 Euro bis unter 4.600 Euro"', modify
label define hheink 10 `"4.600 Euro bis unter 5.000 Euro"', modify
label define hheink 11 `"5.000 Euro bis unter 5.600 Euro"', modify
label define hheink 12 `"5.600 Euro bis unter 6.000 Euro"', modify
label define hheink 13 `"6.000 Euro bis unter 6.600 Euro"', modify
label define hheink 14 `"6.600 Euro bis 7.000 Euro"', modify
label define hheink 15 `"mehr als 7.000 Euro"', modify
label define hheink .f `"verweigert"', modify
label define hheink .g `"weiß nicht"', modify
label define hheink .a `"keine Angabe"', modify
label define w074 1 `"Erreichen des Arbeitsplatzes"', modify
label define w074 2 `"dienstlich oder geschäftlich"', modify
label define w074 3 `"Erreichen der Ausbildungsstätte oder Schule"', modify
label define w074 4 `"Einkauf"', modify
label define w074 5 `"private Erledigungen"', modify
label define w074 7 `"Freizeitaktivität"', modify
label define w074 10 `"andere Aktivität"', modify
label define w074 .f `"verweigert"', modify
label define w074 .g `"weiß nicht"', modify
label define w074 .m `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"', modify
label define w074 .n `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define w074 .o `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define w074 .p `"1-Personen-Haushalt"', modify
label define w074 .i `"bei rbW nicht erhoben"', modify
label define w074 .q `"kein Weg mit Zweck Bringen und Holen von Personen"', modify
label define w074 .r `"Person ohne Begleitung unterwegs"', modify
label define w074 .s `"keine Info, ob Begleiter aus HH"', modify
label define w074 .t `"Begleiter aus HH"', modify
label define w073 1 `" Person 1"', modify
label define w073 2 `" Person 2"', modify
label define w073 3 `" Person 3"', modify
label define w073 4 `" Person 4"', modify
label define w073 5 `" Person 5"', modify
label define w073 6 `" Person 6"', modify
label define w073 7 `" Person 7"', modify
label define w073 9 `"andere Person aus dem HH"', modify
label define w073 .f `"verweigert"', modify
label define w073 .g `"weiß nicht"', modify
label define w073 .v `"Kind 10-13 J. (Selbst) mit Wegeprotokoll"', modify
label define w073 .n `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define w073 .o `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define w073 .w `"Ki. 10-13 J. (Selbst) o. Wegeprot. (StTag <= 3 Tage/ Ausl.)"', modify
label define w073 .p `"1-Personen-Haushalt"', modify
label define w073 .i `"bei rbW nicht erhoben"', modify
label define w073 .u `"Weg nicht mit Motorrad, Auto oder Lkw zurückgelegt"', modify
label define w073 .r `"Person ohne Begleitung unterwegs"', modify
label define w073 .s `"keine Info, ob Begleiter aus HH"', modify
label define w073 .x `"Fahrer unterschiedlich"', modify
label define w072_1 0 `"nicht genannt"', modify
label define w072_1 1 `"genannt"', modify
label define w072_1 .p `"1-Personen-Haushalt"', modify
label define w072_1 .i `"bei rbW nicht erhoben"', modify
label define w072_1 .r `"Person ohne Begleitung unterwegs"', modify
label define w072_1 .v `"Begleiter nicht aus HH"', modify
label define w072_1 .s `"keine Info, ob Begleiter aus HH"', modify
label define w071 1 `"ja"', modify
label define w071 2 `"nein"', modify
label define w071 .f `"verweigert"', modify
label define w071 .g `"weiß nicht"', modify
label define w071 .p `"1-Personen-Haushalt"', modify
label define w071 .i `"bei rbW nicht erhoben"', modify
label define w071 .r `"Person ohne Begleitung unterwegs"', modify
label define w062 1 `"ja"', modify
label define w062 2 `"nein"', modify
label define w062 .f `"verweigert"', modify
label define w062 .g `"weiß nicht"', modify
label define w062 .i `"bei rbW nicht erhoben"', modify
label define w062 0 `"HH ohne Auto"', modify
label define w062 .p `"HH mit mehr als 4 Autos"', modify
label define w062 .q `"Weg ohne Autonutzung"', modify
label define w061 1 `"Fahrer"', modify
label define w061 2 `"Mitfahrer"', modify
label define w061 3 `"unterschiedlich"', modify
label define w061 .f `"verweigert"', modify
label define w061 .g `"weiß nicht"', modify
label define w061 .a `"keine Angabe"', modify
label define w061 .v `"Kind 10-13 J. (Selbst) mit Wegeprotokoll"', modify
label define w061 .n `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define w061 .o `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define w061 .w `"Ki. 10-13 J. (Selbst) o. Wegeprot. (StTag <= 3 Tage/ Ausl.)"', modify
label define w061 .i `"bei rbW nicht erhoben"', modify
label define w061 .u `"Weg nicht mit Motorrad, Auto oder Lkw zurückgelegt"', modify
label define hvm_oev 1 `"zu Fuß"', modify
label define hvm_oev 2 `"Fahrrad"', modify
label define hvm_oev 3 `"MIV (Mitfahrer)"', modify
label define hvm_oev 4 `"MIV (Fahrer)"', modify
label define hvm_oev 5 `"ÖPNV"', modify
label define hvm_oev 6 `"ÖPFV"', modify
label define hvm_oev .a `"keine Angabe"', modify
label define hvm 1 `"zu Fuß"', modify
label define hvm 2 `"Fahrrad"', modify
label define hvm 3 `"MIV (Mitfahrer)"', modify
label define hvm 4 `"MIV (Fahrer)"', modify
label define hvm 5 `"ÖPV"', modify
label define hvm .a `"keine Angabe"', modify
label define vm_kombi 1 `"zu Fuß"', modify
label define vm_kombi 2 `"Fahrrad"', modify
label define vm_kombi 3 `"Fahrrad und ÖV"', modify
label define vm_kombi 4 `"nur ÖV"', modify
label define vm_kombi 5 `"MIV (Mitfahrer) und ÖV"', modify
label define vm_kombi 6 `"MIV (Fahrer) und ÖV"', modify
label define vm_kombi 7 `"nur MIV (Mitfahrer)"', modify
label define vm_kombi 8 `"nur MIV (Fahrer)"', modify
label define vm_kombi 9 `"anderes"', modify
label define hvm_diff 1 `"zu Fuß"', modify
label define hvm_diff 2 `"Fahrrad"', modify
label define hvm_diff 3 `"Mofa | Moped"', modify
label define hvm_diff 4 `"Motorrad"', modify
label define hvm_diff 5 `"Pkw (Mitfahrer)"', modify
label define hvm_diff 6 `"Pkw (Fahrer)"', modify
label define hvm_diff 7 `"Lkw"', modify
label define hvm_diff 8 `"ÖPNV"', modify
label define hvm_diff 9 `"Taxi"', modify
label define hvm_diff 10 `"Schiff | Bahn | Bus | Flugzeug"', modify
label define hvm_diff 11 `"sonstiges"', modify
label define hvm_diff .a `"keine Angabe"', modify
label define lkw_mf 0 `"nicht genannt"', modify
label define lkw_mf 1 `"genannt"', modify
label define lkw_mf .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define lkw_mf .x `"Weg nicht mit Lkw"', modify
label define lkw_f 0 `"nicht genannt"', modify
label define lkw_f 1 `"genannt"', modify
label define lkw_f .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define lkw_f .x `"Weg nicht mit Lkw"', modify
label define pkw_mf 0 `"nicht genannt"', modify
label define pkw_mf 1 `"genannt"', modify
label define pkw_mf .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define pkw_mf .y `"Weg nicht mit Pkw"', modify
label define pkw_f 0 `"nicht genannt"', modify
label define pkw_f 1 `"genannt"', modify
label define pkw_f .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define pkw_f .y `"Weg nicht mit Pkw"', modify
label define mrad_mf 0 `"nicht genannt"', modify
label define mrad_mf 1 `"genannt"', modify
label define mrad_mf .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define mrad_mf .z `"Weg nicht mit Motorrad"', modify
label define mrad_f 0 `"nicht genannt"', modify
label define mrad_f 1 `"genannt"', modify
label define mrad_f .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define mrad_f .z `"Weg nicht mit Motorrad"', modify
label define w05_1 0 `"nicht genannt"', modify
label define w05_1 1 `"genannt"', modify
label define w044 1 `"innerhalb der näheren Umgebung"', modify
label define w044 2 `"Zentrum innerhalb dieser Stadt oder diesem Ort"', modify
label define w044 3 `"EKZ am Stadt- oder Ortsrand, auf der grünen Wiese"', modify
label define w044 4 `"anderes Ziel"', modify
label define w044 .f `"verweigert"', modify
label define w044 .g `"weiß nicht"', modify
label define w044 .a `"keine Angabe"', modify
label define w044 .i `"bei rbW nicht erhoben"', modify
label define w044 .r `"kein Weg mit Detailzweck 501-505 u. 601-602 (s. Variable dzc"', modify
label define w044 .s `"kein Einkaufs-, Erledigungs-, Freizeitweg"', modify
label define w13 1 `"zu Hause"', modify
label define w13 2 `"Arbeitsplatz"', modify
label define w13 3 `"anderes Ziel innerhalb der Stadt oder des Ortes"', modify
label define w13 4 `"anderes Ziel außerhalb der Stadt oder des Ortes"', modify
label define w13 5 `"Rundweg"', modify
label define w13 .f `"verweigert"', modify
label define w13 .g `"weiß nicht"', modify
label define w13 .a `"keine Angabe"', modify
label define w13 .i `"bei rbW nicht erhoben"', modify
label define w13 .v `"bei Rückweg nicht erhoben"', modify
label define w13 .t `"bei Zweck Kita | Kindergarten nicht erhoben"', modify
label define w01 1 `"zu Hause"', modify
label define w01 2 `"Arbeitsplatz"', modify
label define w01 3 `"woanders innerhalb des Ortes"', modify
label define w01 4 `"woanders außerhalb"', modify
label define w01 .f `"verweigert"', modify
label define w01 .g `"weiß nicht"', modify
label define w01 .a `"keine Angabe"', modify
label define w01 .i `"bei rbW nicht erhoben"', modify
label define w01 .u `"ab zweitem Weg nicht erhoben"', modify
label define w01 303 `"erfasster erster Weg ist Rückweg"', modify
label define w04_dzw 11 `"Begleitung Erwachsener"', modify
label define w04_dzw 501 `" täglicher Bedarf (z.B. Lebensmittel, Tanken etc.)"', modify
label define w04_dzw 502 `"sonstige Waren (z.B. Kleidung, Möbel, Hausrat etc.)"', modify
label define w04_dzw 503 `"allgemeiner Einkaufsbummel"', modify
label define w04_dzw 504 `"Dienstleistungen (z.B. Friseur, Schuster etc.)"', modify
label define w04_dzw 505 `"sonstiger Einkaufszweck"', modify
label define w04_dzw 599 `"Einkäufe, kein Angabe zum Detail"', modify
label define w04_dzw 601 `"Arztbesuch"', modify
label define w04_dzw 602 `"Behörde, Bank, Post, Geldautomat"', modify
label define w04_dzw 603 `"private Erledigung für andere Person (unentgeltlich)"', modify
label define w04_dzw 604 `"sonstiger privater Erledigungszweck"', modify
label define w04_dzw 605 `"Betreuung anderer Personen"', modify
label define w04_dzw 699 `"Erledigung, kein Angabe zum Detail"', modify
label define w04_dzw 701 `"Besuch oder Treffen mit|von Freunden, Verwandten, Bekannten"', modify
label define w04_dzw 702 `"Besuch kultureller Einrichtung (z.B. Kino, Theater, Museum)"', modify
label define w04_dzw 703 `"Besuch einer Veranstaltung (z.B. Fußballspiel, Markt)"', modify
label define w04_dzw 704 `"Sport (selbst aktiv), Sportverein"', modify
label define w04_dzw 705 `"Weiterbildung (z.B. Sprachkurs, Volkshochschule, Nachhilfe)"', modify
label define w04_dzw 706 `"Restaurant, Gaststätte, Mittagessen etc."', modify
label define w04_dzw 707 `"Schrebergarten, Wochenendhaus"', modify
label define w04_dzw 708 `"Tagesausflug, mehrtägiger Ausflug (bis 4 Tage)"', modify
label define w04_dzw 709 `"Urlaub (ab 5 Tage)"', modify
label define w04_dzw 710 `"Spaziergang, Spazierfahrt"', modify
label define w04_dzw 711 `"Hund ausführen"', modify
label define w04_dzw 712 `"Laufen, Joggen, Inlineskating, Nordic Walking etc."', modify
label define w04_dzw 713 `"Kirche, Friedhof"', modify
label define w04_dzw 714 `"Ehrenamt, Verein, politische Aktivitäten"', modify
label define w04_dzw 715 `"Jobben in der Freizeit gegen Entgelt"', modify
label define w04_dzw 716 `"Begleitung von Kindern (Spielplatz etc.)"', modify
label define w04_dzw 717 `"Hobby (z.B. Musizieren)"', modify
label define w04_dzw 718 `"Jugendfreizeitheim etc."', modify
label define w04_dzw 719 `"Spielplatz, Spielen auf der Straße etc."', modify
label define w04_dzw 720 `"sonstiger Freizeitzweck"', modify
label define w04_dzw 799 `"Freizeit, kein Angabe zum Detail"', modify
label define w04_dzw .f `"verweigert"', modify
label define w04_dzw .g `"weiß nicht"', modify
label define w04_dzw .a `"keine Angabe"', modify
label define w04_dzw .s `"kein Einkaufs-, Erledigungs-, Freizeitweg"', modify
label define w04 1 `"Erreichen des Arbeitsplatzes"', modify
label define w04 2 `"dienstlich oder geschäftlich"', modify
label define w04 3 `"Erreichen der Ausbildungsstätte oder Schule"', modify
label define w04 4 `"Einkauf"', modify
label define w04 5 `"private Erledigungen"', modify
label define w04 6 `"Bringen oder Holen von Personen"', modify
label define w04 7 `"Freizeitaktivität"', modify
label define w04 8 `"nach Hause"', modify
label define w04 9 `"Rückweg vom vorherigen Weg"', modify
label define w04 10 `"andere Aktivität"', modify
label define w04 11 `"Begleitung Erwachsener"', modify
label define w04 31 `"zur  Schule oder Vorschule"', modify
label define w04 32 `"Kindertagesstätte oder Kindergarten"', modify
label define w04 .f `"verweigert"', modify
label define w04 .g `"weiß nicht"', modify
label define en_min .i `"bei rbW nicht erhoben"', modify
label define en_std .i `"bei rbW nicht erhoben"', modify
label define en_time .i `"bei rbW nicht erhoben"', modify
label define st_min .i `"bei rbW nicht erhoben"', modify
label define st_std .i `"bei rbW nicht erhoben"', modify
label define st_time .i `"bei rbW nicht erhoben"', modify
label define stichtag 1 `"Montag"', modify
label define stichtag 2 `"Dienstag"', modify
label define stichtag 3 `"Mittwoch"', modify
label define stichtag 4 `"Donnerstag"', modify
label define stichtag 5 `"Freitag"', modify
label define stichtag 6 `"Samstag"', modify
label define stichtag 7 `"Sonntag"', modify
label define wsource 0 `"von Person direkt erfasster Weg"', modify
label define wsource 1 `"regelmäßiger beruflicher Weg"', modify
label define int_typ9 1 `"Erwachsener > 13 J. (Selbst) mit Wegeprotokoll"', modify
label define int_typ9 2 `"Erwachsener > 13 J. (Proxy) mit Wegeprotokoll"', modify
label define int_typ9 3 `"Kind 10-13 J. (Selbst) mit Wegeprotokoll"', modify
label define int_typ9 4 `"Kind 10-13 J. (Proxy) mit Wegeprotokoll"', modify
label define int_typ9 5 `"Kind <10 J. (Proxy) mit Wegeprotokoll"', modify
label define int_typ9 6 `"Erw. >13 J. (Selbst) o. Wegeprot. (StTag <= 3 Tage/ Ausl.)"', modify
label define int_typ9 7 `"Ki. 10-13 J. (Selbst) o. Wegeprot. (StTag <= 3 Tage/ Ausl.)"', modify
label define int_typ9 8 `"Erwachsener > 13 J. (Selbst) o. Wegeprot. (StTag > 3 Tage)"', modify
label define int_typ9 9 `"Kind 10-13 J. (Selbst) o. Wegeprot. (StTag > 3 Tage)"', modify


recode sgtyp (99=.c)
recode ktyp_zsg (99=.c)
recode ktyp (99=.c)
recode rtypd7 (99=.c)
recode rtyp (99=.c)
recode co2weg (995=.h)
recode pergrup1 (95=.c)
recode pergrup (95=.c)
recode gesein (102=.m) (3=.f)
recode p070 (98=.g) (109=.x) (97=.f) (102=.m) (103=.v) (105=.o) (107=.w) (104=.n) (96=.u)
recode anzpers (98=.g) (94=.e) (97=.f) (301=.i)
recode w07 (98=.g) (94=.e) (97=.f) (301=.i)
recode hhtyp (91=.n) (90=.k) (92=.c)
recode hp_altg3 (999=.a)
recode hp_altg2 (999=.a)
recode hp_altg1 (999=.a)
recode ov_seg (95=.b)
recode h02 (99=.a) (98=.g) (97=.f)
recode oek_stat (9=.c)
recode tempo (9995=.h) (9994=.e) (3301=.i)
recode hwzweck (99=.a)
recode wegmin_k (9994=.e) (3301=.i)
recode wegkm_k (9998=.g) (9994=.e) (9997=.f)
recode w063 (7=.f) (301=.i) (406=.p) (401=0) (8=.g) (502=.q) (503=.r)
recode st_stdg (301=.i)
* recode bikgk10 (99=.c)
recode polgk (99=.c)
recode s01 (8=.g) (7=.f)
recode s04 (109=.x) (111=.y) (7=.f) (103=.v) (102=.m) (8=.g) (107=.w) (104=.n) (105=.o)
recode s03 (8=.g) (104=.n) (7=.f) (105=.o)
recode hp_pkwfs (9=.a) (8=.g) (7=.f)
recode hp_besch (99=.a)
recode hp_alter (994=.e) (997=.f) (999=.a) (998=.g)
recode hp_sex (9=.a) (8=.g) (7=.f)
recode hheink (99=.a) (98=.g) (97=.f)
recode w074 (201=.p) (309=.q) (607=.t) (601=.r) (603=.s) (301=.i) (98=.g) (97=.f) (102=.m) (104=.n) (105=.o)
recode w073 (201=.p) (604=.w) (605=.x) (601=.r) (603=.s) (602=.v) (301=.i) (98=.g) (97=.f) (103=.v) (501=.u) (107=.w) (104=.n) (105=.o)
recode w072_1 (201=.p) (301=.i) (601=.r) (603=.s) (602=.v)
recode w071 (201=.p) (8=.g) (601=.r) (7=.f) (301=.i)
recode w062 (7=.f) (301=.i) (406=.p) (401=0) (8=.g) (502=.q)
recode w061 (301=.i) (7=.f) (103=.v) (9=.a) (8=.g) (501=.u) (107=.w) (104=.n) (105=.o)
recode hvm_oev (97=.a)
recode hvm (97=.a)
recode hvm_diff (97=.a)
recode lkw_mf (301=.j) (501=.x)
recode lkw_f (301=.j) (501=.x)
recode pkw_mf (301=.j) (501=.y)
recode pkw_f (301=.j) (501=.y)
recode mrad_mf (301=.j) (501=.z)
recode mrad_f (301=.j) (501=.z)
recode w044 (301=.i) (306=.r) (307=.s) (7=.f) (9=.a) (8=.g)
recode w13 (301=.i) (304=.v) (305=.t) (7=.f) (9=.a) (8=.g)
recode w01 (9=.a) (8=.g) (302=.u) (7=.f) (301=.i)
recode w04_dzw (3307=.s) (997=.f) (999=.a) (998=.g)
recode w04 (98=.g) (97=.f)
recode en_min (301=.i)
recode en_std (301=.i)
recode en_time (1083600=.i)
recode st_min (301=.i)
recode st_std (301=.i)
recode st_time (1083600=.i)
