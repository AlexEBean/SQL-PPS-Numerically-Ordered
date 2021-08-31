SELECT ShipCountry, AVG(Freight) AS AverageFreight
	FROM orders
    WHERE OrderDate 
		BETWEEN (SELECT DATE_ADD(MAX(OrderDate), INTERVAL -12 MONTH) FROM Orders)
		AND (SELECT MAX(OrderDate) FROM Orders)
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;

  -- Faster with CTE

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