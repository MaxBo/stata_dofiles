*! 1.0.1  14mar2000  jw/ics
program define droplabels
	version 6

	while "`1'" != "" {
		capture label drop `1'
		if _rc { 
			local nodropv "`nodropv' `1'"
		}       
		mac shift
	}
	if "`nodropv'" != "" {
		di in gr "Unable to drop labels" in ye "`nodropv'"
	}                
end
