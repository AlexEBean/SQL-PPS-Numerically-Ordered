-- Explicit

SELECT o.OrderID, o.OrderDate, s.CompanyName AS Supplier
	FROM Orders o
    JOIN Shippers s
        ON o.ShipVia = s.ShipperID
    WHERE OrderID < 10270
    ORDER BY OrderID;

-- Implicit

SELECT o.OrderID, o.OrderDate, s.CompanyName AS Supplier
	FROM Orders o, Shippers s
    WHERE o.ShipVia = s.ShipperID
    WHERE OrderID < 10270
    ORDER BY OrderID;