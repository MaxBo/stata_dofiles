*! NJC 1.0.0 6 Nov 2003 
program gammafitoffset_lf
	version 8.1
	args lnf alpha beta offset
	qui replace `lnf' = ///
	 -ln(`beta'^`alpha') - lngamma(`alpha') ///
	+ ln(($S_MLy+`offset')^(`alpha' - 1)) - (($S_MLy+`offset') / `beta') 
	// list `alpha' `beta' `offset' $S_MLy `lnf' in 1/10
end 		
