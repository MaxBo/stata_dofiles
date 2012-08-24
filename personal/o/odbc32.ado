version 12
capture program drop odbc32

program define odbc32
  // syntax [anything] [if] [in] [using] [, dialog(passthru) dsn(passthru) table(passthru) exec(passthru) load_options(passthru) connect_options(passthru) clear]
  if `c(bit)'==32 {
  //  odbc `anything' `if' `in' `using', `dialog' `dsn' `table' `exec' `load_options' `connect_options' `clear'
    odbc `0'
  }
  else {
      local commandstr = substr(trim("`0'"),1,4)
	  di "`commandstr'"
	  local currentdir = "`c(pwd)'"
	  // di "`currentdir'"
	  local tempdofile = "`c(tmpdir)'z.do"
	  qui di "`tempdofile'"
	  capture file close tempdo
	  file open tempdo using `tempdofile' , write replace
//	  file write tempdo `"odbc `anything' `if' `in' `using', `dialog' `dsn' `table' `exec' `load_options' `connect_options' `clear'"' _n
	  file write tempdo `"odbc `0'"' _n
	  if "`commandstr'" == "load" {
          file write tempdo `"odbc `0'"' _n
	      file write tempdo `"save `c(tmpdir)'z.dta, replace"' _n
	  }
	  else {
	      save `c(tmpdir)'z.dta, replace
		  // di `"`0'"'
		  local newcommand = subinstr(`"`0'"',"create","overwrite",1)
		  // di `"`newcommand'"'
	      file write tempdo `"use `c(tmpdir)'z.dta, clear"' _n
          file write tempdo `"capture odbc `0'"' _n
		  file write tempdo `"if "'
		  file write tempdo "`"
//		  file close tempdo
		  file write tempdo `"r(sqlerror)"'
		  file write tempdo "'"
		  file write tempdo `" == -1 {"' _n
          file write tempdo `"    odbc `newcommand'"' _n
          file write tempdo `"}"' _n		      
	  }
	  file close tempdo
	  qui cd "`c(tmpdir)'"
	  shell "`c(sysdir_stata)'StataSE-32.exe" -e do `tempdofile'
	  qui cd "`currentdir'"
	  if "`commandstr'" == "load" {
	      use "`c(tmpdir)'z.dta", clear
	  }
	}
end

exit

