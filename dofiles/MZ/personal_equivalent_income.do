use O:\MZ\Daten\2006\mz2006.dta , clear
dropvars hheink
gen hheink = .a
local a = 100
local i = 1
foreach b of numlist 150 300(200)1700 2000(300)3200 3600 4000(500)6000 7500 10000 18000 30000 {
	replace hheink = `a' + (`b'-`a')*runiform() if EF707 == `i'
	local i = `i' + 1
	local a = `b'
	}

dropvars erw kinder n_persons pinc
bysort EF1 EF3 EF4: egen erw = total(EF44>14)
bysort EF1 EF3 EF4: egen kinder = total(EF44<=14)
gen n_persons = 1 + (erw-1) * .5 + kinder*.3
gen pinc = hheink / n_persons
centile pinc, centile(5(10)95)
