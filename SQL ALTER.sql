-- DROPPING THE DATABASE --
DROP DATABASE IF EXISTS mkcl2;

-- CHECKING IF DROPPING WORKED--
SHOW DATABASES;

-- Creating a database--

CREATE DATABASE IF NOT EXISTS mkcl2;

-- USING THE CREATED DATABASE--
USE mkcl2;

-- lets explore the database--
SHOW TABLES;

-- CREATE TABLE--
CREATE TABLE employees (
    employeename VARCHAR(20),
    employeeid INT NOT NULL PRIMARY KEY,
    address VARCHAR(100)
);

-- ADDING VALUES TO THE TABLE--
INSERT INTO employees (employeeName, employeeid,address)
VALUES('Shital Ghimire', 1, 'Dang Nepal'),
('Gopal Lamsal', 2, 'Biratnagar'),
('Ram Sharan Timalsina', 3, 'Kathmandu');
-- SHOWING TABLES--
SHOW TABLES;
DESCRIBE EMPLOYEES;
SELECT 
    *
FROM
    employees;
-- ALTER THE TABLE --
-- 1. ADD A COLUMN TO A TABLE --
ALTER TABLE employees 
ADD 
phoneNumber varchar(20);

-- LETS HAVE A LOOK IF SOMETHING HAS CHANGED OR NOT?--
SELECT 
    *
FROM
    employees;

-- LETS ADD SOMETHING AFTER A SPECIFIC COLUMN-- LETS SAY WE WANT TO ADD A COLUMN SAYIING AGE AFTER EMPLOYEEID--
ALTER TABLE employees
ADD age int 
AFTER employeeid;
-- CHECK CHECK --
SELECT 
    *
FROM
    employees;
ALTER TABLE employees
DROP COLUMN department;
-- LETS DO MULTIPLE COLUMNS--
ALTER TABLE employees
ADD department varchar(20) AFTER age;
-- MODIFYING A COLUMN--
-- ITS A GOOD PRACTICE TO VIEW THE ATTRIBUTES OF A COLUMN BEFORE MODIFYING IT--
DESCRIBE employees;
ALTER TABLE employees
MODIFY age varchar(10);
-- DROPPING A COLUMN--
ALTER TABLE employees
DROP COLUMN ageof;
-- lets see if it has changed--
-- RENAMING THE COLUMN--
ALTER TABLE employees
CHANGE COLUMN age ageof int;
-- Note: you have to specify the datatype in order to make it work--
-- LETS SEE THE CHANGES--
DESCRIBE employees;
-- RENAMING THE TABLE--
-- We can use this to rename the table name-- 
ALTER TABLE employees
RENAME TO employee;
show tables;
USE mkcl2;
-- TRUNCATE *****************************____
-- Truncate table statement is used to delete all the data in the table while keeping the structure of the table--
USE MKCL2;
CREATE TABLE product (
    productName VARCHAR(100),
    productId INT NOT NULL PRIMARY KEY,
    priceperunit FLOAT
);

DESCRIBE product;
SELECT 
    *
FROM
    product;

-- Lets insert some value
DROP TABLE product;
INSERT INTO product(productName, productId, priceperunit)
VALUES("Power tiller", 1, 2450.00),
	("Rotary Seeder", 2, 2375.00),
    ("Mini Harvester", 3, 2510.00),
    ("Tractor Plough", 4, 2400),
    ("Soil Cultivator", 5, 2489),
    ("Seed Drill", 6, 2430),
    ("Disc Harrow", 7, 2505),
    ("Sprayer Pump", 8, 2460),
    ("Threshing Machine", 9, 2399),
    ("Fertilizer Spreader", 10, 2525.00),
    ("Chaff Cutter", 11, 2415),
    ("Crop Reaper", 12, 2449),
    ("Subsoiler", 13, 2530),
    ("Baler Machine", 14, 2425),
    ("Power Weeder", 15, 2490),
    ("Hand Hoe", 16, 2470),
    ("Paddy Transplanter", 17, 2380),
    ("Water Pump", 18, 2500),
    ("Manual Seeder", 19, 2444),
    ("Grain Cleaner", 20, 2465);

SELECT 
    *
FROM
    product
ORDER BY priceperunit;

DELETE FROM product;
-- lets practice 3 things here, one if DROP TABLE, DELETE, AND TRUNCATE-- IT IS ONE OF THE INTERVIEW QUESTION AS WELL-- 
-- DELETE --
use mkcl2;
SELECT 
    *
FROM
    product;

DELETE FROM product 
WHERE
    productId IN (18 , 19, 20);
-- Delete allows us to delete any specific rows with condition. We can specify our condition of delete using where clause

SELECT 
    *
FROM
    product;
-- TRUNCATE--

TRUNCATE TABLE product;

SELECT 
    *
FROM
    product;

-- Truncate allows us to delete all rows while keeping the format/structure of the table(We will have column names when we truncate----

-- Lets move to DROP -- as we have already practiced DROP statement, it just simply drops the table and get rid of the rows and structure as a whole.alter
DROP TABLE product;

-- Lets check if it has been dropped or not--
SHOW TABLES;

-- WE CAN NOW SEE WE ONLY HAVE EMPLOYEES TABLE






