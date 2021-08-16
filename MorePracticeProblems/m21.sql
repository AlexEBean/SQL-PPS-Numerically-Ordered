Select
 Customer.CustomerID
 ,FirstName + ' ' + LastName as CustomerName
 ,OrderDate
 ,SalesOrderHeader.SalesOrderID 
 ,SalesOrderDetail.ProductID
 ,Product.ProductName
 ,LineTotal
From SalesOrderDetail
 Join Product
 on Product.ProductID = SalesOrderDetail .ProductID
 Join SalesOrderHeader
 on SalesOrderHeader .SalesOrderID = SalesOrderDetail .SalesOrderID
 Join Customer
 on Customer.CustomerID = SalesOrderHeader.CustomerID
Order by
 CustomerID
 ,OrderDate
Limit 100;

-- In line 9, SalesOrderHeader changed to SalesOrderDetail
-- In line 12, SalesOrderDetail changed to SalesOrderHeader