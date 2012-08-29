clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_4.dta", clear

quietly label define VM_x 1  `"MIV"', modify
quietly label define VM_x 2  `"�V"', modify
quietly label define VM_x 3  `"kein weiteres"', modify
quietly label define VM_x 4  `"NMIV"', modify
quietly label define VM_x 5  `"Flugzeug"', modify

forvalues i=1/2 {
quietly gen VM_Zubring_x`i' = 1 if f60_`i'==1
quietly replace VM_Zubring_x`i' = 2 if f60_`i'>1 & f60_`i' < 6
quietly replace VM_Zubring_x`i' = 3 if f60_`i'> 5

quietly label value VM_Zubring_x`i' VM_x
quietly label var VM_Zubring_x`i' "zus�tzliche Zubringerverkehrsart `i'"
}

gen VM_Zubring_0 = 1 if HVM_last ==1
replace VM_Zubring_0 = 2 if HVM_last >1 & HVM_last<6
replace VM_Zubring_0 = 4 if HVM_last == 6
replace VM_Zubring_0 = 5 if HVM_last == 7
label var VM_Zubring_0 "letztes Zubringerverkehrsart"
label value VM_Zubring_0 VM_x


foreach i in  "0" "x1" "x2" {
quietly gen VM_Zubring_`i'_txt = "MIV" if VM_Zubring_`i'==1
quietly replace VM_Zubring_`i'_txt = "�V" if VM_Zubring_`i'==2
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
replace catchment_area =3 if kreis_start=="L�neburg" | kreis_start=="L�chow-Dannenberg" | kreis_start=="Uelzen" | kreis_start=="Soltau-Fallingbostel" | kreis_start=="Rotenburg (W�mme)" | kreis_start=="Stade" | kreis_start=="Cuxhaven" | kreis_start=="Harburg"
replace catchment_area =4 if kreis_start=="Kiel"
replace catchment_area =5 if kreis_start=="L�beck"

replace catchment_area =6 if missing(catchment_area) & (bundesland_start==13 | bundesland_start==1 | bundesland_start==3 | bundesland_start==4 | kreis_start=="Prignitz" | kreis_start=="Stendal" | kreis_start=="Ostprignitz_Ruppin" | kreis_start=="Altmarkkreis Salzwedel") 
replace catchment_area =7 if (missing(catchment_area) & f5_1==1) | (kreis_start=="Holzminden" | kreis_start=="Northeim" | kreis_start =="Goslar" | kreis_start=="G�ttingen" | kreis_start=="Osterode am Harz")
replace catchment_area =8 if missing(catchment_area) & f5_2==7
replace catchment_area =9 if missing(catchment_area) & f5_1==2

quietly label define c_a 1  `"Hamburg"', modify
quietly label define c_a 2  `"Metropolregion HH Schleswig-Holstein"', modify
quietly label define c_a 3  `"Metropolregion HH Niedersachsen"', modify
quietly label define c_a 4  `"Kiel"', modify
quietly label define c_a 5  `"L�beck"', modify
quietly label define c_a 6  `"Einzugsgebiet au�erhalb MRH"', modify
quietly label define c_a 7  `"Restdeutschland"', modify
quietly label define c_a 8  `"D�nemark"', modify
quietly label define c_a 9  `"Ausland"', modify

label value catchment_area c_a
label var catchment_area "Einzugsgebiet Flughafen (klassifiziert)"


tostring lfd, gen (lfd_n)
tostring Jahr, gen (Jahr_n)
gen ID = Jahr_n + "_" + lfd_n

label var ID "Identifikationsnummer einzelner Passagiere"

drop lfd_n Jahr_n  VM_Zubring_x2_txt VM_Zubring_x1_txt VM_Zubring_0_txt

gen flug_gew = wichtung

gen fehlt = 1 if ID =="2008_111084"
replace fehlt = 1 if ID == "2008_146025"
replace fehlt = 1 if ID == "2008_146026"
replace fehlt = 1 if ID == "2008_146027"
replace fehlt = 1 if ID == "2008_150010"
replace fehlt = 1 if ID == "2008_150011"
replace fehlt = 1 if ID == "2008_150012"
replace fehlt = 1 if ID == "2008_150013"
replace fehlt = 1 if ID == "2008_150014"
replace fehlt = 1 if ID == "2008_150015"
replace fehlt = 1 if ID == "2008_150016"
replace fehlt = 0 if missing(fehlt)

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_5.dta", replace

drop if Jahr==2006 | Jahr ==2009

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_08_k.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_5.dta", clear
drop if Jahr ==2008
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_06_09_k.dta", replace


use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG_08\FHG_08_verk�rzt7.dta", clear
drop if missing(lfd_nr)
tostring lfd_nr, gen (lfd_n)
tostring jahr, gen (Jahr_n)
gen ID = Jahr_n + "_" + lfd_n
rename wichtung wichtung_08

gen fehlt = 1 if ID == "2008_109001"
replace fehlt = 1 if ID == "2008_109002"
replace fehlt = 1 if ID == "2008_109003"
replace fehlt = 1 if ID == "2008_109015"
replace fehlt = 1 if ID == "2008_109016"
replace fehlt = 1 if ID == "2008_109017"
replace fehlt = 1 if ID == "2008_109027"
replace fehlt = 1 if ID == "2008_110083"
replace fehlt = 1 if ID == "2008_149011"
replace fehlt = 1 if ID == "2008_149012"
replace fehlt = 1 if ID == "2008_149013"

replace fehlt = 0 if missing(fehlt)

replace ID = "2008_150012" if ID == "2008_109003"
replace ID = "2008_150011" if ID == "2008_109002"
replace ID = "2008_150010" if ID == "2008_109001"
replace ID = "2008_150013" if ID == "2008_109015"
replace ID = "2008_150014" if ID == "2008_109016"
replace ID = "2008_150015" if ID == "2008_109017"
replace ID = "2008_146025" if ID == "2008_149011"
replace ID = "2008_146026" if ID == "2008_149012"
replace ID = "2008_146027" if ID == "2008_149013"
replace ID = "2008_150016" if ID == "2008_109027"
replace ID = "2008_111084" if ID == "2008_110083"


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG_08\FHG_08_verk�rzt8.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_08_k.dta", clear

merge ID using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG_08\FHG_08_verk�rzt8.dta", sort unique keep(hplz wplz wichtung_08 charakter  streckenziel_sz_1 endziel_ez_1)

append using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG_06_09_k.dta"



