SELECT ProductID, StandardCost
	FROM ProductCostHistory
    WHERE IF (
				EndDate IS NULL, 
                StandardCost,
                '2014-04-15' BETWEEN StartDate AND EndDate
			)
	GROUP BY ProductID
    ORDER BY ProductID;