set more off
insheet using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KONTIV\K76_aufbereitet.csv", clear 

rename gemeindegrenklasse polgk
label define polgk 1 "< 2.000 EW" 2 "[2.000;5.000)"  3 "[5.000;20.000)" 4 "[20.000;100.000)" 5 "[100.000;300.000)"  6 "[300.000;500.000)"  7 ">=500.000", modify
label value polgk polgk

rename gkz_gruppe rtyp
recode rtyp (0=.)
label define rtyp 1 "st‰dtisch" 2 "gemischt" 3 "l‰ndlich", modify

label define mehrp 9  "9 Personen und mehr", modify
label define mehrk 9  "9 Kinder und mehr" 0 "keine Kinder", modify

label value phh mehrp
label value phh06 merk
label value phh_06_10 merk
label value phh10 merkk

label define jn 1 "ja" 0 "nein" .a "keine Angabe", modify

recode hh_telefon (2=.a)
label value hh_telefon jn 

label define wohnsitu 1 "Untermiete in Privatwohnung", modify
label define wohnsitu 2 "Untermiete in Wohnheim", modify
label define wohnsitu 3 "Miete in Sozialwohnung", modify
label define wohnsitu 4 "Miete in Mietwohnung", modify
label define wohnsitu 5 "Miete in 1-Fam.-/Reihenhaus", modify
label define wohnsitu 6 "Eigentumswohnung", modify
label define wohnsitu 7 "Eigentum landw. Anwesen", modify
label define wohnsitu 8 "eigenes 1-Fam.-/Reihenhaus", modify
recode wohnsituation (9=.a)
label define wohnsitu .a "keine Angabe", modify
label value wohnsituation wohnsitu

label define entf 1 "< 100m" 2 "[100;300)" 3 "[300;500)" 4 "[500;1.000)" 5 "[1.000;1.500)" 6 "[1.500;2.000)" 7 ">2.000m" 9 "keine Haltestelle erreichbar" .a "keine Angabe", modify

foreach x in "p052" "p053" "p055" "p056" "p057" {
	recode `x' (0=.a)
	label value `x' entf
}
recode p058 (0=.a)
label define kA .a "keine Angabe", modify
label value p058 kA

label define schule 1 "Volks-/Hauptschule ohne Lehre" 2  "Volks-/Hauptschule mit Lehre" 3 "Mittl. Abschluss" 4 "Abitur, Fachhochschule, Hochschule" /*
*/ .a "keine Angabe" 6 "Restgruppe (in Schul-/Hochschulausbildung)", modify
label define beruf 1 "Hausfrau ohne Berufsausbildung" 2 "Hausfrau mit Berufsausbildung" 3 "Rentner" 4 "in Berufsausbildung" 5 "in Schul-/Hochschulausbildung" /*
*/ 6 "arbeitslos" 7 "teilweise berufst‰tig" 8 "voll berufst‰tig" .a "keine Angabe", modify
label define beruf_stellung 1 "Arbeiter" 2 "Angestellter" 3 "Beamter" 4 "selbst‰ndiger Landwirt" 5 "anderer Selbst‰ndiger" 6 "mithelfender Familienangehˆriger" /*
*/ .a "keine Angabe" 8 "Restgruppe (Hausfrau, Rentner, in Ausbildung)", modify

recode schule_vorstand (5=.a)
recode schule (5=.a)
recode beruf_vorstand (9=.a)
recode beruf (9=.a)
recode beruf_stellung_vorstand (7=.a)
recode beruf_stellung (7=.a)

label value schule* schule
label value beruf* beruf
label value beruf_stellung* beruf_stellung 

label define sex 5 "Mann" 6 "Frau" .a "keine Angabe", modify
recode sex (0=.a)
label value sex sex

label value alter kA

label define familie 1 "ledig" 2 "verheiratet" 3 "verwitwet" 4 "geschieden" .a "keine Angabe", modify
recode familienstand (5=.a)
label value familienstand familie



label var rtyp "GKZ Gruppe"
label var gemnr "Gemeindenummer GKZ"
label var phh "Haushaltsgrˆﬂe"
label var phh06 "Anz. Kinder unter 6 im Haushalt"
label var phh_06_10 "Anz. Kinder zw. 6 und 10 Jahren im Haushalt"
label var phh10 "Anz. Kinder ab 10 Jahren im Haushalt"
label var hh_telefon "Telefonverf¸gbarkeit im Haushalt"
label var wohnsituation "Wohnsituation"
label var p052 "Entf. Fuﬂ Haltestelle Bus"
label var p053 "Entf. Fuﬂ Haltestelle U-Bahn"
label var p055 "Entf. Fuﬂ Haltestelle Straﬂenbahn"
label var p056 "Entf. Fuﬂ Haltestelle S-Bahn"
label var p057 "Entf. Fuﬂ Haltestelle Eisenbahn"
label var p058 "Summe der zu Fuﬂ erreichbaren ÷V-Haltestellen"
label var pkz_hhvorstand "PID des Haushaltsvorstandes"
label var schule_vorstand "Schulbildung des Haushaltsvorstandes"
label var beruf_vorstand "Berufst‰tigkeit des Haushaltsvorstandes"
label var beruf_stellung_vorstand "Stellung im Beruf des Haushaltsvorstandes"
label var schule "Schulbildung befragte Person"
label var beruf "Berufst‰tigkeit befragte Person"
label var beruf_stellung "Stellung im Beruf befragte Person"
label var sex "Geschlecht befragte Person"
label var alter "Alter befragte Person"
label var familienstand "Familienstand befragte Person"

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KONTIV\kontiv_76.dta", replace

