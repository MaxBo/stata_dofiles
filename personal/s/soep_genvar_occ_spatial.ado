version 10


********** Program zur Generierung der Dummy-Variablen ************+
capture program drop soep_genvar_occ_spatial
program define soep_genvar_occ_spatial

dropvars pinc1000 pincln oc_* notempl employed kid* adult*

/* 
gen pinc1000 = pequivinc / 1000
gen pincln = ln(pequivinc)
label var pincln "log(pers. Einkommen)"
*/

gen oc_full = taetig==1
gen oc_part = taetig==2
gen oc_appr = taetig==3
gen oc_stud = taetig==4
gen notempl = taetig==5|taetig==6
label var oc_full "Vollzeit"
label var oc_part "Teilzeit"
label var oc_appr "Azubi"
label var oc_stud "Student"
label var notempl "Nicht-Erwerbstätig"

recode empstat (1 2 3 4 10=1) (5 6 7 8 9 11 12=0),gen(employed)
label var employed "reg. erwerbstätig/in Ausbildung"
recode eqnkids (1=0) if eqnpers==1 
gen kid1= eqnkids==1
label var kid1 "1 Kind"
gen kid2= (eqnkids>=2&eqnkids<.)
label var kid2 "2+ Kinder"
gen adults = (eqnpers-eqnkids)
gen adult1= adults==1
label var adult1 "1 Erwachsener im HH" //reference category
gen adult2= adults ==2
label var adult2 "2 Erwachsene im HH"
gen adult3= (adults>=3 & adults <.)
label var adult3 "3+ Erwachsene im HH"

dropvars house* city* mixedneighb grossstadt efh
recode wohn_quartier (1 2 5 6=0) (3 4=1), gen(mixedneighb)
label var mixedneighb "mixed neighbourhood"
gen house_rural = wohn_typ==1
gen house_detached = wohn_typ==2
gen house_terrace = wohn_typ==3|wohn_typ==8
gen house_38 = wohn_typ==4|wohn_typ==5
//gen house_9 = wohn_typ==6|wohn_typ==7 
// house_9 als reference type
recode wohn_typ (1/3=1) (2/8=0),gen(efh)
label var efh "Einfamilienhaus"

//gen city_centre = entfgrstadt==1
//city_centre als reference-type
gen city_5_10 = entfgrstadt==2
gen city_10_25 = entfgrstadt==3
gen city_25_40 = entfgrstadt==4
gen city_40_ = (entfgrstadt>4 & entfgrstadt<.)
recode entfgrstadt (1/2=1) (3/6=0),gen(grossstadt)

dropvars doctor* nodoctor shop* noshop notransit
gen doctor10=inf_doctor==1
gen doctor20=inf_doctor==2
gen nodoctor=inf_doctor==3|inf_doctor==4
label var doctor10 "doctor in 10 min."
label var doctor20 "doctor in 20 min."
label var nodoctor "no doctor within 20 min."

gen shop10=inf_shops==1
gen shop20=inf_shops==2
gen noshop=inf_shops==3|inf_shops==4
label var shop10 "shops in 10 min."
label var shop20 "shops in 20 min."
label var noshop "no shops within 20 min."
gen notransit = (inf_transit>1&inf_transit<.)
label var notransit "kein ÖV in 10 Minuten Fußweg"

****** generiere Umzugs-Variable *********
dropvars moved2y
gen moved2y = 0
bysort persnr (year): replace moved2y=1 if (_n>1 & hhwhgnr != hhwhgnr[_n-1] & (agem-agem[_n-1]<=2)) 
bysort persnr (year): replace moved2y=1 if (_n>2 & hhwhgnr != hhwhgnr[_n-2] & (agem-agem[_n-2]<=2))

****** generiere Variablen bei Änderung der Haushaltsgrößen *********
bysort persnr (year): gen adult1_2= (adult2==1 & adult1[_n-1]==1 &_n!=1)
label var adult1_2 "1->2 adults"
bysort persnr (year): gen adult1_3= (adult3==1 & adult1[_n-1]==1 &_n!=1)
label var adult1_3 "1->3+ adults"
bysort persnr (year): gen adult2_3= (adult3==1 & adult2[_n-1]==1 &_n!=1)
label var adult2_3 "2->3+ adults"
bysort persnr (year): gen adult2_1= (adult1==1 & adult2[_n-1]==1 &_n!=1)
label var adult2_1 "2->1 adults"
bysort persnr (year): gen adult3_1= (adult1==1 & adult3[_n-1]==1 &_n!=1)
label var adult3_1 "3+->1 adults"
bysort persnr (year): gen adult3_2= (adult2==1 & adult3[_n-1]==1 &_n!=1)
label var adult3_2 "3+->2 adults"

end
****************************************************************************

exit