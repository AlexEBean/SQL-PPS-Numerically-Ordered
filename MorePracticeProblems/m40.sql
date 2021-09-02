WITH DateDiffData AS (
	SELECT 
		p1.ProductID,
		p1.EndDate,
		p2.StartDate,
		MIN(DATEDIFF(p2.StartDate, p1.EndDate)) AS TimeDiff
		FROM ProductListPriceHistory p1
		JOIN ProductListPriceHistory p2
			ON p1.ProductID = p2.ProductID
            AND p2.StartDate > p1.EndDate
		GROUP BY ProductID, EndDate
)

SELECT 
	d.ProductID,
    c.CalendarDate AS DateWithMissingPrice
	FROM DateDiffData d
    JOIN Calendar c
		ON c.CalendarDate > d.EndDate
			AND c.CalendarDate < d.StartDate
    WHERE TimeDiff != 1
	ORDER BY d.ProductID, c.CalendarDate;