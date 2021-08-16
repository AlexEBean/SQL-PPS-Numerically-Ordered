SELECT ProductID
	FROM ProductListPriceHistory
    WHERE EndDate IS NULL
    GROUP BY ProductID
    HAVING COUNT(*) > 1
    ORDER BY ProductID;