-- 1

SELECT * 
    FROM Shippers;

-- 2

SELECT CategoryName, Description 
	FROM Categories;

-- 3

SELECT FirstName, LastName, HireDate
	FROM employees
    WHERE Title = 'Sales Representative';

-- 4

SELECT FirstName, LastName, HireDate
	FROM employees
    WHERE Title = 'Sales Representative' AND COUNTRY = 'USA';

-- 5

SELECT OrderID, OrderDate
	FROM orders
    WHERE EmployeeID = 5;

-- 6

SELECT *
	FROM suppliers
    WHERE NOT ContactTitle = 'Marketing Manager';

-- 7

SELECT ProductID, ProductName
	FROM products
    WHERE ProductName LIKE '%queso%';

-- 8

SELECT OrderID, CustomerID, ShipCountry
	FROM orders
    WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium';

-- 9

SELECT OrderID, CustomerID, ShipCountry
	FROM orders
    WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela');

-- 10

SELECT FirstName, LastName, Title, BirthDate
	FROM employees
    ORDER BY BirthDate;

-- 11

SELECT FirstName, LastName, Title, CONVERT(BirthDate, DATE) AS DateOnlyBirthDate
	FROM employees
    ORDER BY BirthDate;

-- 12

SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName
	FROM employees;

-- 13

SELECT OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) AS TotalPrice
	FROM OrderDetails
    ORDER BY OrderId, ProductID;

-- 14

SELECT COUNT(CustomerID) AS TotalCustomers
	FROM customers;

-- 15

SELECT MIN(OrderDate) AS FirstOrder
	FROM Orders;

-- 16

SELECT DISTINCT Country
	FROM customers
    ORDER BY Country;

-- 17

SELECT ContactTitle, COUNT(ContactTitle) AS TotalContactTitle
	FROM customers
    GROUP BY ContactTitle
    ORDER BY TotalContactTitle DESC;

-- 18

SELECT p.ProductID, p.ProductName, s.CompanyName AS Supplier
	FROM Products p
    JOIN Suppliers s
        ON p.SupplierID = s.SupplierID;

-- 19

SELECT o.OrderID, o.OrderDate, s.CompanyName AS Supplier
	FROM Orders o
    JOIN Shippers s
        ON o.ShipVia = s.ShipperID
    WHERE OrderID < 10270
    ORDER BY OrderID;

-- 20

SELECT c.CategoryName, COUNT(p.CategoryID) AS TotalProducts
	FROM Categories c
    JOIN Products p
        ON c.CategoryID = p.CategoryID
    GROUP BY p.CategoryID
    ORDER BY TotalProducts DESC;

-- 21

SELECT Country, City, COUNT(Country AND City) AS TotalCustomers
	FROM customers
    GROUP BY Country, City
    ORDER BY TotalCustomers DESC;

-- 22

SELECT productID, ProductName, UnitsInStock, ReorderLevel
	FROM products
    WHERE UnitsInStock <= ReorderLevel
    ORDER BY ProductID;

-- 23

SELECT productID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
	FROM products
    WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued = 0
    ORDER BY ProductID;

-- 24

SELECT
  CustomerID,
  CompanyName,
  Region
FROM Customers
 ORDER BY
  CASE
    WHEN Region IS NULL THEN 1
    ELSE 0
  END,
  Region,
  CustomerID

-- 25

SELECT ShipCountry, AVG(Freight) AS AverageFreight
	FROM orders
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;

-- 26

SELECT ShipCountry, AVG(CASE WHEN OrderDate LIKE '2015%' THEN Freight END) AS AverageFreight
	FROM orders
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;

-- 27

10806


-- This code helped me find it.
SELECT
 OrderID, OrderDate, ShipCountry
FROM Orders
WHERE OrderDate LIKE '2015%' AND OrderDate NOT BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY ShipCountry

-- 28

SELECT ShipCountry, AVG(Freight) AS AverageFreight
	FROM orders
    WHERE OrderDate 
		BETWEEN (SELECT DATE_ADD(MAX(OrderDate), INTERVAL -12 MONTH) FROM Orders)
		AND (SELECT MAX(OrderDate) FROM Orders)
    GROUP BY ShipCountry
    ORDER BY AverageFreight DESC
    LIMIT 3;

-- 29

SELECT e.EmployeeID, e.LastName, o.OrderID, p.ProductName, od.Quantity
	FROM Employees e
    JOIN Orders o
		ON e.EmployeeID = o.EmployeeID
	JOIN OrderDetails od
		ON o.OrderID = od.OrderID
	JOIN Products p
		ON od.ProductID = p.ProductID
	ORDER BY o.OrderID, p.ProductID;

-- 30

SELECT c.CustomerID AS Customers_CustomerID, o.CustomerID AS Orders_CustomerID 
	FROM Customers c
    LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
    WHERE o.CustomerID IS NULL;

-- 31

SELECT c.CustomerID, m.customerID
	FROM customers c
    LEFT JOIN 
		(SELECT o.CustomerID FROM Orders o
            WHERE o.EmployeeID = 4) AS m
		ON c.CustomerID = m.CustomerID
	WHERE m.CustomerID IS NULL;

-- 32

SELECT c.CustomerID, c.CompanyName, o.OrderID, SUM(od.unitPrice * od.Quantity) AS TotalOrderAmount
	FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    WHERE OrderDate LIKE '2016%'
    GROUP BY c.CustomerID, c.CompanyName, o.OrderID
    HAVING (TotalOrderAmount >= 10000)
    ORDER BY TotalOrderAmount DESC;

-- 33

SELECT c.CustomerID, c.CompanyName, SUM(od.unitPrice * od.Quantity) AS TotalOrderAmount
	FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    WHERE OrderDate LIKE '2016%'
    GROUP BY c.CustomerID
    HAVING (TotalOrderAmount >= 15000)
    ORDER BY TotalOrderAmount DESC;

-- 34

SELECT 
    c.CustomerID, c.CompanyName, 
    SUM(od.unitPrice * od.Quantity) AS TotalsWithoutDiscount, 
    SUM(od.unitPrice * od.Quantity * (1-od.Discount)) AS TotalsWithDiscount
	FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    WHERE OrderDate LIKE '2016%'
    GROUP BY c.CustomerID
    HAVING (TotalsWithDiscount >= 10000)
    ORDER BY TotalsWithDiscount DESC;

-- 35

SELECT EmployeeID, OrderID, OrderDate
	FROM orders
    WHERE OrderDate = LAST_DAY(SUBSTR(OrderDate, 1, 10))
    ORDER BY EmployeeID;


-- 36

SELECT OrderID, COUNT(OrderId) AS TotalOrderDetails
	FROM orderDetails
    GROUP BY OrderID
    ORDER BY TotalOrderDetails DESC
    LIMIT 10;

-- 38

SELECT OrderID
	FROM OrderDetails
	WHERE Quantity >= 60
    GROUP BY OrderID, Quantity
	HAVING COUNT(*) > 1
    ORDER BY OrderID;

-- 39

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

-- 41

SELECT OrderID, DATE(OrderDate) AS OrderDate, DATE(RequiredDate) AS RequiredDate, DATE(ShippedDate) AS ShippedDate
	FROM orders
    WHERE DATE(ShippedDate) >= DATE(RequiredDate)
    ORDER BY OrderID;

-- 42

SELECT e.EmployeeID, LastName, COUNT(OrderID) AS TotalLateOrders
	FROM employees e
    JOIN orders o
		ON e.EmployeeID = o.EmployeeID
	WHERE ShippedDate >= RequiredDate
	GROUP BY EmployeeID
    ORDER BY TotalLateOrders DESC;

-- 52

SELECT DISTINCT Country
	FROM  customers
UNION
SELECT DISTINCT Country
	FROM suppliers
ORDER BY Country;

-- 56

SELECT 
	InitialOrder.CustomerID, 
	InitialOrder.OrderID AS InitialOrderID, 
	DATE(InitialOrder.orderDate) AS InitialOrderDate, 
	NextOrder.OrderID AS NextOrderID, 
	DATE(NextOrder.OrderDate) AS NextOrderDate, 
	DATEDIFF(NextOrder.OrderDate, InitialOrder.OrderDate) AS DaysBetweenOrders
	FROM  customers c
    JOIN orders initialOrder
		ON c.CustomerID = InitialOrder.CustomerID
	JOIN orders NextOrder
		ON InitialOrder.CustomerID = NextOrder.CustomerID
	WHERE InitialOrder.OrderID < NextOrder.OrderID
        AND DATEDIFF(NextOrder.OrderDate,
            InitialOrder.OrderDate) <= 5
	ORDER BY c.CustomerID, InitialOrderID;

