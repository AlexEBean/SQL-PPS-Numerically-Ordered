SELECT ProductID, DATE(MIN(OrderDate)) AS FirstOrder, DATE(MAX(OrderDate)) AS LastOrder
	FROM SalesOrderDetail d
    JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	GROUP BY ProductID
    ORDER BY ProductID;