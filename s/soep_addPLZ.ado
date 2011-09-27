********** Program zum Anspielen der PLZ-bezogenen Variablen  ************+
*! version 1.0  06jun2009
program define soep_addPLZ

local fname "H:\TUHH\LuftlinienDistZentren\OZMZ_km"
insheet using "`fname'.txt",clear
rename zip_code plz
sort plz
save "`fname'.dta",replace

use "D:\users\mbohnet\plz_93_07_fakeid.dta",clear
sort plz fakeid
merge plz using "`fname'.dta",uniqusing keep(dist_oz dist_mz)
drop if _merge==2
save "D:\users\mbohnet\93_07_dist_ozmz.dta",replace

use "D:\users\mbohnet\93_07_dist_ozmz.dta",clear
rename erhebj year
sort hhnrakt year
save "D:\users\mbohnet\93_07_dist_ozmz.dta",replace


end
****************************************************************************



use "D:\users\mbohnet\plz_93_07_fakeid.dta",clear
rename erhebj year
bysort fakeid (year): gen plzchanged= (plz != plz[_n-1]) if plz[_n-1] <. & plz<.
by fakeid: egen anzumzuege=total(plzchanged)
keep if plzchanged==1
outsheet fakeid year plzvorher plz using "H:\TUHH\LuftlinienDistZentren\UmzugPLZ.txt", replace