WITH GroupingFlexible AS (SELECT 
	c.CustomerID, 
	c.CompanyName, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount
FROM customers c
JOIN orders o
	ON c.CustomerID = o.CustomerID
JOIN orderdetails od
	ON o.OrderID = od.OrderID
WHERE
    OrderDate >= '2016-01-01'
    AND OrderDate  < '2017-01-01'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY c.CustomerID
)

SELECT 
	g.CustomerID, 
	g.CompanyName, 
    g.TotalOrderAmount,
	cgt.CustomerGroupName AS CustomerGroup
    FROM GroupingFlexible g
    JOIN customergroupthresholds cgt
		ON g.TotalOrderAmount BETWEEN cgt.RangeBottom AND cgt.RangeTop
	ORDER BY c.CustomerID;