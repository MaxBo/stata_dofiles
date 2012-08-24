*! NJC 1.0.0 6 Nov 2003 
program gammafit_lf
	version 8.1
	args lnf alpha beta 
	qui replace `lnf' = ///
	-ln(`beta'^`alpha') - lngamma(`alpha') ///
	+ ln($S_MLy^(`alpha' - 1)) - ($S_MLy / `beta') 
end 		
