clear
set memory 700m
* use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Personen_3.dta", clear
 use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_2006_Wege_10_test.dta", clear
bysort HHID PID: gen PersGr =1 if  BerufVoll==1
bysort HHID PID: replace PersGr =2 if  BerufTeil==1
bysort HHID PID: replace PersGr =3 if   soNErwerb==1
bysort HHID PID: replace PersGr =4 if   Student==1
bysort HHID PID: replace PersGr =5 if   Azubi==1
bysort HHID PID: replace PersGr =6 if   OSchüler==1
bysort HHID PID: replace PersGr =7 if   GSchüler==1
bysort HHID PID: replace PersGr =8 if   Kleinkind==1
bysort HHID PID: replace PersGr =9 if   Rentner==1


label define PersGr 1 `"Vollzeitberufstätige"' 2 `"Teilzeitberufstätige"' 3 `"sonstige Nichterwerbstätige"' 4 `"Student"' 5 `"Azubi"' 6 `"Oberschüler"' 7 `"Grundschüler"' 8 `"Kleinkind"' 9 `"Rentner"'

label value PersGr PersGr

label var PersGr "Personengruppen klassisch"

