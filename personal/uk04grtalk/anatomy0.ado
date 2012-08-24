program anatomy0
    version 8.2

    use anatomy, replace

    line y1 x if _n < 0 ,		        ///
         title(.Graph.title)			///
	 xtitle("") ytitle("")			///
         text(5.7 2.5 ".Graph.plotregion1" ,    ///
              just(center) size(5))  
end
