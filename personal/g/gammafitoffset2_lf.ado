*! NJC 1.0.0 6 Nov 2003 
program gammafitoffset2_lf
	version 8.1
	args lnf alpha beta 
	local offset = `alpha'*`beta'
	qui replace `lnf' = ///
	 -ln(`beta'^`alpha') - lngamma(`alpha') ///
	+ ln(($S_MLy+`offset')^(`alpha' - 1)) - (($S_MLy+`offset') / `beta') 
end 		
