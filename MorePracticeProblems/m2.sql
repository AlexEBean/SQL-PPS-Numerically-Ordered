SELECT CustomerID, COUNT(SalesOrderID) AS TotalOrders
	FROM SalesOrderHeader
    GROUP BY CustomerID
    ORDER BY TotalOrders DESC, CustomerID;