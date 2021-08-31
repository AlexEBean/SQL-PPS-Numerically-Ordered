WITH PriceDifferenceTable AS (
	SELECT 
		pch2.ProductID,
		pch2.StartDate AS CostChangeDate,
		pch2.StandardCost,
		pch1.StandardCost AS PreviousStandardCost,
		pch1.StandardCost - pch2.StandardCost AS PriceDifference
		FROM ProductCostHistory pch1
		JOIN ProductCostHistory pch2
			ON DATEDIFF(pch2.StartDate, pch1.EndDate) = 1 
				AND pch1.ProductID = pch2.ProductID
),

MaxDiffTable AS (
	SELECT
		ProductID,
		MAX(PriceDifference)
			OVER (
					PARTITION BY ProductID
			) AS PriceDifference
		FROM PriceDifferenceTable
        WHERE PriceDifference != 0
)
    SELECT
		DISTINCT p.ProductID,
        p.CostChangeDate,
        p.StandardCost,
        p.PreviousStandardCost,
        m.PriceDifference
		FROM PriceDifferenceTable p
        JOIN MaxDiffTable m
			ON p.ProductID = m.ProductID 
            AND p.PriceDifference = m.PriceDifference
        ORDER BY p.PriceDifference DESC, p.ProductID;