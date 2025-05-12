-- Lets start with CTEs very important topic in SQL
-- STEP 1:Find the total sales per customers

-- Using cte with JOIN clause--
WITH cte AS( 
SELECT customerNumber,
SUM(amount) AS TotalSales
FROM payments
GROUP BY customerNumber
ORDER BY TotalSales)
-- Here we are using ORDER BY BUT ORDER BY IS NOT ALLOWED IN SQL WITHIN CTE
-- MYSQL ALLOWS TO WRITE ORDER BY BUT IT IGNORES WHILE EXECUTING
-- MAIN QUERY
, ctelastOrder AS(
SELECT customerNumber, MAX(paymentDate) AS lastpaymentdate
FROM payments
GROUP BY customerNumber)
-- MAIN QUERY
SELECT c.customerName, c.phone,cte.TotalSales, ctelastOrder.lastpaymentdate
FROM  customers as c
LEFT JOIN cte ON cte.customerNumber=c.customerNumber
JOIN ctelastOrder ON cte.customerNumber=ctelastOrder.customerNumber 
ORDER BY cte.TotalSales DESC;

-- Multiple STANDALONE CTEs--
-- FIND THE LAST ORDERDATE FOR EACH CUSTOMERS. 
-- its above as i am trying to explain it in steps 


