USE auticon_more_sql_problems;

with FraudSuspects as (
 Select *
 From Customer
 Where
 CustomerID in (
 29401
 ,11194
 ,16490
 ,22698
 ,26583
 ,12166
 ,16036
 ,25110
 ,18172
 ,11997
 ,26731
 )
)
, SampleCustomers as (
 Select *
 From Customer
 Where
 CustomerID not in (
	SELECT CustomerID
    FROM FraudSuspects
 )
 Order by
 Rand()
 Limit 100
)
Select * From FraudSuspects
Union all
Select * From SampleCustomers;