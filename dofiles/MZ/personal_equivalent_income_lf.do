use O:\MZ\Daten\2006\mz2006.dta 
recode EF707 (1=100) (2=175) (3=400) (4=600) (5=800) (6=1000) (7=1200) (8=1400) (9=1600) (10=1850) (11=2150) (12=2450) (13=2750) (14=3050) (15=3400) (16=3800) (17=4250) (18=4750) (19=5250) (20=5750) (21=6750) (22=8750) (23=14000) (24=25000) (25/99=.b)
bysort EF3 EF4: gen n_persons = _N
bysort EF3 EF4: egen n_persons_bis_14 = total(EF44 <= 14)
tab n_persons n_persons_bis_14
gen n_sonstige_ueber_14 = n_persons - n_persons_bis_14 - 1
gen faktor = 1 + 0.5*n_sonstige_ueber_14 + 0.3*n_persons_bis_14
replace faktor = 1 if faktor < 1
gen pinc = EF707 / faktor
sumdist pinc [aw=EF952] if EF5a==1
sumdist pinc [aw=EF952] if EF5a==1, n(5)
bysort EF3 EF4 EF27: gen n_persons_lf = _N
bysort EF3 EF4 EF27: egen n_persons_bis_14_lf = total(EF44 <= 14)
gen n_sonstige_ueber_14_lf = n_persons_lf - n_persons_bis_14_lf - 1
gen faktor_lf = 1 + 0.5*n_sonstige_ueber_14_lf + 0.3*n_persons_bis_14_lf
replace faktor_lf = 1 if faktor_lf < 1
bysort EF3 EF4: egen n_lf = max(EF27)
gen hheink_fl = EF707 * n_persons_lf / n_persons
gen pinc_lf = hheink_fl  / faktor_lf
bysort EF3 EF4 EF27: gen lfd_p_in_lf = _n
sumdist pinc_lf [aw=EF952] if lfd_p_in_lf ==1
sumdist pinc_lf [aw=EF952] if lfd_p_in_lf ==1, n(5)
