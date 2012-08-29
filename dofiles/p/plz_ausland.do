clear
set memory 700m
use "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG10.dta", clear

* Umwandlung PLZ-Gebiete in Österreich
replace f7a = substr(f7a, -4,.) if length(f7a)>4 & (f8_2==29 | f8_2==7 | f8_2==27)
gen wohngebiet_ausland = 1 if substr(f7a, 1, 1)=="1" & f8_2==29
quietly replace wohngebiet_ausland = 2 if substr(f7a, 1, 1)=="2" & f8_2==29
quietly replace wohngebiet_ausland = 3 if substr(f7a, 1, 1)=="3" & f8_2==29
quietly replace wohngebiet_ausland = 4 if substr(f7a, 1, 1)=="4" & f8_2==29
quietly replace wohngebiet_ausland = 5 if substr(f7a, 1, 1)=="5" & f8_2==29
quietly replace wohngebiet_ausland = 6 if substr(f7a, 1, 1)=="6" & f8_2==29
quietly replace wohngebiet_ausland = 7 if substr(f7a, 1, 1)=="7" & f8_2==29
quietly replace wohngebiet_ausland = 8 if substr(f7a, 1, 1)=="8" & f8_2==29
quietly replace wohngebiet_ausland = 9 if substr(f7a, 1, 1)=="9" & f8_2==29

* Umwandlung PLZ-Gebiete in Dänemark
quietly replace wohngebiet_ausland = 10 if substr(f7a,1,1) == "1" & f8_2==7
quietly replace wohngebiet_ausland = 11 if substr(f7a,1,1) == "2" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "30" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "31" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "32" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "33" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "34" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "35" & f8_2==7
quietly replace wohngebiet_ausland = 12 if substr(f7a,1,2) == "36" & f8_2==7
quietly replace wohngebiet_ausland = 13 if substr(f7a,1,2) == "37" & f8_2==7
quietly replace wohngebiet_ausland = 14 if substr(f7a,1,2) == "38" & f8_2==7
quietly replace wohngebiet_ausland = 15 if substr(f7a,1,2) == "39" & f8_2==7
quietly replace wohngebiet_ausland = 16 if substr(f7a,1,1) == "4" & f8_2==7
quietly replace wohngebiet_ausland = 17 if substr(f7a,1,1) == "5" & f8_2==7
quietly replace wohngebiet_ausland = 18 if substr(f7a,1,1) == "6" & f8_2==7
quietly replace wohngebiet_ausland = 19 if substr(f7a,1,1) == "7" & f8_2==7
quietly replace wohngebiet_ausland = 20 if substr(f7a,1,1) == "8" & f8_2==7
quietly replace wohngebiet_ausland = 21 if substr(f7a,1,1) == "9" & f8_2==7

* Umwandlung PLZ-Gebiete in Frankreich
replace f7a = substr(f7a, -5,.) if length(f7a)>5 & f8_2==10
quietly replace wohngebiet_ausland = 22 if substr(f7a,1,2) == "67" & f8_2==10
quietly replace wohngebiet_ausland = 22 if substr(f7a,1,2) == "68" & f8_2==10
quietly replace wohngebiet_ausland = 23 if substr(f7a,1,2) == "24" & f8_2==10
quietly replace wohngebiet_ausland = 23 if substr(f7a,1,2) == "33" & f8_2==10
quietly replace wohngebiet_ausland = 23 if substr(f7a,1,2) == "40" & f8_2==10
quietly replace wohngebiet_ausland = 23 if substr(f7a,1,2) == "47" & f8_2==10
quietly replace wohngebiet_ausland = 23 if substr(f7a,1,2) == "64" & f8_2==10
quietly replace wohngebiet_ausland = 24 if substr(f7a,1,2) == "03" & f8_2==10
quietly replace wohngebiet_ausland = 24 if substr(f7a,1,2) == "15" & f8_2==10
quietly replace wohngebiet_ausland = 24 if substr(f7a,1,2) == "43" & f8_2==10
quietly replace wohngebiet_ausland = 24 if substr(f7a,1,2) == "63" & f8_2==10
quietly replace wohngebiet_ausland = 25 if substr(f7a,1,2) == "14" & f8_2==10
quietly replace wohngebiet_ausland = 25 if substr(f7a,1,2) == "50" & f8_2==10
quietly replace wohngebiet_ausland = 25 if substr(f7a,1,2) == "61" & f8_2==10
quietly replace wohngebiet_ausland = 26 if substr(f7a,1,2) == "21" & f8_2==10
quietly replace wohngebiet_ausland = 26 if substr(f7a,1,2) == "58" & f8_2==10
quietly replace wohngebiet_ausland = 26 if substr(f7a,1,2) == "71" & f8_2==10
quietly replace wohngebiet_ausland = 26 if substr(f7a,1,2) == "89" & f8_2==10
quietly replace wohngebiet_ausland = 27 if substr(f7a,1,2) == "22" & f8_2==10
quietly replace wohngebiet_ausland = 27 if substr(f7a,1,2) == "29" & f8_2==10
quietly replace wohngebiet_ausland = 27 if substr(f7a,1,2) == "35" & f8_2==10
quietly replace wohngebiet_ausland = 27 if substr(f7a,1,2) == "56" & f8_2==10
quietly replace wohngebiet_ausland = 28 if substr(f7a,1,2) == "18" & f8_2==10
quietly replace wohngebiet_ausland = 28 if substr(f7a,1,2) == "28" & f8_2==10
quietly replace wohngebiet_ausland = 28 if substr(f7a,1,2) == "36" & f8_2==10
quietly replace wohngebiet_ausland = 28 if substr(f7a,1,2) == "37" & f8_2==10
quietly replace wohngebiet_ausland = 28 if substr(f7a,1,2) == "41" & f8_2==10
quietly replace wohngebiet_ausland = 28 if substr(f7a,1,2) == "45" & f8_2==10
quietly replace wohngebiet_ausland = 29 if substr(f7a,1,2) == "08" & f8_2==10
quietly replace wohngebiet_ausland = 29 if substr(f7a,1,2) == "10" & f8_2==10
quietly replace wohngebiet_ausland = 29 if substr(f7a,1,2) == "51" & f8_2==10
quietly replace wohngebiet_ausland = 29 if substr(f7a,1,2) == "52" & f8_2==10
quietly replace wohngebiet_ausland = 30 if substr(f7a,1,2) == "20" & f8_2==10
quietly replace wohngebiet_ausland = 30 if substr(f7a,1,2) == "20" & f8_2==10
quietly replace wohngebiet_ausland = 31 if substr(f7a,1,2) == "25" & f8_2==10
quietly replace wohngebiet_ausland = 31 if substr(f7a,1,2) == "39" & f8_2==10
quietly replace wohngebiet_ausland = 31 if substr(f7a,1,2) == "70" & f8_2==10
quietly replace wohngebiet_ausland = 31 if substr(f7a,1,2) == "90" & f8_2==10
quietly replace wohngebiet_ausland = 32 if substr(f7a,1,2) == "27" & f8_2==10
quietly replace wohngebiet_ausland = 32 if substr(f7a,1,2) == "76" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "75" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "77" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "78" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "91" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "92" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "93" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "94" & f8_2==10
quietly replace wohngebiet_ausland = 33 if substr(f7a,1,2) == "95" & f8_2==10
quietly replace wohngebiet_ausland = 34 if substr(f7a,1,2) == "11" & f8_2==10
quietly replace wohngebiet_ausland = 34 if substr(f7a,1,2) == "30" & f8_2==10
quietly replace wohngebiet_ausland = 34 if substr(f7a,1,2) == "34" & f8_2==10
quietly replace wohngebiet_ausland = 34 if substr(f7a,1,2) == "48" & f8_2==10
quietly replace wohngebiet_ausland = 34 if substr(f7a,1,2) == "66" & f8_2==10
quietly replace wohngebiet_ausland = 35 if substr(f7a,1,2) == "19" & f8_2==10
quietly replace wohngebiet_ausland = 35 if substr(f7a,1,2) == "23" & f8_2==10
quietly replace wohngebiet_ausland = 35 if substr(f7a,1,2) == "87" & f8_2==10
quietly replace wohngebiet_ausland = 36 if substr(f7a,1,2) == "54" & f8_2==10
quietly replace wohngebiet_ausland = 36 if substr(f7a,1,2) == "55" & f8_2==10
quietly replace wohngebiet_ausland = 36 if substr(f7a,1,2) == "57" & f8_2==10
quietly replace wohngebiet_ausland = 36 if substr(f7a,1,2) == "88" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "09" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "12" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "31" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "32" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "46" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "65" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "81" & f8_2==10
quietly replace wohngebiet_ausland = 37 if substr(f7a,1,2) == "82" & f8_2==10
quietly replace wohngebiet_ausland = 21 if substr(f7a,1,2) == "04" & f8_2==10
quietly replace wohngebiet_ausland = 21 if substr(f7a,1,2) == "06" & f8_2==10
quietly replace wohngebiet_ausland = 22 if substr(f7a,1,2) == "07" & f8_2==10
quietly replace wohngebiet_ausland = 21 if substr(f7a,1,2) == "13" & f8_2==10
quietly replace wohngebiet_ausland = 20 if substr(f7a,1,2) == "16" & f8_2==10
quietly replace wohngebiet_ausland = 20 if substr(f7a,1,2) == "17" & f8_2==10
quietly replace wohngebiet_ausland = 22 if substr(f7a,1,2) == "38" & f8_2==10
quietly replace wohngebiet_ausland = 18 if substr(f7a,1,2) == "44" & f8_2==10
quietly replace wohngebiet_ausland = 17 if substr(f7a,1,2) == "59" & f8_2==10
quietly replace wohngebiet_ausland = 19 if substr(f7a,1,2) == "60" & f8_2==10
quietly replace wohngebiet_ausland = 22 if substr(f7a,1,2) == "69" & f8_2==10
quietly replace wohngebiet_ausland = 22 if substr(f7a,1,2) == "74" & f8_2==10
quietly replace wohngebiet_ausland = 20 if substr(f7a,1,2) == "79" & f8_2==10
quietly replace wohngebiet_ausland = 21 if substr(f7a,1,2) == "83" & f8_2==10


* Umwandlung PLZ-Gebiete in USA
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "831" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "830" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "829" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "828" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "827" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "826" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "825" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "824" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "823" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "822" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "821" & f8_2==102
quietly replace wohngebiet_ausland = 96 if substr(f7a,1,3) == "820" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "268" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "267" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "266" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "265" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "264" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "263" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "262" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "261" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "260" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "259" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "258" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "257" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "256" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "255" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "254" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "253" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "252" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "251" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "250" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "249" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "248" & f8_2==102
quietly replace wohngebiet_ausland = 95 if substr(f7a,1,3) == "247" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "549" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "548" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "547" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "546" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "545" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "544" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "543" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "542" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "541" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "540" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "539" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "538" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "537" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "535" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "534" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "532" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "531" & f8_2==102
quietly replace wohngebiet_ausland = 94 if substr(f7a,1,3) == "530" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "994" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "993" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "992" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "991" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "990" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "989" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "988" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "987" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "986" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "985" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "984" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "983" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "982" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "981" & f8_2==102
quietly replace wohngebiet_ausland = 93 if substr(f7a,1,3) == "980" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "059" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "058" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "057" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "056" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "055" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "054" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "053" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "052" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "051" & f8_2==102
quietly replace wohngebiet_ausland = 92 if substr(f7a,1,3) == "050" & f8_2==102
quietly replace wohngebiet_ausland = 91 if substr(f7a,1,3) == "008" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "246" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "245" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "244" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "243" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "242" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "241" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "240" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "239" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "238" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "237" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "236" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "235" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "234" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "233" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "232" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "231" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "230" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "229" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "228" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "227" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "226" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "225" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "224" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "223" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "222" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "221" & f8_2==102
quietly replace wohngebiet_ausland = 90 if substr(f7a,1,3) == "220" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "847" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "846" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "845" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "844" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "843" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "842" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "841" & f8_2==102
quietly replace wohngebiet_ausland = 89 if substr(f7a,1,3) == "840" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "885" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "799" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "798" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "797" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "796" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "795" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "794" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "793" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "792" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "791" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "790" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "789" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "788" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "787" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "786" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "785" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "784" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "783" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "782" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "781" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "780" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "779" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "778" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "777" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "776" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "775" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "774" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "773" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "772" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "770" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "769" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "768" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "767" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "766" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "765" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "764" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "763" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "762" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "761" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "760" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "759" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "758" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "757" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "756" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "755" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "754" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "753" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "752" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "751" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "750" & f8_2==102
quietly replace wohngebiet_ausland = 88 if substr(f7a,1,3) == "733" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "385" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "384" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "383" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "382" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "381" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "380" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "379" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "378" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "377" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "376" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "375" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "374" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "373" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "372" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "371" & f8_2==102
quietly replace wohngebiet_ausland = 87 if substr(f7a,1,3) == "370" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "577" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "576" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "575" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "574" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "573" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "572" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "571" & f8_2==102
quietly replace wohngebiet_ausland = 86 if substr(f7a,1,3) == "570" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "299" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "298" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "297" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "296" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "295" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "294" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "293" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "292" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "291" & f8_2==102
quietly replace wohngebiet_ausland = 85 if substr(f7a,1,3) == "290" & f8_2==102
quietly replace wohngebiet_ausland = 84 if substr(f7a,1,3) == "029" & f8_2==102
quietly replace wohngebiet_ausland = 84 if substr(f7a,1,3) == "028" & f8_2==102
quietly replace wohngebiet_ausland = 82 if substr(f7a,1,3) == "009" & f8_2==102
quietly replace wohngebiet_ausland = 82 if substr(f7a,1,3) == "007" & f8_2==102
quietly replace wohngebiet_ausland = 82 if substr(f7a,1,3) == "006" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "196" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "195" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "194" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "193" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "192" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "191" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "190" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "189" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "188" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "187" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "186" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "185" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "184" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "183" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "182" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "181" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "180" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "179" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "178" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "177" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "176" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "175" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "174" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "173" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "172" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "171" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "170" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "169" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "168" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "167" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "166" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "165" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "164" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "163" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "162" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "161" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "160" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "159" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "158" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "157" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "156" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "155" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "154" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "153" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "152" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "151" & f8_2==102
quietly replace wohngebiet_ausland = 81 if substr(f7a,1,3) == "150" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "979" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "978" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "977" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "976" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "975" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "974" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "973" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "972" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "971" & f8_2==102
quietly replace wohngebiet_ausland = 80 if substr(f7a,1,3) == "970" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "749" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "748" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "747" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "746" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "745" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "744" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "743" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "741" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "740" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "739" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "738" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "737" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "736" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "735" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "734" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "731" & f8_2==102
quietly replace wohngebiet_ausland = 79 if substr(f7a,1,3) == "730" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "459" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "458" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "457" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "456" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "455" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "454" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "453" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "452" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "451" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "450" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "449" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "448" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "447" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "446" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "445" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "444" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "443" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "442" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "441" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "440" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "439" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "438" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "437" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "436" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "435" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "434" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "433" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "432" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "431" & f8_2==102
quietly replace wohngebiet_ausland = 78 if substr(f7a,1,3) == "430" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "149" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "148" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "147" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "146" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "145" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "144" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "143" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "142" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "141" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "140" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "139" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "138" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "137" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "136" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "135" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "134" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "133" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "132" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "131" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "130" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "129" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "128" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "127" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "126" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "125" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "124" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "123" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "122" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "121" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "120" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "119" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "118" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "117" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "116" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "115" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "114" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "113" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "112" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "111" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "110" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "109" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "108" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "107" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "106" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "105" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "104" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "103" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "102" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "101" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "100" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "098" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "097" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "096" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "095" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "094" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "093" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "093" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "093" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "093" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "093" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "092" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "092" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "092" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "091" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "090" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "005" & f8_2==102
quietly replace wohngebiet_ausland = 77 if substr(f7a,1,3) == "004" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "898" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "897" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "895" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "894" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "893" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "891" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "890" & f8_2==102
quietly replace wohngebiet_ausland = 76 if substr(f7a,1,3) == "889" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "884" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "883" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "882" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "881" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "880" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "879" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "878" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "877" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "875" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "874" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "873" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "872" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "871" & f8_2==102
quietly replace wohngebiet_ausland = 75 if substr(f7a,1,3) == "870" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "089" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "088" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "087" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "086" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "085" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "084" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "083" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "082" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "081" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "080" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "079" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "078" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "077" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "076" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "075" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "074" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "073" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "072" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "071" & f8_2==102
quietly replace wohngebiet_ausland = 74 if substr(f7a,1,3) == "070" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "038" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "037" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "036" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "035" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "034" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "033" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "032" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "031" & f8_2==102
quietly replace wohngebiet_ausland = 73 if substr(f7a,1,3) == "030" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "693" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "692" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "691" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "690" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "689" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "688" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "687" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "686" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "685" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "684" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "683" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "681" & f8_2==102
quietly replace wohngebiet_ausland = 72 if substr(f7a,1,3) == "680" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "588" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "587" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "586" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "585" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "584" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "583" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "582" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "581" & f8_2==102
quietly replace wohngebiet_ausland = 71 if substr(f7a,1,3) == "580" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "289" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "288" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "287" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "286" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "285" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "284" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "283" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "282" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "281" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "280" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "279" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "278" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "277" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "276" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "275" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "274" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "273" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "272" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "271" & f8_2==102
quietly replace wohngebiet_ausland = 70 if substr(f7a,1,3) == "270" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "599" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "598" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "597" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "596" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "595" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "594" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "593" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "592" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "591" & f8_2==102
quietly replace wohngebiet_ausland = 69 if substr(f7a,1,3) == "590" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "397" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "396" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "395" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "394" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "393" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "392" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "391" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "390" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "389" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "388" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "387" & f8_2==102
quietly replace wohngebiet_ausland = 68 if substr(f7a,1,3) == "386" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "658" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "657" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "656" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "655" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "654" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "653" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "652" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "651" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "650" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "649" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "648" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "647" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "646" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "645" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "644" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "641" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "640" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "639" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "638" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "637" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "636" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "635" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "634" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "633" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "631" & f8_2==102
quietly replace wohngebiet_ausland = 66 if substr(f7a,1,3) == "630" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "567" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "566" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "565" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "564" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "563" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "562" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "561" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "560" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "559" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "558" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "557" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "556" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "554" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "553" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "551" & f8_2==102
quietly replace wohngebiet_ausland = 65 if substr(f7a,1,3) == "550" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "499" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "498" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "497" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "496" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "495" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "494" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "493" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "492" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "491" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "490" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "489" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "488" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "487" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "486" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "485" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "484" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "483" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "482" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "481" & f8_2==102
quietly replace wohngebiet_ausland = 64 if substr(f7a,1,3) == "480" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "049" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "048" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "047" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "046" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "045" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "044" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "043" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "042" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "041" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "040" & f8_2==102
quietly replace wohngebiet_ausland = 62 if substr(f7a,1,3) == "039" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "219" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "218" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "217" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "216" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "215" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "214" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "212" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "211" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "210" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "209" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "208" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "207" & f8_2==102
quietly replace wohngebiet_ausland = 61 if substr(f7a,1,3) == "206" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "027" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "026" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "025" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "024" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "023" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "022" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "021" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "020" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "019" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "018" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "017" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "016" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "015" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "014" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "013" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "012" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "011" & f8_2==102
quietly replace wohngebiet_ausland = 60 if substr(f7a,1,3) == "010" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "714" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "713" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "712" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "711" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "710" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "708" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "707" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "706" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "705" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "704" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "703" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "701" & f8_2==102
quietly replace wohngebiet_ausland = 59 if substr(f7a,1,3) == "700" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "427" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "426" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "425" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "424" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "423" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "422" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "421" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "420" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "418" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "417" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "416" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "415" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "414" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "413" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "412" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "411" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "410" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "409" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "408" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "407" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "406" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "405" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "404" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "403" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "402" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "401" & f8_2==102
quietly replace wohngebiet_ausland = 58 if substr(f7a,1,3) == "400" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "679" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "678" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "677" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "676" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "675" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "674" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "673" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "672" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "671" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "670" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "669" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "668" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "667" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "666" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "665" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "664" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "662" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "661" & f8_2==102
quietly replace wohngebiet_ausland = 57 if substr(f7a,1,3) == "660" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "479" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "478" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "477" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "476" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "475" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "474" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "473" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "472" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "471" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "470" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "469" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "468" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "467" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "466" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "465" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "464" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "463" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "462" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "461" & f8_2==102
quietly replace wohngebiet_ausland = 56 if substr(f7a,1,3) == "460" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "629" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "628" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "627" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "626" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "625" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "624" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "623" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "622" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "620" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "619" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "618" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "617" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "616" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "615" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "614" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "613" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "612" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "611" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "610" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "609" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "606" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "605" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "604" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "603" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "602" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "601" & f8_2==102
quietly replace wohngebiet_ausland = 55 if substr(f7a,1,3) == "600" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "838" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "837" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "836" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "835" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "834" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "833" & f8_2==102
quietly replace wohngebiet_ausland = 54 if substr(f7a,1,3) == "832" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "528" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "527" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "526" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "525" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "524" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "523" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "522" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "521" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "520" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "516" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "515" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "514" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "513" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "512" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "511" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "510" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "509" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "508" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "507" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "506" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "505" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "504" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "503" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "502" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "501" & f8_2==102
quietly replace wohngebiet_ausland = 53 if substr(f7a,1,3) == "500" & f8_2==102
quietly replace wohngebiet_ausland = 52 if substr(f7a,1,3) == "968" & f8_2==102
quietly replace wohngebiet_ausland = 52 if substr(f7a,1,3) == "967" & f8_2==102
quietly replace wohngebiet_ausland = 51 if substr(f7a,1,3) == "969" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "399" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "319" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "318" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "317" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "316" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "315" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "314" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "313" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "312" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "311" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "310" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "309" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "308" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "307" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "306" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "305" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "304" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "303" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "302" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "301" & f8_2==102
quietly replace wohngebiet_ausland = 50 if substr(f7a,1,3) == "300" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "349" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "346" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "342" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "340" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "339" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "338" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "337" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "336" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "335" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "334" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "333" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "332" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "331" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "330" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "329" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "328" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "327" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "326" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "325" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "324" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "323" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "322" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "321" & f8_2==102
quietly replace wohngebiet_ausland = 48 if substr(f7a,1,3) == "320" & f8_2==102
quietly replace wohngebiet_ausland = 47 if substr(f7a,1,3) == "199" & f8_2==102
quietly replace wohngebiet_ausland = 47 if substr(f7a,1,3) == "198" & f8_2==102
quietly replace wohngebiet_ausland = 47 if substr(f7a,1,3) == "197" & f8_2==102
quietly replace wohngebiet_ausland = 46 if substr(f7a,1,3) == "205" & f8_2==102
quietly replace wohngebiet_ausland = 46 if substr(f7a,1,3) == "204" & f8_2==102
quietly replace wohngebiet_ausland = 46 if substr(f7a,1,3) == "203" & f8_2==102
quietly replace wohngebiet_ausland = 46 if substr(f7a,1,3) == "202" & f8_2==102
quietly replace wohngebiet_ausland = 46 if substr(f7a,1,3) == "200" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "069" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "068" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "067" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "066" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "065" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "064" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "063" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "062" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "061" & f8_2==102
quietly replace wohngebiet_ausland = 45 if substr(f7a,1,3) == "060" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "816" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "815" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "814" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "813" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "812" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "811" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "810" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "809" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "808" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "807" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "806" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "805" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "804" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "803" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "802" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "801" & f8_2==102
quietly replace wohngebiet_ausland = 44 if substr(f7a,1,3) == "800" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "966" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "965" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "964" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "963" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "962" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "961" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "960" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "959" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "958" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "957" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "956" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "955" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "954" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "953" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "952" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "951" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "950" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "949" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "948" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "947" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "946" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "945" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "944" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "943" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "942" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "941" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "940" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "939" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "938" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "937" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "936" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "935" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "934" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "933" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "932" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "931" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "930" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "928" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "927" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "926" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "925" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "924" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "923" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "922" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "921" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "920" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "918" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "917" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "916" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "915" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "914" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "913" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "912" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "911" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "910" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "908" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "907" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "906" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "905" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "904" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "903" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "902" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "901" & f8_2==102
quietly replace wohngebiet_ausland = 43 if substr(f7a,1,3) == "900" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "865" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "864" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "863" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "860" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "859" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "857" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "856" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "855" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "853" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "852" & f8_2==102
quietly replace wohngebiet_ausland = 42 if substr(f7a,1,3) == "850" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "729" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "728" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "727" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "726" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "725" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "724" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "723" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "722" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "721" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "720" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "719" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "718" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "717" & f8_2==102
quietly replace wohngebiet_ausland = 40 if substr(f7a,1,3) == "716" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "369" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "368" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "367" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "366" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "365" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "364" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "363" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "362" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "361" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "360" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "359" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "358" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "357" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "356" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "355" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "354" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "352" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "351" & f8_2==102
quietly replace wohngebiet_ausland = 39 if substr(f7a,1,3) == "350" & f8_2==102
quietly replace wohngebiet_ausland = 38 if substr(f7a,1,3) == "996" & f8_2==102
quietly replace wohngebiet_ausland = 38 if substr(f7a,1,3) == "995" & f8_2==102

* PLZ Schweiz
quietly replace f7a=substr(f7a,2,.) if substr(f7a,1,1)=="0" & f8_2==35
quietly replace f7a=substr(f7a,4,.) if substr(f7a,1,1)=="C" & f8_2==35
quietly replace wohngebiet_ausland = 97 if substr(f7a,1,1) == "1" & f8_2==35
quietly replace wohngebiet_ausland = 98 if substr(f7a,1,1) == "2" & f8_2==35
quietly replace wohngebiet_ausland = 99 if substr(f7a,1,1) == "3" & f8_2==35
quietly replace wohngebiet_ausland = 100 if substr(f7a,1,1) == "4" & f8_2==35
quietly replace wohngebiet_ausland = 101 if substr(f7a,1,1) == "5" & f8_2==35
quietly replace wohngebiet_ausland = 102 if substr(f7a,1,1) == "6" & f8_2==35
quietly replace wohngebiet_ausland = 103 if substr(f7a,1,1) == "7" & f8_2==35
quietly replace wohngebiet_ausland = 104 if substr(f7a,1,1) == "8" & f8_2==35
quietly replace wohngebiet_ausland = 105 if substr(f7a,1,2) == "80" & f8_2==35
quietly replace wohngebiet_ausland = 106 if substr(f7a,1,1) == "9" & f8_2==35

* PLZ Niederlande

quietly replace wohngebiet_ausland = 111 if substr(f7a,1,2) == "10" & f8_2==27
quietly replace wohngebiet_ausland = 111 if substr(f7a,1,2) == "11" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "12" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "14" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "16" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "18" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "19" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "20" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "22" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "23" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "25" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "26" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "28" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "29" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "30" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "31" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "32" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "35" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "37" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "38" & f8_2==27
quietly replace wohngebiet_ausland = 107 if substr(f7a,1,2) == "42" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "43" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "46" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "47" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "50" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "54" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "55" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "56" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "60" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "62" & f8_2==27
quietly replace wohngebiet_ausland = 108 if substr(f7a,1,2) == "64" & f8_2==27
quietly replace wohngebiet_ausland = 109 if substr(f7a,1,2) == "66" & f8_2==27
quietly replace wohngebiet_ausland = 109 if substr(f7a,1,2) == "69" & f8_2==27
quietly replace wohngebiet_ausland = 109 if substr(f7a,1,2) == "71" & f8_2==27
quietly replace wohngebiet_ausland = 109 if substr(f7a,1,2) == "73" & f8_2==27
quietly replace wohngebiet_ausland = 110 if substr(f7a,1,2) == "78" & f8_2==27
quietly replace wohngebiet_ausland = 110 if substr(f7a,1,2) == "86" & f8_2==27
quietly replace wohngebiet_ausland = 110 if substr(f7a,1,2) == "89" & f8_2==27
quietly replace wohngebiet_ausland = 110 if substr(f7a,1,2) == "96" & f8_2==27
quietly replace wohngebiet_ausland = 110 if substr(f7a,1,2) == "97" & f8_2==27

* PLZ UK

quietly replace wohngebiet_ausland = 113 if f8_2==13
quietly replace wohngebiet_ausland = 112 if f8_2==13 & (upper(substr(f7a,1,2))=="BR" | upper(substr(f7a,1,2))=="NW" | upper(substr(f7a,1,2))=="RM" | upper(substr(f7a,1,2))=="TW")  
quietly replace wohngebiet_ausland = 114 if f8_2==13 & upper(substr(f7a,1,2)) == "BS"
quietly replace wohngebiet_ausland = 114 if f8_2==13 & upper(substr(f7a,1,2)) == "CF"
quietly replace wohngebiet_ausland = 114 if f8_2==13 & upper(substr(f7a,1,2)) == "LL"
quietly replace wohngebiet_ausland = 114 if f8_2==13 & upper(substr(f7a,1,2)) == "NP"
quietly replace wohngebiet_ausland = 115 if f8_2==13 & upper(substr(f7a,1,2)) == "BT"
quietly replace wohngebiet_ausland = 116 if f8_2==13 & upper(substr(f7a,1,2)) == "AB"
quietly replace wohngebiet_ausland = 116 if f8_2==13 & upper(substr(f7a,1,2)) == "EH"
quietly replace wohngebiet_ausland = 116 if f8_2==13 & upper(substr(f7a,1,2)) == "FK"
quietly replace wohngebiet_ausland = 116 if f8_2==13 & upper(substr(f7a,1,1)) == "G"
quietly replace wohngebiet_ausland = 116 if f8_2==13 & upper(substr(f7a,1,2)) == "ML"

* PLZ Spanien
quietly replace f7a = "0" + f7a if (substr(f7a,1,1)=="7" |substr(f7a,1,1)=="8" )  & f8_2==38
quietly replace f7a = substr(f7a,-5,.) if substr(f7a,1,1)=="e" & f8_2==38
quietly replace wohngebiet_ausland = 117 if substr(f7a,1,2) == "01" & f8_2==38
quietly replace wohngebiet_ausland = 118 if substr(f7a,1,2) == "03" & f8_2==38
quietly replace wohngebiet_ausland = 119 if substr(f7a,1,2) == "05" & f8_2==38
quietly replace wohngebiet_ausland = 120 if substr(f7a,1,2) == "07" & f8_2==38
quietly replace wohngebiet_ausland = 121 if substr(f7a,1,2) == "08" & f8_2==38
quietly replace wohngebiet_ausland = 122 if substr(f7a,1,2) == "11" & f8_2==38
quietly replace wohngebiet_ausland = 123 if substr(f7a,1,2) == "12" & f8_2==38
quietly replace wohngebiet_ausland = 124 if substr(f7a,1,2) == "15" & f8_2==38
quietly replace wohngebiet_ausland = 125 if substr(f7a,1,2) == "17" & f8_2==38
quietly replace wohngebiet_ausland = 126 if substr(f7a,1,2) == "18" & f8_2==38
quietly replace wohngebiet_ausland = 127 if substr(f7a,1,2) == "19" & f8_2==38
quietly replace wohngebiet_ausland = 128 if substr(f7a,1,2) == "28" & f8_2==38
quietly replace wohngebiet_ausland = 129 if substr(f7a,1,2) == "29" & f8_2==38
quietly replace wohngebiet_ausland = 130 if substr(f7a,1,2) == "30" & f8_2==38
quietly replace wohngebiet_ausland = 131 if substr(f7a,1,2) == "31" & f8_2==38
quietly replace wohngebiet_ausland = 132 if substr(f7a,1,2) == "32" & f8_2==38
quietly replace wohngebiet_ausland = 133 if substr(f7a,1,2) == "33" & f8_2==38
quietly replace wohngebiet_ausland = 134 if substr(f7a,1,2) == "35" & f8_2==38
quietly replace wohngebiet_ausland = 135 if substr(f7a,1,2) == "37" & f8_2==38
quietly replace wohngebiet_ausland = 136 if substr(f7a,1,2) == "38" & f8_2==38
quietly replace wohngebiet_ausland = 137 if substr(f7a,1,2) == "40" & f8_2==38
quietly replace wohngebiet_ausland = 138 if substr(f7a,1,2) == "43" & f8_2==38
quietly replace wohngebiet_ausland = 139 if substr(f7a,1,2) == "46" & f8_2==38
quietly replace wohngebiet_ausland = 140 if substr(f7a,1,2) == "47" & f8_2==38
quietly replace wohngebiet_ausland = 141 if substr(f7a,1,2) == "48" & f8_2==38
quietly replace wohngebiet_ausland = 142 if substr(f7a,1,2) == "50" & f8_2==38

* PLZ Italien
quietly replace wohngebiet_ausland = 162 if substr(f7a,1,2) == "00" & f8_2==16
quietly replace wohngebiet_ausland = 156 if substr(f7a,1,2) == "10" & f8_2==16
quietly replace wohngebiet_ausland = 156 if substr(f7a,1,2) == "13" & f8_2==16
quietly replace wohngebiet_ausland = 156 if substr(f7a,1,2) == "15" & f8_2==16
quietly replace wohngebiet_ausland = 152 if substr(f7a,1,2) == "16" & f8_2==16
quietly replace wohngebiet_ausland = 152 if substr(f7a,1,2) == "18" & f8_2==16
quietly replace wohngebiet_ausland = 153 if substr(f7a,1,2) == "20" & f8_2==16
quietly replace wohngebiet_ausland = 153 if substr(f7a,1,2) == "21" & f8_2==16
quietly replace wohngebiet_ausland = 153 if substr(f7a,1,2) == "22" & f8_2==16
quietly replace wohngebiet_ausland = 153 if substr(f7a,1,2) == "25" & f8_2==16
quietly replace wohngebiet_ausland = 153 if substr(f7a,1,2) == "28" & f8_2==16
quietly replace wohngebiet_ausland = 161 if substr(f7a,1,2) == "30" & f8_2==16
quietly replace wohngebiet_ausland = 161 if substr(f7a,1,2) == "31" & f8_2==16
quietly replace wohngebiet_ausland = 161 if substr(f7a,1,2) == "32" & f8_2==16
quietly replace wohngebiet_ausland = 148 if substr(f7a,1,2) == "34" & f8_2==16
quietly replace wohngebiet_ausland = 161 if substr(f7a,1,2) == "36" & f8_2==16
quietly replace wohngebiet_ausland = 161 if substr(f7a,1,2) == "37" & f8_2==16
quietly replace wohngebiet_ausland = 163 if substr(f7a,1,2) == "39" & f8_2==16
quietly replace wohngebiet_ausland = 147 if substr(f7a,1,2) == "40" & f8_2==16
quietly replace wohngebiet_ausland = 147 if substr(f7a,1,2) == "41" & f8_2==16
quietly replace wohngebiet_ausland = 159 if substr(f7a,1,2) == "50" & f8_2==16
quietly replace wohngebiet_ausland = 159 if substr(f7a,1,2) == "52" & f8_2==16
quietly replace wohngebiet_ausland = 154 if substr(f7a,1,2) == "60" & f8_2==16
quietly replace wohngebiet_ausland = 154 if substr(f7a,1,2) == "61" & f8_2==16
quietly replace wohngebiet_ausland = 145 if substr(f7a,1,2) == "70" & f8_2==16
quietly replace wohngebiet_ausland = 145 if substr(f7a,1,2) == "72" & f8_2==16
quietly replace wohngebiet_ausland = 145 if substr(f7a,1,2) == "73" & f8_2==16
quietly replace wohngebiet_ausland = 150 if substr(f7a,1,2) == "80" & f8_2==16
quietly replace wohngebiet_ausland = 146 if substr(f7a,1,2) == "84" & f8_2==16
quietly replace wohngebiet_ausland = 149 if substr(f7a,1,2) == "89" & f8_2==16
quietly replace wohngebiet_ausland = 158 if substr(f7a,1,2) == "93" & f8_2==16
quietly replace wohngebiet_ausland = 158 if substr(f7a,1,2) == "95" & f8_2==16

* PLZ Schweden
quietly replace wohngebiet_ausland = 164 if f8_2==34
quietly replace wohngebiet_ausland = 165 if substr(f7a,1,1) == "1" & f8_2==34

* PLZ Finnland
quietly replace wohngebiet_ausland = 166 if f8_2==9
quietly replace wohngebiet_ausland = 167 if substr(f7a,1,3) == "001" & f8_2==9

* PLZ Norwegen
quietly replace f7a = substr(f7a,-4,.) if substr(f7a,1,1)=="N" & f8_2==28
quietly replace wohngebiet_ausland = 168 if f8_2==28 & substr(f7a,1,2)=="00"
quietly replace wohngebiet_ausland = 169 if f8_2==28 & real(substr(f7a,1,1))<7
quietly replace wohngebiet_ausland = 170 if f8_2==28 & (real(substr(f7a,1,1))==7 | real(substr(f7a,1,1))==8)
quietly replace wohngebiet_ausland = 171 if f8_2==28 & real(substr(f7a,1,1))==9

* PLZ  Russland
quietly replace wohngebiet_ausland = 174 if f8_2==33
quietly replace wohngebiet_ausland = 172 if f8_2==33 & real(substr(f7a,1,1))<2 
quietly replace wohngebiet_ausland = 173 if f8_2==33 & real(substr(f7a,1,2))==19 

* PLZ Belgien
quietly replace f7a = substr(f7a,-4,.) if substr(f7a,1,1)=="0" & f8_2==4
quietly replace wohngebiet_ausland = 175 if substr(f7a,1,4) == "1020" & f8_2==4
quietly replace wohngebiet_ausland = 175 if substr(f7a,1,4) == "1000" & f8_2==4
quietly replace wohngebiet_ausland = 176 if substr(f7a,1,1) == "1" & f8_2==4
quietly replace wohngebiet_ausland = 177 if substr(f7a,1,1) == "2" & f8_2==4
quietly replace wohngebiet_ausland = 178 if substr(f7a,1,1) == "3" & f8_2==4
quietly replace wohngebiet_ausland = 179 if substr(f7a,1,1) == "4" & f8_2==4
quietly replace wohngebiet_ausland = 180 if substr(f7a,1,1) == "5" & f8_2==4
quietly replace wohngebiet_ausland = 181 if substr(f7a,1,1) == "6" & f8_2==4
quietly replace wohngebiet_ausland = 182 if substr(f7a,1,1) == "7" & f8_2==4
quietly replace wohngebiet_ausland = 183 if substr(f7a,1,1) == "8" & f8_2==4
quietly replace wohngebiet_ausland = 184 if substr(f7a,1,1) == "9" & f8_2==4

* PLZ Kanada
quietly replace f7a = subinstr(f7a,"O", "0",1)
quietly replace f7a = subinstr(f7a,"Q", "0",1)
quietly replace wohngebiet_ausland = 185 if upper(substr(f7a,1,1)) == "A" & f8_2==101
quietly replace wohngebiet_ausland = 186 if upper(substr(f7a,1,1)) == "B" & f8_2==101
quietly replace wohngebiet_ausland = 187 if upper(substr(f7a,1,1)) == "C" & f8_2==101
quietly replace wohngebiet_ausland = 188 if upper(substr(f7a,1,1)) == "E" & f8_2==101
quietly replace wohngebiet_ausland = 189 if upper(substr(f7a,1,1)) == "G" & f8_2==101
quietly replace wohngebiet_ausland = 190 if upper(substr(f7a,1,1)) == "H" & f8_2==101
quietly replace wohngebiet_ausland = 191 if upper(substr(f7a,1,1)) == "J" & f8_2==101
quietly replace wohngebiet_ausland = 192 if upper(substr(f7a,1,1)) == "K" & f8_2==101
quietly replace wohngebiet_ausland = 193 if upper(substr(f7a,1,1)) == "L" & f8_2==101
quietly replace wohngebiet_ausland = 194 if upper(substr(f7a,1,1)) == "M" & f8_2==101
quietly replace wohngebiet_ausland = 195 if upper(substr(f7a,1,1)) == "N" & f8_2==101
quietly replace wohngebiet_ausland = 196 if upper(substr(f7a,1,1)) == "P" & f8_2==101
quietly replace wohngebiet_ausland = 197 if upper(substr(f7a,1,1)) == "R" & f8_2==101
quietly replace wohngebiet_ausland = 198 if upper(substr(f7a,1,1)) == "S" & f8_2==101
quietly replace wohngebiet_ausland = 199 if upper(substr(f7a,1,1)) == "T" & f8_2==101
quietly replace wohngebiet_ausland = 200 if upper(substr(f7a,1,1)) == "V" & f8_2==101
quietly replace wohngebiet_ausland = 201 if upper(substr(f7a,1,1)) == "X" & f8_2==101
quietly replace wohngebiet_ausland = 202 if upper(substr(f7a,1,1)) == "Y" & f8_2==101
quietly replace wohngebiet_ausland = 203 if upper(substr(f7a,1,2)) == "K0" & f8_2==101
quietly replace wohngebiet_ausland = 204 if upper(substr(f7a,1,2)) == "T0" & f8_2==101
quietly replace wohngebiet_ausland = 205 if upper(substr(f7a,1,2)) == "V0" & f8_2==101
quietly replace wohngebiet_ausland = 206 if upper(substr(f7a,1,2)) == "A0" & f8_2==101
quietly replace wohngebiet_ausland = 207 if upper(substr(f7a,1,2)) == "P0" & f8_2==101


label var wohngebiet_ausland "Wohnregion des PAX im Ausland"

label define wohngebiet_ausland 1 `"Wien"', modify
label define wohngebiet_ausland 2 `"östl. & südl. Niederösterreich, Nordburgenland"', modify
label define wohngebiet_ausland 3 `"westl. Niederösterreich"', modify
label define wohngebiet_ausland 4 `"Oberösterreich & Teile westl. Niederösterreich"', modify
label define wohngebiet_ausland 5 `"Salzburg & westl. Oberösterreich"', modify
label define wohngebiet_ausland 6 `"Tirol & Vorarlberg"', modify
label define wohngebiet_ausland 7 `"Burgenland"', modify
label define wohngebiet_ausland 8 `"Steiermark, Südburgenland"', modify
label define wohngebiet_ausland 9 `"Kärnten & Osttirol"', modify
label define wohngebiet_ausland 10 `"Kopenhagen, Frederiksberg"', modify
label define wohngebiet_ausland 11 `"Frederiksberg, Kopenhagen (Land)"', modify
label define wohngebiet_ausland 12 `"Nordsjælland"', modify
label define wohngebiet_ausland 13 `"Bornholm"', modify
label define wohngebiet_ausland 14 `"Färöer Inseln"', modify
label define wohngebiet_ausland 15 `"Grönland"', modify
label define wohngebiet_ausland 16 `"übriges Sjælland & umliegende Inseln"', modify
label define wohngebiet_ausland 17 `"Fünen & umliegende Inseln"', modify
label define wohngebiet_ausland 18 `"Südjütland (Nordschleswig)"', modify
label define wohngebiet_ausland 19 `"West-Jütland"', modify
label define wohngebiet_ausland 20 `"Ost-Jütland"', modify
label define wohngebiet_ausland 21 `"Nordjütland"', modify
label define wohngebiet_ausland 22 `"Elsass"', modify
label define wohngebiet_ausland 23 `"Aquitanien"', modify
label define wohngebiet_ausland 24 `"Auvergne "', modify
label define wohngebiet_ausland 25 `"Basse-Normandie "', modify
label define wohngebiet_ausland 26 `"Burgund"', modify
label define wohngebiet_ausland 27 `"Bretagne "', modify
label define wohngebiet_ausland 28 `"Centre "', modify
label define wohngebiet_ausland 29 `"Champagne-Ardenne "', modify
label define wohngebiet_ausland 30 `"Korsika"', modify
label define wohngebiet_ausland 31 `"Freigrafschaft Burgund"', modify
label define wohngebiet_ausland 32 `"Haute-Normandie "', modify
label define wohngebiet_ausland 33 `"Île-de-France "', modify
label define wohngebiet_ausland 34 `"Languedoc-Roussillon "', modify
label define wohngebiet_ausland 35 `"Limousin "', modify
label define wohngebiet_ausland 36 `"Lothringen"', modify
label define wohngebiet_ausland 37 `"Midi-Pyrénées "', modify
label define wohngebiet_ausland 38 `"Nord-Pas-de-Calais "', modify
label define wohngebiet_ausland 39 `"Pays de la Loire "', modify
label define wohngebiet_ausland 40 `"Picardie "', modify
label define wohngebiet_ausland 41 `"Poitou-Charentes "', modify
label define wohngebiet_ausland 42 `"Provence-Alpes-Côte d Azur"', modify
label define wohngebiet_ausland 43 `"Rhône-Alpes "', modify
label define wohngebiet_ausland 44 `"Guadeloupe "', modify
label define wohngebiet_ausland 45 `"Martinique "', modify
label define wohngebiet_ausland 46 `"Französisch-Guayana"', modify
label define wohngebiet_ausland 47 `"Réunion"', modify
label define wohngebiet_ausland 38 `"ALASKA"', modify
label define wohngebiet_ausland 39 `"ALABAMA"', modify
label define wohngebiet_ausland 40 `"ARKANSAS"', modify
label define wohngebiet_ausland 41 `"AMERICAN SAMOA"', modify
label define wohngebiet_ausland 42 `"ARIZONA"', modify
label define wohngebiet_ausland 43 `"CALIFORNIA"', modify
label define wohngebiet_ausland 44 `"COLORADO"', modify
label define wohngebiet_ausland 45 `"CONNECTICUT"', modify
label define wohngebiet_ausland 46 `"DISTRICT OF COLUMBIA"', modify
label define wohngebiet_ausland 47 `"DELAWARE"', modify
label define wohngebiet_ausland 48 `"FLORIDA"', modify
label define wohngebiet_ausland 49 `"FEDERATED STATES OF MICRONESIA"', modify
label define wohngebiet_ausland 50 `"GEORGIA"', modify
label define wohngebiet_ausland 51 `"GUAM"', modify
label define wohngebiet_ausland 52 `"HAWAII"', modify
label define wohngebiet_ausland 53 `"IOWA"', modify
label define wohngebiet_ausland 54 `"IDAHO"', modify
label define wohngebiet_ausland 55 `"ILLINOIS"', modify
label define wohngebiet_ausland 56 `"INDIANA"', modify
label define wohngebiet_ausland 57 `"KANSAS"', modify
label define wohngebiet_ausland 58 `"KENTUCKY"', modify
label define wohngebiet_ausland 59 `"LOUISIANA"', modify
label define wohngebiet_ausland 60 `"MASSACHUSETTS"', modify
label define wohngebiet_ausland 61 `"MARYLAND"', modify
label define wohngebiet_ausland 62 `"MAINE"', modify
label define wohngebiet_ausland 63 `"MARSHALL ISLANDS"', modify
label define wohngebiet_ausland 64 `"MICHIGAN"', modify
label define wohngebiet_ausland 65 `"MINNESOTA"', modify
label define wohngebiet_ausland 66 `"MISSOURI"', modify
label define wohngebiet_ausland 67 `"NORTHERN MARIANA ISLANDS"', modify
label define wohngebiet_ausland 68 `"MISSISSIPPI"', modify
label define wohngebiet_ausland 69 `"MONTANA"', modify
label define wohngebiet_ausland 70 `"NORTH CAROLINA"', modify
label define wohngebiet_ausland 71 `"NORTH DAKOTA"', modify
label define wohngebiet_ausland 72 `"NEBRASKA"', modify
label define wohngebiet_ausland 73 `"NEW HAMPSHIRE"', modify
label define wohngebiet_ausland 74 `"NEW JERSEY"', modify
label define wohngebiet_ausland 75 `"NEW MEXICO"', modify
label define wohngebiet_ausland 76 `"NEVADA"', modify
label define wohngebiet_ausland 77 `"NEW YORK"', modify
label define wohngebiet_ausland 78 `"OHIO"', modify
label define wohngebiet_ausland 79 `"OKLAHOMA"', modify
label define wohngebiet_ausland 80 `"OREGON"', modify
label define wohngebiet_ausland 81 `"PENNSYLVANIA"', modify
label define wohngebiet_ausland 82 `"PUERTO RICO"', modify
label define wohngebiet_ausland 83 `"PALAU"', modify
label define wohngebiet_ausland 84 `"RHODE ISLAND"', modify
label define wohngebiet_ausland 85 `"SOUTH CAROLINA"', modify
label define wohngebiet_ausland 86 `"SOUTH DAKOTA"', modify
label define wohngebiet_ausland 87 `"TENNESSEE"', modify
label define wohngebiet_ausland 88 `"TEXAS"', modify
label define wohngebiet_ausland 89 `"UTAH"', modify
label define wohngebiet_ausland 90 `"VIRGINIA"', modify
label define wohngebiet_ausland 91 `"VIRGIN ISLANDS"', modify
label define wohngebiet_ausland 92 `"VERMONT"', modify
label define wohngebiet_ausland 93 `"WASHINGTON"', modify
label define wohngebiet_ausland 94 `"WISCONSIN"', modify
label define wohngebiet_ausland 95 `"WEST VIRGINIA"', modify
label define wohngebiet_ausland 96 `"WYOMING"', modify
label define wohngebiet_ausland 97 `"Westschweiz (Süd)"', modify
label define wohngebiet_ausland 98 `"Westschweiz (Nord)"', modify
label define wohngebiet_ausland 99 `"Bern/Oberwallis"', modify
label define wohngebiet_ausland 100 `"Basel"', modify
label define wohngebiet_ausland 101 `"Aargau"', modify
label define wohngebiet_ausland 102 `"Zentralschweiz, Tessin"', modify
label define wohngebiet_ausland 103 `"Graubünden"', modify
label define wohngebiet_ausland 104 `"Zürich, Thurgau"', modify
label define wohngebiet_ausland 105 `"Stadt Zürich"', modify
label define wohngebiet_ausland 106 `"Ostschweiz"', modify
label define wohngebiet_ausland 107 `"W: Utrecht, Nord- und Südholland"', modify
label define wohngebiet_ausland 108 `"S: Zeeland, Nord-Brabant und Limburg"', modify
label define wohngebiet_ausland 109 `"O: Flevoland, Gelderland und Overijssel"', modify
label define wohngebiet_ausland 110 `"N: Drenthe, Groningen und  Friesland"', modify
label define wohngebiet_ausland 111 `"Amsterdam"', modify
label define wohngebiet_ausland 112 `"London"', modify
label define wohngebiet_ausland 113 `"England"', modify
label define wohngebiet_ausland 114 `"Wales"', modify
label define wohngebiet_ausland 115 `"Nordirland"', modify
label define wohngebiet_ausland 116 `"Schottland"', modify
label define wohngebiet_ausland 117 `"Álava (Vitoria-Gasteiz)"', modify
label define wohngebiet_ausland 118 `"Alicante"', modify
label define wohngebiet_ausland 119 `"Ávila"', modify
label define wohngebiet_ausland 120 `"Illes Balears (Palma de Mallorca)"', modify
label define wohngebiet_ausland 121 `"Barcelona"', modify
label define wohngebiet_ausland 122 `"Cádiz"', modify
label define wohngebiet_ausland 123 `"Castellón"', modify
label define wohngebiet_ausland 124 `"A Coruña"', modify
label define wohngebiet_ausland 125 `"Girona"', modify
label define wohngebiet_ausland 126 `"Granada"', modify
label define wohngebiet_ausland 127 `"Guadalajara"', modify
label define wohngebiet_ausland 128 `"Madrid"', modify
label define wohngebiet_ausland 129 `"Málaga"', modify
label define wohngebiet_ausland 130 `"Murcia"', modify
label define wohngebiet_ausland 131 `"Navarra (Pamplona)"', modify
label define wohngebiet_ausland 132 `"Ourense"', modify
label define wohngebiet_ausland 133 `"Asturias (Oviedo)"', modify
label define wohngebiet_ausland 134 `"Las Palmas"', modify
label define wohngebiet_ausland 135 `"Salamanca"', modify
label define wohngebiet_ausland 136 `"Santa Cruz de Tenerife"', modify
label define wohngebiet_ausland 137 `"Segovia"', modify
label define wohngebiet_ausland 138 `"Tarragona"', modify
label define wohngebiet_ausland 139 `"València"', modify
label define wohngebiet_ausland 140 `"Valladolid"', modify
label define wohngebiet_ausland 141 `"Bizkaia (Vizcaya, Bilbao)"', modify
label define wohngebiet_ausland 142 `"Zaragoza"', modify
label define wohngebiet_ausland 143 `"Abruzzen"', modify
label define wohngebiet_ausland 144 `"Aostatal"', modify
label define wohngebiet_ausland 145 `"Apulien"', modify
label define wohngebiet_ausland 146 `"Basilicata"', modify
label define wohngebiet_ausland 147 `"Emilia Ramagna"', modify
label define wohngebiet_ausland 148 `"Friaul-Julisch Venetien"', modify
label define wohngebiet_ausland 149 `"Kalabrien"', modify
label define wohngebiet_ausland 150 `"Kampanien"', modify
label define wohngebiet_ausland 151 `"Latium"', modify
label define wohngebiet_ausland 152 `"Ligurien"', modify
label define wohngebiet_ausland 153 `"Lombardei"', modify
label define wohngebiet_ausland 154 `"Marken"', modify
label define wohngebiet_ausland 155 `"Molis"', modify
label define wohngebiet_ausland 156 `"Piemont"', modify
label define wohngebiet_ausland 157 `"Sardinien"', modify
label define wohngebiet_ausland 158 `"Sizilien"', modify
label define wohngebiet_ausland 159 `"Toskana"', modify
label define wohngebiet_ausland 160 `"Umbrien"', modify
label define wohngebiet_ausland 161 `"Venetien"', modify
label define wohngebiet_ausland 162 `"Rom"', modify
label define wohngebiet_ausland 163 `"Trentino-Südtirol"', modify
label define wohngebiet_ausland 164 `"Restschweden"', modify
label define wohngebiet_ausland 165 `"Stockholm"', modify
label define wohngebiet_ausland 166 `"Restfinnland"', modify
label define wohngebiet_ausland 167 `"Helsinki"', modify
label define wohngebiet_ausland 168 `"Oslo"', modify
label define wohngebiet_ausland 169 `"Südnorwegen"', modify
label define wohngebiet_ausland 170 `"Mittelnorwegen"', modify
label define wohngebiet_ausland 171 `"Nordnorwegen"', modify
label define wohngebiet_ausland 172 `"Moskau"', modify
label define wohngebiet_ausland 173 `"Sankt Petersburg"', modify
label define wohngebiet_ausland 174 `"Restrussland"', modify
label define wohngebiet_ausland 175 `"Brüssel"', modify
label define wohngebiet_ausland 176 `"Region Brüssel / Wallonisch-Brabant / Flämisch-Brabant"', modify
label define wohngebiet_ausland 177 `"Antwerpen"', modify
label define wohngebiet_ausland 178 `"Flämisch-Brabant / Limburg"', modify
label define wohngebiet_ausland 179 `"Lüttlich"', modify
label define wohngebiet_ausland 180 `"Narmur"', modify
label define wohngebiet_ausland 181 `"Hennegau/Luxemburg"', modify
label define wohngebiet_ausland 182 `"Hennegau"', modify
label define wohngebiet_ausland 183 `"Westflandern"', modify
label define wohngebiet_ausland 184 `"Ostflandern"', modify
label define wohngebiet_ausland 185 `"Neufundland Ballungsgebiet"', modify
label define wohngebiet_ausland 186 `"Nova Scotia Ballungsgebiet"', modify
label define wohngebiet_ausland 187 `"Prince Edward Island Ballungsgebiet"', modify
label define wohngebiet_ausland 188 `"New Brunswick Ballungsgebiet"', modify
label define wohngebiet_ausland 189 `"Québec-Ost Ballungsgebiet"', modify
label define wohngebiet_ausland 190 `"Montréal und Laval Ballungsgebiet"', modify
label define wohngebiet_ausland 191 `"Québec-West Ballungsgebiet"', modify
label define wohngebiet_ausland 192 `"Ontario-Ost Ballungsgebiet"', modify
label define wohngebiet_ausland 193 `"Ontario-Mitte Ballungsgebiet"', modify
label define wohngebiet_ausland 194 `"Groß-Toronto Ballungsgebiet"', modify
label define wohngebiet_ausland 195 `"Ontario-Südwest Ballungsgebiet"', modify
label define wohngebiet_ausland 196 `"Ontario-Nord Ballungsgebiet"', modify
label define wohngebiet_ausland 197 `"Manitoba Ballungsgebiet"', modify
label define wohngebiet_ausland 198 `"Saskatchewan Ballungsgebiet"', modify
label define wohngebiet_ausland 199 `"Alberta Ballungsgebiet"', modify
label define wohngebiet_ausland 200 `"British Columbia Ballungsgebiet"', modify
label define wohngebiet_ausland 201 `"Nordwest-Territorien, Nunavut Ballungsgebiet"', modify
label define wohngebiet_ausland 202 `"Yukon Ballungsgebiet"', modify
label define wohngebiet_ausland 203 `"Ontario-Ost Land"', modify
label define wohngebiet_ausland 204 `"Alberta Land"', modify
label define wohngebiet_ausland 205 `"British Columbia Land"', modify
label define wohngebiet_ausland 206 `"Neufundland Land"', modify
label define wohngebiet_ausland 207 `"Ontario-Nord Land"', modify

* Umwandlung PLZ-Gebiete in Österreich
replace f3a = substr(f3a, -4,.) if length(f3a)>4 & (f5_2==29 | f5_2==7 | f5_2==27)
gen aufbruchgebiet_ausland = 1 if substr(f3a, 1, 1)=="1" & f5_2==29
quietly replace aufbruchgebiet_ausland = 2 if substr(f3a, 1, 1)=="2" & f5_2==29
quietly replace aufbruchgebiet_ausland = 3 if substr(f3a, 1, 1)=="3" & f5_2==29
quietly replace aufbruchgebiet_ausland = 4 if substr(f3a, 1, 1)=="4" & f5_2==29
quietly replace aufbruchgebiet_ausland = 5 if substr(f3a, 1, 1)=="5" & f5_2==29
quietly replace aufbruchgebiet_ausland = 6 if substr(f3a, 1, 1)=="6" & f5_2==29
quietly replace aufbruchgebiet_ausland = 7 if substr(f3a, 1, 1)=="7" & f5_2==29
quietly replace aufbruchgebiet_ausland = 8 if substr(f3a, 1, 1)=="8" & f5_2==29
quietly replace aufbruchgebiet_ausland = 9 if substr(f3a, 1, 1)=="9" & f5_2==29

* Umwandlung PLZ-Gebiete in Dänemark
quietly replace aufbruchgebiet_ausland = 10 if substr(f3a,1,1) == "1" & f5_2==7
quietly replace aufbruchgebiet_ausland = 11 if substr(f3a,1,1) == "2" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "30" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "31" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "32" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "33" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "34" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "35" & f5_2==7
quietly replace aufbruchgebiet_ausland = 12 if substr(f3a,1,2) == "36" & f5_2==7
quietly replace aufbruchgebiet_ausland = 13 if substr(f3a,1,2) == "37" & f5_2==7
quietly replace aufbruchgebiet_ausland = 14 if substr(f3a,1,2) == "38" & f5_2==7
quietly replace aufbruchgebiet_ausland = 15 if substr(f3a,1,2) == "39" & f5_2==7
quietly replace aufbruchgebiet_ausland = 16 if substr(f3a,1,1) == "4" & f5_2==7
quietly replace aufbruchgebiet_ausland = 17 if substr(f3a,1,1) == "5" & f5_2==7
quietly replace aufbruchgebiet_ausland = 18 if substr(f3a,1,1) == "6" & f5_2==7
quietly replace aufbruchgebiet_ausland = 19 if substr(f3a,1,1) == "7" & f5_2==7
quietly replace aufbruchgebiet_ausland = 20 if substr(f3a,1,1) == "8" & f5_2==7
quietly replace aufbruchgebiet_ausland = 21 if substr(f3a,1,1) == "9" & f5_2==7

* Umwandlung PLZ-Gebiete in Frankreich
replace f3a = substr(f3a, -5,.) if length(f3a)>5 & f5_2==10
quietly replace aufbruchgebiet_ausland = 22 if substr(f3a,1,2) == "67" & f5_2==10
quietly replace aufbruchgebiet_ausland = 22 if substr(f3a,1,2) == "68" & f5_2==10
quietly replace aufbruchgebiet_ausland = 23 if substr(f3a,1,2) == "24" & f5_2==10
quietly replace aufbruchgebiet_ausland = 23 if substr(f3a,1,2) == "33" & f5_2==10
quietly replace aufbruchgebiet_ausland = 23 if substr(f3a,1,2) == "40" & f5_2==10
quietly replace aufbruchgebiet_ausland = 23 if substr(f3a,1,2) == "47" & f5_2==10
quietly replace aufbruchgebiet_ausland = 23 if substr(f3a,1,2) == "64" & f5_2==10
quietly replace aufbruchgebiet_ausland = 24 if substr(f3a,1,2) == "03" & f5_2==10
quietly replace aufbruchgebiet_ausland = 24 if substr(f3a,1,2) == "15" & f5_2==10
quietly replace aufbruchgebiet_ausland = 24 if substr(f3a,1,2) == "43" & f5_2==10
quietly replace aufbruchgebiet_ausland = 24 if substr(f3a,1,2) == "63" & f5_2==10
quietly replace aufbruchgebiet_ausland = 25 if substr(f3a,1,2) == "14" & f5_2==10
quietly replace aufbruchgebiet_ausland = 25 if substr(f3a,1,2) == "50" & f5_2==10
quietly replace aufbruchgebiet_ausland = 25 if substr(f3a,1,2) == "61" & f5_2==10
quietly replace aufbruchgebiet_ausland = 26 if substr(f3a,1,2) == "21" & f5_2==10
quietly replace aufbruchgebiet_ausland = 26 if substr(f3a,1,2) == "58" & f5_2==10
quietly replace aufbruchgebiet_ausland = 26 if substr(f3a,1,2) == "71" & f5_2==10
quietly replace aufbruchgebiet_ausland = 26 if substr(f3a,1,2) == "89" & f5_2==10
quietly replace aufbruchgebiet_ausland = 27 if substr(f3a,1,2) == "22" & f5_2==10
quietly replace aufbruchgebiet_ausland = 27 if substr(f3a,1,2) == "29" & f5_2==10
quietly replace aufbruchgebiet_ausland = 27 if substr(f3a,1,2) == "35" & f5_2==10
quietly replace aufbruchgebiet_ausland = 27 if substr(f3a,1,2) == "56" & f5_2==10
quietly replace aufbruchgebiet_ausland = 28 if substr(f3a,1,2) == "18" & f5_2==10
quietly replace aufbruchgebiet_ausland = 28 if substr(f3a,1,2) == "28" & f5_2==10
quietly replace aufbruchgebiet_ausland = 28 if substr(f3a,1,2) == "36" & f5_2==10
quietly replace aufbruchgebiet_ausland = 28 if substr(f3a,1,2) == "37" & f5_2==10
quietly replace aufbruchgebiet_ausland = 28 if substr(f3a,1,2) == "41" & f5_2==10
quietly replace aufbruchgebiet_ausland = 28 if substr(f3a,1,2) == "45" & f5_2==10
quietly replace aufbruchgebiet_ausland = 29 if substr(f3a,1,2) == "08" & f5_2==10
quietly replace aufbruchgebiet_ausland = 29 if substr(f3a,1,2) == "10" & f5_2==10
quietly replace aufbruchgebiet_ausland = 29 if substr(f3a,1,2) == "51" & f5_2==10
quietly replace aufbruchgebiet_ausland = 29 if substr(f3a,1,2) == "52" & f5_2==10
quietly replace aufbruchgebiet_ausland = 30 if substr(f3a,1,2) == "20" & f5_2==10
quietly replace aufbruchgebiet_ausland = 30 if substr(f3a,1,2) == "20" & f5_2==10
quietly replace aufbruchgebiet_ausland = 31 if substr(f3a,1,2) == "25" & f5_2==10
quietly replace aufbruchgebiet_ausland = 31 if substr(f3a,1,2) == "39" & f5_2==10
quietly replace aufbruchgebiet_ausland = 31 if substr(f3a,1,2) == "70" & f5_2==10
quietly replace aufbruchgebiet_ausland = 31 if substr(f3a,1,2) == "90" & f5_2==10
quietly replace aufbruchgebiet_ausland = 32 if substr(f3a,1,2) == "27" & f5_2==10
quietly replace aufbruchgebiet_ausland = 32 if substr(f3a,1,2) == "76" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "75" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "77" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "78" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "91" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "92" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "93" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "94" & f5_2==10
quietly replace aufbruchgebiet_ausland = 33 if substr(f3a,1,2) == "95" & f5_2==10
quietly replace aufbruchgebiet_ausland = 34 if substr(f3a,1,2) == "11" & f5_2==10
quietly replace aufbruchgebiet_ausland = 34 if substr(f3a,1,2) == "30" & f5_2==10
quietly replace aufbruchgebiet_ausland = 34 if substr(f3a,1,2) == "34" & f5_2==10
quietly replace aufbruchgebiet_ausland = 34 if substr(f3a,1,2) == "48" & f5_2==10
quietly replace aufbruchgebiet_ausland = 34 if substr(f3a,1,2) == "66" & f5_2==10
quietly replace aufbruchgebiet_ausland = 35 if substr(f3a,1,2) == "19" & f5_2==10
quietly replace aufbruchgebiet_ausland = 35 if substr(f3a,1,2) == "23" & f5_2==10
quietly replace aufbruchgebiet_ausland = 35 if substr(f3a,1,2) == "87" & f5_2==10
quietly replace aufbruchgebiet_ausland = 36 if substr(f3a,1,2) == "54" & f5_2==10
quietly replace aufbruchgebiet_ausland = 36 if substr(f3a,1,2) == "55" & f5_2==10
quietly replace aufbruchgebiet_ausland = 36 if substr(f3a,1,2) == "57" & f5_2==10
quietly replace aufbruchgebiet_ausland = 36 if substr(f3a,1,2) == "88" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "09" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "12" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "31" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "32" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "46" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "65" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "81" & f5_2==10
quietly replace aufbruchgebiet_ausland = 37 if substr(f3a,1,2) == "82" & f5_2==10
quietly replace aufbruchgebiet_ausland = 21 if substr(f3a,1,2) == "04" & f5_2==10
quietly replace aufbruchgebiet_ausland = 21 if substr(f3a,1,2) == "06" & f5_2==10
quietly replace aufbruchgebiet_ausland = 22 if substr(f3a,1,2) == "07" & f5_2==10
quietly replace aufbruchgebiet_ausland = 21 if substr(f3a,1,2) == "13" & f5_2==10
quietly replace aufbruchgebiet_ausland = 20 if substr(f3a,1,2) == "16" & f5_2==10
quietly replace aufbruchgebiet_ausland = 20 if substr(f3a,1,2) == "17" & f5_2==10
quietly replace aufbruchgebiet_ausland = 22 if substr(f3a,1,2) == "38" & f5_2==10
quietly replace aufbruchgebiet_ausland = 18 if substr(f3a,1,2) == "44" & f5_2==10
quietly replace aufbruchgebiet_ausland = 17 if substr(f3a,1,2) == "59" & f5_2==10
quietly replace aufbruchgebiet_ausland = 19 if substr(f3a,1,2) == "60" & f5_2==10
quietly replace aufbruchgebiet_ausland = 22 if substr(f3a,1,2) == "69" & f5_2==10
quietly replace aufbruchgebiet_ausland = 22 if substr(f3a,1,2) == "74" & f5_2==10
quietly replace aufbruchgebiet_ausland = 20 if substr(f3a,1,2) == "79" & f5_2==10
quietly replace aufbruchgebiet_ausland = 21 if substr(f3a,1,2) == "83" & f5_2==10


* Umwandlung PLZ-Gebiete in USA
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "831" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "830" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "829" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "828" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "827" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "826" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "825" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "824" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "823" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "822" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "821" & f5_2==102
quietly replace aufbruchgebiet_ausland = 96 if substr(f3a,1,3) == "820" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "268" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "267" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "266" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "265" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "264" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "263" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "262" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "261" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "260" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "259" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "258" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "257" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "256" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "255" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "254" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "253" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "252" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "251" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "250" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "249" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "248" & f5_2==102
quietly replace aufbruchgebiet_ausland = 95 if substr(f3a,1,3) == "247" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "549" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "548" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "547" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "546" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "545" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "544" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "543" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "542" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "541" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "540" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "539" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "538" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "537" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "535" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "534" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "532" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "531" & f5_2==102
quietly replace aufbruchgebiet_ausland = 94 if substr(f3a,1,3) == "530" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "994" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "993" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "992" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "991" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "990" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "989" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "988" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "987" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "986" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "985" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "984" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "983" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "982" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "981" & f5_2==102
quietly replace aufbruchgebiet_ausland = 93 if substr(f3a,1,3) == "980" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "059" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "058" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "057" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "056" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "055" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "054" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "053" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "052" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "051" & f5_2==102
quietly replace aufbruchgebiet_ausland = 92 if substr(f3a,1,3) == "050" & f5_2==102
quietly replace aufbruchgebiet_ausland = 91 if substr(f3a,1,3) == "008" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "246" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "245" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "244" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "243" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "242" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "241" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "240" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "239" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "238" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "237" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "236" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "235" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "234" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "233" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "232" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "231" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "230" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "229" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "228" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "227" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "226" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "225" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "224" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "223" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "222" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "221" & f5_2==102
quietly replace aufbruchgebiet_ausland = 90 if substr(f3a,1,3) == "220" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "847" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "846" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "845" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "844" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "843" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "842" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "841" & f5_2==102
quietly replace aufbruchgebiet_ausland = 89 if substr(f3a,1,3) == "840" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "885" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "799" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "798" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "797" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "796" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "795" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "794" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "793" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "792" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "791" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "790" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "789" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "788" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "787" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "786" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "785" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "784" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "783" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "782" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "781" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "780" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "779" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "778" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "777" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "776" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "775" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "774" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "773" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "772" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "770" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "769" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "768" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "767" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "766" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "765" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "764" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "763" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "762" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "761" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "760" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "759" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "758" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "757" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "756" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "755" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "754" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "753" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "752" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "751" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "750" & f5_2==102
quietly replace aufbruchgebiet_ausland = 88 if substr(f3a,1,3) == "733" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "385" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "384" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "383" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "382" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "381" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "380" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "379" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "378" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "377" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "376" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "375" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "374" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "373" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "372" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "371" & f5_2==102
quietly replace aufbruchgebiet_ausland = 87 if substr(f3a,1,3) == "370" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "577" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "576" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "575" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "574" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "573" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "572" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "571" & f5_2==102
quietly replace aufbruchgebiet_ausland = 86 if substr(f3a,1,3) == "570" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "299" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "298" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "297" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "296" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "295" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "294" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "293" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "292" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "291" & f5_2==102
quietly replace aufbruchgebiet_ausland = 85 if substr(f3a,1,3) == "290" & f5_2==102
quietly replace aufbruchgebiet_ausland = 84 if substr(f3a,1,3) == "029" & f5_2==102
quietly replace aufbruchgebiet_ausland = 84 if substr(f3a,1,3) == "028" & f5_2==102
quietly replace aufbruchgebiet_ausland = 82 if substr(f3a,1,3) == "009" & f5_2==102
quietly replace aufbruchgebiet_ausland = 82 if substr(f3a,1,3) == "007" & f5_2==102
quietly replace aufbruchgebiet_ausland = 82 if substr(f3a,1,3) == "006" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "196" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "195" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "194" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "193" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "192" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "191" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "190" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "189" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "188" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "187" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "186" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "185" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "184" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "183" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "182" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "181" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "180" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "179" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "178" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "177" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "176" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "175" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "174" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "173" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "172" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "171" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "170" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "169" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "168" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "167" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "166" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "165" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "164" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "163" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "162" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "161" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "160" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "159" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "158" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "157" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "156" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "155" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "154" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "153" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "152" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "151" & f5_2==102
quietly replace aufbruchgebiet_ausland = 81 if substr(f3a,1,3) == "150" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "979" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "978" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "977" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "976" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "975" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "974" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "973" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "972" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "971" & f5_2==102
quietly replace aufbruchgebiet_ausland = 80 if substr(f3a,1,3) == "970" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "749" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "748" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "747" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "746" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "745" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "744" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "743" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "741" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "740" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "739" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "738" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "737" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "736" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "735" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "734" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "731" & f5_2==102
quietly replace aufbruchgebiet_ausland = 79 if substr(f3a,1,3) == "730" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "459" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "458" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "457" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "456" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "455" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "454" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "453" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "452" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "451" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "450" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "449" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "448" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "447" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "446" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "445" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "444" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "443" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "442" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "441" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "440" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "439" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "438" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "437" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "436" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "435" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "434" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "433" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "432" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "431" & f5_2==102
quietly replace aufbruchgebiet_ausland = 78 if substr(f3a,1,3) == "430" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "149" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "148" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "147" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "146" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "145" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "144" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "143" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "142" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "141" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "140" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "139" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "138" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "137" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "136" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "135" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "134" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "133" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "132" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "131" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "130" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "129" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "128" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "127" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "126" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "125" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "124" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "123" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "122" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "121" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "120" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "119" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "118" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "117" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "116" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "115" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "114" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "113" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "112" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "111" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "110" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "109" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "108" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "107" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "106" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "105" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "104" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "103" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "102" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "101" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "100" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "098" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "097" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "096" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "095" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "094" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "093" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "093" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "093" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "093" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "093" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "092" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "092" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "092" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "091" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "090" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "005" & f5_2==102
quietly replace aufbruchgebiet_ausland = 77 if substr(f3a,1,3) == "004" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "898" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "897" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "895" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "894" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "893" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "891" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "890" & f5_2==102
quietly replace aufbruchgebiet_ausland = 76 if substr(f3a,1,3) == "889" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "884" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "883" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "882" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "881" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "880" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "879" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "878" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "877" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "875" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "874" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "873" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "872" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "871" & f5_2==102
quietly replace aufbruchgebiet_ausland = 75 if substr(f3a,1,3) == "870" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "089" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "088" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "087" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "086" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "085" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "084" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "083" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "082" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "081" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "080" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "079" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "078" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "077" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "076" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "075" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "074" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "073" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "072" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "071" & f5_2==102
quietly replace aufbruchgebiet_ausland = 74 if substr(f3a,1,3) == "070" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "038" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "037" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "036" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "035" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "034" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "033" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "032" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "031" & f5_2==102
quietly replace aufbruchgebiet_ausland = 73 if substr(f3a,1,3) == "030" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "693" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "692" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "691" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "690" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "689" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "688" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "687" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "686" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "685" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "684" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "683" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "681" & f5_2==102
quietly replace aufbruchgebiet_ausland = 72 if substr(f3a,1,3) == "680" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "588" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "587" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "586" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "585" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "584" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "583" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "582" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "581" & f5_2==102
quietly replace aufbruchgebiet_ausland = 71 if substr(f3a,1,3) == "580" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "289" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "288" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "287" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "286" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "285" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "284" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "283" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "282" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "281" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "280" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "279" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "278" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "277" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "276" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "275" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "274" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "273" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "272" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "271" & f5_2==102
quietly replace aufbruchgebiet_ausland = 70 if substr(f3a,1,3) == "270" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "599" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "598" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "597" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "596" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "595" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "594" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "593" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "592" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "591" & f5_2==102
quietly replace aufbruchgebiet_ausland = 69 if substr(f3a,1,3) == "590" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "397" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "396" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "395" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "394" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "393" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "392" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "391" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "390" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "389" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "388" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "387" & f5_2==102
quietly replace aufbruchgebiet_ausland = 68 if substr(f3a,1,3) == "386" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "658" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "657" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "656" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "655" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "654" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "653" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "652" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "651" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "650" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "649" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "648" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "647" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "646" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "645" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "644" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "641" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "640" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "639" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "638" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "637" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "636" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "635" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "634" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "633" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "631" & f5_2==102
quietly replace aufbruchgebiet_ausland = 66 if substr(f3a,1,3) == "630" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "567" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "566" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "565" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "564" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "563" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "562" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "561" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "560" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "559" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "558" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "557" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "556" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "554" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "553" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "551" & f5_2==102
quietly replace aufbruchgebiet_ausland = 65 if substr(f3a,1,3) == "550" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "499" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "498" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "497" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "496" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "495" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "494" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "493" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "492" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "491" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "490" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "489" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "488" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "487" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "486" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "485" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "484" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "483" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "482" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "481" & f5_2==102
quietly replace aufbruchgebiet_ausland = 64 if substr(f3a,1,3) == "480" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "049" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "048" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "047" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "046" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "045" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "044" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "043" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "042" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "041" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "040" & f5_2==102
quietly replace aufbruchgebiet_ausland = 62 if substr(f3a,1,3) == "039" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "219" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "218" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "217" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "216" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "215" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "214" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "212" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "211" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "210" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "209" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "208" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "207" & f5_2==102
quietly replace aufbruchgebiet_ausland = 61 if substr(f3a,1,3) == "206" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "027" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "026" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "025" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "024" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "023" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "022" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "021" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "020" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "019" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "018" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "017" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "016" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "015" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "014" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "013" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "012" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "011" & f5_2==102
quietly replace aufbruchgebiet_ausland = 60 if substr(f3a,1,3) == "010" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "714" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "713" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "712" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "711" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "710" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "708" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "707" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "706" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "705" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "704" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "703" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "701" & f5_2==102
quietly replace aufbruchgebiet_ausland = 59 if substr(f3a,1,3) == "700" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "427" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "426" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "425" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "424" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "423" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "422" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "421" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "420" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "418" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "417" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "416" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "415" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "414" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "413" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "412" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "411" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "410" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "409" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "408" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "407" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "406" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "405" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "404" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "403" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "402" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "401" & f5_2==102
quietly replace aufbruchgebiet_ausland = 58 if substr(f3a,1,3) == "400" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "679" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "678" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "677" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "676" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "675" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "674" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "673" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "672" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "671" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "670" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "669" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "668" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "667" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "666" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "665" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "664" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "662" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "661" & f5_2==102
quietly replace aufbruchgebiet_ausland = 57 if substr(f3a,1,3) == "660" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "479" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "478" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "477" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "476" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "475" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "474" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "473" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "472" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "471" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "470" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "469" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "468" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "467" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "466" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "465" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "464" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "463" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "462" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "461" & f5_2==102
quietly replace aufbruchgebiet_ausland = 56 if substr(f3a,1,3) == "460" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "629" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "628" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "627" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "626" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "625" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "624" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "623" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "622" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "620" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "619" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "618" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "617" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "616" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "615" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "614" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "613" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "612" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "611" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "610" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "609" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "606" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "605" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "604" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "603" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "602" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "601" & f5_2==102
quietly replace aufbruchgebiet_ausland = 55 if substr(f3a,1,3) == "600" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "838" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "837" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "836" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "835" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "834" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "833" & f5_2==102
quietly replace aufbruchgebiet_ausland = 54 if substr(f3a,1,3) == "832" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "528" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "527" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "526" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "525" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "524" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "523" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "522" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "521" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "520" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "516" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "515" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "514" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "513" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "512" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "511" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "510" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "509" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "508" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "507" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "506" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "505" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "504" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "503" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "502" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "501" & f5_2==102
quietly replace aufbruchgebiet_ausland = 53 if substr(f3a,1,3) == "500" & f5_2==102
quietly replace aufbruchgebiet_ausland = 52 if substr(f3a,1,3) == "968" & f5_2==102
quietly replace aufbruchgebiet_ausland = 52 if substr(f3a,1,3) == "967" & f5_2==102
quietly replace aufbruchgebiet_ausland = 51 if substr(f3a,1,3) == "969" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "399" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "319" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "318" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "317" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "316" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "315" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "314" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "313" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "312" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "311" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "310" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "309" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "308" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "307" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "306" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "305" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "304" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "303" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "302" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "301" & f5_2==102
quietly replace aufbruchgebiet_ausland = 50 if substr(f3a,1,3) == "300" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "349" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "346" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "342" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "340" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "339" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "338" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "337" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "336" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "335" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "334" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "333" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "332" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "331" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "330" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "329" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "328" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "327" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "326" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "325" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "324" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "323" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "322" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "321" & f5_2==102
quietly replace aufbruchgebiet_ausland = 48 if substr(f3a,1,3) == "320" & f5_2==102
quietly replace aufbruchgebiet_ausland = 47 if substr(f3a,1,3) == "199" & f5_2==102
quietly replace aufbruchgebiet_ausland = 47 if substr(f3a,1,3) == "198" & f5_2==102
quietly replace aufbruchgebiet_ausland = 47 if substr(f3a,1,3) == "197" & f5_2==102
quietly replace aufbruchgebiet_ausland = 46 if substr(f3a,1,3) == "205" & f5_2==102
quietly replace aufbruchgebiet_ausland = 46 if substr(f3a,1,3) == "204" & f5_2==102
quietly replace aufbruchgebiet_ausland = 46 if substr(f3a,1,3) == "203" & f5_2==102
quietly replace aufbruchgebiet_ausland = 46 if substr(f3a,1,3) == "202" & f5_2==102
quietly replace aufbruchgebiet_ausland = 46 if substr(f3a,1,3) == "200" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "069" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "068" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "067" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "066" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "065" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "064" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "063" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "062" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "061" & f5_2==102
quietly replace aufbruchgebiet_ausland = 45 if substr(f3a,1,3) == "060" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "816" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "815" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "814" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "813" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "812" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "811" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "810" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "809" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "808" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "807" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "806" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "805" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "804" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "803" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "802" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "801" & f5_2==102
quietly replace aufbruchgebiet_ausland = 44 if substr(f3a,1,3) == "800" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "966" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "965" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "964" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "963" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "962" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "961" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "960" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "959" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "958" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "957" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "956" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "955" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "954" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "953" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "952" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "951" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "950" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "949" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "948" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "947" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "946" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "945" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "944" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "943" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "942" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "941" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "940" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "939" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "938" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "937" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "936" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "935" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "934" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "933" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "932" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "931" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "930" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "928" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "927" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "926" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "925" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "924" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "923" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "922" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "921" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "920" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "918" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "917" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "916" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "915" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "914" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "913" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "912" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "911" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "910" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "908" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "907" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "906" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "905" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "904" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "903" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "902" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "901" & f5_2==102
quietly replace aufbruchgebiet_ausland = 43 if substr(f3a,1,3) == "900" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "865" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "864" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "863" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "860" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "859" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "857" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "856" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "855" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "853" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "852" & f5_2==102
quietly replace aufbruchgebiet_ausland = 42 if substr(f3a,1,3) == "850" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "729" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "728" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "727" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "726" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "725" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "724" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "723" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "722" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "721" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "720" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "719" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "718" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "717" & f5_2==102
quietly replace aufbruchgebiet_ausland = 40 if substr(f3a,1,3) == "716" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "369" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "368" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "367" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "366" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "365" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "364" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "363" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "362" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "361" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "360" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "359" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "358" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "357" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "356" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "355" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "354" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "352" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "351" & f5_2==102
quietly replace aufbruchgebiet_ausland = 39 if substr(f3a,1,3) == "350" & f5_2==102
quietly replace aufbruchgebiet_ausland = 38 if substr(f3a,1,3) == "996" & f5_2==102
quietly replace aufbruchgebiet_ausland = 38 if substr(f3a,1,3) == "995" & f5_2==102

* PLZ Schweiz
quietly replace f3a=substr(f3a,2,.) if substr(f3a,1,1)=="0" & f5_2==35
quietly replace f3a=substr(f3a,4,.) if substr(f3a,1,1)=="C" & f5_2==35
quietly replace aufbruchgebiet_ausland = 97 if substr(f3a,1,1) == "1" & f5_2==35
quietly replace aufbruchgebiet_ausland = 98 if substr(f3a,1,1) == "2" & f5_2==35
quietly replace aufbruchgebiet_ausland = 99 if substr(f3a,1,1) == "3" & f5_2==35
quietly replace aufbruchgebiet_ausland = 100 if substr(f3a,1,1) == "4" & f5_2==35
quietly replace aufbruchgebiet_ausland = 101 if substr(f3a,1,1) == "5" & f5_2==35
quietly replace aufbruchgebiet_ausland = 102 if substr(f3a,1,1) == "6" & f5_2==35
quietly replace aufbruchgebiet_ausland = 103 if substr(f3a,1,1) == "7" & f5_2==35
quietly replace aufbruchgebiet_ausland = 104 if substr(f3a,1,1) == "8" & f5_2==35
quietly replace aufbruchgebiet_ausland = 105 if substr(f3a,1,2) == "80" & f5_2==35
quietly replace aufbruchgebiet_ausland = 106 if substr(f3a,1,1) == "9" & f5_2==35

* PLZ Niederlande

quietly replace aufbruchgebiet_ausland = 111 if substr(f3a,1,2) == "10" & f5_2==27
quietly replace aufbruchgebiet_ausland = 111 if substr(f3a,1,2) == "11" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "12" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "14" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "16" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "18" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "19" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "20" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "22" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "23" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "25" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "26" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "28" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "29" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "30" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "31" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "32" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "35" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "37" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "38" & f5_2==27
quietly replace aufbruchgebiet_ausland = 107 if substr(f3a,1,2) == "42" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "43" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "46" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "47" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "50" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "54" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "55" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "56" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "60" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "62" & f5_2==27
quietly replace aufbruchgebiet_ausland = 108 if substr(f3a,1,2) == "64" & f5_2==27
quietly replace aufbruchgebiet_ausland = 109 if substr(f3a,1,2) == "66" & f5_2==27
quietly replace aufbruchgebiet_ausland = 109 if substr(f3a,1,2) == "69" & f5_2==27
quietly replace aufbruchgebiet_ausland = 109 if substr(f3a,1,2) == "71" & f5_2==27
quietly replace aufbruchgebiet_ausland = 109 if substr(f3a,1,2) == "73" & f5_2==27
quietly replace aufbruchgebiet_ausland = 110 if substr(f3a,1,2) == "78" & f5_2==27
quietly replace aufbruchgebiet_ausland = 110 if substr(f3a,1,2) == "86" & f5_2==27
quietly replace aufbruchgebiet_ausland = 110 if substr(f3a,1,2) == "89" & f5_2==27
quietly replace aufbruchgebiet_ausland = 110 if substr(f3a,1,2) == "96" & f5_2==27
quietly replace aufbruchgebiet_ausland = 110 if substr(f3a,1,2) == "97" & f5_2==27

* PLZ UK

quietly replace aufbruchgebiet_ausland = 113 if f5_2==13
quietly replace aufbruchgebiet_ausland = 112 if f5_2==13 & (upper(substr(f3a,1,2))=="BR" | upper(substr(f3a,1,2))=="NW" | upper(substr(f3a,1,2))=="RM" | upper(substr(f3a,1,2))=="TW")  
quietly replace aufbruchgebiet_ausland = 114 if f5_2==13 & upper(substr(f3a,1,2)) == "BS"
quietly replace aufbruchgebiet_ausland = 114 if f5_2==13 & upper(substr(f3a,1,2)) == "CF"
quietly replace aufbruchgebiet_ausland = 114 if f5_2==13 & upper(substr(f3a,1,2)) == "LL"
quietly replace aufbruchgebiet_ausland = 114 if f5_2==13 & upper(substr(f3a,1,2)) == "NP"
quietly replace aufbruchgebiet_ausland = 115 if f5_2==13 & upper(substr(f3a,1,2)) == "BT"
quietly replace aufbruchgebiet_ausland = 116 if f5_2==13 & upper(substr(f3a,1,2)) == "AB"
quietly replace aufbruchgebiet_ausland = 116 if f5_2==13 & upper(substr(f3a,1,2)) == "EH"
quietly replace aufbruchgebiet_ausland = 116 if f5_2==13 & upper(substr(f3a,1,2)) == "FK"
quietly replace aufbruchgebiet_ausland = 116 if f5_2==13 & upper(substr(f3a,1,1)) == "G"
quietly replace aufbruchgebiet_ausland = 116 if f5_2==13 & upper(substr(f3a,1,2)) == "ML"

* PLZ Spanien
quietly replace f3a = "0" + f3a if (substr(f3a,1,1)=="7" |substr(f3a,1,1)=="8" )  & f5_2==38
quietly replace f3a = substr(f3a,-5,.) if substr(f3a,1,1)=="e" & f5_2==38
quietly replace aufbruchgebiet_ausland = 117 if substr(f3a,1,2) == "01" & f5_2==38
quietly replace aufbruchgebiet_ausland = 118 if substr(f3a,1,2) == "03" & f5_2==38
quietly replace aufbruchgebiet_ausland = 119 if substr(f3a,1,2) == "05" & f5_2==38
quietly replace aufbruchgebiet_ausland = 120 if substr(f3a,1,2) == "07" & f5_2==38
quietly replace aufbruchgebiet_ausland = 121 if substr(f3a,1,2) == "08" & f5_2==38
quietly replace aufbruchgebiet_ausland = 122 if substr(f3a,1,2) == "11" & f5_2==38
quietly replace aufbruchgebiet_ausland = 123 if substr(f3a,1,2) == "12" & f5_2==38
quietly replace aufbruchgebiet_ausland = 124 if substr(f3a,1,2) == "15" & f5_2==38
quietly replace aufbruchgebiet_ausland = 125 if substr(f3a,1,2) == "17" & f5_2==38
quietly replace aufbruchgebiet_ausland = 126 if substr(f3a,1,2) == "18" & f5_2==38
quietly replace aufbruchgebiet_ausland = 127 if substr(f3a,1,2) == "19" & f5_2==38
quietly replace aufbruchgebiet_ausland = 128 if substr(f3a,1,2) == "28" & f5_2==38
quietly replace aufbruchgebiet_ausland = 129 if substr(f3a,1,2) == "29" & f5_2==38
quietly replace aufbruchgebiet_ausland = 130 if substr(f3a,1,2) == "30" & f5_2==38
quietly replace aufbruchgebiet_ausland = 131 if substr(f3a,1,2) == "31" & f5_2==38
quietly replace aufbruchgebiet_ausland = 132 if substr(f3a,1,2) == "32" & f5_2==38
quietly replace aufbruchgebiet_ausland = 133 if substr(f3a,1,2) == "33" & f5_2==38
quietly replace aufbruchgebiet_ausland = 134 if substr(f3a,1,2) == "35" & f5_2==38
quietly replace aufbruchgebiet_ausland = 135 if substr(f3a,1,2) == "37" & f5_2==38
quietly replace aufbruchgebiet_ausland = 136 if substr(f3a,1,2) == "38" & f5_2==38
quietly replace aufbruchgebiet_ausland = 137 if substr(f3a,1,2) == "40" & f5_2==38
quietly replace aufbruchgebiet_ausland = 138 if substr(f3a,1,2) == "43" & f5_2==38
quietly replace aufbruchgebiet_ausland = 139 if substr(f3a,1,2) == "46" & f5_2==38
quietly replace aufbruchgebiet_ausland = 140 if substr(f3a,1,2) == "47" & f5_2==38
quietly replace aufbruchgebiet_ausland = 141 if substr(f3a,1,2) == "48" & f5_2==38
quietly replace aufbruchgebiet_ausland = 142 if substr(f3a,1,2) == "50" & f5_2==38

* PLZ Italien
quietly replace aufbruchgebiet_ausland = 162 if substr(f3a,1,2) == "00" & f5_2==16
quietly replace aufbruchgebiet_ausland = 156 if substr(f3a,1,2) == "10" & f5_2==16
quietly replace aufbruchgebiet_ausland = 156 if substr(f3a,1,2) == "13" & f5_2==16
quietly replace aufbruchgebiet_ausland = 156 if substr(f3a,1,2) == "15" & f5_2==16
quietly replace aufbruchgebiet_ausland = 152 if substr(f3a,1,2) == "16" & f5_2==16
quietly replace aufbruchgebiet_ausland = 152 if substr(f3a,1,2) == "18" & f5_2==16
quietly replace aufbruchgebiet_ausland = 153 if substr(f3a,1,2) == "20" & f5_2==16
quietly replace aufbruchgebiet_ausland = 153 if substr(f3a,1,2) == "21" & f5_2==16
quietly replace aufbruchgebiet_ausland = 153 if substr(f3a,1,2) == "22" & f5_2==16
quietly replace aufbruchgebiet_ausland = 153 if substr(f3a,1,2) == "25" & f5_2==16
quietly replace aufbruchgebiet_ausland = 153 if substr(f3a,1,2) == "28" & f5_2==16
quietly replace aufbruchgebiet_ausland = 161 if substr(f3a,1,2) == "30" & f5_2==16
quietly replace aufbruchgebiet_ausland = 161 if substr(f3a,1,2) == "31" & f5_2==16
quietly replace aufbruchgebiet_ausland = 161 if substr(f3a,1,2) == "32" & f5_2==16
quietly replace aufbruchgebiet_ausland = 148 if substr(f3a,1,2) == "34" & f5_2==16
quietly replace aufbruchgebiet_ausland = 161 if substr(f3a,1,2) == "36" & f5_2==16
quietly replace aufbruchgebiet_ausland = 161 if substr(f3a,1,2) == "37" & f5_2==16
quietly replace aufbruchgebiet_ausland = 163 if substr(f3a,1,2) == "39" & f5_2==16
quietly replace aufbruchgebiet_ausland = 147 if substr(f3a,1,2) == "40" & f5_2==16
quietly replace aufbruchgebiet_ausland = 147 if substr(f3a,1,2) == "41" & f5_2==16
quietly replace aufbruchgebiet_ausland = 159 if substr(f3a,1,2) == "50" & f5_2==16
quietly replace aufbruchgebiet_ausland = 159 if substr(f3a,1,2) == "52" & f5_2==16
quietly replace aufbruchgebiet_ausland = 154 if substr(f3a,1,2) == "60" & f5_2==16
quietly replace aufbruchgebiet_ausland = 154 if substr(f3a,1,2) == "61" & f5_2==16
quietly replace aufbruchgebiet_ausland = 145 if substr(f3a,1,2) == "70" & f5_2==16
quietly replace aufbruchgebiet_ausland = 145 if substr(f3a,1,2) == "72" & f5_2==16
quietly replace aufbruchgebiet_ausland = 145 if substr(f3a,1,2) == "73" & f5_2==16
quietly replace aufbruchgebiet_ausland = 150 if substr(f3a,1,2) == "80" & f5_2==16
quietly replace aufbruchgebiet_ausland = 146 if substr(f3a,1,2) == "84" & f5_2==16
quietly replace aufbruchgebiet_ausland = 149 if substr(f3a,1,2) == "89" & f5_2==16
quietly replace aufbruchgebiet_ausland = 158 if substr(f3a,1,2) == "93" & f5_2==16
quietly replace aufbruchgebiet_ausland = 158 if substr(f3a,1,2) == "95" & f5_2==16

* PLZ Schweden
quietly replace aufbruchgebiet_ausland = 164 if f5_2==34
quietly replace aufbruchgebiet_ausland = 165 if substr(f3a,1,1) == "1" & f5_2==34

* PLZ Finnland
quietly replace aufbruchgebiet_ausland = 166 if f5_2==9
quietly replace aufbruchgebiet_ausland = 167 if substr(f3a,1,3) == "001" & f5_2==9

* PLZ Norwegen
quietly replace f3a = substr(f3a,-4,.) if substr(f3a,1,1)=="N" & f5_2==28
quietly replace aufbruchgebiet_ausland = 168 if f5_2==28 & substr(f3a,1,2)=="00"
quietly replace aufbruchgebiet_ausland = 169 if f5_2==28 & real(substr(f3a,1,1))<7
quietly replace aufbruchgebiet_ausland = 170 if f5_2==28 & (real(substr(f3a,1,1))==7 | real(substr(f3a,1,1))==8)
quietly replace aufbruchgebiet_ausland = 171 if f5_2==28 & real(substr(f3a,1,1))==9

* PLZ  Russland
quietly replace aufbruchgebiet_ausland = 174 if f5_2==33
quietly replace aufbruchgebiet_ausland = 172 if f5_2==33 & real(substr(f3a,1,1))<2 
quietly replace aufbruchgebiet_ausland = 173 if f5_2==33 & real(substr(f3a,1,2))==19 

* PLZ Belgien
quietly replace f3a = substr(f3a,-4,.) if substr(f3a,1,1)=="0" & f5_2==4
quietly replace aufbruchgebiet_ausland = 175 if substr(f3a,1,4) == "1020" & f5_2==4
quietly replace aufbruchgebiet_ausland = 175 if substr(f3a,1,4) == "1000" & f5_2==4
quietly replace aufbruchgebiet_ausland = 176 if substr(f3a,1,1) == "1" & f5_2==4
quietly replace aufbruchgebiet_ausland = 177 if substr(f3a,1,1) == "2" & f5_2==4
quietly replace aufbruchgebiet_ausland = 178 if substr(f3a,1,1) == "3" & f5_2==4
quietly replace aufbruchgebiet_ausland = 179 if substr(f3a,1,1) == "4" & f5_2==4
quietly replace aufbruchgebiet_ausland = 180 if substr(f3a,1,1) == "5" & f5_2==4
quietly replace aufbruchgebiet_ausland = 181 if substr(f3a,1,1) == "6" & f5_2==4
quietly replace aufbruchgebiet_ausland = 182 if substr(f3a,1,1) == "7" & f5_2==4
quietly replace aufbruchgebiet_ausland = 183 if substr(f3a,1,1) == "8" & f5_2==4
quietly replace aufbruchgebiet_ausland = 184 if substr(f3a,1,1) == "9" & f5_2==4

* PLZ Kanada
quietly replace f3a = subinstr(f3a,"O", "0",1)
quietly replace f3a = subinstr(f3a,"Q", "0",1)
quietly replace aufbruchgebiet_ausland = 185 if upper(substr(f3a,1,1)) == "A" & f5_2==101
quietly replace aufbruchgebiet_ausland = 186 if upper(substr(f3a,1,1)) == "B" & f5_2==101
quietly replace aufbruchgebiet_ausland = 187 if upper(substr(f3a,1,1)) == "C" & f5_2==101
quietly replace aufbruchgebiet_ausland = 188 if upper(substr(f3a,1,1)) == "E" & f5_2==101
quietly replace aufbruchgebiet_ausland = 189 if upper(substr(f3a,1,1)) == "G" & f5_2==101
quietly replace aufbruchgebiet_ausland = 190 if upper(substr(f3a,1,1)) == "H" & f5_2==101
quietly replace aufbruchgebiet_ausland = 191 if upper(substr(f3a,1,1)) == "J" & f5_2==101
quietly replace aufbruchgebiet_ausland = 192 if upper(substr(f3a,1,1)) == "K" & f5_2==101
quietly replace aufbruchgebiet_ausland = 193 if upper(substr(f3a,1,1)) == "L" & f5_2==101
quietly replace aufbruchgebiet_ausland = 194 if upper(substr(f3a,1,1)) == "M" & f5_2==101
quietly replace aufbruchgebiet_ausland = 195 if upper(substr(f3a,1,1)) == "N" & f5_2==101
quietly replace aufbruchgebiet_ausland = 196 if upper(substr(f3a,1,1)) == "P" & f5_2==101
quietly replace aufbruchgebiet_ausland = 197 if upper(substr(f3a,1,1)) == "R" & f5_2==101
quietly replace aufbruchgebiet_ausland = 198 if upper(substr(f3a,1,1)) == "S" & f5_2==101
quietly replace aufbruchgebiet_ausland = 199 if upper(substr(f3a,1,1)) == "T" & f5_2==101
quietly replace aufbruchgebiet_ausland = 200 if upper(substr(f3a,1,1)) == "V" & f5_2==101
quietly replace aufbruchgebiet_ausland = 201 if upper(substr(f3a,1,1)) == "X" & f5_2==101
quietly replace aufbruchgebiet_ausland = 202 if upper(substr(f3a,1,1)) == "Y" & f5_2==101
quietly replace aufbruchgebiet_ausland = 203 if upper(substr(f3a,1,2)) == "K0" & f5_2==101
quietly replace aufbruchgebiet_ausland = 204 if upper(substr(f3a,1,2)) == "T0" & f5_2==101
quietly replace aufbruchgebiet_ausland = 205 if upper(substr(f3a,1,2)) == "V0" & f5_2==101
quietly replace aufbruchgebiet_ausland = 206 if upper(substr(f3a,1,2)) == "A0" & f5_2==101
quietly replace aufbruchgebiet_ausland = 207 if upper(substr(f3a,1,2)) == "P0" & f5_2==101


label var aufbruchgebiet_ausland "Aufbruchsregion des PAX im Ausland"

label value wohngebiet_ausland wohngebiet_ausland
label value aufbruchgebiet_ausland wohngebiet_ausland

save "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\FHG10_2.dta", replace

