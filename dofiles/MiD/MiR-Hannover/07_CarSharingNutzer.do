use O:\MiD-H\MIR-2011\stata\personen_Raumkategorien_cod.dta, clear

set mem 800m
set more off

tab  Raumkategorien P06A
tab  REGION P06A
tab  Regins P06A
tab  Hann_Umland P06A
tab  Umland_Schiene P06A
tab  Umland P06A
tab  Regins_Schiene P06A
tab  Regins_ohne_Schiene P06A

tab  LEBENSPH P06A
tab  PERGRUP P06A
tab  OEK_STAT P06A
tab OV_SEG P06A
tab H04_3 P06A
tab HP_ALTG1 P06A

