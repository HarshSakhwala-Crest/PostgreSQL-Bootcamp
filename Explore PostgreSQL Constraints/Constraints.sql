-- NOT NULL CONSTRAINT
-- ADD TO COLUMN
CREATE TABLE not_null_column (
	id SERIAL PRIMARY KEY,
	tag TEXT NOT NULL
);

INSERT INTO not_null_column (tag)
VALUES
('Harsh');

INSERT INTO not_null_column (tag)
VALUES
(NULL);

INSERT INTO not_null_column (tag)
VALUES
('');

SELECT * FROM not_null_column;


-- ADD TO TABLE
CREATE TABLE not_null_table (
	id SERIAL PRIMARY KEY,
	tag TEXT
);


ALTER TABLE not_null_table
ALTER COLUMN tag 
SET NOT NULL;


INSERT INTO not_null_table (tag)
VALUES
('Harsh');

INSERT INTO not_null_table (tag)
VALUES
(NULL);

SELECT * FROM not_null_table;


-- UNIQUE CONSTRAINT
-- ADD TO COLUMN
CREATE TABLE emails (
	id SERIAL PRIMARY KEY,
	email TEXT UNIQUE
);

INSERT INTO emails (email)
VALUES
('a@b.com');

INSERT INTO emails (email)
VALUES
('a@b.com');

SELECT * FROM emails;


-- ADD TO TABLE
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	code VARCHAR(10),
	name TEXT
	-- UNIQUE (code, name)
);


ALTER TABLE products
ADD CONSTRAINT "Unique" UNIQUE (code, name);


INSERT INTO products (code, name)
VALUES
('a','apple'),
('b','ball');

INSERT INTO products (code, name)
VALUES
('apple','a');

INSERT INTO products (code, name)
VALUES
('b','bell');

SELECT * FROM products;


-- DEFAULT CONSTRAINT
-- ADD TO COLUMN
CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	is_enable VARCHAR(2) DEFAULT 'Y'
);

INSERT INTO employees (first_name, last_name)
VALUES
('Christopher','Nolan');

SELECT * FROM employees;


-- ADD TO TABLE
ALTER TABLE employees
ALTER COLUMN is_enable 
SET DEFAULT 'N';


INSERT INTO employees (first_name, last_name)
VALUES
('Zack','Synder');

SELECT * FROM employees;


-- DROP DEFAULT CONSTRAINT
ALTER TABLE employees
ALTER COLUMN is_enable 
DROP DEFAULT;


INSERT INTO employees (first_name, last_name)
VALUES
('Stan','Lee');

SELECT * FROM employees;


-- PRIMARY KEY CONSTRAINT
-- ON SINGLE COLUMN
-- ADD TO COLUMN
CREATE TABLE items (
	id INTEGER PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

INSERT INTO items (id, name)
VALUES
(1, 'pen'),
(2, 'pencil');

INSERT INTO items (id, name)
VALUES
(1, 'pen');

SELECT * FROM items;


-- ADD TO TABLE
-- DROP PRIMARY KEY CONSTRAINT
ALTER TABLE items
DROP CONSTRAINT items_pkey;


ALTER TABLE items
ADD PRIMARY KEY (id);

ALTER TABLE items
ADD PRIMARY KEY (id, name);


INSERT INTO items (id, name)
VALUES
(2, 'pencil');

INSERT INTO items (id, name)
VALUES
(2, '');

SELECT * FROM items;


-- ON MULTIPLE COLUMNS - COMPOSITE KEY
-- ADD TO COLUMN
CREATE TABLE grades (
	course_id VARCHAR(100) NOT NULL,
	student_id VARCHAR(100) NOT NULL,
	grade INT NOT NULL,
	PRIMARY KEY (course_id, student_id)
);

INSERT INTO grades (course_id, student_id, grade)
VALUES
('Math','S1', 50),
('Chemistry','S1', 70),
('English','S2', 70),
('Physics','S1', 80),
('Math','S2', 70);

INSERT INTO grades (course_id, student_id, grade)
VALUES
('Math','S1', 70);

SELECT * FROM grades;


-- ADD TO TABLE
-- DROP PRIMARY KEY CONSTRAINT
ALTER TABLE grades
DROP CONSTRAINT grades_pkey;


ALTER TABLE grades
ADD CONSTRAINT grades_course_id_student_id_pkey
PRIMARY KEY (course_id, student_id);


-- FOREIGN KEY CONSTRAINT
-- TABLES WITHOUT FOREIGN KEY CONSTRAINT
CREATE TABLE t_suppliers (
	supplier_id INT PRIMARY KEY,
	supplier_name VARCHAR(50) NOT NULL
);

CREATE TABLE t_products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	supplier_id INT NOT NULL
);

INSERT INTO t_suppliers (supplier_id, supplier_name)
VALUES
(1, 'S1'),
(2, 'S2');

SELECT * FROM t_suppliers;

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES
(1,'pen', 1),
(2,'pencil', 2);

SELECT * FROM t_products;

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES
(3,'eraser', 10);

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES
(4,'bag', 100);

SELECT * FROM t_products;


-- TABLES WITH FOREIGN KEY CONSTRAINT
-- ADD TO COLUMN
DROP TABLE t_suppliers;

CREATE TABLE t_suppliers (
	supplier_id INT PRIMARY KEY,
	supplier_name VARCHAR(50) NOT NULL
);

DROP TABLE t_products;

CREATE TABLE t_products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	supplier_id INT NOT NULL,
	FOREIGN KEY (supplier_id) REFERENCES t_suppliers (supplier_id) 
);

INSERT INTO t_suppliers (supplier_id, supplier_name)
VALUES
(1, 'S1'),
(2, 'S2');

SELECT * FROM t_suppliers;

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES
(1,'pen', 1),
(2,'pencil', 2);

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES
(3,'eraser', 10);

SELECT * FROM t_products;


DELETE FROM t_products WHERE product_id = 1;

DELETE FROM t_suppliers WHERE supplier_id = 1;


UPDATE t_products
SET supplier_id = 5
WHERE product_id = 2;


-- DROP FOREIGN KEY CONSTRAINT
ALTER TABLE t_products
DROP CONSTRAINT t_products_supplier_id_fkey;


-- ADD TO TABLE
ALTER TABLE t_products
ADD CONSTRAINT t_products_supplier_id_fkey 
FOREIGN KEY (supplier_id) REFERENCES t_suppliers (supplier_id);


-- CHECK CONSTRAINT
-- ADD TO COLUMN
CREATE TABLE staff (
	staff_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	birth_date DATE CHECK (birth_date > '1900-01-01'),
	joining_date DATE CHECK (joining_date > birth_date),
	salary NUMERIC CHECK (salary > 0)
);

INSERT INTO staff (first_name, last_name, birth_date, joining_date, salary)
VALUES
('Adam','King','1999-01-01','2002-01-02',100);

INSERT INTO staff (first_name, last_name, birth_date, joining_date, salary)
VALUES
('John','Adams','2020-01-01','2020-01-01',150);

INSERT INTO staff (first_name, last_name, birth_date, joining_date, salary)
VALUES
('John','Adams','2010-01-01','2020-01-01',-50);

SELECT * FROM staff;


UPDATE staff
SET salary = 0
WHERE staff_id = 1;


-- ADD TO TABLE
CREATE TABLE prices (
	price_id SERIAL PRIMARY KEY,
	product_id INT NOT NULL,
	price NUMERIC NOT NULL,
	discount NUMERIC NOT NULL,
	valid_from DATE NOT NULL
);


ALTER TABLE prices
ADD CONSTRAINT price_check 
CHECK (price > 0 AND discount >= 0 AND price > discount);


INSERT INTO prices (product_id, price, discount, valid_from)
VALUES
(1, 100, 20,'2020-10-01'),
(2, 40, 5,'2016-05-07');

INSERT INTO prices (product_id, price, discount, valid_from)
VALUES
(1, 100, 1200,'2020-10-01');

SELECT * FROM prices;


-- RENAME CONSTRAINT
ALTER TABLE prices
RENAME CONSTRAINT price_check TO price_discount_check;


-- DROP CONSTRAINT
ALTER TABLE prices
DROP CONSTRAINT price_discount_check;


ALTER TABLE prices
ADD CONSTRAINT price_discount_check 
CHECK (price > 0 AND discount >= 5 AND price >= discount);