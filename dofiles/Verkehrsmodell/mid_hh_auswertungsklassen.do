set more off
local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\MiD_Codiert\2008\"
use "`path'MiD_2008_2006_Wege_11.dta", clear

*++++++++++Auswertungsklassen für Modal-Split-Berechnungen
*++++++Hamburg

* Zentralität
label define zentral 3 "Unterzentrum" 4 "ländl. Peripherie", modify
label define zentral 2 "Mittelzentrum" 1 "Innenstadt", modify


gen zentral = 3 if st_hvv==102
replace zentral = 1 if st_hvv==103
replace zentral = 3 if st_hvv==104
replace zentral = 1 if st_hvv==108
replace zentral = 1 if st_hvv==109
replace zentral = 1 if st_hvv==110
replace zentral = 1 if st_hvv==111
replace zentral = 1 if st_hvv==112
replace zentral = 1 if st_hvv==114
replace zentral = 1 if st_hvv==115
replace zentral = 1 if st_hvv==116
replace zentral = 1 if st_hvv==117
replace zentral = 2 if st_hvv==119
replace zentral = 2 if st_hvv==121
replace zentral = 1 if st_hvv==201
replace zentral = 1 if st_hvv==202
replace zentral = 2 if st_hvv==203
replace zentral = 3 if st_hvv==204
replace zentral = 3 if st_hvv==205
replace zentral = 4 if st_hvv==206
replace zentral = 3 if st_hvv==207
replace zentral = 4 if st_hvv==208
replace zentral = 4 if st_hvv==209
replace zentral = 3 if st_hvv==210
replace zentral = 1 if st_hvv==211
replace zentral = 3 if st_hvv==212
replace zentral = 1 if st_hvv==213
replace zentral = 4 if st_hvv==214
replace zentral = 3 if st_hvv==301
replace zentral = 2 if st_hvv==302
replace zentral = 1 if st_hvv==303
replace zentral = 1 if st_hvv==304
replace zentral = 3 if st_hvv==305
replace zentral = 3 if st_hvv==306
replace zentral = 1 if st_hvv==307
replace zentral = 4 if st_hvv==308
replace zentral = 3 if st_hvv==309
replace zentral = 3 if st_hvv==401
replace zentral = 2 if st_hvv==402
replace zentral = 1 if st_hvv==403
replace zentral = 3 if st_hvv==404
replace zentral = 1 if st_hvv==405
replace zentral = 3 if st_hvv==406
replace zentral = 4 if st_hvv==407
replace zentral = 1 if st_hvv==408
replace zentral = 1 if st_hvv==409
replace zentral = 3 if st_hvv==410
replace zentral = 3 if st_hvv==411
replace zentral = 1 if st_hvv==412
replace zentral = 1 if st_hvv==413
replace zentral = 4 if st_hvv==501
replace zentral = 3 if st_hvv==502
replace zentral = 4 if st_hvv==503
replace zentral = 3 if st_hvv==504
replace zentral = 3 if st_hvv==505
replace zentral = 4 if st_hvv==506
replace zentral = 3 if st_hvv==507
replace zentral = 4 if st_hvv==508
replace zentral = 4 if st_hvv==509
replace zentral = 3 if st_hvv==510
replace zentral = 3 if st_hvv==511
replace zentral = 4 if st_hvv==512
replace zentral = 3 if st_hvv==513
replace zentral = 3 if st_hvv==514
replace zentral = 4 if st_hvv==515
replace zentral = 2 if st_hvv==516
replace zentral = 4 if st_hvv==517
replace zentral = 4 if st_hvv==518
replace zentral = 3 if st_hvv==601
replace zentral = 4 if st_hvv==602
replace zentral = 2 if st_hvv==603
replace zentral = 3 if st_hvv==604
replace zentral = 4 if st_hvv==605
replace zentral = 4 if st_hvv==606
replace zentral = 3 if st_hvv==607
replace zentral = 4 if st_hvv==608
replace zentral = 4 if st_hvv==609
replace zentral = 4 if st_hvv==610
replace zentral = 4 if st_hvv==611
replace zentral = 4 if st_hvv==612
replace zentral = 4 if st_hvv==613
replace zentral = 4 if st_hvv==702
replace zentral = 4 if st_hvv==703
replace zentral = 4 if st_hvv==704
replace zentral = 2 if st_hvv==706
replace zentral = 4 if st_hvv==707
replace zentral = 3 if st_hvv==708
replace zentral = 4 if st_hvv==709
replace zentral = 3 if st_hvv==710
replace zentral = 4 if st_hvv==712
replace zentral = 3 if st_hvv==713
replace zentral = 4 if st_hvv==715
replace zentral = 4 if st_hvv==716
replace zentral = 3 if st_hvv==717

label value zentral zentral
label var zentral "Zentralität des Wohnortes"

******* +++++ Einwohnerdichte je Stadtteil [EW/km²]
gen einwohnerdichte_EW = 4106 if st_hvv==102
replace einwohnerdichte_EW = 7388 if st_hvv==103
replace einwohnerdichte_EW = 606 if st_hvv==104
replace einwohnerdichte_EW = 12104 if st_hvv==108
replace einwohnerdichte_EW = 12081 if st_hvv==109
replace einwohnerdichte_EW = 3656 if st_hvv==110
replace einwohnerdichte_EW = 679 if st_hvv==111
replace einwohnerdichte_EW = 6440 if st_hvv==112
replace einwohnerdichte_EW = 5381 if st_hvv==114
replace einwohnerdichte_EW = 1208 if st_hvv==115
replace einwohnerdichte_EW = 5926 if st_hvv==116
replace einwohnerdichte_EW = 9436 if st_hvv==117
replace einwohnerdichte_EW = 1116 if st_hvv==119
replace einwohnerdichte_EW = 1411 if st_hvv==121
replace einwohnerdichte_EW = 9850 if st_hvv==201
replace einwohnerdichte_EW = 9684 if st_hvv==202
replace einwohnerdichte_EW = 2426 if st_hvv==203
replace einwohnerdichte_EW = 1538 if st_hvv==204
replace einwohnerdichte_EW = 4508 if st_hvv==205
replace einwohnerdichte_EW = 3983 if st_hvv==206
replace einwohnerdichte_EW = 5222 if st_hvv==207
replace einwohnerdichte_EW = 1552 if st_hvv==208
replace einwohnerdichte_EW = 3434 if st_hvv==209
replace einwohnerdichte_EW = 2055 if st_hvv==210
replace einwohnerdichte_EW = 11333 if st_hvv==211
replace einwohnerdichte_EW = 870 if st_hvv==212
replace einwohnerdichte_EW = 12775 if st_hvv==213
replace einwohnerdichte_EW = 1594 if st_hvv==214
replace einwohnerdichte_EW = 3468 if st_hvv==301
replace einwohnerdichte_EW = 16713 if st_hvv==302
replace einwohnerdichte_EW = 8204 if st_hvv==303
replace einwohnerdichte_EW = 17834 if st_hvv==304
replace einwohnerdichte_EW = 5095 if st_hvv==305
replace einwohnerdichte_EW = 3119 if st_hvv==306
replace einwohnerdichte_EW = 5708 if st_hvv==307
replace einwohnerdichte_EW = 3055 if st_hvv==308
replace einwohnerdichte_EW = 3911 if st_hvv==309
replace einwohnerdichte_EW = 4141 if st_hvv==401
replace einwohnerdichte_EW = 9709 if st_hvv==402
replace einwohnerdichte_EW = 10005 if st_hvv==403
replace einwohnerdichte_EW = 14693 if st_hvv==404
replace einwohnerdichte_EW = 8442 if st_hvv==405
replace einwohnerdichte_EW = 1773 if st_hvv==406
replace einwohnerdichte_EW = 1704 if st_hvv==407
replace einwohnerdichte_EW = 15482 if st_hvv==408
replace einwohnerdichte_EW = 8164 if st_hvv==409
replace einwohnerdichte_EW = 2964 if st_hvv==410
replace einwohnerdichte_EW = 1991 if st_hvv==411
replace einwohnerdichte_EW = 7191 if st_hvv==412
replace einwohnerdichte_EW = 6376 if st_hvv==413
replace einwohnerdichte_EW = 1349 if st_hvv==501
replace einwohnerdichte_EW = 4988 if st_hvv==502
replace einwohnerdichte_EW = 915 if st_hvv==503
replace einwohnerdichte_EW = 11927 if st_hvv==504
replace einwohnerdichte_EW = 4023 if st_hvv==505
replace einwohnerdichte_EW = 1832 if st_hvv==506
replace einwohnerdichte_EW = 4987 if st_hvv==507
replace einwohnerdichte_EW = 820 if st_hvv==508
replace einwohnerdichte_EW = 3585 if st_hvv==509
replace einwohnerdichte_EW = 2710 if st_hvv==510
replace einwohnerdichte_EW = 3257 if st_hvv==511
replace einwohnerdichte_EW = 2682 if st_hvv==512
replace einwohnerdichte_EW = 7720 if st_hvv==513
replace einwohnerdichte_EW = 3254 if st_hvv==514
replace einwohnerdichte_EW = 1707 if st_hvv==515
replace einwohnerdichte_EW = 5403 if st_hvv==516
replace einwohnerdichte_EW = 2375 if st_hvv==517
replace einwohnerdichte_EW = 254 if st_hvv==518
replace einwohnerdichte_EW = 1290 if st_hvv==601
replace einwohnerdichte_EW = 141 if st_hvv==602
replace einwohnerdichte_EW = 3586 if st_hvv==603
replace einwohnerdichte_EW = 137 if st_hvv==604
replace einwohnerdichte_EW = 353 if st_hvv==605
replace einwohnerdichte_EW = 278 if st_hvv==606
replace einwohnerdichte_EW = 2957 if st_hvv==607
replace einwohnerdichte_EW = 262 if st_hvv==608
replace einwohnerdichte_EW = 186 if st_hvv==609
replace einwohnerdichte_EW = 163 if st_hvv==610
replace einwohnerdichte_EW = 70 if st_hvv==611
replace einwohnerdichte_EW = 143 if st_hvv==612
replace einwohnerdichte_EW = 164 if st_hvv==613
replace einwohnerdichte_EW = 596 if st_hvv==702
replace einwohnerdichte_EW = 2794 if st_hvv==703
replace einwohnerdichte_EW = 70 if st_hvv==704
replace einwohnerdichte_EW = 5604 if st_hvv==706
replace einwohnerdichte_EW = 1530 if st_hvv==707
replace einwohnerdichte_EW = 1734 if st_hvv==708
replace einwohnerdichte_EW = 5259 if st_hvv==709
replace einwohnerdichte_EW = 1533 if st_hvv==710
replace einwohnerdichte_EW = 295 if st_hvv==712
replace einwohnerdichte_EW = 1198 if st_hvv==713
replace einwohnerdichte_EW = 1432 if st_hvv==715
replace einwohnerdichte_EW = 1307 if st_hvv==716
replace einwohnerdichte_EW = 4590 if st_hvv==717


******* +++++ Anteil Wohnungen in Ein-und Zweifamilienhäusern je Stadtteil
gen einwohnerdichte_EFH = 19.5 if st_hvv==102
replace einwohnerdichte_EFH = 1.3 if st_hvv==103
replace einwohnerdichte_EFH = 33.7 if st_hvv==104
replace einwohnerdichte_EFH = 0.5 if st_hvv==108
replace einwohnerdichte_EFH = 1 if st_hvv==109
replace einwohnerdichte_EFH = 4.5 if st_hvv==110
replace einwohnerdichte_EFH = 3.6 if st_hvv==111
replace einwohnerdichte_EFH = 6.7 if st_hvv==112
replace einwohnerdichte_EFH = 2 if st_hvv==114
replace einwohnerdichte_EFH = 5.6 if st_hvv==115
replace einwohnerdichte_EFH = 2.7 if st_hvv==116
replace einwohnerdichte_EFH = 2.6 if st_hvv==117
replace einwohnerdichte_EFH = 2 if st_hvv==119
replace einwohnerdichte_EFH = 15.4 if st_hvv==121
replace einwohnerdichte_EFH = 2.1 if st_hvv==201
replace einwohnerdichte_EFH = 1.4 if st_hvv==202
replace einwohnerdichte_EFH = 19.2 if st_hvv==203
replace einwohnerdichte_EFH = 46.6 if st_hvv==204
replace einwohnerdichte_EFH = 42.5 if st_hvv==205
replace einwohnerdichte_EFH = 41.7 if st_hvv==206
replace einwohnerdichte_EFH = 33.8 if st_hvv==207
replace einwohnerdichte_EFH = 48.8 if st_hvv==208
replace einwohnerdichte_EFH = 28 if st_hvv==209
replace einwohnerdichte_EFH = 37.8 if st_hvv==210
replace einwohnerdichte_EFH = 2.4 if st_hvv==211
replace einwohnerdichte_EFH = 46.9 if st_hvv==212
replace einwohnerdichte_EFH = 2.6 if st_hvv==213
replace einwohnerdichte_EFH = 50.6 if st_hvv==214
replace einwohnerdichte_EFH = 28.7 if st_hvv==301
replace einwohnerdichte_EFH = 1.1 if st_hvv==302
replace einwohnerdichte_EFH = 5.1 if st_hvv==303
replace einwohnerdichte_EFH = 1.7 if st_hvv==304
replace einwohnerdichte_EFH = 16.8 if st_hvv==305
replace einwohnerdichte_EFH = 34.8 if st_hvv==306
replace einwohnerdichte_EFH = 3.8 if st_hvv==307
replace einwohnerdichte_EFH = 41.1 if st_hvv==308
replace einwohnerdichte_EFH = 14.2 if st_hvv==309
replace einwohnerdichte_EFH = 19.4 if st_hvv==401
replace einwohnerdichte_EFH = 1.3 if st_hvv==402
replace einwohnerdichte_EFH = 0.7 if st_hvv==403
replace einwohnerdichte_EFH = 0.6 if st_hvv==404
replace einwohnerdichte_EFH = 3 if st_hvv==405
replace einwohnerdichte_EFH = 23.6 if st_hvv==406
replace einwohnerdichte_EFH = 42.4 if st_hvv==407
replace einwohnerdichte_EFH = 1.6 if st_hvv==408
replace einwohnerdichte_EFH = 2.3 if st_hvv==409
replace einwohnerdichte_EFH = 40.3 if st_hvv==410
replace einwohnerdichte_EFH = 20.9 if st_hvv==411
replace einwohnerdichte_EFH = 1.9 if st_hvv==412
replace einwohnerdichte_EFH = 2.6 if st_hvv==413
replace einwohnerdichte_EFH = 58.1 if st_hvv==501
replace einwohnerdichte_EFH = 28.5 if st_hvv==502
replace einwohnerdichte_EFH = 77.5 if st_hvv==503
replace einwohnerdichte_EFH = 1.5 if st_hvv==504
replace einwohnerdichte_EFH = 34.8 if st_hvv==505
replace einwohnerdichte_EFH = 28.6 if st_hvv==506
replace einwohnerdichte_EFH = 19.9 if st_hvv==507
replace einwohnerdichte_EFH = 89.1 if st_hvv==508
replace einwohnerdichte_EFH = 25.5 if st_hvv==509
replace einwohnerdichte_EFH = 58.1 if st_hvv==510
replace einwohnerdichte_EFH = 29.7 if st_hvv==511
replace einwohnerdichte_EFH = 69.7 if st_hvv==512
replace einwohnerdichte_EFH = 4.1 if st_hvv==513
replace einwohnerdichte_EFH = 26.2 if st_hvv==514
replace einwohnerdichte_EFH = 58.1 if st_hvv==515
replace einwohnerdichte_EFH = 13.2 if st_hvv==516
replace einwohnerdichte_EFH = 54 if st_hvv==517
replace einwohnerdichte_EFH = 75.5 if st_hvv==518
replace einwohnerdichte_EFH = 34.9 if st_hvv==601
replace einwohnerdichte_EFH = 79.5 if st_hvv==602
replace einwohnerdichte_EFH = 24.8 if st_hvv==603
replace einwohnerdichte_EFH = 78 if st_hvv==604
replace einwohnerdichte_EFH = 71.1 if st_hvv==605
replace einwohnerdichte_EFH = 76.4 if st_hvv==606
replace einwohnerdichte_EFH = 22.1 if st_hvv==607
replace einwohnerdichte_EFH = 86.6 if st_hvv==608
replace einwohnerdichte_EFH = 77.3 if st_hvv==609
replace einwohnerdichte_EFH = 74.9 if st_hvv==610
replace einwohnerdichte_EFH = 79 if st_hvv==611
replace einwohnerdichte_EFH = 72.6 if st_hvv==612
replace einwohnerdichte_EFH = 83.6 if st_hvv==613
replace einwohnerdichte_EFH = 37.4 if st_hvv==702
replace einwohnerdichte_EFH = 30.6 if st_hvv==703
replace einwohnerdichte_EFH = 77.2 if st_hvv==704
replace einwohnerdichte_EFH = 2.6 if st_hvv==706
replace einwohnerdichte_EFH = 34.3 if st_hvv==707
replace einwohnerdichte_EFH = 14.9 if st_hvv==708
replace einwohnerdichte_EFH = 56.6 if st_hvv==709
replace einwohnerdichte_EFH = 49.7 if st_hvv==710
replace einwohnerdichte_EFH = 58.5 if st_hvv==712
replace einwohnerdichte_EFH = 39.9 if st_hvv==713
replace einwohnerdichte_EFH = 50.6 if st_hvv==715
replace einwohnerdichte_EFH = 59.7 if st_hvv==716
replace einwohnerdichte_EFH = 19.1 if st_hvv==717


gen Bahnanschluss = 1 if st_hvv==102
replace Bahnanschluss = 1 if st_hvv==103
replace Bahnanschluss = 0 if st_hvv==104
replace Bahnanschluss = 1 if st_hvv==108
replace Bahnanschluss = 1 if st_hvv==109
replace Bahnanschluss = 1 if st_hvv==110
replace Bahnanschluss = 1 if st_hvv==111
replace Bahnanschluss = 1 if st_hvv==112
replace Bahnanschluss = 1 if st_hvv==114
replace Bahnanschluss = 1 if st_hvv==115
replace Bahnanschluss = 1 if st_hvv==116
replace Bahnanschluss = 1 if st_hvv==117
replace Bahnanschluss = 1 if st_hvv==119
replace Bahnanschluss = 1 if st_hvv==121
replace Bahnanschluss = 1 if st_hvv==201
replace Bahnanschluss = 1 if st_hvv==202
replace Bahnanschluss = 1 if st_hvv==203
replace Bahnanschluss = 1 if st_hvv==204
replace Bahnanschluss = 1 if st_hvv==205
replace Bahnanschluss = 1 if st_hvv==206
replace Bahnanschluss = 0 if st_hvv==207
replace Bahnanschluss = 1 if st_hvv==208
replace Bahnanschluss = 1 if st_hvv==209
replace Bahnanschluss = 1 if st_hvv==210
replace Bahnanschluss = 1 if st_hvv==211
replace Bahnanschluss = 1 if st_hvv==212
replace Bahnanschluss = 1 if st_hvv==213
replace Bahnanschluss = 1 if st_hvv==214
replace Bahnanschluss = 1 if st_hvv==301
replace Bahnanschluss = 1 if st_hvv==302
replace Bahnanschluss = 1 if st_hvv==303
replace Bahnanschluss = 1 if st_hvv==304
replace Bahnanschluss = 1 if st_hvv==305
replace Bahnanschluss = 1 if st_hvv==306
replace Bahnanschluss = 1 if st_hvv==307
replace Bahnanschluss = 1 if st_hvv==308
replace Bahnanschluss = 1 if st_hvv==309
replace Bahnanschluss = 1 if st_hvv==401
replace Bahnanschluss = 1 if st_hvv==402
replace Bahnanschluss = 1 if st_hvv==403
replace Bahnanschluss = 1 if st_hvv==404
replace Bahnanschluss = 1 if st_hvv==405
replace Bahnanschluss = 1 if st_hvv==406
replace Bahnanschluss = 0 if st_hvv==407
replace Bahnanschluss = 1 if st_hvv==408
replace Bahnanschluss = 1 if st_hvv==409
replace Bahnanschluss = 1 if st_hvv==410
replace Bahnanschluss = 1 if st_hvv==411
replace Bahnanschluss = 1 if st_hvv==412
replace Bahnanschluss = 1 if st_hvv==413
replace Bahnanschluss = 0 if st_hvv==501
replace Bahnanschluss = 0 if st_hvv==502
replace Bahnanschluss = 0 if st_hvv==503
replace Bahnanschluss = 1 if st_hvv==504
replace Bahnanschluss = 1 if st_hvv==505
replace Bahnanschluss = 0 if st_hvv==506
replace Bahnanschluss = 0 if st_hvv==507
replace Bahnanschluss = 0 if st_hvv==508
replace Bahnanschluss = 1 if st_hvv==509
replace Bahnanschluss = 1 if st_hvv==510
replace Bahnanschluss = 1 if st_hvv==511
replace Bahnanschluss = 0 if st_hvv==512
replace Bahnanschluss = 0 if st_hvv==513
replace Bahnanschluss = 1 if st_hvv==514
replace Bahnanschluss = 1 if st_hvv==515
replace Bahnanschluss = 1 if st_hvv==516
replace Bahnanschluss = 1 if st_hvv==517
replace Bahnanschluss = 1 if st_hvv==518
replace Bahnanschluss = 1 if st_hvv==601
replace Bahnanschluss = 0 if st_hvv==602
replace Bahnanschluss = 1 if st_hvv==603
replace Bahnanschluss = 1 if st_hvv==604
replace Bahnanschluss = 0 if st_hvv==605
replace Bahnanschluss = 0 if st_hvv==606
replace Bahnanschluss = 0 if st_hvv==607
replace Bahnanschluss = 1 if st_hvv==608
replace Bahnanschluss = 0 if st_hvv==609
replace Bahnanschluss = 0 if st_hvv==610
replace Bahnanschluss = 0 if st_hvv==611
replace Bahnanschluss = 0 if st_hvv==612
replace Bahnanschluss = 0 if st_hvv==613
replace Bahnanschluss = 0 if st_hvv==702
replace Bahnanschluss = 0 if st_hvv==703
replace Bahnanschluss = 0 if st_hvv==704
replace Bahnanschluss = 1 if st_hvv==706
replace Bahnanschluss = 1 if st_hvv==707
replace Bahnanschluss = 1 if st_hvv==708
replace Bahnanschluss = 0 if st_hvv==709
replace Bahnanschluss = 0 if st_hvv==710
replace Bahnanschluss = 0 if st_hvv==712
replace Bahnanschluss = 1 if st_hvv==713
replace Bahnanschluss = 0 if st_hvv==715
replace Bahnanschluss = 0 if st_hvv==716
replace Bahnanschluss = 0 if st_hvv==717

gen rk_gesa = 3 if st_hvv==102
replace rk_gesa = 2 if st_hvv==103
replace rk_gesa = 5 if st_hvv==104
replace rk_gesa = 2 if st_hvv==108
replace rk_gesa = 2 if st_hvv==109
replace rk_gesa = 2 if st_hvv==110
replace rk_gesa = 3 if st_hvv==111
replace rk_gesa = 3 if st_hvv==112
replace rk_gesa = 2 if st_hvv==114
replace rk_gesa = 3 if st_hvv==115
replace rk_gesa = 2 if st_hvv==116
replace rk_gesa = 2 if st_hvv==117
replace rk_gesa = 3 if st_hvv==119
replace rk_gesa = 2 if st_hvv==121
replace rk_gesa = 2 if st_hvv==201
replace rk_gesa = 2 if st_hvv==202
replace rk_gesa = 3 if st_hvv==203
replace rk_gesa = 4 if st_hvv==204
replace rk_gesa = 3 if st_hvv==205
replace rk_gesa = 4 if st_hvv==206
replace rk_gesa = 4 if st_hvv==207
replace rk_gesa = 3 if st_hvv==208
replace rk_gesa = 4 if st_hvv==209
replace rk_gesa = 3 if st_hvv==210
replace rk_gesa = 2 if st_hvv==211
replace rk_gesa = 4 if st_hvv==212
replace rk_gesa = 2 if st_hvv==213
replace rk_gesa = 4 if st_hvv==214
replace rk_gesa = 4 if st_hvv==301
replace rk_gesa = 2 if st_hvv==302
replace rk_gesa = 2 if st_hvv==303
replace rk_gesa = 2 if st_hvv==304
replace rk_gesa = 3 if st_hvv==305
replace rk_gesa = 3 if st_hvv==306
replace rk_gesa = 2 if st_hvv==307
replace rk_gesa = 4 if st_hvv==308
replace rk_gesa = 3 if st_hvv==309
replace rk_gesa = 3 if st_hvv==401
replace rk_gesa = 2 if st_hvv==402
replace rk_gesa = 2 if st_hvv==403
replace rk_gesa = 2 if st_hvv==404
replace rk_gesa = 2 if st_hvv==405
replace rk_gesa = 3 if st_hvv==406
replace rk_gesa = 4 if st_hvv==407
replace rk_gesa = 2 if st_hvv==408
replace rk_gesa = 2 if st_hvv==409
replace rk_gesa = 3 if st_hvv==410
replace rk_gesa = 3 if st_hvv==411
replace rk_gesa = 2 if st_hvv==412
replace rk_gesa = 2 if st_hvv==413
replace rk_gesa = 4 if st_hvv==501
replace rk_gesa = 3 if st_hvv==502
replace rk_gesa = 5 if st_hvv==503
replace rk_gesa = 2 if st_hvv==504
replace rk_gesa = 3 if st_hvv==505
replace rk_gesa = 5 if st_hvv==506
replace rk_gesa = 4 if st_hvv==507
replace rk_gesa = 5 if st_hvv==508
replace rk_gesa = 3 if st_hvv==509
replace rk_gesa = 4 if st_hvv==510
replace rk_gesa = 4 if st_hvv==511
replace rk_gesa = 4 if st_hvv==512
replace rk_gesa = 3 if st_hvv==513
replace rk_gesa = 4 if st_hvv==514
replace rk_gesa = 4 if st_hvv==515
replace rk_gesa = 2 if st_hvv==516
replace rk_gesa = 4 if st_hvv==517
replace rk_gesa = 5 if st_hvv==518
replace rk_gesa = 3 if st_hvv==601
replace rk_gesa = 5 if st_hvv==602
replace rk_gesa = 2 if st_hvv==603
replace rk_gesa = 5 if st_hvv==604
replace rk_gesa = 5 if st_hvv==605
replace rk_gesa = 5 if st_hvv==606
replace rk_gesa = 3 if st_hvv==607
replace rk_gesa = 5 if st_hvv==608
replace rk_gesa = 5 if st_hvv==609
replace rk_gesa = 5 if st_hvv==610
replace rk_gesa = 5 if st_hvv==611
replace rk_gesa = 5 if st_hvv==612
replace rk_gesa = 5 if st_hvv==613
replace rk_gesa = 5 if st_hvv==702
replace rk_gesa = 4 if st_hvv==703
replace rk_gesa = 5 if st_hvv==704
replace rk_gesa = 2 if st_hvv==706
replace rk_gesa = 4 if st_hvv==707
replace rk_gesa = 3 if st_hvv==708
replace rk_gesa = 4 if st_hvv==709
replace rk_gesa = 4 if st_hvv==710
replace rk_gesa = 5 if st_hvv==712
replace rk_gesa = 4 if st_hvv==713
replace rk_gesa = 5 if st_hvv==715
replace rk_gesa = 4 if st_hvv==716
replace rk_gesa = 4 if st_hvv==717

gen rk_gesa2 = 3 if st_hvv==102
replace rk_gesa2 = 1 if st_hvv==103
replace rk_gesa2 = 7 if st_hvv==104
replace rk_gesa2 = 1 if st_hvv==108
replace rk_gesa2 = 1 if st_hvv==109
replace rk_gesa2 = 1 if st_hvv==110
replace rk_gesa2 = 3 if st_hvv==111
replace rk_gesa2 = 3 if st_hvv==112
replace rk_gesa2 = 1 if st_hvv==114
replace rk_gesa2 = 3 if st_hvv==115
replace rk_gesa2 = 1 if st_hvv==116
replace rk_gesa2 = 1 if st_hvv==117
replace rk_gesa2 = 3 if st_hvv==119
replace rk_gesa2 = 2 if st_hvv==121
replace rk_gesa2 = 1 if st_hvv==201
replace rk_gesa2 = 2 if st_hvv==202
replace rk_gesa2 = 3 if st_hvv==203
replace rk_gesa2 = 6 if st_hvv==204
replace rk_gesa2 = 5 if st_hvv==205
replace rk_gesa2 = 6 if st_hvv==206
replace rk_gesa2 = 6 if st_hvv==207
replace rk_gesa2 = 6 if st_hvv==208
replace rk_gesa2 = 6 if st_hvv==209
replace rk_gesa2 = 6 if st_hvv==210
replace rk_gesa2 = 2 if st_hvv==211
replace rk_gesa2 = 6 if st_hvv==212
replace rk_gesa2 = 1 if st_hvv==213
replace rk_gesa2 = 7 if st_hvv==214
replace rk_gesa2 = 6 if st_hvv==301
replace rk_gesa2 = 2 if st_hvv==302
replace rk_gesa2 = 1 if st_hvv==303
replace rk_gesa2 = 1 if st_hvv==304
replace rk_gesa2 = 3 if st_hvv==305
replace rk_gesa2 = 6 if st_hvv==306
replace rk_gesa2 = 1 if st_hvv==307
replace rk_gesa2 = 7 if st_hvv==308
replace rk_gesa2 = 3 if st_hvv==309
replace rk_gesa2 = 3 if st_hvv==401
replace rk_gesa2 = 2 if st_hvv==402
replace rk_gesa2 = 1 if st_hvv==403
replace rk_gesa2 = 2 if st_hvv==404
replace rk_gesa2 = 2 if st_hvv==405
replace rk_gesa2 = 5 if st_hvv==406
replace rk_gesa2 = 6 if st_hvv==407
replace rk_gesa2 = 1 if st_hvv==408
replace rk_gesa2 = 1 if st_hvv==409
replace rk_gesa2 = 5 if st_hvv==410
replace rk_gesa2 = 6 if st_hvv==411
replace rk_gesa2 = 1 if st_hvv==412
replace rk_gesa2 = 1 if st_hvv==413
replace rk_gesa2 = 6 if st_hvv==501
replace rk_gesa2 = 3 if st_hvv==502
replace rk_gesa2 = 7 if st_hvv==503
replace rk_gesa2 = 1 if st_hvv==504
replace rk_gesa2 = 5 if st_hvv==505
replace rk_gesa2 = 7 if st_hvv==506
replace rk_gesa2 = 6 if st_hvv==507
replace rk_gesa2 = 7 if st_hvv==508
replace rk_gesa2 = 3 if st_hvv==509
replace rk_gesa2 = 6 if st_hvv==510
replace rk_gesa2 = 6 if st_hvv==511
replace rk_gesa2 = 7 if st_hvv==512
replace rk_gesa2 = 3 if st_hvv==513
replace rk_gesa2 = 7 if st_hvv==514
replace rk_gesa2 = 7 if st_hvv==515
replace rk_gesa2 = 3 if st_hvv==516
replace rk_gesa2 = 7 if st_hvv==517
replace rk_gesa2 = 7 if st_hvv==518
replace rk_gesa2 = 3 if st_hvv==601
replace rk_gesa2 = 7 if st_hvv==602
replace rk_gesa2 = 1 if st_hvv==603
replace rk_gesa2 = 7 if st_hvv==604
replace rk_gesa2 = 7 if st_hvv==605
replace rk_gesa2 = 7 if st_hvv==606
replace rk_gesa2 = 5 if st_hvv==607
replace rk_gesa2 = 7 if st_hvv==608
replace rk_gesa2 = 7 if st_hvv==609
replace rk_gesa2 = 7 if st_hvv==610
replace rk_gesa2 = 7 if st_hvv==611
replace rk_gesa2 = 7 if st_hvv==612
replace rk_gesa2 = 7 if st_hvv==613
replace rk_gesa2 = 7 if st_hvv==702
replace rk_gesa2 = 6 if st_hvv==703
replace rk_gesa2 = 7 if st_hvv==704
replace rk_gesa2 = 1 if st_hvv==706
replace rk_gesa2 = 6 if st_hvv==707
replace rk_gesa2 = 3 if st_hvv==708
replace rk_gesa2 = 6 if st_hvv==709
replace rk_gesa2 = 6 if st_hvv==710
replace rk_gesa2 = 7 if st_hvv==712
replace rk_gesa2 = 6 if st_hvv==713
replace rk_gesa2 = 7 if st_hvv==715
replace rk_gesa2 = 7 if st_hvv==716
replace rk_gesa2 = 6 if st_hvv==717

gen rk_gesa3 = 3 if st_hvv==102
replace rk_gesa3 = 1 if st_hvv==103
replace rk_gesa3 = 6 if st_hvv==104
replace rk_gesa3 = 1 if st_hvv==108
replace rk_gesa3 = 1 if st_hvv==109
replace rk_gesa3 = 1 if st_hvv==110
replace rk_gesa3 = 3 if st_hvv==111
replace rk_gesa3 = 3 if st_hvv==112
replace rk_gesa3 = 2 if st_hvv==114
replace rk_gesa3 = 3 if st_hvv==115
replace rk_gesa3 = 1 if st_hvv==116
replace rk_gesa3 = 1 if st_hvv==117
replace rk_gesa3 = 3 if st_hvv==119
replace rk_gesa3 = 2 if st_hvv==121
replace rk_gesa3 = 1 if st_hvv==201
replace rk_gesa3 = 2 if st_hvv==202
replace rk_gesa3 = 3 if st_hvv==203
replace rk_gesa3 = 6 if st_hvv==204
replace rk_gesa3 = 5 if st_hvv==205
replace rk_gesa3 = 6 if st_hvv==206
replace rk_gesa3 = 6 if st_hvv==207
replace rk_gesa3 = 5 if st_hvv==208
replace rk_gesa3 = 6 if st_hvv==209
replace rk_gesa3 = 5 if st_hvv==210
replace rk_gesa3 = 2 if st_hvv==211
replace rk_gesa3 = 6 if st_hvv==212
replace rk_gesa3 = 1 if st_hvv==213
replace rk_gesa3 = 6 if st_hvv==214
replace rk_gesa3 = 6 if st_hvv==301
replace rk_gesa3 = 2 if st_hvv==302
replace rk_gesa3 = 1 if st_hvv==303
replace rk_gesa3 = 1 if st_hvv==304
replace rk_gesa3 = 3 if st_hvv==305
replace rk_gesa3 = 5 if st_hvv==306
replace rk_gesa3 = 1 if st_hvv==307
replace rk_gesa3 = 6 if st_hvv==308
replace rk_gesa3 = 3 if st_hvv==309
replace rk_gesa3 = 3 if st_hvv==401
replace rk_gesa3 = 2 if st_hvv==402
replace rk_gesa3 = 1 if st_hvv==403
replace rk_gesa3 = 2 if st_hvv==404
replace rk_gesa3 = 2 if st_hvv==405
replace rk_gesa3 = 5 if st_hvv==406
replace rk_gesa3 = 6 if st_hvv==407
replace rk_gesa3 = 1 if st_hvv==408
replace rk_gesa3 = 1 if st_hvv==409
replace rk_gesa3 = 5 if st_hvv==410
replace rk_gesa3 = 5 if st_hvv==411
replace rk_gesa3 = 1 if st_hvv==412
replace rk_gesa3 = 1 if st_hvv==413
replace rk_gesa3 = 6 if st_hvv==501
replace rk_gesa3 = 3 if st_hvv==502
replace rk_gesa3 = 6 if st_hvv==503
replace rk_gesa3 = 1 if st_hvv==504
replace rk_gesa3 = 5 if st_hvv==505
replace rk_gesa3 = 6 if st_hvv==506
replace rk_gesa3 = 6 if st_hvv==507
replace rk_gesa3 = 6 if st_hvv==508
replace rk_gesa3 = 3 if st_hvv==509
replace rk_gesa3 = 6 if st_hvv==510
replace rk_gesa3 = 6 if st_hvv==511
replace rk_gesa3 = 6 if st_hvv==512
replace rk_gesa3 = 3 if st_hvv==513
replace rk_gesa3 = 6 if st_hvv==514
replace rk_gesa3 = 6 if st_hvv==515
replace rk_gesa3 = 2 if st_hvv==516
replace rk_gesa3 = 6 if st_hvv==517
replace rk_gesa3 = 6 if st_hvv==518
replace rk_gesa3 = 3 if st_hvv==601
replace rk_gesa3 = 6 if st_hvv==602
replace rk_gesa3 = 1 if st_hvv==603
replace rk_gesa3 = 6 if st_hvv==604
replace rk_gesa3 = 6 if st_hvv==605
replace rk_gesa3 = 6 if st_hvv==606
replace rk_gesa3 = 5 if st_hvv==607
replace rk_gesa3 = 6 if st_hvv==608
replace rk_gesa3 = 6 if st_hvv==609
replace rk_gesa3 = 6 if st_hvv==610
replace rk_gesa3 = 6 if st_hvv==611
replace rk_gesa3 = 6 if st_hvv==612
replace rk_gesa3 = 6 if st_hvv==613
replace rk_gesa3 = 6 if st_hvv==702
replace rk_gesa3 = 6 if st_hvv==703
replace rk_gesa3 = 6 if st_hvv==704
replace rk_gesa3 = 1 if st_hvv==706
replace rk_gesa3 = 6 if st_hvv==707
replace rk_gesa3 = 3 if st_hvv==708
replace rk_gesa3 = 6 if st_hvv==709
replace rk_gesa3 = 6 if st_hvv==710
replace rk_gesa3 = 6 if st_hvv==712
replace rk_gesa3 = 6 if st_hvv==713
replace rk_gesa3 = 6 if st_hvv==715
replace rk_gesa3 = 6 if st_hvv==716
replace rk_gesa3 = 6 if st_hvv==717

label var rk_gesa "abgewandelte Raumkategorien nach DA Gesa"
label define rk_gesa 2 "Innenstadt" 3 "Zwischenzone" 4 "Stadtrand" 5 "ländl. Raum", modify
label value rk_gesa rk_gesa

label var rk_gesa2 "abgewandelte Raumkategorien nach DA Gesa - diff + angepasst"
label define rk_gesa2 1 "Innenstadt 1" 2 "Innenstadt 2"  3 "Zwischenzone 1" 5 "Zwischenzone 3" 6 "Stadtrand" 7 "ländl. Raum", modify
label value rk_gesa2 rk_gesa2

label value rk_gesa3 rk_gesa2

recode rk_gesa3 (1 2 = 1 "Innenstadt") (3=2 "Zwischenzone 1") (5=3 "Zwischenzone 2") (6=4 "Stadtrand"), gen(rk_gesa4)
gen rk_gesa5 = rk_gesa4
replace rk_gesa5 = 5 if rk_gesa2==7
label define rk_gk4 5 "ländl. HH", add modify
label value rk_gesa5 rk_gesa4


gen hvv_stadt = 1 if krs_hvv==4 & polgk==5
replace hvv_stadt = 2 if krs_hvv==8 & polgk==5
replace hvv_stadt = 3 if krs_hvv==5 & polgk==4 & rtyp==1
replace hvv_stadt = 4 if krs_hvv==5 & polgk==4 & rtyp==3
replace hvv_stadt = 5 if krs_hvv==4 & polgk==4
replace hvv_stadt = 6 if krs_hvv==3 & polgk==4 & rtyp==1
replace hvv_stadt = 7 if krs_hvv==3 & polgk==4 & rtyp==3
replace hvv_stadt = 8 if krs_hvv==2 & polgk==4
replace hvv_stadt = 9 if krs_hvv==7 & polgk==4 & rtyp==1
replace hvv_stadt = 10 if krs_hvv==7 & polgk==4 & rtyp==3
replace hvv_stadt = 11 if krs_hvv==6 & polgk==4

label define hvv_stadt 1 "Norderstedt" 2 "Lüneburg" 3 "Ahrensburg, Reinbek" 4 "Bad Oldesloe" 5 "Henstedt-Ulzburg", modify
label define hvv_stadt 6 "Wedel, Pinneberg, Quickborn" 7 "Elmshorn" 8 "Geesthacht" 9 "Buxtehude" 10 "Stade", modify
label define hvv_stadt 11 "Winsen, Seevetal, Neu Wulmstorf, Buchholz i.d. Nordheide", modify
label value hvv_stadt hvv_stadt

gen aw_ms = 1 if hvv_stadt<. & rtyp==1
replace aw_ms = 2 if hvv_stadt<. & rtyp==3
replace aw_ms = 3 if polgk==1 & rtyp==1
replace aw_ms = 4 if polgk==2 & rtyp==1
replace aw_ms = 5 if polgk==3 & rtyp==1
replace aw_ms = 6 if polgk<4 & rtyp==3

* label value aw_ms rk_gesa4
label define aw_ms 1 "Städte um Hamburg" 2 "Städte auf dem Land im HVV" 3 "ländl. Gemeinde im HH-Umland <2.000" 4 "ländl. Gemeinde im HH-Umland [2.000;5.000]" 5 "ländl. Gemeinde im HH-Umland [5.000;20.000]" 6 "ländl. Gemeinde im HVV", modify
label value aw_ms aw_ms
set more off

* tab VM_6 aw_ms [iw=w_gew] if filter==1, col nofr
* mlogit VM_6 i.aw_ms [iw=w_gew] if filter==1 & VM_6<6

* tab VM_6 rk_gesa5 [iw=w_gew] if filter==1, col nofr
* mlogit VM_6 i.rk_gesa5 [iw=w_gew] if filter==1 & VM_6<6


gen auswertungsklassen_raum = aw_ms
replace auswertungsklassen_raum = rk_gesa5 + 6 if missing(aw_ms)
label value auswertungsklassen_raum aw_ms

label define aw_ms 7 "HH - Innenstadt" 8 "HH - Zwischenzone 1" 9 "HH - Zwischenzone 2" 10 "HH - Stadtrand" 11 "ländl. HH", modify


tab auswertungsklassen_raum VM_6 [iw=w_gew] if filter==1 & stichtag<6 & VM_6<6, row nofr
mlogit VM_6 i.auswertungsklassen_raum hp_alter c.hp_alter#c.hp_alter i.hp_sex [iw=w_gew] if filter==1 & VM_6<6 & stichtag<6, nolog
outreg2 using "M:\Nachfragedaten\Validierung\multivariat_test.xls",  sideway nopar nolabel ctitle("Modal Split mit Kontroll Alter & Geschlecht") e(r2_p) replace


foreach i in "ÖV" "Rad" "MIV_MF" "Fuß"{
	forvalues x=1/9 {
		forvalue y=2/9 {
			test [`i']: i`x'.auswertungsklassen_raum = [`i']: i`y'.auswertungsklassen_raum
		}
	}
}

* recode von Zweck nach Hierarchie
recode Zweck (1=1 "Arbeit") (3=2 "Bilden") (2=3 "dienstl.") (5=4 "Erledigung") (6=5 "Freizeit") (17=6 "Sport") (13=7 "Einkaufsbummel")/*
*/ (12=8 "allg. Einkauf") (11=9 "tägl. Einkauf") (10=10 "Freizeit ohne Zweck") (7=11 "Begleitung") (8=12 "Besuch/fremde Wohnung") (9=13 "sonstiges") (0=14 "Wohnen"), gen(zweck_rec)
sort hhid pid wsid
* min/max bilden nach hhid pid WWID
bysort hhid pid WWID: egen hz = min(zweck_rec) if filter==1 & stichtag<6

label value hz zweck_rec

save "`path'MiD_2008_2006_Wege_11_ausw.dta", replace 



cumul wegkm_k, gen(weg_rzk) by(VM_6 hat_zeitkarte)
gen weg_rzk_bew = 1-weg_rzk

cumul wegkm_k, gen(weg_kum) by(VM_6)
gen weg_bew = 1 - weg_kum
* line weg_bew wegkm_k if wegkm_k<50, sort by(VM_6)
cumul wegkm_k, gen(weg_r) by(VM_6 rtyp)
gen weg_r_bew = 1-weg_r

local f_weit = 100
local f_nah = 10

* allgemein
twoway (line weg_bew wegkm_k if wegkm_k<`f_weit' & VM_6==1, sort legend( label (1 "Fuß"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_weit' & VM_6==2, sort legend( label (2 "Rad"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_weit' & VM_6==3, sort legend( label (3 "ÖV"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_weit' & VM_6==4, sort legend( label (4 "MIV"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_weit' & VM_6==5, sort legend( label (5 "MIV-MF")))
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Allg100.gph", replace
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Allg100.jpg", replace

twoway (line weg_bew wegkm_k if wegkm_k<`f_nah' & VM_6==1, sort legend( label (1 "Fuß"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_nah' & VM_6==2, sort legend( label (2 "Rad"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_nah' & VM_6==3, sort legend( label (3 "ÖV"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_nah' & VM_6==4, sort legend( label (4 "MIV"))) /*
*/ (line weg_kum wegkm_k if wegkm_k<`f_nah' & VM_6==5, sort legend( label (5 "MIV-MF")))
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Allg10.gph", replace
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Allg10.jpg", replace

* nach Zeitkarte

twoway (line weg_rzk_bew wegkm_k if wegkm_k<`f_weit' & VM_6==2 &  hat_zeitkarte==1 , sort legend( label (1 "Rad - Zeitkarte") size(small)) lcolor(dknavy) /* 
*/ title("Bewertungsfunktionen nach ÖV-Zeitkartenbesitz", size(medium) color(black)) subtitle("für Radverkehr, ÖV und MIV", size(small)) /*
*/ ytitle( "Bewertungswahrscheinlichkeit für Verkehrsmittelnutzung [%]", size(small)) xtitle("Entfernung in km" , size(small)) graphregion(color(white)) /*
*/ ylabel( 0 "0" 0.25 "25" 0.5 "50" 0.75 "75" 1 "100") ylabel(,labsize(small)) xlabel(,labsize(small))) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_weit' & VM_6==2 &  hat_zeitkarte==0  , sort legend( label (2 "Rad - ohne Zeitkarte")) lcolor(cranberry)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_weit' & VM_6==3 &  hat_zeitkarte==1 , sort legend( label (3 "ÖV - Zeitkarte")) lcolor(blue)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_weit' & VM_6==3 &  hat_zeitkarte==0 , sort legend( label (4 "ÖV - ohne Zeitkarte")) lcolor(red)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_weit' & VM_6==4 &  hat_zeitkarte==1 , sort legend( label (5 "MIV - Zeitkarte")) lcolor(midblue)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_weit' & VM_6==4 &  hat_zeitkarte==0 , sort legend( label (6 "MIV - ohne Zeitkarte")) lcolor(orange))
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Zeitkarte100.gph", replace
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Zeitkarte100.jpg", replace

twoway (line weg_rzk_bew wegkm_k if wegkm_k<`f_nah' & VM_6==2 &  hat_zeitkarte==1 , sort legend( label (1 "Rad - Zeitkarte") size(small)) lcolor(dknavy) /* 
*/ title("Bewertungsfunktionen nach ÖV-Zeitkartenbesitz", size(medium) color(black)) subtitle("für Radverkehr, ÖV und MIV", size(small)) /*
*/ ytitle( "Bewertungswahrscheinlichkeit für Verkehrsmittelnutzung [%]", size(small)) xtitle("Entfernung in km" , size(small)) graphregion(color(white)) /*
*/ ylabel( 0 "0" 0.25 "25" 0.5 "50" 0.75 "75" 1 "100") ylabel(,labsize(small)) xlabel(,labsize(small))) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_nah' & VM_6==2 &  hat_zeitkarte==0  , sort legend( label (2 "Rad - ohne Zeitkarte")) lcolor(cranberry)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_nah' & VM_6==3 &  hat_zeitkarte==1 , sort legend( label (3 "ÖV - Zeitkarte")) lcolor(blue)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_nah' & VM_6==3 &  hat_zeitkarte==0 , sort legend( label (4 "ÖV - ohne Zeitkarte")) lcolor(red)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_nah' & VM_6==4 &  hat_zeitkarte==1 , sort legend( label (5 "MIV - Zeitkarte")) lcolor(midblue)) /*
*/ (line weg_rzk_bew wegkm_k if wegkm_k<`f_nah' & VM_6==4 &  hat_zeitkarte==0 , sort legend( label (6 "MIV - ohne Zeitkarte")) lcolor(orange))
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Zeitkarte10.gph", replace
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Zeitkarte10.jpg", replace

* nach Wohnort
twoway (line weg_r_bew wegkm_k if wegkm_k<`f_weit' & VM_6==2 &  rtyp==1 , sort legend( label (1 "Rad - Stadt") size(small)) lcolor(dknavy) /* 
*/ title("Bewertungsfunktionen nach Wohnort", size(medium) color(black)) subtitle("für Radverkehr, ÖV und MIV", size(small)) /*
*/ ytitle( "Bewertungswahrscheinlichkeit für Verkehrsmittelnutzung [%]", size(small)) xtitle("Entfernung in km" , size(small)) graphregion(color(white)) /*
*/ ylabel( 0 "0" 0.25 "25" 0.5 "50" 0.75 "75" 1 "100") ylabel(,labsize(small)) xlabel(,labsize(small))) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_weit' & VM_6==2 &  rtyp==3  , sort legend( label (2 "Rad - Land")) lcolor(cranberry)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_weit' & VM_6==3 & rtyp==1 , sort legend( label (3 "ÖV - Stadt")) lcolor(blue)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_weit' & VM_6==3 &  rtyp==3  , sort legend( label (4 "ÖV - Land")) lcolor(red)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_weit' & VM_6==4 &  rtyp==1 , sort legend( label (5 "MIV - Stadt")) lcolor(midblue)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_weit' & VM_6==4 &  rtyp==3  , sort legend( label (6 "MIV - Land")) lcolor(orange))
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Wohnort100.gph", replace
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Wohnort100.jpg", replace

twoway (line weg_r_bew wegkm_k if wegkm_k<`f_nah' & VM_6==2 &  rtyp==1 , sort legend( label (1 "Rad - Stadt") size(small)) lcolor(dknavy) /* 
*/ title("Bewertungsfunktionen nach Wohnort", size(medium) color(black)) subtitle("für Radverkehr, ÖV und MIV", size(small)) /*
*/ ytitle( "Bewertungswahrscheinlichkeit für Verkehrsmittelnutzung [%]", size(small)) xtitle("Entfernung in km" , size(small)) graphregion(color(white)) /*
*/ ylabel( 0 "0" 0.25 "25" 0.5 "50" 0.75 "75" 1 "100") ylabel(,labsize(small)) xlabel(,labsize(small))) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_nah' & VM_6==2 &  rtyp==3  , sort legend( label (2 "Rad - Land")) lcolor(cranberry)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_nah' & VM_6==3 & rtyp==1 , sort legend( label (3 "ÖV - Stadt")) lcolor(blue)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_nah' & VM_6==3 &  rtyp==3  , sort legend( label (4 "ÖV - Land")) lcolor(red)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_nah' & VM_6==4 &  rtyp==1 , sort legend( label (5 "MIV - Stadt")) lcolor(midblue)) /*
*/ (line weg_r_bew wegkm_k if wegkm_k<`f_nah' & VM_6==4 &  rtyp==3  , sort legend( label (6 "MIV - Land")) lcolor(orange))
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Wohnort10.gph", replace
graph save "M:\Nachfragedaten\Validierung\Bewertungsfkt_Wohnort10.jpg", replace
