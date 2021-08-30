WITH FirstTable AS (
SELECT s.country AS SupplierCountry, c.country AS CustomerCountry
FROM customers c
	LEFT JOIN suppliers s
		ON c.country = s.country
),

SecondTable AS (
SELECT s.country AS SupplierCountry, c.country AS CustomerCountry
FROM customers c
	RIGHT JOIN suppliers s
		ON c.country = s.country
)

SELECT *
	FROM FirstTable
UNION
SELECT *
	FROM SecondTable
ORDER BY IFNULL(SupplierCountry, CustomerCountry);