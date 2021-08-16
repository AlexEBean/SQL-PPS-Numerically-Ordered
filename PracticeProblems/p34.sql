SELECT c.CustomerID, c.CompanyName, o.OrderID, SUM(od.unitPrice * od.Quantity) AS TotalsWithoutDiscount, SUM(od.unitPrice * od.Quantity * (1-od.Discount)) AS TotalsWithDiscount
	FROM Customers c
    JOIN Orders o
    ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
    ON o.OrderID = od.OrderID
    WHERE OrderDate LIKE '2016%'
    GROUP BY c.CustomerID
    HAVING (TotalsWithDiscount >= 10000)
    ORDER BY TotalsWithDiscount DESC;


-- Using Implicit INNER JOIN

-- SELECT c.CustomerID, c.CompanyName, o.OrderID, SUM(od.unitPrice * od.Quantity) AS TotalsWithoutDiscount, SUM(od.unitPrice * od.Quantity * (1-od.Discount)) AS TotalsWithDiscount
--     FROM Customers c, Orders o, OrderDetails od
--     WHERE c.CustomerID = o.CustomerID
--        AND o.OrderID = od.OrderID
--        AND OrderDate LIKE '2016%'
--     GROUP BY c.CustomerID
--     HAVING (TotalsWithDiscount >= 10000)
--     ORDER BY TotalsWithDiscount DESC;