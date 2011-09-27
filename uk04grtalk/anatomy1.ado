program anatomy1
    version 8.2

    use anatomy, replace

    line y1 x || line y2 x,  		           ///
         ylabel(1(1)6 ,  axis(1 2) gmax)           ///
         title(.Graph.Title)			   ///
         `0'
end
