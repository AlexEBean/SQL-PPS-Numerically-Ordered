SELECT p.ProductID, ProductName, ProductSubCategoryName, DATE(MIN(h.OrderDate)) AS FirstOrder, DATE(MAX(h.OrderDate)) AS LastOrder
	FROM SalesOrderDetail d
    LEFT JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	RIGHT JOIN product p
		ON d.ProductID = p.ProductID
	LEFT JOIN ProductSubCategory psc
		ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	GROUP BY ProductName
    ORDER BY ProductName;


-- I like the following better since it's easier for me to read

SELECT p.ProductID, ProductName, ProductSubCategoryName, DATE(MIN(h.OrderDate)) AS FirstOrder, DATE(MAX(h.OrderDate)) AS LastOrder
	FROM product p
    LEFT JOIN SalesOrderDetail d
		ON d.ProductID = p.ProductID
	LEFT JOIN SalesOrderHeader h 
		ON d.SalesOrderID = h.SalesOrderID
	LEFT JOIN ProductSubCategory psc
		ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	GROUP BY ProductName
    ORDER BY ProductName;