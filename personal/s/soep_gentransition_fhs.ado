********** Program zur codierung der �berg�nge beim F�hrerscheinbesitz   ************
*! version 1.0  06jun2009

program define soep_gentransition_fhs

di "codiere �berg�nge f�r den F�hrerscheinbesitz"
quietly {
// f�r den F�hrerscheinbesitz
label define l_pfhs 2 "Erwerb" 3 "Abgabe", modify
bysort persnr (year): replace fhs =2 if (fhs[_n-1]==0 & fhs[_n]==1 & _n!=1)
bysort persnr (year): replace fhs =3 if ((fhs[_n-1]==1 | fhs[_n-1]==2) & fhs[_n]==0 & _n!=1)
}

end
