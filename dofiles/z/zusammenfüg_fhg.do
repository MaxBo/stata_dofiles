clear 
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06.dta", clear

append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG08.dta"
append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG09.dta"


label define f25 1 `"Privater oder Firmen-PKW, der gleich zurückgefahren ist"', modify
label define f25 2 `"Privater oder Firmen-PKW, der kurz abgestellt wurde"', modify
label define f25 3 `"Privater oder Firmen-PKW, der abgestellt u. von anderen/Dritten abgeholt wird"', modify
label define f25 4 `"Privater oder Firmen-PKW, der für die Reisedauer abgestellt wurde"', modify
label define f25 5 `"Taxi"', modify
label define f25 6 `"Leihwagen"', modify
label define f25 7 `"Airport-City-Bus vom Hauptbahnhof"', modify
label define f25 8 `"HVV Bus Linie 110 von Ohlsdorf "', modify
label define f25 9 `"Andere HVV-Buslinie"', modify
label define f25 10 `"Fernverkehrs-Linienbus aus Richtung Kiel/Neumünster (Kielius)"', modify
label define f25 11 `"Reisebus z.B. bei Pauschalreise / Gruppenreise / zu Mehreren"', modify
label define f25 12 `"Zubringerdienst = kleinerer Bus / Hotelshuttle / etc. (kein Reisebus!) "', modify
label define f25 13 `"Traveline Bus (Travemünde_Lübeck_Oldesloe_Hamburg)"', modify
label define f25 14 `"Flugzeug"', modify
label define f25 21 `"C-Maxx-Autoservice"', modify
label define f25 22 `"DRK Krankentransport"', modify
label define f25 23 `"Fahrrad"', modify
label define f25 24 `"HVV Bus, anderer"', modify
label define f25 25 `"Keines / kein Verkehrsmittel"', modify
label define f25 26 `"Lufthansashuttle von Luftwerft"', modify
label define f25 27 `"Mitarbeiterparkplatz"', modify
label define f25 28 `"Park & Fly extern / Valet Parking"', modify
label define f25 29 `"Roller, Motorroller"', modify
label define f25 30 `"zu Fuß"', modify
label define f25 31 `"Bus 39"', modify
label define f25 32 `"Bus 26"', modify
label define f25 33 `"Bus 292"', modify
label define f25 34 `"Nachtbus 606"', modify
label define f25 35 `"Bus 172"', modify
label define f25 20 `"S1"', modify
label define f25 16 `"Flughafentransfer / Sammeltaxi"', modify

label value f25 f25

drop f1_4 f2 f6 f11_4 f11_5 f11_6  f50_6 f50_7 f50_8 f50_9 f50_10 f71_2 f60_3 f39b_3 f39b_2 f30_3 jahr f17 


label define Reisegrund 4 `"Besuch Bekannte/Freunde"', modify
label define Reisegrund 3 `"Besuch Verwandte/Familie"', modify
label define Reisegrund 5 `"privat aus anderem Grund"', modify
label define Reisegrund 6 `"Besuch Verwandte/Bekannte"', modify
label define Reisegrund 7 `"geschäftlich + privat"', modify

forvalues i=1/3 {
	recode f1_`i' (4=5) if Jahr==2006
	recode f1_`i' (3=6) if Jahr==2006
	label value f1_`i' Reisegrund	
}

replace hrg = f1_1 if  missing(hrg)
replace hrg = 7 if f1_1==1 & f1_2<7
label value hrg Reisegrund

gen f19 = (f19_1==1)
label var f19 "Alleinreisend"
label define f19 1 `"ja"', modify
label define f19 0 `"nein"', modify
label value f19 f19

gen HVM_last = 1 if f25<7
replace HVM_last =2 if (f25 > 6 & f25<10) | (f25 > 6 & f25<10) | f25==24 | (f25>30 & f25<40) | (f25>26 & f25<30) 
replace HVM_last =3 if f25 ==10 | f25 == 13 | f25==11
replace HVM_last =4 if f25==20
replace HVM_last =5 if f25==12 | f25==26  | f25==16
replace HVM_last =6 if f25==23 | f25==30 | f25==25
replace HVM_last =7 if f25==14

label define HVM 1  `"MIV"', modify
label define HVM 2  `"Stadtbus"', modify
label define HVM 3  `"Fernbus"', modify
label define HVM 4  `"S-Bahn"', modify
label define HVM 5  `"Zubringerverkehr (Bus,AST)"', modify
label define HVM 6  `"NMIV"', modify
label define HVM 7  `"Flugzeug"', modify

label value HVM_last HVM

drop if missing(lfd)


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09.dta", replace

