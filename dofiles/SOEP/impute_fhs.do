use "Y:\data\pw\soep\proj\Pers\Pers-custom.dta", clear
xtset persnr year,yearly

// Führerscheinbesitz bei Jugendlichen
replace pfhspkw=0 if age<17
replace pfhslkw=0 if age<18
replace pfhsmoped=0 if age<16
replace pfhsmotrad=0 if age<18

drop if year==1997|year==2000|year==2002|year>2003
sort persnr year
//Pkw-Führerschein imputieren
by persnr (year): replace pfhspkw=pfhspkw[_n+1] if (pfhspkw>=. & pfhspkw[_n-1]==pfhspkw[_n+1] & _n!=1 & _n !=_N)

//Lappen temporär weg???
by persnr (year): gen  fhs_weg = 0 if (pfhspkw[_n-1]==1 | pfhspkw==1 | pfhspkw[_n+1] ==1 & _n!=1 & _n !=_N)
by persnr (year): replace fhs_weg = 1 if (pfhspkw[_n-1]==1 & pfhspkw==0 & pfhspkw[_n+1] ==1 & _n!=1 & _n !=_N)

//Führerschein imputieren
by persnr (year): replace pfhs=pfhs[_n+1] if (pfhs>=. & pfhs[_n-1]==pfhs[_n+1] & _n!=1 & _n !=_N)

tab year  pfhspkw,row
tab year  pfhs,row
drop if pfhspkw>=.
xttrans pfhspkw,freq
sort persnr year
by persnr (year): gen fhserwerb1 = (pfhspkw==0 & pfhspkw[_n-1]==1 & _n!=1)
by persnr (year): gen fhserwerb0 = (pfhspkw[_n+1]==0 & pfhspkw==1 & _n!=_N)
by persnr (year): gen zeitraum = (year[_n+1]-year)
tab age fhserwerb0 
tab age fhserwerb1 
tab sex fhserwerb0 
tab sex fhserwerb1 



//fillin persnr year


preserve
drop if pfhs>=.
xttrans pfhs,freq
sort persnr year
by persnr (year): gen fhserwerb1 = (pfhs==0 & pfhs[_n-1]==1 & _n!=1)
by persnr (year): gen fhserwerb0 = (pfhs[_n+1]==0 & pfhs==1 & _n!=_N)
restore


drop if pfhspkw>=.
xttrans pfhspkw,freq
sort persnr year
by persnr (year): gen fhserwerb1 = (pfhspkw==1 & pfhspkw[_n-1]==0 & _n!=1)
by persnr (year): gen fhserwerb0 = (pfhspkw[_n+1]==1 & pfhspkw==0 & _n!=_N)
by persnr (year): gen zeitraum = (year[_n+1]-year)
tab age fhserwerb0 
tab age fhserwerb1 
sum zeitraum 
sum zeitraum if fhserwerb0==1

restore

preserve
drop if ppkwverf>=.
xttrans ppkwverf,freq
restore

preserve
drop if povzeitk>=.
xttab povzeitk
xttrans povzeitk,freq
restore

preserve
drop if pautobeg>=.
xttab pautobeg
xttrans pautobeg,freq
restore

preserve
drop if povungern>=.
xttab povungern
xttrans povungern,freq
restore

preserve
drop if pumwelt>=.
xttab pumwelt
xttrans pumwelt,freq
restore

preserve
drop if pfreiz>=.
xttab pfreiz
xttrans pfreiz,freq
restore



