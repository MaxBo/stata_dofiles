gen altersgruppe = 1 if alter<20
replace altersgruppe = 2 if alter <30 & alter >=20
replace altersgruppe = 3 if alter <40 & alter >=30
replace altersgruppe = 4 if alter <50 & alter >=40
replace altersgruppe = 5 if alter <60 & alter >=50
replace altersgruppe = 6 if alter <70 & alter >=60
replace altersgruppe = 7 if alter <80 & alter >=70
replace altersgruppe = 8 if alter <90 & alter >=80
replace altersgruppe = 9 if alter <100 & alter >=90


gen altersgruppe2 = 1 if alter<25
replace altersgruppe2 = 2 if alter <45 & alter >=25
replace altersgruppe2 = 3 if alter <65 & alter >=45
replace altersgruppe2 = 4 if alter <100 & alter >=65


* für anova, regression und sonstige teststatistik