SELECT p.ProductID, DATE(h.OrderDate) AS OrderDate, d.OrderQty AS Qty, DATE(p.SellStartDate) AS SellStartDate, DATE(p.SellEndDate) AS SellEndDate, 
	CASE
		WHEN h.OrderDate < p.SellStartDate
        THEN 'Sold before start date'
        ELSE 'Sold after end date'
    END AS ProblemType
	FROM product p
    JOIN SalesOrderDetail d
		ON p.ProductID = d.ProductID
	JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE h.OrderDate < p.SellStartDate OR p.SellEndDate < h.OrderDate
    ORDER BY p.ProductID, h.OrderDate;