set more off

use "X:\Daten\KiD_MiD_ internerGebrauch\MiD2008\Daten\STATA\STATA_Zusatzfile\MiD2008_Zusatzfile_Wege.dta", clear 
label define jn 1 "ja" 0 "nein", modify

sort hhid pid st_time en_time
duplicates drop hhid pid st_time en_time w04 w04_dzw w01 w13 w08 if wsource!=1, force

* Definition von Wegen mit Zweck Urlaub: Hin- und Rückweg
gen urlaub =  (w04_dzw==708 | w04_dzw==709) & (s02_1==1 | s02_2==1)
replace urlaub = 1 if w04==8 & (s02_1==1 | s02_2==1)

* Definition des Werktags
gen werktag = stichtag<6

* Zuspielung weiterer Informationen aus dem Personendatensatz zur Validierung der Pkw-Fahrereigenschaft
merge m:1 hhid pid using "X:\Daten\KiD_MiD_ internerGebrauch\MiD2008\Daten\STATA\STATA_Zusatzfile\MiD2008_Zusatzfile_Personen.dta", keepusing(p11 p13 p061_3 rbw03 rbw05)
drop if missing(wid)
replace w04=2 if rbw03 < 1676 & wsource==1
replace w05_5=1 if rbw05==5 & wsource==1
replace w05_5=0 if rbw05!=5 & wsource==1

* Definition von Pkw-Fahrern
gen pkwfahrer = w05_5==1 & (w061==1 | w061==3)
replace pkwfahrer = 0 if p13<17 | p13==1104 |  p13==1105
replace pkwfahrer = 0 if p061_3!=1
replace pkwfahrer = 1 if rbw05==5 & wsource==1 & p061_3==1

bysort hhid pid st_time en_time w04_dzw: egen pkw_gem = sum(pkwfahrer)
bysort hhid pid st_time en_time w04: egen pkw_gem2 = sum(pkwfahrer)
replace pkw_gem= pkw_gem2 if pkw_gem==0 & pkw_gem2==1

sort hhid pid pkw_gem
bysort hhid pid st_time en_time: gen index = _n if pkw_gem==2
drop if index==2

replace rbw03= . if rbw03 > 99996
replace w08 = . if w08==99997 | w08==99998
gen km = w08 
replace km = rbw03 if wsource==1

label value werktag jn
label value urlaub jn
label value pkwfahrer jn

* Gewichtung mit Hochrechnngsfaktor für km
tab urlaub werktag [iw= km*w_hochkm ] if pkwfahrer==1, col
tab urlaub werktag [iw= w_hochkm ] if pkwfahrer==1, col
* Gewichtung mit einfachem Wegegewicht
tab urlaub werktag [iw= km*w_gew ] if pkwfahrer==1, col

