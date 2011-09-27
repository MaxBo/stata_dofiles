********** Program zur Generierung der Umzugs-Variablen ************+
*! version 1.0  06jun2009
program define soep_genvar_moved

quietly {


****** generiere Umzugs-Variable *********
dropvars moved2y
gen moved2y = 0
bysort persnr (year): replace moved2y=1 if (_n>1 & hhwhgnr != hhwhgnr[_n-1] & (agem-agem[_n-1]<=2)) 
bysort persnr (year): replace moved2y=1 if (_n>2 & hhwhgnr != hhwhgnr[_n-2] & (agem-agem[_n-2]<=2))

****** generiere Variablen bei Änderung der Haushaltsgrößen *********
bysort persnr (year): gen adult1_2= (adult2==1 & adult1[_n-1]==1 &_n!=1)
label var adult1_2 "1->2 adults"
bysort persnr (year): gen adult1_3= (adult3==1 & adult1[_n-1]==1 &_n!=1)
label var adult1_3 "1->3+ adults"
bysort persnr (year): gen adult2_3= (adult3==1 & adult2[_n-1]==1 &_n!=1)
label var adult2_3 "2->3+ adults"
bysort persnr (year): gen adult2_1= (adult1==1 & adult2[_n-1]==1 &_n!=1)
label var adult2_1 "2->1 adults"
bysort persnr (year): gen adult3_1= (adult1==1 & adult3[_n-1]==1 &_n!=1)
label var adult3_1 "3+->1 adults"
bysort persnr (year): gen adult3_2= (adult2==1 & adult3[_n-1]==1 &_n!=1)
label var adult3_2 "3+->2 adults"

}

end
****************************************************************************
