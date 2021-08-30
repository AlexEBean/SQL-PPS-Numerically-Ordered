SELECT EmployeeID, OrderID, OrderDate
	FROM orders
    WHERE OrderDate = LAST_DAY(OrderDate)
    ORDER BY EmployeeID;
