SELECT OrderID
	FROM OrderDetails
	WHERE Quantity >= 60
    GROUP BY OrderID, Quantity
	HAVING count(*) > 1
    ORDER BY OrderID;