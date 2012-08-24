/* ----------------------------------------------------------------- */
/* Written by Markus Hahn and John Haisken-DeNew                     */
/* Copyright 2007 Dr. John P. Haisken-DeNew. All rights reserved.    */
/* Unauthorized copying prohibited. Email:john@soepmenu.de           */
/* ----------------------------------------------------------------- */


program define pwnetupdate, rclass
	version 9.2
	syntax, [user(string)] [pass(string)] [query] [create(string)] [check] [packages] [install(string)] [kill(string)] [doupdate] [repair] [bin] [version] [os(passthru)] [NO_panelwhiz_restart] [only_upload]
	
    ///////////////////////////////////////////////////////////////////////////////////////
	// Package Information                                                               //
	///////////////////////////////////////////////////////////////////////////////////////
	/* si ch pc */
    local allprefixes         = "pw pa cn cc oz ac bp mz mc de uk li"        // affects order of update check, installing, ...

	/*pc5500*/
	
	/* sipp shp */
	local pkg_main_subdirs    = "pwadmin soep hilda lsac iabbp mikroz mzpc cpsnber cpscepr  bhps luxis"   // "base" must not be specified!	
	local pw_name             = "BASE"
	local pa_name             = "PWADMIN"
	local de_name             = "SOEP"
	local oz_name             = "HILDA"
	local ac_name             = "LSAC"
	local uk_name             = "BHPS"
	local bp_name             = "IAB-BP"
	local mz_name             = "MIKROZ"
	local mc_name             = "MZPC"
	local cn_name             = "CPS-NBER"
	local cc_name             = "CPS-CEPR"
	local li_name             = "LIS"
/*
	local si_name             = "SIPP"
	local ch_name             = "SHP"
	local pc_name             = "PC 5500"
*/

	local pw_subdirs          = "base"
	local pa_subdirs          = "pwadmin/base pwadmin/docs"
	local de_subdirs          = "soep/base soep/labelinfo soep/plugins  soep/updatedata soep/index soep/datasetup"
	local oz_subdirs          = "hilda/base hilda/labelinfo hilda/plugins hilda/index hilda/datasetup"
	local ac_subdirs          = "lsac/base lsac/labelinfo lsac/plugins lsac/index lsac/datasetup"
	local uk_subdirs          = "bhps/base bhps/labelinfo bhps/plugins bhps/datasetup bhps/index"
	local bp_subdirs          = "iabbp/base iabbp/labelinfo iabbp/plugins iabbp/datasetup iabbp/index"
	local mz_subdirs          = "mikroz/base mikroz/plugins mikroz/labelinfo mikroz/datasetup mikroz/index"
	local mc_subdirs          = "mzpc/base mzpc/plugins mzpc/labelinfo mzpc/datasetup mzpc/index"
	local cn_subdirs          = "cpsnber/base cpsnber/labelinfo cpsnber/plugins cpsnber/datasetup cpsnber/index"
	local cc_subdirs          = "cpscepr/base cpscepr/labelinfo cpscepr/plugins cpscepr/datasetup cpscepr/index"
	local li_subdirs          = "luxis/base luxis/datasetup"
/*
	local pc_subdirs          = "pc5500/base pc5500/plugins pc5500/labelinfo pc5500/datasetup pc5500/index"
	local si_subdirs          = "sipp/base sipp/labelinfo sipp/datasetup sipp/index"
	local ch_subdirs          = "shp/base shp/labelinfo shp/plugins shp/datasetup shp/index"
*/

	local pw_aux_subdirs      = "settings temp"
	local pa_aux_subdirs      = "pwadmin/logs"
	local de_aux_subdirs      = "soep/updatedata soep/views"
	local oz_aux_subdirs      = "hilda/views"
	local ac_aux_subdirs      = "lsac/views"
	local uk_aux_subdirs      = "bhps/views"
	local bp_aux_subdirs      = "iabbp/views"
	local mz_aux_subdirs      = "mikroz/views"
	local mc_aux_subdirs      = "mzpc/views"
	local cn_aux_subdirs      = "cpsnber/views"
	local cc_aux_subdirs      = "cpscepr/views"
	local li_aux_subdirs      = "luxis/views"
/*
	local pc_aux_subdirs      = "pc5500/views"
	local si_aux_subdirs      = "sipp/views"
	local ch_aux_subdirs      = "shp/views"
*/
	///////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////////////////////////////////////////////
	// some url and paths (usually this must not be changed) //
	///////////////////////////////////////////////////////////
	local updatescript        = "http://www.panelwhiz.eu/pwcontrol/update.php"
	local online_dist_dir     = "$PW_panelwhizpath/_online_dist"
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////////
	// some text messages (usually this must not be changed) //
	///////////////////////////////////////////////////////////
	local checktext = "Checking http://www.panelwhiz.eu:"
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////

	
	
	/////////////////
	// program code
	
	// more
	local more = c(more)
	set more off
	
	//checksum
	local checksum = c(checksum)
	set checksum off
		
	if "`user'" != "" {
		global PW_auth_user = "`user'"
	}
	if "`pass'" != "" {
		global PW_auth_pass = "`pass'"
	}

	
	// Define standard action
	if "`query'`create'`check'`packages'`install'`doupdate'`repair'`bin'`version'" == "" {
		local query = "query"
	}

	// option [version] given ? -> also run [query]
	if "`version'" == "version" {
		local query = "query"
	}
	
	// create the local subdirs
	foreach pfx of local allprefixes {
		local subdirs "`subdirs' ``pfx'_subdirs'"
	}

	
	// Kill data set packages
	if "`kill'" != "" {
		mata: st_local("kill", strlower("`kill'"))

		foreach pfx of local allprefixes {
			local in_kill: list pfx in kill
			if `in_kill' & !inlist("`pfx'", "pw", "pa"){
				local subdirs_tokill "`subdirs_tokill' ``pfx'_subdirs' ``pfx'_aux_subdirs'"
			}
		}

		foreach subdir of local subdirs_tokill {
			di as text "Killing [`subdir']" _c
			local path "$PW_panelwhizpath/`subdir'"
			local files: dir "`path'" files "*"
			foreach file of local files {
				erase "`path'/`file'"
			}
			di as result "  DONE."
		}
		
		exit
	}
		
	// Check which packages are installed
	if "`packages'" == "packages" | "`query'" == "query" {
		global PW_installed_packages
		if "`query'" == "" {
			di as input "Installed packages: "_c
		}
		foreach pfx of local allprefixes {
			local fully_installed = 1
			foreach subdir of local `pfx'_subdirs {
				capture confirm file "$PW_panelwhizpath/`subdir'/_version"
				if _rc {
					local fully_installed = 0
				}
			}
			if `fully_installed' {
				if "`query'" == "" {
					di as input "[`pfx'] "_c
				}
				global PW_installed_packages $PW_installed_packages `pfx'
			}
		}

		if "`query'" == "" {
			di 
			exit
		}
	}
	
	
	// Check if all files are properly installed
	if "`check'" == "check" {
		foreach pfx of global PW_installed_packages {
			local subdirs_installed "`subdirs_installed' ``pfx'_subdirs'"
		}
		
		check_panelwhiz, subdirs(`subdirs_installed')
		exit
	}
				

	if "`install'" != "" {

		di
		di
		di as input "#############################"
		di as input "# PanelWhiz Install Routine #"
		di as input "#############################"
		di

		// Check internet connection
		check_inet_connect
			
		// Check authentication of user/pass
		check_authentication, updatescript(`updatescript')
		if !r(ok) {
			showerror, install_user_pass
		}

		///////////////////////
		// begin installation
		//
		
		if "$PW_panelwhizpath" != "" {
			local PW_panelwhizpath = "$PW_panelwhizpath"
		}
		
		global PW_panelwhizpath = "`install'"
		
				
		capture localmkdir, path("$PW_panelwhizpath")
		if !_rc {
			global PW_panelwhizpath "`r(dir)'"	// get long path from localmkdir
			
			pwnetupdate, repair	// do full installation
			
			di
			di
			di as input "#########################"
			di as input "# Starting PanelWhiz... #"
			di as input "#########################"
			
			quietly adopath ++ "$PW_panelwhizpath/base"
			capture which panelwhiz
			if !_rc {
				pwprofile, temporary_pwprofile
				run `"`r(pwprofile_do)'"'
				pwviewsmcl, whatsnew
				window stopbox note "You have not yet defined a working directory. Please do this now."
				pwprofilemanager
				exit
			}
			else {
				showerror, failed_installation
			}			
		}
		else {
			showerror, mkdir_panelwhizpath
			
			if "`PW_panelwhizpath'" != "" {
				global PW_panelwhizpath = "`PW_panelwhizpath'"
			}
			
			error 9999
		}
	}
	
	////////////////
	// some checks
	
	if "$PW_panelwhizpath" == "" {
		showerror, no_panelwhizpath
	}
	
	// Check internet connection
	check_inet_connect
	
	// Check authentication of user/pass
	check_authentication, updatescript(`updatescript')
	if !r(ok) {
		local notification = "`checktext' Wrong user/pass! Change {stata pwprofilemanager:here}."
		di as input in smcl "`notification'"_c
			
		if "`query'" != "" {
			return local querytext `"`notification'"'
		}
		
		exit
	}
	
	/////////////////////////////////n/
	// get rights -> subdirs_permitted and subdir
	tempname fout
	quietly file open `fout' using "`updatescript'?getrights&user=${PW_auth_user}&pass=${PW_auth_pass}", read text
	file read `fout' line
	file close `fout'
		
	gettoken result prefixes : line
		
	if "`result'" == "Error:" {
		di as error `"`line'"'
		error 99999
	}
		
	foreach pfx of local allprefixes {
		local in_prefixes: list pfx in prefixes
		if `in_prefixes' {
			local subdirs_permitted "`subdirs_permitted' ``pfx'_subdirs'"
		}
	}
				
	if ("`query'" == "query" | "`doupdate'" == "doupdate") & ("`repair'" != "repair") {

		foreach pfx of global PW_installed_packages {
			local in_prefixes: list pfx in prefixes
			if !`in_prefixes' {
				local pkgs_nolicense "`pkgs_nolicense' `pfx'"
			}
		}

		
		quietly file open `fout' using "`updatescript'?getversion", read text
			
		file read `fout' line
		
		if "`version'" == "version" {
			di
			di as result "{ralign 25:PACKAGE}    OFFLINE VERSION     ONLINE VERSION"
		}

		local subdirs      // clear subdirs
		
		while r(eof)==0 {
			local current = 1

			local subdir     : word 1 of `line'
			local online_ver : word 2 of `line'
						
			get_version `subdir'
			local in_subdirs_permitted: list subdir in subdirs_permitted
			if (("`online_ver'" != "`r(version)'") | ("`r(version)'" == "???????????????")) & (`in_subdirs_permitted'){
				// subdir needs update
				local current = 0
				local subdirs `subdirs' `subdir'
			}

			if "`version'" == "version" {
				local off_ver = "`r(version)'"
				local on_ver  = "`online_ver'"
				
				foreach xxx in off_ver on_ver {
					local len = length("``xxx''")
					if `len' == 14 {
						local `xxx' " ``xxx''"
					}
					
				}

				if `current' {
					di as text "{ralign 25:[`subdir']}    " as text  "`off_ver'" as text "    `on_ver'"
				}
				else {
					di as text "{ralign 25:[`subdir']}    " as error "`off_ver'" as text "    `on_ver'"
				}
			}
								
			file read `fout' line
		}
		file close `fout'
		
		if "`query'" == "query" {

			if "`subdirs'" != "" {
				if "`version'" != "version" {

					foreach subdir of local subdirs {
						local text_subdirs "`text_subdirs'[`subdir'] "
					}
					local querytext " Update `text_subdirs'{stata pwnetupdate, doupdate:here}."
				}

				global PW_needupdate = "yes"
			}
			else {
				if "`version'" != "version" {
					local querytext " PanelWhiz is up to date."
				}
				
				global PW_needupdate = "no"
			}
			
			if "`version'" != "version" {
				di as input in smcl `"{p 0 0 2}`checktext'`querytext'{p_end}"'
				return local querytext `"`checktext'`querytext'"'
			}

			if "`pkgs_nolicense'" != "" {
				
				foreach pfx of local pkgs_nolicense {
					local package = "``pfx'_name'"
					local text_pkgs "`text_pkgs'`package' "
				}
				
				mata: st_local("text_pkgs", strtrim("`text_pkgs'"))

				local text_pkgs: subinstr local text_pkgs " " ", ", all
				
				local nolicensetext "Your PanelWhiz license for the following data sets has expired: `text_pkgs'. Please update your license! Click {browse www.panelwhiz.eu/docs/PanelWhiz_Contract.pdf:here} for the contract."

				di
				di as input in smcl `"{p 0 0 2}`nolicensetext'{p_end}"'
				return local nolicensetext `"`nolicensetext'"'
			}
			
			// Restart soep if possible
			capture which panelwhiz
			if !_rc & ("`no_panelwhiz_restart'" != "no_panelwhiz_restart") {
				panelwhiz
			}
			
			set more     `more'
			set checksum `checksum'
			
			exit
 		}                
		
	}


	// ensure directory structure
	foreach pfx of local allprefixes {
		if "`pfx'" == "pw" {
			local create_subdirs "`pw_subdirs' `pkg_main_subdirs' `pw_aux_subdirs'"			
		}
		else {
			local create_subdirs "``pfx'_subdirs' ``pfx'_aux_subdirs'"
		}
		
		foreach subdir of local create_subdirs {
			capture mkdir "$PW_panelwhizpath/`subdir'", public
		}
	}

	
	if "`bin'" == "bin" {
		binaries, updatescript(`updatescript') `os' getall
		exit
	}
	else {
		if "`repair'" == "repair" {
			binaries, updatescript(`updatescript') getall
		}
		else {
			binaries, updatescript(`updatescript')	// Check if binaries installed
		}
	}
	
		
	if "`create'" != "" {
		if "`only_upload'" == "" {
						
			local pwd = c(pwd)
			quietly cd "$PW_panelwhizpath/"
			capture mkdir "`online_dist_dir'", public
			foreach dir of local pkg_main_subdirs {
				capture mkdir "`online_dist_dir'/`dir'", public	
			}

			
			tempname fout fout2
			quietly file open `fout' using "_version", write replace text

			foreach subdir of local subdirs {
				local make_subdir: list subdir in create 
				if `make_subdir' {
					di as text "Creating [`subdir']"

					// Preparations for some subdirs
					if "`subdir'" == "soep/plugins" {
						if "$PW_pwadmin" == "Yes" {
							// pwadmin_deplugindescribe
						}
					}
										
					// Do packaging 
					local target_tar  = "`subdir'.tar"
					local target_gz   = "`target_tar'.gz"
								
					set_version `subdir'
					
					capture shell tar -cvf `target_tar' `subdir'
					capture confirm file "`target_tar'"
					if _rc {
						showerror, tar
					}
				
					capture shell gzip -f `target_tar'
					capture confirm file "`target_gz'"
					if _rc {
						showerror, gzip
					}
								
					capture copy "`target_gz'" "`online_dist_dir'/`target_gz'", replace
					capture erase "`target_gz'" 
				
				
				}
				else {
					get_version `subdir'
				}
			
				file write `fout' "`subdir' `r(version)'" _n
			}
			
			file close `fout'
			
			capture copy "_version" "`online_dist_dir'/_version", replace
			capture erase "_version"
			capture copy "$PW_panelwhizpath/base/pwnetupdate.ado" "`online_dist_dir'/pwnetupdate.ado", replace
			capture copy "$PW_panelwhizpath/pwwhatsnew.smcl" "`online_dist_dir'/pwwhatsnew.smcl", replace
		
			quietly cd "`pwd'"
		
			di as result "Written to: `online_dist_dir'"
		
		}

		if "$PW_pwadmin" == "Yes" {
			di
			pwadmin_pwpublishupdate, subdirs(`create') archivepath(`online_dist_dir')
		}
		
		exit
	}
	
	
	if "`repair'" != "" {
		// repair only permitted subdirs
		local subdirs `subdirs_permitted'
	}
	
	
	foreach subdir of local subdirs {
		local target_tar  = "`subdir'.tar"
		local target_gz   = "`target_tar'.gz"
		
		local source      = "`updatescript'?getpackage&user=${PW_auth_user}&pass=${PW_auth_pass}&package=`subdir'"
		local destination = "$PW_panelwhizpath/`target_gz'"
		
		di as text "Downloading [`subdir']" _c
		capture copy `"`source'"' `"`destination'"', replace
		if !_rc {
			di as result "  DONE."
		}
		else {
			di as error "  FAILED. (DOWNLOAD ERROR)"
		}
	}
	
	if "`subdirs'" != "" {
		di as text "Downloading [pwwhatsnew.smcl]" _c
		capture copy "`updatescript'?getwhatsnew" "$PW_panelwhizpath/pwwhatsnew.smcl", replace
		if !_rc {
			di as result "  DONE."
		}
		else {
			di as error "  FAILED. (DOWNLOAD ERROR)"
		}
	}
		
	
	foreach subdir of local subdirs {
		local target_tar  = "`subdir'.tar"
		local target_gz   = "`target_tar'.gz"
		
		di as text "Decompressing [`subdir']" _c
		
		if "`subdir'" == "base" {
			capture findfile "pwnetupdate.ado"
			if !_rc {
				capture copy "`r(fn)'" "$PW_panelwhizpath/pwnetupdate.ado", replace
			}
		}
		
		///////////////////////////
		// begin extraction	
		
		local pwd = c(pwd)
		quietly cd "$PW_panelwhizpath"
				
							
		capture shell gzip --decompress `target_gz'
		capture confirm file "`target_tar'"
		if _rc {
			di as error "  FAILED. (GZIP ERROR)"
		}
		else {			
			capture shell tar --recursive-unlink -xvf `target_tar' `subdir'		// tar KILLS old subdir first!!
			
			di as result "  DONE."
		}
			
		capture erase `target_tar'
		quietly cd "`pwd'"
		
	}
	

	set more     `more'
	set checksum `checksum'

	// Restart PanelWhiz if possible
	capture which panelwhiz
	if !_rc {
		discard
		capture panelwhiz, init
	}
    
	pwnetupdate, query
	capture pwnetupdate, packages
	capture pwviewsmcl, whatsnew
end


program define showerror
	syntax,	[gzip] [tar] [mkdir_panelwhizpath] [NO_panelwhizpath] [inet_connect] [download] [install_user_pass] [failed_installation]
	
	di
	
	if "`gzip'" == "gzip" {
		di as error `"There was an error with the gzip binary."'
		di as error `"Please make sure that this binary is properly installed on your system!"'
		di as error `"Type "pwnetupdate, bin" or click {stata pwnetupdate, bin:here} to get the latest binaries!"'
		error 99999
	}
	
	else if "`tar'" == "tar" {
		di as error `"There was an error with the tar binary."'
		di as error `"Please make sure that this binary is properly installed on your system!"'
		di as error `"Type "pwnetupdate, bin" or click {stata pwnetupdate, bin:here} to get the latest binaries!"'
		error 99999
	}
	
	else if "`mkdir_panelwhizpath'" == "mkdir_panelwhizpath" {
		di as error `"Could not create the directory "$PW_panelwhizpath"!"'
		di
		di as error `"Please make sure that..."'
		di as error `"(1) "$PW_panelwhizpath" is typed correctly."'
		di as error `"(2) "$PW_panelwhizpath" does not already exist."'
		di as error `"(3) you have write privileges."'
		di
	}
	
	else if "`no_panelwhizpath'" == "no_panelwhizpath" {
		di as error `"It seems as if PanelWhiz is not properly installed!"'
		error 99999
	}
	
	else if "`inet_connect'" == "inet_connect" {
		di as error `"It seems as if you have no connection to the internet!"'
		error 99999
	}

	else if "`download'" == "download" {
		di as error `"Some files could not be downloaded!"'
		di as error `"Please check your PanelWhiz directories and/or your internet connection."'
		error 99999
	}
	
	else if "`install_user_pass'" == "install_user_pass" {
		di as error "{p 0 0 2} You have entered the wrong user id or password. Please make sure that you specifiy the user id (email) and password correctly!{p_end}"
		di
		di as error "{p 0 0 2} Correct syntax: pwnetupdate, install(<path>) user(<user>) pass(<password>){p_end}"
		error 99999
	}
	
	else if "`failed_installation'" == "failed_installation" {
		di as error "PanelWhiz not fully installed, please install again!"
		error 99999
	}
			
	else {
		di as error `"Some error!"'
		error 99999
	}
	
end


program define binaries
	syntax, updatescript(string) [os(string)] [getall]
		
	// Read current os
	if "`os'" == "" {
		local os = c(os)
	}
	
	if ("`os'" == "Windows") {
		local binaries = "gzip.exe tar.exe readme.txt"
		get_binaries, binaries(`binaries') url(`updatescript'?getbinary&binary=windows/) `getall'
	}
	else if ("`os'" == "Unix") {
		local binaries = "gzip tar"
		check_binaries, binaries(`binaries')
	}
	else {
		di as text "It is assumed that gzip and tar are installed on your system (`os')..."
	}
end


program define get_binaries
	syntax, binaries(string) url(string) [getall]
	
	local download_error = 0
	
	foreach binary of local binaries {
		local source    "`url'`binary'"
		local destination "$PW_panelwhizpath/`binary'"
		
		capture confirm file "`destination'"
		if _rc | "`getall'" == "getall" {
			di as text "Downloading [`binary']" _c
			capture copy "`source'" "`destination'", replace
			if !_rc {
				di as result "  DONE."
			}
			else {
				di as error "  FAILED. (DOWNLOAD ERROR)"
				local download_error = 1
			}
		}
	}
	
	if `download_error' {
		showerror, download
	}
	
end


program define check_binaries
	syntax, binaries(string)
	
	local not_found = ""
	tempname fh

	foreach binary of local binaries {
		tempfile `binary'
		capture shell which `binary' > ``binary''
		
		quietly file open `fh' using ``binary'', read text
		file read `fh' line
		file close `fh'

		if "`line'" == "" {
			local not_found `not_found' `binary'
		}
	}
	
	if "`not_found'" != "" {
		
		foreach binary of local not_found {
			di as error "[`binary'] " _c
		}
		
		di as error "not properly installed. The update function won't work."
		di as error "Please install the latest binaries on your system."
		error 9999
	}

end

program get_version, rclass
	args subdir
	
	tempname fout
		
	capture file open `fout' using "$PW_panelwhizpath/`subdir'/_version", read text
	if !_rc {
		file read `fout' line
		local version : word 1 of `line'
		file close `fout'
	}
	else {
		local version = "???????????????"
	}
	
	return local version = "`version'"
end

program set_version, rclass
	args subdir
	
	local path = "$PW_panelwhizpath/`subdir'"
	
	tempname fout
	
	quietly file open `fout' using "`path'/_version", write text replace
	
	local version = subinstr(c(current_date), " ", "", .) + subinstr(c(current_time), ":", "", .)
	file write `fout' "`version'" _n _n
	
	local dir: dir "`path'" files "*.*"
	foreach filename of local dir {
		quietly checksum "`path'/`filename'"
		file write `fout' "`filename' `=r(filelen)' `=r(checksum)'" _n
	}
	
	file close `fout'
	
	return local version = "`version'"
end


program define check_inet_connect
	local testurl = "http://www.panelwhiz.eu"
	
	tempname fout
	capture file open `fout' using `testurl', read
	if !_rc {
		file close `fout'
	}
	else {
		showerror, inet_connect
	}

end


program check_authentication, rclass
	syntax, updatescript(string)

	return scalar ok = 0
	
	if "$PW_auth_user" != "" & "$PW_auth_pass" != "" {		
		
		tempname fout
		quietly file open `fout' using "`updatescript'?getauthentication&user=${PW_auth_user}&pass=${PW_auth_pass}", read text
		file read `fout' line
		file close `fout'
				
		if `"`line'"' == `"Ok: authenticated"' {
			return scalar ok = 1
		}
		
	}
	
end

program define check_panelwhiz, rclass
	syntax, subdirs(string)
	
	di
	di
	di as input "##############################"
	di as input "# PanelWhiz Checking Routine #"
	di as input "##############################"
	
	tempname fout
	local error = 0
	
	di
	di as text "Checking global PW_panelwhizpath" _c
	if "$PW_panelwhizpath" != "" {
		di as result "  OK."
	}
	else {
		di as error "  FAILED."
		local error = 1
	}
	
	if !`error' {
		di
		di as text "Checking existence of directories"
		check_dir, dir($PW_panelwhizpath)
		if !r(is_dir) {
			local error = 1
		}
	}
			
	if !`error' {
		foreach subdir of local subdirs {
			check_dir, dir($PW_panelwhizpath/`subdir')
			if !r(is_dir) {
				local error = 1
				local failed_subdirs `failed_subdirs' `subdir'
			}
		}
			
		foreach subdir of local subdirs {
			local subdir_error = 0
			local checksum_mismatch = 0
			local not_found = 0

			
			di
			di as text "Checking content of [`subdir']" _c
			
			local no_check: list subdir in failed_subdirs
			if `no_check' {
				di as error "  FAILED."
			}
			else {
				capture file open `fout' using $PW_panelwhizpath/`subdir'/_version, read text
				if !_rc {
					file read `fout' line
					file read `fout' line
					file read `fout' line
					while !r(eof) {
						local filename : word 1 of `line'
						local filelen  : word 2 of `line'
						local checksum : word 3 of `line'

						if "`filelen'`checksum'" == "" {	// No checksum or file length entries in versionfile
							di
							di as input "     _version" as error "  NOT VALID." _c
							local subdir_error = 1
							continue, break
						}
						
						capture checksum "$PW_panelwhizpath/`subdir'/`filename'"
						if !_rc {
							return scalar is_existing = 1
							
							if (r(filelen) != `filelen') | (r(checksum) != `checksum') {
								// di
								// di as input "     `filename'" as error "  CHECKSUM MISMATCH." _c
								local ++checksum_mismatch
								local subdir_error = 1
							}
						}
						else {
							// di
							// di as input "     `filename'" as error "  NOT FOUND." _c
							local ++not_found
							local subdir_error = 1
						}
						
						file read `fout' line
					}
					
					capture file close `fout'
				}
				else {
					di
					di as input "     _version" as error "  NOT FOUND." _c
					local subdir_error = 1
				}
				
				if !`subdir_error' {
					di as result "  OK."
				}
				else {
					if `not_found' {
						di
						di as input "     `not_found' file(s)" as error "  NOT FOUND."_c
					}
					if `checksum_mismatch' {
						di
						di as input "     `checksum_mismatch' file(s)" as error "  CHECKSUM MISMATCH."_c
					}

					local error = 1
					di
				}
			}
		}
	}


	di
	di
	di as input "#####################"
	di as input "# Checking complete #"
	di as input "#####################"
	di
	
	di as text "Status: "_c
	if `error' {
		di as error "Some errors occured."
	}
	else {
		di as result "No errors occured."
	}
	
	return scalar error = `error'
end

program define check_dir, rclass
	syntax, dir(string)
	
	di as input "     `dir'" _c
	
	capture local test_dir: dir "`dir'" other "*.*", nofail		// exploit macro function "dir" to test whether a specific directory exists
	if !_rc {
		di as result "  OK."
		return scalar is_dir = 1
	}
	else {
		di as error "  FAILED."
		return scalar is_dir = 0
	
	}
end




program define localmkdir, rclass
version 8.2


syntax [, path(string)]

 
local pwd=c(pwd)

local path=subinstr("`path'","\","/",.)


 di "path: `path'"


    tokenize `path', parse("/")

    local i=1
    while "`1'" != "" {

       if "`1'"=="/" {
          if `i'==1 {
              quietly cd /
          }
          macro shift
       }

       if `i'==1 {

          local stub1=substr("`1'",2,1) 
          if "`stub1'"== ":" {
              local stub2=substr("`1'",1,2) 
              quietly cd "`stub2'/"
          }
          else if "`1'"== "~" {
              quietly cd "`1'"
          }
          else {
             capture mkdir "`1'", public
             local rcmd=_rc
             capture cd "`1'"          
          }
       }
       else {
          capture mkdir "`1'", public
          local rcmd=_rc
          capture cd "`1'"          

       }


       macro shift
       local ++i
    }

if `rcmd'!=0  {
   quietly cd "`pwd'"
   error `rcmd'
}
else {
  local dir=c(pwd)
  return local dir=subinstr("`dir'","\","/",.)
  quietly cd "`pwd'"
}

end




