SELECT d.ProductID, ProductName, DATE(MIN(OrderDate)) AS FirstOrder, DATE(MAX(OrderDate)) AS LastOrder
	FROM SalesOrderDetail d
    JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	JOIN product p
		ON d.ProductID = p.ProductID
	GROUP BY ProductID
    ORDER BY ProductID;


-- This is easier to work from for m13 in Outer-Joins

SELECT p.ProductID, ProductName, DATE(MIN(h.OrderDate)) AS FirstOrder, DATE(MAX(h.OrderDate)) AS LastOrder
	FROM product p
    JOIN SalesOrderDetail d
		ON d.ProductID = p.ProductID
	JOIN SalesOrderHeader h 
		ON d.SalesOrderID = h.SalesOrderID
	GROUP BY ProductID
    ORDER BY ProductID;