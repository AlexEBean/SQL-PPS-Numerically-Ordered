SELECT OrderID
	FROM OrderDetails
	WHERE Quantity >= 60
    GROUP BY OrderID, Quantity
	HAVING COUNT(*) > 1
    ORDER BY OrderID;