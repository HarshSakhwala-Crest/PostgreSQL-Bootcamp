-- INSERTING DATA INTO A TABLE
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

SELECT * FROM customers;


-- INSERT A RECORD
INSERT INTO customers (first_name, last_name, email, age) 
VALUES 
('Harsh','Sakhwala','harshsakhwala@gmail.com',21);

SELECT * FROM customers;


-- INSERT MULTIPLE RECORDS
INSERT INTO customers (first_name, last_name)
VALUES 
('Vraj','Desai'),
('Vatsal','Chauhan'),
('Aneri','Desai'),
('Meet','Mavani'),
('Jeet','Prajapati');

SELECT * FROM customers;


-- INSERT A RECORD WITH QUOTES
INSERT INTO customers (first_name, last_name)
VALUES
('Kevin','O''Brian');

SELECT * FROM customers;


--RETURNING TO GET INFO ON ADDED ROWS
INSERT INTO customers (first_name, last_name)
VALUES
('Sahil','Kalariya') RETURNING *;


INSERT INTO customers (first_name, last_name)
VALUES 
('Meet','Kothari'),
('Deep','Dabhi') RETURNING first_name;