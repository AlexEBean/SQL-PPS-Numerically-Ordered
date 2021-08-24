SELECT CustomerID, CompanyName, Region
	FROM customers
    ORDER BY Region IS NULL, region, CustomerID;

-- More explicit way of writing this
Select

  CustomerID

  ,CompanyName

 ,Region

From Customers

 Order By

  Case

    when Region is null then 1

   else 0

  End

 ,Region

 ,CustomerID