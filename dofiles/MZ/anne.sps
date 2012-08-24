* HOMOGENISIERUNG WZ02 2008 gesamt

STRING WZ02_2008 (A8) .
RECODE
  EF120
  (20='02')  (50='03')  (102='05')  (111='06')  (112='09')  (159='11')
 (160='12')  (182='14')  (221='58')  (222='18')  (232='19')  (244='21')
 (296='25')  (297='27')  (300='28')  (333='33')  (361='31')  (410='36')
 (451='43')  (452='42')  (505='47')  (527='95')  (633='79')  (634='52')
 (641='53')  (643='60')  (660='65')  (701='41')  (721='62')  (722='58')
 (723='63')  (724='58')  (725='33')  (726='62')  (921='59')  (922='60')
 (923='90')  (924='63')  (925='91')  (930='96')  (950='97')  (990='99')
 (741='69')  (744='73')  (745='78')  (746='80')  (747='81')  (748='74')
 (851='86')  (852='75')  (853='87')  (900='37')  (11 thru 14='01')  (141
  thru 145='08')  (151 thru 158='10')  (171 thru 177='13')  (192 thru 193='1'+
 '5')  (201 thru 205='16')  (211 thru 212='17')  (241 thru 243='20')  (245
  thru 247='20')  (251 thru 252='22')  (261 thru 268='23')  (271 thru 274='2'+
 '4')  (275 thru 287='25')  (291 thru 295='28')  (311 thru 313='26')  (314
  thru 316='27')  (321 thru 332='26')  (334 thru 335='32')  (341 thru 343='2'+
 '9')  (351 thru 355='30')  (362 thru 366='32')  (371 thru 372='38')  (401
  thru 403='35')  (453 thru 454='43')  (501 thru 504='45')  (511 thru 519='4'+
 '6')  (521 thru 526='47')  (551 thru 552='55')  (553 thru 555='56')  (601
  thru 602='49')  (611 thru 612='50')  (621 thru 622='51')  (631 thru 632='5'+
 '2')  (651 thru 652='64')  (671 thru 672='66')  (702 thru 703='68')  (711
  thru 714='77')  (926 thru 927='93')  (731 thru 732='72')  (742 thru 743='7'+
 '1')  (751 thru 753='84')  (801 thru 804='85')  (911 thru 913='94')  (ELSE=''+
 'x')  INTO  WZ02_2008 .
EXECUTE .

 * UMCODIERUNG BRANCHE

STRING Branche_IHK (A8) .
RECODE
 EF120 (SYSMIS='kb') (410='E') (721='M') (725='S') (726='J') (851='Q') (852='M') (853='Q') (900='E') (930='S') (950='T') (990='U') (11 thru 50='A') (101 thru 145='B') (151 thru 212='C') (221 thru 222='J') (231 thru 366='C') (371 thru 372='E') (401
thru 403='D') (451 thru 454='F') (501 thru 527='G') (551 thru 555='I') (601 thru 634='H') (641 thru 643='J') (651 thru 672='K') (701 thru 703='L') (711 thru 714='N') (722 thru 724='J') (731 thru 744='M') (745 thru 748='N') (751 thru 753='O') (801 thru
804='P') (911 thru 913='S') (921 thru 922='J') (923 thru 927='R') (ELSE='X') INTO Branche_IHK.
EXECUTE.

STRING IHK_Aggregat (A8) .
RECODE 
Branche_IHK ('A'='A') ('B'='BF') ('C'='BF') ('D'='BF') ('E'='BF') ('F'='BF') ('G'='GI') ('H'='GI') ('I'='GI') ('J'='JN') ('K'='JN') ('L'='JN') ('M'='JN') ('N'='JN') ('O'='OQ') ('P'='OQ') ('Q'='OQ') ('R'='RU')
('S'='RU') ('x'='SYSMIS')
('T'='RU') ('U'='RU') INTO IHK_Aggregat.
VARIABLE LABELS  IHK_Aggregat 'IHK_Aggregat'.
EXECUTE.

* Definition SVB *

RECODE EF117 (1 thru 4=0) (5 thru 8=1) (9 thru 11=0) (ELSE=SYSMIS) INTO SVB. 
EXECUTE.

* Definition geringfügig *

RECODE EF82 (1=1) (ELSE=0) INTO GB. 
EXECUTE.

* Auswahl NS *

COMPUTE filter_$=(EF1 = 3). 
VARIABLE LABEL filter_$ 'EF1 = 3 (FILTER)'.  
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMAT filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE.

 * SVB Branchen *

CROSSTABS
  /TABLES=SVB BY Branche_IHK
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.

 * GERINGFÜGIG BESCHÄFTIGTE Branchen *

CROSSTABS
  /TABLES=GB BY Branche_IHK
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.

 * SVB Aggregate *

CROSSTABS
  /TABLES=SVB BY IHK_Aggregat
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.

 * GERINGFÜGIG BESCHÄFTIGTE Aggregate *

CROSSTABS
  /TABLES=GB BY IHK_Aggregat
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.
