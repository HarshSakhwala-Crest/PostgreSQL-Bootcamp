-- DOMAIN DATA TYPE
CREATE DOMAIN addr AS VARCHAR(100) NOT NULL;

CREATE TABLE location(
	address addr
);

INSERT INTO location
VALUES
('123 London');

SELECT * FROM location;


-- DOMAIN FOR INTEGER VALUES
CREATE DOMAIN positive_numeric AS INT NOT NULL CHECK (VALUE > 0);

CREATE TABLE sample(
	sample_id SERIAL PRIMARY KEY,
	value_num positive_numeric
);

INSERT INTO sample (value_num)
VALUES
(10);

INSERT INTO sample (value_num)
VALUES
(-5);

SELECT * FROM sample;


-- DOMAIN FOR POSTAL CODE VALIDATION
CREATE DOMAIN us_postal_code AS TEXT 
CHECK (VALUE ~ '^\d{5}$' OR VALUE ~ '^\d{5}-\d{4}$');

CREATE TABLE address(
	address_id SERIAL PRIMARY KEY,
	postal_code us_postal_code
);

INSERT INTO address (postal_code)
VALUES
('10000'),
('10000-1000');

INSERT INTO address (postal_code)
VALUES
('10000-1000-1000');

SELECT * FROM address;


-- DOMAIN FOR EMAIL VALIDATION
CREATE DOMAIN proper_email AS VARCHAR(150)
CHECK (VALUE ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');

CREATE TABLE clients(
	client_id SERIAL PRIMARY KEY,
	email proper_email
);

INSERT INTO clients (email)
VALUES
('a@b.com'),
('c@d.com');

INSERT INTO clients (email)
VALUES
('a @ b.com');

SELECT * FROM clients;


-- DOMAIN FOR ENUMERATION TYPE
CREATE DOMAIN valid_color AS VARCHAR(10)
CHECK (VALUE IN ('red','green','blue'));

CREATE TABLE colors(
	color valid_color
);

INSERT INTO colors 
VALUES
('green'),
('red');

INSERT INTO colors 
VALUES
('orange');

SELECT * FROM colors;


-- GET ALL DOMAINS IN A SCHEMA
-- USING PGADMIN GUI : SEE LIST OF DOMAINS IN PUBLIC SCHEMA

SELECT typname
FROM pg_catalog.pg_type
JOIN pg_catalog.pg_namespace
ON pg_namespace.oid = pg_type.typnamespace
WHERE 
typtype = 'd' AND nspname = 'public';


-- DROP A DOMAIN
DROP DOMAIN positive_numeric;

DROP DOMAIN positive_numeric CASCADE;

SELECT * FROM sample;


DROP DOMAIN valid_color;

SELECT * FROM colors;

ALTER TABLE colors
ALTER COLUMN color TYPE TEXT;

DROP DOMAIN valid_color CASCADE;