********** Program zur imputation von Reisezeiten mit Verkehrsmittel-Alternativen ************
**** Dies erfolgt in mehreren Schritten.
**** Zunächst wird wird aus allen im "Wochebuch" berichteten Wegen Von bzw. zur Arbeit der häufigste Weg extrahiert
**** Damit sollen Ausreisser (Montag morgen...) herausgefiltert werden
**** Dann wird für alle Verkehrsmittel je ein Modell der Reisezeit in Abhängigkeit der Entfernung geschätzt
**** (lineare OLS-Regression mit in nichtlinear Spezifikation der Entfernungen) 
**** (Für den ÖV wird differenziert zwischen "schnellen" und "langsamen Direktverbindungen", und Verbindungen mit einem oder mehreren Umstiegen)
**** Hiermit werden dann für die gewählten und nicht gewählten Alternativen Reisezeiten abgeschätzt (predict xb)
**** Suche dann die am öftesten angegebene Pendeldistanz und das hauptsächlich genutzte Verkehrsmittel und reduzieren den Datensatz entsprechend
* Mobilitätspanel-Daten *
*! version 1.01  19oct2009
************************************************************************

************************************************************************
program define MOP_impute_altTravelTimes

di "schätze Reisezeiten bei Nutzung aller Verkehrsmittel-Alternativen"
quietly {
*** Sortiere Wege
sort JAHR ID PERSNR WOTAG WNRT

// Zweck z0 des vorherigen Weges am Tag
bysort JAHR ID PERSNR WOTAG: gen z0 = zweck[_n-1] if _n>1
label value z0 ZWECK
// Zweck z0woche des vorherigen Weges der Woche
bysort JAHR ID PERSNR: gen z0woche = zweck[_n-1] if _n>1
label value z0woche ZWECK

noi di "Markiere alle Wege Wohnung-Arbeit/Ausbildung und Arbeit/Ausbildung-Wohnung"
gen Arbeitsweg = ((zweck==1) & (WNRT==1 | (WNRT>1 & (z0woche==7|z0woche==77) ))) | (zweck==7 & (z0woche==1))
gen Ausbildungsweg = ((zweck==3) & (WNRT==1 | (WNRT>1 & (z0woche==7|z0woche==77) ))) | (zweck==7 & (z0woche==3))
gen AWeg = Arbeitsweg==1 | Ausbildungsweg

dropvars _merge
merge JAHR ID PERSNR using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_P0.dta", uniqusing sort keep(GEWHHPWO OEFFERR LAGEARB FUSSMIN PARKP)
drop _merge
sort JAHR ID PERSNR
merge JAHR ID using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_HH0.dta", uniqusing sort keep(GEWHHWO LAGE HALT*)
drop _merge
noi di "bilde Wegegewicht"
gen GEWHHPWEG = GEWHHPWO * cond(WEGGEW>=.,1,WEGGEW) * cond(KMGEW>=.,1,KMGEW) * cond(DATGEW>=.,1,DATGEW)  
egen meangew = mean(GEWHHPWEG)
gen weightHHPW = GEWHHPWEG/meangew 


preserve

rename KM km
rename VMDIW mode
MOP_gen_var_kmMinuten
label var mode5 "VM5"

constraint define 1 _ZUZEIT=1 
constraint define 2 _ABZEIT010=5
constraint define 3 _ABZEIT1020=15
constraint define 4 _ABZEIT20=25
constraint define 5 _km05WGRan _km05WGZen
constraint define 6 _kmWGRan=0
constraint define 7 _kmAPPer=0
constraint define 8 _km05APPer =0
constraint define 9 _km05WGRan = 0
constraint define 10 _km05ApMZen

noi di "schätze 'Reisezeit ÖPNV' in Abhängigkeit von 'Entfernung und Lage Wohnung/Arbeitsplatz'"
cnsreg Minute _kmD* _kmU*  _km05D* _km05U* _oUmst* _ZUZEIT _ABZEIT* _km05W* _km*AP* if mode5==3 & OEFFERR<5 & AWeg [pw=weightHHPW], constraint(1/4 5 7 8)
estimates store estMinOV
/*
twoway function y=.137*x+6.7*x^.5+8.1 ,range(0 100)|| function y=.38*x+6.5*x^.5+8.1 ,range(0 100)|| /*
*/ function y=.20*x+7.2*x^.5+8.1+5 ,range(0 100)|| function y=.27*x+7.06*x^.5+8.1+7.2,range(0 100) /*
*/ legend(label(1 "zügige Direktv") label(2 "langsame Direktv") label(3 "1* Umsteigen") label(4 "mehrf. Umsteigen"))
twoway function y=.54*x+3.5*x^.5+4.8 ,range(0 100)|| function y=.38*x+6.3*x^.5+8.1 ,range(0 100)|| /*
*/ function y=.15*x+7.95*x^.5+8.1+2.5 ,range(0 100)|| function y=.324*x+6.6*x^.5+8.1+7.2,range(0 100) || function y=(.54-.34)*x+(3.5+2.2)*x^.5+4.8 ,range(0 100) /*
*/ legend(label(1 "zügige Direktv") label(2 "langsame Direktv") label(3 "1* Umsteigen") label(4 "mehrf. Umsteigen") label(5 "direktInnenstadt"))
*/

noi di "schätze 'Reisezeit Fuss' in Abhängigkeit von 'Entfernung und Lage Wohnung'"
reg Minute km _km05 _km05WLand if mode5==1 & km<=3 & AWeg [pw=weightHHPW]
estimates store estMinFuss

/*
twoway function y=5.52*x+6.9*x^.5+.8 ,range(0 5) /*
*/ legend(label(1 "Fuss"))
*/

noi di "schätze 'Reisezeit Rad' in Abhängigkeit von 'Entfernung und Lage Wohnung'"
reg Minute km _km05 _kmGross if mode5==2 & km<=20 & AWeg [pw=weightHHPW]
estimates store estMinRad

/*
twoway function y=2.1*x+3.98*x^.5+1.46,range(0 30) /*
*/ legend(label(1 "Rad"))
*/

noi di "schätze 'Reisezeit Pkw' in Abhängigkeit von 'Entfernung und Lage Wohnung/Arbeitsplatz'"
reg Minute km _km05 _Park* _??Gr* _??Mz* _km05WLand if (mode5==5 | mode5==4) & km<=150 & AWeg [pw=weightHHPW]

estimates store estMinPkw
/*
twoway function y=(0.42)*x+(3.78)*x^.5+.5+1.9+2.8,range(0 100) || function y=(0.42)*x+(3.78-.24)*x^.5+.52,range(0 100) || function y=(0.42)*x+(3.78)*x^.5+.52+.38+1.5,range(0 100) /*
*/ legend(label(1 "Pkw GrossstadtZentrum") label(2 "Pkw Land") label(3 "Pkw MZKern") )
*/

restore

noi di "Suche die am öftesten in der Woche berichtete Entfernung zum Arbeitsplatz"
// die am öftesten genannte Pendlerdistanz für Arbeits-/Einkaufswege (zweck==1 oder 3) bzw. Rückwege (zweck == 7) von Arbeit oder Ausbildung
bysort JAHR ID PERSNR: egen KMoft = mode(KM) if AWeg , maxmode

gen typisch = ((abs(KM-KMoft)<1.5) | ((KM/KMoft) >.8 & (KM/KMoft<1.2)) & AWeg)
bysort JAHR ID PERSNR: egen AnzTypischerWege = total(typisch==1)

noi di "Suche die am öftesten in der Woche berichtete Pendelverkehrsmittel"
// das am öftesten genutzte Pendlerverkehrsmittel
bysort JAHR ID PERSNR: egen VMoft = mode(VMDIW) if AWeg & typisch & AnzTypischerWege>=4, maxmode

label values VMoft VM

noi di "Bilde mittlere Reisezeiten von allen Arbeitswegen,  denen Verkehrsmittel und Distanz dem Hauptverkehrsmittel/Pendeldistanz entspricht"
// die mittlere Dauer (mean) der Wege, bei denen Verkehrsmittel und Distanz dem Hauptverkehrsmittel/Pendeldistanz entspricht
bysort JAHR ID PERSNR: egen double Daueroft = mean(dauer) if AWeg & (VMDIW==VMoft & typisch) & AnzTypischerWege>=4
format Daueroft %tcHH:MM

noi di "Bilde eine Zeile pro Person mit Angaben zum Hauptpendelweg"
//Fasse Daten für eine Person zusammen
collapse (median)  km=KMoft mode=VMoft dauer=Daueroft, by(ID PERSNR JAHR)
format dauer %tcHH:MM

dropvars _merge
merge JAHR ID PERSNR using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_P0.dta", uniqusing sort keep(OEFFERR LAGEARB FUSSMIN PARKP)
drop _merge
sort JAHR ID PERSNR
merge JAHR ID using "$MOP_workingdir\Mobilitätsdaten\Long\MOP_HH0.dta", uniqusing sort keep(LAGE HALT*)
drop _merge


MOP_gen_var_kmMinuten
label var mode5 "Hauptpendel-VM"


noi di "imputiere Reisezeit mit alternativen Verkehrsmittel" 
estimates restore estMinOV
predict pMinOV
label var pMinOV "min OV"
estimates restore estMinFuss
predict pMinFuss
label var pMinFuss "min Fuss"
estimates restore estMinRad
predict pMinRad
label var pMinRad "min Rad"
estimates restore estMinPkw
predict pMinPkw
label var pMinPkw "min Pkw"
keep ID PERSNR JAHR Minute mode5 km dauer pMin*

}

end 
************************************************************************


