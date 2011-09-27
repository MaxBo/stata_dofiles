********** Program Berechnung der Verkehrsmittelanteile ************+
program define MiDH_PredictModeShare

quietly {
dropvars Prob*  PGes*  FLGew*  PAlt*  PersGew*
predict Prob if _sample, pc1
egen PGes = total(Prob)
bysort m: egen PAlt= total(Prob)
replace PAlt = PAlt / PGes * 100
gen FLGew = Prob* MeterKfz * 322 / 1000
gen PersGew = Prob * 322

}
noi di "Fahrleistung"
noi tab m [iw=FLGew]
noi di "Modal Split der Wege"
noi tab m [iw=PersGew]

end
****************************************************************************
