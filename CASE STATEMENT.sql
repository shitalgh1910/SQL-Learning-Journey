-- lets dive into CASE STATEMENT--
SELECT 
    *
FROM
    customers;
SELECT 
    creditLimit
FROM
    customers
ORDER BY creditLimit DESC;
SELECT 
    customerName,
    customerNumber,
    creditLimit,
    CASE
        WHEN creditLimit BETWEEN 0 AND 50000 THEN 'LOW'
        WHEN creditLimit BETWEEN 50000 AND 100000 THEN 'MEDIUM'
        WHEN creditLimit > 100000 THEN 'HIGH'
    END AS category
FROM
    customers;

-- Lets try one more example--
-- Lets try to join two table and see what are the products selling as low selling, medium selling and high selling'
SELECT 
    SUM(quantityOrdered * priceEach) AS totalsold, productCode
FROM
    orderdetails
GROUP BY productCode
ORDER BY totalsold;

SELECT 
    p.productName,
    p.productLine,
    SUM(o.quantityOrdered * o.priceEach) AS Total_Sold,
    CASE
        WHEN SUM(o.quantityOrdered * o.priceEach) BETWEEN 0 AND 50000 THEN 'LOW SELLING ITEM'
        WHEN SUM(o.quantityOrdered * o.priceEach) BETWEEN 50000 AND 100000 THEN 'MEDIUM SELLING ITEM'
        WHEN SUM(o.quantityOrdered * o.priceEach) BETWEEN 100000 AND 200000 THEN 'HIGH SELLING ITEM'
        ELSE 'BEST SELLING ITEMS'
    END AS category
FROM
    orderdetails AS o
        JOIN
    products AS p ON o.productCode = p.productCode
GROUP BY p.productName , p.productLine
ORDER BY Total_Sold;

-- This is how we can use CASE STATEMENT TO SPECIFY THE CONDITION--
