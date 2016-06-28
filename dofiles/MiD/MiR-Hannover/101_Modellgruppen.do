**Modal Split Vergleich Infas***

use "O:\MiD-H\MiR-2011\stata\personen_Raumkategorien_cod.dta", clear
***Modal Split nach Personengruppen***
***Montag-Freitag***
dropvars PgrModell
recode PERGRUP1 (9=0 Kleinkind) (10=1 Grundsch) ///
(11 12 =2 Schüler) (5 6=3 Studierende) (7 8=4 Azubi) ///
(1=5 EmP) (2=6 EoP) (3=7 NEmP) (4=8 NEoP) ///
(.f=9 R75mP) (.g=10 R75oP) (.h=11 R99mP) (.i=12 R99oP), gen(PgrModell)

recode PgrModell (7=11) (8=12) if HP_ALTER>=65
recode PgrModell (11=9) (12=10) if HP_ALTER<75

tab  PgrModell [iw=P_HOCH]


use "O:\MiD-H\MIR-2011\stata\Wege_Raumkategorien_cod.dta", clear
set mem 800m
set more off


***Modal Split nach Personengruppen***
***Montag-Freitag***
dropvars PgrModell
recode PERGRUP1 (9=0 Kleinkind) (10=1 Grundsch) ///
(11 12 =2 Schüler) (5 6=3 Studierende) (7 8=4 Azubi) ///
(1=5 EmP) (2=6 EoP) (3=7 NEmP) (4=8 NEoP) ///
(.f=9 R75mP) (.g=10 R75oP) (.h=11 R99mP) (.i=12 R99oP), gen(PgrModell)

recode PgrModell (7=11) (8=12) if HP_ALTER>=65
recode PgrModell (11=9) (12=10) if HP_ALTER<75

tab  PgrModell HVM if STICHTAG <= 5 & HWZWECK != 2 & WEGKM_K <=100 [iw=W_GEW], row nof
tab  PgrModell HVM if  HWZWECK != 2  [iw=W_HOCH]

tabstat WEGKM_K if STICHTAG <= 5 & HWZWECK != 2 & WEGKM_K <=50 [aw=W_GEW], by(PgrModell) stats(mean)


***Aktivitäten Modell***

dropvars ZweckModell
recode W04 (1=1 Arbeit) (2=.a dienstl) ///
(4=2 Einkperi) (.z=3 EinkAper) ///
(5/7= 4 PrivErl) (8/29=.d Sonstiges) ///
(3 31 32 =5 Grundsch) (.y=6 Schule2) (.x=7 Berufsch) (.w=8 Hochsch) (.v=9 Kita) ///
, gen(ZweckModell)
recode ZweckModell (2 4=3) if inlist(W04_DZW, 502, 503, 505)
recode ZweckModell (5=6) if PgrModell==2
recode ZweckModell (5=7) if PgrModell==4
recode ZweckModell (5=8) if PgrModell==3
recode ZweckModell (5=9) if PgrModell==0

tabstat WEGKM_K if STICHTAG <= 5 & HWZWECK != 2 & WEGKM_K <=50 [aw=W_GEW], by(ZweckModell) stats(mean)

tab ZweckModell HVM if STICHTAG <= 5 & HWZWECK != 2 & WEGKM_K <=50 [aw=W_GEW], row nof


** Wege insgesamt (incl. Sa/So, da sonst der HRF nicht passt)
tab  PgrModell HVM if  HWZWECK != 2  [iw=W_HOCH]

