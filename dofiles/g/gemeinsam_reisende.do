clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_2.dta", clear
* gen lfd_jahr = lfd+"_"+datum_j
gen reise_gemeinsam = 1 if f19==1
replace reise_gemeinsam=2 if f19_2==2
replace reise_gemeinsam=3 if f19_2==3
replace reise_gemeinsam=4 if f19_2==4
replace reise_gemeinsam=5 if f19_2==1 & f19_3==1
replace reise_gemeinsam=6 if f19_2==1 & f19_3==2
replace reise_gemeinsam=7 if f19_2==2 & f19_3==1
replace reise_gemeinsam=8 if f19_2==2 & f19_3==2
replace reise_gemeinsam=9 if f19_2==3 & f19_3==1
replace reise_gemeinsam=10 if missing(reise_gemeinsam)

label var reise_gemeinsam "Gruppen gemeinsam Reisender"
label define reise_gemeinsam 1 `"Alleinreisend"', modify
label define reise_gemeinsam 2 `"2 Erwachsene"', modify
label define reise_gemeinsam 3 `"3 Erwachsene"', modify
label define reise_gemeinsam 4 `"4 Erwachsene"', modify
label define reise_gemeinsam 5 `"1 Erwachsener, 1 Kind"', modify
label define reise_gemeinsam 6 `"1 Erwachsener, 2 Kinder"', modify
label define reise_gemeinsam 7 `"2 Erwachsene, 1 Kind"', modify
label define reise_gemeinsam 8 `"2 Erwachsene, 2 Kinder"', modify
label define reise_gemeinsam 9 `"3 Erwachsene, 1 Kind"', modify
label define reise_gemeinsam 10 `"Sonstige"', modify

label value reise_gemeinsam reise_gemeinsam

gen reise_kind = f19_3>0
label var reise_kind "Reise mit Kind"
label define jn 1 `"Ja"', modify
label define jn 0 `"Nein"', modify
label value reise_kind jn

label define f60 1  `"PKW (auch Mietwagen )"', modify
label define f60 2  `"Bus"', modify
label define f60 3  `"U-Bahn / S-Bahn"', modify
label define f60 4  `"Regionalbahn"', modify
label define f60 5  `"ICE / IC"', modify
label define f60 6  `"anderes / k.A."', modify
label define f60 7  `"kein anderes VM vorher"', modify

forvalues i=1/2 {
 label var f60_`i' "anderes Zubringerverkehrsmittel `i'"
 label value f60_`i' f60
}

foreach x in "3" "7" {
replace f`x'a="23570" if f`x'a=="23750"
replace f`x'a="03050" if f`x'a=="3050"
replace f`x'a="04155" if f`x'a=="4155"
replace f`x'a="09111" if f`x'a=="9111"
replace f`x'a="01983" if f`x'a=="1983"
replace f`x'a="01139" if f`x'a=="1139"
replace f`x'a="02625" if f`x'a=="2625"
replace f`x'a="09599" if f`x'a=="9599"
replace f`x'a="07429" if f`x'a=="7429"
replace f`x'a="08396" if f`x'a=="8396"
replace f`x'a="09366" if f`x'a=="9366"
replace f`x'a="09629" if f`x'a=="9629"
replace f`x'a="0"+f`x'a if length(f`x'a)==4 & f25==14
replace f`x'a="75172" if f`x'a=="75133"
}

replace f7a="0"+f7a if length(f7a)==4 & f12==2 & destination==150 & substr(f7a, 1, 2)<"20"
replace f7a="0"+f7a if length(f7a)==4 & f12==2 & substr(f7a, 1, 1)=="4"
replace f7a="04177" if f7a=="04178"
replace f7a="0"+f7a  if f7a=="3046"
replace f7a="0"+f7a  if f7a=="2788"


merge f3a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH)
drop _merge
drop if  missing(lfd)
gen f3aa = f3a if length(f3a)==4
merge f3aa using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung_4steller.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH) update
drop f3aa
drop if  missing(lfd)
rename bundesland bundesland_start
rename kreis kreis_start
rename gemeinde gemeinde_start
rename Bezirke_HH Bezirke_HH_start
rename Stadtteil_HH Stadtteil_HH_start
drop _merge

merge f7a using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH)
drop _merge
drop if  missing(lfd)
gen f7aa = f7a if length(f7a)==4
merge f7aa using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\plz_zuordnung_4steller.dta", sort uniqusing keep ( bundesland kreis gemeinde Bezirke_HH Stadtteil_HH) update 
drop f7aa
drop if  missing(lfd)
rename bundesland bundesland_wohn
rename kreis kreis_wohn
rename gemeinde gemeinde_wohn
rename Bezirke_HH Bezirke_HH_wohn
rename Stadtteil_HH Stadtteil_HH_wohn


drop _merge
drop if  missing(lfd)

gen innerdeutsch = f9<1000
label value innerdeutsch jn

gen bundesland_zielflughafen = 4 if f9==30
replace bundesland_zielflughafen = 11 if f9==100 | f9==101
replace bundesland_zielflughafen = 9 if f9==80 | f9==90 | f9==675
replace bundesland_zielflughafen = 5 if f9==50 | f9==40
replace bundesland_zielflughafen = 14 if f9==150 | f9==140
replace bundesland_zielflughafen = 16 if f9==160 
replace bundesland_zielflughafen = 10 if f9==120
replace bundesland_zielflughafen = 6 if f9==60
replace bundesland_zielflughafen = 8 if f9==70 | f9==610 | f9==590 | f9==605
replace bundesland_zielflughafen = 1 if f9==240

label value bundesland_zielflughafen BuLa

label var bundesland_zielflughafen "Bundesland des Zielflughafens"
gen f12n = f12

replace  f12n = 2 if bundesland_wohn>4 & f12n==1
replace f12n = 1 if f3a==f7a | bundesland_start==bundesland_wohn
replace f12n =1 if bundesland_start<5 & bundesland_zielflughafen>4 & bundesland_zielflughafen<30 & f12n==2
replace f12n = 2 if f5_2==f8_2 & f5_1>1 & f8_2!=7
replace  f12n = 2 if bundesland_wohn>4 & bundesland_wohn<20 & f12n==1


replace f12n = 3 if f25==14
label define f12 3 `"Umsteiger"', modify
label value f12n f12

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_3.dta", replace


