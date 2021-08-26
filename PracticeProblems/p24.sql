SELECT CustomerID, CompanyName, Region
	FROM customers
    ORDER BY Region IS NULL, region, CustomerID;

-- More explicit way of writing this

SELECT
  CustomerID,
  CompanyName,
  Region
FROM Customers
 ORDER BY
  CASE
    WHEN Region IS NULL THEN 1
    ELSE 0
  END,
  Region,
  CustomerID