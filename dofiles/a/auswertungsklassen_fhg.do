clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_7.dta", clear

gen altersgruppe = 1 if alter<20
replace altersgruppe = 2 if alter <30 & alter >=20
replace altersgruppe = 3 if alter <40 & alter >=30
replace altersgruppe = 4 if alter <50 & alter >=40
replace altersgruppe = 5 if alter <60 & alter >=50
replace altersgruppe = 6 if alter <70 & alter >=60
replace altersgruppe = 7 if alter <80 & alter >=70
replace altersgruppe = 8 if alter <90 & alter >=80
replace altersgruppe = 9 if alter <100 & alter >=90

label define alter 1 `"< 20"', modify
label define alter 2 `"20 - 30"', modify
label define alter 3 `"30 - 40"', modify
label define alter 4 `"40 - 50"', modify
label define alter 5 `"50 - 60"', modify
label define alter 6 `"60 - 70"', modify
label define alter 7 `"70 - 80"', modify
label define alter 8 `"80 - 90"', modify
label define alter 9 `"90 - 100"', modify

label value altersgruppe alter
label var altersgruppe "Altersgruppe (10-Jahre)"

gen altersgruppe2 = 1 if alter<25
replace altersgruppe2 = 2 if alter <45 & alter >=25
replace altersgruppe2 = 3 if alter <65 & alter >=45
replace altersgruppe2 = 4 if alter <100 & alter >=65


label define alter2 1 `"< 25"', modify
label define alter2 2 `"25 - 45"', modify
label define alter2 3 `"45 - 65"', modify
label define alter2 4 `"65 - 100"', modify

label value altersgruppe2 alter2
label var altersgruppe2 "Altersgruppe 25-45-65"

gen f13_aggr = 1 if f13 ==0
replace f13_aggr = 2 if f13>0 & f13<8
replace f13_aggr = 3 if f13>7 & f13<15
replace f13_aggr = 4 if f13>14 & f13<22
replace f13_aggr = 5 if f13>21 & f13<2000

label define f13_aggr 1 `"gleicher Tag"', modify
label define f13_aggr 2 `"bis zu einer Woche"', modify
label define f13_aggr 3 `"14 Tage"', modify
label define f13_aggr 4 `"3 Wochen"', modify
label define f13_aggr 5 `"länger als 3 Wochen"', modify
label value f13_aggr f13_aggr
label var f13_aggr "Gesamtreisedauer zu Wochen zusammengefasst"

gen f24_aggr = 1 if f24_neu ==0.5
replace f24_aggr = 2 if f24_neu >0.5 & f24_neu < 8
replace f24_aggr = 3 if f24_neu > 7 & f24_neu < 15
replace f24_aggr = 4 if f24_neu > 14 & f24_neu < 22
replace f24_aggr = 5 if f24_neu > 21 & f24_neu < 29
replace f24_aggr = 6 if f24_neu > 28 & f24_neu < 36
replace f24_aggr = 7 if f24_neu > 35 & f24_neu < 43
replace f24_aggr = 8 if f24_neu > 42 & f24_neu < 50
replace f24_aggr = 9 if f24_neu > 49 & f24_neu < 61
replace f24_aggr = 10 if f24_neu > 60 & f24_neu < 91
replace f24_aggr = 11 if f24_neu > 90 & f24_neu < 121
replace f24_aggr = 12 if f24_neu > 120 & f24_neu < 151
replace f24_aggr = 13 if f24_neu > 150 & f24_neu < 181
replace f24_aggr = 14 if f24_neu > 180 & f24_neu < 211
replace f24_aggr = 15 if f24_neu > 210 & f24_neu < 721

label define f24_aggr 1 `"gleicher Tag"', modify
label define f24_aggr 2 `"1 Woche"', modify
label define f24_aggr 3 `"2 Wochen"', modify
label define f24_aggr 4 `"3 Wochen"', modify
label define f24_aggr 5 `"4 Wochen"', modify
label define f24_aggr 6 `"5 Wochen"', modify
label define f24_aggr 7 `"6 Wochen"', modify
label define f24_aggr 8 `"7 Wochen"', modify
label define f24_aggr 9 `"60 Tage"', modify
label define f24_aggr 10 `"90 Tage"', modify
label define f24_aggr 11 `"120 Tage"', modify
label define f24_aggr 12 `"150 Tage"', modify
label define f24_aggr 13 `"180 Tage"', modify
label define f24_aggr 14 `"210 Tage"', modify
label define f24_aggr 15 `"mehr als 210 Tage"', modify

label value f24_aggr f24_aggr
label var f24_aggr "Flugvorausbuchungszeit"

gen f32_aggr=1 if f32<=30
replace f32_aggr = 2 if f32>30 & f32<=45
replace f32_aggr = 3 if f32>45 & f32<=60
replace f32_aggr = 4 if f32>60 & f32<=75
replace f32_aggr = 5 if f32>75 & f32<=90
replace f32_aggr = 6 if f32>90 & f32<=105
replace f32_aggr = 7 if f32>105 & f32<=120
replace f32_aggr = 8 if f32>120 & f32<=150
replace f32_aggr = 9 if f32>150 & f32<=180
replace f32_aggr = 10 if f32>180 & f32<=210
replace f32_aggr = 11 if f32>210 & f32<=240
replace f32_aggr = 12 if f32>240 & f32<=1440

label define f32_aggr 1 `"<= 30min"', modify
label define f32_aggr 2 `"]30min;45min]"', modify
label define f32_aggr 3 `"]45min;60min]"', modify
label define f32_aggr 4 `"]60min;75min]"', modify
label define f32_aggr 5 `"]75min;90min]"', modify
label define f32_aggr 6 `"]90min;105min]"', modify
label define f32_aggr 7 `"]105min;120min]"', modify
label define f32_aggr 8 `"]120min;150min]"', modify
label define f32_aggr 9 `"]150min;180min]"', modify
label define f32_aggr 10 `"]180min;210min]"', modify
label define f32_aggr 11 `"]210min;240min]"', modify
label define f32_aggr 12 `">240"', modify

label value f32_aggr f32_aggr
label var f32_aggr "Ankunftszeit am Flughafen"

gen f32_aggr2=1 if f32<=30
replace f32_aggr2 = 2 if f32>30 & f32<=60
replace f32_aggr2 = 3 if f32>60 & f32<=90
replace f32_aggr2 = 4 if f32>90 & f32<=120
replace f32_aggr2 = 5 if f32>120 & f32<=150
replace f32_aggr2 = 6 if f32>150 & f32<=180
replace f32_aggr2 = 7 if f32>180 & f32<=210
replace f32_aggr2 = 8 if f32>210 & f32<=240
replace f32_aggr2 = 9 if f32>240 & f32<=1440

label define f32_aggr2 1 `"<= 30min"', modify
label define f32_aggr2 2 `"]30min;60min]"', modify
label define f32_aggr2 3 `"]60min;90min]"', modify
label define f32_aggr2 4 `"]90min;120min]"', modify
label define f32_aggr2 5 `"]120min;150min]"', modify
label define f32_aggr2 6 `"]150min;180min]"', modify
label define f32_aggr2 7 `"]180min;210min]"', modify
label define f32_aggr2 8 `"]210min;240min]"', modify
label define f32_aggr2 9 `">240"', modify

label value f32_aggr2 f32_aggr2
label var f32_aggr2 "Ankunftszeit am Flughafen (9 Kl.)"

label var f12n "Quell-,Zielverkehr, Umsteiger"

gen VM_Zubring_0_diff = 1 if f25==1 | f25==2 | f25 ==5 | f25==6 | f25==12 | f25==16
replace VM_Zubring_0_diff = 2 if f25==3 | f25==4 | f25 ==29 | f25==27 | f25==28
replace VM_Zubring_0_diff = 3 if  VM_Zubring_0 == 2 & missing(VM_Zubring_0_diff)
replace VM_Zubring_0_diff = 5 if  f25==25 | f25==23 | f25==30
replace VM_Zubring_0_diff = 6 if  f25==14
replace VM_Zubring_0_diff = 4 if f25==10 | f25==11 | f25==13

label define vm_diff 1 `"MIV-kur"', modify
label define vm_diff 2 `"MIV-lang"', modify
label define vm_diff 3 `"ÖPNV"', modify
label define vm_diff 4 `"ÖPFV"', modify
label define vm_diff 5 `"NMIV"', modify
label define vm_diff 6 `"Flug"', modify
label value VM_Zubring_0_diff vm_diff
label var VM_Zubring_0_diff "letztes Zubringerfahrzeug differenziert"

label var f32 "Ankunft am HAM vor planmäßigem Abflug"
 

gen flugart = 1 if charakter=="IT"
replace flugart = 2 if charakter == "LC"
replace flugart = 3 if charakter == "LI"
replace flugart = 4 if charakter == "SO"

label define flugart 1 `"Touristikverkehr"', modify
label define flugart 2 `"Low-Cost-Verkehr"', modify
label define flugart 3 `"Klassischer Linienverkehr"', modify
label define flugart 4 `"sonstiger Verkehr"', modify
label value flugart flugart
label var flugart "Charakter der Flugverbindung"

quietly replace flugart = 1 if missing(flugart) & flug == "4R"
quietly replace flugart = 1 if missing(flugart) & flug == "BUC"
quietly replace flugart = 1 if missing(flugart) & flug == "DE"
quietly replace flugart = 1 if missing(flugart) & flug == "FHY"
quietly replace flugart = 1 if missing(flugart) & flug == "H9"
quietly replace flugart = 1 if missing(flugart) & flug == "HF"
quietly replace flugart = 1 if missing(flugart) & flug == "INX"
quietly replace flugart = 1 if missing(flugart) & flug == "JK"
quietly replace flugart = 1 if missing(flugart) & flug == "OU"
quietly replace flugart = 1 if missing(flugart) & flug == "QW"
quietly replace flugart = 1 if missing(flugart) & flug == "SHY"
quietly replace flugart = 1 if missing(flugart) & flug == "ST"
quietly replace flugart = 1 if missing(flugart) & flug == "TSC"
quietly replace flugart = 1 if missing(flugart) & flug == "VIM"
quietly replace flugart = 1 if missing(flugart) & flug == "XQ"
quietly replace flugart = 2 if missing(flugart) & flug == "3L"
quietly replace flugart = 2 if missing(flugart) & flug == "4U"
quietly replace flugart = 2 if missing(flugart) & flug == "BE"
quietly replace flugart = 2 if missing(flugart) & flug == "BT"
quietly replace flugart = 2 if missing(flugart) & flug == "DY"
quietly replace flugart = 2 if missing(flugart) & flug == "EI"
quietly replace flugart = 2 if missing(flugart) & flug == "EZS"
quietly replace flugart = 2 if missing(flugart) & flug == "EZY"
quietly replace flugart = 2 if missing(flugart) & flug == "HV"
quietly replace flugart = 2 if missing(flugart) & flug == "OV"
quietly replace flugart = 3 if missing(flugart) & flug == "AF"
quietly replace flugart = 3 if missing(flugart) & flug == "AY"
quietly replace flugart = 3 if missing(flugart) & flug == "BA"
quietly replace flugart = 3 if missing(flugart) & flug == "C9"
quietly replace flugart = 3 if missing(flugart) & flug == "CO"
quietly replace flugart = 3 if missing(flugart) & flug == "EK"
quietly replace flugart = 3 if missing(flugart) & flug == "FV"
quietly replace flugart = 3 if missing(flugart) & flug == "IN"
quietly replace flugart = 3 if missing(flugart) & flug == "IR"
quietly replace flugart = 3 if missing(flugart) & flug == "JZ"
quietly replace flugart = 3 if missing(flugart) & flug == "KD"
quietly replace flugart = 3 if missing(flugart) & flug == "KF"
quietly replace flugart = 3 if missing(flugart) & flug == "KL"
quietly replace flugart = 3 if missing(flugart) & flug == "KM"
quietly replace flugart = 3 if missing(flugart) & flug == "LG"
quietly replace flugart = 3 if missing(flugart) & flug == "LO"
quietly replace flugart = 3 if missing(flugart) & flug == "LX"
quietly replace flugart = 3 if missing(flugart) & flug == "MA"
quietly replace flugart = 3 if missing(flugart) & flug == "OK"
quietly replace flugart = 3 if missing(flugart) & flug == "OL"
quietly replace flugart = 3 if missing(flugart) & flug == "OS"
quietly replace flugart = 3 if missing(flugart) & flug == "SK"
quietly replace flugart = 3 if missing(flugart) & flug == "SN"
quietly replace flugart = 3 if missing(flugart) & flug == "SU"
quietly replace flugart = 3 if missing(flugart) & flug == "TK"
quietly replace flugart = 3 if missing(flugart) & flug == "TP"
quietly replace flugart = 3 if missing(flugart) & flug == "VG"
quietly replace flugart = 3 if missing(flugart) & flug == "VV"
quietly replace flugart = 3 if missing(flugart) & flug == "LH"
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==40
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==50
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==70
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==90
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==605
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==675
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==1520
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2040
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2210
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2550
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2700
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2730
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2750
quietly replace flugart=2 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2801
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==80
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2240
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2260
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2270
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2350
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2360
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2370
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2400
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2412
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2420
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2430
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2460
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2480
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2490
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2820
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2870
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2920
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2950
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==2980
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3000
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3110
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3120
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3170
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3190
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3200
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3220
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3330
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==3340
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==4040
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==4160
quietly replace flugart=1 if missing(flugart) & (flug=="AB" | flug=="TU" | flug=="X3") & destination==4170

quietly replace flugart = 1 if missing(flugart) & flug=="PGT" & destination ==3340
quietly replace flugart = 1 if missing(flugart) & flug=="PGT" & destination ==3300
quietly replace flugart = 1 if missing(flugart) & flug=="PGT" & destination ==3342
quietly replace flugart = 1 if missing(flugart) & flug=="PRJ" & destination ==3504
quietly replace flugart = 3 if missing(flugart) & flug=="TE" & destination ==1052
quietly replace flugart = 1 if missing(flugart) & flug=="TRK" & destination ==3310
quietly replace flugart = 3 if missing(flugart) & flug=="TU" & destination ==4150
quietly replace flugart = 4 if missing(flugart) & flug=="TZ" & destination ==160
quietly replace flugart = 1 if missing(flugart) & flug=="X3" & destination ==4280
quietly replace flugart = 2 if missing(flugart) & flug=="HLX" & destination ==2820
quietly replace flugart = 2 if missing(flugart) & flug=="HLX" & destination ==2730
quietly replace flugart = 2 if missing(flugart) & flug=="HLX" & destination ==2200
quietly replace flugart = 2 if missing(flugart) & flug=="HLX" & destination ==2750
quietly replace flugart = 2 if missing(flugart) & flug=="HLX" & destination ==50
quietly replace flugart = 1 if missing(flugart) & flug=="IWD" & destination ==2400
quietly replace flugart = 2 if missing(flugart) & flug=="KAJ" & destination ==4170
quietly replace flugart = 1 if missing(flugart) & flug=="KK" & destination ==3310
quietly replace flugart = 1 if missing(flugart) & flug=="KK" & destination ==3340
quietly replace flugart = 1 if missing(flugart) & flug=="KK" & destination ==3344
quietly replace flugart = 2 if missing(flugart) & flug=="LFM" & destination ==3536
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==3760
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2410
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==4060
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==3170
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==3110
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2350
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==4170
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2400
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==4040
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2420
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2490
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2480
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2400
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==4160
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==3000
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==3770
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==3340
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2260
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==4280
quietly replace flugart = 1 if missing(flugart) & flug=="LT" & destination ==2430
quietly replace flugart = 3 if missing(flugart) & flug=="LT" & destination ==40
quietly replace flugart = 3 if missing(flugart) & flug=="LT" & destination ==70
quietly replace flugart = 3 if missing(flugart) & flug=="LT" & destination ==90
quietly replace flugart = 1 if missing(flugart) & flug=="NRD" & destination ==2350
quietly replace flugart = 3 if missing(flugart) & flug=="OA" & destination ==1052
quietly replace flugart = 3 if missing(flugart) & flug=="OHY" & destination ==3340
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==1376
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==4380
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3200
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==90
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3410
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3320
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3310
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==2420
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3710
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3120
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3340
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==3300
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==70
quietly replace flugart = 1 if missing(flugart) & flug=="HHI" & destination ==4390
quietly replace flugart = 2 if missing(flugart) & flug=="HE" & destination ==70
quietly replace flugart = 2 if missing(flugart) & flug=="HE" & destination ==160
quietly replace flugart = 2 if missing(flugart) & flug=="2Q" & destination ==1270
quietly replace flugart = 2 if missing(flugart) & flug=="8A" & destination ==4280
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==5702
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==9500
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==2435
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==6400
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==9391
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==9540
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==1130
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==2812
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==3810
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==6410
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==2710
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==9345
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==1100
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==60
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==1560
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==8410
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==1400
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==9565
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==3550
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==2813
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==3321
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==2812
quietly replace flugart = 3 if missing(flugart) & flug=="AB" & destination ==1501
quietly replace flugart = 1 if missing(flugart) & flug=="AMV" & destination ==4020
quietly replace flugart = 1 if missing(flugart) & flug=="BJ" & destination ==4170
quietly replace flugart = 1 if missing(flugart) & flug=="BWG" & destination ==3310
quietly replace flugart = 1 if missing(flugart) & flug=="CAI" & destination ==3340
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==2950
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==70
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==3110
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==6080
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==2800
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==2910
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==3504
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==80
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==2080
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==2920
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==90
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==6062
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==8750
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==2880
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==1373
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==3010
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==8410
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==40
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==8740
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==3100
quietly replace flugart = 2 if missing(flugart) & flug=="DI" & destination ==8080
quietly replace flugart = 1 if missing(flugart) & flug=="ECA" & destination ==1501
quietly replace flugart = 3 if missing(flugart) & flug=="FB" & destination ==3760
quietly replace flugart = 3 if missing(flugart) & flug=="FB" & destination ==3770
quietly replace flugart = 1 if missing(flugart) & flug=="FUA" & destination ==2950
quietly replace flugart = 1 if missing(flugart) & flug=="FUA" & destination ==2420


sort Jahr welle destination
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_8.dta", replace

insheet using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\hochrechnungsfaktoren_fluggastbefragung.txt", clear
rename jahr Jahr
label var flug_hochr "Hochrechnungsfaktor für Fallzahlen (Anzahl Flüge/Anzahl Interviews)" 
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\hochrechnungsfaktoren_06_08_09.dta", replace
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_8.dta", clear
// Gewichtungsfaktoren für die Hochrechnung einführen, Anteil Fluggäste je Welle an Gesamtzahl ==> Gewichtungsfaktor für Hochrechnungsfaktor
merge Jahr welle destination using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\hochrechnungsfaktoren_06_08_09.dta", sort uniqus keep(flug_hochr fh_aggr_2009)
drop if missing(lfd)
drop _merge

label var fh_aggr_2009 "Hochrechnungsgruppen nach Schema 2009"

label define gew_gruppe 1 `"H01 Frankfurt"', modify
label define gew_gruppe 2 `"H02 München"', modify
label define gew_gruppe 3 `"H03 Helsinki"', modify
label define gew_gruppe 4 `"H04 Kopenhagen"', modify
label define gew_gruppe 5 `"H05 London-Heathrow"', modify
label define gew_gruppe 6 `"H06 Amsterdam"', modify
label define gew_gruppe 7 `"H07 Brüssel"', modify
label define gew_gruppe 8 `"H08 Paris"', modify
label define gew_gruppe 9 `"H09 Lissabon"', modify
label define gew_gruppe 10 `"H10 Zürich"', modify
label define gew_gruppe 11 `"H11 Wien"', modify
label define gew_gruppe 12 `"H12 Istanbul"', modify
label define gew_gruppe 13 `"H13 Budapest"', modify
label define gew_gruppe 14 `"H14 Prag"', modify
label define gew_gruppe 15 `"H15 Moskau"', modify
label define gew_gruppe 16 `"H16 Amerika"', modify
label define gew_gruppe 17 `"H17 Dubai"', modify
label define gew_gruppe 18 `"L01 Düsseldorf"', modify
label define gew_gruppe 19 `"L02 Köln/Bonn"', modify
label define gew_gruppe 20 `"L03 Stuttgart"', modify
label define gew_gruppe 21 `"L04 Nürnberg"', modify
label define gew_gruppe 22 `"L05 Dresden"', modify
label define gew_gruppe 23 `"L06 Mannheim, Saarbrücken"', modify
label define gew_gruppe 24 `"L07 Karlsruhe/Baden-Baden"', modify
label define gew_gruppe 25 `"L08 Memmingen"', modify
label define gew_gruppe 26 `"L09 übr. Deutschland"', modify
label define gew_gruppe 27 `"L10 Danzig, Warschau"', modify
label define gew_gruppe 28 `"L11 Riga"', modify
label define gew_gruppe 29 `"L12 übr. Baltikum"', modify
label define gew_gruppe 30 `"L13 Stockholm"', modify
label define gew_gruppe 31 `"L14 Oslo"', modify
label define gew_gruppe 32 `"L15 übr. London"', modify
label define gew_gruppe 33 `"L16 Manchester"', modify
label define gew_gruppe 34 `"L17 übr. Großbritannien/Irland"', modify
label define gew_gruppe 35 `"L18 Lyon"', modify
label define gew_gruppe 36 `"L19 Toulouse"', modify
label define gew_gruppe 37 `"L20 übr. Nord- u. Westeuropa"', modify
label define gew_gruppe 38 `"L21 Madrid, Barcelona"', modify
label define gew_gruppe 39 `"L22 Basel"', modify
label define gew_gruppe 40 `"L23 Salzburg"', modify
label define gew_gruppe 41 `"L24 Rom, Mailand"', modify
label define gew_gruppe 42 `"L25 übr. Mittel- / Südeuropa"', modify
label define gew_gruppe 43 `"L26 übr. Osteuropa"', modify
label define gew_gruppe 44 `"L27 Teheran u. übr. Asien"', modify
label define gew_gruppe 45 `"T01 übr. Spanien (Festland)"', modify
label define gew_gruppe 46 `"T02 Mallorca"', modify
label define gew_gruppe 47 `"T03 Las Palmas"', modify
label define gew_gruppe 48 `"T04 Teneriffa"', modify
label define gew_gruppe 49 `"T05 Fuerteventura"', modify
label define gew_gruppe 50 `"T06 übr. Spanien (Inseln)"', modify
label define gew_gruppe 51 `"T07 übr. Portugal, Malta"', modify
label define gew_gruppe 52 `"T08 Griechenland"', modify
label define gew_gruppe 53 `"T09 Antalya"', modify
label define gew_gruppe 54 `"T10 übr. Türkei, Zypern"', modify
label define gew_gruppe 55 `"T11 Burgas, Varna"', modify
label define gew_gruppe 56 `"T12 übr. Afrika"', modify
label value fh_aggr_2009 gew_gruppe


gen flug_hochrr=round(flug_hochr,2)
label var flug_hochrr "Quartalsweise Hochrechnungsfaktoren, 1 Nachkommastelle"
gen eins = 1

bysort fh_aggr_2009 werktag Stunde: gen wk_agggr = _N
bysort fh_aggr_2009 werktag: gen sum_wk_agggr= _N
gen ant_h_werktag = wk_agggr/sum_wk_agggr*100

label var wk_agggr "Anzahl PAX / Tagart / h zum FH-Gruppe"
label var sum_wk_agggr "Anzahl PAX / Tagart zum FH-Gruppe"
label var ant_h_werktag "Anteil der PAX je Werktag / h an GesamtPAX"


save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_9.dta", replace
insheet using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\anteile_tagesgang_wochengang.txt", clear

rename v1 fh_aggr_2009
rename v2 Wochtagart
rename v3 Stunde
rename v4 ant_h_werktag_tats_08
rename v5 werktag

label var ant_h_werktag_tats_08 "Anteil an geflogenen PAX in repräsentativer Woche 2008"
 
save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\Anteile_PAX_tat.dta", replace

use  "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_9.dta", clear
merge fh_aggr_2009 werktag Stunde using "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\Anteile_PAX_tat.dta", sort uniqus keep(ant_h_werktag_tats_08)

drop if missing(lfd)
gen flug_gew_hw =  ant_h_werktag_tats_08/ ant_h_werktag if _merge==3
replace flug_gew_hw=1 if missing(flug_gew_hw)
label var flug_gew_hw "gewichtete Flüge nach tatsächlichem Tagesgang und Wochentagsart (Achtung Lücken!)"




gen unt_ok = 1 if f63==1
replace unt_ok = 4 if f63==2
replace unt_ok = 4 if f63==3
replace unt_ok = 6 if f63==4
replace unt_ok = 4 if f63==5
replace unt_ok = 7 if f63==6
replace unt_ok = 1 if f63==7
replace unt_ok = 7 if f63==9
replace unt_ok = 6 if f63==10
replace unt_ok = 2 if f63==11
replace unt_ok = 2 if f63==12
replace unt_ok = 5 if f63==13
replace unt_ok = 6 if f63==14
replace unt_ok = 4 if f63==15
replace unt_ok = 6 if f63==16
replace unt_ok = 6 if f63==17
replace unt_ok = 4 if f63==18
replace unt_ok = 2 if f63==19
replace unt_ok = 5 if f63==20
replace unt_ok = 4 if f63==21
replace unt_ok = 3 if f63==22
replace unt_ok = 4 if f63==23
replace unt_ok = 3 if f63==24
replace unt_ok = 1 if f63==25
replace unt_ok = 4 if f63==26
replace unt_ok = 2 if f63==27
replace unt_ok = 4 if f63==28
replace unt_ok = 6 if f63==29
replace unt_ok = 2 if f63==30
replace unt_ok = 2 if f63==31
replace unt_ok = 6 if f63==32
replace unt_ok = 7 if f63==33
replace unt_ok = 4 if f63==34
replace unt_ok = 6 if f63==35
replace unt_ok = 4 if f63==36
replace unt_ok = 6 if f63==37
replace unt_ok = 4 if f63==38
replace unt_ok = 4 if f63==39
replace unt_ok = 3 if f63==40
replace unt_ok = 2 if f63==41
replace unt_ok = 7 if f63==42
replace unt_ok = 7 if f63==44
replace unt_ok = 4 if f63==45
replace unt_ok = 4 if f63==46
replace unt_ok = 6 if f63==47
replace unt_ok = 6 if f63==48
replace unt_ok = 1 if f63==49
replace unt_ok = 6 if f63==50
replace unt_ok = 4 if f63==51
replace unt_ok = 2 if f63==52
replace unt_ok = 4 if f63==53
replace unt_ok = 2 if f63==54
replace unt_ok = 6 if f63==55
replace unt_ok = 3 if f63==56
replace unt_ok = 3 if f63==57
replace unt_ok = 4 if f63==58
replace unt_ok = 4 if f63==59
replace unt_ok = 4 if f63==60
replace unt_ok = 2 if f63==61
replace unt_ok = 4 if f63==62
replace unt_ok = 7 if f63==63
replace unt_ok = 5 if f63==64
replace unt_ok = 2 if f63==65
replace unt_ok = 5 if f63==66
replace unt_ok = 4 if f63==67
replace unt_ok = 5 if f63==68
replace unt_ok = 6 if f63==69
replace unt_ok = 1 if f63==70
replace unt_ok = 6 if f63==71
replace unt_ok = 2 if f63==72
replace unt_ok = 3 if f63==73
replace unt_ok = 6 if f63==74
replace unt_ok = 6 if f63==75
replace unt_ok = 1 if f63==76
replace unt_ok = 6 if f63==77
replace unt_ok = 2 if f63==78
replace unt_ok = 5 if f63==79
replace unt_ok = 4 if f63==81
replace unt_ok = 4 if f63==82
replace unt_ok = 2 if f63==83
replace unt_ok = 2 if f63==84
replace unt_ok = 4 if f63==85
replace unt_ok = 1 if f63==86
replace unt_ok = 3 if f63==87
replace unt_ok = 4 if f63==88
replace unt_ok = 3 if f63==89
replace unt_ok = 7 if f63==90
replace unt_ok = 2 if f63==91
replace unt_ok = 2 if f63==92
replace unt_ok = 4 if f63==93
replace unt_ok = 2 if f63==95
replace unt_ok = 3 if f63==96
replace unt_ok = 2 if f63==97
replace unt_ok = 2 if f63==98
replace unt_ok = 4 if f63==99
replace unt_ok = 4 if f63==100
replace unt_ok = 5 if f63==101
replace unt_ok = 4 if f63==102
replace unt_ok = 2 if f63==103
replace unt_ok = 2 if f63==104
replace unt_ok = 2 if f63==105
replace unt_ok = 3 if f63==106
replace unt_ok = 3 if f63==107
replace unt_ok = 7 if f63==108
replace unt_ok = 2 if f63==109
replace unt_ok = 2 if f63==110
replace unt_ok = 4 if f63==111
replace unt_ok = 1 if f63==112
replace unt_ok = 3 if f63==113
replace unt_ok = 2 if f63==114
replace unt_ok = 4 if f63==116
replace unt_ok = 2 if f63==117
replace unt_ok = 2 if f63==118
replace unt_ok = 7 if f63==119
replace unt_ok = 2 if f63==120
replace unt_ok = 3 if f63==121
replace unt_ok = 2 if f63==122
replace unt_ok = 6 if f63==123
replace unt_ok = 6 if f63==124
replace unt_ok = 6 if f63==125
replace unt_ok = 2 if f63==126
replace unt_ok = 1 if f63==127
replace unt_ok = 2 if f63==128
replace unt_ok = 2 if f63==129
replace unt_ok = 7 if f63==130
replace unt_ok = 7 if f63==131
replace unt_ok = 6 if f63==132
replace unt_ok = 2 if f63==133
replace unt_ok = 2 if f63==134
replace unt_ok = 4 if f63==135
replace unt_ok = 4 if f63==136
replace unt_ok = 5 if f63==137
replace unt_ok = 3 if f63==138
replace unt_ok = 5 if f63==139
replace unt_ok = 2 if f63==140
replace unt_ok = 2 if f63==141
replace unt_ok = 4 if f63==142
replace unt_ok = 4 if f63==144
replace unt_ok = 2 if f63==145
replace unt_ok = 2 if f63==146
replace unt_ok = 3 if f63==147
replace unt_ok = 2 if f63==148
replace unt_ok = 6 if f63==149
replace unt_ok = 4 if f63==150
replace unt_ok = 3 if f63==151
replace unt_ok = 2 if f63==152
replace unt_ok = 2 if f63==153
replace unt_ok = 4 if f63==154
replace unt_ok = 4 if f63==156
replace unt_ok = 2 if f63==157
replace unt_ok = 1 if f63==158
replace unt_ok = 4 if f63==160
replace unt_ok = 5 if f63==161
replace unt_ok = 2 if f63==162
replace unt_ok = 3 if f63==163
replace unt_ok = 2 if f63==164
replace unt_ok = 3 if f63==165
replace unt_ok = 2 if f63==166
replace unt_ok = 4 if f63==167
replace unt_ok = 4 if f63==168
replace unt_ok = 3 if f63==169
replace unt_ok = 4 if f63==170
replace unt_ok = 3 if f63==171
replace unt_ok = 3 if f63==172
replace unt_ok = 5 if f63==173
replace unt_ok = 6 if f63==174
replace unt_ok = 3 if f63==175
replace unt_ok = 3 if f63==176
replace unt_ok = 1 if f63==177
replace unt_ok = 6 if f63==179
replace unt_ok = 3 if f63==180
replace unt_ok = 4 if f63==182
replace unt_ok = 2 if f63==183
replace unt_ok = 2 if f63==184
replace unt_ok = 2 if f63==185
replace unt_ok = 6 if f63==186
replace unt_ok = 2 if f63==187
replace unt_ok = 3 if f63==188
replace unt_ok = 2 if f63==189
replace unt_ok = 3 if f63==190
replace unt_ok = 2 if f63==191
replace unt_ok = 2 if f63==192
replace unt_ok = 2 if f63==193
replace unt_ok = 2 if f63==194
replace unt_ok = 6 if f63==195
replace unt_ok = 2 if f63==196
replace unt_ok = 2 if f63==198
replace unt_ok = 2 if f63==199
replace unt_ok = 6 if f63==200
replace unt_ok = 4 if f63==201
replace unt_ok = 6 if f63==202
replace unt_ok = 2 if f63==203
replace unt_ok = 5 if f63==204
replace unt_ok = 3 if f63==205
replace unt_ok = 4 if f63==206
replace unt_ok = 1 if f63==207
replace unt_ok = 2 if f63==208
replace unt_ok = 2 if f63==209
replace unt_ok = 4 if f63==210
replace unt_ok = 3 if f63==213
replace unt_ok = 4 if f63==214
replace unt_ok = 4 if f63==215
replace unt_ok = 2 if f63==216
replace unt_ok = 3 if f63==217
replace unt_ok = 4 if f63==218
replace unt_ok = 1 if f63==219
replace unt_ok = 2 if f63==220
replace unt_ok = 2 if f63==221
replace unt_ok = 3 if f63==222
replace unt_ok = 7 if f63==223
replace unt_ok = 2 if f63==224
replace unt_ok = 5 if f63==225
replace unt_ok = 4 if f63==226
replace unt_ok = 2 if f63==227
replace unt_ok = 3 if f63==228
replace unt_ok = 2 if f63==229
replace unt_ok = 4 if f63==230
replace unt_ok = 2 if f63==231
replace unt_ok = 1 if f63==232
replace unt_ok = 3 if f63==233
replace unt_ok = 2 if f63==234
replace unt_ok = 2 if f63==235
replace unt_ok = 4 if f63==236
replace unt_ok = 6 if f63==237
replace unt_ok = 1 if f63==238
replace unt_ok = 5 if f63==239
replace unt_ok = 2 if f63==240
replace unt_ok = 5 if f63==241
replace unt_ok = 2 if f63==242
replace unt_ok = 6 if f63==243
replace unt_ok = 7 if f63==245
replace unt_ok = 2 if f63==246
replace unt_ok = 4 if f63==247
replace unt_ok = 4 if f63==248
replace unt_ok = 5 if f63==249
replace unt_ok = 3 if f63==250
replace unt_ok = 6 if f63==251
replace unt_ok = 1 if f63==252
replace unt_ok = 5 if f63==253
replace unt_ok = 1 if f63==254
replace unt_ok = 2 if f63==255
replace unt_ok = 2 if f63==256
replace unt_ok = 1 if f63==257
replace unt_ok = 2 if f63==258
replace unt_ok = 3 if f63==259
replace unt_ok = 1 if f63==260
replace unt_ok = 2 if f63==261
replace unt_ok = 4 if f63==262
replace unt_ok = 6 if f63==263
replace unt_ok = 4 if f63==264
replace unt_ok = 2 if f63==265
replace unt_ok = 2 if f63==266
replace unt_ok = 4 if f63==267
replace unt_ok = 2 if f63==268
replace unt_ok = 3 if f63==269
replace unt_ok = 7 if f63==270
replace unt_ok = 2 if f63==271
replace unt_ok = 2 if f63==272
replace unt_ok = 2 if f63==273
replace unt_ok = 2 if f63==274
replace unt_ok = 5 if f63==275
replace unt_ok = 2 if f63==277
replace unt_ok = 4 if f63==278
replace unt_ok = 2 if f63==279
replace unt_ok = 3 if f63==280
replace unt_ok = 3 if f63==281
replace unt_ok = 2 if f63==282
replace unt_ok = 2 if f63==283
replace unt_ok = 7 if f63==284
replace unt_ok = 6 if f63==285
replace unt_ok = 1 if f63==287
replace unt_ok = 5 if f63==288
replace unt_ok = 4 if f63==289
replace unt_ok = 2 if f63==290
replace unt_ok = 4 if f63==291
replace unt_ok = 2 if f63==293
replace unt_ok = 3 if f63==294
replace unt_ok = 7 if f63==295
replace unt_ok = 3 if f63==296
replace unt_ok = 2 if f63==297
replace unt_ok = 3 if f63==298
replace unt_ok = 1 if f63==299
replace unt_ok = 6 if f63==300
replace unt_ok = 4 if f63==301
replace unt_ok = 2 if f63==302
replace unt_ok = 3 if f63==303
replace unt_ok = 5 if f63==304
replace unt_ok = 2 if f63==306
replace unt_ok = 3 if f63==307
replace unt_ok = 5 if f63==308
replace unt_ok = 4 if f63==309
replace unt_ok = 6 if f63==310
replace unt_ok = 1 if f63==311
replace unt_ok = 1 if f63==313
replace unt_ok = 3 if f63==314
replace unt_ok = 2 if f63==315
replace unt_ok = 3 if f63==317
replace unt_ok = 3 if f63==318
replace unt_ok = 2 if f63==319
replace unt_ok = 2 if f63==320
replace unt_ok = 4 if f63==321
replace unt_ok = 4 if f63==322
replace unt_ok = 5 if f63==323
replace unt_ok = 2 if f63==324
replace unt_ok = 5 if f63==325
replace unt_ok = 7 if f63==326
replace unt_ok = 2 if f63==327
replace unt_ok = 2 if f63==328
replace unt_ok = 5 if f63==329
replace unt_ok = 4 if f63==340
replace unt_ok = 2 if f63==341
replace unt_ok = 7 if f63==342
replace unt_ok = 4 if f63==343
replace unt_ok = 4 if f63==345
replace unt_ok = 6 if f63==346
replace unt_ok = 3 if f63==347
replace unt_ok = 3 if f63==348
replace unt_ok = 2 if f63==349
replace unt_ok = 1 if f63==350
replace unt_ok = 6 if f63==351
replace unt_ok = 4 if f63==352
replace unt_ok = 2 if f63==353
replace unt_ok = 2 if f63==354
replace unt_ok = 4 if f63==355
replace unt_ok = 5 if f63==356
replace unt_ok = 2 if f63==357
replace unt_ok = 7 if f63==358
replace unt_ok = 2 if f63==359
replace unt_ok = 2 if f63==360
replace unt_ok = 4 if f63==361
replace unt_ok = 6 if f63==362
replace unt_ok = 3 if f63==363
replace unt_ok = 6 if f63==364
replace unt_ok = 2 if f63==365
replace unt_ok = 6 if f63==367
replace unt_ok = 6 if f63==368
replace unt_ok = 3 if f63==369
replace unt_ok = 3 if f63==370
replace unt_ok = 6 if f63==371
replace unt_ok = 7 if f63==372
replace unt_ok = 6 if f63==374
replace unt_ok = 6 if f63==375
replace unt_ok = 6 if f63==376
replace unt_ok = 4 if f63==377
replace unt_ok = 4 if f63==378
replace unt_ok = 2 if f63==379
replace unt_ok = 6 if f63==380
replace unt_ok = 2 if f63==381
replace unt_ok = 2 if f63==382
replace unt_ok = 4 if f63==383
replace unt_ok = 7 if f63==384
replace unt_ok = 4 if f63==385
replace unt_ok = 4 if f63==386
replace unt_ok = 2 if f63==387
replace unt_ok = 6 if f63==388
replace unt_ok = 5 if f63==389
replace unt_ok = 3 if f63==390
replace unt_ok = 2 if f63==391
replace unt_ok = 7 if f63==392
replace unt_ok = 1 if f63==394
replace unt_ok = 3 if f63==395
replace unt_ok = 1 if f63==396
replace unt_ok = 3 if f63==397
replace unt_ok = 2 if f63==398
replace unt_ok = 2 if f63==399
replace unt_ok = 6 if f63==400
replace unt_ok = 3 if f63==401
replace unt_ok = 5 if f63==402
replace unt_ok = 7 if f63==403
replace unt_ok = 6 if f63==404
replace unt_ok = 4 if f63==405
replace unt_ok = 2 if f63==406
replace unt_ok = 5 if f63==407
replace unt_ok = 1 if f63==408
replace unt_ok = 5 if f63==409
replace unt_ok = 6 if f63==410
replace unt_ok = 2 if f63==411
replace unt_ok = 4 if f63==412
replace unt_ok = 2 if f63==413
replace unt_ok = 3 if f63==414
replace unt_ok = 4 if f63==415
replace unt_ok = 1 if f63==416
replace unt_ok = 2 if f63==417
replace unt_ok = 6 if f63==418
replace unt_ok = 3 if f63==419
replace unt_ok = 2 if f63==420
replace unt_ok = 4 if f63==421
replace unt_ok = 6 if f63==422
replace unt_ok = 4 if f63==423
replace unt_ok = 6 if f63==424
replace unt_ok = 4 if f63==425
replace unt_ok = 4 if f63==426
replace unt_ok = 7 if f63==428
replace unt_ok = 3 if f63==429
replace unt_ok = 2 if f63==430
replace unt_ok = 5 if f63==431
replace unt_ok = 6 if f63==432
replace unt_ok = 4 if f63==433
replace unt_ok = 2 if f63==434
replace unt_ok = 4 if f63==435
replace unt_ok = 3 if f63==436
replace unt_ok = 6 if f63==437
replace unt_ok = 4 if f63==438
replace unt_ok = 2 if f63==439
replace unt_ok = 4 if f63==440
replace unt_ok = 2 if f63==441
replace unt_ok = 6 if f63==442
replace unt_ok = 4 if f63==443
replace unt_ok = 2 if f63==444
replace unt_ok = 3 if f63==445
replace unt_ok = 6 if f63==446
replace unt_ok = 6 if f63==447
replace unt_ok = 7 if f63==448
replace unt_ok = 1 if f63==449
replace unt_ok = 3 if f63==450
replace unt_ok = 7 if f63==451
replace unt_ok = 6 if f63==452
replace unt_ok = 2 if f63==453
replace unt_ok = 7 if f63==454
replace unt_ok = 5 if f63==455
replace unt_ok = 2 if f63==456
replace unt_ok = 6 if f63==457
replace unt_ok = 5 if f63==458
replace unt_ok = 7 if f63==459
replace unt_ok = 4 if f63==460
replace unt_ok = 3 if f63==461
replace unt_ok = 3 if f63==462
replace unt_ok = 4 if f63==463
replace unt_ok = 2 if f63==464
replace unt_ok = 3 if f63==465
replace unt_ok = 7 if f63==466
replace unt_ok = 6 if f63==467
replace unt_ok = 4 if f63==468
replace unt_ok = 3 if f63==469
replace unt_ok = 3 if f63==471
replace unt_ok = 5 if f63==472
replace unt_ok = 2 if f63==473
replace unt_ok = 7 if f63==474
replace unt_ok = 4 if f63==475
replace unt_ok = 6 if f63==476
replace unt_ok = 6 if f63==477
replace unt_ok = 3 if f63==478
replace unt_ok = 6 if f63==479
replace unt_ok = 3 if f63==480
replace unt_ok = 7 if f63==481
replace unt_ok = 4 if f63==482
replace unt_ok = 7 if f63==483
replace unt_ok = 5 if f63==484
replace unt_ok = 4 if f63==485
replace unt_ok = 5 if f63==486
replace unt_ok = 6 if f63==487
replace unt_ok = 3 if f63==488
replace unt_ok = 2 if f63==489
replace unt_ok = 5 if f63==490
replace unt_ok = 7 if f63==491
replace unt_ok = 2 if f63==492
replace unt_ok = 3 if f63==493
replace unt_ok = 4 if f63==494
replace unt_ok = 6 if f63==495
replace unt_ok = 7 if f63==496
replace unt_ok = 4 if f63==497
replace unt_ok = 6 if f63==498
replace unt_ok = 4 if f63==499
replace unt_ok = 2 if f63==500
replace unt_ok = 5 if f63==501
replace unt_ok = 6 if f63==503
replace unt_ok = 3 if f63==504
replace unt_ok = 6 if f63==505
replace unt_ok = 2 if f63==506
replace unt_ok = 2 if f63==507
replace unt_ok = 4 if f63==508
replace unt_ok = 3 if f63==509
replace unt_ok = 2 if f63==510
replace unt_ok = 4 if f63==511
replace unt_ok = 1 if f63==512
replace unt_ok = 1 if f63==513
replace unt_ok = 1 if f63==514
replace unt_ok = 1 if f63==515
replace unt_ok = 4 if f63==516
replace unt_ok = 2 if f63==517
replace unt_ok = 3 if f63==518
replace unt_ok = 5 if f63==519
replace unt_ok = 2 if f63==520
replace unt_ok = 2 if f63==521
replace unt_ok = 6 if f63==522
replace unt_ok = 4 if f63==523
replace unt_ok = 4 if f63==524
replace unt_ok = 5 if f63==525
replace unt_ok = 7 if f63==526
replace unt_ok = 5 if f63==527
replace unt_ok = 3 if f63==528
replace unt_ok = 3 if f63==529
replace unt_ok = 3 if f63==530
replace unt_ok = 7 if f63==531
replace unt_ok = 7 if f63==532
replace unt_ok = 4 if f63==533
replace unt_ok = 2 if f63==534
replace unt_ok = 5 if f63==535
replace unt_ok = 4 if f63==536
replace unt_ok = 3 if f63==537
replace unt_ok = 2 if f63==538
replace unt_ok = 3 if f63==539
replace unt_ok = 3 if f63==540
replace unt_ok = 5 if f63==541
replace unt_ok = 4 if f63==542
replace unt_ok = 7 if f63==543
replace unt_ok = 4 if f63==544
replace unt_ok = 5 if f63==545
replace unt_ok = 4 if f63==546
replace unt_ok = 4 if f63==547
replace unt_ok = 5 if f63==548
replace unt_ok = 4 if f63==549
replace unt_ok = 3 if f63==550
replace unt_ok = 5 if f63==551
replace unt_ok = 4 if f63==552
replace unt_ok = 2 if f63==553
replace unt_ok = 2 if f63==554
replace unt_ok = 2 if f63==555
replace unt_ok = 6 if f63==556
replace unt_ok = 3 if f63==557
replace unt_ok = 4 if f63==558
replace unt_ok = 1 if f63==559
replace unt_ok = 4 if f63==560
replace unt_ok = 7 if f63==561
replace unt_ok = 3 if f63==562
replace unt_ok = 7 if f63==563
replace unt_ok = 4 if f63==564
replace unt_ok = 7 if f63==565
replace unt_ok = 7 if f63==566
replace unt_ok = 4 if f63==567
replace unt_ok = 2 if f63==568
replace unt_ok = 2 if f63==569
replace unt_ok = 3 if f63==570
replace unt_ok = 7 if f63==571
replace unt_ok = 5 if f63==572
replace unt_ok = 7 if f63==573
replace unt_ok = 3 if f63==574
replace unt_ok = 5 if f63==575
replace unt_ok = 2 if f63==576
replace unt_ok = 5 if f63==577
replace unt_ok = 3 if f63==578
replace unt_ok = 3 if f63==579
replace unt_ok = 3 if f63==580
replace unt_ok = 3 if f63==582
replace unt_ok = 7 if f63==583
replace unt_ok = 3 if f63==584
replace unt_ok = 3 if f63==585
replace unt_ok = 2 if f63==586
replace unt_ok = 7 if f63==587
replace unt_ok = 2 if f63==588
replace unt_ok = 2 if f63==589
replace unt_ok = 1 if f63==591
replace unt_ok = 2 if f63==592
replace unt_ok = 7 if f63==593
replace unt_ok = 3 if f63==594
replace unt_ok = 4 if f63==595
replace unt_ok = 2 if f63==596
replace unt_ok = 6 if f63==598
replace unt_ok = 6 if f63==599
replace unt_ok = 4 if f63==600
replace unt_ok = 2 if f63==601
replace unt_ok = 1 if f63==602
replace unt_ok = 2 if f63==603
replace unt_ok = 2 if f63==604
replace unt_ok = 5 if f63==605
replace unt_ok = 3 if f63==606
replace unt_ok = 1 if f63==607
replace unt_ok = 6 if f63==608
replace unt_ok = 2 if f63==609
replace unt_ok = 3 if f63==610
replace unt_ok = 2 if f63==611
replace unt_ok = 2 if f63==612
replace unt_ok = 4 if f63==613
replace unt_ok = 2 if f63==614
replace unt_ok = 2 if f63==615
replace unt_ok = 4 if f63==616
replace unt_ok = 2 if f63==617
replace unt_ok = 5 if f63==618
replace unt_ok = 6 if f63==619
replace unt_ok = 2 if f63==620
replace unt_ok = 2 if f63==621
replace unt_ok = 1 if f63==622
replace unt_ok = 5 if f63==623
replace unt_ok = 3 if f63==624
replace unt_ok = 1 if f63==625
replace unt_ok = 6 if f63==626
replace unt_ok = 3 if f63==627
replace unt_ok = 2 if f63==628
replace unt_ok = 2 if f63==629
replace unt_ok = 5 if f63==630
replace unt_ok = 5 if f63==631
replace unt_ok = 7 if f63==632
replace unt_ok = 1 if f63==633
replace unt_ok = 6 if f63==634
replace unt_ok = 6 if f63==635
replace unt_ok = 2 if f63==636
replace unt_ok = 4 if f63==637
replace unt_ok = 3 if f63==638
replace unt_ok = 2 if f63==639
replace unt_ok = 2 if f63==640
replace unt_ok = 7 if f63==641
replace unt_ok = 2 if f63==642
replace unt_ok = 6 if f63==643
replace unt_ok = 2 if f63==645
replace unt_ok = 4 if f63==648
replace unt_ok = 2 if f63==649
replace unt_ok = 2 if f63==650
replace unt_ok = 2 if f63==651
replace unt_ok = 6 if f63==652
replace unt_ok = 4 if f63==653
replace unt_ok = 4 if f63==654
replace unt_ok = 3 if f63==655
replace unt_ok = 2 if f63==656
replace unt_ok = 3 if f63==657
replace unt_ok = 7 if f63==658
replace unt_ok = 6 if f63==659
replace unt_ok = 4 if f63==660
replace unt_ok = 6 if f63==662
replace unt_ok = 3 if f63==663
replace unt_ok = 1 if f63==664
replace unt_ok = 3 if f63==665
replace unt_ok = 2 if f63==666
replace unt_ok = 4 if f63==667
replace unt_ok = 2 if f63==668
replace unt_ok = 3 if f63==669
replace unt_ok = 2 if f63==671
replace unt_ok = 2 if f63==672
replace unt_ok = 6 if f63==673
replace unt_ok = 4 if f63==674
replace unt_ok = 3 if f63==675
replace unt_ok = 2 if f63==675
replace unt_ok = 6 if f63==676
replace unt_ok = 7 if f63==677
replace unt_ok = 6 if f63==678
replace unt_ok = 2 if f63==679
replace unt_ok = 2 if f63==680
replace unt_ok = 2 if f63==681
replace unt_ok = 4 if f63==682
replace unt_ok = 6 if f63==683
replace unt_ok = 2 if f63==684
replace unt_ok = 6 if f63==685
replace unt_ok = 6 if f63==686
replace unt_ok = 2 if f63==687
replace unt_ok = 2 if f63==688
replace unt_ok = 4 if f63==689
replace unt_ok = 7 if f63==690
replace unt_ok = 4 if f63==691
replace unt_ok = 3 if f63==692
replace unt_ok = 3 if f63==693
replace unt_ok = 6 if f63==694
replace unt_ok = 6 if f63==695
replace unt_ok = 5 if f63==696
replace unt_ok = 2 if f63==697
replace unt_ok = 1 if f63==698
replace unt_ok = 6 if f63==699
replace unt_ok = 2 if f63==700
replace unt_ok = 5 if f63==701
replace unt_ok = 3 if f63==702
replace unt_ok = 2 if f63==703
replace unt_ok = 2 if f63==704
replace unt_ok = 2 if f63==705
replace unt_ok = 3 if f63==706
replace unt_ok = 2 if f63==707
replace unt_ok = 5 if f63==708
replace unt_ok = 4 if f63==709
replace unt_ok = 4 if f63==710
replace unt_ok = 4 if f63==711
replace unt_ok = 6 if f63==712
replace unt_ok = 1 if f63==713
replace unt_ok = 3 if f63==714
replace unt_ok = 2 if f63==715
replace unt_ok = 2 if f63==716
replace unt_ok = 6 if f63==717
replace unt_ok = 4 if f63==718
replace unt_ok = 2 if f63==719
replace unt_ok = 4 if f63==720
replace unt_ok = 2 if f63==721
replace unt_ok = 4 if f63==722
replace unt_ok = 2 if f63==723
replace unt_ok = 6 if f63==724
replace unt_ok = 4 if f63==725
replace unt_ok = 7 if f63==726
replace unt_ok = 4 if f63==727
replace unt_ok = 4 if f63==728
replace unt_ok = 3 if f63==729
replace unt_ok = 4 if f63==730
replace unt_ok = 3 if f63==731
replace unt_ok = 3 if f63==732
replace unt_ok = 4 if f63==733
replace unt_ok = 2 if f63==734
replace unt_ok = 6 if f63==735
replace unt_ok = 1 if f63==736
replace unt_ok = 3 if f63==737
replace unt_ok = 3 if f63==738
replace unt_ok = 6 if f63==739
replace unt_ok = 2 if f63==740
replace unt_ok = 6 if f63==741
replace unt_ok = 2 if f63==742
replace unt_ok = 2 if f63==743
replace unt_ok = 7 if f63==744
replace unt_ok = 1 if f63==745
replace unt_ok = 3 if f63==746
replace unt_ok = 5 if f63==747
replace unt_ok = 3 if f63==748
replace unt_ok = 4 if f63==749
replace unt_ok = 2 if f63==750
replace unt_ok = 4 if f63==751
replace unt_ok = 5 if f63==752
replace unt_ok = 3 if f63==753
replace unt_ok = 3 if f63==754
replace unt_ok = 2 if f63==755
replace unt_ok = 1 if f63==756
replace unt_ok = 1 if f63==757
replace unt_ok = 3 if f63==758
replace unt_ok = 4 if f63==759
replace unt_ok = 2 if f63==760
replace unt_ok = 2 if f63==761
replace unt_ok = 2 if f63==762
replace unt_ok = 1 if f63==763
replace unt_ok = 3 if f63==764
replace unt_ok = 3 if f63==765
replace unt_ok = 2 if f63==766
replace unt_ok = 6 if f63==767
replace unt_ok = 1 if f63==768
replace unt_ok = 3 if f63==769
replace unt_ok = 4 if f63==770
replace unt_ok = 3 if f63==771
replace unt_ok = 2 if f63==772
replace unt_ok = 3 if f63==773
replace unt_ok = 2 if f63==774
replace unt_ok = 2 if f63==775
replace unt_ok = 3 if f63==776
replace unt_ok = 4 if f63==777
replace unt_ok = 2 if f63==778
replace unt_ok = 4 if f63==779
replace unt_ok = 3 if f63==780
replace unt_ok = 3 if f63==781
replace unt_ok = 7 if f63==782
replace unt_ok = 2 if f63==783
replace unt_ok = 2 if f63==784
replace unt_ok = 4 if f63==785
replace unt_ok = 2 if f63==786
replace unt_ok = 2 if f63==787
replace unt_ok = 2 if f63==788
replace unt_ok = 4 if f63==789
replace unt_ok = 2 if f63==790
replace unt_ok = 2 if f63==791
replace unt_ok = 1 if f63==792
replace unt_ok = 4 if f63==793
replace unt_ok = 4 if f63==794
replace unt_ok = 6 if f63==795
replace unt_ok = 4 if f63==796
replace unt_ok = 2 if f63==797
replace unt_ok = 3 if f63==798
replace unt_ok = 3 if f63==799
replace unt_ok = 2 if f63==800
replace unt_ok = 1 if f63==801
replace unt_ok = 2 if f63==802
replace unt_ok = 3 if f63==803
replace unt_ok = 2 if f63==804
replace unt_ok = 5 if f63==805
replace unt_ok = 2 if f63==806
replace unt_ok = 2 if f63==807
replace unt_ok = 3 if f63==808
replace unt_ok = 4 if f63==809
replace unt_ok = 4 if f63==810
replace unt_ok = 4 if f63==811
replace unt_ok = 4 if f63==812
replace unt_ok = 3 if f63==813
replace unt_ok = 2 if f63==814
replace unt_ok = 4 if f63==815
replace unt_ok = 2 if f63==816
replace unt_ok = 7 if f63==817
replace unt_ok = 5 if f63==818
replace unt_ok = 4 if f63==819
replace unt_ok = 2 if f63==820
replace unt_ok = 2 if f63==821
replace unt_ok = 1 if f63==822
replace unt_ok = 7 if f63==823
replace unt_ok = 4 if f63==824
replace unt_ok = 2 if f63==825
replace unt_ok = 5 if f63==826
replace unt_ok = 3 if f63==827
replace unt_ok = 7 if f63==828
replace unt_ok = 4 if f63==829
replace unt_ok = 6 if f63==830
replace unt_ok = 5 if f63==831
replace unt_ok = 4 if f63==832
replace unt_ok = 6 if f63==833
replace unt_ok = 2 if f63==834
replace unt_ok = 3 if f63==835
replace unt_ok = 2 if f63==836
replace unt_ok = 4 if f63==837
replace unt_ok = 3 if f63==838
replace unt_ok = 6 if f63==839
replace unt_ok = 2 if f63==840
replace unt_ok = 1 if f63==841
replace unt_ok = 2 if f63==842
replace unt_ok = 3 if f63==843
replace unt_ok = 6 if f63==844
replace unt_ok = 1 if f63==845
replace unt_ok = 2 if f63==846
replace unt_ok = 5 if f63==847
replace unt_ok = 2 if f63==848
replace unt_ok = 2 if f63==849
replace unt_ok = 7 if f63==850
replace unt_ok = 2 if f63==851
replace unt_ok = 2 if f63==852
replace unt_ok = 2 if f63==853
replace unt_ok = 2 if f63==854
replace unt_ok = 2 if f63==855
replace unt_ok = 6 if f63==856
replace unt_ok = 5 if f63==857
replace unt_ok = 2 if f63==858
replace unt_ok = 7 if f63==859
replace unt_ok = 3 if f63==860
replace unt_ok = 2 if f63==861
replace unt_ok = 6 if f63==862
replace unt_ok = 1 if f63==863
replace unt_ok = 3 if f63==865
replace unt_ok = 4 if f63==866
replace unt_ok = 2 if f63==867
replace unt_ok = 2 if f63==868
replace unt_ok = 4 if f63==869
replace unt_ok = 3 if f63==870
replace unt_ok = 5 if f63==871
replace unt_ok = 2 if f63==872
replace unt_ok = 2 if f63==873
replace unt_ok = 6 if f63==874
replace unt_ok = 2 if f63==875
replace unt_ok = 7 if f63==876
replace unt_ok = 2 if f63==877
replace unt_ok = 2 if f63==878
replace unt_ok = 6 if f63==879
replace unt_ok = 1 if f63==880
replace unt_ok = 3 if f63==881
replace unt_ok = 4 if f63==882
replace unt_ok = 1 if f63==883
replace unt_ok = 5 if f63==884
replace unt_ok = 2 if f63==886
replace unt_ok = 5 if f63==887
replace unt_ok = 2 if f63==888
replace unt_ok = 2 if f63==889
replace unt_ok = 4 if f63==890
replace unt_ok = 6 if f63==891
replace unt_ok = 2 if f63==892
replace unt_ok = 2 if f63==893
replace unt_ok = 4 if f63==894
replace unt_ok = 3 if f63==895
replace unt_ok = 2 if f63==896
replace unt_ok = 1 if f63==897
replace unt_ok = 5 if f63==898
replace unt_ok = 3 if f63==899
replace unt_ok = 5 if f63==900
replace unt_ok = 1 if f63==901
replace unt_ok = 2 if f63==902
replace unt_ok = 3 if f63==903
replace unt_ok = 4 if f63==904
replace unt_ok = 2 if f63==905
replace unt_ok = 2 if f63==906
replace unt_ok = 2 if f63==907
replace unt_ok = 4 if f63==908
replace unt_ok = 6 if f63==909
replace unt_ok = 1 if f63==910
replace unt_ok = 2 if f63==911
replace unt_ok = 4 if f63==912
replace unt_ok = 2 if f63==913
replace unt_ok = 3 if f63==914
replace unt_ok = 2 if f63==915
replace unt_ok = 2 if f63==916
replace unt_ok = 4 if f63==917
replace unt_ok = 3 if f63==918
replace unt_ok = 3 if f63==919
replace unt_ok = 3 if f63==920
replace unt_ok = 3 if f63==921
replace unt_ok = 4 if f63==922
replace unt_ok = 4 if f63==923
replace unt_ok = 2 if f63==924
replace unt_ok = 2 if f63==925
replace unt_ok = 1 if f63==926
replace unt_ok = 2 if f63==927
replace unt_ok = 2 if f63==928
replace unt_ok = 2 if f63==929
replace unt_ok = 3 if f63==930
replace unt_ok = 5 if f63==931
replace unt_ok = 6 if f63==932
replace unt_ok = 3 if f63==933
replace unt_ok = 1 if f63==934
replace unt_ok = 5 if f63==935
replace unt_ok = 1 if f63==936
replace unt_ok = 2 if f63==937
replace unt_ok = 5 if f63==938
replace unt_ok = 6 if f63==939
replace unt_ok = 6 if f63==940
replace unt_ok = 4 if f63==941
replace unt_ok = 1 if f63==942
replace unt_ok = 4 if f63==943
replace unt_ok = 6 if f63==944
replace unt_ok = 3 if f63==945
replace unt_ok = 2 if f63==946
replace unt_ok = 7 if f63==947
replace unt_ok = 4 if f63==948
replace unt_ok = 5 if f63==949
replace unt_ok = 2 if f63==950
replace unt_ok = 5 if f63==951
replace unt_ok = 1 if f63==952
replace unt_ok = 6 if f63==953
replace unt_ok = 4 if f63==954
replace unt_ok = 1 if f63==955
replace unt_ok = 2 if f63==956
replace unt_ok = 6 if f63==957
replace unt_ok = 4 if f63==958
replace unt_ok = 7 if f63==959
replace unt_ok = 4 if f63==960
replace unt_ok = 4 if f63==961
replace unt_ok = 1 if f63==962
replace unt_ok = 2 if f63==963
replace unt_ok = 4 if f63==964
replace unt_ok = 2 if f63==965
replace unt_ok = 6 if f63==966
replace unt_ok = 1 if f63==967
replace unt_ok = 7 if f63==968
replace unt_ok = 2 if f63==969
replace unt_ok = 5 if f63==970
replace unt_ok = 2 if f63==971
replace unt_ok = 2 if f63==972
replace unt_ok = 3 if f63==973
replace unt_ok = 2 if f63==974
replace unt_ok = 3 if f63==975
replace unt_ok = 2 if f63==976
replace unt_ok = 7 if f63==977
replace unt_ok = 4 if f63==978
replace unt_ok = 2 if f63==979
replace unt_ok = 4 if f63==980
replace unt_ok = 5 if f63==981
replace unt_ok = 5 if f63==982
replace unt_ok = 2 if f63==983
replace unt_ok = 3 if f63==984
replace unt_ok = 6 if f63==985
replace unt_ok = 7 if f63==986
replace unt_ok = 2 if f63==987
replace unt_ok = 4 if f63==988
replace unt_ok = 6 if f63==989
replace unt_ok = 2 if f63==990
replace unt_ok = 5 if f63==991
replace unt_ok = 2 if f63==992
replace unt_ok = 2 if f63==993
replace unt_ok = 3 if f63==994
replace unt_ok = 6 if f63==995
replace unt_ok = 4 if f63==996
replace unt_ok = 3 if f63==997
replace unt_ok = 6 if f63==998
replace unt_ok = 5 if f63==999
replace unt_ok = 1 if f63==1000
replace unt_ok = 6 if f63==1001
replace unt_ok = 3 if f63==1002
replace unt_ok = 1 if f63==1003
replace unt_ok = 1 if f63==1004
replace unt_ok = 6 if f63==1005
replace unt_ok = 4 if f63==1006
replace unt_ok = 5 if f63==1007
replace unt_ok = 2 if f63==1008
replace unt_ok = 5 if f63==1010
replace unt_ok = 2 if f63==1011
replace unt_ok = 6 if f63==1012
replace unt_ok = 2 if f63==1013
replace unt_ok = 5 if f63==1014
replace unt_ok = 5 if f63==1015
replace unt_ok = 4 if f63==1016
replace unt_ok = 5 if f63==1017
replace unt_ok = 1 if f63==1018
replace unt_ok = 3 if f63==1019
replace unt_ok = 4 if f63==1020
replace unt_ok = 2 if f63==1021
replace unt_ok = 3 if f63==1022
replace unt_ok = 6 if f63==1023
replace unt_ok = 1 if f63==1024
replace unt_ok = 5 if f63==1026
replace unt_ok = 4 if f63==1027
replace unt_ok = 3 if f63==1028
replace unt_ok = 1 if f63==1029
replace unt_ok = 4 if f63==1030
replace unt_ok = 7 if f63==1031
replace unt_ok = 2 if f63==1032
replace unt_ok = 2 if f63==1033
replace unt_ok = 5 if f63==1034
replace unt_ok = 6 if f63==1035
replace unt_ok = 4 if f63==1036
replace unt_ok = 6 if f63==1037
replace unt_ok = 5 if f63==1038
replace unt_ok = 1 if f63==1039
replace unt_ok = 2 if f63==1040
replace unt_ok = 7 if f63==1041
replace unt_ok = 4 if f63==1042
replace unt_ok = 6 if f63==1043
replace unt_ok = 6 if f63==1044
replace unt_ok = 4 if f63==1045
replace unt_ok = 4 if f63==1046
replace unt_ok = 6 if f63==1047
replace unt_ok = 6 if f63==1048
replace unt_ok = 4 if f63==1049
replace unt_ok = 2 if f63==1050
replace unt_ok = 4 if f63==1051
replace unt_ok = 1 if f63==1052
replace unt_ok = 4 if f63==1054
replace unt_ok = 3 if f63==1055
replace unt_ok = 5 if f63==1056
replace unt_ok = 4 if f63==1057
replace unt_ok = 5 if f63==1058
replace unt_ok = 4 if f63==1059
replace unt_ok = 2 if f63==1060
replace unt_ok = 3 if f63==1061
replace unt_ok = 5 if f63==1062
replace unt_ok = 3 if f63==1063
replace unt_ok = 5 if f63==1064
replace unt_ok = 6 if f63==1065
replace unt_ok = 6 if f63==1066
replace unt_ok = 3 if f63==1067
replace unt_ok = 2 if f63==1068
replace unt_ok = 5 if f63==1069
replace unt_ok = 2 if f63==1070
replace unt_ok = 4 if f63==1071
replace unt_ok = 5 if f63==1072
replace unt_ok = 2 if f63==1073
replace unt_ok = 6 if f63==1074
replace unt_ok = 1 if f63==1075
replace unt_ok = 4 if f63==1076
replace unt_ok = 4 if f63==1077
replace unt_ok = 4 if f63==1078
replace unt_ok = 5 if f63==1079
replace unt_ok = 4 if f63==1080
replace unt_ok = 1 if f63==1081
replace unt_ok = 7 if f63==1082
replace unt_ok = 4 if f63==1083
replace unt_ok = 2 if f63==1084
replace unt_ok = 4 if f63==1085
replace unt_ok = 7 if f63==1086
replace unt_ok = 1 if f63==1087
replace unt_ok = 3 if f63==1088
replace unt_ok = 4 if f63==1089
replace unt_ok = 2 if f63==1090
replace unt_ok = 3 if f63==1091
replace unt_ok = 3 if f63==1092
replace unt_ok = 1 if f63==1093
replace unt_ok = 6 if f63==1094
replace unt_ok = 4 if f63==1095
replace unt_ok = 7 if f63==1096
replace unt_ok = 3 if f63==1097
replace unt_ok = 2 if f63==1098
replace unt_ok = 4 if f63==1099
replace unt_ok = 7 if f63==1100
replace unt_ok = 7 if f63==1101
replace unt_ok = 4 if f63==1102
replace unt_ok = 2 if f63==1103
replace unt_ok = 5 if f63==1104
replace unt_ok = 4 if f63==1105
replace unt_ok = 1 if f63==1106
replace unt_ok = 3 if f63==1107
replace unt_ok = 4 if f63==1108
replace unt_ok = 4 if f63==1109
replace unt_ok = 2 if f63==1110
replace unt_ok = 2 if f63==1111
replace unt_ok = 6 if f63==1112
replace unt_ok = 3 if f63==1113
replace unt_ok = 3 if f63==1114
replace unt_ok = 2 if f63==1115
replace unt_ok = 6 if f63==1116
replace unt_ok = 4 if f63==1117
replace unt_ok = 2 if f63==1118
replace unt_ok = 7 if f63==1119
replace unt_ok = 5 if f63==1120
replace unt_ok = 1 if f63==1121
replace unt_ok = 2 if f63==1122
replace unt_ok = 2 if f63==1123
replace unt_ok = 5 if f63==1124
replace unt_ok = 3 if f63==1125
replace unt_ok = 3 if f63==1126
replace unt_ok = 3 if f63==1127
replace unt_ok = 3 if f63==1128
replace unt_ok = 4 if f63==1129
replace unt_ok = 2 if f63==1130
replace unt_ok = 3 if f63==1131
replace unt_ok = 4 if f63==1132
replace unt_ok = 6 if f63==1133
replace unt_ok = 5 if f63==1134
replace unt_ok = 3 if f63==1135
replace unt_ok = 3 if f63==1136
replace unt_ok = 6 if f63==1137
replace unt_ok = 1 if f63==1138
replace unt_ok = 3 if f63==1139
replace unt_ok = 4 if f63==1140
replace unt_ok = 4 if f63==1141
replace unt_ok = 3 if f63==1142
replace unt_ok = 2 if f63==1143
replace unt_ok = 4 if f63==1144
replace unt_ok = 2 if f63==1145
replace unt_ok = 2 if f63==1146
replace unt_ok = 4 if f63==1147
replace unt_ok = 5 if f63==1148
replace unt_ok = 5 if f63==1149
replace unt_ok = 6 if f63==1150
replace unt_ok = 5 if f63==1151
replace unt_ok = 6 if f63==1152
replace unt_ok = 2 if f63==1153
replace unt_ok = 4 if f63==1154
replace unt_ok = 4 if f63==1155
replace unt_ok = 2 if f63==1156
replace unt_ok = 4 if f63==1158
replace unt_ok = 6 if f63==1159
replace unt_ok = 4 if f63==1160
replace unt_ok = 5 if f63==1161
replace unt_ok = 1 if f63==1162
replace unt_ok = 3 if f63==1163
replace unt_ok = 4 if f63==1164
replace unt_ok = 2 if f63==1165
replace unt_ok = 6 if f63==1167
replace unt_ok = 2 if f63==1168
replace unt_ok = 4 if f63==1169
replace unt_ok = 2 if f63==1170
replace unt_ok = 6 if f63==1171
replace unt_ok = 4 if f63==1172
replace unt_ok = 2 if f63==1173
replace unt_ok = 6 if f63==1174
replace unt_ok = 6 if f63==1175
replace unt_ok = 1 if f63==1176
replace unt_ok = 2 if f63==1177
replace unt_ok = 7 if f63==1178
replace unt_ok = 5 if f63==1179
replace unt_ok = 5 if f63==1180
replace unt_ok = 2 if f63==1181
replace unt_ok = 3 if f63==1182
replace unt_ok = 2 if f63==1183
replace unt_ok = 6 if f63==1184
replace unt_ok = 4 if f63==1185
replace unt_ok = 6 if f63==1186
replace unt_ok = 4 if f63==1187
replace unt_ok = 6 if f63==1188
replace unt_ok = 3 if f63==1189
replace unt_ok = 1 if f63==1190
replace unt_ok = 2 if f63==1191
replace unt_ok = 4 if f63==1192
replace unt_ok = 4 if f63==1193
replace unt_ok = 2 if f63==1194
replace unt_ok = 4 if f63==1195
replace unt_ok = 2 if f63==1196
replace unt_ok = 2 if f63==1197
replace unt_ok = 3 if f63==1198
replace unt_ok = 5 if f63==1199
replace unt_ok = 4 if f63==1200
replace unt_ok = 2 if f63==1201
replace unt_ok = 2 if f63==1202
replace unt_ok = 4 if f63==1204
replace unt_ok = 4 if f63==1205
replace unt_ok = 3 if f63==1206
replace unt_ok = 4 if f63==1207
replace unt_ok = 4 if f63==1208
replace unt_ok = 4 if f63==1209
replace unt_ok = 2 if f63==1210
replace unt_ok = 4 if f63==1211
replace unt_ok = 2 if f63==1212
replace unt_ok = 2 if f63==1213
replace unt_ok = 4 if f63==1214
replace unt_ok = 2 if f63==1215
replace unt_ok = 1 if f63==1216
replace unt_ok = 2 if f63==1217
replace unt_ok = 2 if f63==1218
replace unt_ok = 2 if f63==1219
replace unt_ok = 3 if f63==1220
replace unt_ok = 2 if f63==1221
replace unt_ok = 5 if f63==1222
replace unt_ok = 2 if f63==1223
replace unt_ok = 2 if f63==1224
replace unt_ok = 4 if f63==1225
replace unt_ok = 1 if f63==1226
replace unt_ok = 7 if f63==1227
replace unt_ok = 3 if f63==1228
replace unt_ok = 6 if f63==1229
replace unt_ok = 6 if f63==1230
replace unt_ok = 3 if f63==1231
replace unt_ok = 2 if f63==1232
replace unt_ok = 1 if f63==1233
replace unt_ok = 2 if f63==1234
replace unt_ok = 7 if f63==1235
replace unt_ok = 3 if f63==1236
replace unt_ok = 2 if f63==1237
replace unt_ok = 3 if f63==1238
replace unt_ok = 2 if f63==1239
replace unt_ok = 5 if f63==1240
replace unt_ok = 1 if f63==1241
replace unt_ok = 1 if f63==1242
replace unt_ok = 4 if f63==1243
replace unt_ok = 4 if f63==1244
replace unt_ok = 3 if f63==1245
replace unt_ok = 2 if f63==1246
replace unt_ok = 2 if f63==1247
replace unt_ok = 3 if f63==1248
replace unt_ok = 4 if f63==1249
replace unt_ok = 2 if f63==1250
replace unt_ok = 3 if f63==1251
replace unt_ok = 3 if f63==1252
replace unt_ok = 4 if f63==1253
replace unt_ok = 3 if f63==1254
replace unt_ok = 2 if f63==1255
replace unt_ok = 4 if f63==1256
replace unt_ok = 2 if f63==1257
replace unt_ok = 6 if f63==1258
replace unt_ok = 3 if f63==1259
replace unt_ok = 3 if f63==1260
replace unt_ok = 2 if f63==1261
replace unt_ok = 3 if f63==1262
replace unt_ok = 4 if f63==1263
replace unt_ok = 6 if f63==1264
replace unt_ok = 4 if f63==1265
replace unt_ok = 4 if f63==1266
replace unt_ok = 2 if f63==1267
replace unt_ok = 2 if f63==1268
replace unt_ok = 3 if f63==1269
replace unt_ok = 3 if f63==1270
replace unt_ok = 2 if f63==1271
replace unt_ok = 4 if f63==1272
replace unt_ok = 2 if f63==1273
replace unt_ok = 6 if f63==1274
replace unt_ok = 7 if f63==1275
replace unt_ok = 3 if f63==1276
replace unt_ok = 3 if f63==1277
replace unt_ok = 5 if f63==1278
replace unt_ok = 2 if f63==1279
replace unt_ok = 4 if f63==1280
replace unt_ok = 1 if f63==1281
replace unt_ok = 3 if f63==1282
replace unt_ok = 2 if f63==1283
replace unt_ok = 4 if f63==1284
replace unt_ok = 2 if f63==1285
replace unt_ok = 4 if f63==1286
replace unt_ok = 4 if f63==1287
replace unt_ok = 3 if f63==1288
replace unt_ok = 3 if f63==1289
replace unt_ok = 4 if f63==1290
replace unt_ok = 6 if f63==1291
replace unt_ok = 5 if f63==1292
replace unt_ok = 7 if f63==1293
replace unt_ok = 1 if f63==1294
replace unt_ok = 4 if f63==1295
replace unt_ok = 6 if f63==1296
replace unt_ok = 6 if f63==1297
replace unt_ok = 2 if f63==1298
replace unt_ok = 4 if f63==1299
replace unt_ok = 3 if f63==1300
replace unt_ok = 5 if f63==1301
replace unt_ok = 1 if f63==1303
replace unt_ok = 2 if f63==1304
replace unt_ok = 1 if f63==1305
replace unt_ok = 5 if f63==1306
replace unt_ok = 2 if f63==1307
replace unt_ok = 2 if f63==1308
replace unt_ok = 3 if f63==1309
replace unt_ok = 2 if f63==1310
replace unt_ok = 4 if f63==1311
replace unt_ok = 3 if f63==1312
replace unt_ok = 3 if f63==1313
replace unt_ok = 4 if f63==1314
replace unt_ok = 3 if f63==1315
replace unt_ok = 4 if f63==1316
replace unt_ok = 2 if f63==1317
replace unt_ok = 1 if f63==1318
replace unt_ok = 2 if f63==1319
replace unt_ok = 3 if f63==1320
replace unt_ok = 5 if f63==1321
replace unt_ok = 2 if f63==1322
replace unt_ok = 2 if f63==1323
replace unt_ok = 4 if f63==1324
replace unt_ok = 3 if f63==1325
replace unt_ok = 7 if f63==1326
replace unt_ok = 3 if f63==1327
replace unt_ok = 6 if f63==1328
replace unt_ok = 5 if f63==1329
replace unt_ok = 5 if f63==1330
replace unt_ok = 2 if f63==1331
replace unt_ok = 2 if f63==1332
replace unt_ok = 2 if f63==1333
replace unt_ok = 5 if f63==1334
replace unt_ok = 6 if f63==1335
replace unt_ok = 5 if f63==1336
replace unt_ok = 2 if f63==1337
replace unt_ok = 4 if f63==1338
replace unt_ok = 3 if f63==1339
replace unt_ok = 4 if f63==1340
replace unt_ok = 3 if f63==1341
replace unt_ok = 4 if f63==1342
replace unt_ok = 6 if f63==1343
replace unt_ok = 2 if f63==1344
replace unt_ok = 4 if f63==1345
replace unt_ok = 5 if f63==1346
replace unt_ok = 6 if f63==1347
replace unt_ok = 4 if f63==1348
replace unt_ok = 6 if f63==1349
replace unt_ok = 6 if f63==1350
replace unt_ok = 2 if f63==1351
replace unt_ok = 3 if f63==1352
replace unt_ok = 7 if f63==1353
replace unt_ok = 2 if f63==1354
replace unt_ok = 3 if f63==1355
replace unt_ok = 4 if f63==1356
replace unt_ok = 4 if f63==1357
replace unt_ok = 4 if f63==1358
replace unt_ok = 3 if f63==1359
replace unt_ok = 2 if f63==1360
replace unt_ok = 4 if f63==1361
replace unt_ok = 6 if f63==1362
replace unt_ok = 1 if f63==1363
replace unt_ok = 1 if f63==1364
replace unt_ok = 2 if f63==1365
replace unt_ok = 4 if f63==1366
replace unt_ok = 6 if f63==1367
replace unt_ok = 7 if f63==1368
replace unt_ok = 4 if f63==1369
replace unt_ok = 7 if f63==1370
replace unt_ok = 2 if f63==1371
replace unt_ok = 4 if f63==1372
replace unt_ok = 7 if f63==1373
replace unt_ok = 5 if f63==1374
replace unt_ok = 2 if f63==1375
replace unt_ok = 2 if f63==1376
replace unt_ok = 5 if f63==1377
replace unt_ok = 7 if f63==1378
replace unt_ok = 4 if f63==1379
replace unt_ok = 4 if f63==1380
replace unt_ok = 4 if f63==1381
replace unt_ok = 2 if f63==1382
replace unt_ok = 4 if f63==1383
replace unt_ok = 6 if f63==1384
replace unt_ok = 2 if f63==1385
replace unt_ok = 3 if f63==1386
replace unt_ok = 6 if f63==1387
replace unt_ok = 2 if f63==1388
replace unt_ok = 4 if f63==1389
replace unt_ok = 1 if f63==1390
replace unt_ok = 2 if f63==1391
replace unt_ok = 4 if f63==1392
replace unt_ok = 3 if f63==1393
replace unt_ok = 6 if f63==1394
replace unt_ok = 1 if f63==1395
replace unt_ok = 2 if f63==1396
replace unt_ok = 2 if f63==1397
replace unt_ok = 4 if f63==1398
replace unt_ok = 5 if f63==1399
replace unt_ok = 2 if f63==1400
replace unt_ok = 5 if f63==1401
replace unt_ok = 7 if f63==1402
replace unt_ok = 5 if f63==1403
replace unt_ok = 2 if f63==1404
replace unt_ok = 4 if f63==1405
replace unt_ok = 2 if f63==1406
replace unt_ok = 1 if f63==1407
replace unt_ok = 7 if f63==1408
replace unt_ok = 6 if f63==1409
replace unt_ok = 4 if f63==1410
replace unt_ok = 5 if f63==1412
replace unt_ok = 2 if f63==1413
replace unt_ok = 1 if f63==1414
replace unt_ok = 2 if f63==1415
replace unt_ok = 3 if f63==1416
replace unt_ok = 3 if f63==1417
replace unt_ok = 2 if f63==1418
replace unt_ok = 3 if f63==1419
replace unt_ok = 4 if f63==1420
replace unt_ok = 3 if f63==1421
replace unt_ok = 3 if f63==1422
replace unt_ok = 2 if f63==1423
replace unt_ok = 3 if f63==1424
replace unt_ok = 4 if f63==1425
replace unt_ok = 7 if f63==1426
replace unt_ok = 3 if f63==1427
replace unt_ok = 4 if f63==1428
replace unt_ok = 3 if f63==1429
replace unt_ok = 2 if f63==1430
replace unt_ok = 6 if f63==1431
replace unt_ok = 5 if f63==1432
replace unt_ok = 4 if f63==1433
replace unt_ok = 3 if f63==1434
replace unt_ok = 5 if f63==1435
replace unt_ok = 7 if f63==1436
replace unt_ok = 3 if f63==1437
replace unt_ok = 3 if f63==1438
replace unt_ok = 2 if f63==1439
replace unt_ok = 4 if f63==115
replace unt_ok = 4 if f63==143
replace unt_ok = 7 if f63==155
replace unt_ok = 3 if f63==159
replace unt_ok = 4 if f63==178
replace unt_ok = 2 if f63==181
replace unt_ok = 6 if f63==885
replace unt_ok = 4 if f63==292
replace unt_ok = 4 if f63==1025
replace unt_ok = 7 if f63==366
replace unt_ok = 3 if f63==470
replace unt_ok = 3 if f63==502
replace unt_ok = 4 if f63==647
replace unt_ok = 2 if f63==646
replace unt_ok = 2 if f63==1009
replace unt_ok = 6 if f63==989

gen unt_uk =11 if f63==1
replace unt_uk =44 if f63==2
replace unt_uk =47 if f63==3
replace unt_uk =63 if f63==4
replace unt_uk =48 if f63==5
replace unt_uk =72 if f63==6
replace unt_uk =11 if f63==7
replace unt_uk =72 if f63==9
replace unt_uk =63 if f63==10
replace unt_uk =22 if f63==11
replace unt_uk =23 if f63==12
replace unt_uk =51 if f63==13
replace unt_uk =62 if f63==14
replace unt_uk =44 if f63==15
replace unt_uk =62 if f63==16
replace unt_uk =62 if f63==17
replace unt_uk =48 if f63==18
replace unt_uk =22 if f63==19
replace unt_uk =53 if f63==20
replace unt_uk =42 if f63==21
replace unt_uk =31 if f63==22
replace unt_uk =41 if f63==23
replace unt_uk =33 if f63==24
replace unt_uk =11 if f63==25
replace unt_uk =48 if f63==26
replace unt_uk =22 if f63==27
replace unt_uk =41 if f63==28
replace unt_uk =63 if f63==29
replace unt_uk =25 if f63==30
replace unt_uk =25 if f63==31
replace unt_uk =61 if f63==32
replace unt_uk =71 if f63==33
replace unt_uk =47 if f63==34
replace unt_uk =63 if f63==35
replace unt_uk =41 if f63==36
replace unt_uk =63 if f63==37
replace unt_uk =46 if f63==38
replace unt_uk =41 if f63==39
replace unt_uk =31 if f63==40
replace unt_uk =22 if f63==41
replace unt_uk =72 if f63==42
replace unt_uk =71 if f63==44
replace unt_uk =45 if f63==45
replace unt_uk =43 if f63==46
replace unt_uk =63 if f63==47
replace unt_uk =61 if f63==48
replace unt_uk =11 if f63==49
replace unt_uk =62 if f63==50
replace unt_uk =43 if f63==51
replace unt_uk =26 if f63==52
replace unt_uk =44 if f63==53
replace unt_uk =22 if f63==54
replace unt_uk =62 if f63==55
replace unt_uk =31 if f63==56
replace unt_uk =31 if f63==57
replace unt_uk =48 if f63==58
replace unt_uk =43 if f63==59
replace unt_uk =48 if f63==60
replace unt_uk =24 if f63==61
replace unt_uk =42 if f63==62
replace unt_uk =71 if f63==63
replace unt_uk =53 if f63==64
replace unt_uk =27 if f63==65
replace unt_uk =53 if f63==66
replace unt_uk =44 if f63==67
replace unt_uk =53 if f63==68
replace unt_uk =63 if f63==69
replace unt_uk =11 if f63==70
replace unt_uk =62 if f63==71
replace unt_uk =26 if f63==72
replace unt_uk =34 if f63==73
replace unt_uk =61 if f63==74
replace unt_uk =61 if f63==75
replace unt_uk =11 if f63==76
replace unt_uk =63 if f63==77
replace unt_uk =21 if f63==78
replace unt_uk =54 if f63==79
replace unt_uk =48 if f63==81
replace unt_uk =46 if f63==82
replace unt_uk =25 if f63==83
replace unt_uk =21 if f63==84
replace unt_uk =45 if f63==85
replace unt_uk =11 if f63==86
replace unt_uk =34 if f63==87
replace unt_uk =48 if f63==88
replace unt_uk =34 if f63==89
replace unt_uk =71 if f63==90
replace unt_uk =26 if f63==91
replace unt_uk =27 if f63==92
replace unt_uk =48 if f63==93
replace unt_uk =21 if f63==95
replace unt_uk =34 if f63==96
replace unt_uk =25 if f63==97
replace unt_uk =26 if f63==98
replace unt_uk =45 if f63==99
replace unt_uk =46 if f63==100
replace unt_uk =53 if f63==101
replace unt_uk =45 if f63==102
replace unt_uk =21 if f63==103
replace unt_uk =27 if f63==104
replace unt_uk =26 if f63==105
replace unt_uk =34 if f63==106
replace unt_uk =34 if f63==107
replace unt_uk =72 if f63==108
replace unt_uk =21 if f63==109
replace unt_uk =21 if f63==110
replace unt_uk =46 if f63==111
replace unt_uk =11 if f63==112
replace unt_uk =31 if f63==113
replace unt_uk =27 if f63==114
replace unt_uk =46 if f63==116
replace unt_uk =21 if f63==117
replace unt_uk =25 if f63==118
replace unt_uk =72 if f63==119
replace unt_uk =24 if f63==120
replace unt_uk =31 if f63==121
replace unt_uk =27 if f63==122
replace unt_uk =63 if f63==123
replace unt_uk =61 if f63==124
replace unt_uk =62 if f63==125
replace unt_uk =23 if f63==126
replace unt_uk =11 if f63==127
replace unt_uk =27 if f63==128
replace unt_uk =21 if f63==129
replace unt_uk =72 if f63==130
replace unt_uk =71 if f63==131
replace unt_uk =61 if f63==132
replace unt_uk =21 if f63==133
replace unt_uk =21 if f63==134
replace unt_uk =45 if f63==135
replace unt_uk =45 if f63==136
replace unt_uk =53 if f63==137
replace unt_uk =31 if f63==138
replace unt_uk =52 if f63==139
replace unt_uk =21 if f63==140
replace unt_uk =26 if f63==141
replace unt_uk =42 if f63==142
replace unt_uk =48 if f63==144
replace unt_uk =27 if f63==145
replace unt_uk =27 if f63==146
replace unt_uk =33 if f63==147
replace unt_uk =21 if f63==148
replace unt_uk =62 if f63==149
replace unt_uk =45 if f63==150
replace unt_uk =34 if f63==151
replace unt_uk =27 if f63==152
replace unt_uk =24 if f63==153
replace unt_uk =48 if f63==154
replace unt_uk =45 if f63==156
replace unt_uk =21 if f63==157
replace unt_uk =11 if f63==158
replace unt_uk =48 if f63==160
replace unt_uk =53 if f63==161
replace unt_uk =21 if f63==162
replace unt_uk =31 if f63==163
replace unt_uk =21 if f63==164
replace unt_uk =31 if f63==165
replace unt_uk =23 if f63==166
replace unt_uk =48 if f63==167
replace unt_uk =42 if f63==168
replace unt_uk =31 if f63==169
replace unt_uk =42 if f63==170
replace unt_uk =32 if f63==171
replace unt_uk =34 if f63==172
replace unt_uk =52 if f63==173
replace unt_uk =61 if f63==174
replace unt_uk =31 if f63==175
replace unt_uk =33 if f63==176
replace unt_uk =11 if f63==177
replace unt_uk =63 if f63==179
replace unt_uk =35 if f63==180
replace unt_uk =46 if f63==182
replace unt_uk =21 if f63==183
replace unt_uk =21 if f63==184
replace unt_uk =27 if f63==185
replace unt_uk =61 if f63==186
replace unt_uk =21 if f63==187
replace unt_uk =31 if f63==188
replace unt_uk =27 if f63==189
replace unt_uk =34 if f63==190
replace unt_uk =27 if f63==191
replace unt_uk =26 if f63==192
replace unt_uk =26 if f63==193
replace unt_uk =24 if f63==194
replace unt_uk =61 if f63==195
replace unt_uk =27 if f63==196
replace unt_uk =27 if f63==198
replace unt_uk =21 if f63==199
replace unt_uk =62 if f63==200
replace unt_uk =46 if f63==201
replace unt_uk =61 if f63==202
replace unt_uk =21 if f63==203
replace unt_uk =53 if f63==204
replace unt_uk =31 if f63==205
replace unt_uk =46 if f63==206
replace unt_uk =11 if f63==207
replace unt_uk =21 if f63==208
replace unt_uk =26 if f63==209
replace unt_uk =46 if f63==210
replace unt_uk =31 if f63==213
replace unt_uk =48 if f63==214
replace unt_uk =48 if f63==215
replace unt_uk =26 if f63==216
replace unt_uk =34 if f63==217
replace unt_uk =48 if f63==218
replace unt_uk =11 if f63==219
replace unt_uk =21 if f63==220
replace unt_uk =23 if f63==221
replace unt_uk =34 if f63==222
replace unt_uk =72 if f63==223
replace unt_uk =21 if f63==224
replace unt_uk =54 if f63==225
replace unt_uk =47 if f63==226
replace unt_uk =26 if f63==227
replace unt_uk =34 if f63==228
replace unt_uk =21 if f63==229
replace unt_uk =47 if f63==230
replace unt_uk =27 if f63==231
replace unt_uk =11 if f63==232
replace unt_uk =34 if f63==233
replace unt_uk =24 if f63==234
replace unt_uk =22 if f63==235
replace unt_uk =48 if f63==236
replace unt_uk =63 if f63==237
replace unt_uk =11 if f63==238
replace unt_uk =53 if f63==239
replace unt_uk =23 if f63==240
replace unt_uk =54 if f63==241
replace unt_uk =23 if f63==242
replace unt_uk =61 if f63==243
replace unt_uk =72 if f63==245
replace unt_uk =21 if f63==246
replace unt_uk =46 if f63==247
replace unt_uk =45 if f63==248
replace unt_uk =52 if f63==249
replace unt_uk =34 if f63==250
replace unt_uk =61 if f63==251
replace unt_uk =11 if f63==252
replace unt_uk =53 if f63==253
replace unt_uk =11 if f63==254
replace unt_uk =21 if f63==255
replace unt_uk =23 if f63==256
replace unt_uk =11 if f63==257
replace unt_uk =27 if f63==258
replace unt_uk =31 if f63==259
replace unt_uk =11 if f63==260
replace unt_uk =21 if f63==261
replace unt_uk =41 if f63==262
replace unt_uk =62 if f63==263
replace unt_uk =45 if f63==264
replace unt_uk =21 if f63==265
replace unt_uk =21 if f63==266
replace unt_uk =46 if f63==267
replace unt_uk =23 if f63==268
replace unt_uk =31 if f63==269
replace unt_uk =71 if f63==270
replace unt_uk =23 if f63==271
replace unt_uk =22 if f63==272
replace unt_uk =27 if f63==273
replace unt_uk =27 if f63==274
replace unt_uk =52 if f63==275
replace unt_uk =27 if f63==277
replace unt_uk =47 if f63==278
replace unt_uk =24 if f63==279
replace unt_uk =34 if f63==280
replace unt_uk =34 if f63==281
replace unt_uk =27 if f63==282
replace unt_uk =27 if f63==283
replace unt_uk =72 if f63==284
replace unt_uk =61 if f63==285
replace unt_uk =11 if f63==287
replace unt_uk =52 if f63==288
replace unt_uk =47 if f63==289
replace unt_uk =21 if f63==290
replace unt_uk =46 if f63==291
replace unt_uk =21 if f63==293
replace unt_uk =33 if f63==294
replace unt_uk =71 if f63==295
replace unt_uk =33 if f63==296
replace unt_uk =21 if f63==297
replace unt_uk =31 if f63==298
replace unt_uk =12 if f63==299
replace unt_uk =63 if f63==300
replace unt_uk =45 if f63==301
replace unt_uk =27 if f63==302
replace unt_uk =31 if f63==303
replace unt_uk =52 if f63==304
replace unt_uk =21 if f63==306
replace unt_uk =35 if f63==307
replace unt_uk =53 if f63==308
replace unt_uk =46 if f63==309
replace unt_uk =63 if f63==310
replace unt_uk =11 if f63==311
replace unt_uk =11 if f63==313
replace unt_uk =34 if f63==314
replace unt_uk =27 if f63==315
replace unt_uk =35 if f63==317
replace unt_uk =31 if f63==318
replace unt_uk =23 if f63==319
replace unt_uk =27 if f63==320
replace unt_uk =42 if f63==321
replace unt_uk =47 if f63==322
replace unt_uk =54 if f63==323
replace unt_uk =27 if f63==324
replace unt_uk =52 if f63==325
replace unt_uk =72 if f63==326
replace unt_uk =26 if f63==327
replace unt_uk =22 if f63==328
replace unt_uk =51 if f63==329
replace unt_uk =45 if f63==340
replace unt_uk =23 if f63==341
replace unt_uk =72 if f63==342
replace unt_uk =45 if f63==343
replace unt_uk =48 if f63==345
replace unt_uk =61 if f63==346
replace unt_uk =34 if f63==347
replace unt_uk =34 if f63==348
replace unt_uk =24 if f63==349
replace unt_uk =11 if f63==350
replace unt_uk =62 if f63==351
replace unt_uk =46 if f63==352
replace unt_uk =27 if f63==353
replace unt_uk =25 if f63==354
replace unt_uk =45 if f63==355
replace unt_uk =52 if f63==356
replace unt_uk =23 if f63==357
replace unt_uk =71 if f63==358
replace unt_uk =27 if f63==359
replace unt_uk =21 if f63==360
replace unt_uk =46 if f63==361
replace unt_uk =62 if f63==362
replace unt_uk =35 if f63==363
replace unt_uk =61 if f63==364
replace unt_uk =23 if f63==365
replace unt_uk =61 if f63==367
replace unt_uk =61 if f63==368
replace unt_uk =33 if f63==369
replace unt_uk =35 if f63==370
replace unt_uk =62 if f63==371
replace unt_uk =71 if f63==372
replace unt_uk =63 if f63==374
replace unt_uk =61 if f63==375
replace unt_uk =61 if f63==376
replace unt_uk =45 if f63==377
replace unt_uk =42 if f63==378
replace unt_uk =21 if f63==379
replace unt_uk =61 if f63==380
replace unt_uk =21 if f63==381
replace unt_uk =27 if f63==382
replace unt_uk =43 if f63==383
replace unt_uk =72 if f63==384
replace unt_uk =42 if f63==385
replace unt_uk =46 if f63==386
replace unt_uk =21 if f63==387
replace unt_uk =61 if f63==388
replace unt_uk =52 if f63==389
replace unt_uk =35 if f63==390
replace unt_uk =21 if f63==391
replace unt_uk =71 if f63==392
replace unt_uk =12 if f63==394
replace unt_uk =34 if f63==395
replace unt_uk =11 if f63==396
replace unt_uk =34 if f63==397
replace unt_uk =22 if f63==398
replace unt_uk =27 if f63==399
replace unt_uk =63 if f63==400
replace unt_uk =34 if f63==401
replace unt_uk =53 if f63==402
replace unt_uk =72 if f63==403
replace unt_uk =63 if f63==404
replace unt_uk =42 if f63==405
replace unt_uk =21 if f63==406
replace unt_uk =54 if f63==407
replace unt_uk =11 if f63==408
replace unt_uk =52 if f63==409
replace unt_uk =61 if f63==410
replace unt_uk =24 if f63==411
replace unt_uk =45 if f63==412
replace unt_uk =21 if f63==413
replace unt_uk =33 if f63==414
replace unt_uk =43 if f63==415
replace unt_uk =11 if f63==416
replace unt_uk =24 if f63==417
replace unt_uk =63 if f63==418
replace unt_uk =31 if f63==419
replace unt_uk =26 if f63==420
replace unt_uk =47 if f63==421
replace unt_uk =63 if f63==422
replace unt_uk =41 if f63==423
replace unt_uk =61 if f63==424
replace unt_uk =45 if f63==425
replace unt_uk =46 if f63==426
replace unt_uk =71 if f63==428
replace unt_uk =31 if f63==429
replace unt_uk =21 if f63==430
replace unt_uk =52 if f63==431
replace unt_uk =63 if f63==432
replace unt_uk =46 if f63==433
replace unt_uk =27 if f63==434
replace unt_uk =46 if f63==435
replace unt_uk =31 if f63==436
replace unt_uk =62 if f63==437
replace unt_uk =46 if f63==438
replace unt_uk =21 if f63==439
replace unt_uk =48 if f63==440
replace unt_uk =21 if f63==441
replace unt_uk =63 if f63==442
replace unt_uk =43 if f63==443
replace unt_uk =21 if f63==444
replace unt_uk =35 if f63==445
replace unt_uk =62 if f63==446
replace unt_uk =61 if f63==447
replace unt_uk =72 if f63==448
replace unt_uk =11 if f63==449
replace unt_uk =34 if f63==450
replace unt_uk =72 if f63==451
replace unt_uk =61 if f63==452
replace unt_uk =23 if f63==453
replace unt_uk =72 if f63==454
replace unt_uk =53 if f63==455
replace unt_uk =21 if f63==456
replace unt_uk =63 if f63==457
replace unt_uk =52 if f63==458
replace unt_uk =71 if f63==459
replace unt_uk =41 if f63==460
replace unt_uk =34 if f63==461
replace unt_uk =34 if f63==462
replace unt_uk =48 if f63==463
replace unt_uk =26 if f63==464
replace unt_uk =32 if f63==465
replace unt_uk =72 if f63==466
replace unt_uk =62 if f63==467
replace unt_uk =48 if f63==468
replace unt_uk =33 if f63==469
replace unt_uk =34 if f63==471
replace unt_uk =53 if f63==472
replace unt_uk =24 if f63==473
replace unt_uk =72 if f63==474
replace unt_uk =46 if f63==475
replace unt_uk =62 if f63==476
replace unt_uk =63 if f63==477
replace unt_uk =34 if f63==478
replace unt_uk =61 if f63==479
replace unt_uk =33 if f63==480
replace unt_uk =71 if f63==481
replace unt_uk =48 if f63==482
replace unt_uk =71 if f63==483
replace unt_uk =52 if f63==484
replace unt_uk =48 if f63==485
replace unt_uk =53 if f63==486
replace unt_uk =63 if f63==487
replace unt_uk =34 if f63==488
replace unt_uk =26 if f63==489
replace unt_uk =54 if f63==490
replace unt_uk =71 if f63==491
replace unt_uk =22 if f63==492
replace unt_uk =33 if f63==493
replace unt_uk =46 if f63==494
replace unt_uk =61 if f63==495
replace unt_uk =71 if f63==496
replace unt_uk =45 if f63==497
replace unt_uk =63 if f63==498
replace unt_uk =42 if f63==499
replace unt_uk =25 if f63==500
replace unt_uk =53 if f63==501
replace unt_uk =63 if f63==503
replace unt_uk =35 if f63==504
replace unt_uk =63 if f63==505
replace unt_uk =27 if f63==506
replace unt_uk =21 if f63==507
replace unt_uk =46 if f63==508
replace unt_uk =35 if f63==509
replace unt_uk =27 if f63==510
replace unt_uk =48 if f63==511
replace unt_uk =11 if f63==512
replace unt_uk =11 if f63==513
replace unt_uk =11 if f63==514
replace unt_uk =11 if f63==515
replace unt_uk =41 if f63==516
replace unt_uk =21 if f63==517
replace unt_uk =34 if f63==518
replace unt_uk =53 if f63==519
replace unt_uk =21 if f63==520
replace unt_uk =21 if f63==521
replace unt_uk =61 if f63==522
replace unt_uk =41 if f63==523
replace unt_uk =46 if f63==524
replace unt_uk =53 if f63==525
replace unt_uk =71 if f63==526
replace unt_uk =53 if f63==527
replace unt_uk =34 if f63==528
replace unt_uk =34 if f63==529
replace unt_uk =33 if f63==530
replace unt_uk =71 if f63==531
replace unt_uk =71 if f63==532
replace unt_uk =41 if f63==533
replace unt_uk =25 if f63==534
replace unt_uk =52 if f63==535
replace unt_uk =47 if f63==536
replace unt_uk =33 if f63==537
replace unt_uk =24 if f63==538
replace unt_uk =34 if f63==539
replace unt_uk =31 if f63==540
replace unt_uk =52 if f63==541
replace unt_uk =48 if f63==542
replace unt_uk =72 if f63==543
replace unt_uk =46 if f63==544
replace unt_uk =52 if f63==545
replace unt_uk =45 if f63==546
replace unt_uk =45 if f63==547
replace unt_uk =52 if f63==548
replace unt_uk =46 if f63==549
replace unt_uk =35 if f63==550
replace unt_uk =52 if f63==551
replace unt_uk =41 if f63==552
replace unt_uk =22 if f63==553
replace unt_uk =25 if f63==554
replace unt_uk =21 if f63==555
replace unt_uk =62 if f63==556
replace unt_uk =34 if f63==557
replace unt_uk =46 if f63==558
replace unt_uk =11 if f63==559
replace unt_uk =45 if f63==560
replace unt_uk =72 if f63==561
replace unt_uk =34 if f63==562
replace unt_uk =72 if f63==563
replace unt_uk =48 if f63==564
replace unt_uk =72 if f63==565
replace unt_uk =72 if f63==566
replace unt_uk =48 if f63==567
replace unt_uk =22 if f63==568
replace unt_uk =21 if f63==569
replace unt_uk =34 if f63==570
replace unt_uk =71 if f63==571
replace unt_uk =52 if f63==572
replace unt_uk =71 if f63==573
replace unt_uk =31 if f63==574
replace unt_uk =51 if f63==575
replace unt_uk =27 if f63==576
replace unt_uk =53 if f63==577
replace unt_uk =33 if f63==578
replace unt_uk =33 if f63==579
replace unt_uk =33 if f63==580
replace unt_uk =35 if f63==582
replace unt_uk =71 if f63==583
replace unt_uk =33 if f63==584
replace unt_uk =31 if f63==585
replace unt_uk =23 if f63==586
replace unt_uk =71 if f63==587
replace unt_uk =27 if f63==588
replace unt_uk =23 if f63==589
replace unt_uk =11 if f63==591
replace unt_uk =21 if f63==592
replace unt_uk =71 if f63==593
replace unt_uk =33 if f63==594
replace unt_uk =45 if f63==595
replace unt_uk =21 if f63==596
replace unt_uk =61 if f63==598
replace unt_uk =62 if f63==599
replace unt_uk =46 if f63==600
replace unt_uk =26 if f63==601
replace unt_uk =11 if f63==602
replace unt_uk =21 if f63==603
replace unt_uk =27 if f63==604
replace unt_uk =52 if f63==605
replace unt_uk =34 if f63==606
replace unt_uk =11 if f63==607
replace unt_uk =61 if f63==608
replace unt_uk =21 if f63==609
replace unt_uk =34 if f63==610
replace unt_uk =27 if f63==611
replace unt_uk =21 if f63==612
replace unt_uk =46 if f63==613
replace unt_uk =25 if f63==614
replace unt_uk =21 if f63==615
replace unt_uk =45 if f63==616
replace unt_uk =27 if f63==617
replace unt_uk =53 if f63==618
replace unt_uk =61 if f63==619
replace unt_uk =25 if f63==620
replace unt_uk =21 if f63==621
replace unt_uk =11 if f63==622
replace unt_uk =53 if f63==623
replace unt_uk =35 if f63==624
replace unt_uk =11 if f63==625
replace unt_uk =62 if f63==626
replace unt_uk =34 if f63==627
replace unt_uk =21 if f63==628
replace unt_uk =27 if f63==629
replace unt_uk =53 if f63==630
replace unt_uk =54 if f63==631
replace unt_uk =72 if f63==632
replace unt_uk =11 if f63==633
replace unt_uk =63 if f63==634
replace unt_uk =62 if f63==635
replace unt_uk =21 if f63==636
replace unt_uk =45 if f63==637
replace unt_uk =34 if f63==638
replace unt_uk =27 if f63==639
replace unt_uk =27 if f63==640
replace unt_uk =72 if f63==641
replace unt_uk =25 if f63==642
replace unt_uk =63 if f63==643
replace unt_uk =27 if f63==645
replace unt_uk =41 if f63==648
replace unt_uk =27 if f63==649
replace unt_uk =23 if f63==650
replace unt_uk =21 if f63==651
replace unt_uk =61 if f63==652
replace unt_uk =48 if f63==653
replace unt_uk =48 if f63==654
replace unt_uk =31 if f63==655
replace unt_uk =22 if f63==656
replace unt_uk =35 if f63==657
replace unt_uk =71 if f63==658
replace unt_uk =62 if f63==659
replace unt_uk =42 if f63==660
replace unt_uk =63 if f63==662
replace unt_uk =34 if f63==663
replace unt_uk =11 if f63==664
replace unt_uk =32 if f63==665
replace unt_uk =21 if f63==666
replace unt_uk =48 if f63==667
replace unt_uk =21 if f63==668
replace unt_uk =34 if f63==669
replace unt_uk =27 if f63==671
replace unt_uk =21 if f63==672
replace unt_uk =63 if f63==673
replace unt_uk =43 if f63==674
replace unt_uk =33 if f63==675
replace unt_uk =27 if f63==675
replace unt_uk =62 if f63==676
replace unt_uk =71 if f63==677
replace unt_uk =63 if f63==678
replace unt_uk =21 if f63==679
replace unt_uk =26 if f63==680
replace unt_uk =21 if f63==681
replace unt_uk =48 if f63==682
replace unt_uk =61 if f63==683
replace unt_uk =27 if f63==684
replace unt_uk =61 if f63==685
replace unt_uk =61 if f63==686
replace unt_uk =27 if f63==687
replace unt_uk =21 if f63==688
replace unt_uk =44 if f63==689
replace unt_uk =72 if f63==690
replace unt_uk =42 if f63==691
replace unt_uk =32 if f63==692
replace unt_uk =33 if f63==693
replace unt_uk =61 if f63==694
replace unt_uk =62 if f63==695
replace unt_uk =52 if f63==696
replace unt_uk =23 if f63==697
replace unt_uk =11 if f63==698
replace unt_uk =61 if f63==699
replace unt_uk =21 if f63==700
replace unt_uk =53 if f63==701
replace unt_uk =35 if f63==702
replace unt_uk =26 if f63==703
replace unt_uk =27 if f63==704
replace unt_uk =27 if f63==705
replace unt_uk =31 if f63==706
replace unt_uk =21 if f63==707
replace unt_uk =53 if f63==708
replace unt_uk =46 if f63==709
replace unt_uk =48 if f63==710
replace unt_uk =42 if f63==711
replace unt_uk =63 if f63==712
replace unt_uk =11 if f63==713
replace unt_uk =31 if f63==714
replace unt_uk =27 if f63==715
replace unt_uk =21 if f63==716
replace unt_uk =63 if f63==717
replace unt_uk =48 if f63==718
replace unt_uk =21 if f63==719
replace unt_uk =45 if f63==720
replace unt_uk =27 if f63==721
replace unt_uk =46 if f63==722
replace unt_uk =21 if f63==723
replace unt_uk =62 if f63==724
replace unt_uk =48 if f63==725
replace unt_uk =71 if f63==726
replace unt_uk =45 if f63==727
replace unt_uk =46 if f63==728
replace unt_uk =34 if f63==729
replace unt_uk =48 if f63==730
replace unt_uk =35 if f63==731
replace unt_uk =34 if f63==732
replace unt_uk =48 if f63==733
replace unt_uk =21 if f63==734
replace unt_uk =63 if f63==735
replace unt_uk =11 if f63==736
replace unt_uk =34 if f63==737
replace unt_uk =31 if f63==738
replace unt_uk =61 if f63==739
replace unt_uk =27 if f63==740
replace unt_uk =62 if f63==741
replace unt_uk =24 if f63==742
replace unt_uk =26 if f63==743
replace unt_uk =71 if f63==744
replace unt_uk =12 if f63==745
replace unt_uk =31 if f63==746
replace unt_uk =53 if f63==747
replace unt_uk =31 if f63==748
replace unt_uk =44 if f63==749
replace unt_uk =22 if f63==750
replace unt_uk =43 if f63==751
replace unt_uk =53 if f63==752
replace unt_uk =34 if f63==753
replace unt_uk =31 if f63==754
replace unt_uk =26 if f63==755
replace unt_uk =11 if f63==756
replace unt_uk =11 if f63==757
replace unt_uk =34 if f63==758
replace unt_uk =45 if f63==759
replace unt_uk =21 if f63==760
replace unt_uk =27 if f63==761
replace unt_uk =26 if f63==762
replace unt_uk =12 if f63==763
replace unt_uk =32 if f63==764
replace unt_uk =34 if f63==765
replace unt_uk =21 if f63==766
replace unt_uk =63 if f63==767
replace unt_uk =11 if f63==768
replace unt_uk =34 if f63==769
replace unt_uk =48 if f63==770
replace unt_uk =31 if f63==771
replace unt_uk =26 if f63==772
replace unt_uk =34 if f63==773
replace unt_uk =27 if f63==774
replace unt_uk =21 if f63==775
replace unt_uk =31 if f63==776
replace unt_uk =48 if f63==777
replace unt_uk =27 if f63==778
replace unt_uk =41 if f63==779
replace unt_uk =31 if f63==780
replace unt_uk =34 if f63==781
replace unt_uk =72 if f63==782
replace unt_uk =22 if f63==783
replace unt_uk =26 if f63==784
replace unt_uk =45 if f63==785
replace unt_uk =27 if f63==786
replace unt_uk =26 if f63==787
replace unt_uk =21 if f63==788
replace unt_uk =46 if f63==789
replace unt_uk =26 if f63==790
replace unt_uk =23 if f63==791
replace unt_uk =11 if f63==792
replace unt_uk =46 if f63==793
replace unt_uk =46 if f63==794
replace unt_uk =61 if f63==795
replace unt_uk =42 if f63==796
replace unt_uk =21 if f63==797
replace unt_uk =35 if f63==798
replace unt_uk =31 if f63==799
replace unt_uk =21 if f63==800
replace unt_uk =12 if f63==801
replace unt_uk =22 if f63==802
replace unt_uk =34 if f63==803
replace unt_uk =22 if f63==804
replace unt_uk =52 if f63==805
replace unt_uk =22 if f63==806
replace unt_uk =22 if f63==807
replace unt_uk =34 if f63==808
replace unt_uk =46 if f63==809
replace unt_uk =48 if f63==810
replace unt_uk =47 if f63==811
replace unt_uk =42 if f63==812
replace unt_uk =34 if f63==813
replace unt_uk =27 if f63==814
replace unt_uk =48 if f63==815
replace unt_uk =27 if f63==816
replace unt_uk =72 if f63==817
replace unt_uk =54 if f63==818
replace unt_uk =41 if f63==819
replace unt_uk =21 if f63==820
replace unt_uk =21 if f63==821
replace unt_uk =12 if f63==822
replace unt_uk =71 if f63==823
replace unt_uk =45 if f63==824
replace unt_uk =21 if f63==825
replace unt_uk =51 if f63==826
replace unt_uk =31 if f63==827
replace unt_uk =72 if f63==828
replace unt_uk =46 if f63==829
replace unt_uk =61 if f63==830
replace unt_uk =53 if f63==831
replace unt_uk =47 if f63==832
replace unt_uk =63 if f63==833
replace unt_uk =24 if f63==834
replace unt_uk =33 if f63==835
replace unt_uk =21 if f63==836
replace unt_uk =46 if f63==837
replace unt_uk =35 if f63==838
replace unt_uk =61 if f63==839
replace unt_uk =21 if f63==840
replace unt_uk =11 if f63==841
replace unt_uk =27 if f63==842
replace unt_uk =33 if f63==843
replace unt_uk =61 if f63==844
replace unt_uk =11 if f63==845
replace unt_uk =27 if f63==846
replace unt_uk =54 if f63==847
replace unt_uk =21 if f63==848
replace unt_uk =27 if f63==849
replace unt_uk =72 if f63==850
replace unt_uk =26 if f63==851
replace unt_uk =27 if f63==852
replace unt_uk =27 if f63==853
replace unt_uk =21 if f63==854
replace unt_uk =27 if f63==855
replace unt_uk =63 if f63==856
replace unt_uk =53 if f63==857
replace unt_uk =21 if f63==858
replace unt_uk =72 if f63==859
replace unt_uk =33 if f63==860
replace unt_uk =21 if f63==861
replace unt_uk =63 if f63==862
replace unt_uk =11 if f63==863
replace unt_uk =34 if f63==865
replace unt_uk =45 if f63==866
replace unt_uk =27 if f63==867
replace unt_uk =21 if f63==868
replace unt_uk =47 if f63==869
replace unt_uk =33 if f63==870
replace unt_uk =52 if f63==871
replace unt_uk =25 if f63==872
replace unt_uk =23 if f63==873
replace unt_uk =63 if f63==874
replace unt_uk =25 if f63==875
replace unt_uk =72 if f63==876
replace unt_uk =21 if f63==877
replace unt_uk =24 if f63==878
replace unt_uk =63 if f63==879
replace unt_uk =11 if f63==880
replace unt_uk =34 if f63==881
replace unt_uk =46 if f63==882
replace unt_uk =12 if f63==883
replace unt_uk =52 if f63==884
replace unt_uk =21 if f63==886
replace unt_uk =53 if f63==887
replace unt_uk =27 if f63==888
replace unt_uk =21 if f63==889
replace unt_uk =48 if f63==890
replace unt_uk =63 if f63==891
replace unt_uk =23 if f63==892
replace unt_uk =21 if f63==893
replace unt_uk =48 if f63==894
replace unt_uk =34 if f63==895
replace unt_uk =21 if f63==896
replace unt_uk =11 if f63==897
replace unt_uk =54 if f63==898
replace unt_uk =34 if f63==899
replace unt_uk =53 if f63==900
replace unt_uk =11 if f63==901
replace unt_uk =21 if f63==902
replace unt_uk =34 if f63==903
replace unt_uk =45 if f63==904
replace unt_uk =21 if f63==905
replace unt_uk =21 if f63==906
replace unt_uk =26 if f63==907
replace unt_uk =45 if f63==908
replace unt_uk =62 if f63==909
replace unt_uk =11 if f63==910
replace unt_uk =27 if f63==911
replace unt_uk =48 if f63==912
replace unt_uk =21 if f63==913
replace unt_uk =34 if f63==914
replace unt_uk =22 if f63==915
replace unt_uk =24 if f63==916
replace unt_uk =45 if f63==917
replace unt_uk =34 if f63==918
replace unt_uk =34 if f63==919
replace unt_uk =35 if f63==920
replace unt_uk =31 if f63==921
replace unt_uk =46 if f63==922
replace unt_uk =45 if f63==923
replace unt_uk =21 if f63==924
replace unt_uk =26 if f63==925
replace unt_uk =11 if f63==926
replace unt_uk =21 if f63==927
replace unt_uk =27 if f63==928
replace unt_uk =21 if f63==929
replace unt_uk =33 if f63==930
replace unt_uk =53 if f63==931
replace unt_uk =63 if f63==932
replace unt_uk =34 if f63==933
replace unt_uk =11 if f63==934
replace unt_uk =53 if f63==935
replace unt_uk =11 if f63==936
replace unt_uk =22 if f63==937
replace unt_uk =52 if f63==938
replace unt_uk =61 if f63==939
replace unt_uk =63 if f63==940
replace unt_uk =47 if f63==941
replace unt_uk =11 if f63==942
replace unt_uk =42 if f63==943
replace unt_uk =63 if f63==944
replace unt_uk =32 if f63==945
replace unt_uk =26 if f63==946
replace unt_uk =72 if f63==947
replace unt_uk =44 if f63==948
replace unt_uk =52 if f63==949
replace unt_uk =27 if f63==950
replace unt_uk =53 if f63==951
replace unt_uk =11 if f63==952
replace unt_uk =63 if f63==953
replace unt_uk =43 if f63==954
replace unt_uk =11 if f63==955
replace unt_uk =21 if f63==956
replace unt_uk =62 if f63==957
replace unt_uk =45 if f63==958
replace unt_uk =71 if f63==959
replace unt_uk =46 if f63==960
replace unt_uk =48 if f63==961
replace unt_uk =12 if f63==962
replace unt_uk =24 if f63==963
replace unt_uk =43 if f63==964
replace unt_uk =21 if f63==965
replace unt_uk =61 if f63==966
replace unt_uk =12 if f63==967
replace unt_uk =72 if f63==968
replace unt_uk =26 if f63==969
replace unt_uk =53 if f63==970
replace unt_uk =21 if f63==971
replace unt_uk =21 if f63==972
replace unt_uk =31 if f63==973
replace unt_uk =24 if f63==974
replace unt_uk =33 if f63==975
replace unt_uk =21 if f63==976
replace unt_uk =72 if f63==977
replace unt_uk =46 if f63==978
replace unt_uk =25 if f63==979
replace unt_uk =41 if f63==980
replace unt_uk =53 if f63==981
replace unt_uk =52 if f63==982
replace unt_uk =26 if f63==983
replace unt_uk =34 if f63==984
replace unt_uk =63 if f63==985
replace unt_uk =72 if f63==986
replace unt_uk =25 if f63==987
replace unt_uk =46 if f63==988
replace unt_uk =63 if f63==989
replace unt_uk =27 if f63==990
replace unt_uk =54 if f63==991
replace unt_uk =27 if f63==992
replace unt_uk =26 if f63==993
replace unt_uk =35 if f63==994
replace unt_uk =62 if f63==995
replace unt_uk =48 if f63==996
replace unt_uk =34 if f63==997
replace unt_uk =63 if f63==998
replace unt_uk =53 if f63==999
replace unt_uk =12 if f63==1000
replace unt_uk =63 if f63==1001
replace unt_uk =31 if f63==1002
replace unt_uk =11 if f63==1003
replace unt_uk =11 if f63==1004
replace unt_uk =63 if f63==1005
replace unt_uk =43 if f63==1006
replace unt_uk =53 if f63==1007
replace unt_uk =25 if f63==1008
replace unt_uk =52 if f63==1010
replace unt_uk =21 if f63==1011
replace unt_uk =63 if f63==1012
replace unt_uk =21 if f63==1013
replace unt_uk =52 if f63==1014
replace unt_uk =54 if f63==1015
replace unt_uk =41 if f63==1016
replace unt_uk =53 if f63==1017
replace unt_uk =11 if f63==1018
replace unt_uk =34 if f63==1019
replace unt_uk =43 if f63==1020
replace unt_uk =26 if f63==1021
replace unt_uk =34 if f63==1022
replace unt_uk =61 if f63==1023
replace unt_uk =12 if f63==1024
replace unt_uk =53 if f63==1026
replace unt_uk =46 if f63==1027
replace unt_uk =34 if f63==1028
replace unt_uk =11 if f63==1029
replace unt_uk =46 if f63==1030
replace unt_uk =71 if f63==1031
replace unt_uk =27 if f63==1032
replace unt_uk =21 if f63==1033
replace unt_uk =52 if f63==1034
replace unt_uk =63 if f63==1035
replace unt_uk =46 if f63==1036
replace unt_uk =62 if f63==1037
replace unt_uk =52 if f63==1038
replace unt_uk =11 if f63==1039
replace unt_uk =21 if f63==1040
replace unt_uk =72 if f63==1041
replace unt_uk =44 if f63==1042
replace unt_uk =63 if f63==1043
replace unt_uk =63 if f63==1044
replace unt_uk =48 if f63==1045
replace unt_uk =48 if f63==1046
replace unt_uk =63 if f63==1047
replace unt_uk =63 if f63==1048
replace unt_uk =42 if f63==1049
replace unt_uk =21 if f63==1050
replace unt_uk =41 if f63==1051
replace unt_uk =11 if f63==1052
replace unt_uk =43 if f63==1054
replace unt_uk =34 if f63==1055
replace unt_uk =54 if f63==1056
replace unt_uk =44 if f63==1057
replace unt_uk =52 if f63==1058
replace unt_uk =43 if f63==1059
replace unt_uk =21 if f63==1060
replace unt_uk =34 if f63==1061
replace unt_uk =53 if f63==1062
replace unt_uk =34 if f63==1063
replace unt_uk =53 if f63==1064
replace unt_uk =61 if f63==1065
replace unt_uk =63 if f63==1066
replace unt_uk =34 if f63==1067
replace unt_uk =22 if f63==1068
replace unt_uk =52 if f63==1069
replace unt_uk =26 if f63==1070
replace unt_uk =46 if f63==1071
replace unt_uk =54 if f63==1072
replace unt_uk =27 if f63==1073
replace unt_uk =62 if f63==1074
replace unt_uk =11 if f63==1075
replace unt_uk =46 if f63==1076
replace unt_uk =48 if f63==1077
replace unt_uk =41 if f63==1078
replace unt_uk =52 if f63==1079
replace unt_uk =47 if f63==1080
replace unt_uk =11 if f63==1081
replace unt_uk =72 if f63==1082
replace unt_uk =43 if f63==1083
replace unt_uk =21 if f63==1084
replace unt_uk =41 if f63==1085
replace unt_uk =71 if f63==1086
replace unt_uk =12 if f63==1087
replace unt_uk =33 if f63==1088
replace unt_uk =46 if f63==1089
replace unt_uk =25 if f63==1090
replace unt_uk =34 if f63==1091
replace unt_uk =34 if f63==1092
replace unt_uk =11 if f63==1093
replace unt_uk =63 if f63==1094
replace unt_uk =46 if f63==1095
replace unt_uk =72 if f63==1096
replace unt_uk =31 if f63==1097
replace unt_uk =26 if f63==1098
replace unt_uk =46 if f63==1099
replace unt_uk =72 if f63==1100
replace unt_uk =72 if f63==1101
replace unt_uk =45 if f63==1102
replace unt_uk =22 if f63==1103
replace unt_uk =53 if f63==1104
replace unt_uk =45 if f63==1105
replace unt_uk =11 if f63==1106
replace unt_uk =34 if f63==1107
replace unt_uk =41 if f63==1108
replace unt_uk =48 if f63==1109
replace unt_uk =25 if f63==1110
replace unt_uk =21 if f63==1111
replace unt_uk =61 if f63==1112
replace unt_uk =33 if f63==1113
replace unt_uk =34 if f63==1114
replace unt_uk =24 if f63==1115
replace unt_uk =63 if f63==1116
replace unt_uk =43 if f63==1117
replace unt_uk =21 if f63==1118
replace unt_uk =72 if f63==1119
replace unt_uk =52 if f63==1120
replace unt_uk =11 if f63==1121
replace unt_uk =25 if f63==1122
replace unt_uk =21 if f63==1123
replace unt_uk =52 if f63==1124
replace unt_uk =35 if f63==1125
replace unt_uk =33 if f63==1126
replace unt_uk =34 if f63==1127
replace unt_uk =34 if f63==1128
replace unt_uk =42 if f63==1129
replace unt_uk =24 if f63==1130
replace unt_uk =31 if f63==1131
replace unt_uk =45 if f63==1132
replace unt_uk =62 if f63==1133
replace unt_uk =53 if f63==1134
replace unt_uk =31 if f63==1135
replace unt_uk =32 if f63==1136
replace unt_uk =61 if f63==1137
replace unt_uk =12 if f63==1138
replace unt_uk =35 if f63==1139
replace unt_uk =46 if f63==1140
replace unt_uk =46 if f63==1141
replace unt_uk =31 if f63==1142
replace unt_uk =21 if f63==1143
replace unt_uk =45 if f63==1144
replace unt_uk =25 if f63==1145
replace unt_uk =25 if f63==1146
replace unt_uk =47 if f63==1147
replace unt_uk =53 if f63==1148
replace unt_uk =51 if f63==1149
replace unt_uk =63 if f63==1150
replace unt_uk =52 if f63==1151
replace unt_uk =62 if f63==1152
replace unt_uk =27 if f63==1153
replace unt_uk =42 if f63==1154
replace unt_uk =47 if f63==1155
replace unt_uk =27 if f63==1156
replace unt_uk =45 if f63==1158
replace unt_uk =63 if f63==1159
replace unt_uk =48 if f63==1160
replace unt_uk =52 if f63==1161
replace unt_uk =11 if f63==1162
replace unt_uk =31 if f63==1163
replace unt_uk =45 if f63==1164
replace unt_uk =25 if f63==1165
replace unt_uk =63 if f63==1167
replace unt_uk =27 if f63==1168
replace unt_uk =44 if f63==1169
replace unt_uk =21 if f63==1170
replace unt_uk =63 if f63==1171
replace unt_uk =46 if f63==1172
replace unt_uk =23 if f63==1173
replace unt_uk =62 if f63==1174
replace unt_uk =61 if f63==1175
replace unt_uk =11 if f63==1176
replace unt_uk =21 if f63==1177
replace unt_uk =72 if f63==1178
replace unt_uk =53 if f63==1179
replace unt_uk =52 if f63==1180
replace unt_uk =27 if f63==1181
replace unt_uk =34 if f63==1182
replace unt_uk =21 if f63==1183
replace unt_uk =63 if f63==1184
replace unt_uk =47 if f63==1185
replace unt_uk =63 if f63==1186
replace unt_uk =45 if f63==1187
replace unt_uk =63 if f63==1188
replace unt_uk =31 if f63==1189
replace unt_uk =11 if f63==1190
replace unt_uk =26 if f63==1191
replace unt_uk =48 if f63==1192
replace unt_uk =48 if f63==1193
replace unt_uk =27 if f63==1194
replace unt_uk =42 if f63==1195
replace unt_uk =25 if f63==1196
replace unt_uk =21 if f63==1197
replace unt_uk =33 if f63==1198
replace unt_uk =53 if f63==1199
replace unt_uk =42 if f63==1200
replace unt_uk =27 if f63==1201
replace unt_uk =21 if f63==1202
replace unt_uk =46 if f63==1204
replace unt_uk =45 if f63==1205
replace unt_uk =34 if f63==1206
replace unt_uk =46 if f63==1207
replace unt_uk =48 if f63==1208
replace unt_uk =48 if f63==1209
replace unt_uk =21 if f63==1210
replace unt_uk =48 if f63==1211
replace unt_uk =21 if f63==1212
replace unt_uk =27 if f63==1213
replace unt_uk =48 if f63==1214
replace unt_uk =21 if f63==1215
replace unt_uk =12 if f63==1216
replace unt_uk =21 if f63==1217
replace unt_uk =21 if f63==1218
replace unt_uk =23 if f63==1219
replace unt_uk =34 if f63==1220
replace unt_uk =27 if f63==1221
replace unt_uk =52 if f63==1222
replace unt_uk =24 if f63==1223
replace unt_uk =21 if f63==1224
replace unt_uk =48 if f63==1225
replace unt_uk =11 if f63==1226
replace unt_uk =71 if f63==1227
replace unt_uk =35 if f63==1228
replace unt_uk =63 if f63==1229
replace unt_uk =61 if f63==1230
replace unt_uk =35 if f63==1231
replace unt_uk =27 if f63==1232
replace unt_uk =12 if f63==1233
replace unt_uk =21 if f63==1234
replace unt_uk =71 if f63==1235
replace unt_uk =31 if f63==1236
replace unt_uk =27 if f63==1237
replace unt_uk =31 if f63==1238
replace unt_uk =21 if f63==1239
replace unt_uk =53 if f63==1240
replace unt_uk =11 if f63==1241
replace unt_uk =11 if f63==1242
replace unt_uk =46 if f63==1243
replace unt_uk =48 if f63==1244
replace unt_uk =31 if f63==1245
replace unt_uk =23 if f63==1246
replace unt_uk =26 if f63==1247
replace unt_uk =34 if f63==1248
replace unt_uk =45 if f63==1249
replace unt_uk =25 if f63==1250
replace unt_uk =31 if f63==1251
replace unt_uk =32 if f63==1252
replace unt_uk =47 if f63==1253
replace unt_uk =31 if f63==1254
replace unt_uk =26 if f63==1255
replace unt_uk =43 if f63==1256
replace unt_uk =21 if f63==1257
replace unt_uk =61 if f63==1258
replace unt_uk =31 if f63==1259
replace unt_uk =33 if f63==1260
replace unt_uk =27 if f63==1261
replace unt_uk =35 if f63==1262
replace unt_uk =46 if f63==1263
replace unt_uk =63 if f63==1264
replace unt_uk =46 if f63==1265
replace unt_uk =46 if f63==1266
replace unt_uk =21 if f63==1267
replace unt_uk =27 if f63==1268
replace unt_uk =32 if f63==1269
replace unt_uk =34 if f63==1270
replace unt_uk =27 if f63==1271
replace unt_uk =44 if f63==1272
replace unt_uk =26 if f63==1273
replace unt_uk =63 if f63==1274
replace unt_uk =71 if f63==1275
replace unt_uk =31 if f63==1276
replace unt_uk =31 if f63==1277
replace unt_uk =52 if f63==1278
replace unt_uk =21 if f63==1279
replace unt_uk =45 if f63==1280
replace unt_uk =12 if f63==1281
replace unt_uk =32 if f63==1282
replace unt_uk =21 if f63==1283
replace unt_uk =46 if f63==1284
replace unt_uk =21 if f63==1285
replace unt_uk =41 if f63==1286
replace unt_uk =46 if f63==1287
replace unt_uk =35 if f63==1288
replace unt_uk =31 if f63==1289
replace unt_uk =45 if f63==1290
replace unt_uk =63 if f63==1291
replace unt_uk =52 if f63==1292
replace unt_uk =72 if f63==1293
replace unt_uk =11 if f63==1294
replace unt_uk =48 if f63==1295
replace unt_uk =62 if f63==1296
replace unt_uk =63 if f63==1297
replace unt_uk =25 if f63==1298
replace unt_uk =46 if f63==1299
replace unt_uk =31 if f63==1300
replace unt_uk =51 if f63==1301
replace unt_uk =12 if f63==1303
replace unt_uk =27 if f63==1304
replace unt_uk =11 if f63==1305
replace unt_uk =52 if f63==1306
replace unt_uk =24 if f63==1307
replace unt_uk =21 if f63==1308
replace unt_uk =34 if f63==1309
replace unt_uk =25 if f63==1310
replace unt_uk =46 if f63==1311
replace unt_uk =34 if f63==1312
replace unt_uk =34 if f63==1313
replace unt_uk =48 if f63==1314
replace unt_uk =34 if f63==1315
replace unt_uk =41 if f63==1316
replace unt_uk =24 if f63==1317
replace unt_uk =12 if f63==1318
replace unt_uk =26 if f63==1319
replace unt_uk =31 if f63==1320
replace unt_uk =52 if f63==1321
replace unt_uk =26 if f63==1322
replace unt_uk =26 if f63==1323
replace unt_uk =42 if f63==1324
replace unt_uk =34 if f63==1325
replace unt_uk =71 if f63==1326
replace unt_uk =34 if f63==1327
replace unt_uk =63 if f63==1328
replace unt_uk =53 if f63==1329
replace unt_uk =52 if f63==1330
replace unt_uk =22 if f63==1331
replace unt_uk =21 if f63==1332
replace unt_uk =24 if f63==1333
replace unt_uk =54 if f63==1334
replace unt_uk =62 if f63==1335
replace unt_uk =54 if f63==1336
replace unt_uk =27 if f63==1337
replace unt_uk =47 if f63==1338
replace unt_uk =33 if f63==1339
replace unt_uk =48 if f63==1340
replace unt_uk =34 if f63==1341
replace unt_uk =47 if f63==1342
replace unt_uk =63 if f63==1343
replace unt_uk =21 if f63==1344
replace unt_uk =43 if f63==1345
replace unt_uk =52 if f63==1346
replace unt_uk =62 if f63==1347
replace unt_uk =46 if f63==1348
replace unt_uk =61 if f63==1349
replace unt_uk =61 if f63==1350
replace unt_uk =27 if f63==1351
replace unt_uk =34 if f63==1352
replace unt_uk =71 if f63==1353
replace unt_uk =21 if f63==1354
replace unt_uk =34 if f63==1355
replace unt_uk =46 if f63==1356
replace unt_uk =44 if f63==1357
replace unt_uk =45 if f63==1358
replace unt_uk =31 if f63==1359
replace unt_uk =26 if f63==1360
replace unt_uk =43 if f63==1361
replace unt_uk =61 if f63==1362
replace unt_uk =11 if f63==1363
replace unt_uk =11 if f63==1364
replace unt_uk =26 if f63==1365
replace unt_uk =46 if f63==1366
replace unt_uk =63 if f63==1367
replace unt_uk =72 if f63==1368
replace unt_uk =46 if f63==1369
replace unt_uk =71 if f63==1370
replace unt_uk =27 if f63==1371
replace unt_uk =43 if f63==1372
replace unt_uk =71 if f63==1373
replace unt_uk =52 if f63==1374
replace unt_uk =21 if f63==1375
replace unt_uk =27 if f63==1376
replace unt_uk =52 if f63==1377
replace unt_uk =72 if f63==1378
replace unt_uk =48 if f63==1379
replace unt_uk =44 if f63==1380
replace unt_uk =46 if f63==1381
replace unt_uk =22 if f63==1382
replace unt_uk =48 if f63==1383
replace unt_uk =61 if f63==1384
replace unt_uk =21 if f63==1385
replace unt_uk =31 if f63==1386
replace unt_uk =63 if f63==1387
replace unt_uk =27 if f63==1388
replace unt_uk =43 if f63==1389
replace unt_uk =12 if f63==1390
replace unt_uk =23 if f63==1391
replace unt_uk =48 if f63==1392
replace unt_uk =32 if f63==1393
replace unt_uk =62 if f63==1394
replace unt_uk =12 if f63==1395
replace unt_uk =22 if f63==1396
replace unt_uk =24 if f63==1397
replace unt_uk =46 if f63==1398
replace unt_uk =53 if f63==1399
replace unt_uk =21 if f63==1400
replace unt_uk =53 if f63==1401
replace unt_uk =71 if f63==1402
replace unt_uk =53 if f63==1403
replace unt_uk =21 if f63==1404
replace unt_uk =46 if f63==1405
replace unt_uk =21 if f63==1406
replace unt_uk =12 if f63==1407
replace unt_uk =72 if f63==1408
replace unt_uk =61 if f63==1409
replace unt_uk =48 if f63==1410
replace unt_uk =54 if f63==1412
replace unt_uk =21 if f63==1413
replace unt_uk =12 if f63==1414
replace unt_uk =24 if f63==1415
replace unt_uk =31 if f63==1416
replace unt_uk =31 if f63==1417
replace unt_uk =21 if f63==1418
replace unt_uk =31 if f63==1419
replace unt_uk =46 if f63==1420
replace unt_uk =31 if f63==1421
replace unt_uk =35 if f63==1422
replace unt_uk =27 if f63==1423
replace unt_uk =33 if f63==1424
replace unt_uk =48 if f63==1425
replace unt_uk =72 if f63==1426
replace unt_uk =34 if f63==1427
replace unt_uk =43 if f63==1428
replace unt_uk =31 if f63==1429
replace unt_uk =24 if f63==1430
replace unt_uk =62 if f63==1431
replace unt_uk =52 if f63==1432
replace unt_uk =47 if f63==1433
replace unt_uk =34 if f63==1434
replace unt_uk =53 if f63==1435
replace unt_uk =71 if f63==1436
replace unt_uk =34 if f63==1437
replace unt_uk =34 if f63==1438
replace unt_uk =24 if f63==1439
replace unt_uk =46 if f63==115
replace unt_uk =45 if f63==143
replace unt_uk =71 if f63==155
replace unt_uk =34 if f63==159
replace unt_uk =45 if f63==178
replace unt_uk =24 if f63==181
replace unt_uk =63 if f63==885
replace unt_uk =46 if f63==292
replace unt_uk =45 if f63==1025
replace unt_uk =71 if f63==366
replace unt_uk =34 if f63==470
replace unt_uk =34 if f63==502
replace unt_uk =45 if f63==647
replace unt_uk =24 if f63==646
replace unt_uk =24 if f63==1009
replace unt_uk =63 if f63==989

label define unt_ok 1 `"Handelsunternehmen"', modify
label define unt_ok 2 `"Produzierendes/Verarbeitendes Gewerbe"', modify
label define unt_ok 3 `"Forschung & Entwicklung"', modify
label define unt_ok 4 `"Dienstleistungen"', modify
label define unt_ok 5 `"Recht / Beratung"', modify
label define unt_ok 6 `"Öffentlicher Dienst"', modify
label define unt_ok 7 `"Finanzen / Versicherungen"', modify

label define unt_uk 11 `"Einzelhandel"', modify
label define unt_uk 12 `"Großhandel"', modify
label define unt_uk 21 `"Maschinenbau"', modify
label define unt_uk 22 `"Luftfahrt"', modify
label define unt_uk 23 `"Schifffahrt"', modify
label define unt_uk 24 `"Energie"', modify
label define unt_uk 25 `"Bau"', modify
label define unt_uk 26 `"Elektro"', modify
label define unt_uk 27 `"Handelsware / Konsumgüter"', modify
label define unt_uk 31 `"Pharma / Biotech"', modify
label define unt_uk 32 `"Maschinenbau"', modify
label define unt_uk 33 `"Chemie"', modify
label define unt_uk 34 `"IT / Telekommunikation"', modify
label define unt_uk 35 `"Universitäten"', modify
label define unt_uk 41 `"Handwerk"', modify
label define unt_uk 42 `"klassische Dienstleistung"', modify
label define unt_uk 43 `"Private Bildungsträger / Arbeitsvermittlung"', modify
label define unt_uk 44 `"Entsorgung"', modify
label define unt_uk 45 `"Reise / Hotel / Gastronomie"', modify
label define unt_uk 46 `"Unterhaltung / Medien"', modify
label define unt_uk 47 `"Gesundheit"', modify
label define unt_uk 48 `"Verkehrsunternehmen"', modify
label define unt_uk 51 `"Rechtsanwalt / Notar"', modify
label define unt_uk 52 `"Beratung"', modify
label define unt_uk 53 `"Marketing"', modify
label define unt_uk 54 `"Planungsbüros"', modify
label define unt_uk 61 `"Krankenhäuser / Ärzte"', modify
label define unt_uk 62 `"Bildung / Soziales / Kirchen"', modify
label define unt_uk 63 `"Politik / Verwaltung"', modify
label define unt_uk 71 `"Banken / Finanzdienstleistung"', modify
label define unt_uk 72 `"Versicherung"', modify


label value unt_ok unt_ok
label var unt_ok "Oberkategorien für Unternehmen"
label value unt_uk unt_uk
label var unt_uk "Unterkategorien für Unternehmen"

tab flugart, gen(flugart_)
tab f32_aggr2, gen(mct_)

gen flug_lc_vs_kl = 1 if flugart_2==1
replace flug_lc_vs_kl=0 if flugart_3==1
label var flug_lc_vs_kl "Vergleich klassischer Linienverkehre mit Low-Cost-Angeboten"

label define f38_aggr 1 `"<=10"', modify
label define f38_aggr 2 `"<=20"', modify
label define f38_aggr 3 `"<=30"', modify
label define f38_aggr 4 `"<=40"', modify
label define f38_aggr 5 `"<=50"', modify
label define f38_aggr 6 `"<=60"', modify
label define f38_aggr 7 `"<=70"', modify
label define f38_aggr 8 `"<=80"', modify
label define f38_aggr 9 `"<=90"', modify

replace f38a_1=0 if missing(f38a_1) & f38a_2<300
replace f38a_2=0 if missing(f38a_2) & f38a_1<300
replace f38b_1=0 if missing(f38b_1) & f38a_1<300
replace f38b_2=0 if missing(f38b_2) & f38a_2<300


gen f38=f38a_1+f38a_2 if f38a_1<300 & f38a_2<300
gen f38_HAM=f38b_1+f38b_2 if f38b_1<300 & f38b_2<300

foreach x in "a_1" "a_2" "b_1" "b_2" "" "_HAM"{
quietly gen f38`x'_aggr = 1 if f38`x'<=10
quietly replace f38`x'_aggr = 0 if f38`x'==0
quietly replace f38`x'_aggr = 2 if f38`x'<=20 & f38`x'>10
quietly replace f38`x'_aggr = 3 if f38`x'<=30 & f38`x'>20
quietly replace f38`x'_aggr = 4 if f38`x'<=40 & f38`x'>30
quietly replace f38`x'_aggr = 5 if f38`x'<=50 & f38`x'>40
quietly replace f38`x'_aggr = 6 if f38`x'<=60 & f38`x'>50
quietly replace f38`x'_aggr = 7 if f38`x'<=70 & f38`x'>60
quietly replace f38`x'_aggr = 8 if f38`x'<=80 & f38`x'>70
quietly replace f38`x'_aggr = 9 if f38`x'<=250 & f38`x'>80
quietly gen f38`x'_vf = f38`x'>5 & f38`x'<300

quietly recode f38`x'_vf (0=.) if missing(f38`x')

label value f38`x'_aggr f38_aggr
label value f38`x'_vf jn
}

label var f38a_1_aggr "Anzahl jährlicher Geschäftsreisen (10er)"
label var f38b_1_aggr "Anzahl jährlicher Geschäftsreisen ab HAM (10er)"
label var f38a_2_aggr "Anzahl jährlicher Privatreisen (10er)"
label var f38b_2_aggr "Anzahl jährlicher Privatreisen ab HAM (10er)"
label var f38 "Anzahl Flugreisen im Jahr"
label var f38_aggr "Anzahl Flugreisen im Jahr (10er)" 
label var f38_vf "Vielflieger (>5)"

label var f38a_1_vf "Vielflieger Geschäftsreisen"
label var f38b_1_vf "Vielflieger Geschäftsreisen ab HAM"
label var f38a_2_vf "Vielflieger Privatreisen"
label var f38b_2_vf "Vielflieger Privatreisen ab HAM"

label var f38_HAM "Anzahl jährlicher Flüge ab HAM"
label var f38_HAM_aggr "Anzahl jährlicher Flüge ab HAM (10er)"
label var f38_HAM_vf "Vielflieger ab HAM"

gen f38_ant_HAM_G_ges = f38b_1/f38 if f38<300
gen f38_ant_HAM_P_ges = f38b_2/f38 if f38<300
gen f38_ant_G_ges = f38a_1/f38 if f38<300
gen f38_ant_P_ges = f38a_2/f38 if f38<300
gen f38_ant_HAM_ges = f38_HAM/f38 if f38<300

label var f38_ant_HAM_G_ges "Anteil Geschäftsreisen ab HAM zu Gesamtflugreisen"
label var f38_ant_HAM_P_ges "Anteil Privatreisen ab HAM zu Gesamtflugreisen"
label var f38_ant_G_ges "Anteil der Geschäftsreisen an jährlichen Gesamtreiseaufkommen"
label var f38_ant_P_ges "Anteil der Privatreisen an jährlichen Gesamtreiseaufkommen"
label var f38_ant_HAM_ges "Anteil der Flüge ab Hamburg zur Gesamtfluganzahl"

label define f38_ant_ges_gr4 1 `"<=.25"', modify
label define f38_ant_ges_gr4 2 `"<=.5"', modify
label define f38_ant_ges_gr4 3 `"<=.75"', modify
label define f38_ant_ges_gr4 4 `"<=1"', modify

foreach x in "HAM_G" "HAM_P" "G" "P" "HAM" {
quietly gen f38_ant_`x'_ges_gr4 = 0 if f38_ant_`x'_ges==0
quietly replace f38_ant_`x'_ges_gr4 = 1 if f38_ant_`x'_ges>0 & f38_ant_`x'_ges<=0.25
quietly replace f38_ant_`x'_ges_gr4 = 2 if f38_ant_`x'_ges>0.25 & f38_ant_`x'_ges<=0.5
quietly replace f38_ant_`x'_ges_gr4 = 3 if f38_ant_`x'_ges>0.5 & f38_ant_`x'_ges<=0.75
quietly replace f38_ant_`x'_ges_gr4 = 4 if f38_ant_`x'_ges>0.75 & f38_ant_`x'_ges<=1
label value f38_ant_`x'_ges_gr4 f38_ant_ges_gr4
}


* Quelle für Vielflieger http://oma.od.nih.gov/manualchapters/management/1500/05.html --> mehr als 5 Flugreisen im Jahr


* ttest f32, by(flugart_1)
* ttest f32, by(flug_lc_vs_kl)
xi: regress f32 flugart_*  f31  in_dt in_eu i.catchment_area i.f38_HAM_vf i.f38_ant_HAM_ges_gr4, nocons

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG06_08_09_10.dta", replace



* tab  f32_aggr2, gen(f32_aggr2_)
* tab Jahr, gen(Jahr_)
* tab f12n, gen(f12n_)
* tab  catchment_area, gen(ca_)
* tab  ziel, gen(ziel_)
* tab  altersgruppe, gen(ag_)
* tab hrg2, gen(hrg2_)
* tab  Stunde, gen(std_)
