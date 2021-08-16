SELECT ProductID, ListPrice
	FROM ProductListPriceHistory
    WHERE EndDate IS NULL
    ORDER BY ProductID;