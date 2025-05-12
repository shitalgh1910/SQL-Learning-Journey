-- LETS DO SUBQURIES NOW-- 
-- 1. LIST ALL CUSTOMERS WHO ARE HANDLED BY EMPLOYEES WORKING IN THE USA--
SELECT 
    lastName, firstName, officeCode
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices o
        WHERE
            country = 'USA');
SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
WHERE
    amount = (SELECT 
            MAX(amount)
        FROM
            payments);

SELECT customerNumber, checkNumber, amount, avg(amount) as average
FROM payments
WHERE amount >(SELECT AVG(amount) from payments)
GROUP BY customerNumber, checkNumber, amount;

-- LETS USE SUBQUERY WHICH WILL RETURN MORE THAN ONE VALUE--
SELECT customerNumber, customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber from orders);

-- 2. find the name of employees who work in the same office as danial murphy
SELECT  employeeNumber,lastName, firstName,officeCode
from employees
where officeCode = (SELECT officeCode from employees WHERE firstName='Diane' AND lastName='Murphy');

-- 3. List the products that have never been ordered
SELECT 
    productCode, productName, productLine
FROM
    products
WHERE
    productCode NOT IN (SELECT 
            productCode
        FROM
            orderdetails);
-- 4. show all the customers who have placed more orders than the average number of orders per customer
SELECT COUNT(*) as totalorder, customerNumber
FROM orders
GROUP BY customerNumber
HAVING COUNT(*) >(
SELECT AVG(order_count)
FROM (SELECT COUNT(*) AS order_count 
FROM orders
GROUP BY customerNumber)
AS cutomer_order_counts)
ORDER BY totalorder desc;

-- 5. Find the employees who have customers in France--
SELECT lastName, firstName
FROM employees
WHERE employeeNumber IN  (SELECT repnumber from customers WHERE country='France');

-- 6 List the names of customers who have placed orders with a total amount greater than $50000
SELECT c.customerName,totals.total
FROM customers c
JOIN (
SELECT SUM(d.quantityOrdered*priceEach) as total, o.customerNumber
FROM orderdetails d
JOIN orders o
USING (orderNumber)
GROUP BY o.customerNumber
order by total)
as totals ON c.customerNumber=totals.customerNumber
WHERE totals.total>50000;

-- 7. find the product(S) with the highest price(MSPR)
SELECT MAX(MSRP) FROM products;
SELECT productCode, productLine, productName,MSRP
FROM products
WHERE MSRP IN (SELECT MAX(MSRP) from products);

-- 8. list offices that do not have any employees--
SELECT officeCode from offices
WHERE officeCode NOT IN (SELECT officeCode FROM employees);

/* 9. Display the names of customers who have ordered all products in the Motorcycle productline(correlated
subquery needed-harder */
-- try to break queries--
-- lets get the productname and product line which is only motorcycle

SELECT productLine, productName
FROM products
WHERE productLine='Motorcycles';

SELECT c.customerNumber, c.customerName, p.productLine, p.productName
FROM customers c
JOIN orders o 
ON c.customerNumber=o.customerNumber
JOIN orderdetails d ON o.orderNumber=d.orderNumber
JOIN products p ON d.productCode=p.productCode
WHERE p.productLine='Motorcycles';