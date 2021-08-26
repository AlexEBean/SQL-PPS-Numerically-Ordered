-- Since this problem requires understanding p38, I did p38 first.  I later realized p38 was listed later on and reorganized accordingly.

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