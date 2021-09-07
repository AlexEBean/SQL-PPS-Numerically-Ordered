-- Creating a Table via WorkBench

create table tutorials_tbl(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   tutorial_author VARCHAR(40) NOT NULL,
   submission_date DATE,
   PRIMARY KEY ( tutorial_id )
);

-- Creating a Table Via Command Prompt (cmd)
-- Run as administrator
-- cd into C:\Program Files\MySQL\MySQL Server 8.0\bin
-- mysql -u root -p
use TUTORIAL;

CREATE TABLE tutorials_tb2(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   tutorial_author VARCHAR(40) NOT NULL,
   submission_date DATE,
   PRIMARY KEY ( tutorial_id )
   );

-- DROP
DROP TABLE tutorials_tbl;

-- Creating Temporary Tables
-- They're automatically dropped when the current client session terminates

CREATE TEMPORARY TABLE SalesSummary (
   product_name VARCHAR(50) NOT NULL, 
   total_sales DECIMAL(12,2) NOT NULL DEFAULT 0.00, 
   avg_unit_price DECIMAL(7,2) NOT NULL DEFAULT 0.00,
    total_units_sold INT UNSIGNED NOT NULL DEFAULT 0
)

INSERT INTO SalesSummary
   (product_name, total_sales, avg_unit_price, total_units_sold)
   VALUES
	('cucumber', 100.25, 90, 2);

-- CREATE TABLE AS SELECT (CTAS). Example uses data from Second Problem Set database

CREATE TEMPORARY TABLE CustomerAndOrder
	SELECT 
		c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        o.SalesOrderID
        FROM customer c
        JOIN SalesOrderHeader o
			USING(CustomerID)
		ORDER BY c.CustomerID;
    
SELECT * FROM CustomerAndOrder;

-- Clone a Table

-- Shows Table name and Create Table function used to create it
SHOW CREATE TABLE CustomerAndOrder;

-- Create Clone Table
CREATE TEMPORARY TABLE CloneCustomerAndOrder(
	CustomerID INT ,
    CustomerName VARCHAR(101),
    SalesOrderID INT
);

-- Insert Data.  The SELECT takes the place of VALUES
INSERT INTO CloneCustomerAndOrder (
	CustomerID,
    CustomerName,
    SalesOrderID)

SELECT 
	CustomerID,
    CustomerName,
    SalesOrderID
    FROM CustomerAndOrder;

SELECT * FROM CloneCustomerAndOrder;

-- Data to put in cmd

CREATE DATABASE USPopulation;

USE USPopulation;

CREATE TABLE PopData (
    `rank` INT PRIMARY KEY CHECK(`rank` > 0),
    State VARCHAR(50),
    Pop INT,
    Growth DECIMAL(5, 4),
    Pop2018 INT,
    Pop2010 INT,
    growthSince2010 DECIMAL(5, 4),
    Percent DECIMAL(5, 4),
    density DECIMAL(10, 4)
);

-- This restriction can be removed from MySQL Workbench 8.0 in the following way. 
-- Edit the connection, on the Connection tab, go to the 'Advanced' sub-tab, and in the 'Others:' box 
-- add the line OPT_LOCAL_INFILE=1.
-- This should allow a client using the Workbench to run LOAD DATA INFILE as usual.

LOAD DATA LOCAL INFILE "C:/Users/Alex/Downloads/USStatesandTerritories2021PopulationData.csv" INTO TABLE PopData
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
(`rank`, State, Pop, Growth, Pop2018, Pop2010, growthSince2010, Percent, density);

SELECT * FROM PopData
	ORDER BY Pop;

SELECT 'rank', 'State', 'Pop', 'Growth', 'Pop2018', 'Pop2010', 'growthSince2010', 'Percent', 'density'
UNION
SELECT * FROM PopData
	ORDER BY CAST(Pop AS UNSIGNED)
    INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MySQLToCSV.csv'
    FIELDS ENCLOSED BY '"'
    TERMINATED BY ',';
