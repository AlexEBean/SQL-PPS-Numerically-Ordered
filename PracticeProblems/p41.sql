SELECT OrderID, DATE(OrderDate) AS OrderDate, DATE(RequiredDate) AS RequiredDate, DATE(ShippedDate) AS ShippedDate
	FROM orders
    WHERE ShippedDate >= RequiredDate
    ORDER BY OrderID;

-- I don't think I need a subquery or CTE for this problem since I just need to compare two 
-- preexisting columns on a row-by-row basis.