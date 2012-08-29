set more off
local path "C:\Spitzencluster Luftverkehr\Modell\Nachfragedaten\FHG\"

use "`path'FHG06_08_09_10_raum.dta" , clear

drop if missing(welle)

drop hvm_neu2_* ca_* Jahr_* f30_aggr_* vm_diff_* vm_? hrg_? tz_? flugartn_? herkunft_? ca_wohn_diff_* ca_start_diff_*


drop _merge flugart_? f38_ant_HAM_G_ges_gr4 f38_ant_HAM_P_ges_gr4 f38_ant_G_ges_gr4 f38_ant_P_ges_gr4 f38_ant_HAM_ges_gr4 besch_? alt1_? reisetyp_? alt2_? hrg3_? jz_? ziel_? start_? t r stdf su_ank_zu ank_zu_mw res_gauss ank_30 tp sp tx_r tp2 sp2 tx_r2 mu resi res2 y2 resid jar uhr?_? reisedauer_* wichtung_n ?_halt_? hvm_neu3_?


drop f40 flug_lc_vs_kl ttt tttt  v16 v18 

drop  uhr_tat_m uhr_tat_s v37 v51  wbuld1 wbuld2 wld1 wld2 wkreis1 wkreis2 hkreis1 hkreis2 hld1 hld2 hort1 hort2 hbuld1 hbuld2 wort1 wort2 wror1 wror2
drop log_f13 log_f38_HAM log_f24 log_f32 ank_15 herbst Wohnort_HH_N ziel_10 hror1 hror2
save  "`path'FHG06_08_09_10_raum_red.dta" , replace

merge n:1 wohnland using "`path'weltregionen_def_neu.dta", keepusing(w_region_hwwi) gen(val_wohn)
rename w_region_hwwi wohn_wreg_hwwi
drop if missing(welle)

merge n:1 zielland using "`path'weltregionen_def_neu.dta", keepusing(w_region_hwwi) gen(val_ziel)
rename w_region_hwwi ziel_wreg_hwwi
drop if missing(welle)

recode hrg3 (1=1 "business") (2 3 = 2 "leisure"), gen(hrg_2)
recode f13 (0=0) (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7/1080=7 "7++"), gen(f13_7)

regress f13_7 ib2.zielregion_aggr##ib2.hrg3

