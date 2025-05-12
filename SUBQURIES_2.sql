SELECT * FROM customers;

-- Subquries based on Results--
/* THERE ARE BASICALLY THREE TYPE OF SUBQURIES BASED ON RESULT TYPE
1. SCALAR- RETURNS ONLY ONE VALUE
2. ROW SUBQURY-RETURNS MULTIPLE ROWS
3. TABLE SUBQURY -RETURNS MULTIPLE ROWS AND COLUMNS
*/
-- 1. Scalar--
SELECT AVG(creditLimit) 
FROM customers;
-- this is what we call it a scalar, i.e returning a single value.

-- 2. ROW SUBQURY
SELECT customerNumber
FROM customers;
-- this returns only one columns but multiple rows
-- 3. TABLE SUBQURY
SELECT * FROM customers;

-- BASED ON LOCATION | CLAUSE

-- 1. FROM 
/* SYNTAX
SELECT colum1, column2
FROM (SELECT cplumn FROM table 1 WHERE condition)
*/
-- lets perform our first step
-- if the manager comes and says do not consider customers who have credit limit less than 50000 and then calculate the average of 
-- credit limit, and the display all customers who have more than average credit limit
-- main query
SELECT customerNumber, customerName, creditLimit FROM customers
Having creditLimit>
-- subquery
(SELECT AVG(creditLimit) as avrg
FROM customers
WHERE creditLimit>50000
order by creditLimit);


-- lets do with where clause

-- main query
SELECT customerNumber, customerName, creditLimit FROM customers
WHERE creditLimit>
-- subquery
(SELECT AVG(creditLimit) as avrg
FROM customers
WHERE creditLimit>50000
order by creditLimit);
-- main query
SELECT *, RANK() OVER (ORDER BY total desc) customerRank FROM 
-- subquery
	(SELECT customerNumber, SUM(amount) as total
	FROM payments
	GROUP BY customerNumber
	ORDER BY total)t
    WHERE total>50000;
    
    
    
    -- 2. SUBQURY IN SELECT CLAUSE
    /* SYNTAX
    SELECT column1
			(SELECT column FROM table1 WHERE condition)
		FROM table1
	*/
    
    select * from customers;
    
    SELECT customerName, customerNumber,creditLimit,(SELECT AVG(creditLimit) FROM customers)
    FROM customers;
    
-- A rule here-the value that is being returned by a subquery in SELECT STATEMENT MUST BE A SCALAR VALUE
-- OTHERWISE IT IS NOT GOING TO WORK, SQL IS EXPECTING SINGLE(SCALAR) VALUE AS AN OUTPUT FROM THE SUBQUERY)

SELECT 
    productLine,
    productCode,
    (SELECT 
            COUNT(*)
        FROM
            orderdetails) AS totalOrder
FROM
    products;
-- Preparation of subquery--
SELECT 
    COUNT(*)
FROM
    orderdetails;
    
    -- Only scalar value Please
    -- it will say subquery returned more than one value
    
    -- 3 USING SUBQUERIES WITH JOIN CLAUSE
    -- lets find out customer details and findout total orders of each customers
    -- main query
    SELECT c.customerNumber, c.customerName ,T.total
    FROM customers c
    LEFT JOIN
    (SELECT COUNT(*) as total, c.customerNumber FROM customers c
    JOIN orders o
    ON c.customerNumber=o.customerNumber
    GROUP BY c.customerNumber
    ORDER BY COUNT(*) DESC) T 
    ON c.customerNumber=T.customerNumber;
    
    -- The concept is amazing, as the subquery is executed first, we can display the result of the column created in subquery in our main query.
-- 4. USIING SUBQURIES WITH WHERE CLAUSE
-- we can use where clause with a static value, but in real projects we
-- filter the values based on complex logics so we have to use subquries with where cluase to get our result

SELECT * FROM customers
WHERE creditLimit>50000;
-- FIND THE PRODUCTS THAT HAVE A PRICE HIGHER THAN THE AVERAGE PRICE OF ALL PRODUCTS
SELECT productCode, productLine, buyPrice,ROUND((SELECT AVG(buyPrice) as avgr FROM products),2) as averg
FROM products
WHERE buyPrice>(SELECT AVG(buyPrice) as avgr FROM products);

-- Lets do logical operator now

-- SUBQURIES WITH IN CLAUSE
/*IN COMPARISION OPERATOR WE CAN ONLY FILTER BASED ON SINGLE VALUE. BUT IN MOST OF THE CASES WE HAVE TO FILTER THE DATA BASED ON MULTIPLE
VALUES. IN THIS CASE WE CAN USE IN OPERATOR TO GET THE LIST OF VALUES */

SELECT o.orderNumber, o.orderDate, t.customerName, t.customerNumber
FROM orders o 
JOIN (SELECT c.customerName, c.customerNumber
FROM customers c
JOIN orders o 
ON c.customerNumber=o.customerNumber
WHERE c.country='France') t
ON o.customerNumber=t.customerNumber;
-- IN Operator

SELECT * FROM orders
WHERE customerNumber IN (
SELECT customerNumber
FROM customers WHERE country='France');

-- But what if you need customerName, and Customer address from customer Table


SELECT 
    orderNumber,
    orderDate,
    customerNumber,
    (SELECT 
            customerName
        FROM
            customers
        WHERE
            customers.customerNumber = orders.customerNumber) AS customerName
FROM
    orders
WHERE
    customerNumber IN (SELECT 
            customerNumber
        FROM
            customers
        WHERE
            country = 'France');
            
-- SUBQUERY WITH ANY/ALL OPERATOR
-- THIS OPERATOR CHECKS IF A VALUE MATCHES ANY VALUES WITHIN A LIST. IT IS USED TO CHECK IF A VALUE IS TRUE FOR AT LEAST
-- ONE OF THE VALUES IN A LIST

-- 1. FIND THE PRODCUTS THAT ARE MORE EXPENSIVE THAN ANY PRODUCTS IN THE CLASSIC PRODUCTLINE
-- ANY----
SELECT productCode, productLine, productName,MSRP
FROM products
WHERE MSRP>any
(SELECT MSRP FROM products 
WHERE productLine='Classic cars')
ORDER BY MSRP;

-- ALL OPERATORS-----
SELECT customerName, customerNumber,creditLimit
from customers
WHERE creditLimit> ALL
(SELECT  creditLimit
FROM customers
WHERE country='USA'
Order by creditLimit);

-- here we get the value which is greater that all the values of creditlimit from USA customers;
-- Lets show all the orders where the order amount is higher that any order placed by customerNumber 103

-- Correlated subquery -- 
/* IN this subquery the subquery is dependant on main query
the main query interacts with the database engine, get a row of result, pass it on to 
the subqeury, checks if there is any result returned from subquery, if there is a results
it will include in the final result. Similarly it does this for all the rows on the table. and 
finally show the result. so it is iterative*/

-- Here i need customer details and find the total orders of each customers
-- Selcting from customers--9
-- We can simply just use a scalar value to display but we need to group this by customers--
SELECT customerName, customerNumber, country,(SELECT count(*) 
FROM orders) as count
FROM customers;

-- This is has a subqury which is non correlated
SELECT customerName, customerNumber, country,(SELECT count(*) 
FROM orders o WHERE o.customerNumber=c.customerNumber) as count
FROM customers c;

-- selecting from orders--

SELECT count(*) AS 'Total Orders per customer'
FROM orders
GROUP BY customerNumber
ORDER BY count(*) desc;
 
 -- show the details of the orders made by customers in France
 -- Step 1----
 SELECT customerNumber
 FROM customers
 WHERE country='France';
 
 -- step 2--
 SELECT * FROM 
 orders;
 -- Step 3
 -- Lets put these two quries together
  SELECT * from orders o
 WHERE EXISTS( SELECT c.customerNumber
 FROM customers c
 WHERE c.country='France');
 
 -- untill now these two queries and non correlated
 
 SELECT * from orders o
 WHERE EXISTS( SELECT 1
 FROM customers c
 WHERE c.country='France'
 AND c.customerNumber=o.customerNumber);
 -- RESULT SHOWS 37 ROWS
 -- Not exists
  SELECT * from orders o
 WHERE NOT EXISTS( SELECT 1
 FROM customers c
 WHERE c.country='France'
 AND c.customerNumber=o.customerNumber);
 -- HERE 289 ROWS RETURNES
 
 SELECT * FROM orders;
 -- 326 rows returned
 
 

