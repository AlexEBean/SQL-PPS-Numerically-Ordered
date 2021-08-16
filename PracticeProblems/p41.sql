SELECT OrderID, DATE(OrderDate) AS OrderDate, DATE(RequiredDate) AS RequiredDate, DATE(ShippedDate) AS ShippedDate
	FROM orders
    WHERE DATE(ShippedDate) > DATE(RequiredDate)
    ORDER BY OrderID;