
****Äquivalenzeinkommen bilden***
* Quelle der Wete des Äquivalenzeinkommens  http://www.destatis.de/jetspeed/portal/cms/Sites/destatis/Internet/DE/Content/Statistiken/Bevoelkerung/MigrationIntegration/Migrationshintergrund/Begriffserlaeuterungen/Aequivalenzeinkommen,templateId=renderPrint.psml
* Statistisches Bundesamt: Der erste Erwachsene geht mit dem Gewicht 1, Kinder unter 14 Jahren mit dem Gewicht 0,3 und weitere Personen über 14 Jahren mit dem Gewicht 0,5 ein.

****2011***

gen hheink1 = .a
local a = 100
local i = 1
foreach b of numlist 500 900 1500 2000 2600 3000 3600 4000 4600 5000 5600 6000 6600 7000 30000 {
	replace hheink1 = `a' + (`b'-`a')*runiform() if HHEINK == `i'
	local i = `i' + 1
	local a = `b'
	}


gen HHGRue14 = H02-HHGR14
gen n_persons = 1 + (HHGRue14 - 1)*0.5 + HHGR14*0.3 if HHGRue14>0

gen pinc = hheink1 / n_persons
centile pinc, centile(5(10)95)

recode pinc (0/499.99999999=1 "unter 500 Euro") (500/899.999999=2 "500-900 Euro") (900/1499.999999=3 "900-1500 Euro") (1500/1999.99999=4 "1500-2000 Euro") (2000/2600.9999999=5 "2000-2600 Euro") (2600/3000.99999999999=6 "2600-3000 Euro") (3001/3600.999999999999=7 "3000-3600 Euro") (3600/max=8 "3600 und mehr pro Monat"), gen (hheink_aeq)
 
 ***4 Klassen***
 recode pinc (0/999.9999=1 "unter 1000 Euro") (1000/1499.99999=2 "1000-1500 Euro") (1500/1999.999999=3 "1500-2000 Euro") (2000/max=4 "über 2000 Euro"), gen (hheink_aeq4) 
 
 *****2002
 gen hheink1 = .a
local a = 100
local i = 1
foreach b of numlist 500 900 1500 2000 2600 3000 3600 6000 {
	replace hheink1 = `a' + (`b'-`a')*runiform() if hheink == `i'
	local i = `i' + 1
	local a = `b'
	}


gen HHGRue14 = h02-hhgr14
gen n_persons = 1 + (HHGRue14 - 1)*0.5 + hhgr14*0.3 if HHGRue14>0

gen pinc = hheink1 / n_persons
centile pinc, centile(5(10)95)

recode pinc (0/499.99999999=1 "unter 500 Euro") (500/899.999999=2 "500-900 Euro") (900/1499.999999=3 "900-1500 Euro") (1500/1999.99999=4 "1500-2000 Euro") (2000/2600.9999999=5 "2000-2600 Euro") (2600/3000.99999999999=6 "2600-3000 Euro") (3001/3600.999999999999=7 "3000-3600 Euro") (3600/max=8 "3600 und mehr pro Monat"), gen (hheink_aeq)
 
 ***4 Klassen***
recode pinc (0/999.9999=1 "unter 1000 Euro") (1000/1499.99999=2 "1000-1500 Euro") (1500/1999.999999=3 "1500-2000 Euro") (2000/max=4 "über 2000 Euro"), gen (hheink_aeq4) 
 
