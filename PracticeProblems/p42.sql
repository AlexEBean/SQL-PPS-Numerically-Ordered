SELECT e.EmployeeID, LastName, COUNT(OrderID) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    ORDER BY TotalLateOrders DESC;