*! 1.0.1 NJC & SPJ 17 Nov 2003
*! 1.0.0 NJC & SPJ 6 Nov 2003
* Fit two-parameter gamma distribution by ML 

/*------------------------------------------------ playback request */
program gammafitoffset2, eclass byable(onecall)
	version 8.1
	if replay() {
		if "`e(cmd)'" != "gammafitoffset2" {
			di as err "results for gammafitoffset2 not found"
			exit 301
		}
		if _by() error 190 
		Display `0'
		exit `rc'
	}
	if _by() by `_byvars'`_byrc0': Estimate `0'
	else Estimate `0'
end

/*------------------------------------------------ estimation */
program Estimate, eclass byable(recall)
	syntax varlist(max=1) [if] [in] [fw aw] [,  ///
		BETAvar(varlist numeric) ALPHAvar(varlist numeric) ///
		Robust Cluster(varname) Level(integer $S_level) noLOG INITAlpha(real 1.) * ]
		
	local y "`varlist'"
	marksample touse 
	markout `touse' `varlist' `betavar' `alphavar' `cluster'
	
//	qui count if `y' < 0 & `touse'
//	if r(N) {
//		noi di " "
//		noi di as txt "warning: {res:`y'} has `r(N)' values < 0;" _c
//		noi di as txt " not used in calculations"
//	}
//	qui replace `touse' = 0 if `y' < 0

	qui count if `touse' 
	if r(N) == 0 error 2000 

	local title "ML fit of two-parameter gamma distribution with offset-parameter"
		local nbeta : word count `betavar'
	local nalpha : word count `alphavar'

	local wtype `weight'
	local wtexp `"`exp'"'
	if "`weight'" != "" local wgt `"[`weight'`exp']"'  
	
	if "`cluster'" != "" { 
		local robust "robust"
		local clopt "cluster(`cluster')" 
	}
	qui sum `y'
	local initoffset = -r(min) * 1.2
	local initbeta = `initoffset' / `initalpha'
	if "`level'" != "" local level "level(`level')"
        local log = cond("`log'" == "", "noisily", "quietly") 
			
	mlopts mlopts, `options'
	global S_MLy "`y'"
	di "`initalpha' `initbeta' `initoffset'"
	`log' ml model lf gammafitoffset2_lf (alpha: `alphavar') (beta: `betavar') ///
		`wgt' if `touse' 
	ml init `initalpha' `initbeta', copy
	ml maximize ,				 ///
	   `robust'       		 ///
		search(on) `clopt' `level' `mlopts' `stdopts' `modopts' 

	eret local cmd "gammafitoffset2"
	eret local depvar "`y'"

	tempname b bbeta balpha
	mat `b' = e(b)
	mat `bbeta' = `b'[1,"beta:"] 
	mat `balpha' = `b'[1,"alpha:"]
	eret matrix b_beta = `bbeta'
	eret matrix b_alpha = `balpha'
	eret scalar length_b_beta = 1 + `nbeta'
	eret scalar length_b_alpha = 1 + `nalpha'

	if "`betavar'`alphavar'" == ""  {
		tempname e		
		mat `e' = e(b)
		eret scalar alpha = `e'[1,1]
		eret scalar beta = `e'[1,2]
	}	
	
	Display, `level' `diopts'
end

program Display
	syntax [, Level(int $S_level) *]
	local diopts "`options'"
	ml display, level(`level') `diopts'
	if `level' < 10 | `level' > 99 local level = 95
end

