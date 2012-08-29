clear
set memory 700m

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Datum_Tag.dta", clear

label define tag 1 `"Montag"', modify
label define tag 2 `"Dienstag"', modify
label define tag 3 `"Mittwoch"', modify
label define tag 4 `"Donnerstag"', modify
label define tag 5 `"Freitag"', modify
label define tag 6 `"Samstag"', modify
label define tag 7 `"Sonntag"', modify

label value wochentag tag

label var wochentag "Wochentag"

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Datum_Tag.dta", replace

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_3.dta", clear

tostring Tag, gen(Tag_n)
tostring Monat, gen(Monat_n)
tostring Jahr, gen(Jahr_n)

replace Tag_n="0"+Tag_n if  length(Tag_n)==1
replace Monat_n="0"+Monat_n if length(Monat_n)==1

gen datum = Tag_n + "/" + Monat_n + "/" + Jahr_n

merge datum using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Datum_Tag.dta", sort uniqusing
drop if missing(lfd)
drop  Tag_n Monat_n Jahr_n _merge

gen werktag = wochentag <6
label value werktag jn
label var werktag "Werktag"

gen hrg2 = hrg
replace hrg2 = 6 if hrg==3 | hrg==4
label value hrg2 Reisegrund
label var hrg2 "Reisegrund zusammengefasst"

gen zeit = Stunde*60+Minute
label var zeit "planmäßige Abflugzeit ab Mitternacht [min]"
gen zeit_abf_min = zeit - f32
gen f32_3 = floor( zeit_abf_min/60)
gen f32_4 = (zeit_abf_min/60 - f32_3)* 60

label var f32_3 "Abfahrtszeits [h]"
label var f32_4 "Abfahrtszeit [min]" 


foreach x in "f32_3" "f32_4" {
tostring `x', gen (`x'n)
replace `x'n="0"+`x'n if length(`x'n)==1  & zeit_abf_min <9999
}


* tostring f32_3, gen (f32_3n)
* tostring f32_4, gen (f32_4n)

* replace f32_3n="0"+f32_3n if  length(f32_3n)==1
* replace f32_4n="0"+f32_4n if length(f32_4n)==1 & zeit_abf_min <9999

gen Abfahrtszeit = f32_3n + ":" + f32_4n if zeit_abf_min <9999


 
label var Abfahrtszeit "Abfahrtszeit vom Aufbruchsort"


foreach x in "Stunde" "Minute" {
tostring `x', gen (`x'_n)
replace `x'_n="0"+`x'_n if length(`x'_n)==1 
}

gen Abflugzeit = Stunde_n + ":" + Minute_n

label var Abflugzeit "planmäßige Abflugzeit"

drop f32_?n zeit zeit_abf_min Stunde_n Minute_n

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_4.dta", replace





