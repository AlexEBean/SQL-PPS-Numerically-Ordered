SELECT DISTINCT CustomerID 
	FROM customers
    WHERE CustomerID  
		NOT IN
        (SELECT CustomerID 
			FROM orders
			WHERE EmployeeID = 4);