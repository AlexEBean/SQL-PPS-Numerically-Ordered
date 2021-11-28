SELECT 
	ProductID,
    ProductNumber,
    POSITION('-' IN ProductNumber) AS HyphenPosition,
	CASE 
		WHEN LOCATE('-', ProductNumber)
        THEN SUBSTR(ProductNumber, 1, POSITION('-' IN ProductNumber) - 1)
        ELSE ProductNumber
	END AS BaseProductNumber,
	CASE 
		WHEN LOCATE('-', ProductNumber)
        THEN SUBSTR(ProductNumber, POSITION('-' IN ProductNumber) + 1)
        ELSE NULL
	END AS Size
	FROM Product
    WHERE ProductID > 533;