SELECT c.CustomerID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, COUNT(DISTINCT soh.SalesPersonEmployeeID) AS TotalDifferentSalesPeople
	FROM customer c
    JOIN SalesOrderHeader soh
		ON c.CustomerID = soh.CustomerID
	GROUP By c.CustomerID
	HAVING COUNT(DISTINCT soh.SalesPersonEmployeeID) > 1
    ORDER BY CustomerName;