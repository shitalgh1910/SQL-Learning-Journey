-- Lets start window function now
-- lets find out the sum of the payment made by customer
SELECT SUM(amount) from payments;
-- lets find out for each customer
SELECT SUM(amount),customerNumber from payments
GROUP BY customerNumber;

-- find the total amount for each customer, payment id and payment date
SELECT CUSTOMERNUMBER,paymentDate,checkNumber,amount,
SUM(amount) OVER(Partition by CUSTOMERNUMBER) from payments
;
-- using partition by is important otherwise
-- sql is going to make one window and do the aggregation
SELECT CUSTOMERNUMBER,paymentDate,checkNumber,amount,
SUM(amount) OVER() from payments
;

-- partition by using multiple column--
SELECT o.customerNumber, o.orderNumber, p.amount,o.status,
SUM(p.amount) OVER(PARTITION BY o.status,o.customerNumber) as total
FROM orders o
JOIN payments p
ON o.customerNumber=p.customerNumber;

-- find total sales accross all the orders--
-- here we did not do any partition so the aggregation function will give total sum

SELECT orderNumber, orderDate, status,
sum(p.amount) OVER()
FROM orders 
JOIN payments p ON orders.customerNumber=p.customerNumber;

-- now lets use parition by customerNumber or status
-- HERE WE CAN SEE HOW GRANULARLY WE CAN SEE THE DATA--
SELECT orderNumber, orderDate, status,p.amount AS AMT,
sum(p.amount) OVER() AS GRANDSUM,
sum(p.amount) OVER(PARTITION BY o.orderNumber) as TOTALSALESBYORDERS
FROM orders o
JOIN payments p ON o.customerNumber=p.customerNumber;

-- LETS FIND THE TOTAL SALES FOR EACH COMBINITAITION OF PRODUCT AND ORDER STATUS

SELECT orderNumber, orderDate, status,p.amount AS AMT,
sum(p.amount) OVER() AS GRANDSUM,
sum(p.amount) OVER(PARTITION BY o.orderNumber) as TOTALSALESBYORDERS,
SUM(p.amount) OVER(PARTITION BY o.orderNumber, status) salesbyorderstatus
FROM orders o
JOIN payments p ON o.customerNumber=p.customerNumber;

-- Lets see order by --

select *, RANK() OVER(PARTITION BY customerNumber ORDER BY AMOUNT DESC)
FROM PAYMENTS;

-- HERE WE CAN SEE WHAT WAS THE HIGHEST AMOUNT OF PAYMENT DONE BY A PARTICULAR CUSTOMER
-- FIRST SQL GOING TO PARTIITION BY CUSTOMER AND THEN RANK IT BY AMOUNT)
-- AMAZING CONCEPT
-- LETS RANK THE FIRST TO LAST AMOUNT ----
SELECT *, RANK() OVER(ORDER BY AMOUNT DESC) FROM payments ;

-- LETS TRY THIS WITH FRAME CLAUSE

SELECT *,SUM(amount) OVER(PARTITION BY customerNumber ORDER BY amount ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) FROM payments;
 
-- lets rank the employee based on the sales they have made

SELECT SUM(p.amount) AS total,c.repnumber,RANK() OVER(order by SUM(p.amount) desc) AS 'RANK OF SALESMAN'
FROM payments p
JOIN customers c 
ON p.customerNumber=c.customerNumber
GROUP BY c.repnumber;
-- here we are aggregating based on p.amount right, so sql will only let you use what is in group by
