clear
sysuse auto
keep if foreign
sort weight

gen weight2 = weight^2
regress mpg weight weight2
predict fit
predict se , stdp

#delimit ;
twoway sc mpg weight , pstyle(p3) ms(o)					||
       fn weight[3]  - 1000 * normden(x, `=fit[3]' , `=se[3]') , 
		range(`=fit[3] -5' `=fit[3] +5') horiz pstyle(p1)	||
       fn `=fit[3]' , range(`=weight[3]' `=weight[3]-1000*normden(0, se[3])')
       		      pstyle(p1)					||
       fn weight[17] - 1000 * normden(x, `=fit[17]', `=se[17]') , 
       		range(`=fit[17]-5' `=fit[17]+5') horiz pstyle(p1)	||
       fn `=fit[17]', range(`=weight[17]' `=weight[17]-1000*normden(0, se[17])')
       		      pstyle(p1)					||
       fn weight[21] - 1000 * normden(x, `=fit[21]' , `=se[21]') , 
       		range(`=fit[21] -7' `=fit[21] +7') horiz pstyle(p1)	||
       fn `=fit[21]', range(`=weight[21]' `=weight[21]-1000*normden(0, se[21])')
       		      pstyle(p1)					||
       line fit weight
	, clwidth(*2) legend(off) ytitle(Miles per gallon) xtitle(Weight)
	  title("Scatter with Regression Line and Confidence Interval Densities"
	  , size(4.8) margin(t=0 b=1.5) span)
;
#delimit cr
