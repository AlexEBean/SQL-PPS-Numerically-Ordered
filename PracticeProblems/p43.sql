WITH LateOrders AS (
SELECT e.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, l.LastName, COUNT(*) AS AllOrders, l.TotalLateOrders AS LateOrders
	FROM orders o
    JOIN LateOrders l
		ON o.EmployeeID = l.EmployeeID
	GROUP BY EmployeeID
    ORDER BY EmployeeID;