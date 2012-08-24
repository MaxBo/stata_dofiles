local my_path "$Y\H\EWDaten\\"
local my_mdb "HAN"
odbc load, dialog(complete) dsn("$AccessDB;DBQ=`my_path'`my_mdb'") /*
*/ exec("SELECT int(NO_) AS VZNR, TypeNO, AnSchiene FROM VZ_VEP") clear

rename  VZNR VZNR_AP
sort VZNR_AP
merge VZNR_AP using "D:\DatenMaxDiss\MiD-H\Stata\P_OVKosten.dta",uniqmaster
drop _merge
sort PersId
merge PersId using "D:\DatenMaxDiss\MiD-H\Stata\MidH_P0.dta",uniqusing

recode TypeNO (1 2 = 1) (3/6 = 3),gen(TypSchiene)
replace TypSchiene = TypSchiene + AnSchiene
label define TypSchiene 1 "HAN ohne Schiene" 2 "HAN mit Schiene" 3 "Uml ohne Schiene" 4 "Uml mit Schiene"
label values TypSchiene TypSchiene
recode TypeNO (1 = 1) (2 = 3) (3 4 = 5) (5 6 = 7),gen(TypSchiene8)
replace TypSchiene8 = TypSchiene8 + AnSchiene
label define TypSchiene8 1 "H_Innenstadt ohne Schiene" 2 "H_Innenstadt mit Schiene" /*
*/ 3 "H_Rand ohne Schiene" 4 "H_Rand mit Schiene" /*
*/ 5 "Uml1 ohne Schiene" 6 "Uml2 mit Schiene" /*
*/ 7 "Uml2 ohne Schiene" 8 "Uml2 mit Schiene"
label values TypSchiene8 TypSchiene8
tab TypSchiene pTicket,row nof