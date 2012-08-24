use "Y:\MOP\Mobilitätsdaten\Long\MOP_W.dta", clear
sort ID PERSNR JAHR
merge ID PERSNR JAHR using "Y:\MOP\Mobilitätsdaten\Long\MOP_P.dta", uniqusing
drop ANORM* URLAUB* WERK* KRANK*
recode VMDIW (99=.)
tab VMDIW  JAHR [iweight=GEWHHPWO],col nof
tab VMDIW  JAHR ,col nof