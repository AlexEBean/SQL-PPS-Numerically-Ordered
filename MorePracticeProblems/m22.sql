SELECT ProductName
	FROM product
    GROUP BY ProductName
    HAVING COUNT(ProductName) > 1;