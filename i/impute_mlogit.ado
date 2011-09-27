********** Program zur einfachen Imputation kategorialer Variablen ************
*! version 1.01  19oct2009
************************************************************************

************************************************************************
program define impute_mlogit

*** imputiert die kategoriale Variable depvar per Monte-Carlo-Simulation mit einem einfachen MNL ***
*** stratifiziert nach einer anderen kategorialen Variable, die mit der BY-Option festgelegt wird ***
*** und ggf. mit weiteren Variablen ***
*** impute_mlogit depvar indvarlist [if/] [in], BY(varname) ***
syntax varlist(min=1) [if/] [in], BY(varname)
quietly {
tempvar prcum r
gettoken depvar varlist: varlist, parse(" ")
local catvar = "`by'"
if "`if'" != "" {
  local ifexp = "`if' & `by'=="
}
else {
  local ifexp = "`by'=="
}
  
tab `catvar',matrow(MatCat)
local norows = rowsof(MatCat)

forvalues b=1/`norows' {
   local catnum = matrix(MatCat[`b',1])
   dropvars _pr*
   mlogit `depvar' `varlist' if `ifexp'`catnum' `in'
   local numout = e(k_out)
   matrix out = e(out)
   predict _pr* if `ifexp'`catnum',pr
   dropvars `r' `prcum'
   gen `r' = 1-runiform() if `ifexp'`catnum'
   gen `prcum' = 0
   forvalues a=1/`numout' {
	 replace `prcum' = `prcum' + _pr`a'
       local catid = matrix(out[1,`a'])
       replace `depvar' = `catid' if `r'<=`prcum' & `ifexp'`catnum' & `depvar'>=.
       replace `prcum' = -10 if `r'<=`prcum'
  }
  matrix drop out
}
}
dropvars _pr* `prcum' `r'
matrix drop MatCat

end 
************************************************************************


