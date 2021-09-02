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

-- 30

SELECT 
    c.CalendarDate,
    plph1.ProductID,
    COUNT(*) AS TotalRows
	FROM ProductListPriceHistory plph1
	JOIN ProductListPriceHistory plph2
		ON 
			plph2.StartDate < plph1.EndDate
			AND plph2.EndDate > plph1.StartDate
            AND plph1.ProductID = plph2.ProductID
            AND (
				plph1.StartDate != plph2.StartDate 
				OR plph1.EndDate != plph2.EndDate
				)
	JOIN calendar c
		ON c.CalendarDate 
			BETWEEN plph2.StartDate AND plph1.EndDate
            AND c.CalendarDate BETWEEN plph1.StartDate AND plph2.EndDate
	GROUP BY ProductID, CalendarDate
    ORDER BY ProductID, CalendarDate;

-- 31

SELECT 
	c.CalendarDate,
	plph1.ProductID,
	COUNT(*) + 1 AS TotalRows
	FROM ProductListPriceHistory plph1
	JOIN ProductListPriceHistory plph2
		ON 
			(plph2.StartDate < plph1.EndDate OR plph1.EndDate IS NULL)
			AND (plph2.EndDate > plph1.StartDate OR plph2.EndDate IS NULL)
			AND plph1.ProductID = plph2.ProductID
			AND (
				plph1.StartDate != plph2.StartDate 
				OR plph1.EndDate != plph2.EndDate
				)
	JOIN calendar c
		ON 
			c.CalendarDate BETWEEN plph2.StartDate AND plph1.EndDate
				AND plph2.StartDate < plph1.EndDate
	GROUP BY ProductID, CalendarDate
	ORDER BY ProductID, CalendarDate;

-- 32

WITH LastYearOrders AS (
SELECT DISTINCT DATE_FORMAT(OrderDate, '%Y/%m - %M') AS CalendarMonth,
		COUNT(*) AS TotalOrders
	FROM SalesOrderHeader
    WHERE OrderDate 
		BETWEEN (SELECT DATE_ADD(MAX(OrderDate), INTERVAL -12 MONTH) FROM SalesOrderHeader)
		AND (SELECT MAX(OrderDate) FROM SalesOrderHeader)
	GROUP BY CalendarMonth
	)

SELECT 
	*,
    (@RunningTotal := @RunningTotal + TotalOrders) AS RunningTotal
    FROM LastYearOrders;

-- 33

WITH TotalOrdersTable AS (
	SELECT 
		soh.TerritoryID,
		st.TerritoryName,
		st.CountryCode,
		COUNT(*) AS TotalOrders
		FROM SalesOrderHeader soh
		JOIN SalesTerritory st
			USING(TerritoryID)
		GROUP BY soh.TerritoryID
)
    
SELECT 
	t.TerritoryID,
	t.TerritoryName,
	t.CountryCode,
    t.TotalOrders,
    COUNT(*) AS TotalLateOrders
	FROM TotalOrdersTable t
    JOIN SalesOrderHeader s
		ON t.TerritoryID = s.TerritoryID
        WHERE s.DueDate < s.ShipDate
	GROUP BY t.TerritoryID
    ORDER BY t.TerritoryID;

-- 35

WITH LastOrder AS (
	SELECT 
		c.CustomerID,
		CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
		MAX(h.OrderDate) AS OrderDate,
        h.SalesOrderID
		FROM customer c
		JOIN SalesOrderHeader h
			USING(CustomerID)
		WHERE c.CustomerID 
			IN (19500, 19792, 24409, 26785)
		GROUP BY c.CustomerID
),

MaxLastOrder AS (
	SELECT 
		l.CustomerID,
		l.CustomerName,
		MAX(d.UnitPrice) AS MaxPrice
		FROM LastOrder l
		JOIN SalesOrderDetail d
			USING(SalesOrderID)
		JOIN Product p
			USING(ProductID)
		GROUP BY l.CustomerName
)

SELECT 
	DISTINCT m.CustomerID,
    m.CustomerName,
    psc.ProductSubCategoryName
	FROM MaxLastOrder m
    JOIN SalesOrderDetail d
		ON m.MaxPrice = d.UnitPrice
    JOIN Product p
		USING(ProductID)
    JOIN ProductSubCategory psc
		USING(ProductSubCategoryID)
	ORDER BY m.CustomerID

-- 36

SELECT 
	o1.SalesOrderID, 
	e.EventName, 
    DATE_FORMAT(o1.EventDateTime, '%Y-%m-%d %h:%i') AS TrackingEventDate, 
    DATE_FORMAT(o2.EventDateTime, '%Y-%m-%d %h:%i') AS NextTrackingEventDate,
    TIMESTAMPDIFF(HOUR, o1.EventDateTime, o2.EventDateTime) AS HoursInStage
	FROM OrderTracking o1
	JOIN TrackingEvent e
		USING(TrackingEventID)
    LEFT JOIN OrderTracking o2
		ON o1.SalesOrderID = o2.SalesOrderID
        AND o1.TrackingEventID + 1 = o2.TrackingEventID
    WHERE o1.SalesOrderID
		IN (68857, 70531, 70421)
	ORDER BY o1.SalesOrderID;

-- 37

WITH HourDiffTest AS (
	SELECT 
		CASE
			WHEN OnlineOrderFlag = 1
			THEN 'Online'
			ELSE 'Offline'
		END AS OnlineOfflineStatus,
		e.EventName,
		TIMESTAMPDIFF(HOUR, o1.EventDateTime, o2.EventDateTime) AS HoursDiff,
        e.TrackingEventID,
        s.SalesOrderID
		FROM OrderTracking o1
		JOIN TrackingEvent e
			USING(TrackingEventID)
		JOIN SalesOrderHeader s
			USING(SalesOrderID)
		LEFT JOIN OrderTracking o2
			ON o1.SalesOrderID = o2.SalesOrderID
				AND o1.TrackingEventID != o2.TrackingEventID
),

ProcessingInfo AS (
	SELECT
		OnlineOfflineStatus,
		EventName,
		MIN(
			CASE 
				 WHEN HoursDiff > 0
				 THEN HoursDiff
				 ELSE NULL
			END
            ) AS HoursInStage,
        TrackingEventID
		FROM HourDiffTest
		GROUP BY OnlineOfflineStatus, SalesOrderID, TrackingEventID
)

SELECT 
	OnlineOfflineStatus,
    EventName,
    AVG(HoursInStage) AS AverageHoursSpentInStage
    FROM ProcessingInfo
    GROUP BY OnlineOfflineStatus, TrackingEventID
    ORDER BY OnlineOfflineStatus, TrackingEventID;

-- 38

WITH HourDiffTest AS (
	SELECT 
		CASE
			WHEN OnlineOrderFlag = 1
			THEN 'Online'
			ELSE 'Offline'
		END AS OnlineOfflineStatus,
		e.EventName,
		TIMESTAMPDIFF(HOUR, o1.EventDateTime, o2.EventDateTime) AS HoursDiff,
        e.TrackingEventID,
        s.SalesOrderID
		FROM OrderTracking o1
		JOIN TrackingEvent e
			USING(TrackingEventID)
		JOIN SalesOrderHeader s
			USING(SalesOrderID)
		LEFT JOIN OrderTracking o2
			ON o1.SalesOrderID = o2.SalesOrderID
				AND o1.TrackingEventID != o2.TrackingEventID
),

ProcessingInfo AS (
	SELECT
		OnlineOfflineStatus,
		EventName,
		MIN(
			CASE 
				 WHEN HoursDiff > 0
				 THEN HoursDiff
				 ELSE NULL
			END
            ) AS HoursInStage,
        TrackingEventID
		FROM HourDiffTest
		GROUP BY OnlineOfflineStatus, SalesOrderID, TrackingEventID
),

OfflineAggregateData AS (
	SELECT 
		EventName,
		AVG(HoursInStage) AS OfflineAvgHoursInStage,
        TrackingEventID
		FROM ProcessingInfo
        WHERE OnlineOfflineStatus = 'Offline'
		GROUP BY TrackingEventID
),

OnlineAggregateData AS (
	SELECT 
		EventName,
		AVG(HoursInStage) AS OnlineAvgHoursInStage,
        TrackingEventID
		FROM ProcessingInfo
        WHERE OnlineOfflineStatus = 'Online'
		GROUP BY TrackingEventID
)

SELECT 
	ofd.EventName,
    ofd.OfflineAvgHoursInStage,
    ond.OnlineAvgHoursInStage
	FROM OfflineAggregateData ofd
    JOIN OnlineAggregateData ond
		USING(EventName)
	ORDER BY ofd.TrackingEventID;

-- 39

WITH BaseData AS (
	SELECT 
		c.CustomerID,
		CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
		psc.ProductSubCategoryName,
		sod.LineTotal
		FROM customer c
		JOIN SalesOrderHeader soh
			USING(CustomerID)
		JOIN SalesOrderDetail sod
			USING(SalesOrderID)
		JOIN product p
			USING(ProductID)
		JOIN ProductSubCategory psc
			USING(ProductSubCategoryID)
		WHERE c.CustomerID
			IN(13763, 13836, 20331, 21113, 26313)
),

TopSubData1 AS (
	SELECT 
		CustomerID,
        CustomerName,
        MAX(LineTotal),
        ProductSubCategoryName AS TopProdSubCat1
        FROM BaseData
        GROUP BY CustomerID
), 

TopSubData2 AS (
	SELECT 
		t2.CustomerID,
        t2.CustomerName,
        MAX(LineTotal),
        t1.TopProdSubCat1,
        t2.ProductSubCategoryName AS TopProdSubCat2
        FROM BaseData t2
        JOIN TopSubData1 t1
			USING(CustomerID)
		WHERE t2.ProductSubCategoryName != t1.TopProdSubCat1
        GROUP BY CustomerID
),

TopSubData3 AS (
	SELECT 
		t3.CustomerID,
		t3.CustomerName,
		MAX(LineTotal),
		t2.TopProdSubCat1,
		t2.TopProdSubCat2,
		t3.ProductSubCategoryName AS TopProdSubCat3
		FROM BaseData t3
		JOIN TopSubData2 t2
			USING(CustomerID)
		WHERE t3.ProductSubCategoryName NOT IN (t2.TopProdSubCat1, t2.TopProdSubCat2)
		GROUP BY CustomerID
)

SELECT 
	t2.CustomerID,
    t2.CustomerName,
    t2.TopProdSubCat1,
    t2.TopProdSubCat2,
    t3.TopProdSubCat3
	FROM TopSubData2 t2
    LEFT JOIN TopSubData3 t3
		USING(CustomerID)
	ORDER BY CustomerID;

-- 40

WITH DateDiffData AS (
	SELECT 
		p1.ProductID,
		p1.EndDate,
		p2.StartDate,
		MIN(DATEDIFF(p2.StartDate, p1.EndDate)) AS TimeDiff
		FROM ProductListPriceHistory p1
		JOIN ProductListPriceHistory p2
			ON p1.ProductID = p2.ProductID
            AND p2.StartDate > p1.EndDate
		GROUP BY ProductID, EndDate
)

SELECT 
	d.ProductID,
    c.CalendarDate AS DateWithMissingPrice
	FROM DateDiffData d
    JOIN Calendar c
		ON c.CalendarDate > d.EndDate
			AND c.CalendarDate < d.StartDate
    WHERE TimeDiff != 1
	ORDER BY d.ProductID, c.CalendarDate;

-- Resolve with CTE instead of subqueries

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