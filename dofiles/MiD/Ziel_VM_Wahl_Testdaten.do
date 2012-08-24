use "C:\Users\Max_2\Desktop\ZVM.dta", clear

dropvars U eU nenner logsum
constraint define 1 lnZ=1
clogit chosen t O F lnZ if _sample, group(PersId) constr(1)
clogit chosen t O F lnZ if _sample0, group(PersId) constr(1)
predict pGesSimultan
gen w1 = 1
replace w1 = 10 if Y==1
clogit chosen t lnZ O F if _sample [iw=w1], group(PersId) constr(1)
clogit chosen t lnZ O F if _sample [iw=1/w1], group(PersId) constr(1)

clogit chosen t O F if _sample , group(PersIdZ)
predict pM
predict U,xb
gen eU = exp(U)
bysort PersIdZ: egen nenner = total(eU)
gen logsum = ln(nenner)
sort PersId Z ModeId


clogit chosenZ lnZ logsum if _sample0 & P [iw = w1],group(PersId) constr(1)
clogit chosenZ lnZ logsum if _sample0 & P [iw = 1/w1],group(PersId) constr(1)
clogit chosenZ lnZ logsum if _sample0 & P,group(PersId) constr(1)
predict pZ0 if P
bysort PersIdZ: egen pZ1 = max(pZ0)

gen pGes = pM * pZ1
corr pGes pGesSimultan

constraint define 11 [Z1]:lnZ = 1
constraint define 12 [Z2]:lnZ = 1
constraint define 13 [Z3]:lnZ = 1
constraint define 21 [Z1_tau]_cons = [Z2_tau]_cons
constraint define 23 [Z3_tau]_cons = [Z2_tau]_cons
nlogit chosen t O F if _sample0 || Z: lnZ || altnum:, noconst case(PersId) constr(11/13 21 23)
nlogit chosen t O F if _sample || Z: lnZ || altnum:, noconst case(PersId) constr(11/13 21 23)
clogit chosen t O F lnZ if _sample , group(PersId) constr(1)

constraint define 31 [ModeId1_tau]_cons = [ModeId2_tau]_cons
constraint define 32 [ModeId2_tau]_cons = [ModeId3_tau]_cons
constraint define 41 [altnum]:lnZ = 1
constraint define 42 [ModeId1]:t = [ModeId2]:t
constraint define 43 [ModeId1]:t = [ModeId3]:t
nlogit chosen lnZ  O F if _sample0 || ModeId: t || altnum: , noconst collinear case(PersId) constr(31 32 41/43)
nlogit chosen lnZ  O F if _sample || ModeId: t || altnum: , noconst collinear case(PersId) constr(31 32 41/43)
