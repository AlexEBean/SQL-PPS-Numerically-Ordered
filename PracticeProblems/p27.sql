10806


-- This code helped me find it.
SELECT
 OrderID, OrderDate, ShipCountry
FROM Orders
WHERE OrderDate LIKE '2015%' AND OrderDate NOT BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY ShipCountry