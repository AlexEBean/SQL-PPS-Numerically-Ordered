SELECT Country, City, COUNT(Country AND City) AS TotalCustomers
	FROM customers
    GROUP BY Country, City
    ORDER BY TotalCustomers DESC;