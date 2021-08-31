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

-- 43

WITH LateOrders AS (
SELECT e.EmployeeID, LastName, COUNT(*) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, LastName, COUNT(*) AS AllOrders, TotalLateOrders AS LateOrders
	FROM orders o
    JOIN LateOrders l
		ON o.EmployeeID = l.EmployeeID
	GROUP BY EmployeeID, LastName
    ORDER BY EmployeeID;

-- 44

WITH LateOrders AS (
SELECT e.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, e.LastName, COUNT(*) AS AllOrders, l.TotalLateOrders AS LateOrders
	FROM orders o
    LEFT JOIN LateOrders l
		ON o.EmployeeID = l.EmployeeID
	JOIN employees e
		ON e.EmployeeID = o.EmployeeID
	GROUP BY EmployeeID, LastName
    ORDER BY EmployeeID;

-- 45

WITH LateOrders AS (
SELECT e.EmployeeID, e.LastName, COUNT(*) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, e.LastName, COUNT(*) AS AllOrders, IFNULL(l.TotalLateOrders, 0) AS LateOrders
	FROM orders o
    LEFT JOIN LateOrders l
		ON o.EmployeeID = l.EmployeeID
	JOIN employees e
		ON e.EmployeeID = o.EmployeeID
	GROUP BY EmployeeID, LastName
    ORDER BY EmployeeID;

-- 46

WITH TotalLateOrders AS (
SELECT e.EmployeeID, e.LastName, COUNT(*) AS LateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, 
		e.LastName, 
        COUNT(*) AS AllOrders, 
        IFNULL(LateOrders, 0), 
        IFNULL(LateOrders, 0)/COUNT(*) AS PercentLateOrders
	FROM orders o
    LEFT JOIN TotalLateOrders l
		ON o.EmployeeID = l.EmployeeID
	JOIN employees e
		ON e.EmployeeID = o.EmployeeID
	GROUP BY EmployeeID, LastName
    ORDER BY EmployeeID;

-- 47

WITH TotalLateOrders AS (
SELECT e.EmployeeID, e.LastName, COUNT(*) AS LateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    )
    
SELECT o.EmployeeID, 
		e.LastName, 
        COUNT(*) AS AllOrders, 
        IFNULL(LateOrders, 0) AS LateOrders, 
        ROUND(IFNULL(LateOrders, 0)/COUNT(*), 2) AS PercentLateOrders
	FROM orders o
    LEFT JOIN TotalLateOrders l
		ON o.EmployeeID = l.EmployeeID
	JOIN employees e
		ON e.EmployeeID = o.EmployeeID
	GROUP BY EmployeeID, LastName
    ORDER BY EmployeeID;

-- 48

SELECT 
	c.CustomerID, 
	c.CompanyName, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount,
    CASE 
		WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 0 AND 1000
        THEN 'Low'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 1000 AND 5000
        THEN 'Medium'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 5000 AND 10000
        THEN 'High'
        ELSE 'Very High'
	END AS CustomerGroup
FROM customers c
JOIN orders o
	ON c.CustomerID = o.CustomerID
JOIN orderdetails od
	ON o.OrderID = od.OrderID
WHERE
    OrderDate >= '2016-01-01'
    AND OrderDate  < '2017-01-01'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID;

-- 49

SELECT 
	c.CustomerID, 
	c.CompanyName, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount,
    CASE 
		WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 0 AND 1000
        THEN 'Low'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 1000 AND 5000
        THEN 'Medium'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 5000 AND 10000
        THEN 'High'
        ELSE 'Very High'
	END AS CustomerGroup
FROM customers c
JOIN orders o
	ON c.CustomerID = o.CustomerID
JOIN orderdetails od
	ON o.OrderID = od.OrderID
WHERE
    OrderDate >= '2016-01-01'
    AND OrderDate  < '2017-01-01'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID;

-- 50

WITH CustomerGrouping AS (
SELECT 
	c.CustomerID, 
	c.CompanyName, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount,
    CASE 
		WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 0 AND 1000
        THEN 'Low'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 1000 AND 5000
        THEN 'Medium'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 5000 AND 10000
        THEN 'High'
        ELSE 'Very High'
	END AS CustomerGroup
FROM customers c
JOIN orders o
	ON c.CustomerID = o.CustomerID
JOIN orderdetails od
	ON o.OrderID = od.OrderID
WHERE
    OrderDate >= '2016-01-01'
    AND OrderDate  < '2017-01-01'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID
    )
    
SELECT 
	cg.CustomerGroup, 
	COUNT(*) AS TotalInGroup, 
    COUNT(*)/(SELECT COUNT(*) FROM CustomerGrouping) AS PercentageInGroup
	FROM CustomerGrouping cg
    JOIN customers c
		ON cg.CustomerID = c.CustomerID
	GROUP BY cg.CustomerGroup
    ORDER BY TotalInGroup DESC;

-- 51

WITH GroupingFlexible AS (SELECT 
	c.CustomerID, 
	c.CompanyName, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount
FROM customers c
JOIN orders o
	ON c.CustomerID = o.CustomerID
JOIN orderdetails od
	ON o.OrderID = od.OrderID
WHERE
    OrderDate >= '2016-01-01'
    AND OrderDate  < '2017-01-01'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID
)

SELECT 
	g.CustomerID, 
	g.CompanyName, 
    g.TotalOrderAmount,
	cgt.CustomerGroupName AS CustomerGroup
    FROM GroupingFlexible g
    JOIN customergroupthresholds cgt
		ON g.TotalOrderAmount BETWEEN cgt.RangeBottom AND cgt.RangeTop
	ORDER BY c.CustomerID;

-- 53

WITH FirstTable AS (
SELECT s.country AS SupplierCountry, c.country AS CustomerCountry
FROM customers c
	LEFT JOIN suppliers s
		ON c.country = s.country
),

SecondTable AS (
SELECT s.country AS SupplierCountry, c.country AS CustomerCountry
FROM customers c
	RIGHT JOIN suppliers s
		ON c.country = s.country
)

SELECT *
	FROM FirstTable
UNION
SELECT *
	FROM SecondTable
ORDER BY IFNULL(SupplierCountry, CustomerCountry);

-- More SQL (Second Problem Set)

-- 24

WITH Changes AS (
SELECT ProductID, COUNT(StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory
    GROUP BY ProductID
    ORDER BY ProductID
)

SELECT TotalPriceChanges, COUNT(*) AS TotalProducts
	FROM Changes
    GROUP BY TotalPriceChanges
    ORDER BY TotalPriceChanges;

-- 26

WITH hyphen AS (
	SELECT p.ProductNumber, 
    CASE 
		WHEN LOCATE('-', p.productNumber)
        THEN SUBSTR(p.productNumber, 1, LOCATE('-', p.productNumber) - 1)
        ELSE p.ProductNumber
	END AS BaseProductNumber
    FROM product p 
)


SELECT h.BaseProductNumber, COUNT(*) AS TotalSizes
FROM product p
JOIN ProductSubCategory psc
	ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN ProductCategory pc
	ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN hyphen h
	ON p.ProductNumber = h.ProductNumber
WHERE pc.ProductCategoryID = 3
GROUP BY h.BaseProductNumber
ORDER BY h.BaseProductNumber;

-- 29

USE auticon_more_sql_problems;

with FraudSuspects as (
 Select *
 From Customer
 Where
 CustomerID in (
 29401
 ,11194
 ,16490
 ,22698
 ,26583
 ,12166
 ,16036
 ,25110
 ,18172
 ,11997
 ,26731
 )
)
, SampleCustomers as (
 Select *
 From Customer
 Where
 CustomerID not in (
	SELECT CustomerID
    FROM FraudSuspects
 )
 Order by
 Rand()
 Limit 100
)
Select * From FraudSuspects
Union all
Select * From SampleCustomers;

-- I used a subquery rather than har-coding the list again