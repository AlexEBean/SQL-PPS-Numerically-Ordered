WITH dates AS (
	SELECT DISTINCT DATE_FORMAT(StartDate, '%Y/%m - %M') AS CalendarMonth, COUNT(*) AS TotalRows, StartDate
		FROM ProductListPriceHistory
        GROUP BY DATE_FORMAT(StartDate, '%Y/%m - %M')
),

minmax AS (
	SELECT MIN(d.StartDate) AS min, MAX(d.StartDate) AS max
    FROM dates d
)

SELECT DISTINCT DATE_FORMAT(c.CalendarDate, '%Y/%m - %M') AS CalendarMonth, IFNULL(d.TotalRows, 0) AS TotalRows
	FROM calendar c
    LEFT JOIN dates d
		ON DATE_FORMAT(c.CalendarDate, '%Y/%m - %M') = d.CalendarMonth
	JOIN minmax m
		ON c.CalendarDate
		BETWEEN m.min AND m.max;