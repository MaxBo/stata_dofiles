use D:\DatenMaxDiss\MiD-H\Stata\P.dta, clear
keep p01 p06 p052 p054 p041 p042 p11 gew_pa

recode p01 (-400/0=.a) (1=2 "immer")(2 3=1 "gelegentlich") (4 6 = 2 "nein") (7/9= .b), gen(pkw_verf)
rename gew_pa P_GEW
gen y2011=0

recode p11(1=0 "Mann") (2=1 "Frau") (9=.a), gen(Frau)

replace p054 = p052 if p054==96
recode p054 (1/4=1 "ja") (5/8=0 "nein")(97/99=.e), gen(an_schiene)
recode p041 p042 (6/9=.e)
rename p041 err_ov
rename p042 err_iv
recode p06 (2=0 "Nein") (7/8=.g), gen(fhs)

drop p01 p052 p054 p11 p06
save "D:\DatenMaxDiss\MiD-H\MIR\temp\pers_2002.dta", replace



use "W:\mobil\01 Projekte\1217 Evaluation VEP Hannover\40 Daten\MIR-2011\stata\personen.dta", clear
keep P01_1 P06 HP_SEX P052 P054 P041 P042 P_GEW

recode P01_1 (-400/0=.a) (1=2 "immer") (2=1 "gelegentlich") (3 6 = 0 "nein") (7/9= .b), gen(pkw_verf)
gen y2011=1

recode HP_SEX(1=0 "Mann") (2=1 "Frau") (9=.a), gen(Frau)

replace P054 = P052 if P054==96
recode P054 (1/4=1 "ja") (5/8=0 "nein")(97/99=.e), gen(an_schiene)
recode P041 P042 (6/9=.e)
rename P041 err_ov
rename P042 err_iv
recode P06 (2=0 "Nein") (7/8=.g), gen(fhs)

drop P01_1 P052 P054 HP_SEX P06
save "D:\DatenMaxDiss\MiD-H\MIR\temp\pers_2011.dta", replace
append using "D:\DatenMaxDiss\MiD-H\MIR\temp\pers_2002.dta"
compress

misschk err_ov an_schiene fhs Frau y2011


ologit err_ov an_schiene fhs Frau y2011 [iw=P_GEW]
keep in 1/2
* Hier "Musterpersonen bauen"
predict sehr_gut gut mittel schlecht sehr_schlecht

