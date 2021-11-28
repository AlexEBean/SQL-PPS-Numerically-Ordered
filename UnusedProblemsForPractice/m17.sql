WITH TimeComponentOrderCount AS (
	SELECT COUNT(*) AS TotalOrderWithTime
	FROM  SalesOrderHeader
    WHERE OrderDate NOT LIKE '%00:00:00'
)

SELECT 
	TotalOrderWithTime, 
	COUNT(*) AS TotalOrders,
    TotalOrderWithTime / COUNT(*) AS PercentOrdersWithTime
		FROM  SalesOrderHeader soh, TimeComponentOrderCount;