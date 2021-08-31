WITH OrdersByCountry AS ( 
    SELECT 
        ShipCountry,
        CustomerID, 
        OrderID, 
        DATE(OrderDate) AS OrderDate,
		ROW_NUMBER() 
			OVER (PARTITION BY ShipCountry 
					ORDER BY OrderID
				) AS RowNumberPerCountry
		FROM Orders 
) 

SELECT
    ShipCountry,
	CustomerID, 
	OrderID, 
	OrderDate
	FROM
		OrdersByCountry 
	WHERE 
		RowNumberPerCountry = 1 
	ORDER BY ShipCountry;