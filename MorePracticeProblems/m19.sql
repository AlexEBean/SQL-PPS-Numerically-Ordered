WITH RawMarginData AS (
	SELECT 
		ProductID, 
		ProductName, 
		StandardCost, 
		ListPrice,
		ListPrice - StandardCost AS RawMargin
		FROM product p
        WHERE StandardCost != 0
		ORDER BY ProductName
)

SELECT *, 
	NTILE(4) OVER (
        ORDER BY RawMargin DESC
    ) AS Quartile
	FROM RawMarginData
	ORDER BY ProductName;