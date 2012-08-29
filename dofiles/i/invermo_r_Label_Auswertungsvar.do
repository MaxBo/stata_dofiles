clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\INVERMO\B Haupterhebung\Daten STATA\r_Label.dta", clear

* Reisezweck prüf
gen zweck_aggr1= zweck7==1
label var zweck_aggr1 "Dienstreise"
gen zweck_aggr2 = zweck5==1 | zweck4==1
label var zweck_aggr2 "Urlaubsreise"
gen zweck_aggr3 = zweck1==1
label var zweck_aggr3 "Besuchsreise"
gen zweck_aggr4 = zweck6==1 | zweck8==1
label var zweck_aggr4 "Sonstige"
gen zweck_aggr5 = zweck2==1 | zweck3==1 | zweck9==1
label var zweck_aggr5 "Privatreise"
label value zweck_aggr? jn

gen zweck_sum = zweck1+zweck2+zweck3+zweck4+zweck5+zweck6+zweck7+zweck8+zweck9

gen zweck = 1 if zweck_sum==1 & zweck1==1
replace zweck = 2 if zweck_sum==1 & zweck2 == 1
replace zweck = 3 if zweck_sum==1 & zweck3 == 1
replace zweck = 4 if zweck_sum==1 & zweck4 == 1
replace zweck = 5 if zweck_sum==1 & zweck5 == 1
replace zweck = 6 if zweck_sum==1 & zweck6 == 1
replace zweck = 7 if zweck_sum==1 & zweck7 == 1
replace zweck = 8 if zweck_sum==1 & zweck8 == 1
replace zweck = 9 if zweck_sum==1 & zweck9 == 1

replace zweck = 1 if zweck_sum==2 & zweck1==1 & missing(zweck) & (zweck6==1 | zweck8==2)
replace zweck = 2 if zweck_sum==2 & zweck2 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 3 if zweck_sum==2 & zweck3 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 4 if zweck_sum==2 & zweck4 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 5 if zweck_sum==2 & zweck5 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 6 if zweck_sum==2 & zweck6 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 7 if zweck_sum==2 & zweck7 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 8 if zweck_sum==2 & zweck8 == 1 & missing(zweck) & (zweck6==1| zweck8==1)
replace zweck = 9 if zweck_sum==2 & zweck9 == 1 & missing(zweck) & (zweck6==1| zweck8==1)

replace zweck = 1 if zweck_sum==2 & zweck1 == 1 & missing(zweck) & zweck2==1
replace zweck = 3 if zweck_sum==2 & zweck3 == 1 & missing(zweck) & zweck2==1
replace zweck = 4 if zweck_sum==2 & zweck4 == 1 & missing(zweck) & zweck2==1
replace zweck = 5 if zweck_sum==2 & zweck5 == 1 & missing(zweck) & zweck2==1
replace zweck = 6 if zweck_sum==2 & zweck6 == 1 & missing(zweck) & zweck2==1
replace zweck = 7 if zweck_sum==2 & zweck7 == 1 & missing(zweck) & zweck2==1
replace zweck = 8 if zweck_sum==2 & zweck8 == 1 & missing(zweck) & zweck2==1
replace zweck = 9 if zweck_sum==2 & zweck9 == 1 & missing(zweck) & zweck2==1

replace zweck = 3 if zweck_sum==2 & zweck5==1 & zweck3==1 & missing(zweck)
replace zweck = 9 if zweck_sum==2 & zweck9==1 & zweck4==1 & missing(zweck) 
replace zweck = 5 if zweck_sum==2 & zweck5==1 & zweck4==1 & missing(zweck)
replace zweck = 1 if zweck_sum==2 & zweck1==1 & zweck4==1 & missing(zweck)

replace zweck = 10 if zweck_sum==2 & zweck1==1 & zweck5==1 & missing(zweck)
replace zweck = 11 if zweck_sum==2 & zweck1==1 & zweck4==1 & missing(zweck)
replace zweck = 12 if zweck_sum==2 & zweck1==1 & zweck7==1 & missing(zweck)
replace zweck = 13 if zweck_sum==2 & zweck5==1 & zweck7==1 & missing(zweck)

label define zweck 11 `"Kultur-/Privatreise zu Verwandten/Freunden"' , modify
label define zweck 1 `"Besuch von Verwandten, Bekannten, Freunden"', modify
label define zweck 2`"Einkauf oder private Besorgungen"' , modify
label define zweck 3`"Pflege der Gesundheit, Kur-, Fitness- o. Klinikaufenthalt"' , modify
label define zweck 4`"priv. Tagesreise; Besuch v. Sport- o. Kulturveranstaltungen, Städtereise, Ausflug etc"' , modify
label define zweck 5`"Urlaubsreise, Kurzurlaub"' , modify
label define zweck 6`"Reise mit mind. 1 Übernachtung zw. Wohnung u. Arbeitsstätte/Bundeswehr-/Zivildienststandort"' , modify
label define zweck 7`"Dienst- o. Geschäftsreise"' , modify
label define zweck 8`"sonst. Reisegrund"' , modify
label define zweck 9`"Schulische Fahrt, Reise, Studienfahrt, Exkursion"' , modify
label define zweck 10 `"Urlaubsreise, Kurzurlaub bei Verwandten"' , modify
label define zweck 11 `"Kultur-/Privatreise zu Verwandten/Freunden"' , modify
label define zweck 12 `"Dienstreise mit Besuch bei Verwandten/Freunden"' , modify
label define zweck 13 `"kombinierte Dienst- und Urlaubsreise "' , modify

label var zweck "Reisezweck"
label value zweck zweck

* Reiseinformationen prüf
gen  info = info1 + info2+ info3+ info4+ info5+ info6

* Gruppierungen für das HVM der Reise
gen hvm_grupp = 1 if hvm<4
replace hvm_grupp = 2 if hvm>3 & hvm<7
replace hvm_grupp = 3 if hvm>8 & hvm<14
replace hvm_grupp = 4 if hvm==7
replace hvm_grupp = 5 if hvm==8
replace hvm_grupp = 6 if hvm<19 & hvm >13

label define hvm_gr 1 `"Flugzeug"' 2 `"Zug"' 3 `"Auto"' 4 `"Reisebus"' 5 `"Fähre/Schiff"' 6 `"sonstige"'
label value hvm_grupp hvm_gr
label var hvm_grupp "Übergeordnete Verkehrmittelgruppen des HVM"

gen artueb_sum= e1artueb1+ e1artueb2+ e1artueb3+ e1artueb4
gen e1artueb = 1 if e1artueb1==1 
replace e1artueb = 2 if e1artueb2==1 & artueb_sum==1
replace e1artueb = 3 if e1artueb3==1 & artueb_sum==1
replace e1artueb = 4 if e1artueb4==1 & artueb_sum==1
replace e1artueb = e1artueb5 if  e1artueb4==1 & artueb_sum==1
replace e1artueb = 0 if artueb_sum==0

label value e1artueb artueb

