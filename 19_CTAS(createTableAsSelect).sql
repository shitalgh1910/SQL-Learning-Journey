-- lets make a ctas with the total number of payments done each year
CREATE VIEW T2 AS(
SELECT YEAR(PAYMENTDATE) as payment_year, COUNT(AMOUNT) as payment_count, CUSTOMERNUMBER
FROM payments
group by YEAR(PAYMENTDATE), CUSTOMERNUMBER);

-- lets create a ctas and see if we update something in our main table lets see if it changes in in ctas  or not
DROP TABLE t3;
CREATE TABLE T3 AS(
SELECT YEAR(PAYMENTDATE) as payment_year, COUNT(AMOUNT) as payment_count, CUSTOMERNUMBER
FROM payments
group by YEAR(PAYMENTDATE), CUSTOMERNUMBER);

INSERT INTO customers (
    customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city, country
)
VALUES (
    222, 'Temp Customer', 'Doe', 'John', '123456789', '123 Main St', 'Testville', 'Testland'
);
-- if a column in a primary key to some other table then sql will not allow you to change it-- 
-- so i addedd a customerid with 222

-- NOW WE HAVE CREATED VIEW AND CTAS 

-- lets update the customernumber in the main table and check if the change occurs in view or ctas

SET SQL_SAFE_UPDATES = 0;
UPDATE payments
SET CUSTOMERNUMBER=222
WHERE CUSTOMERNUMBER=103;

-- check from view
SELECT * FROM t2
order by customernumber;
-- check from ctas
select * from t3
order by customerNumber;

/** here we can see that when we update the data in main table then the result we get from view
is the changed result because when we create a view then a virtual table with the query 
is stored in the database, when we execture the query then that query is executed fetching 
the data and then giving the result. where in CTAS the data is already fetched and stored in a table
and there is a change in main table then there will not be any changes in your result
**/


-- if you want to see the updated, you go and drop the ctas table and then run the query again...
