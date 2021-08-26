-- First Problem Set

-- 13

SELECT OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) AS TotalPrice
	FROM OrderDetails
    ORDER BY OrderId, ProductID;

-- 23

SELECT productID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
	FROM products
    WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 0
    ORDER BY ProductID;

-- 28

SELECT ShipCountry, AVG(Freight) AS AverageFreight
	FROM orders
    WHERE OrderDate 
		BETWEEN (SELECT DATE_ADD(MAX(OrderDate), INTERVAL -12 MONTH) FROM Orders)
		AND (SELECT MAX(OrderDate) FROM Orders)
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;
 
 -- 31

SELECT c.CustomerID, m.customerID
	FROM customers c
    LEFT JOIN 
		(SELECT o.CustomerID FROM Orders o
            WHERE o.EmployeeID = 4) AS m
		ON c.CustomerID = m.CustomerID
	WHERE m.CustomerID IS NULL;

-- 33

SELECT c.CustomerID, c.CompanyName, SUM(od.unitPrice * od.Quantity) AS TotalOrderAmount
	FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    WHERE OrderDate LIKE '2016%'
    GROUP BY c.CustomerID
    HAVING (TotalOrderAmount >= 15000)
    ORDER BY TotalOrderAmount DESC;

-- 34

SELECT 
    c.CustomerID, c.CompanyName, 
    SUM(od.unitPrice * od.Quantity) AS TotalsWithoutDiscount, 
    SUM(od.unitPrice * od.Quantity * (1-od.Discount)) AS TotalsWithDiscount
	FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    WHERE OrderDate LIKE '2016%'
    GROUP BY c.CustomerID
    HAVING (TotalsWithDiscount >= 10000)
    ORDER BY TotalsWithDiscount DESC;


-- More SQL (Second Problem Set)

-- 1

SELECT ProductID, COUNT(StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory
    GROUP BY ProductID
    ORDER BY ProductID;

-- 14

SELECT p.ProductID, p.ProductName, p.ListPrice AS Prod_ListPrice, plph.ListPrice AS PriceHist_LatestListPrice, p.ListPrice - plph.ListPrice AS Diff
	FROM product p
    JOIN ProductListPriceHistory plph
		ON p.ProductID = plph.ProductID
    WHERE p.ListPrice != plph.ListPrice AND plph.EndDate IS NULL
    ORDER BY p.ProductID;
