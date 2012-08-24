********** Program zur codierung der �berg�nge bei der Pkw-/Fhs-Verf�gbarkeit ************
*! version 1.0  06jun2009

program define soep_gentransition_pkwfs

di "codiere �berg�nge f�r die Pkw-/F�hrerschein-Verf�gbarkeit"
quietly {
// f�r Pkw/F�hrerschein-Verf�gbarkeit
	label define l_pkwfs 12 "k.FS->FS, Pkw nie" 13 "k.FS->Pkw zeitweise" 14 "k.FS->Pkw immer" 21 " nie,FS->kein FS" 23 "nie,FS->zeitw" 24 "nie,FS->immer" /*
	*/ 31 "zeitw->k.FS" 32 "zeitw->nie,FS" 34 "zeitw->immer" 41 "immer->k.FS" 42 "immer->nie,FS" 43 "immer->zeitw",modify

	by persnr (year): replace pkwfs= 12 if (pkwfs[_n-1]==1 & pkwfs[_n]==2 & _n!=1)
	by persnr (year): replace pkwfs= 13 if (pkwfs[_n-1]==1 & pkwfs[_n]==3 & _n!=1)
	by persnr (year): replace pkwfs= 14 if (pkwfs[_n-1]==1 & pkwfs[_n]==4 & _n!=1)
	by persnr (year): replace pkwfs= 21 if ((pkwfs[_n-1]==2 | pkwfs[_n-1]==12) & pkwfs[_n]==1 & _n!=1)
	by persnr (year): replace pkwfs= 23 if ((pkwfs[_n-1]==2 | pkwfs[_n-1]==12) & pkwfs[_n]==3 & _n!=1)
	by persnr (year): replace pkwfs= 24 if ((pkwfs[_n-1]==2 | pkwfs[_n-1]==12) & pkwfs[_n]==4 & _n!=1)
	by persnr (year): replace pkwfs= 31 if ((pkwfs[_n-1]==3 | pkwfs[_n-1]==13 | pkwfs[_n-1]==23) & pkwfs[_n]==1 & _n!=1)
	by persnr (year): replace pkwfs= 32 if ((pkwfs[_n-1]==3 | pkwfs[_n-1]==13 | pkwfs[_n-1]==23) & pkwfs[_n]==2 & _n!=1)
	by persnr (year): replace pkwfs= 34 if ((pkwfs[_n-1]==3 | pkwfs[_n-1]==13 | pkwfs[_n-1]==23) & pkwfs[_n]==4 & _n!=1)
	by persnr (year): replace pkwfs= 41 if ((pkwfs[_n-1]==4 | pkwfs[_n-1]==14 | pkwfs[_n-1]==24 | pkwfs[_n-1]==34) & pkwfs[_n]==1 & _n!=1)
	by persnr (year): replace pkwfs= 42 if ((pkwfs[_n-1]==4 | pkwfs[_n-1]==14 | pkwfs[_n-1]==24 | pkwfs[_n-1]==34) & pkwfs[_n]==2 & _n!=1)
	by persnr (year): replace pkwfs= 43 if ((pkwfs[_n-1]==4 | pkwfs[_n-1]==14 | pkwfs[_n-1]==24 | pkwfs[_n-1]==34) & pkwfs[_n]==3 & _n!=1)
}

end
