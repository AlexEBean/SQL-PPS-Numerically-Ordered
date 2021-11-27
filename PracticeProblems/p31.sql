SELECT c.CustomerID, m.customerID
	FROM customers c
    LEFT JOIN 
		(SELECT o.CustomerID FROM Orders o
            WHERE o.EmployeeID = 4) AS m
		ON c.CustomerID = m.CustomerID
	WHERE m.CustomerID IS NULL;


-- Using CTE

WITH MargaretOrders AS (
	SELECT 
		o.CustomerID 
		FROM Orders o
        WHERE o.EmployeeID = 4
)

SELECT c.CustomerID, m.customerID
	FROM customers c
    LEFT JOIN 
		 MargaretOrders m
		ON c.CustomerID = m.CustomerID
	WHERE m.CustomerID IS NULL;