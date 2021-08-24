SELECT ShipCountry, AVG(Freight) AS AverageFreight
	FROM orders
    WHERE OrderDate 
		BETWEEN (SELECT DATE_ADD(MAX(OrderDate), INTERVAL -12 MONTH) FROM Orders)
		AND (SELECT MAX(OrderDate) FROM Orders)
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;