SELECT *
	FROM  orderDetails
    WHERE OrderID IN (
		SELECT OrderID
			FROM OrderDetails
			WHERE Quantity >= 60
			GROUP BY OrderID, Quantity
			HAVING COUNT(*) > 1
    )
    ORDER BY OrderID, Quantity;

-- CTE

WITH criteria AS (
	SELECT OrderID
			FROM OrderDetails
			WHERE Quantity >= 60
			GROUP BY OrderID, Quantity
			HAVING COUNT(*) > 1
)

SELECT DISTINCT *
	FROM  orderDetails od
    JOIN criteria c
		ON od.OrderID = c.OrderID
    ORDER BY od.OrderID, od.Quantity;