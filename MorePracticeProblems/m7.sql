SELECT DATE_FORMAT(StartDate, '%Y/%m') AS ProductListPriceMonth, COUNT(DATE_FORMAT(StartDate, '%Y/%m')) AS TotalRows
	FROM ProductListPriceHistory
    GROUP BY DATE_FORMAT(StartDate, '%Y/%m');