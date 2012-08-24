insheet using "$Y\H\Üstra\Tarife\WegeKosten.txt", tab case clear
save "$MiD_workingdir\Stata\W_OVKosten.dta",replace
insheet using "$Y\H\RoutenTables\HinwegeAlleVerbindungen.txt", tab case clear
renpfix mittl w
gen byte Hin=1
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
insheet using "$Y\H\RoutenTables\HeimwegeAlleVerbindungen.txt", tab case clear
renpfix mittl w
gen byte Hin=0
append using "$MiD_workingdir\Stata\W_kg_OV.dta"
renpfix wUmsteige wUm
renpfix wZugangs wZu
renpfix wAbgangs wAb
merge WegId using "$MiD_workingdir\Stata\W_OVKosten.dta", unique sort update
drop _merge
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
local my_path "$Y\H\RoutenTables\\"
local my_mdb "MiD_H_Routen"
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS WegId, Total_Minutes AS MinKfz, Total_Meter AS MeterKfz FROM StartZielKfz") clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS WegId, Total_MinFuss AS MinFuss , Total_MinRad AS MinRad, Total_Meter AS MeterFuss FROM StartZielFussRadKm") clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(ID) AS WegId, DichteEW AS DiStEW , DichteAPpriv AS DiStAPpriv, DichteAPOD AS DiStAPOD, DichteEHperi AS DiStEHperi, DichteEHaperi AS DiStEHaperi, DichteStudPl AS DiStStudPl FROM DichteStartPunkt") clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(ID) AS WegId, DichteEW AS DiZiEW , DichteAPpriv AS DiZiAPpriv, DichteAPOD AS DiZiAPOD, DichteEHperi AS DiZiEHperi, DichteEHaperi AS DiZiEHaperi, DichteStudPl AS DiZiStudPl FROM DichteZielPunkt") clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", unique sort update
drop _merge
sort WegId
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT ID AS WegId, VZNr AS VZNrStartPunkt, Parkzeit AS ParkzeitStartPunkt FROM ParkzeitStartPunkt") clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", unique sort update
drop _merge
sort WegId
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT ID AS WegId, VZNr AS VZNrZielPunkt, Parkzeit AS ParkzeitZielPunkt FROM ParkzeitZielPunkt") clear
merge WegId using "$MiD_workingdir\Stata\W_kg_OV.dta", unique sort update
drop _merge
sort WegId
save "$MiD_workingdir\Stata\W_kg_OV.dta",replace



insheet using "$Y\H\RoutenTables\PendelwegVerbindungen.txt", tab case clear
renpfix mittl w
save "$MiD_workingdir\Stata\P_kg_IV.dta",replace
local my_path "$Y\H\RoutenTables\\"
local my_mdb "MiD_H_Routen"
di "`my_path'`my_mdb'"
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(ZuAbgangszeitVZ2005.VZNr) AS VZNR, Pkw2009 AS ParkZeitAP FROM ZuAbgangszeitVZ2005") clear
sort  VZNR
save "$MiD_workingdir\Stata\VZ_Parkzeit.dta",replace
insheet using "$Y\H\Üstra\Tarife\PendelwegeKosten.txt", tab case clear
rename ZielVZNr VZNR
merge VZNR using "$MiD_workingdir\Stata\VZ_Parkzeit.dta", uniqusing sort nokeep
rename VZNR VZNR_AP
drop _merge
save "$MiD_workingdir\Stata\P_OVKosten.dta",replace


local my_path "$Y\H\RoutenTables\\"
local my_mdb "MiD_H_Routen"
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS PersId, Total_Minutes AS MinKfz, Total_Meter AS MeterKfz FROM WA_Kfz") clear
merge PersId using "$MiD_workingdir\Stata\P_kg_IV.dta", unique sort update
sort PersId 
drop _merge
save "$MiD_workingdir\Stata\P_kg_IV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS PersId, Total_MinFuss AS MinFuss , Total_MinRad AS MinRad, Total_Meter AS MeterFuss FROM WA_FussRadKm") clear
merge PersId using "$MiD_workingdir\Stata\P_kg_IV.dta", unique sort update
drop _merge
save "$MiD_workingdir\Stata\P_kg_IV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT caseid, DichteEW AS DiHHEW , DichteAPpriv AS DiHHAPpriv, DichteAPOD AS DiHHAPOD, DichteEHperi AS DiHHEHperi, DichteEHaperi AS DiHHEHaperi, DichteStudpl AS DiHHStudPl FROM DichteHaushalte") clear
sort caseid
recode DiHH* (-9999 = .a)
label define Dichte .a "keine Angabe"
label values DiHH** Dichte
tempfile DichteHHfile
save `DichteHHfile'

odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT caseid, VZNr, Parkzeit FROM ParkzeitHaushalte") clear
sort caseid
tempfile ParkZeitHHfile
save `ParkZeitHHfile'

use "$MiD_workingdir\Stata\P_kg_IV.dta",clear
merge PersId using "$MiD_workingdir\Stata\P_OVKosten.dta", unique sort update
drop _merge
gen long caseid = PersId / 10
merge caseid using `DichteHHfile', uniqusing sort update
drop _merge
merge caseid using `ParkZeitHHfile', uniqusing sort update
drop _merge
sort PersId
renpfix wUmsteige wUm
renpfix wZugangs wZu
renpfix wAbgangs wAb
keep if PersId <.
save "$MiD_workingdir\Stata\P_kg_IV.dta",replace


insheet using "$MiD_workingdir\Stata\PersMitMehrerenAO.txt", tab case clear
duplicates drop PersId,force
sort PersId
gen byte MehrereAO = 1
save "$MiD_workingdir\Stata\PersMitMehrerenAO.dta", replace
