SELECT p.ProductID, ProductName, p.ListPrice AS Prod_ListPrice, plph.ListPrice AS PriceHist_LatestListPrice, p.ListPrice - plph.ListPrice AS Diff
	FROM product p
    JOIN ProductListPriceHistory plph
		  ON p.ProductID = plph.ProductID
    WHERE p.ListPrice != plph.ListPrice AND plph.EndDate IS NULL;