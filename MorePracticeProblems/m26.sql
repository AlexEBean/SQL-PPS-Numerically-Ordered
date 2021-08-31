WITH hyphen AS (
	SELECT p.ProductNumber, 
    CASE 
		WHEN LOCATE('-', p.productNumber)
        THEN SUBSTR(p.productNumber, 1, LOCATE('-', p.productNumber) - 1)
        ELSE p.ProductNumber
	END AS BaseProductNumber
    FROM product p 
)


SELECT h.BaseProductNumber, COUNT(*) AS TotalSizes
FROM product p
JOIN ProductSubCategory psc
	ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN ProductCategory pc
	ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN hyphen h
	ON p.ProductNumber = h.ProductNumber
WHERE pc.ProductCategoryID = 3
GROUP BY h.BaseProductNumber
ORDER BY h.BaseProductNumber;