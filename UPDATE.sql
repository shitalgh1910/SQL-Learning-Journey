-- Lets explore UPDATE--
USE classicmodels;
show databases;

SELECT 
    *
FROM
    employees;
UPDATE employees 
SET 
    email = 'mary.patterso@classicmodelcars.com'
WHERE
    employeeNumber = 1056;

SELECT 
    *
FROM
    employees;
-- Lets see how we can use update to modify values in multiple columns--
UPDATE employees 
SET 
    lastName = 'Ghimire',
    email = 'ghjimrei@gmail.com'
WHERE
    employeeNumber = 1056;

SELECT 
    *
FROM
    employees
WHERE
    employeeNumber = 1056;


-- This is how we can modify/UPDATE VALUES IN MULTIPLE COLUMNS--

SELECT 
    *
FROM
    employees
WHERE
    officeCode = 6;
SELECT 
    email, jobTitle, officeCode
FROM
    employees
WHERE
    officeCode = 6
        AND jobTitle LIKE '%Sales%';

UPDATE employees 
SET 
    email = REPLACE(email,
        '@classicmodelcars.com',
        '@mysqltutorial.org')
WHERE
    jobTitle = 'Sales Rep'
        AND officeCode = 6;

-- USING UPDATE to update rows returned by a SELECT statement--
SELECT 
    *
FROM
    customers
WHERE
    salesRepEmployeeNumber IS NULL
;

SELECT 
    employeeNumber
FROM
    employees
WHERE
    jobTitle LIKE '%sales%'
ORDER BY RAND()
LIMIT 1;

-- Now lets update using suquery

UPDATE customers 
SET 
    salesRepEmployeeNumber = (SELECT 
            employeeNumber
        FROM
            employees
        WHERE
            jobTitle LIKE '%sales%'
        ORDER BY RAND()
        LIMIT 1)
WHERE
    salesRepEmployeeNumber IS NULL;

SELECT 
    *
FROM
    customers;

-- Now you can see there are no null values for SalesRepEmployeeNumber because now every customer have a representative--





