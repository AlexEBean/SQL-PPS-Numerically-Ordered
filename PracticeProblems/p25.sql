SELECT ShipCountry, AVG(Freight) AS AverageFreight
	FROM orders
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;