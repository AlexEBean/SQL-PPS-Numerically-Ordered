SELECT ProductID, COUNT(StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory
    GROUP BY ProductID;