SELECT OrderID, COUNT(OrderId) AS TotalOrderDetails
	FROM orderDetails
    GROUP BY OrderID
    ORDER BY TotalOrderDetails DESC
    LIMIT 10;