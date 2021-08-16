SELECT e.EmployeeID, LastName, COUNT(OrderID) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    ORDER BY TotalLateOrders DESC;

-- It might help to specify that an order that has the same date between shipped and required still counts as late.