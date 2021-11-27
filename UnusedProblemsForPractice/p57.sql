-- WORK-IN-PROGRESS

SELECT 
	InitialOrder.CustomerID, 
	DATE(InitialOrder.orderDate) AS InitialOrderDate, 
	DATE(NextOrder.OrderDate) AS NextOrderDate,
     OVER (PARTITION BY CustomerID
		ORDER BY InitialOrder.OrderID
					
				) AS DaysBetweenOrders
    FROM  customers c
    JOIN orders initialOrder
		ON c.CustomerID = InitialOrder.CustomerID
	JOIN orders NextOrder
		ON InitialOrder.CustomerID = NextOrder.CustomerID
	ORDER BY c.CustomerID, InitialOrder.orderDate;