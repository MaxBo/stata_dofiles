capture program drop EstimateZielwahl
program EstimateZielwahl 
version 10.1
args fn
clear
insheet using "`fn'", tab clear case
//rename wij U
sort PersId AltNr
merge PersId using "$MiD_workingdir\Stata\MidH_PTour.dta" ,uniqusing 
constraint define 1 lnZP=1
//gen wij = U / -.05
gen wijVollzEinf = wij * (pTaet==1) * (pPosition==1)
gen wijVollzMittl = wij * (pTaet==1) * (pPosition==2)
//HS/RS unterscheiden sich von Fhs/Abi...
gen wijVollzHoch = wij * (pTaet==1) * (pPosition==3)
gen wijTeilzEinf = wij * (pTaet==2) * (pPosition==1)
gen wijTeilzMittel = wij * (pTaet==2) * (pPosition==2)
gen wijTeilzHoch = wij * (pTaet==2) * (pPosition==3)
gen wijSchueler = wij * (pTaet==4)
gen wijAzubi = wij * (pTaet==3)
gen wijStudi = wij * (pTaet==5)

gen wijHauptsch = wij *  (pSchul==1)
gen wijRealsch = wij *  (pSchul==2)
gen wijFHSReife = wij * (pSchul==3)
gen wijAbitur = wij * (pSchul==4)
constraint define 2  wijRealsch = 0

gen wijFrau = wij *(pFrau==1)

gen _sample = 1
replace _sample=0 if wij>=. | pTaet>=. | pTaet==0

clogit chosen lnZP wij?* if _sample,group(PersId) constraint(1 2)
end

local BaseFile "D:\temp\AlternativeZiele_ZP_LogSum"
local Endung ".txt"
forvalues i = 0/2 {
	local FileName "`BaseFile'0`i'`Endung'"
	di "`FileName'"
	EstimateZielwahl "`FileName'"
	estimates store Modell`i'
}