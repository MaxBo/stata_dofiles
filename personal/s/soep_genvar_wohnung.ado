********** Program zur Generierung der räumlichen Interaktionen mit Zahl der Pkw ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_genvar_wohnung

di "generiere Interaktionen der räumlichen Variablen mit Pkw-Besitz"
quietly {

dropvars C?city* C?shop* C*notransit* C?mixednei* C?hs* C*efh CMZ* COZ* CMET*

*** Entfernung zur City: Für HH mit Erwerbstätigen nur Effekt bis 10 km messbar - darüber hinaus vermutlich schon über Arbeitsweg berücksichtigt***
*** Eigenständiger Erst-, Zweit- und Drittwagen-Effekt sind messbar
*** testen unter Berücksichtigung von Nicht-Erwerbstätigen ***
gen C0city05_10 = C0*city_05_10
gen C0city10_25 = C0*city_10_25
gen C0city25_ = C0*(city_25_40|city_40_)
gen C2city05_10 = C2*city_05_10
gen C2city10_25 = C2*city_10_25
gen C2city25_ = C2*(city_25_40|city_40_)
gen C3city05_10 = C3*city_05_10
gen C3city10_25 = C3*city_10_25
gen C3city25_ = C3*(city_25_40|city_40_)

capture confirm var MZwiderstandov
if !_rc {
gen C0tovMZ = C0*MZwiderstandov
gen C0tovOZ = C0*OZwiderstandov
gen C0tovMET = C0*METwiderstandov
gen C2tovMZ = C2*MZwiderstandov
gen C2tovOZ = C2*OZwiderstandov
gen C2tovMET = C2*METwiderstandov
gen C3tovMZ = C3*MZwiderstandov
gen C3tovOZ = C3*OZwiderstandov
gen C3tovMET = C3*METwiderstandov

gen C0MZLogSumPkw = C0*MZLogSumPkw
gen C0OZLogSumPkw = C0*OZLogSumPkw
gen C0METLogSumPkw = C0*METLogSumPkw
gen C2MZLogSumPkw = C2*MZLogSumPkw
gen C2OZLogSumPkw = C2*OZLogSumPkw
gen C2METLogSumPkw = C2*METLogSumPkw
gen C3MZLogSumPkw = C3*MZLogSumPkw
gen C3OZLogSumPkw = C3*OZLogSumPkw
gen C3METLogSumPkw = C3*METLogSumPkw

gen C0METmittlswz = C0*METmittlswz
gen C2METmittlswz = C2*METmittlswz
gen C3METmittlswz = C3*METmittlswz

}

*** Erreichbarkeit Einzelhandel: Eigenständiger Erst-, Zweit- und Drittwagen-Effekt sind messbar
gen C0shop10 = C0*shop10
gen C0shop20 = C0*shop20
gen C2shop10 = C2*shop10
gen C2shop20 = C2*shop20
gen C3shop10 = C3*shop10
gen C3shop20 = C3*shop20

*** ÖV-Qualität scheint für Personen mit Arbeitsweg schon über die VM-Wahl abgebildet zu sein. keinen eigenständigen Einfluss dieses Parameters ***
*** testen unter Berücksichtigung von Nicht-Erwerbstätigen ***
gen C0notransit_10 = C0*notransit
gen C23notransit_10 = (C2|C3)*notransit

*** Mixedneighbourhood: Signifikant, Unterschied Zweit- und Drittwagen nicht zu sehen ***
*** testen unter Berücksichtigung von Nicht-Erwerbstätigen ***
gen C0mixedneighb = C0*mixedneighb
gen C2mixedneighb = C2*mixedneighb
gen C3mixedneighb = C3*mixedneighb

*** Haustyp ***
gen C0hsrural = C0*house_rural
gen C2hsrural = C2*house_rural
gen C3hsrural = C3*house_rural
gen C0hsdetatched = C0*house_detached
gen C2hsdetatched = C2*house_detached
gen C3hsdetatched = C3*house_detached
gen C0hsterraced = C0*house_terrace
gen C2hsterraced = C2*house_terrace
gen C3hsterraced = C3*house_terrace
gen C0hsmulti38 = C0*house_38
gen C2hsmulti38 = C2*house_38
gen C3hsmulti38 = C3*house_38

*** Haustyp einfacher***
gen C0efh = C0*(house_rural|house_detached|house_terrace)
gen C2efh = C2*(house_rural|house_detached|house_terrace)
gen C3efh = C3*(house_rural|house_detached|house_terrace)


dropvars C?ac*
noi di "generiere Variablen für ÖV-Zugang"
gen C0actram2 = (tramaccess==2)*C0
gen C2actram2 = (tramaccess==2)*C2
gen C3actram2 = (tramaccess==2)*C3
gen C0acmetro2 = (metroaccess==2)*C0
gen C2acmetro2 = (metroaccess==2)*C2
gen C3acmetro2 = (metroaccess==2)*C3



}


end 
************************************************************************


