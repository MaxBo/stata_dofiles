clear
set memory 700m
local path "D:\DatenMaxDiss\MiD-Hessen\MiD_2008\STATA\"

use "`path'MiD_Personen_Hessen_cod_def.dta", clear


* Problem: Pkw-Beistz wurde auf HH-Ebene erhoben, Bezug zur Personenebene daher mit Verzerrungen gekennzeichnet
gen alter2 = HP_ALTER*HP_ALTER
qui tab OEK_STAT, gen(OEK_STAT_)
qui tab HHEINK, gen(HHEINK_)
qui tab ZEN_HES, gen(Zentr_)
qui tab HHTYP, gen(HHTyp_)

* recode H040_? (.a=-1)

* logit hh_ohne_pkw  HHEINK_? HHTyp_? Zentr_? hh_mofa hh_rad hat_zeitkarte P19_1_1 P19_1_2 P19_1_3 HP_ALTER alter2  if HP_ALTER>16

* 1. Ansatz für Logitmodell für HH ohne Pkw
* logit hh_ohne_pkw Zentr_?
* logit hh_ohne_pkw  HHEINK_? HHTYP_?
* logit hh_ohne_pkw  hh_mofa hh_rad hat_zeitkarte P19_1_1 P19_1_2 P19_1_3
* logit hh_ohne_pkw HP_ALTER alter2 P092  P091_1 P091_2 P091_3 P091_4
* logit hh_ohne_pkw Zentr_1 Zentr_2 Zentr_3  hh_mofa hh_rad hat_zeitkarte P19_1_1 P19_1_2 P19_1_3 HP_ALTER alter2 P092 OEK_STAT_1 RBW0


