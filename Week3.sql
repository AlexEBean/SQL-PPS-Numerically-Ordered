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



-- 49



-- 50



-- 51


-- 53



-- More SQL (Second Problem Set)

-- 24



-- 26



-- 29

