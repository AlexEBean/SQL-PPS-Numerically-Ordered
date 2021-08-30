-- 1

SELECT ProductID, COUNT(StandardCost) AS TotalPriceChanges 
	FROM ProductCostHistory
    GROUP BY ProductID
    ORDER BY ProductID;

-- 2

SELECT CustomerID, COUNT(SalesOrderID) AS TotalOrders
	FROM SalesOrderHeader
    GROUP BY CustomerID
    ORDER BY TotalOrders DESC, CustomerID;

-- 3

SELECT ProductID, DATE(MIN(OrderDate)) AS FirstOrder, DATE(MAX(OrderDate)) AS LastOrder
	FROM SalesOrderDetail d
    JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	GROUP BY ProductID
    ORDER BY ProductID;

-- 4

SELECT p.ProductID, ProductName, DATE(MIN(h.OrderDate)) AS FirstOrder, DATE(MAX(h.OrderDate)) AS LastOrder
	FROM product p
    JOIN SalesOrderDetail d
		ON d.ProductID = p.ProductID
	JOIN SalesOrderHeader h 
		ON d.SalesOrderID = h.SalesOrderID
	GROUP BY ProductID
    ORDER BY ProductID;

-- 5

SELECT ProductID, StandardCost
	FROM ProductCostHistory
    WHERE '2012-04-15'
    BETWEEN StartDate 
		AND EndDate
    ORDER BY ProductID;

-- 6

SELECT ProductID, StandardCost
	FROM ProductCostHistory
    WHERE IF (
				EndDate IS NULL, 
                StandardCost,
                '2014-04-15' BETWEEN StartDate AND EndDate
			)
	GROUP BY ProductID
    ORDER BY ProductID;

-- 7

SELECT DATE_FORMAT(StartDate, '%Y/%m') AS ProductListPriceMonth, COUNT(DATE_FORMAT(StartDate, '%Y/%m')) AS TotalRows
	FROM ProductListPriceHistory
    GROUP BY DATE_FORMAT(StartDate, '%Y/%m');

-- 9

SELECT ProductID, ListPrice
	FROM ProductListPriceHistory
    WHERE EndDate IS NULL
    ORDER BY ProductID;

-- 10

SELECT p.ProductID, p.ProductName
	FROM product p
    LEFT JOIN ProductListPriceHistory  plph
		ON p.ProductID = plph.ProductID
	WHERE plph.ProductID IS NULL
    ORDER BY p.ProductID;

-- 12

SELECT ProductID
	FROM ProductListPriceHistory
    WHERE EndDate IS NULL
    GROUP BY ProductID
    HAVING COUNT(*) > 1
    ORDER BY ProductID;

-- 13

SELECT p.ProductID, ProductName, ProductSubCategoryName, DATE(MIN(h.OrderDate)) AS FirstOrder, DATE(MAX(h.OrderDate)) AS LastOrder
	FROM product p
    LEFT JOIN SalesOrderDetail d
		ON d.ProductID = p.ProductID
	LEFT JOIN SalesOrderHeader h 
		ON d.SalesOrderID = h.SalesOrderID
	LEFT JOIN ProductSubCategory psc
		ON p.ProductSubcategoryID = psc.ProductSubcategoryID
	GROUP BY ProductName
    ORDER BY ProductName;

-- 14

SELECT p.ProductID, ProductName, p.ListPrice AS Prod_ListPrice, plph.ListPrice AS PriceHist_LatestListPrice, p.ListPrice - plph.ListPrice AS Diff
	FROM product p
    JOIN ProductListPriceHistory plph
		ON p.ProductID = plph.ProductID
    WHERE p.ListPrice != plph.ListPrice AND plph.EndDate IS NULL
    ORDER BY ProductID;

-- 15

SELECT p.ProductID, DATE(OrderDate) AS OrderDate, ProductName, OrderQty AS Qty, DATE(SellStartDate) AS SellStartDate, DATE(SellEndDate) AS SellEndDate
	FROM product p
    JOIN SalesOrderDetail d
		ON p.ProductID = d.ProductID
	JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE OrderDate < SellStartDate OR SellEndDate < OrderDate
    ORDER BY p.ProductID, OrderDate;

-- 16

SELECT p.ProductID, DATE(h.OrderDate) AS OrderDate, d.OrderQty AS Qty, DATE(p.SellStartDate) AS SellStartDate, DATE(p.SellEndDate) AS SellEndDate, 
	CASE
		WHEN h.OrderDate < p.SellStartDate
        THEN 'Sold before start date'
        ELSE 'Sold after end date'
    END AS ProblemType
	FROM product p
    JOIN SalesOrderDetail d
		ON p.ProductID = d.ProductID
	JOIN SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE h.OrderDate < p.SellStartDate OR p.SellEndDate < h.OrderDate
    ORDER BY p.ProductID, h.OrderDate;

-- 18

Select
 Product.ProductID
 ,ProductName
 ,ProductSubCategoryName
 ,Date(Min(OrderDate)) as FirstOrder
 ,Date(Max(OrderDate)) as LastOrder
From Product
 Left Join SalesOrderDetail Detail
 on Product.ProductID = Detail.ProductID
 Left Join SalesOrderHeader Header
 on Header.SalesOrderID = Detail .SalesOrderID
 Left Join ProductSubCategory 
 on ProductSubCategory .ProductSubCategoryID = Product.ProductSubCategoryID
Where
 Color = 'Silver'
Group by
 Product.ProductID
 ,ProductName
 ,ProductSubCategoryName
Order by LastOrder desc;

-- The column name of color was coded as 'Color' in the WHERE Statement
-- It shouldn't be written as a string.

-- 20

SELECT c.CustomerID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, COUNT(DISTINCT soh.SalesPersonEmployeeID) AS TotalDifferentSalesPeople
	FROM customer c
    JOIN SalesOrderHeader soh
		ON c.CustomerID = soh.CustomerID
	GROUP By c.CustomerID
	HAVING COUNT(DISTINCT soh.SalesPersonEmployeeID) > 1
    ORDER BY CustomerName;

-- 21

Select
 Customer.CustomerID
 ,FirstName + ' ' + LastName as CustomerName
 ,OrderDate
 ,SalesOrderHeader.SalesOrderID 
 ,SalesOrderDetail.ProductID
 ,Product.ProductName
 ,LineTotal
From SalesOrderDetail
 Join Product
 on Product.ProductID = SalesOrderDetail .ProductID
 Join SalesOrderHeader
 on SalesOrderHeader .SalesOrderID = SalesOrderDetail .SalesOrderID
 Join Customer
 on Customer.CustomerID = SalesOrderHeader.CustomerID
Order by
 CustomerID
 ,OrderDate
Limit 100;

-- In line 9, SalesOrderHeader changed to SalesOrderDetail
-- In line 12, SalesOrderDetail changed to SalesOrderHeader

-- 22

SELECT ProductName
	FROM product
    GROUP BY ProductName
    HAVING COUNT(ProductName) > 1;

-- 24



-- 26



-- 29

