SHOW DATABASES;
USE classicmodels;
-- SELECT STATEMENT--
SELECT * FROM customers;
-- Select Distinct--
SELECT DISTINCT state from customers;
-- SELECT DISTINCT WITH WHERE CLAUSE--
select city from customers;
SELECT DISTINCT
    customerName, customerNumber
FROM
    customers
WHERE
    city = 'NYC';
-- OrderBY --
SELECT 
    customerName, customerNumber
FROM
    customers
WHERE
    city = 'NYC'
ORDER BY customerNumber;

-- AND OPERATOR-- 
SELECT 
    customerName, customerNumber, city
FROM
    customers
WHERE
    customerName LIKE 'M%' AND city = 'NYC';

SELECT 
    COUNT(*) AS total_number_of_customers, city
FROM
    customers
GROUP BY city
ORDER BY total_number_of_customers DESC
LIMIT 10;

SELECT 
    e.employeeNumber,
    CONCAT_WS(' ', e.firstName, e.lastName) AS FullName,
    o.city
FROM
    employees AS e
        INNER JOIN
    offices o ON e.officeCode = o.officeCode
WHERE
    CONCAT_WS(' ', e.firstName, e.lastname) LIKE 'P%'
        AND city = 'Sydney'
ORDER BY FullName;
        
SELECT * FROM CUSTOMERS
LIMIT 20;
-- IN and NOT IN Operator--
SELECT 
    customerName, customerNumber, phone, city
FROM
    customers
WHERE
    city IN ('Las Vegas' , 'NYC', 'Melbourne', 'Madrid');

SELECT 
    customerName, customerNumber, phone, city
FROM
    customers
WHERE
    city NOT IN ('Las Vegas' , 'NYC');

-- between Operator--
SELECT 
    c.customerName, c.customerNumber, c.creditLimit, p.amount
FROM
    customers AS c
        RIGHT JOIN
    payments p ON c.customerNumber = p.customerNumber
WHERE
    c.creditLimit BETWEEN 10000 AND 200000
ORDER BY creditLimit , amount DESC;

-- NOT BETWEEN-- 
SELECT 
    c.customerNumber, c.customerName, c.creditLimit, p.amount
FROM
    customers AS c
        RIGHT JOIN
    payments p ON c.customerNumber = p.customerNumber
WHERE
    p.amount NOT BETWEEN 5000 AND 25000
ORDER BY p.amount;

-- We can see the amount from 5000 to 25000 is not shown in the result as we used NOT BETWEEN Operator. --
-- Like Operator-- 

SELECT 
    e.employeeNumber,
    CONCAT_WS(' ', e.lastName, e.firstName) AS FullName,
    o.city
FROM
    employees e
        JOIN
    offices o ON e.officeCode = o.officeCode
WHERE
    o.city LIKE 'N%';

SELECT 
    e.employeeNumber,
    CONCAT_WS(' ', e.lastName, e.firstName) AS FullName,
    o.city
FROM
    employees e
        JOIN
    offices o ON e.officeCode = o.officeCode
WHERE
    o.city LIKE '%N';
    -- 
select city from offices;
SELECT 
    e.employeeNumber,
    CONCAT_WS(' ', e.lastName, e.firstName) AS FullName,
    o.city
FROM
    employees e
        JOIN
    offices o ON e.officeCode = o.officeCode
WHERE
    o.city LIKE '%ri%';

-- Using _ WIldcard--

SELECT 
    e.employeeNumber,
    CONCAT_WS(' ', e.lastName, e.firstName) AS FullName,
    o.city
FROM
    employees e
        JOIN
    offices o ON e.officeCode = o.officeCode
WHERE
    o.city LIKE 'N_C';

-- NOT LIKE OPERATOR --
SELECT productLine, count(*) as count
FROM products
WHERE productLine NOT LIKE "T%"
GROUP BY productLine
ORDER BY count;

-- LIKE OPERATOR WITH ESCAPE CLAUSE--
SELECT productName, MSRP
FROM products
WHERE productCode LIKE '%S12%';

-- limit clause with offset--
SELECT customerNumber, customerName, phone
FROM customers
LIMIT 5,15;

SELECT * FROM employees
LIMIT 2, 5;
-- This will skip first and second row and show the next 5 rows from the table--

-- Limit clause with pagination --

SET @employeeNumber=1088;
SELECT * FROM 
employees
where employeeNumber>@employeeNumber
order by employeeNumber
limit 5;
-- curson pagination for date time--

set @paymentDate= '2005-01-01';
SELECT amount,paymentDate from payments
where paymentDate>@paymentDate
order by amount;


set @paymentDate= '2005-01-01';
SELECT amount,paymentDate from payments
where paymentDate BETWEEN @paymentDate AND '2006-01-01'
order by paymentDate;

-- Aggregate Function--
select c.customerName, c.customerNumber, c.salesRepEmployeeNumber, sum(p.amount) 
FROM customers c 
INNER JOIN payments p
ON c.customerNumber=p.customerNumber GROUP BY c.customerName,c.customerNumber, c.salesRepEmployeeNumber;

select sum(o.quantityOrdered*o.priceEach) as total_price,p.productLine,p.productName
from orderdetails as o
JOIN products p 
ON o.productCode=p.productCode
group by p.productLine,p.productName;

SELECT count(*), status from orders
GROUP BY status;

-- Lets dive into joins--
-- Inner Join--
SELECT p.productCode, p.productName, pr.textDescription 
FROM products p
JOIN productlines pr
ON p.productLine=pr.productLine;

SELECT p.productCode, p.productName, pr.textDescription 
FROM products p
LEFT JOIN productlines pr
ON p.productLine=pr.productLine;

SELECT c.customerName, c.customerNumber, p.amount
FROM customers c
JOIN payments p USING (customerNumber);

SELECT c.customerName, c.customerNumber, p.amount
FROM customers c
CROSS JOIN payments p
order by c.customerNumber,p.amount; 

use database classicmodels;
select * from customers;

select pl.productLine, p.productVendor
FROM products p
CROSS JOIN productlines pl;

select e.employeeNumber, concat_ws(' ',e.lastName, e.firstName) as fullname, o.officeCode, o.city
FROM employees e
CROSS JOIN offices o;
-- Natural Join--
select *
FROM employees e
natural join customers c;

select concat_ws()(" ", e.lastName, e.firstName) as FullName, e.reportsTo 
FROM employees e
INNER JOIN employee emp 
ON e.employeeNumber=emp.employeeNumber;

select concat(" ",e.lastName, e.firstName) as EmployeeName,
		CONCAT(" ", emp.lastName, emp.firstName) as manager
From employeeS e
INNER JOIN employeeS emp 
ON e.employeeNumber=emp.reportsTo
ORDER BY manager;

-- self join with left join--
select e.lastName as directReports,
		ifnull(m.lastName,'topManager') as manager
        from employees e
        LEFT JOIN employees m
        ON e.reportsto=m.employeeNumber;
        
        
select concat_ws(' ', e.lastName, e.firstName) as Manager,
		IFNULL(concat_ws(' ',m.lastName, m.firstName),'Top manager') as directreports
        FROM employees e
        LEFT JOIN employees m
        ON e.reportsto=m.employeeNumber;


        

        
        




