*Do-File zum Zusammenfügen der MOP-Dateien im Long-Format
*Erzeugt von Max Bohnet am Thu Aug 28 2008

program joinMOP

local Typen "HH P PT W KIND POT" 
forvalues jahr = 1994/2006 {
	foreach typ in `Typen'  {
		di `jahr' "`typ'"
		if (`jahr' < 1996 & "`typ'" == "POT") {
			display "POT in den ersten beiden Jahren nicht vorhanden"
		}
		else {
		clear
		quietly infix using "Y:\MOP\Mobilitätsdaten\Panel `jahr'\Dict`typ'.dct"
		MOP_StataLabel`typ'
		save "Y:\MOP\Mobilitätsdaten\Panel `jahr'\Stata\MOP_`typ'.dat", replace
		}
	}
}
local Typen "HH P PT W KIND POT" 

foreach typ in `Typen' {
	di "`typ'"
	clear
	if ("`typ'" == "POT") {
		local start 1996
	}
	else {
		local start 1994
	}
	quietly use "Y:\MOP\Mobilitätsdaten\Panel `start'\Stata\MOP_`typ'.dta"
	forvalues jahr = `++start'/2006 {
		quietly append using "Y:\MOP\Mobilitätsdaten\Panel `jahr'\Stata\MOP_`typ'.dta"
	}
	save "Y:\MOP\Mobilitätsdaten\Long\MOP_`typ'.dat",replace

}
