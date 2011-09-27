********** Program zur Generierung der räumlichen Dummy-Variablen ************+
*! version 1.0  06jun2009
program define MOP_genvar_spatial

quietly {

noi di "generiere Variablen zu Nachbarschaft und Gebäudetyp"

dropvars C?LAGE* C?PP_*
//gen C0LAGE_GrInnen = (LAGE==1) * C0
gen C0LAGE_GrRand = (LAGE==2) * C0
gen C0LAGE_MzInnen = (LAGE==3) * C0
gen C0LAGE_MzRand = (LAGE==4) * C0
gen C0LAGE_Kleinstadt = (LAGE==5) * C0
//keine autolosen Haushalte auf dem Lande, zumindest nicht nach 2004, wo Einkommen erhoben wurde
//gen C0LAGE_Landgem = (LAGE==6) * C0    

//gen C2LAGE_GrInnen = (LAGE==1) * C2
gen C2LAGE_GrRand = (LAGE==2) * C2
gen C2LAGE_MzInnen = (LAGE==3) * C2
gen C2LAGE_MzRand = (LAGE==4) * C2
gen C2LAGE_Kleinstadt = (LAGE==5) * C2
gen C2LAGE_Landgem = (LAGE==6) * C2

//gen C3LAGE_GrInnen = (LAGE==1) * C3
gen C3LAGE_GrRand = (LAGE==2) * C3
gen C3LAGE_MzInnen = (LAGE==3) * C3
gen C3LAGE_MzRand = (LAGE==4) * C3
gen C3LAGE_Kleinstadt = (LAGE==5) * C3
gen C3LAGE_Landgem = (LAGE==6) * C3

//gen C0PP_keine = (PARKPRO==4) * C0
gen C0PP_nbes = (PARKPRO==3) * C0
gen C0PP_schwierig = (PARKPRO==2) * C0
gen C0PP_sehr = (PARKPRO==1) * C0

//gen C2PP_keine = (PARKPRO==4) * C2
gen C2PP_nbes = (PARKPRO==3) * C2
gen C2PP_schwierig = (PARKPRO==2) * C2
gen C2PP_sehr = (PARKPRO==1) * C2

//gen C3PP_keine = (PARKPRO==4) * C3
gen C3PP_nbes = (PARKPRO==3) * C3
gen C3PP_schwierig = (PARKPRO==2) * C3
gen C3PP_sehr = (PARKPRO==1) * C3

replace _sample = 0 if PARKPRO >=.


dropvars C?EINK?
noi di "generiere Variablen zur Erreichbarkeit von Ärzten, Einzelhandel, ÖPNV"
gen C0EINK1 = EINK1 * C0
gen C2EINK1 = EINK1 * C2
gen C3EINK1 = EINK1 * C3
gen C0EINK2 = EINK2 * C0
gen C2EINK2 = EINK2 * C2
gen C3EINK2 = EINK2 * C3

replace _sample = 0 if EINK1>=. | EINK2>=.

gen C0ZWEIT = (ZWEITW>=1 & ZWEITW<.) *C0
gen C2ZWEIT = (ZWEITW>=1 & ZWEITW<.) *C2
gen C3ZWEIT = (ZWEITW>=1 & ZWEITW<.) *C3
replace _sample = 0 if ZWEITW>=.

gen C0KNEIPE = (KNEIPE==1) *C0
gen C2KNEIPE = (KNEIPE==1) *C2
gen C3KNEIPE = (KNEIPE==1) *C3
replace _sample = 0 if KNEIPE>=.

gen C0KINO = (KINO==1) *C0
gen C2KINO = (KINO==1) *C2
gen C3KINO = (KINO==1) *C3
replace _sample = 0 if KINO>=.

gen C0SPORT = (SPORT==1) *C0
gen C2SPORT = (SPORT==1) *C2
gen C3SPORT = (SPORT==1) *C3
replace _sample = 0 if SPORT>=.




}

end
****************************************************************************
