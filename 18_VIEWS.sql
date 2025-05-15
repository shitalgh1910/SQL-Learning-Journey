SELECT * FROM CUSTOMERS;
CREATE VIEW CUS AS(SELECT CUSTOMERNAME, CUSTOMERNUMBER, CREDITLIMIT, CONCAT(CONTACTLASTNAME,' ', CONTACTFIRSTNAME) AS 'FULL NAME', REPNUMBER
FROM CUSTOMERS);


select * from cus
where creditLimit>50000;
select* from payments;
-- FIND THE RUNNING TOTAL OF AMOUNT RECEIVED FOR EACH MONTH
WITH CTE_MONTHLY AS(
SELECT SUM(AMOUNT) AS AMT, YEAR(PAYMENTDATE) AS YR, MONTH(PAYMENTDATE),
count(checkNumber) as NOofCheck
FROM PAYMENTS
GROUP BY YEAR(PAYMENTDATE), MONTH(PAYMENTDATE)
ORDER BY YEAR(PAYMENTDATE)
) 
SELECT SUM(AMT) OVER(PARTITION BY YR) AS SMT,YR
FROM CTE_MONTHLY;
 
 
 -- lets create the view
 create view v_MONTHLY AS(
SELECT SUM(AMOUNT) AS AMT, YEAR(PAYMENTDATE) AS YR, MONTH(PAYMENTDATE),
count(checkNumber) as NOofCheck
FROM PAYMENTS
GROUP BY YEAR(PAYMENTDATE), MONTH(PAYMENTDATE)
ORDER BY YEAR(PAYMENTDATE)
) 
;
select * from v_monthly;

-- this is how we create view -- and we can use it
-- 
SELECT SUM(AMT) OVER(PARTITION BY YR) AS SMT,YR
FROM v_monthly;
-- see how we can put a logic

-- if we want to put it in our schema then we can specify this as 
create view classicmodels.v_MONTHLY AS(
SELECT SUM(AMOUNT) AS AMT, YEAR(PAYMENTDATE) AS YR, MONTH(PAYMENTDATE),
count(checkNumber) as NOofCheck
FROM PAYMENTS
GROUP BY YEAR(PAYMENTDATE), MONTH(PAYMENTDATE)
ORDER BY YEAR(PAYMENTDATE)
) 
;

-- what if you dont want to keep this you can simply drop

DROP VIEW v_monthly;


-- how to change a logic inside the view

-- lets make a view that combines orders, products, customers, employees,

SELECT * FROM CUSTOMERS;
CREATE VIEW DAT AS (
SELECT c.customerNumber, c.customerName, CONCAT_WS(c.contactFirstName, ' ',c.contactLastName) as 'Full Name', c.creditLimit, 
c.repNumber, c.country, p.amount as 'Amount paid'
FROM customers c
LEFT JOIN payments p ON c.customerNumber=p.customerNumber)
;

SELECT * FROM dat;

-- provide a view for EU sales team that combines details from all tables and excludes data related to the usa
create view eu_data AS(
select * from dat
where country NOT IN ('USA'));

select * from eu_data;

-- here we are protecting rows from USA

-- here we can create a view which is available to everyone, another view which is only relevant to france sales team, australia sales team and so on
-- so VIEW helps us to create this security