graph twoway scatter lexp gnppc if  dwater || 			///
	     scatter lexp gnppc if !dwater ,			///
	title("Life expectancy at birth")			///
	legend(							///
		title(Water safety rating)			///
		order(2 "Below average" 1 "Above average")	///
	)

