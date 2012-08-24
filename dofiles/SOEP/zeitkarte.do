use "$PW_workingdir\soep\proj\Mobilitaet\Mob_temp.dta",clear
recode mode5 (.a/.b=5) if taet==5|taet==6
tab mode5 povze ,mi row nof
tab mode5 povze if  workcar==0,mi row nof
tab mode5 povze if  workcar==1,mi row nof
di "Zeitkarten-Besitz bei nicht-ÖV-Nutzern"
tab taet povze if  mode5!=1,row
// vor allem bei bei Studis hoher Anteil Zeitkarten (29%)
di "Zeitkarten-Besitz bei ÖV-Nutzern"
tab taet povze if  mode5==1,row
// vor allem bei geringfügig/teilzeit-beschäftigten geringer Anteil Zeitkarten (66%)