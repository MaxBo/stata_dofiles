* Do-File zur Generierung von Wegeketten
* Grobes Modell zur Bestimmung von vereinfachten Wegeaktivitäten, Wegepaaren und allgemeine und heimbasierte Ketten
* Eingangsdaten - MiD des jeweiligen Jahres

clear
set memory 32m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_zeitn5.dta", clear
rename W08 WEGKM_K

* rename differenzierte Wegezwecke umbenennen
gen W04_DZW = 11 if DIWZW3 ==  11 | DIWZW2 ==  506 | DIWZW1 ==  506
replace W04_DZW = 501 if DIWZW3 ==  501 | DIWZW2 ==  501 | DIWZW1 ==  501
replace W04_DZW = 502 if DIWZW3 ==  502 | DIWZW2 ==  502 | DIWZW1 ==  502
replace W04_DZW = 503 if DIWZW3 ==  503 | DIWZW2 ==  503 | DIWZW1 ==  503
replace W04_DZW = 504 if DIWZW3 ==  504 | DIWZW2 ==  504 | DIWZW1 ==  504
replace W04_DZW = 505 if DIWZW3 ==  505 | DIWZW2 ==  505 | DIWZW1 ==  505
* replace W04_DZW = .a if DIWZW3 ==  .t | DIWZW2 ==  .t | DIWZW1 ==  .t
replace W04_DZW = 601 if DIWZW3 ==  601 | DIWZW2 ==  601 | DIWZW1 ==  601
replace W04_DZW = 602 if DIWZW3 ==  602 | DIWZW2 ==  602 | DIWZW1 ==  602
replace W04_DZW = 603 if DIWZW3 ==  603 | DIWZW2 ==  603 | DIWZW1 ==  603
replace W04_DZW = 604 if DIWZW3 ==  604 | DIWZW2 ==  604 | DIWZW1 ==  604
replace W04_DZW = 605 if DIWZW3 ==  605 | DIWZW2 ==  605 | DIWZW1 ==  605
* replace W04_DZW = .a if DIWZW3 ==  .u | DIWZW2 ==  .u | DIWZW1 ==  .u
replace W04_DZW = 701 if DIWZW3 ==  701 | DIWZW2 ==  701 | DIWZW1 ==  701
replace W04_DZW = 702 if DIWZW3 ==  702 | DIWZW2 ==  702 | DIWZW1 ==  702
replace W04_DZW = 703 if DIWZW3 ==  703 | DIWZW2 ==  703 | DIWZW1 ==  703
replace W04_DZW = 704 if DIWZW3 ==  704 | DIWZW2 ==  704 | DIWZW1 ==  704
replace W04_DZW = 705 if DIWZW3 ==  705 | DIWZW2 ==  705 | DIWZW1 ==  705
replace W04_DZW = 706 if DIWZW3 ==  706 | DIWZW2 ==  706 | DIWZW1 ==  706
replace W04_DZW = 707 if DIWZW3 ==  707 | DIWZW2 ==  707 | DIWZW1 ==  707
replace W04_DZW = 708 if DIWZW3 ==  708 | DIWZW2 ==  708 | DIWZW1 ==  708
replace W04_DZW = 709 if DIWZW3 ==  709 | DIWZW2 ==  709 | DIWZW1 ==  709
replace W04_DZW = 710 if DIWZW3 ==  710 | DIWZW2 ==  710 | DIWZW1 ==  710
replace W04_DZW = 711 if DIWZW3 ==  711 | DIWZW2 ==  711 | DIWZW1 ==  711
replace W04_DZW = 712 if DIWZW3 ==  712 | DIWZW2 ==  712 | DIWZW1 ==  712
replace W04_DZW = 713 if DIWZW3 ==  713 | DIWZW2 ==  713 | DIWZW1 ==  713
replace W04_DZW = 714 if DIWZW3 ==  714 | DIWZW2 ==  714 | DIWZW1 ==  714
replace W04_DZW = 715 if DIWZW3 ==  715 | DIWZW2 ==  715 | DIWZW1 ==  715
replace W04_DZW = 716 if DIWZW3 ==  716 | DIWZW2 ==  716 | DIWZW1 ==  716
replace W04_DZW = 717 if DIWZW3 ==  717 | DIWZW2 ==  717 | DIWZW1 ==  717
replace W04_DZW = 718 if DIWZW3 ==  718 | DIWZW2 ==  718 | DIWZW1 ==  718
replace W04_DZW = 719 if DIWZW3 ==  719 | DIWZW2 ==  719 | DIWZW1 ==  719
replace W04_DZW = 720 if DIWZW3 ==  720 | DIWZW2 ==  720 | DIWZW1 ==  720
replace W04_DZW = .a if missing(W04_DZW) & (W04 !=4 | W04 !=5 | W04 !=7)
* replace W04_DZW = .f if DIWZW3 ==  .f | DIWZW2 ==  .f | DIWZW1 ==  .f
* replace W04_DZW = .g if DIWZW3 ==  .g | DIWZW2 ==  .g | DIWZW1 ==  .g
* replace W04_DZW = .s if DIWZW3 ==  .s | DIWZW2 ==  .s | DIWZW1 ==  .s


label define W04_DZW 11 `" Begleitung Erwachsener, "', modify
label define W04_DZW 501 `"  täglicher Bedarf (z.B. Lebensmittel, Tanken etc.), "', modify
label define W04_DZW 502 `" sonstige Waren (z.B. Kleidung, Möbel, Hausrat etc.), "', modify
label define W04_DZW 503 `" allgemeiner Einkaufsbummel, "', modify
label define W04_DZW 504 `" Dienstleistungen (z.B. Friseur, Schuster etc.), "', modify
label define W04_DZW 505 `" sonstiger Einkaufszweck, "', modify
label define W04_DZW 601 `" Arztbesuch, "', modify
label define W04_DZW 602 `" Behörde, Bank, Post, Geldautomat, "', modify
label define W04_DZW 603 `" private Erledigung für andere Person (unentgeltlich), "', modify
label define W04_DZW 604 `" sonstiger privater Erledigungszweck, "', modify
label define W04_DZW 605 `" Betreuung anderer Personen, "', modify
label define W04_DZW 701 `" Besuch oder Treffen mit|von Freunden, Verwandten, Bekannten, "', modify
label define W04_DZW 702 `" Besuch kultureller Einrichtung (z.B. Kino, Theater, Museum), "', modify
label define W04_DZW 703 `" Besuch einer Veranstaltung (z.B. Fußballspiel, Markt), "', modify
label define W04_DZW 704 `" Sport (selbst aktiv), Sportverein, "', modify
label define W04_DZW 705 `" Weiterbildung (z.B. Sprachkurs, Volkshochschule, Nachhilfe), "', modify
label define W04_DZW 706 `" Restaurant, Gaststätte, Mittagessen etc., "', modify
label define W04_DZW 707 `" Schrebergarten, Wochenendhaus, "', modify
label define W04_DZW 708 `" Tagesausflug, mehrtägiger Ausflug (bis 4 Tage), "', modify
label define W04_DZW 709 `" Urlaub (ab 5 Tage), "', modify
label define W04_DZW 710 `" Spaziergang, Spazierfahrt, "', modify
label define W04_DZW 711 `" Hund ausführen, "', modify
label define W04_DZW 712 `" Laufen, Joggen, Inlineskating, Nordic Walking etc., "', modify
label define W04_DZW 713 `" Kirche, Friedhof, "', modify
label define W04_DZW 714 `" Ehrenamt, Verein, politische Aktivitäten, "', modify
label define W04_DZW 715 `" Jobben in der Freizeit gegen Entgelt, "', modify
label define W04_DZW 716 `" Begleitung von Kindern (Spielplatz etc.), "', modify
label define W04_DZW 717 `" Hobby (z.B. Musizieren), "', modify
label define W04_DZW 718 `" Jugendfreizeitheim etc., "', modify
label define W04_DZW 719 `" Spielplatz, Spielen auf der Straße etc., "', modify
label define W04_DZW 720 `" sonstiger Freizeitzweck, "', modify
label define W04_DZW .f `" verweigert, "', modify
label define W04_DZW .g `" weiß nicht, "', modify
label define W04_DZW .a `" keine Angabe, "', modify
label define W04_DZW .s `" kein Einkaufs-, Erledigungs-, Freizeitweg"', modify
 
label value W04_DZW W04_DZW
label var W04_DZW "detaillierter Wegezweck"
 
* Sortierung für Datenanalyse
sort  HHID PID WSIDN

* Zweck generieren Hilfsvariablen: 
* Wegzweck (W04) Spezifikation (W041) Quelle (W01) Ziel (W13)

bysort HHID PID: gen Zweck = "Arbeit" if W04 == 1 | W13 == 2
bysort HHID PID: replace Zweck = "dienstlich per" if WSID > 100
bysort HHID PID: replace Zweck = "dienstlich aper" if W04 == 2 & WSID < 100
bysort HHID PID: replace Zweck = "Bilden" if W04 == 3 | W04 == 31
bysort HHID PID: replace Zweck = "Kindergarten" if W04 == 32 | W04 == 31
bysort HHID PID: replace Zweck = "Rundweg" if (W01 == 1 & W13 == 1) | W13 == 5
bysort HHID PID: replace Zweck = "Wohnen" if W04 == 8 
bysort HHID PID: replace Zweck = "Einkauf periodisch" if W04 == 4 & W04_DZW == 501
bysort HHID PID: replace Zweck = "Einkauf aperiodisch" if W04 == 4 & W04_DZW != 501


bysort HHID PID: replace Zweck = "Sonstige" if (W04 > 4 & W04 < 8)| (W04 >9 & W04 < 30)| W04 == .a| W04 == .g 
bysort HHID PID: replace Zweck = "Rückweg" if  W04 == 9

label var Zweck "ausgeführte Zielaktivität"


* Wegepaare generieren:
bysort HHID PID:gen wegpaar = Zweck[_n-1]+" - "+Zweck[_n]
bysort HHID PID:replace wegpaar = "Wohnen"+" - "+Zweck[_n] if W01 == 1  | (WSIDN[_n]==1 & W01 == -39)
bysort HHID PID: replace wegpaar = "Sonstiges"+" - "+Zweck[_n] if WSIDN[_n]==1 & W01 == 2
label var wegpaar "Aktivitätenpaare aus Hauptzwecken"

* Wegekette generieren:
bysort HHID PID: gen wegekette = wegpaar[_n] if _n==1
bysort HHID PID: replace wegekette = wegekette[_n-1]+" ; "+ wegpaar[_n] if _n>1
label var wegekette "Aktivitätenkette über den gesamten Tagesverlauf"

* Wegeketten generieren mit Wohnen als Heimbasis
bysort HHID PID: gen wegekette_home = wegpaar[_n] if _n==1 | Zweck[_n-1] == "Wohnen"
bysort HHID PID: replace wegekette_home = wegekette_home[_n-1]+" ; "+ wegpaar[_n] if _n>1 & missing(wegekette_home)
label var wegekette_home "heimbasierte Aktivitätenkette"

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2006\MiD_2006_Wege_zeitn5_akt.dta", replace

