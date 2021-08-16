Select
 Product.ProductID
 ,ProductName
 ,ProductSubCategoryName
 ,Date(Min(OrderDate)) as FirstOrder
 ,Date(Max(OrderDate)) as LastOrder
From Product
 Left Join SalesOrderDetail Detail
 on Product.ProductID = Detail.ProductID
 Left Join SalesOrderHeader Header
 on Header.SalesOrderID = Detail .SalesOrderID
 Left Join ProductSubCategory 
 on ProductSubCategory .ProductSubCategoryID = Product.ProductSubCategoryID
Where
 Color = 'Silver'
Group by
 Product.ProductID
 ,ProductName
 ,ProductSubCategoryName
Order by LastOrder desc;

-- The column name of color was coded as 'Color' in the WHERE Statement
-- It shouldn't be written as a string.