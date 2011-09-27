********** Program zum Export der Daten für biogeme  ************
*! version 1.0  14jul2009
program define soep_export2biogeme

preserve
drop if MZLogSumPkw>=. | METLogSumPkw>=.
drop if METmittlswz >=.
drop if hhpkwmode >=.
keep hhpkwmode persnryear female taet notempl kid1 kid2 hfhs  tmiv tov trad tfuss/*
*/ mixedneighb house_rural house_detached house_terrace house_38 city_* MZ* OZ* MET* /*
*/ doctor10 doctor20 shop10 shop20 noshop pid hfhs /*
*/ PLogSum hhrinc _altnum _sample cozk copkw
rename hhrinc restinc


reshape wide _sample PLogSum , i(persnryear) j(_altnum)
recode * (./.z=99999)

foreach alt of numlist 1/4 11/15 21/25 31/35 {
	drop if _sample`alt'==0 & hhpkwmode == `alt'
}


outsheet using "D:\users\mbohnet\biogeme18\windows_cfsqp\Mobilitaet\sample3.dat", nolabel replace

restore

end
****************************************************************************
