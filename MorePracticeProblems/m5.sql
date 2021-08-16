SELECT ProductID, StandardCost
	FROM ProductCostHistory
    WHERE '2012-04-15'
    BETWEEN StartDate 
		AND EndDate
    ORDER BY ProductID;