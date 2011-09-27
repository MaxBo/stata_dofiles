insheet using "$Y\H\RoutenTables\HinwegeAlleVerbindungen.txt", tab case clear
renpfix mittl w
gen byte Hin=1
save "$Y\MiD-H\Stata\W_kg_OV.dta",replace
insheet using "$Y\H\RoutenTables\HeimwegeAlleVerbindungen.txt", tab case clear
renpfix mittl w
gen byte Hin=0
append using "$Y\MiD-H\Stata\W_kg_OV.dta"
renpfix wUmsteige wUm
renpfix wZugangs wZu
renpfix wAbgangs wAb
save "$Y\MiD-H\Stata\W_kg_OV.dta",replace
local my_path "$Y\H\RoutenTables\\"
local my_mdb "MiD_H_Routen"
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS WegId, Total_Minutes AS MinKfz, Total_Meter AS MeterKfz FROM StartZielKfz") clear
merge WegId using "$Y\MiD-H\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$Y\MiD-H\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS WegId, Total_MinFuss AS MinFuss , Total_MinRad AS MinRad, Total_Meter AS MeterFuss FROM StartZielFussRadKm") clear
merge WegId using "$Y\MiD-H\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$Y\MiD-H\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(ID) AS WegId, VZNR AS VZ_Start , ZuAbgangszeitVZ2005_Pkw2009 AS ParkZeitStart FROM VZ_ParkZeit_StartPunkte") clear
merge WegId using "$Y\MiD-H\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$Y\MiD-H\Stata\W_kg_OV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(ID) AS WegId, VZNR AS VZ_Ziel , ZuAbgangszeitVZ2005_Pkw2009 AS ParkZeitZiel FROM VZ_ParkZeit_ZielPunkte") clear
merge WegId using "$Y\MiD-H\Stata\W_kg_OV.dta", unique sort update
drop _merge
save "$Y\MiD-H\Stata\W_kg_OV.dta",replace



insheet using "$Y\H\RoutenTables\PendelwegVerbindungen.txt", tab case clear
renpfix mittl w
save "$Y\MiD-H\Stata\P_kg_IV.dta",replace
local my_path "$Y\H\RoutenTables\\"
local my_mdb "MiD_H_Routen"
di "`my_path'`my_mdb'"
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS PersId, Total_Minutes AS MinKfz, Total_Meter AS MeterKfz FROM WA_Kfz") clear
merge PersId using "$Y\MiD-H\Stata\P_kg_IV.dta", unique sort update
sort PersId 
drop _merge
save "$Y\MiD-H\Stata\P_kg_IV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS PersId, Total_MinFuss AS MinFuss , Total_MinRad AS MinRad, Total_Meter AS MeterFuss FROM WA_FussRadKm") clear
merge PersId using "$Y\MiD-H\Stata\P_kg_IV.dta", unique sort update
sort PersId
drop _merge
renpfix wUmsteige wUm
renpfix wZugangs wZu
renpfix wAbgangs wAb
save "$Y\MiD-H\Stata\P_kg_IV.dta",replace
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(Name) AS PersId, Total_MinFuss AS MinFuss , Total_MinRad AS MinRad, Total_Meter AS MeterFuss FROM VZ_ParkZeit_ZielPunkte") clear
merge PersId using "$Y\MiD-H\Stata\P_kg_IV.dta", unique sort update
sort PersId
drop _merge
save "$Y\MiD-H\Stata\P_kg_IV.dta",replace


