SELECT p.ProductID, DATE(OrderDate) AS OrderDate, ProductName, OrderQty AS Qty, DATE(SellStartDate) AS SellStartDate, DATE(SellEndDate) AS SellEndDate
	FROM product p
    JOIN SalesOrderDetail d
		ON p.ProductID = d.ProductID
	JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE OrderDate < SellStartDate OR SellEndDate < OrderDate
    ORDER BY p.ProductID, OrderDate;