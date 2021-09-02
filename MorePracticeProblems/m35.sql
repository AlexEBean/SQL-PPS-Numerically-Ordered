WITH LastOrder AS (
	SELECT 
		c.CustomerID,
		CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
		MAX(h.OrderDate) AS OrderDate,
        h.SalesOrderID
		FROM customer c
		JOIN SalesOrderHeader h
			USING(CustomerID)
		WHERE c.CustomerID 
			IN (19500, 19792, 24409, 26785)
		GROUP BY c.CustomerID
),

MaxLastOrder AS (
	SELECT 
		l.CustomerID,
		l.CustomerName,
		MAX(d.UnitPrice) AS MaxPrice
		FROM LastOrder l
		JOIN SalesOrderDetail d
			USING(SalesOrderID)
		JOIN Product p
			USING(ProductID)
		GROUP BY l.CustomerName
)

SELECT 
	DISTINCT m.CustomerID,
    m.CustomerName,
    psc.ProductSubCategoryName
	FROM MaxLastOrder m
    JOIN SalesOrderDetail d
		ON m.MaxPrice = d.UnitPrice
    JOIN Product p
		USING(ProductID)
    JOIN ProductSubCategory psc
		USING(ProductSubCategoryID)
	ORDER BY m.CustomerID