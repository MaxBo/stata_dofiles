use "Y:\MiD-H\Stata\MidH_W0.dta" , clear
merge WegId using "Y:\MiD-H\Stata\W_kg_OV.dta",uniqusing

recode wVM11 (1=1 "Fuss") (2=2 "Rad") (3/5 9=4 "sont. MIV") (6/7=5 "Pkw-F") (8 10=3 "ÖV") (11=.b "sonstiges"),gen(mode5)
expand 5
bysort WegId: gen altnum = _n
gen choice = altnum==mode5
gen _sample = 1
replace _sample = 0 if mode5>=.
gen F = altnum==1
gen R = altnum==2
gen O = altnum==3
gen M = altnum==4
gen P = altnum==5

replace _sample = 0 if O & AnzRouten>=.
replace _sample = 0 if F & MeterKfz>=10000
replace _sample = 0 if R & MeterKfz>=30000
replace _sample = 0 if P & pPkwVerf==0

gen FwGehzeit = F * MinFuss
gen RwFahrtzeit = R * MinRad
gen MPwFahrtzeit = (M|P) * MinKfz
gen OwSZW = O * wSWZ
gen OwFahrtzeit = O * wFahrtzeit
gen OwBahnFahrtzeit = O * wBahnFahrtzeit
gen OwBusFahrtzeit = O * wBusFahrtzeit
gen OwUmhaeufigkeit = O * wUmhaeufigkeit
gen OwZuAbzeit = O * (wZuzeit + wAbzeit)

// Umsteigehäufigkeit als Dummy-Variable
gen OwUH = round(OwUmh)
gen OwUH1 = OwUH==1
gen OwUH2 = OwUH==2
gen OwUH3 = (OwUH>=3 & OwUH<.)

foreach vm in F R O M {
   di "`vm'zwBeruf"?zw*
   gen `vm'zwBeruf = `vm' & hpzweck==1
   gen `vm'zwAusbildung = `vm' & hpzweck==2
   gen `vm'zwDient = `vm' & hpzweck==3
   gen `vm'zwBegleitung = `vm' & hpzweck==4
   gen `vm'zwPrivErl = `vm' & hpzweck==5
   gen `vm'zwEinkauf = `vm' & hpzweck==6
//   gen `vm'zwFreizeit = `vm' & (hpzweck==7 | hpzweck==8)
}


clogit choice F R O M  FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M ?zw* FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwBahnFahrtzeit OwBusFahrtzeit OwUmhaeufigkeit OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M ?zw* FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample, group(WegId)
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample & wZweck==1, group(WegId)
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample & wZweck==3, group(WegId)
// Einkauf täglichger Bedarf
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample & hpzweck==6 & wZweckEinkauf==501, group(WegId)
// Einkauf Sontige Waren/Einkaufsbummel
clogit choice F R O M FwGehzeit RwFahrtzeit MPwFahrtzeit OwSZW OwBahnFahrtzeit OwBusFahrtzeit OwUH?  OwZuAbzeit if _sample & hpzweck==6 & (wZweckEinkauf==502 | wZweckEinkauf==503), group(WegId)
