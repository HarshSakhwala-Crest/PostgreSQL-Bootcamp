-- COMPOSITE DATA TYPE
-- COMPOSITE TYPE FOR ADDRESS
CREATE TYPE address AS (
	city VARCHAR(50),
	country VARCHAR(20)
);


CREATE TABLE companies (
	comp_id SERIAL PRIMARY KEY,
	address address
);

INSERT INTO companies (address)
VALUES
(('London','UK'));

INSERT INTO companies (address)
VALUES
(ROW('New York','USA'));

SELECT * FROM companies;

SELECT (address).country FROM companies;

SELECT (companies.address).city FROM companies;


-- COMPOSITE TYPE FOR INVENTORY ITEM
CREATE TYPE inventory_item AS (
	name VARCHAR(20),
	supplier_id INT,
	price NUMERIC
);

CREATE TABLE inventory(
	inventory_id SERIAL PRIMARY KEY,
	item inventory_item
);

INSERT INTO inventory (item)
VALUES
(ROW('pen', 10, 4.99)),
(('pencil', 20, 10.99));

SELECT * FROM inventory;

SELECT (item).name FROM inventory
WHERE (item).price < 5.99;


-- DROP A COMPOSITE TYPE
CREATE TYPE sample_type AS ENUM ('ABC','123','XYZ');

DROP TYPE sample_type;


-- ALTER A COMPOSITE TYPE
CREATE TYPE myaddress AS (
	city VARCHAR(50),
	country VARCHAR(20)
);


-- RENAME A COMPOSITE TYPE
ALTER TYPE my_address
RENAME TO myaddress;


-- CHANGE OWNER OF A COMPOSITE TYPE
ALTER TYPE myaddress
OWNER TO postgres;


-- CHANGE SCHEMA OF A COMPOSITE TYPE
ALTER TYPE myaddress
SET SCHEMA test_schema;


-- ADD AN ATTRIBUTE IN COMPOSITE TYPE
ALTER TYPE test_schema.myaddress
ADD ATTRIBUTE street_address VARCHAR(150);