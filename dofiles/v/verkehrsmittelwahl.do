clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_4.dta", clear

quietly label define VM_x 1  `"MIV"', modify
quietly label define VM_x 2  `"ÖV"', modify
quietly label define VM_x 3  `"kein weiteres"', modify
quietly label define VM_x 4  `"NMIV"', modify
quietly label define VM_x 5  `"Flugzeug"', modify

forvalues i=1/2 {
quietly gen VM_Zubring_x`i' = 1 if f60_`i'==1
quietly replace VM_Zubring_x`i' = 2 if f60_`i'>1 & f60_`i' < 6
quietly replace VM_Zubring_x`i' = 3 if f60_`i'> 5

quietly label value VM_Zubring_x`i' VM_x
quietly label var VM_Zubring_x`i' "zusätzliche Zubringerverkehrsart `i'"
}

gen VM_Zubring_0 = 1 if HVM_last ==1
replace VM_Zubring_0 = 2 if HVM_last >1 & HVM_last<6
replace VM_Zubring_0 = 4 if HVM_last == 6
replace VM_Zubring_0 = 5 if HVM_last == 7
label var VM_Zubring_0 "letztes Zubringerverkehrsart"
label value VM_Zubring_0 VM_x


foreach i in  "0" "x1" "x2" {
quietly gen VM_Zubring_`i'_txt = "MIV" if VM_Zubring_`i'==1
quietly replace VM_Zubring_`i'_txt = "ÖV" if VM_Zubring_`i'==2
quietly replace VM_Zubring_`i'_txt = "" if VM_Zubring_`i'==3
quietly replace VM_Zubring_`i'_txt = "NMIV" if VM_Zubring_`i'==4
quietly replace VM_Zubring_`i'_txt = "Flug" if VM_Zubring_`i'==5
}

gen VM_Kette = VM_Zubring_x2_txt + "-" + VM_Zubring_x1_txt + "-" + VM_Zubring_0_txt
replace VM_Kette = VM_Zubring_x1_txt + "-" + VM_Zubring_0_txt if missing(VM_Zubring_x2_txt)
replace VM_Kette = VM_Zubring_0_txt if missing(VM_Zubring_x2_txt) & missing(VM_Zubring_x1_txt)

label var VM_Kette "Verkettung der Verkehrsmittel zu Ankunft am HAM"

gen catchment_area = 1 if bundesland_start==2
replace catchment_area =2 if kreis_start=="Dithmarschen" | kreis_start=="Steinburg" | kreis_start=="Pinneberg" | kreis_start=="Segeberg" | kreis_start=="Stormarn" | kreis_start=="Herzogtum Lauenburg"
replace catchment_area =3 if kreis_start=="Lüneburg" | kreis_start=="Lüchow-Dannenberg" | kreis_start=="Uelzen" | kreis_start=="Soltau-Fallingbostel" | kreis_start=="Rotenburg (Wümme)" | kreis_start=="Stade" | kreis_start=="Cuxhaven" | kreis_start=="Harburg"
replace catchment_area =4 if kreis_start=="Kiel"
replace catchment_area =5 if kreis_start=="Lübeck"

replace catchment_area =6 if missing(catchment_area) & (bundesland_start==13 | bundesland_start==1 | bundesland_start==3 | bundesland_start==4 | kreis_start=="Prignitz" | kreis_start=="Stendal" | kreis_start=="Ostprignitz_Ruppin" | kreis_start=="Altmarkkreis Salzwedel") 
replace catchment_area =7 if (missing(catchment_area) & f5_1==1) | (kreis_start=="Holzminden" | kreis_start=="Northeim" | kreis_start =="Goslar" | kreis_start=="Göttingen" | kreis_start=="Osterode am Harz")
replace catchment_area =8 if missing(catchment_area) & f5_2==7
replace catchment_area =9 if missing(catchment_area) & f5_1==2

quietly label define c_a 1  `"Hamburg"', modify
quietly label define c_a 2  `"Metropolregion HH Schleswig-Holstein"', modify
quietly label define c_a 3  `"Metropolregion HH Niedersachsen"', modify
quietly label define c_a 4  `"Kiel"', modify
quietly label define c_a 5  `"Lübeck"', modify
quietly label define c_a 6  `"Einzugsgebiet außerhalb MRH"', modify
quietly label define c_a 7  `"Restdeutschland"', modify
quietly label define c_a 8  `"Dänemark"', modify
quietly label define c_a 9  `"Ausland"', modify

label value catchment_area c_a
label var catchment_area "Einzugsgebiet Flughafen (klassifiziert)"



tostring lfd, gen (lfd_n)
tostring Jahr, gen (Jahr_n)
gen ID = Jahr_n + lfd_n
destring ID, replace

label var ID "Identifikationsnummer einzelner Passagiere"

drop lfd_n Jahr_n  VM_Zubring_x2_txt VM_Zubring_x1_txt VM_Zubring_0_txt

gen flug_gew = wichtung
replace flug_gew = subinstr(flug_gew, ",", "",1)
destring flug_gew, replace


gen fehlt = 1 if ID ==2008111084
replace fehlt = 1 if ID == 2008146025
replace fehlt = 1 if ID == 2008146026
replace fehlt = 1 if ID == 2008146027
replace fehlt = 1 if ID == 2008150010
replace fehlt = 1 if ID == 2008150011
replace fehlt = 1 if ID == 2008150012
replace fehlt = 1 if ID == 2008150013
replace fehlt = 1 if ID == 2008150014
replace fehlt = 1 if ID == 2008150015
replace fehlt = 1 if ID == 2008150016
replace fehlt = 0 if missing(fehlt)

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_5.dta", replace

drop if Jahr==2006 | Jahr ==2009
sort ID
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_08_k.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_5.dta", clear
drop if Jahr ==2008
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_06_09_k.dta", replace


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG_08\FHG_08_verkürzt7.dta", clear
drop if missing(lfd_nr)
tostring lfd_nr, gen (lfd_n)
tostring jahr, gen (Jahr_n)
gen ID = Jahr_n + lfd_n
destring ID, replace
rename wichtung wichtung_08

gen fehlt = 1 if ID == 2008109001
replace fehlt = 1 if ID == 2008109002
replace fehlt = 1 if ID == 2008109003
replace fehlt = 1 if ID == 2008109015
replace fehlt = 1 if ID == 2008109016
replace fehlt = 1 if ID == 2008109017
replace fehlt = 1 if ID == 2008109027
replace fehlt = 1 if ID == 2008110083
replace fehlt = 1 if ID == 2008149011
replace fehlt = 1 if ID == 2008149012
replace fehlt = 1 if ID == 2008149013

replace fehlt = 0 if missing(fehlt)

replace ID = 2008150012 if ID == 2008109003
replace ID = 2008150011 if ID == 2008109002
replace ID = 2008150010 if ID == 2008109001
replace ID = 2008150013 if ID == 2008109015
replace ID = 2008150014 if ID == 2008109016
replace ID = 2008150015 if ID == 2008109017
replace ID = 2008146025 if ID == 2008149011
replace ID = 2008146026 if ID == 2008149012
replace ID = 2008146027 if ID == 2008149013
replace ID = 2008150016 if ID == 2008109027
replace ID = 2008111084 if ID == 2008110083

gen qzu =1 if q__z =="Q"
replace qzu =2 if q__z == "Z"
replace qzu =3 if q__z == "U"

sort ID
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG_08\FHG_08_verkürzt8.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_08_k.dta", clear

merge using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG_08\FHG_08_verkürzt8.dta", keep(ID hplz wplz wichtung_08 charakter  streckenziel_sz_1 endziel_ez_1 qzu)
label value qzu f12

append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_06_09_k.dta"
drop _merge

replace flug_gew=wichtung_08 if missing(flug_gew) & Jahr==2008

replace f12n = 2 if (bundesland_wohn > 4 | (bundesland_wohn<11 & bundesland_wohn>13)) & innerdeutsch==1 & (bundesland_zielflughafen > 4 | (bundesland_zielflughafen<11 & bundesland_zielflughafen>13)) 
replace f12n =1 if bundesland_wohn <5 | (bundesland_wohn>10 & bundesland_wohn<14 )
replace f12n =3 if f25==14

label define Ausland 43 `"Serbien"', modify
label define Ausland 44 `"Montenegro"', modify
label define Ausland 45 `"Kosovo UN Verwaltung"', modify
label define Ausland 46 `"Zypern (Nord)"', modify
label define Ausland 47 `"Weißrussland"', modify
label define Ausland 108 `"staatenlos"', modify

foreach x in "f5_2" "f8_2" "staat_2" {
quietly recode `x' (47=17) if Jahr > 2006
quietly recode `x' (20=18) if Jahr > 2006
quietly recode `x' (21=19) if Jahr > 2006
quietly recode `x' (22=20) if Jahr > 2006
quietly recode `x' (23=21) if Jahr > 2006
quietly recode `x' (24=22) if Jahr > 2006
quietly recode `x' (25=23) if Jahr > 2006
quietly recode `x' (26=24) if Jahr > 2006
quietly recode `x' (27=25) if Jahr > 2006
quietly recode `x' (28=26) if Jahr > 2006
quietly recode `x' (29=27) if Jahr > 2006
quietly recode `x' (30=28) if Jahr > 2006
quietly recode `x' (31=29) if Jahr > 2006
quietly recode `x' (32=30) if Jahr > 2006
quietly recode `x' (33=31) if Jahr > 2006
quietly recode `x' (34=32) if Jahr > 2006
quietly recode `x' (35=33) if Jahr > 2006
quietly recode `x' (36=34) if Jahr > 2006
quietly recode `x' (37=35) if Jahr > 2006
quietly recode `x' (38=36) if Jahr > 2006
quietly recode `x' (39=37) if Jahr > 2006
quietly recode `x' (40=38) if Jahr > 2006
quietly recode `x' (41=39) if Jahr > 2006
quietly recode `x' (42=40) if Jahr > 2006
quietly recode `x' (43=41) if Jahr > 2006
quietly recode `x' (44=42) if Jahr > 2006
quietly recode `x' (17=43) if Jahr > 2006
quietly recode `x' (18=44) if Jahr > 2006
quietly recode `x' (19=45) if Jahr > 2006
quietly recode `x' (45=46) if Jahr > 2006
quietly recode `x' (46=47) if Jahr > 2006

label value `x' Ausland
}

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_6.dta", replace
