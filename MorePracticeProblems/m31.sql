SELECT 
	c.CalendarDate,
	plph1.ProductID,
	COUNT(*) + 1 AS TotalRows
	FROM ProductListPriceHistory plph1
	JOIN ProductListPriceHistory plph2
		ON 
			(plph2.StartDate < plph1.EndDate OR plph1.EndDate IS NULL)
			AND (plph2.EndDate > plph1.StartDate OR plph2.EndDate IS NULL)
			AND plph1.ProductID = plph2.ProductID
			AND (
				plph1.StartDate != plph2.StartDate 
				OR plph1.EndDate != plph2.EndDate
				)
	JOIN calendar c
		ON 
			c.CalendarDate BETWEEN plph2.StartDate AND plph1.EndDate
				AND plph2.StartDate < plph1.EndDate
	GROUP BY ProductID, CalendarDate
	ORDER BY ProductID, CalendarDate;