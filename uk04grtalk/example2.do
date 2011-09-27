graph twoway scatter lexp gnppc if  dwater || 			///
	     scatter lexp gnppc if !dwater ,			///
	title("Continent", size(small))				///
	legend(							///
		title(Water safety rating)			///
		order(2 "Below average" 1 "Above average")	///
	)							///
	by(region , title("Life expectancy at birth"))
