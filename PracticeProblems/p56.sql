SELECT o.CustomerID, o.OrderID AS InitialOrderID, DATE(o.orderDate) AS InitialOrderDate, od.OrderID AS NextOrderID, DATE(od.OrderDate) AS NextOrderDate, DATEDIFF(od.OrderDate, o.OrderDate) AS DaysBetweenOrders
	FROM  customers c
    JOIN orders o
		ON c.CustomerID = o.CustomerID
	JOIN orders od
		ON o.CustomerID = od.CustomerID
	WHERE TIMESTAMPDIFF(SECOND, o.OrderDate, od.OrderDate) BETWEEN 1 AND 432000 OR DATEDIFF(od.OrderDate, o.OrderDate) = 5 OR (o.OrderDate = od.OrderDate AND o.OrderID != od.OrderID)
    GROUP BY o.OrderDate, od.OrderDate
	ORDER BY c.CustomerID, InitialOrderID;