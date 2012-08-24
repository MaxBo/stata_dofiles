recode WECHSARB MOPED FAHRRAD BAHNCARD (-9=.a) if JAHR==2006
recode WECHSARB MOPED FAHRRAD (-9=.b) if (JAHR>=1994 & JAHR <=1996)
recode BAHNCARD (-9=.b) if (JAHR>=1994 & JAHR <=2000)
recode FSMOT(.=.b) if (JAHR>=2004 & JAHR <=2006)
recode ANORM* (2/7 = 1)
