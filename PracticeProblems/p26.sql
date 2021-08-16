SELECT ShipCountry, AVG(CASE WHEN OrderDate LIKE '2015%' THEN Freight END) AS AverageFreight
	FROM orders
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;