
"ERDs.  ERDs are a critical part of all relational database work.  Here are some questions for you to answer:

1. What is a primary key (PK)?  Look it up if you're not sure, but answer in your own words, don't copy and paste what you read.
2. What data type should BirthDate be?
3. What data type should Gender be?
4. What do you suspect that AddressType is used for?  Given your assumption, what type should it be?
5. What data type should MartialStatus be?
6. What kind of table is EmployeeAddress?
7. If you wanted to model the """"Reports To"""" relationship, how would you modify this schema given what you know about the business world?  Look up the syntax for ALTER TABLE and express your answer as SQL.
8. If you were to add a """"Level"""" field (for employee level), what data type would that be?  Once again, express this as an ALTER TABLE.
9. If you had to store a photo of the employee, what would you name the column and what would its type be?  Express as ALTER TABLE.
10. What type should ModifiedDate be?  Pretend that this field doesn't exist and express this, too, as an ALTER TABLE.
10. What should StateProvinceID's type be?"

-- 1

-- Every row in a table will have a primary key that is unique to that one row.  
-- It would also typically be used to join other tables.

-- 2

-- DATE

-- 3

-- VARCHAR(1)

-- 4

-- It's probably used for Home Address, Business Address, etc.
-- VARCHAR(50) should work in this case.

-- 5

-- VARCHAR(50)

-- 6

-- An intermediate table betwetween Employee and Address

-- 7

ALTER TABLE Employee
ADD COLUMN ReportsTo INT NOT NULL;

-- 8

ALTER TABLE Employee
ADD COLUMN Level INT NOT NULL;

-- 9

ALTER TABLE Employee
ADD COLUMN Employee_picture BLOB NOT NULL;

-- 10

ALTER TABLE Employee
ADD COLUMN ModifiedDate DATE NOT NULL;

-- 11

-- VARCHAR(2)