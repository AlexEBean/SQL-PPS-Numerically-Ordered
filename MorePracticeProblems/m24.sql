WITH Changes AS (
SELECT COUNT(StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory
    GROUP BY ProductID
)

SELECT TotalPriceChanges, COUNT(*) AS TotalProducts
	FROM Changes
    GROUP BY TotalPriceChanges
    ORDER BY TotalPriceChanges;