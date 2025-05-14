 USE classicmodels;
 
 SELECT * FROM PAYMENTS;
 -- RANK-- 
 -- THIS WINDOW FUNCTION ASSIGNS A RANK IN A WINDOW BUT WITH GAPS
 -- FOR EXAMPLE THERE ARE 3 CUSTOMERS WITH CUSTOMERID 103 SO IT WILL GIVE
 -- RANK 1 TO CUSTOMER WITH CUSTOMERID 103 AND AS THERE ARE 3 OF THEM
 -- THE NEXT RANK IT GIVES TO ANOTHER CUSTOMER WITH CUSTOMERID112 IS 4.
 SELECT amount,RANK() OVER(ORDER BY customerNumber) salesRank,customerNumber,
 DENSE_RANK() OVER(ORDER BY CUSTOMERNUMBER) denserank,ROUND(CUME_DIST() OVER(ORDER BY CUSTOMERNUMBER),2) as cumrank,ROW_NUMBER() OVER(ORDER BY AMOUNT) asrownumber
 FROM PAYMENTS;
 
 -- LETS USE DENSE_RANK
  -- IN DENSE RANK, THERE WILL NOT BE ANY GAPS
 
 SELECT customerNumber, amount, DENSE_RANK() OVER(ORDER BY CUSTOMERNUMBER)
 FROM PAYMENTS;
 
 -- LETS USE CUMME_DISTRIBUTION
 
  SELECT customerNumber, amount, ROUND(CUME_DIST() OVER(ORDER BY CUSTOMERNUMBER),2)
 FROM PAYMENTS;
 
 -- LETS USE ROW NUMBER
  SELECT customerNumber, amount, ROW_NUMBER() OVER(ORDER BY AMOUNT)
 FROM PAYMENTS;
 
 -- LETS USE PERCENT_RANK()
  SELECT customerNumber, amount, PERCENT_RANK() OVER(ORDER BY CUSTOMERNUMBER)
 FROM PAYMENTS;
 
 -- lets explore the use cases of ROW_NUMBER
 -- LETS TO TOP_N ANALYSIS
 -- LETS FIND THE TOP AMOUNT PAID BY EACH CUSTOMER
 SELECT * FROM (
 select customerNumber, amount, ROW_NUMBER() OVER(PARTITION BY customerNumber order by amount desc) RANKOFPRODUCT
 from payments) T WHERE RANKOFPRODUCT=1;
 
 -- LETS FIND THE LOWEST TWO CUSTOMER BASED ON THEIR AMOUNT PAID
 select * from(
 SELECT customerNumber, sum(amount) totalamount,ROW_NUMBER() OVER(ORDER BY SUM(amount)) as rownumber
 from payments
 group by customerNumber) t
 where rownumber<=2;
 
 -- lets say we have a table but we dont have a unique id primarykey
 -- now we want to assign primaryKye(iD)
 select *,ROW_NUMBER() OVER(ORDER BY customerNumber) UniqueID from payments;
 
 -- here we created a uniqueID 
 
 -- NTILE--
 SELECT amount, NTILE(20) OVER(ORDER BY AMOUNT) from payments;
 --
 
 -- LETS USE IT FOR DATA SEGMENTATION
 select *, CASE
 WHEN buckets=1 THEN 'HIGH'
 WHEN buckets=2 THEN 'MEDIUM'
 WHEN buckets=3 THEN 'LOW' 
 END AS CATERGOORY FROM (
 SELECT amount, customerNumber,
 NTILE(3) OVER(ORDER BY AMOUNT desc) buckets
 FROM payments) AS T ;
 -- here we categorise the amount in 3 categoire, high, low, and medium
 
 -- LETS USE NTILE() TO EXPORT THE DATA, DIVIDE THE ORDERS INTO TWO GROUP
 SELECT * FROM CUSTOMERS;
 -- I HAVE 122 CUSTOMERS RIGHT? NOW I WOULD LIKE TO TRANSFER THIS TABLE TO A DIFFERENT DATABASE
 -- WHAT I CAN DO IS I CAN DIVIDE THIS TO TWO BUCKETS AND THEN TRANSFER
 
 SELECT *,NTILE(2) OVER(ORDER BY CUSTOMERNUMBER)
 FROM CUSTOMERS;
 -- NOW WE DIVIDED IT TO TWO BUCKETS
 -- lets find the customers that falls within the highest 40% of customers
 
 SELECT * FROM payments;
 select *,round(concat(distrank*100,'%'),2) as distrankper  from (
 select customerNumber, amount,CUME_DIST() OVER(ORDER BY amount) distrank
 from payments) as t 
 where distrank<=0.40;
 