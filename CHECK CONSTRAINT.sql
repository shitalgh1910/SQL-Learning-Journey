USE MKCL2;
DROP TABLE employee;
CREATE TABLE employee (
    employeeid INT PRIMARY KEY NOT NULL,
    firstname VARCHAR(20),
    lastname VARCHAR(20),
    hourlypay DECIMAL(6 , 2 ),
    hiredate DATETIME
);

SELECT 
    *
FROM
    employee;
-- Lets insert some value--
INSERT INTO employee(employeeid, firstname, lastname, hourlypay, hiredate)
VALUES (1,'david','becham',25.05, '2024-02-02'),
(2,'jame','furgeson',45.50,'2021-02-03'),
(3,'randy','orton',35.00,'2023-09-03');
-- Lets add the constraint--
ALTER TABLE employee
ADD CONSTRAINT chkhourlypay CHECK(hourlypay>=20.05);

SELECT 
    *
FROM
    employee;
-- Here is the main thing CHECK CONSTRAINT DO, IF WE WANT TO ADD A VALUE THAT IS LESS THAN WHAT WE HAVE DEFINED IN THE CHECK CLAUSE
-- IT IS GOING TO SAY Check constraint 'chkhourlypay' is violated.
INSERT INTO employee
VALUES (4, 'john','cena', 15.00,'2022-04-04');
-- LETS TRY TO INSERT THE HOURLY PAY FOR BIRAT WHICH IS MORE THAN WHAT HAS BEEN DEFINED IN CHECK CONSTRAINT--
INSERT INTO employee
VALUES (4, 'john','cena', 44.00,'2022-04-04');

SELECT 
    *
FROM
    employee;

-- Now if we want to drop the check constraint we can do so by using alter--

ALTER TABLE employee
DROP CHECK chkhourlypay;

-- Now lets try to add a value that is less than 20.05 which is defined in check constraint

INSERT INTO employee(employeeid, lastname, firstname, hourlypay, hiredate)
VALUES(5,'thapa','remon',12.00,'2020-02-07');

-- Now this allows us to add less than 20.05 because the check constraint has been dropped--

-- Thats all for check constraint-- 
select * from employee;

