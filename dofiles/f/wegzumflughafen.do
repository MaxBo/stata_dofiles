* für Schätzmodelle

clear
set memory 32m

* for i = 

use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\MiD_2008_Wege_zeitn5_akt.dta", clear

bysort HHID PID:gen vorfahrzeit = fahrzeit[_n-1]
bysort HHID PID:gen nachfahrzeit = fahrzeit[_n-1]

bysort HHID PID: gen vorW05_1 = W05_1[_n-1]
bysort HHID PID: gen vorW05_2 = W05_2[_n-1]
bysort HHID PID: gen vorW05_3 = W05_3[_n-1]
bysort HHID PID: gen vorW05_4 = W05_4[_n-1]
bysort HHID PID: gen vorW05_5 = W05_5[_n-1]
bysort HHID PID: gen vorW05_7 = W05_7[_n-1]
bysort HHID PID: gen vorW05_11 = W05_11[_n-1]
bysort HHID PID: gen vorW05_12 = W05_12[_n-1]
bysort HHID PID: gen vorW05_13 = W05_13[_n-1]
bysort HHID PID: gen vorW05_14 = W05_14[_n-1]
bysort HHID PID: gen vorW05_15 = W05_15[_n-1]
bysort HHID PID: gen vorW05_16 = W05_16[_n-1]
bysort HHID PID: gen vorW05_17 = W05_17[_n-1]
bysort HHID PID: gen vorW05_18 = W05_18[_n-1]
bysort HHID PID: gen vorW05_20 = W05_20[_n-1]
bysort HHID PID: gen vorW05_22 = W05_22[_n-1]
bysort HHID PID: gen vorW05_23 = W05_23[_n-1]
bysort HHID PID: gen vorMRAD_F = MRAD_F[_n-1]
bysort HHID PID: gen vorMRAD_MF = MRAD_MF[_n-1]
bysort HHID PID: gen vorPKW_F = PKW_F[_n-1]
bysort HHID PID: gen vorPKW_MF = PKW_MF[_n-1]
bysort HHID PID: gen vorLKW_F = LKW_F[_n-1]
bysort HHID PID: gen vorLKW_MF = LKW_MF[_n-1]


label define vorLKW_MF .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define vorLKW_MF .x `"Weg nicht mit Lkw"', modify
label define vorLKW_F .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define vorLKW_F .x `"Weg nicht mit Lkw"', modify
label define vorPKW_MF .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define vorPKW_MF .y `"Weg nicht mit Pkw"', modify
label define vorPKW_F .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define vorPKW_F .y `"Weg nicht mit Pkw"', modify
label define vorMRAD_MF .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define vorMRAD_MF .z `"Weg nicht mit Motorrad"', modify
label define vorMRAD_F .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define vorMRAD_F .z `"Weg nicht mit Motorrad"', modify
label define vorW05_1 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_2 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_3 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_4 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_5 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_7 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_11 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_12 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_13 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_14 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_15 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_16 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_17 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_18 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_20 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_22 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorW05_23 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorMRAD_F 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorMRAD_MF 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorPKW_F 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorPKW_MF 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorLKW_F 0 `"nicht genannt"' 1 `"genannt"', modify
label define vorLKW_MF 0 `"nicht genannt"' 1 `"genannt"', modify
label value vorW05_1 vorW05_1
label value vorW05_2 vorW05_2
label value vorW05_3 vorW05_3
label value vorW05_4 vorW05_4
label value vorW05_5 vorW05_5
label value vorW05_7 vorW05_7
label value vorW05_11 vorW05_11
label value vorW05_12 vorW05_12
label value vorW05_13 vorW05_13
label value vorW05_14 vorW05_14
label value vorW05_15 vorW05_15
label value vorW05_16 vorW05_16
label value vorW05_17 vorW05_17
label value vorW05_18 vorW05_18
label value vorW05_20 vorW05_20
label value vorW05_22 vorW05_22
label value vorW05_23 vorW05_23
label value vorMRAD_F vorMRAD_F
label value vorMRAD_MF vorMRAD_MF
label value vorPKW_F vorPKW_F
label value vorPKW_MF vorPKW_MF
label value vorLKW_F vorLKW_F
label value vorLKW_MF vorLKW_MF

bysort HHID PID: gen nachW05_1 = W05_1[_n+1]
bysort HHID PID: gen nachW05_2 = W05_2[_n+1]
bysort HHID PID: gen nachW05_3 = W05_3[_n+1]
bysort HHID PID: gen nachW05_4 = W05_4[_n+1]
bysort HHID PID: gen nachW05_5 = W05_5[_n+1]
bysort HHID PID: gen nachW05_7 = W05_7[_n+1]
bysort HHID PID: gen nachW05_11 = W05_11[_n+1]
bysort HHID PID: gen nachW05_12 = W05_12[_n+1]
bysort HHID PID: gen nachW05_13 = W05_13[_n+1]
bysort HHID PID: gen nachW05_14 = W05_14[_n+1]
bysort HHID PID: gen nachW05_15 = W05_15[_n+1]
bysort HHID PID: gen nachW05_16 = W05_16[_n+1]
bysort HHID PID: gen nachW05_17 = W05_17[_n+1]
bysort HHID PID: gen nachW05_18 = W05_18[_n+1]
bysort HHID PID: gen nachW05_20 = W05_20[_n+1]
bysort HHID PID: gen nachW05_22 = W05_22[_n+1]
bysort HHID PID: gen nachW05_23 = W05_23[_n+1]
bysort HHID PID: gen nachMRAD_F = MRAD_F[_n+1]
bysort HHID PID: gen nachMRAD_MF = MRAD_MF[_n+1]
bysort HHID PID: gen nachPKW_F = PKW_F[_n+1]
bysort HHID PID: gen nachPKW_MF = PKW_MF[_n+1]
bysort HHID PID: gen nachLKW_F = LKW_F[_n+1]
bysort HHID PID: gen nachLKW_MF = LKW_MF[_n+1]


label define nachLKW_MF .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define nachLKW_MF .x `"Weg nicht mit Lkw"', modify
label define nachLKW_F .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define nachLKW_F .x `"Weg nicht mit Lkw"', modify
label define nachPKW_MF .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define nachPKW_MF .y `"Weg nicht mit Pkw"', modify
label define nachPKW_F .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define nachPKW_F .y `"Weg nicht mit Pkw"', modify
label define nachMRAD_MF .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define nachMRAD_MF .z `"Weg nicht mit Motorrad"', modify
label define nachMRAD_F .j `"bei rbW Fahrer/Mitfahrer nicht erhoben"', modify
label define nachMRAD_F .z `"Weg nicht mit Motorrad"', modify
label define nachW05_1 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_2 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_3 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_4 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_5 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_7 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_11 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_12 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_13 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_14 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_15 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_16 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_17 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_18 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_20 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_22 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachW05_23 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachMRAD_F 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachMRAD_MF 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachPKW_F 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachPKW_MF 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachLKW_F 0 `"nicht genannt"' 1 `"genannt"', modify
label define nachLKW_MF 0 `"nicht genannt"' 1 `"genannt"', modify

label value nachW05_1 nachW05_1
label value nachW05_2 nachW05_2
label value nachW05_3 nachW05_3
label value nachW05_4 nachW05_4
label value nachW05_5 nachW05_5
label value nachW05_7 nachW05_7
label value nachW05_11 nachW05_11
label value nachW05_12 nachW05_12
label value nachW05_13 nachW05_13
label value nachW05_14 nachW05_14
label value nachW05_15 nachW05_15
label value nachW05_16 nachW05_16
label value nachW05_17 nachW05_17
label value nachW05_18 nachW05_18
label value nachW05_20 nachW05_20
label value nachW05_22 nachW05_22
label value nachW05_23 nachW05_23
label value nachMRAD_F nachMRAD_F
label value nachMRAD_MF nachMRAD_MF
label value nachPKW_F nachPKW_F
label value nachPKW_MF nachPKW_MF
label value nachLKW_F nachLKW_F
label value nachLKW_MF nachLKW_MF

* clogit vorfahrzeit vorW* vorM* vorL* vorP* nachW* nachM* nachL* nachP* if bearbeitet != 5 &  W05_18 ==1, group(Zweck)
* br   WSIDN  Anz_Wege ST_STD_korr ST_MIN EN_STD_korr EN_MIN  HVM_DIFF W04 W04_DZW HWZWECK W01 W13 W044 if  W05_18==1 | nachW05_18==1 | vorW05_18==1