/* lWe can use various Arithmetic Operators on the data stored in the tables.
Arithmetic Operators are:

+           [Addition]
-           [Subtraction]
/           [Division]
*           [Multiplication]
%           [Modulus] 
*/
-- Here we will be using Classimodels database--
USE classicmodels;
SELECT 
    customerNumber, customerName, creditLimit
FROM
    customers
ORDER BY creditLimit;
-- lets add 20000 credit limit to few customers you want give more credit--
SELECT 
    creditLimit + 20000 AS new, customerNumber, creditLimit
FROM
    customers
WHERE
    customerNumber IN (125 , 128, 183, 145, 167);

-- Multiplication--
-- lets calculate the total amount ordered per productcode
SELECT 
    o.quantityOrdered * o.priceEach AS total,
    o.productCode,
    p.productName
FROM
    orderdetails o
        JOIN
    products p ON o.productCode = p.productCode;

-- Another way you can use * is by using aggregate function--
SELECT 
    SUM(o.quantityOrdered * o.priceEach) AS total,
    o.productCode,
    p.productName
FROM
    orderdetails o
        JOIN
    products p ON o.productCode = p.productCode
GROUP BY o.productCode , p.productName;

-- lets do substration--
-- lets deduct the employee number from credit limit, lets see who has sales rep with less employeenumber.alter

SELECT 
    *
FROM
    customers;
-- I THOUGH WHY NOT DISPLAY THE DIFF, AND THE ACTUAL NUMBER TO TALLY IF WE ARE OFF THE A ROCKING START--
SELECT 
    creditLimit - salesRepEmployeeNumber AS deducted,
    creditLimit,
    salesRepEmployeeNumber,
    customerNumber,
    ABS(creditLimit - salesRepEmployeeNumber) AS diff
FROM
    customers
GROUP BY creditLimit , salesRepEmployeeNumber , customerNumber;

-- DIVISION-----*******8*********
-- TOO LONG COLUMN NAME, HARD TO TYPE EVERYTIME----
ALTER TABLE customers
RENAME COLUMN salesRepEmployeeNumber TO repnumber;

-- lets divide credit limit by their representative's number--
SELECT 
    customerNumber,
    repnumber,
    creditlimit,
    creditlimit / repnumber AS 'Divided Column'
FROM
    customers
ORDER BY creditLimit DESC;


-- Modulus-----********** lusss lussss lussssssssss modulussss-----

-- it is used to get remainder when one data is dived by another.
select customerNumber%50 as NEW, customerNumber, repnumber
FROM customers;



