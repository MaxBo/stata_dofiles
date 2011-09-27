use "Y:\MOP\Mobilitätsdaten\Long\MOP_W.dta",clear
recode WEGGEW (-9=1) (.=1)
sort ID PERSNR JAHR
merge ID PERSNR JAHR using "Y:\MOP\Mobilitätsdaten\Long\MOP_P.dta", uniqusing
sort JAHR
by JAHR: egen _JahrGew = mean(GEWHHPWO)
by JAHR: gen N = _N
gen GEW = (GEWHHPWO / _JahrGew) / N
gen GEW_HPW = GEW  * WEGGEW
recode VMDIW (-9=.) (99=.)
recode KMGEW (-9=1)
recode KM (-9=.)
tab VMDIW JAHR [iw=  GEW_HPW],nof 
gen GEW_HPWK = GEW_HPW * KMGEW * KM
tab VMDIW JAHR [iw=  GEW_HPWK]




