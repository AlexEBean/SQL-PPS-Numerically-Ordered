SELECT o.CustomerID, o.OrderID AS InitialOrderID, DATE(o.orderDate) AS InitialOrderDate, od.OrderID AS NextOrderID, DATE(od.OrderDate) AS NextOrderDate, DATEDIFF(od.OrderDate, o.OrderDate) AS DaysBetweenOrders
	FROM  customers c
    JOIN orders o
		ON c.CustomerID = o.CustomerID
	JOIN orders od
		ON o.CustomerID = od.CustomerID
	WHERE TIMESTAMPDIFF(SECOND, o.OrderDate, od.OrderDate) BETWEEN 1 AND 432000 OR DATEDIFF(od.OrderDate, o.OrderDate) = 5 OR (o.OrderDate = od.OrderDate AND o.OrderID != od.OrderID)
    GROUP BY o.OrderDate, od.OrderDate
	ORDER BY c.CustomerID, InitialOrderID;

-- Simpler and easier to read solution

SELECT 
	InitialOrder.CustomerID, 
	InitialOrder.OrderID AS InitialOrderID, 
	DATE(InitialOrder.orderDate) AS InitialOrderDate, 
	NextOrder.OrderID AS NextOrderID, 
	DATE(NextOrder.OrderDate) AS NextOrderDate, 
	DATEDIFF(NextOrder.OrderDate, InitialOrder.OrderDate) AS DaysBetweenOrders
	FROM  customers c
    JOIN orders initialOrder
		ON c.CustomerID = InitialOrder.CustomerID
	JOIN orders NextOrder
		ON InitialOrder.CustomerID = NextOrder.CustomerID
	WHERE InitialOrder.OrderID < NextOrder.OrderID
        AND DATEDIFF(NextOrder.OrderDate,
            InitialOrder.OrderDate) <= 5
	ORDER BY c.CustomerID, InitialOrderID;