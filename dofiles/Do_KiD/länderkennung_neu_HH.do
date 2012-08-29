clear
set memory 700m
use "X:\Datengrundlagen\KiD_MiD_ internerGebrauch\KiD 2002 - Aufstockung HH\KiD_2002_Stadt_Hamburg_Einzelfahrtdaten.dta", clear

gen Ab_Land = 1 if f02b=="D" | f02b=="d"
replace Ab_Land = 2 if f02b == "A"
replace Ab_Land = 3 if f02b == "B"
replace Ab_Land = 4 if f02b == "CH"
replace Ab_Land = 5 if f02b == "CZ"
replace Ab_Land = 6 if f02b == "DK"
replace Ab_Land = 7 if f02b == "E"
replace Ab_Land = 8 if f02b == "F"
replace Ab_Land = 9 if f02b == "FIN"
replace Ab_Land = 10 if f02b == "GB"
replace Ab_Land = 11 if f02b == "h" | f02b=="H"
replace Ab_Land = 12 if f02b == "HR"
replace Ab_Land = 13 if f02b == "I"
replace Ab_Land = 14 if f02b == "IRL"
replace Ab_Land = 15 if f02b == "L"
replace Ab_Land = 16 if f02b == "NL"
replace Ab_Land = 17 if f02b == "P"
replace Ab_Land = 18 if f02b == "PL"
replace Ab_Land = 19 if f02b == "S"
replace Ab_Land = 20 if f02b == "SLO"
replace Ab_Land = .a if f02b == "-1"
replace Ab_Land = .z if f02b == "-9"

label variable Ab_Land "Abfahrtsland"
label define Ab_Land 1 `"D"', modify
label define Ab_Land 2 `"A"', modify
label define Ab_Land 3 `"B"', modify
label define Ab_Land 4 `"CH"', modify
label define Ab_Land 5 `"CZ"', modify
label define Ab_Land 6 `"DK"', modify
label define Ab_Land 7 `"E"', modify
label define Ab_Land 8 `"F"', modify
label define Ab_Land 9 `"FIN"', modify
label define Ab_Land 10 `"GB"', modify
label define Ab_Land 11 `"h"', modify
label define Ab_Land 12 `"HR"', modify
label define Ab_Land 13 `"I"', modify
label define Ab_Land 14 `"IRL"', modify
label define Ab_Land 15 `"L"', modify
label define Ab_Land 16 `"NL"', modify
label define Ab_Land 17 `"P"', modify
label define Ab_Land 18 `"PL"', modify
label define Ab_Land 19 `"S"', modify
label define Ab_Land 20 `"SLO"', modify
label define Ab_Land .a `"keine Angabe"', modify
label define Ab_Land .z `"Merkmal nicht erhoben"', modify
label value Ab_Land Ab_Land

gen An_Land =1 if f08b =="D"
replace An_Land = 2 if f08b == "A"
replace An_Land = 3 if f08b == "B"
replace An_Land = 4 if f08b == "CH"
replace An_Land = 5 if f08b == "CZ"
replace An_Land = 6 if f08b == "DK"
replace An_Land = 7 if f08b == "E"
replace An_Land = 8 if f08b == "F"
replace An_Land = 9 if f08b == "FIN"
replace An_Land = 10 if f08b == "GB"
replace An_Land = 11 if f08b == "H"
replace An_Land = 12 if f08b == "HR"
replace An_Land = 13 if f08b == "I"
replace An_Land = 14 if f08b == "L"
replace An_Land = 15 if f08b == "N"
replace An_Land = 16 if f08b == "NL"
replace An_Land = 17 if f08b == "P"
replace An_Land = 18 if f08b == "PL"
replace An_Land = 19 if f08b == "RO"
replace An_Land = 20 if f08b == "S"
replace An_Land = 21 if f08b == "SK"
replace An_Land = 22 if f08b == "SLO"
replace An_Land = 23 if f08b == "TR"
replace An_Land = .a if f08b == "-1"
replace An_Land = .z if f08b == "-9"

label variable An_Land "Anfahrtsland"
label define An_Land 1 `"D"', modify
label define An_Land 2 `"A"', modify
label define An_Land 3 `"B"', modify
label define An_Land 4 `"CH"', modify
label define An_Land 5 `"CZ"', modify
label define An_Land 6 `"DK"', modify
label define An_Land 7 `"E"', modify
label define An_Land 8 `"F"', modify
label define An_Land 9 `"FIN"', modify
label define An_Land 10 `"GB"', modify
label define An_Land 11 `"H"', modify
label define An_Land 12 `"HR"', modify
label define An_Land 13 `"I"', modify
label define An_Land 14 `"L"', modify
label define An_Land 15 `"N"', modify
label define An_Land 16 `"NL"', modify
label define An_Land 17 `"P"', modify
label define An_Land 18 `"PL"', modify
label define An_Land 19 `"RO"', modify
label define An_Land 20 `"S"', modify
label define An_Land 21 `"SK"', modify
label define An_Land 22 `"SLO"', modify
label define An_Land 23 `"TR"', modify
label define An_Land .a `"keine Angabe"', modify
label define An_Land .z `"Merkmal nicht erhoben"', modify
label value An_Land An_Land
