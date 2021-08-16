SELECT p.ProductID, DATE(OrderDate) AS OrderDate, OrderQty AS Qty, DATE(SellStartDate) AS SellStartDate, DATE(SellEndDate) AS SellEndDate, 
	CASE
		WHEN OrderDate < SellStartDate
        THEN 'Sold before start date'
        ELSE 'Sold after end date'
    END AS ProblemType
	FROM product p
    JOIN SalesOrderDetail d
		ON p.ProductID = d.ProductID
	JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE OrderDate < SellStartDate OR SellEndDate < OrderDate
    ORDER BY p.ProductID, OrderDate;