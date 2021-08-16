-- Explicit

SELECT e.EmployeeID, e.LastName, o.OrderID, p.ProductName, od.Quantity
	FROM Employees e
    JOIN Orders o
		ON e.EmployeeID = o.EmployeeID
	JOIN OrderDetails od
		ON o.OrderID = od.OrderID
	JOIN Products p
		ON od.ProductID = p.ProductID
	ORDER BY o.OrderID, p.ProductID;

-- Implicit

SELECT e.EmployeeID, e.LastName, o.OrderID, p.ProductName, od.Quantity
	FROM Employees e, Orders o, OrderDetails od, Products p
    WHERE e.EmployeeID = o.EmployeeID
		AND o.OrderID = od.OrderID
		AND od.ProductID = p.ProductID
	ORDER BY o.OrderID, p.ProductID;