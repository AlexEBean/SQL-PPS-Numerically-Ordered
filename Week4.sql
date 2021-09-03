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

-- CREATE TABLE AS SELECT (CTAS).