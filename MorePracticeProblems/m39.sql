USE auticon_more_sql_problems;

WITH BaseData AS (
	SELECT 
		c.CustomerID,
		CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
		psc.ProductSubCategoryName,
		sod.LineTotal
		FROM customer c
		JOIN SalesOrderHeader soh
			USING(CustomerID)
		JOIN SalesOrderDetail sod
			USING(SalesOrderID)
		JOIN product p
			USING(ProductID)
		JOIN ProductSubCategory psc
			USING(ProductSubCategoryID)
		WHERE c.CustomerID
			IN(13763, 13836, 20331, 21113, 26313)
),

TopSubData1 AS (
	SELECT 
		CustomerID,
        CustomerName,
        MAX(LineTotal),
        ProductSubCategoryName AS TopProdSubCat1
        FROM BaseData
        GROUP BY CustomerID
), 

TopSubData2 AS (
	SELECT 
		t2.CustomerID,
        t2.CustomerName,
        MAX(LineTotal),
        t1.TopProdSubCat1,
        t2.ProductSubCategoryName AS TopProdSubCat2
        FROM BaseData t2
        RIGHT JOIN TopSubData1 t1
			USING(CustomerID)
		WHERE t2.ProductSubCategoryName != t1.TopProdSubCat1
        GROUP BY CustomerID
),

TopSubData3 AS (
	SELECT 
		t3.CustomerID,
		t3.CustomerName,
		MAX(LineTotal),
		t2.TopProdSubCat1,
		t2.TopProdSubCat2,
		t3.ProductSubCategoryName AS TopProdSubCat3
		FROM BaseData t3
		JOIN TopSubData2 t2
			USING(CustomerID)
		WHERE t3.ProductSubCategoryName NOT IN (t2.TopProdSubCat1, t2.TopProdSubCat2)
		GROUP BY CustomerID
)

SELECT 
	t1.CustomerID,
    t1.CustomerName,
    t1.TopProdSubCat1,
    t2.TopProdSubCat2,
    t3.TopProdSubCat3
	FROM TopSubData1 t1
    LEFT JOIN TopSubData2 t2
		USING(CustomerID)
    LEFT JOIN TopSubData3 t3
		USING(CustomerID)
	ORDER BY CustomerID;