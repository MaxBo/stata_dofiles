gen Zuordnung = 3 if KRS_HVV==1


 
replace Zuordnung = 5 if KRS_HVV>=6
replace Zuordnung = 7 if KRS_HVV>1 & KRS_HVV<=5

label define Zuordnung 3 `"Hamburg"' 5 `"Nieders�chsische Landkreise in der MRH (Cuxhaven, Stade, Rotenburg (W�mme), Harburg, L�neburg, Uelzen und L�chow Dannenberg)"' 7 `"Schleswig-holsteinische Landkreise in der MRH (Dithmarschen, Steinburg, Pinneberg, Segeberg, Stormarn und Herzogtum Lauenburg)"'
label value Zuordnung Zuordnung


label variable Zuordnung `"Ortszuweisung"'