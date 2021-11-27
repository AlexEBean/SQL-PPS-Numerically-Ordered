SELECT OrderID, CustomerID, ShipCountry
	FROM orders
    WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium';


-- This also works. 

SELECT OrderID, CustomerID, ShipCountry
	FROM orders
    WHERE ShipCountry IN ('France', 'Belgium');
