SELECT ShipCountry, AVG(CASE WHEN OrderDate BETWEEN '2015-05-06 18:00:00' AND '2016-05-06 18:00:00' THEN Freight END) AS AverageFreight
	FROM orders
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;