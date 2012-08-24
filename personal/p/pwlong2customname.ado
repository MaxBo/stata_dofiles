version 10

capture program drop pwlong2customname
program define pwlong2customname 
	run "$PW_panelwhizpath/settings/demyvarnames.do"

	foreach recodepair of global DE_myvarnames {
		local frompos = strpos("`recodepair'","|")
		local customname =substr("`recodepair'",1,`frompos'-1)
		local longname = substr("`recodepair'",`frompos'+1,.)
		capture conf v `longname'
  		local longexists=_rc  
		if `longexists'==0 {
			rename `longname' `customname'
		}
	}

	local outname = subinstr("$S_FN","-long.dta","-custom.dta",1)
	save `outname',replace
end

exit
