-- This does not work in MySQL, but would if MySQL used FULL OUTER JOIN

SELECT 
	IFNULL(s.country, c.country) AS Country, 
    IFNULL(s.TotalSuppliers, 0) AS TotalSuppliers, 
    IFNULL(c.TotalCustomers, 0) AS TotalCustomers
	FROM SuppliersTable s 
		FULL OUTER JOIN CustomersTable c 
			ON s.country = c.country
		ORDER BY IFNULL(s.country, c.country);

-- This works in its place

WITH SuppliersTable AS (
SELECT s.country AS Country, COUNT(*) AS TotalSuppliers
FROM suppliers s
	GROUP BY s.country
),

CustomersTable AS (
SELECT c.country AS Country, COUNT(*) AS TotalCustomers
FROM customers c
	GROUP BY c.country
)

SELECT 
	IFNULL(s.country, c.country) AS Country, 
    IFNULL(s.TotalSuppliers, 0) AS TotalSuppliers, 
    IFNULL(c.TotalCustomers, 0) AS TotalCustomers
	FROM SuppliersTable s 
		LEFT JOIN CustomersTable c 
			ON s.country = c.country
UNION
	SELECT 
		IFNULL(s.country, c.country) AS Country, 
		IFNULL(s.TotalSuppliers, 0) AS TotalSuppliers, 
		IFNULL(c.TotalCustomers, 0) AS TotalCustomers
		FROM SuppliersTable s 
			RIGHT JOIN CustomersTable c 
				ON s.country = c.country
ORDER BY country