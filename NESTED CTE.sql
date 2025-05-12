-- HERE WE WILL RANK CUSTOMERS BASED ON TOTAL SALES PER CUSTOMER
-- lets write for getting the total per customer
WITH totalsales AS(
SELECT customerNumber, SUM(amount) AS TOTAL
FROM payments
GROUP BY customerNumber
order by total)

-- now lets write to get customerName, and country where they belong
-- we can put customer details in main query
-- LETS GET MAX ORDER FOR CUSTOMER

,paymentcte AS (SELECT MAX(paymentdate) lastpaidon,customerNumber
FROM payments
GROUP BY customerNumber)
,ctecategory AS(
SELECT totalsales.TOTAL,totalsales.customerNumber,
CASE
WHEN totalsales.TOTAL BETWEEN 0 AND 50000 THEN 'LOW SPENDING CUSTOMER'
WHEN totalsales.TOTAL BETWEEN 50000 AND 150000 THEN 'MEDIUM SPENDING CUSTOMER'
WHEN totalsales.TOTAL >150000 THEN 'HIGH SPENDING CUSTOMER'
ELSE 'NO SPENDING'
END AS CATEGORY
FROM totalsales)
-- lets rank customers
,customerrank AS(SELECT customerNumber, TOTAL,
RANK() OVER(ORDER BY TOTAL DESC) AS CUSTOMERRANK
FROM totalsales)

-- main query
SELECT c.CUSTOMERNAME, c.COUNTRY,totalsales.TOTAL, paymentcte.LASTPAIDON, customerrank.CUSTOMERRANK, ctecategory.CATEGORY
FROM customers c
LEFT JOIN totalsales ON totalsales.customerNumber=c.customerNumber
LEFT JOIN paymentcte ON paymentcte.customerNumber=c.customerNumber
LEFT JOIN customerrank ON customerrank.customerNumber=c.customerNumber
LEFT JOIN ctecategory ON ctecategory.customerNumber=c.customerNumber
WHERE totalsales.total >0
order by customerrank.customerRank ;
-- also one one, if you want to independly run just the ctes its not possible in mysql, as mysql mandatoryly requires you to have a main query 
-- the other option is to individually select the cte parts and run to see the intermediate result.
-- ITS ALWAYS GOOD TO BREAK THE PROBLEM INTO SMALLER PART 
-- OTHERWISE IT BECOMES HARD TO SOLVE-- 


-- lets segment customers based on their total sales
-- i have added it above
-- its amazing how sql does these wonderful work for us

