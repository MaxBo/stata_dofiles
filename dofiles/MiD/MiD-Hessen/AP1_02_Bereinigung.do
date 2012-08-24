clear
set memory 700m
local path "D:\DatenMaxDiss\MiD-Hessen\MiD_2008\STATA\"

use "`path'MiD_Wege_Hessen_cod.dta", clear

drop if WSOURCE == 1 | missing(W_GPV)
drop if PV==0
sort HHID PID WSID

* 37 F�lle mit negativer Aktivit�tendauer => 161 F�lle f�r den PV gesehen auf die Wegekette
*	1) Doppelte Wege eliminieren (12 F�lle)
*	2) Einzelfallpr�fungen, Wegezeitenanpassung 
*	3) Neuberechnung Aktivit�tendauer f�r m�gliche zweischichtige Filterung
*	4) am Ende der Pr�fung 11 Wege mit neg. Aktivit�tendauer, 59 F�llen bei Wegekettenbetrachtung

* Behandlung von Wegeketten mit Duplikaten
duplicates tag HHID PID ST_TIME EN_TIME W04, gen(doppelter_Weg)
duplicates drop HHID PID ST_TIME EN_TIME W04 W01 W13 HVM, force
label var doppelter_Weg "Weg kam im Datensatz doppelt vor."

* Einzelfallbearbeitung doppelter Weg
replace W13=3 if HHID == 779634 & PID ==2 & WSID==1
drop if HHID == 779634 & PID ==2 & WSID==2
drop if HHID == 789124 & PID ==2 & WSID==2

* Zeittransformation f�r Folgetage
replace ST_TIME = 86400*ST_DAT + ST_TIME
replace EN_TIME = 86400*EN_DAT + EN_TIME

* Ermittlung Aktivit�tendauer
bysort HHID PID: gen akt_dauer = (ST_TIME[_n] - EN_TIME[_n-1])/60 if _n>1
label var akt_dauer "Aktivit�tendauer"
* Ermittlung einer Wegekette mit mind. einer neg. Aktivit�tendauer
gen neg_time = akt_dauer<0
label var neg_time "negative Aktivit�tendauer"
bysort HHID PID: egen p_neg = sum(neg_time)
label var p_neg "Wegekette mit neg. Aktiv�tendauer"

* Einzelfallbearbeitung Weganfangs- und -endzeit
drop if HHID == 339726 & PID ==2 & WSID==6
drop if HHID == 339726 & PID ==3 & WSID==2
drop if HHID == 795557 & PID ==2 & WSID==2
drop if HHID == 877951 & PID ==2 & WSID==2

* teilweise Mitnahme im Pkw und Fortsetzung des Weges mit �V, teilweise Erledigung dazwischen
replace ST_TIME = ST_TIME + 5*60  if HHID==692801 & PID==3 & WSID==2
replace ST_TIME = ST_TIME + 10*60 if HHID==779531 & PID==1 & WSID==2
replace EN_TIME = EN_TIME - 21*60 if HHID==785510 & PID==3 & WSID==4
replace ST_TIME = ST_TIME + 10*60 if HHID==791730 & PID==4 & WSID==2
replace ST_TIME = ST_TIME + 5*60  if HHID==803491 & PID==1  & WSID==2
replace ST_TIME = ST_TIME + 5*60  if HHID==872743 & PID==1 & WSID==9
replace ST_TIME = ST_TIME + 5*60  if HHID==875072 & PID==2 & WSID==4
replace ST_TIME = ST_TIME + 15*60 if HHID==876114 & PID==1 & WSID==4
replace ST_TIME = ST_TIME + 3*60 if  HHID==879815 & PID==1 & WSID==2
replace ST_TIME = ST_TIME + 10*60 if  HHID==784850 & PID==2 & WSID==9
replace ST_TIME = ST_TIME + 3*60 if  HHID==803798 & PID==1 & WSID==5

* Aktualisierung Wegenummerierung
bysort HHID PID: replace WSID = _n

* verbleibende Wege mit negativer Aktivit�tendauer
bysort HHID PID: replace akt_dauer = (ST_TIME[_n] - EN_TIME[_n-1])/60 if _n>1
* Ermittlung einer Wegekette mit mind. einer neg. Aktivit�tendauer
gen neg_time2 = akt_dauer<0
label var neg_time2 "negative Aktivit�tendauer; nach Pr�fung"
bysort HHID PID: egen p_neg2 = sum(neg_time2)
label var p_neg2 "Wegekette mit neg. Aktiv�tendauer; nach Pr�fung"

gen wegedauer = (EN_TIME-ST_TIME)/60
label var wegedauer "Wegedauer nach Plausibilit�tspr�fung"

* br HHID PID WSID neg_time ST_STD ST_MIN EN_STD EN_MIN  ANZPERS W071  W074 W04 W01 W13 HVM   doppelter_Weg if p_neg2>0

* Pr�fung der Attributierung, Wegezweck & Alter: plausibel
* Pr�fung der Attributierung, F�hrerscheinbesitz & Alter: 11 Pkw-Fahrer + 2 Motorradfahrer  <17
* Beeinigung: Pkw-Fahrer zu Mitfahrer, Motorradfahrer zu Mofafahrern
gen VM_anpass = 0
label var VM_anpass "angepasste Verkehrsmittelwahl"

replace PKW_MF=1 if PKW_F==1 & HP_ALTER<17
replace VM_anpass = 1 if PKW_F==1 & HP_ALTER<17
replace PKW_MF=0 if PKW_F==1 & HP_ALTER<17

replace  W05_3 = 1 if  MRAD_F==1 & HP_ALTER<17
replace VM_anpass = 1 if MRAD_F==1 & HP_ALTER<17



* Pr�fung der Wegel�ngen zur Verkehrsmittelwahl:
* 1) F�lle mit langen Fu�wegen zur Arbeit, private Erledigung -> Einzelfallpr�fung!

* Plausibilt�tspr�fung mit: tab HVM_DIFF  VM, col nofr

* Was fehlt: Wegezwecke auf Richtigkeit pr�fen, z.B. Arbeitswege
* Datenkonsistenz zw. den Datens�tzen pr�fen, so dass �berall die gleichen Attribute stehen!, Orientierung an DS mit Originalerhebung

* Bei 51 F�llen wurden fehlende Werte erg�nzt.
merge HHID PID using "`path'MiD_Personen_Hessen_cod.dta", sort keep(HHEINK OEK_STAT OV_SEG HP_SEX HP_ALTER HHTYP H04_3 H02 PERGRUP PERGRUP1 LEBENSPH GESEIN HP_BESCH HP_PKWFS) _merge(Update_Pers) update uniqusing
drop if missing(WSID)

merge HHID using "`path'MiD_HH_Hessen_cod.dta", sort keep(H02 H04_1 H04_2 H04_3 HHEINK OEK_STAT HHTYP) uniqusing _merge(update_HH) update
drop if missing(WSID)

save "`path'MiD_Wege_Hessen_cod_bereinig.dta", replace




