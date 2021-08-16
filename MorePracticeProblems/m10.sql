SELECT p.ProductID, p.ProductName
	FROM product p
    LEFT JOIN ProductListPriceHistory  plph
		ON p.ProductID = plph.ProductID
	WHERE plph.ProductID IS NULL
    ORDER BY p.ProductID;