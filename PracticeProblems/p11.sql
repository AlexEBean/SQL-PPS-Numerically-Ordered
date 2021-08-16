SELECT FirstName, LastName, Title, CONVERT(BirthDate, DATE) AS DateOnlyBirthDate
	FROM employees
    ORDER BY BirthDate;