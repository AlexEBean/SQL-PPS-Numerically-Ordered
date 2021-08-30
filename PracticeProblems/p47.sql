WITH TotalLateOrders AS (
SELECT e.EmployeeID, e.LastName, COUNT(*) AS LateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, 
		e.LastName, 
        COUNT(*) AS AllOrders, 
        IFNULL(LateOrders, 0) AS LateOrders, 
        ROUND(IFNULL(LateOrders, 0)/COUNT(*), 2) AS PercentLateOrders
	FROM orders o
    LEFT JOIN TotalLateOrders l
		ON o.EmployeeID = l.EmployeeID
	JOIN employees e
		ON e.EmployeeID = o.EmployeeID
	GROUP BY EmployeeID, LastName
    ORDER BY EmployeeID;