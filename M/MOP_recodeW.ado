********** Program zum Umcodieren der Wege-Daten ************
*! version 1.01  10oct2009
************************************************************************

************************************************************************
program MOP_recodeW

di "codiere Wege-Daten um"
quietly {

recode ABZEIT (9999=.c)
gen double abzeit = (int(ABZEIT/100)*60 + mod(ABZEIT,100))*60*1000
gen double anzeit = (int(ANZEIT/100)*60 + mod(ANZEIT,100))*60*1000
replace anzeit = anzeit+msofhours(24) if anzeit < msofhours(7) & abzeit > msofhours(7)

gen double dauer = anzeit-abzeit
format abzeit anzeit dauer %tcHH:MM

replace anzeit=.e if dauer<0
replace abzeit=.e if dauer<0
replace dauer=.e if dauer<0
label define zeit .e "unplausibel"
label values anzeit abzeit dauer zeit

replace KM =.1 if KM==0.0
gen speed = KM / hours(dauer)

recode ZWECK (15 17 50 79 80 = .d) (70/76 78 = 7),gen(zweck)
label define ZWECK .d "ungültig/sonstige",modify
label values zweck ZWECK

recode VMDIW (99 = .a)
label define VM .a "keine Angabe",modify



}

end
****************************************************************************