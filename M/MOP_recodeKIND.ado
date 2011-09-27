********** Program zum Umcodieren der Kinder-Daten ************
*! version 1.01  10oct2009
************************************************************************

************************************************************************
program MOP_recodeKIND

di "codiere Kinder-Daten um"
quietly {
MOP_recodeP
dropvars ALTER
recode alter (0/9 = 0) (10/17=1) (18/105 = .b "Alter für Kind unplausibel") (106/.z = .c "unplausibel"),gen(ALTER)
label var ALTER Altersklasse
}

end
****************************************************************************