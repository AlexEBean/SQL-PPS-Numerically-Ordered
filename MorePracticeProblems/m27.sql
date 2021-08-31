SELECT 
	p.ProductID, 
    p.ProductName, 
    COUNT(DISTINCT pch.StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory pch
    JOIN product p
		ON pch.ProductID = p.ProductID
	GROUP BY pch.ProductID
    ORDER BY ProductID;