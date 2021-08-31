WITH PotentialProblemOrders AS (
	Select
	 OrderID
	 From OrderDetails
	 Where Quantity >= 60
	 Group By OrderID, Quantity
	 Having Count(*) > 1
	)

Select
 DISTINCT OrderDetails.OrderID
 ,ProductID
 ,UnitPrice
 ,Quantity
 ,Discount
From OrderDetails 
 Join PotentialProblemOrders
 on PotentialProblemOrders.OrderID = OrderDetails.OrderID
Order by OrderID, ProductID;

    
