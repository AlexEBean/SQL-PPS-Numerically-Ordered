WITH DuplicateData AS (
	SELECT
		ProductID,
		ROW_NUMBER() 
			OVER (
					PARTITION BY ProductName
				) AS RowCount,
		ProductName
		FROM product
)

SELECT 	
	ProductID AS PotentialDuplicateProductID,
    ProductName
    FROM DuplicateDAta
    WHERE RowCount > 1;