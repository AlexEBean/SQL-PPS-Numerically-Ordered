WITH TotalOrdersTable AS (
	SELECT 
		soh.TerritoryID,
		st.TerritoryName,
		st.CountryCode,
		COUNT(*) AS TotalOrders
		FROM SalesOrderHeader soh
		JOIN SalesTerritory st
			USING(TerritoryID)
		GROUP BY soh.TerritoryID
)
    
SELECT 
	t.TerritoryID,
	t.TerritoryName,
	t.CountryCode,
    t.TotalOrders,
    COUNT(*) AS TotalLateOrders
	FROM TotalOrdersTable t
    JOIN SalesOrderHeader s
		ON t.TerritoryID = s.TerritoryID
        WHERE s.DueDate < s.ShipDate
	GROUP BY t.TerritoryID
    ORDER BY t.TerritoryID;