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