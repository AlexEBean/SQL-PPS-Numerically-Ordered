-- 1

-- Every row in a table will have a primary key that is unique to that one row.  
-- It would also typically be used to join other tables.

-- 2

-- DATE

-- 3

-- VARCHAR(1)

-- 4

-- It's probably used for Home Address, Business Address, etc.
-- VARCHAR(20) should work in this case.

-- 5

-- VARCHAR(20)

-- 6

-- VARCHAR(100)

-- 7

ALTER TABLE Employee
ADD COLUMN ReportsTo INT NOT NULL;

-- 8

ALTER TABLE Employee
ADD COLUMN Level INT NOT NULL;

-- 9

ALTER TABLE Employee
ADD COLUMN Employee_picture VARCHAR(3000) NOT NULL;

-- 10

ALTER TABLE Employee
ADD COLUMN ModifiedDate DATE NOT NULL;

-- 11

-- VARCHAR(2)