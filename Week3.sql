-- 35

SELECT EmployeeID, OrderID, OrderDate
	FROM orders
    WHERE OrderDate = LAST_DAY(SUBSTR(OrderDate, 1, 10))
    ORDER BY EmployeeID;

-- 37

SELECT OrderID
	FROM orders
    ORDER BY RAND()
	LIMIT 10;
