SELECT productID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
	FROM products
    WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 0;