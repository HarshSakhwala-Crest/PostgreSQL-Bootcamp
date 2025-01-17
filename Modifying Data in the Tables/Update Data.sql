-- UPDATING DATA INTO A TABLE
SELECT * FROM customers;


-- UPDATE A RECORD
-- UPDATE A COLUMN
UPDATE customers
SET email = 'meetmavani@gmail.com'
WHERE last_name = 'Mavani';

SELECT * FROM customers;


-- UPDATE MULTIPLE COLUMNS
UPDATE customers 
SET email = 'deepdabhi@gmail.com', age = 21
WHERE first_name = 'Deep';

SELECT * FROM customers;


-- RETURNING TO GET INFO ON UPDATED ROWS
UPDATE customers
SET email = 'sahilkalariya@gmail.com', age = 20
WHERE first_name = 'Sahil'
RETURNING *;


-- UPDATE MULTIPLE RECORDS
-- USING PGADMIN GUI : CREATE A NEW COLUMN
SELECT * FROM customers;

UPDATE customers
SET is_student = 'Y'
RETURNING *;