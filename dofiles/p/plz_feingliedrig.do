clear
set memory 700m

insheet using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\PLZ_HH_kleinräumig.txt"

tostring plz, gen (f3a)
rename stadtt STADTT
rename bezirk_hh Bezirke_HH


gen Stadtteil_HH = 0
replace Stadtteil_HH = 102 if STADTT == "Billstedt"
replace Stadtteil_HH = 103 if STADTT == "Borgfelde"
replace Stadtteil_HH = 104 if STADTT == "Finkenwerder"
replace Stadtteil_HH = 108 if STADTT == "Hamm-Mitte"
replace Stadtteil_HH = 109 if STADTT == "Hamm-Nord"
replace Stadtteil_HH = 110 if STADTT == "Hamm-Süd"
replace Stadtteil_HH = 111 if STADTT == "Hammerbrook"
replace Stadtteil_HH = 112 if STADTT == "Horn"
replace Stadtteil_HH = 114 if STADTT == "Neustadt"
replace Stadtteil_HH = 115 if STADTT == "Rothenburgsort"
replace Stadtteil_HH = 116 if STADTT == "St. Georg"
replace Stadtteil_HH = 117 if STADTT == "St. Pauli"
replace Stadtteil_HH = 119 if STADTT == "Veddel"
replace Stadtteil_HH = 121 if STADTT == "Wilhelmsburg"
replace Stadtteil_HH = 201 if STADTT == "Altona-Altstadt"
replace Stadtteil_HH = 202 if STADTT == "Altona-Nord"
replace Stadtteil_HH = 203 if STADTT == "Bahrenfeld"
replace Stadtteil_HH = 204 if STADTT == "Blankenese"
replace Stadtteil_HH = 205 if STADTT == "Groß Flottbek"
replace Stadtteil_HH = 206 if STADTT == "Iserbrook"
replace Stadtteil_HH = 207 if STADTT == "Lurup"
replace Stadtteil_HH = 208 if STADTT == "Nienstedten"
replace Stadtteil_HH = 209 if STADTT == "Osdorf"
replace Stadtteil_HH = 210 if STADTT == "Othmarschen"
replace Stadtteil_HH = 211 if STADTT == "Ottensen"
replace Stadtteil_HH = 212 if STADTT == "Rissen"
replace Stadtteil_HH = 213 if STADTT == "Sternschanze"
replace Stadtteil_HH = 214 if STADTT == "Sülldorf"
replace Stadtteil_HH = 301 if STADTT == "Eidelstedt"
replace Stadtteil_HH = 302 if STADTT == "Eimsbüttel"
replace Stadtteil_HH = 303 if STADTT == "Harvestehude"
replace Stadtteil_HH = 304 if STADTT == "Hoheluft-West"
replace Stadtteil_HH = 305 if STADTT == "Lokstedt"
replace Stadtteil_HH = 306 if STADTT == "Niendorf"
replace Stadtteil_HH = 307 if STADTT == "Rotherbaum"
replace Stadtteil_HH = 308 if STADTT == "Schnelsen"
replace Stadtteil_HH = 309 if STADTT == "Stellingen"
replace Stadtteil_HH = 401 if STADTT == "Alsterdorf"
replace Stadtteil_HH = 402 if STADTT == "Barmbek-Nord"
replace Stadtteil_HH = 403 if STADTT == "Barmbek-Süd"
replace Stadtteil_HH = 404 if STADTT == "Dulsberg"
replace Stadtteil_HH = 405 if STADTT == "Eppendorf"
replace Stadtteil_HH = 406 if STADTT == "Fuhlsbüttel"
replace Stadtteil_HH = 407 if STADTT == "Groß Borstel"
replace Stadtteil_HH = 408 if STADTT == "Hoheluft-Ost"
replace Stadtteil_HH = 409 if STADTT == "Hohenfelde"
replace Stadtteil_HH = 410 if STADTT == "Langenhorn"
replace Stadtteil_HH = 411 if STADTT == "Ohlsdorf"
replace Stadtteil_HH = 412 if STADTT == "Uhlenhorst"
replace Stadtteil_HH = 413 if STADTT == "Winterhude"
replace Stadtteil_HH = 501 if STADTT == "Bergstedt"
replace Stadtteil_HH = 502 if STADTT == "Bramfeld"
replace Stadtteil_HH = 503 if STADTT == "Duvenstedt"
replace Stadtteil_HH = 504 if STADTT == "Eilbek"
replace Stadtteil_HH = 505 if STADTT == "Farmsen-Berne"
replace Stadtteil_HH = 506 if STADTT == "Hummelsbüttel"
replace Stadtteil_HH = 507 if STADTT == "Jenfeld"
replace Stadtteil_HH = 508 if STADTT == "Lemsahl-Mellingstedt"
replace Stadtteil_HH = 509 if STADTT == "Marienthal"
replace Stadtteil_HH = 510 if STADTT == "Poppenbüttel"
replace Stadtteil_HH = 511 if STADTT == "Rahlstedt"
replace Stadtteil_HH = 512 if STADTT == "Sasel"
replace Stadtteil_HH = 513 if STADTT == "Steilshoop"
replace Stadtteil_HH = 514 if STADTT == "Tonndorf"
replace Stadtteil_HH = 515 if STADTT == "Volksdorf"
replace Stadtteil_HH = 516 if STADTT == "Wandsbek"
replace Stadtteil_HH = 517 if STADTT == "Wellingsbüttel"
replace Stadtteil_HH = 518 if STADTT == "Wohldorf-Ohlstedt"
replace Stadtteil_HH = 601 if STADTT == "Allermöhe"
replace Stadtteil_HH = 602 if STADTT == "Altengamme"
replace Stadtteil_HH = 603 if STADTT == "Bergedorf"
replace Stadtteil_HH = 604 if STADTT == "Billwerder"
replace Stadtteil_HH = 605 if STADTT == "Curslack"
replace Stadtteil_HH = 606 if STADTT == "Kirchwerder"
replace Stadtteil_HH = 607 if STADTT == "Lohbrügge"
replace Stadtteil_HH = 608 if STADTT == "Moorfleet"
replace Stadtteil_HH = 609 if STADTT == "Neuengamme"
replace Stadtteil_HH = 610 if STADTT == "Ochsenwerder"
replace Stadtteil_HH = 611 if STADTT == "Reitbrook"
replace Stadtteil_HH = 612 if STADTT == "Spadenland"
replace Stadtteil_HH = 613 if STADTT == "Tatenberg"
replace Stadtteil_HH = 702 if STADTT == "Cranz"
replace Stadtteil_HH = 703 if STADTT == "Eißendorf"
replace Stadtteil_HH = 704 if STADTT == "Francop"
replace Stadtteil_HH = 706 if STADTT == "Harburg"
replace Stadtteil_HH = 707 if STADTT == "Hausbruch"
replace Stadtteil_HH = 708 if STADTT == "Heimfeld"
replace Stadtteil_HH = 709 if STADTT == "Langenbek"
replace Stadtteil_HH = 710 if STADTT == "Marmstorf"
replace Stadtteil_HH = 712 if STADTT == "Neuenfelde"
replace Stadtteil_HH = 713 if STADTT == "Neugraben-Fischbek"
replace Stadtteil_HH = 715 if STADTT == "Rönneburg"
replace Stadtteil_HH = 716 if STADTT == "Sinstorf"
replace Stadtteil_HH = 717 if STADTT == "Wilstorf"
replace Stadtteil_HH = 1 if STADTT == "Mitte"
replace Stadtteil_HH = 2 if STADTT == "Altona"
replace Stadtteil_HH = 3 if STADTT == "Eimsbüttel"
replace Stadtteil_HH = 4 if STADTT == "Nord"
replace Stadtteil_HH = 5 if STADTT == "Wandsbek"
replace Stadtteil_HH = 6 if STADTT == "Bergedorf"
replace Stadtteil_HH = 7 if STADTT == "Harburg"


label var Stadtteil_HH "Hamburger Stadtteile"

label define ST_HVV 102 `"Billstedt"', modify
label define ST_HVV 103 `"Borgfelde"', modify
label define ST_HVV 104 `"Finkenwerder"', modify
label define ST_HVV 108 `"Hamm-Mitte"', modify
label define ST_HVV 109 `"Hamm-Nord"', modify
label define ST_HVV 110 `"Hamm-Süd"', modify
label define ST_HVV 111 `"Hammerbrook"', modify
label define ST_HVV 112 `"Horn"', modify
label define ST_HVV 114 `"Neustadt"', modify
label define ST_HVV 115 `"Rothenburgsort"', modify
label define ST_HVV 116 `"St. Georg"', modify
label define ST_HVV 117 `"St. Pauli"', modify
label define ST_HVV 119 `"Veddel"', modify
label define ST_HVV 121 `"Wilhelmsburg"', modify
label define ST_HVV 201 `"Altona-Altstadt"', modify
label define ST_HVV 202 `"Altona-Nord"', modify
label define ST_HVV 203 `"Bahrenfeld"', modify
label define ST_HVV 204 `"Blankenese"', modify
label define ST_HVV 205 `"Groß Flottbek"', modify
label define ST_HVV 206 `"Iserbrook"', modify
label define ST_HVV 207 `"Lurup"', modify
label define ST_HVV 208 `"Nienstedten"', modify
label define ST_HVV 209 `"Osdorf"', modify
label define ST_HVV 210 `"Othmarschen"', modify
label define ST_HVV 211 `"Ottensen"', modify
label define ST_HVV 212 `"Rissen"', modify
label define ST_HVV 213 `"Sternschanze"', modify
label define ST_HVV 214 `"Sülldorf"', modify
label define ST_HVV 301 `"Eidelstedt"', modify
label define ST_HVV 302 `"Eimsbüttel"', modify
label define ST_HVV 303 `"Harvestehude"', modify
label define ST_HVV 304 `"Hoheluft-West"', modify
label define ST_HVV 305 `"Lokstedt"', modify
label define ST_HVV 306 `"Niendorf"', modify
label define ST_HVV 307 `"Rotherbaum"', modify
label define ST_HVV 308 `"Schnelsen"', modify
label define ST_HVV 309 `"Stellingen"', modify
label define ST_HVV 401 `"Alsterdorf"', modify
label define ST_HVV 402 `"Barmbek-Nord"', modify
label define ST_HVV 403 `"Barmbek-Süd"', modify
label define ST_HVV 404 `"Dulsberg"', modify
label define ST_HVV 405 `"Eppendorf"', modify
label define ST_HVV 406 `"Fuhlsbüttel"', modify
label define ST_HVV 407 `"Groß Borstel"', modify
label define ST_HVV 408 `"Hoheluft-Ost"', modify
label define ST_HVV 409 `"Hohenfelde"', modify
label define ST_HVV 410 `"Langenhorn"', modify
label define ST_HVV 411 `"Ohlsdorf"', modify
label define ST_HVV 412 `"Uhlenhorst"', modify
label define ST_HVV 413 `"Winterhude"', modify
label define ST_HVV 501 `"Bergstedt"', modify
label define ST_HVV 502 `"Bramfeld"', modify
label define ST_HVV 503 `"Duvenstedt"', modify
label define ST_HVV 504 `"Eilbek"', modify
label define ST_HVV 505 `"Farmsen-Berne"', modify
label define ST_HVV 506 `"Hummelsbüttel"', modify
label define ST_HVV 507 `"Jenfeld"', modify
label define ST_HVV 508 `"Lemsahl-Mellingstedt"', modify
label define ST_HVV 509 `"Marienthal"', modify
label define ST_HVV 510 `"Poppenbüttel"', modify
label define ST_HVV 511 `"Rahlstedt"', modify
label define ST_HVV 512 `"Sasel"', modify
label define ST_HVV 513 `"Steilshoop"', modify
label define ST_HVV 514 `"Tonndorf"', modify
label define ST_HVV 515 `"Volksdorf"', modify
label define ST_HVV 516 `"Wandsbek"', modify
label define ST_HVV 517 `"Wellingsbüttel"', modify
label define ST_HVV 518 `"Wohldorf-Ohlstedt"', modify
label define ST_HVV 601 `"Allermöhe"', modify
label define ST_HVV 602 `"Altengamme"', modify
label define ST_HVV 603 `"Bergedorf"', modify
label define ST_HVV 604 `"Billwerder"', modify
label define ST_HVV 605 `"Curslack"', modify
label define ST_HVV 606 `"Kirchwerder"', modify
label define ST_HVV 607 `"Lohbrügge"', modify
label define ST_HVV 608 `"Moorfleet"', modify
label define ST_HVV 609 `"Neuengamme"', modify
label define ST_HVV 610 `"Ochsenwerder"', modify
label define ST_HVV 611 `"Reitbrook"', modify
label define ST_HVV 612 `"Spadenland"', modify
label define ST_HVV 613 `"Tatenberg"', modify
label define ST_HVV 702 `"Cranz"', modify
label define ST_HVV 703 `"Eißendorf"', modify
label define ST_HVV 704 `"Francop"', modify
label define ST_HVV 706 `"Harburg"', modify
label define ST_HVV 707 `"Hausbruch"', modify
label define ST_HVV 708 `"Heimfeld"', modify
label define ST_HVV 709 `"Langenbek"', modify
label define ST_HVV 710 `"Marmstorf"', modify
label define ST_HVV 712 `"Neuenfelde"', modify
label define ST_HVV 713 `"Neugraben-Fischbek"', modify
label define ST_HVV 715 `"Rönneburg"', modify
label define ST_HVV 716 `"Sinstorf"', modify
label define ST_HVV 717 `"Wilstorf"', modify
label define SB_HVV 1 `"Mitte"', modify
label define SB_HVV 2 `"Altona"', modify
label define SB_HVV 3 `"Eimsbüttel"', modify
label define SB_HVV 4 `"Nord"', modify
label define SB_HVV 5 `"Wandsbek"', modify
label define SB_HVV 6 `"Bergedorf"', modify
label define SB_HVV 7 `"Harburg"', modify

label value Stadtteil_HH SB_HVV


label define bezirke 1 `"Altona"', modify
label define bezirke 2 `"Bergedorf"', modify
label define bezirke 3 `"Eimsbüttel"', modify
label define bezirke 4 `"Hamburg-Mitte"', modify
label define bezirke 5 `"Hamburg-Nord"', modify
label define bezirke 6 `"Harburg"', modify
label define bezirke 7 `"Wandsbek"', modify
label define bezirke 8 `"Neuwerk"', modify

label var Bezirke_HH "Hamburger Bezirke"
label value Bezirke_HH bezirke



save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\PLZ_HH_kleinräumig.dta", replace



use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung.dta", clear

rename bundesland bundesland_name

gen bundesland = 1 if bundesland_name=="Schleswig-Holstein"
replace bundesland = 2 if bundesland_name == "Hamburg"
replace bundesland = 3 if bundesland_name == "Niedersachsen"
replace bundesland = 4 if bundesland_name == "Bremen"
replace bundesland = 5 if bundesland_name == "Nordrhein-Westfalen"
replace bundesland = 6 if bundesland_name == "Hessen"
replace bundesland = 7 if bundesland_name == "Rheinland-Pfalz"
replace bundesland = 8 if bundesland_name == "Baden-Württemberg"
replace bundesland = 9 if bundesland_name == "Bayern"
replace bundesland = 10 if bundesland_name == "Saarland"
replace bundesland = 11 if bundesland_name == "Berlin"
replace bundesland = 12 if bundesland_name == "Brandenburg"
replace bundesland = 13 if bundesland_name == "Mecklenburg-Vorpommern"
replace bundesland = 14 if bundesland_name == "Sachsen"
replace bundesland = 15 if bundesland_name == "Sachsen-Anhalt"
replace bundesland = 16 if bundesland_name == "Thüringen"

label define BuLa 1 `"Schleswig-Holstein"', modify
label define BuLa 2 `"Hamburg"', modify
label define BuLa 3 `"Niedersachsen"', modify
label define BuLa 4 `"Bremen"', modify
label define BuLa 5 `"Nordrhein-Westfalen"', modify
label define BuLa 6 `"Hessen"', modify
label define BuLa 7 `"Rheinland-Pfalz"', modify
label define BuLa 8 `"Baden-Württemberg"', modify
label define BuLa 9 `"Bayern"', modify
label define BuLa 10 `"Saarland"', modify
label define BuLa 11 `"Berlin"', modify
label define BuLa 12 `"Brandenburg"', modify
label define BuLa 13 `"Mecklenburg-Vorpommern"', modify
label define BuLa 14 `"Sachsen"', modify
label define BuLa 15 `"Sachsen-Anhalt"', modify
label define BuLa 16 `"Thüringen"', modify

label value bundesland BuLa 

merge f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\PLZ_HH_kleinräumig.dta", sort unique keep (Bezirke_HH Stadtteil_HH)
drop _merge

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung.dta", replace

duplicates drop f3aa, force

save  "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung_4steller.dta", replace

