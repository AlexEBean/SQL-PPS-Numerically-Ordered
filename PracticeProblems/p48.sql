SELECT 
	c.CustomerID, 
	c.CompanyName, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount,
    CASE 
		WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 0 AND 1000
        THEN 'Low'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 1000 AND 5000
        THEN 'Medium'
        WHEN SUM(od.UnitPrice * od.Quantity) BETWEEN 5000 AND 10000
        THEN 'High'
        ELSE 'Very High'
	END AS CustomerGroup
FROM customers c
JOIN orders o
	ON c.CustomerID = o.CustomerID
JOIN orderdetails od
	ON o.OrderID = od.OrderID
WHERE
    OrderDate >= '2016-01-01'
    AND OrderDate  < '2017-01-01'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID;