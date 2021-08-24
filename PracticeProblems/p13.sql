SELECT OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) AS TotalPrice
	FROM OrderDetails
    ORDER BY OrderId, ProductID;