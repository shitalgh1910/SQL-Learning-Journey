/* IN NON-RECURSIVE CTEs THE CTE IS EXECUTED JUST ONCE, IN RECURSIVE IT GOES ON A LOOP
UNTIL THE CONDITION SPECIFIED IS NOT SATISFIED */  

-- GENERATE A NUMBER OF SEQUENCE FROM 1 TO 20
-- ANCHOR QUERY
WITH RECURSIVE series AS (
SELECT 1 AS MYNUMBER
UNION ALL
-- RECURSIVE QUERY
SELECT MYNUMBER+1
FROM series
WHERE MYNUMBER<20)
-- main query
SELECT * FROM series;
-- IN MYSQL YOU HAVE TO SPECI FY RECURSIVE INORDER FOR IT TO WORK
-- WE CAN LIMIT IT AS WELL, FOR MAXIMUM NO OF ITERATIL 




