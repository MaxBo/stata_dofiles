********** Program zum Umcodieren der Haushalts-Daten ************
*! version 1.01  10oct2009
************************************************************************

************************************************************************
program MOP_recodeHH

di "codiere HH-Daten um"
quietly {

recode LAGE PKWpriv? PKWnutz? PARKSTR? EINK? KNEIPE KINO SPORT(9=.a)
label define LAGE .a "keine Angabe",modify
label define PKWpriv .a "keine Angabe",modify
label define PKWnutz .a "keine Angabe",modify
label define PARKSTR .a "keine Angabe",modify
label define EINK1 .a "keine Angabe",modify
label define EINK2 .a "keine Angabe",modify
label define KNEIPE .a "keine Angabe",modify
label define KINO .a "keine Angabe",modify
label define SPORT .a "keine Angabe",modify

drop PARKGAR

recode HALTBUS HALTSTR HALTU HALTS HALTZUG (9=0)
label define HALT 0 "nein",modify
recode HALTBUSZ HALTSTRZ HALTUZ HALTSZ HALTZUGZ (999=.c)
label define HALTZ .c "unplausibel",modify
label values HALTBUSZ HALTSTRZ HALTUZ HALTSZ HALTZUGZ HALTZ
recode ZWEITW (5=0)
label define ZWEITW 0 "Nein",modify

recode CARSHAR PC PCWEB (2=0)
label define CARSHAR 0 "Nein",modify
label define PC 0 "Nein",modify
label define PCWEB 0 "Nein",modify

recode EINK1 EINK2 KNEIPE KINO SPORT (2=0)
label define EINK1 0 "nein" ,modify
label define EINK2 0 "nein" ,modify
label define KNEIPE 0 "nein" ,modify
label define KINO 0 "nein" ,modify
label define SPORT 0 "nein" ,modify

recode EINK?KM KNEIPEKM KINOKM SPORTKM (99/100=.c)
label define ErreichbarkeitKM .c "unplausibel",modify
label values EINK?KM KNEIPEKM KINOKM SPORTKM ErreichbarkeitKM 

recode PKWHH (3/5=3),gen(pkw03)

}

end
****************************************************************************