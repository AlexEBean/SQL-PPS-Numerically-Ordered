-- Explicit

SELECT p.ProductID, p.ProductName, s.CompanyName AS Supplier
	FROM Products p
    JOIN Suppliers s
        ON p.SupplierID = s.SupplierID;

-- Implicit

SELECT p.ProductID, p.ProductName, s.CompanyName AS Supplier
	FROM Products p, Suppliers s
    WHERE p.SupplierID = s.SupplierID;