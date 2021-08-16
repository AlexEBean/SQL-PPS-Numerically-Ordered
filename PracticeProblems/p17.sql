SELECT ContactTitle, COUNT(ContactTitle) AS TotalContactTitle
	FROM customers
    GROUP BY ContactTitle;