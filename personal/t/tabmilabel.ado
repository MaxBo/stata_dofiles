*! version 1.0 -- Max Bohnet -- 07/11/2008
program define tabmilabel 
  version 10
  syntax varlist [if] [in]
 
  foreach variable of varlist `varlist' {
    quietly ds `variable',has(type string)
    local str = r(varlist)

* String-Variablen in numerische Variable umwandeln, damit tab Werte auszählen kann   
    if "`str'" !="." {
	  encode `variable', generate(_`variable')
	  local variable = "_`variable'"
    }			
* Values und Häufigkeiten in Matrix schreiben
    quietly tab `variable' `if' `in',matrow(vars) matcell(freqs) nol mi
    local rows = rowsof(vars)
    local varl : variable label `variable'
    local vl : value label `variable'
    display
    display as txt "Variable: `variable' -- `varl'"
/*    mata: vallab("`variable'") */
    if "`vl'" != "" {
    	display as txt "Value Lable: `vl'"
    }
    display
    display as txt "Value   Freq   Label"
    local uniqueobs=0
    local obs=0
    local totalobs=0
    forvalues i=1/`rows' {
	 local v=vars[`i',1]
	 local f=freqs[`i',1]
       local vl : label (`variable') `v'
       display as res %5.0f `v' "  " %5.0fc `f' "   `vl'"  
	 if `v'<. {
		local uniqueobs = `uniqueobs' + 1
		local obs = `obs' + `f'
	 }
	 local totalobs = `totalobs'+`f'
    }
    display
    local uniqmissobs= `rows' - `uniqueobs'
    local missobs = `totalobs' - `obs'
    local uniqmisstext = ""
    local misstext = ""
    if `uniqmissobs'>1 {
      local s = "s" //Plural-S
    }
    if `uniqmissobs'>0 {
	local uniqmisstext = "(`uniqueobs' valid + `uniqmissobs' missing`s')"
	local misstext = "(`obs' valid + `missobs' missings)"
    }
    if `rows'>0 {
	display as txt "Total different values : `rows' `uniqmisstext'"
	display as txt "Total observations : `totalobs' `misstext'"
    }
    if "`str'" !="." {
	 drop `variable'
    }
  }
end

mata:
void vallab(string scalar var)
{
	vl = st_varvaluelabel(var)
	st_local("vl",vl)
}
end

