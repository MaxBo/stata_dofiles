
twoway fn normden(x), range(-4 1.93) recast(area) || ///
       fn normden(x), range(1.99 4)  recast(area)    ///
	  bcolor(red) 				  || ///
       scatteri .02 2.2 .07 2.8 , recast(line)	     ///
	  clcolor(black)			  || ///
       scatteri .07 2.8 "2.5%" , msymbol(none)       ///
	  mlabcolor(black) mlabposition(2)	     ///
	  legend(nodraw)		     	     ///
	  ytitle(Density) xtitle(Z-statistic)	     ///
	  xlabel(-1.96 0 1.96, tlength(0))	     ///
	  ylabel(, nogrid angle(horizontal))	     ///
	  plotregion(margin(b=0))		     ///
	  graphregion(color(white))		     ///
	  title(Standard Normal Density)
