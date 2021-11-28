SELECT DISTINCT
	ProductID
	FROM ProductCostHistory
	WHERE ProductID 
		NOT IN (
			SELECT 
			ProductID
			FROM ProductCostHistory
			WHERE 
				'2014-04-15' BETWEEN StartDate AND IFNULL(EndDate, NOW())
    )
    ORDER BY ProductID;