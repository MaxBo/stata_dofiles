* k00 f00 Ankunft_MRH Abfahrt_MRH Ankunft_Hamburg Abkunft_Hamburg Ankunft_Hafen_HH Abfahrt_Hafen_HH Ankunft_FH Abfahrt_FH 

* Textdateien zu Statadateien formatieren
clear
infile k00 f00 Ankunft_FH Abfahrt_FH using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_FH.txt"
sort k00 f00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_FH.dta", replace
clear
infile k00 f00 Ankunft_HH Abfahrt_HH using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_HH.txt"
sort k00 f00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_HH.dta", replace
clear
infile k00 f00 Ankunft_Hafen_HH	Abfahrt_Hafen_HH using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_HAfen_HH.txt"
sort k00 f00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_Hafen_HH.dta", replace
clear
infile k00 f00 Ankunft_MRH	Abfahrt_MRH using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_MRH.txt"
sort k00 f00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_MRH.dta", replace


* neue Statadateien mit regionaler Zuordnung der Fahrtketten in die aktuelle STATA-Version laden


clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100721.dta", clear
sort k00 f00

merge k00 f00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_MRH.dta", uniqusing _merge(MRH)
sort k00 f00
merge k00 f00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_HH.dta", uniqusing _merge(HH)
sort k00 f00
merge k00 f00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_Hafen_HH.dta", uniqusing _merge(Hafen_HH)
sort k00 f00
merge k00 f00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\Do\Do_KiD\Verkettung_FH.dta", uniqusing _merge(FH)
sort k00 f00

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", replace


* Markierung der Fahrtwege, die Start- oder Endpunkt in dem jeweilgen Gebiet haben

clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", clear
* drop Fahrt_MRH Fahrt_HH 
* Fahrt_Hafen_HH  Fahrt_FH_HH
sort k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", replace

* MRH
keep k00 Ankunft_MRH
keep if Ankunft_MRH<2

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_MRH.dta", replace
drop Ankunft_MRH
sort k00
keep k00
bysort k00: keep if _n==1
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_MRH.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", clear
sort k00
merge k00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_MRH.dta", uniqusing  _merge(Fahrt_MRH)

sort k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", replace

* HH
keep k00 Ankunft_HH
keep if Ankunft_HH<2

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_HH.dta", replace
drop Ankunft_HH
sort k00
keep k00
bysort k00: keep if _n==1
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_HH.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", clear
sort k00
merge k00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_HH.dta", uniqusing  _merge(Fahrt_HH)

sort k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", replace

* Hafen Hamburg

keep k00 Ankunft_Hafen_HH
keep if Ankunft_Hafen_HH<2

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_Hafen_HH.dta", replace
drop Ankunft_Hafen_HH
sort k00
keep k00
bysort k00: keep if _n==1
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_Hafen_HH.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", clear
sort k00
merge k00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_Hafen_HH.dta", uniqusing  _merge(Fahrt_Hafen_HH)

sort k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", replace

* Flughafen Hamburg
keep k00 Ankunft_FH
keep if Ankunft_FH<2

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_FH_HH.dta", replace
drop Ankunft_FH
sort k00
keep k00
bysort k00: keep if _n==1
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_FH_HH.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", clear
sort k00
merge k00 using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Fahrtnr_FH_HH.dta", uniqusing  _merge(Fahrt_FH_HH)

sort k00
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\KiD_2002\Einzelfahrten_100723.dta", replace

