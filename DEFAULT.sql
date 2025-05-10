
-- Lets start guyssssss--- this looks fun-- -- it was soo boring before i used to take this as i have to learn this to get a job
-- now my perception is I am learning this to actually learn and KNOW how these things work.
CREATE TABLE cart_items(
item_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
quantity INT NOT NULL,
price DECIMAL(6,2) NOT NULL,
sales_tax DECIMAL(6,2) NOT NULL DEFAULT 0.1,
CHECK (quantity>0),
CHECK(sales_tax>=0));
-- lets see if we have successfully created the table--
DESCRIBE cart_items;
INSERT INTO cart_items(name, quantity, price)
VALUES('keyboard',1,50);
-- WE CAN SEE THE DEFAULT VALUE ON SALES_TAX COLUMN IS 10%.--
SELECT * FROM cart_items;


