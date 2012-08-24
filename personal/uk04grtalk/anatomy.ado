program anatomy
    version 8.2

    use anatomy, replace

    line y1 x || line y2 x,  		           ///
         text(1.9 3.5 ".Graph.plotregion1.plot1",  ///
	      just(center) color(navy))		   ///
         text(4.5 2.9 ".Graph.plotregion1.plot2",  ///
              just(center) color(maroon))          ///
         text(5.7 2.5 ".Graph.plotregion1" ,       ///
              just(center) size(5))                ///
         ylabel(1(1)6 ,  axis(1 2) gmax)           ///
         ytitle(.Graph.yaxis1.title)               ///
         xtitle(.Graph.xaxis1.title)               ///
         title(.Graph.title {c -} .Graph.title.style) ///
	 subtitle(.Graph.subtitle)		   ///
         note(.Graph.note)			   ///
	 caption(.Graph.caption)		   ///
         legend(order(1 ".keys[1]" 2 ".keys[2]")   ///
    		title(.Graph.legend,		   ///
		size(medlarge)))		   ///
         `0'
end
