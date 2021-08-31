-- 28

WITH MaxDate AS (
	SELECT MAX(OrderDate) AS LastDate
    FROM Orders
)

SELECT o.ShipCountry, AVG(o.Freight) AS AverageFreight
	FROM orders o
    JOIN MaxDate m
		ON OrderDate
			BETWEEN (DATE_ADD(m.LastDate, INTERVAL -12 MONTH))
			AND m.LastDate
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;

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

-- 39

WITH criteria AS (
	SELECT OrderID
			FROM OrderDetails
			WHERE Quantity >= 60
			GROUP BY OrderID, Quantity
			HAVING COUNT(*) > 1
)

SELECT DISTINCT *
	FROM  orderDetails od
    JOIN criteria c
		ON od.OrderID = c.OrderID
    ORDER BY od.OrderID, od.Quantity;

-- 40

WITH PotentialProblemOrders AS (
	Select
	 OrderID
	 From OrderDetails
	 Where Quantity >= 60
	 Group By OrderID, Quantity
	 Having Count(*) > 1
	)

Select
 DISTINCT OrderDetails.OrderID
 ,ProductID
 ,UnitPrice
 ,Quantity
 ,Discount
From OrderDetails 
 Join PotentialProblemOrders
 on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID;

-- 41

-- I don't think I need a subquery or CTE for this problem since I just need to compare two 
-- preexisting columns on a row-by-row basis.

SELECT OrderID, DATE(OrderDate) AS OrderDate, DATE(RequiredDate) AS RequiredDate, DATE(ShippedDate) AS ShippedDate
	FROM orders
    WHERE ShippedDate >= RequiredDate
    ORDER BY OrderID;

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

-- 55

WITH OrdersByCountry AS ( 
    SELECT 
        ShipCountry,
        CustomerID, 
        OrderID, 
        DATE(OrderDate) AS OrderDate,
		ROW_NUMBER() 
			OVER (PARTITION BY ShipCountry 
					ORDER BY OrderID
				) AS RowNumberPerCountry
		FROM Orders 
) 

SELECT
    ShipCountry,
	CustomerID, 
	OrderID, 
	OrderDate
	FROM
		OrdersByCountry 
	WHERE 
		RowNumberPerCountry = 1 
	ORDER BY ShipCountry;

-- More SQL (Second Problem Set)

-- 8

WITH dates AS (
	SELECT DISTINCT DATE_FORMAT(StartDate, '%Y/%m - %M') AS CalendarMonth, COUNT(*) AS TotalRows, StartDate
		FROM ProductListPriceHistory
        GROUP BY DATE_FORMAT(StartDate, '%Y/%m - %M')
),

minmax AS (
	SELECT MIN(d.StartDate) AS min, MAX(d.StartDate) AS max
    FROM dates d
)

SELECT DISTINCT DATE_FORMAT(c.CalendarDate, '%Y/%m - %M') AS CalendarMonth, IFNULL(d.TotalRows, 0) AS TotalRows
	FROM calendar c
    LEFT JOIN dates d
		ON DATE_FORMAT(c.CalendarDate, '%Y/%m - %M') = d.CalendarMonth
	JOIN minmax m
		ON c.CalendarDate
		BETWEEN m.min AND m.max;

-- 10

SELECT p.ProductID, p.ProductName
	FROM product p
    LEFT JOIN ProductListPriceHistory  plph
		ON p.ProductID = plph.ProductID
	WHERE plph.ProductID IS NULL
    ORDER BY p.ProductID;

-- I don't think I need a subquery or CTE for this problem since I just need to compare two 
-- preexisting columns on a row-by-row basis.

-- 19

WITH RawMarginData AS (
	SELECT 
		ProductID, 
		ProductName, 
		StandardCost, 
		ListPrice,
		ListPrice - StandardCost AS RawMargin
		FROM product p
        WHERE StandardCost != 0
		ORDER BY ProductName
)

SELECT *, 
	NTILE(4) OVER (
        ORDER BY RawMargin DESC
    ) AS Quartile
	FROM RawMarginData
	ORDER BY ProductName;

-- 23

WITH DuplicateData AS (
	SELECT
		ProductID,
		ROW_NUMBER() 
			OVER (
					PARTITION BY ProductName
				) AS RowCount,
		ProductName
		FROM product
)

SELECT 	
	ProductID AS PotentialDuplicateProductID,
    ProductName
    FROM DuplicateDAta
    WHERE RowCount > 1;

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

-- 27

SELECT 
	p.ProductID, 
    p.ProductName, 
    COUNT(DISTINCT pch.StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory pch
    JOIN product p
		ON pch.ProductID = p.ProductID
	GROUP BY pch.ProductID
    ORDER BY ProductID;

-- 28

WITH PriceDifferenceTable AS (
	SELECT 
		pch2.ProductID,
		pch2.StartDate AS CostChangeDate,
		pch2.StandardCost,
		pch1.StandardCost AS PreviousStandardCost,
		pch1.StandardCost - pch2.StandardCost AS PriceDifference
		FROM ProductCostHistory pch1
		JOIN ProductCostHistory pch2
			ON DATEDIFF(pch2.StartDate, pch1.EndDate) = 1 
				AND pch1.ProductID = pch2.ProductID
),

MaxDiffTable AS (
	SELECT
		ProductID,
		MAX(PriceDifference)
			OVER (
					PARTITION BY ProductID
			) AS PriceDifference
		FROM PriceDifferenceTable
        WHERE PriceDifference != 0
)
    SELECT
		DISTINCT p.ProductID,
        p.CostChangeDate,
        p.StandardCost,
        p.PreviousStandardCost,
        m.PriceDifference
		FROM PriceDifferenceTable p
        JOIN MaxDiffTable m
			ON p.ProductID = m.ProductID 
            AND p.PriceDifference = m.PriceDifference
        ORDER BY p.PriceDifference DESC, p.ProductID;

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