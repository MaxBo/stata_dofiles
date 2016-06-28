** Führerscheinbesitz nach Altersklassen 
** 2002 **
quietly {
use "O:\MiD-H\MiR-2011\stata\P_REGION2.dta", clear
recode palter (997/999=.c)
recode psex (9=.c)
egen alkl4 = cut(palter), at(0 18 30 50 65 75 99) label

** Berufstätigkeit
recode p15 (1=1 ja) (2=0 nein) (7/8=.f), gen(berufst)
tab psex berufst if alkl4>=1 & alkl4<=3 [iw=gew_pa], row nof

** Personengruppen
tab Hann_ PERGRUP_AUS[iw=gew_pa], row nof

** Pkw-Führerschein
recode p061_3 (2 .a .b .d .e .f .h =0) (7 8 9 = .j), gen(pfhs)
bysort Hann_ psex: tab alkl4 pfhs  [iw=gew_pa], row nof

** Pkw-Verfügbarkeit nach Altersklassen

bysort caseid: egen n_fhs = total(pfhs)
gen PKW_FS = pfhs
replace PKW_FS = 2 if (pfhs == 1) & (h04_3 < n_fhs) & (h04_3 > 0)
replace PKW_FS = 3 if (pfhs == 1) & (h04_3 >= n_fhs)
label define PKW_FS 0 "kein fhs" 1 "fhs, aber kein Pkw" 2 "geteilter Pkw" 3 "eigener Pkw"
label value PKW_FS PKW_FS

bysort Hann_ psex: tab alkl4 PKW_FS  [iw=gew_pa], row nof
bysort psex: tab alkl4 PKW_FS  [iw=gew_pa], row nof


recode PKW_FS (0 1=0) (2 3=1), gen(pkw)

logit pkw Hann_ psex#i.alkl4
dropvars lr_index se_index p_hat lb ub plb pub 
predict lr_index, xb
predict se_index, stdp
generate p_hat = exp(lr_index)/(1+exp(lr_index))
gen lb = lr_index - invnormal(0.95)*se_index
gen ub = lr_index + invnormal(0.95)*se_index
gen plb = exp(lb)/(1+exp(lb))
gen pub = exp(ub)/(1+exp(ub))
}
tabstat plb pub [aw=gew_pa], by(alkl4) s(mean)
** Hannover
tabstat plb pub if Hann_==1 [aw=gew_pa], by(alkl4) s(mean)
** Umland
tabstat plb pub if Hann_==2 [aw=gew_pa], by(alkl4) s(mean)
** Mann
tabstat plb pub if psex ==1 [aw=gew_pa], by(alkl4) s(mean)
** Frau
tabstat plb pub if psex ==2 [aw=gew_pa], by(alkl4) s(mean)


** Führerscheinbesitz nach Altersklassen 
** 2011 **
quietly {
use "O:\MiD-H\MiR-2011\stata\personen_Raumkategorien_cod.dta", clear
rename P_GEW gew_pa
recode HP_ALTER (997/999=.c)
rename HP_SEX psex
egen alkl4 = cut(HP_ALTER), at(0 18 30 50 65 75 99) label

** Erwerbstätigkeit
recode HP_BERUF (1=1 ja) (2=0 nein) , gen(berufst)
tab psex berufst if alkl4>=1 & alkl4<=3 [iw=gew_pa], row nof




** Personengruppen
***Personengruppe mit Rentner***
recode PERGRUP (6=5) (7=6) (8/9 = 7), gen(PERGRUP2)

label define PERGRUP2 1 "Berufstätige(r) mit verfügbarem Pkw" 2 "Berufstätige(r) ohne Pkw" 3 "Nicht-Berufstätige(r) mit verfügbarem Pkw" 4 "Nicht-Berufstätige(r) ohne Pkw" 5 "Student/Auszubildende(r)" 6 "Kind unter 6 Jahre" 7 "Schüler(in)", modify
label values PERGRUP2 PERGRUP2


gen PERGRUP_NEU = PERGRUP2
replace PERGRUP_NEU = 8 if HP_ALTER >=65 & LEBENSP == 7 & berufst == 0
replace PERGRUP_NEU = 8 if LEBENSP == 7 & berufst == 0

label define PERGRUP_NEU 1 "Berufstätige(r) mit verfügbarem Pkw" 2 "Berufstätige(r) ohne Pkw" 3 "Nicht-Berufstätige(r) mit verfügbarem Pkw" 4 "Nicht-Berufstätige(r) ohne Pkw" 5 "Student/Auszubildende(r)" 6 "Kind unter 6 Jahre" 7 "Schüler(in)" 8 "Rentner(in)", modify
label values PERGRUP_NEU PERGRUP_NEU
recode PERGRUP_NEU (2=1) (3 4=2) (5=3) (6=4) (7=5) (8=6), gen(PERGRUP_AUS)

label define PERGRUP_AUS 1 "Berufstätige(r)" 2 "Nicht-Berufstätige(r)" 3 "Student/Auszubildende(r)" 4 "Kind unter 6 Jahre" 5 "Schüler(in)" 6 "Rentner" , modify
label values PERGRUP_AUS PERGRUP_AUS

tab Hann_ PERGRUP_AUS[iw=gew_pa], row nof

** Führerscheinbesitz
gen pfhs = HP_PKWFS
bysort Hann_ psex: tab alkl4 pfhs  [iw=gew_pa], row nof

** Pkw-Verfügbarkeit nach Altersklassen

bysort HHID: egen n_fhs = total(pfhs)
gen PKW_FS = pfhs
rename H04_3 h04_3
replace PKW_FS = 2 if (pfhs == 1) & (h04_3 < n_fhs) & (h04_3 > 0)
replace PKW_FS = 3 if (pfhs == 1) & (h04_3 >= n_fhs)
label define PKW_FS 0 "kein fhs" 1 "fhs, aber kein Pkw" 2 "geteilter Pkw" 3 "eigener Pkw"
label value PKW_FS PKW_FS

bysort Hann_ psex: tab alkl4 PKW_FS  [iw=gew_pa], row nof
bysort psex: tab alkl4 PKW_FS  [iw=gew_pa], row nof

recode PKW_FS (0 1=0) (2 3=1), gen(pkw)

logit pkw Hann_ psex#i.alkl4
dropvars lr_index se_index p_hat lb ub plb pub 
predict lr_index, xb
predict se_index, stdp
generate p_hat = exp(lr_index)/(1+exp(lr_index))
gen lb = lr_index - invnormal(0.95)*se_index
gen ub = lr_index + invnormal(0.95)*se_index
gen plb = exp(lb)/(1+exp(lb))
gen pub = exp(ub)/(1+exp(ub))
}
tabstat plb pub [aw=gew_pa], by(alkl4) s(mean)
** Hannover
tabstat plb pub if Hann_==1 [aw=gew_pa], by(alkl4) s(mean)
** Umland
tabstat plb pub if Hann_==2 [aw=gew_pa], by(alkl4) s(mean)

** Mann
tabstat plb pub if psex ==1 [aw=gew_pa], by(alkl4) s(mean)
** Frau
tabstat plb pub if psex ==2 [aw=gew_pa], by(alkl4) s(mean)
