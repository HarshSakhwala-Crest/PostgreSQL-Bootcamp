-- CREATE A SEQUENCE
-- WITHOUT START VALUE
CREATE SEQUENCE IF NOT EXISTS test_sequence;


-- ADVANCE A SEQUENCE - NEXT VALUE OF A SEQUENCE
SELECT NEXTVAL('test_sequence');

SELECT NEXTVAL('test_sequence');

SELECT NEXTVAL('test_sequence');


-- CURRENT VALUE OF A SEQUENCE
SELECT CURRVAL('test_sequence');

SELECT CURRVAL('test_sequence');


-- SET VALUE OF A SEQUENCE
-- WITH SKIPPING OVER
SELECT SETVAL('test_sequence', 100);

SELECT NEXTVAL('test_sequence');


-- WITHOUT SKIPPING OVER
SELECT SETVAL('test_sequence', 10, FALSE);

SELECT NEXTVAL('test_sequence');

SELECT NEXTVAL('test_sequence');


-- WITH START VALUE
CREATE SEQUENCE IF NOT EXISTS start_sequence START WITH 100;

SELECT NEXTVAL('start_sequence');


-- ALTER A SEQUENCE
-- RESTART A SEQUENCE
ALTER SEQUENCE test_sequence RESTART WITH 100;

SELECT NEXTVAL('test_sequence');


-- RENAME A SEQUENCE
ALTER SEQUENCE test_sequence RENAME TO mysequence;


-- USING PGADMIN GUI : ALTER A SEQUENCE


-- WITH SEQUENCE PARAMETERS
CREATE SEQUENCE IF NOT EXISTS parameters_sequence
START WITH 400
INCREMENT 20
MINVALUE 400
MAXVALUE 600;

SELECT NEXTVAL('parameters_sequence');

SELECT NEXTVAL('parameters_sequence');


-- WITH A SPECIFIC DATA TYPE
CREATE SEQUENCE IF NOT EXISTS datatype_sequence AS SMALLINT;

SELECT NEXTVAL('datatype_sequence');


-- DESCNDING SEQUENCE
CREATE SEQUENCE IF NOT EXISTS descending_sequence
START 3
INCREMENT -1
MINVALUE 1
MAXVALUE 3
NO CYCLE;

SELECT NEXTVAL('descending_sequence');

SELECT NEXTVAL('descending_sequence');

SELECT NEXTVAL('descending_sequence');

SELECT NEXTVAL('descending_sequence');


-- CYCLE SEQUENCE
CREATE SEQUENCE IF NOT EXISTS cycle_sequence
START 3
INCREMENT -1
MINVALUE 1
MAXVALUE 3
CYCLE;

SELECT NEXTVAL('cycle_sequence');

SELECT NEXTVAL('cycle_sequence');

SELECT NEXTVAL('cycle_sequence');

SELECT NEXTVAL('cycle_sequence');


-- DELETE A SEQUENCE
DROP SEQUENCE IF EXISTS mysequence;

DROP SEQUENCE IF EXISTS start_sequence;

DROP SEQUENCE IF EXISTS datatype_sequence;

DROP SEQUENCE IF EXISTS descending_sequence;

DROP SEQUENCE IF EXISTS cycle_sequence;


-- USING PGADMIN GUI : DELETE A SEQUENCE


-- ATTACH SEQUENCE TO A TABLE
-- WITH SERIAL DATA TYPE
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	user_name VARCHAR(50)
);

INSERT INTO users (user_name)
VALUES
('Adam'),
('Chris');

SELECT * FROM users;


SELECT SETVAL('users_user_id_seq', 10, FALSE);

INSERT INTO users (user_name)
VALUES
('Brian');

SELECT * FROM users;


ALTER SEQUENCE users_user_id_seq RESTART WITH 100;

INSERT INTO users (user_name)
VALUES
('Dom');

SELECT * FROM users;


-- WITH CREATING A NEW SEQUENCE
CREATE TABLE assign_sequence (
	user_id INT PRIMARY KEY,
	user_name VARCHAR(50)
);

CREATE SEQUENCE IF NOT EXISTS assign_table_sequence
START WITH 100 OWNED BY assign_sequence.user_id;

ALTER TABLE assign_sequence
ALTER COLUMN user_id 
SET DEFAULT NEXTVAL('assign_table_sequence');

INSERT INTO assign_sequence (user_name)
VALUES
('Adam'),
('Chris');

SELECT * FROM assign_sequence;


-- LIST ALL SEQUENCES
SELECT relname sequence_name
FROM pg_class
WHERE relkind = 'S';


-- SHARE A SEQUENCE AMONG TABLES
CREATE SEQUENCE IF NOT EXISTS common_fruits START WITH 100;

CREATE TABLE apples (
	fruit_id INT DEFAULT NEXTVAL('common_fruits'),
	fruit_name VARCHAR(50)
);

CREATE TABLE mangoes (
	fruit_id INT DEFAULT NEXTVAL('common_fruits'),
	fruit_name VARCHAR(50)
);

INSERT INTO apples (fruit_name)
VALUES
('Apple1'),
('Apple2');

SELECT * FROM apples;

INSERT INTO mangoes (fruit_name)
VALUES
('Mango1'),
('Mango2');

SELECT * FROM mangoes;


-- ALPHANUMERIC SEQUENCE
CREATE SEQUENCE IF NOT EXISTS alphanumeric_sequence;

CREATE TABLE contacts (
	contact_id TEXT DEFAULT ('ID' || NEXTVAL('alphanumeric_sequence')),
	contact_name VARCHAR(150)
);

ALTER SEQUENCE alphanumeric_sequence
OWNED BY contacts.contact_id;

INSERT INTO contacts (contact_name)
VALUES
('Adam'),
('Chris');

SELECT * FROM contacts;