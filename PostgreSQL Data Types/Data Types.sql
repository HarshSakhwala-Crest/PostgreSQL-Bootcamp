-- BOOLEAN DATA TYPE
CREATE TABLE boolean(
	product_id SERIAL PRIMARY KEY,
	is_available BOOLEAN NOT NULL
);

INSERT INTO boolean (is_available)
VALUES
(TRUE),
(FALSE),
('true'),
('false'),
('t'),
('f'),
('yes'),
('no'),
('y'),
('n'),
('1'),
('0');

SELECT * FROM boolean;


SELECT * FROM boolean
WHERE is_available = TRUE;

SELECT * FROM boolean 
WHERE is_available = '0';

SELECT * FROM boolean
WHERE is_available = 'y';

SELECT * FROM boolean
WHERE is_available = 'no';


SELECT * FROM boolean
WHERE NOT is_available;


ALTER TABLE boolean 
ALTER COLUMN is_available
SET DEFAULT FALSE;


INSERT INTO boolean (product_id)
VALUES
(14);


-- CHARACTER DATA TYPE
-- CHARACTER(N), CHAR(N) 
SELECT CAST('Harsh' AS CHARACTER(10)) AS "Name";
"Harsh     "

SELECT 'Harsh'::CHAR(10) AS "Name";
"Harsh     "

SELECT 'Harsh'::CHAR AS "Name";
"H"


-- CHARACTER VARYING(N), VARCHAR(N)
SELECT 'Harsh'::VARCHAR(10) AS "Name";
"Harsh"

SELECT 'This is a test statement'::CHARACTER VARYING(10) AS "Statement";
"This is a "

SELECT 'This is a test statement'::VARCHAR AS "Statement";
"This is a test statement"


-- TEXT
SELECT 'This is a test statement'::TEXT AS "Statement";


CREATE TABLE characters(
	col_char CHAR(10),
	col_varchar VARCHAR(10),
	col_text TEXT
);

INSERT INTO characters (col_char, col_varchar, col_text)
VALUES
('abc','abc','abc'),
('xyz','xyz','xyz');

SELECT * FROM characters;
"abc       "	"abc"	"abc"
"xyz       "	"xyz"	"xyz"


-- NUMERIC DATA TYPE
-- INTEGER
CREATE TABLE serial(
	col_smallint SMALLINT,
	col_int INT,
	col_bigint BIGINT,
	col_smallserial SMALLSERIAL,
	col_serial SERIAL PRIMARY KEY,
	col_bigserial BIGSERIAL,
	product_name VARCHAR(100)
);

INSERT INTO serial (col_smallint, col_int, col_bigint, product_name)
VALUES
(1, 1, 1, 'pen'),
(2, 2, 2, 'pencil'),
(3, 3, 3, 'erasor');

SELECT * FROM serial;


-- DECIMAL
CREATE TABLE decimal(
	col_numeric NUMERIC(20, 5),
	col_decimal DECIMAL(20, 3),
	col_real REAL,
	col_double DOUBLE PRECISION
);

INSERT INTO decimal (col_numeric, col_decimal, col_real, col_double)
VALUES
(.9, .9, .9, .9),
(3.13579, 3.13579, 3.13579, 3.13579),
(4.135787654, 4.135787654, 4.135787654, 4.135787654);

SELECT * FROM decimal;
0.90000	0.900	0.9	0.9
3.13579	3.136	3.13579	3.13579
4.13579	4.136	4.1357875	4.135787654


-- DATE/TIME DATA TYPE
-- DATE
CREATE TABLE dates(
	id SERIAL PRIMARY KEY,
	employee_name VARCHAR(100) NOT NULL,
	hired_date DATE NOT NULL,
	add_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO dates (employee_name, hired_date)
VALUES
('Adam','2020-01-01'),
('Linda','2020-02-01');

SELECT * FROM dates;


SELECT CURRENT_DATE;

SELECT NOW();


-- TIME
CREATE TABLE time(
	id SERIAL PRIMARY KEY,
	class_name VARCHAR(100) NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL
);

INSERT INTO time (class_name, start_time, end_time)
VALUES
('Math','08:00:00','09:00:00'),
('Chemistry','09:01:00','10:00:00');

SELECT * FROM time;


SELECT CURRENT_TIME;

SELECT CURRENT_TIME(3);


SELECT LOCALTIME;


SELECT TIME '10:00' - TIME '04:00' AS "Interval";


SELECT CURRENT_TIME, CURRENT_TIME + INTERVAL '-2 hours' AS "Updated Time";


-- TIMESTAMP, TIMESTAMPTZ
CREATE TABLE timestamp(
	col_ts TIMESTAMP,
	col_tstz TIMESTAMPTZ
);

INSERT INTO timestamp (col_ts, col_tstz)
VALUES
('2020-02-22 10:10:10-07', '2020-02-22 10:10:10-07');

SELECT * FROM timestamp;


SHOW TIMEZONE;

SET TIMEZONE = 'America/New_York';


SELECT CURRENT_TIMESTAMP;


SELECT TIMEOFDAY();


SELECT TIMEZONE('Asia/Singapore', '2020-01-01 02:00:00');
SELECT TIMEZONE('America/New_York', '2020-01-01 02:00:00');


-- UUID DATA TYPE
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


SELECT uuid_generate_v1();
"fb2f9da4-d7ab-11ef-baf5-abcb4e1057b1"

SELECT uuid_generate_v4();
"1caf0636-b868-49f9-a7fd-3e7c9c96cd12"


CREATE TABLE uuid(
	product_id UUID DEFAULT uuid_generate_v1(),
	product_name VARCHAR(100) NOT NULL
);

INSERT INTO uuid (product_name)
VALUES
('abc'),
('xyz');

SELECT * FROM uuid;

ALTER TABLE uuid
ALTER COLUMN product_id
SET DEFAULT uuid_generate_v4();

INSERT INTO uuid (product_name)
VALUES
('pqr'),
('hij'),
('opq');

SELECT * FROM uuid;


-- ARRAY DATA TYPE
CREATE TABLE arrays(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	phones TEXT[]
);

INSERT INTO arrays (name, phones)
VALUES
('Adam', ARRAY['(801)-123-4567', '(819)-555-2222']),
('Linda', ARRAY['(201)-123-4567', '(214)-222-3333']);

SELECT * FROM arrays;

SELECT name, phones[1] FROM arrays;

SELECT name FROM arrays
WHERE phones[2] = '(214)-222-3333';


-- HSTORE DATA TYPE
CREATE EXTENSION IF NOT EXISTS "hstore";


CREATE TABLE hstores(
	book_id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	info HSTORE
);

INSERT INTO hstores (title, info)
VALUES
('title 1', 
'
	"publisher" => "abc",
	"cost" => "10.00",
	"pages" => "480"
'),
('title 2',
'
	"publisher" => "xyz",
	"cost" => "15.00",
	"pages" => 360
');

SELECT * FROM hstores;

SELECT info -> 'publisher' AS "Publisher",
info -> 'pages' AS "Pages"
FROM hstores;


-- JSON DATA TYPE
CREATE TABLE json(
	id SERIAL PRIMARY KEY,
	docs JSON
);

INSERT INTO json (docs)
VALUES
('[1, 2, 3, 4, 5, 6]'),
('[2, 3, 4, 5, 6, 7]'),
('{"key" : "value"}');

SELECT * FROM json;

ALTER TABLE json
ALTER COLUMN docs
TYPE JSONB;

SELECT * FROM json
WHERE docs @> '2';


CREATE INDEX ON json USING GIN (docs jsonb_path_ops);


-- NETWORK ADDRESS DATA TYPE
-- IP ADDRESS
CREATE TABLE network_address(
	id SERIAL PRIMARY KEY,
	ip INET
);

INSERT INTO network_address (ip)
VALUES
('4.35.221.243'),
('4.152.207.126'),
('4.152.207.238'),
('4.249.111.162'),
('12.1.223.132'),
('12.8.192.60');

SELECT * FROM network_address;


SELECT 
ip, 
set_masklen(ip, 24) AS "Inet 24" 
FROM network_address;

SELECT 
ip, 
set_masklen(ip, 24) AS "Inet 24",
set_masklen(ip::CIDR, 24) AS "Cidr 24"
FROM network_address;

SELECT 
ip, 
set_masklen(ip, 24) AS "Inet 24",
set_masklen(ip::CIDR, 24) AS "Cidr 24",
set_masklen(ip::CIDR, 27) AS "Cidr 27",
set_masklen(ip::CIDR, 28) AS "Cidr 28"
FROM network_address;