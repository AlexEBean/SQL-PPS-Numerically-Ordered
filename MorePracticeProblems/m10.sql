SELECT p.ProductID, p.ProductName
	FROM product p
    LEFT JOIN ProductListPriceHistory  plph
		ON p.ProductID = plph.ProductID
	WHERE plph.ProductID IS NULL
    ORDER BY p.ProductID;

-- I don't think I need a subquery or CTE for this problem since I just need to compare two 
-- preexisting columns on a row-by-row basis.