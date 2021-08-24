SELECT ShipCountry, AVG(CASE WHEN OrderDate LIKE '2015%' THEN Freight END) AS AverageFreight
	FROM orders
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;

-- Shouldn't use conditional logic withing aggrage function unless absolutely needed
-- It's unnecessary to convert OrderDate into a string using LIKE
-- The following answer is faster since it doesn't require converting OrderDate

SELECT
    ShipCountry,
    AVG(freight) AS AverageFreight
FROM Orders
WHERE
    OrderDate >= '2015-01-01'
    AND OrderDate  < '2016-01-01'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;