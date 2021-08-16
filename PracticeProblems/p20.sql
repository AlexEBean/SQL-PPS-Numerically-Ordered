-- Explicit

SELECT c.CategoryName, COUNT(p.CategoryID) AS TotalProducts
	FROM Categories c
    JOIN Products p
    ON c.CategoryID = p.CategoryID
    GROUP BY p.CategoryID
    ORDER BY TotalProducts DESC;

-- Implicit

SELECT c.CategoryName, COUNT(p.CategoryID) AS TotalProducts
	FROM Categories c, Products P
    WHERE c.CategoryID = p.CategoryID
    GROUP BY p.CategoryID
    ORDER BY TotalProducts DESC;