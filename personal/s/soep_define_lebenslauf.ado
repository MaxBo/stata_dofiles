********** Program dass zu simulierenden Lebesverlauf definiert ************
*! version 1.01  06jun2009
************************************************************************

************************************************************************
program define soep_define_lebenslauf

quietly {

**************** initialisiere Kovariaten für typischen Lebenslauf ****************
*** sam 0 und 2: Männer, sam 1 und 3: Frauen *********
gen female = 0 if sam==0|sam==2
replace female = 1 if sam==1|sam==3

gen empstat=.
gen eqnpers=1
gen adult1_2=0
gen adult1_3=0
gen adult2_3=0
gen adult2_1=0
gen adult3_1=0
gen adult3_2=0
gen eqnkids=0
gen eqnkids14=0
gen hhinc=1800
gen taetig=6 //Nicht-Erwerbstätig
gen moved2y =0
label var moved "Umzug im Jahr"
gen wohn_typ=.
gen entfgrstadt=.
gen inf_doctor=.
gen inf_shops=.
gen inf_transit=.
gen wohn_quartier=.
gen MZLogSumPkw = .
gen OZLogSumPkw = .
gen METLogSumPkw = .
gen METmittlswz = .

***** Person wohnt im Dorf ******
replace wohn_quartier=2
replace wohn_typ=2 
replace entfgrstadt=6 
replace inf_doctor=3 
replace inf_shops=3 
replace inf_transit=3 
replace MZLogSumPkw = 1.5
replace OZLogSumPkw = 3.5
replace METLogSumPkw = 3.5
replace METmittlswz = 23

replace hhinc=700 if agem<22
replace eqnpers=1 if agem<22
replace taetig=3 if agem<22 //Azubi

** mit xx Umzug in Großstadt
local umzugsjahr=18
//sam 0 und 1: bleibt im Dorf
//sam 2 und 3: Umzug in die Großstadt
replace moved2y =1 if agem>=`umzugsjahr' & agem<`umzugsjahr'+2 & sam>1
replace wohn_quartier=3 if agem>=`umzugsjahr' & sam>1
replace wohn_typ=6 if agem>=`umzugsjahr' & sam>1
replace entfgrstadt=1 if agem>=`umzugsjahr' & sam>1
replace inf_doctor=1 if agem>=`umzugsjahr' & sam>1
replace inf_shops=1 if agem>=`umzugsjahr' & sam>1
replace inf_transit=1 if agem>=`umzugsjahr' & sam>1
replace MZLogSumPkw = .2
replace OZLogSumPkw = .2
replace METLogSumPkw = .2
replace METmittlswz = 3


**** mit 22 Voll-Erwerbstätig, ****
replace taetig=1 if agem>=22
replace hhinc=1500 if agem>=22

**** mit 28 Zusammenziehen mit Partner, mit 30 Kind****
replace eqnpers=2 if agem>=28
replace eqnpers=3 if agem>=28
replace hhinc=3000 if agem>=28

replace eqnkids=1 if agem>=30
replace eqnkids14=1 if agem>=44
*** Kind wird erwachsen ***
replace eqnkids=0 if agem>=48
replace eqnkids14=0 if agem>=48

**** mit 53 Kind zieht aus****
replace eqnpers=2 if agem>=53

**** mit 56 : Scheidung ****
replace eqnpers=1 if agem>=56
replace hhinc=1300 if agem>=56

*** mit 65: Rente ***
replace taetig=6 if agem>=65
replace hhinc=1100 if agem>=65



}
end

