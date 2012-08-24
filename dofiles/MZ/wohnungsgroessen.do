use "O:\MZ\Daten\2006\mz2006.dta", clear

keep EF1 EF3 EF4 EF5a EF5b EF8 EF9 EF490 EF491 EF492 EF616 EF637 EF641 EF642 EF9b EF960
// nur Haushalte : = 1. Person im Haushalt
keep if EF5a==1 & EF5b == 0
// WGs itentifizieren
bysort EF3 EF9:  gen wg=_n
recode wg (1=0) (2/9=1)
recode EF490 (2/5=0) (9=.), gen(ezfh)

egen whgrkl = cut( EF492 ), at(0 40 50 60 70 80(20)160 401) label
gen wgrkl_gebtyp = whgrkl + ezfh*10
recode wgrkl_gebtyp (6/9 = 6) (10/14=14)
label define wgrkl_gebtyp 0 "gw_bis_40" 1 "gw_40_50" 2 "gw_50_60" 3 "gw_60_70" 4 "gw_70_80" 5 "gw_80_100" 6 "gw_100_"  14 "efh_bis_80" 15 "efh_80_100"  16 "efh_100_120" 17 "efh_120_140" 18 "efh_140_160" 19 "efh_160_" 20 "WG"
label values wgrkl_gebtyp wgrkl_gebtyp
tabout wgrkl_gebtyp wg [aw=EF960] using "D:\Modell\sim\params\wg_nach_whgtyp.txt", cells(row)
// WG als eigenen Wohnungstyp
replace wgrkl_gebtyp=20 if wg

recode EF616 (3/9=3 "3 und mehr"), gen(hhgr)
tabout wgrkl_gebtyp hhgr [aw=EF960] using "D:\Modell\sim\params\whgtyp_nach_hhtyp.txt", cells(col)


