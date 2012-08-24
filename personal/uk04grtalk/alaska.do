twoway area latitude longitude			 ///
	if !cpoint & (poly != 1 | mod(_n,5)==0), ///
	nodropbase  cmissing(no)		 ///
	bcolor("205 133 63") bfintensity(100)	 ///
	blwidth(vvvthin)			 ///
    ||						 ///
       sarrows lat_v long_v ,			 ///
	clcolor(white) clwidth(vthin)		 ///
	xscale(off) yscale(off)			 ///
	ylabel(, nogrid)			 ///
	graphregion(color("143 188 143"))	 ///
	plotregion(color( "143 188 143"))	 ///
	legend(off) xsize(4)
