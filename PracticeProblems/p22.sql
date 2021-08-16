SELECT productID, ProductName, UnitsInStock, ReorderLevel
	FROM products
    WHERE UnitsInStock <= ReorderLevel
    ORDER BY ProductID;