********** Program zur codierung der Übergänge beim Führerscheinbesitz   ************
*! version 1.0  06jun2009

program define soep_gentransition_fhs

di "codiere Übergänge für den Führerscheinbesitz"
quietly {
// für den Führerscheinbesitz
label define l_pfhs 2 "Erwerb" 3 "Abgabe", modify
bysort persnr (year): replace fhs =2 if (fhs[_n-1]==0 & fhs[_n]==1 & _n!=1)
bysort persnr (year): replace fhs =3 if ((fhs[_n-1]==1 | fhs[_n-1]==2) & fhs[_n]==0 & _n!=1)
}

end
