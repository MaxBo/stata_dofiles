********** Program zur codierung der Übergänge bei der Pkw-Verfügbarkeit ************
*! version 1.0  09jun2009

program define soep_gentransition_pkw

di "codiere Übergänge für die Pkw-Verfügbarkeit"
quietly {
// für Pkw-Verfügbarkeit
	label define l_pkw 12 "nie -> zeitweise" 13 "nie -> immer" 21 "zeitweise -> nie" 23 "zeitweise -> immer" /*
	*/ 31 "immer -> nie" 32 "immer -> zeitweise" ,modify
	sort persnr year agem
	by persnr (year): replace pkw= 12 if (pkw[_n-1]==1 & pkw[_n]==2 & _n!=1)
	by persnr (year): replace pkw= 13 if (pkw[_n-1]==1 & pkw[_n]==3 & _n!=1)
	by persnr (year): replace pkw= 21 if ((pkw[_n-1]==2 | pkw[_n-1]==12) & pkw[_n]==1 & _n!=1)
	by persnr (year): replace pkw= 23 if ((pkw[_n-1]==2 | pkw[_n-1]==12) & pkw[_n]==3 & _n!=1)
	by persnr (year): replace pkw= 31 if ((pkw[_n-1]==3 | pkw[_n-1]==13 | pkw[_n-1]==23) & pkw[_n]==1 & _n!=1)
	by persnr (year): replace pkw= 32 if ((pkw[_n-1]==3 | pkw[_n-1]==13 | pkw[_n-1]==23) & pkw[_n]==2 & _n!=1)
}

end
