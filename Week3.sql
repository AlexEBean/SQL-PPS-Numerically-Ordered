-- 35

SELECT EmployeeID, OrderID, OrderDate
	FROM orders
    WHERE OrderDate = LAST_DAY(OrderDate)
    ORDER BY EmployeeID, OrderID;

-- 37

SELECT OrderID
	FROM orders
    ORDER BY RAND()
	LIMIT 10;
