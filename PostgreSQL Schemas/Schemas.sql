-- SCHEMA OPERATIONS
-- CREATE SCHEMA
-- USING PGADMIN GUI : CREATE SCHEMA
CREATE SCHEMA sales;

CREATE SCHEMA hr;


-- ALTER SCHEMA
-- USING PGADMIN GUI : ALTER SCHEMA
ALTER SCHEMA sales
RENAME TO programming;


-- DROP SCHEMA
-- USING PGADMIN GUI : DROP SCHEMA
DROP SCHEMA programming;

DROP SCHEMA hr;


-- SCHEMA HIERARCHY
SELECT * FROM hr.public.employees;

SELECT * FROM hr.humanresources.employees;


-- MOVE TABLE TO ANOTHER SCHEMA
-- USING PGADMIN GUI : CREATE ORDERS TABLE
ALTER TABLE humanresources.orders
SET SCHEMA public;


-- SCHEMA SEARCH PATH
SELECT CURRENT_SCHEMA();

SHOW SEARCH_PATH;


SET SEARCH_PATH TO '$user', humanresources, public;

SELECT * FROM test;

INSERT INTO public.test
VALUES
(1),
(2);

SELECT * FROM test;


SET SEARCH_PATH TO '$user', public, humanresources;

SELECT * FROM test;


SET SEARCH_PATH TO '$user', humanresources;

SELECT * FROM orders;

SELECT * FROM public.orders;


-- SCHEMA OWNERSHIP
-- USING PGADMIN GUI : CHANGE OWNER
ALTER SCHEMA humanresources
OWNER TO "Harsh";


-- DUPLICATE SCHEMA
CREATE DATABASE test_schema;

CREATE TABLE test_schema.public.songs (
	song_id SERIAL PRIMARY KEY,
	song_title VARCHAR(100)
);

INSERT INTO test_schema.public.songs (song_title)
VALUES
('Counting Stars'),
('On & On');

SELECT * FROM test_schema.public.songs;


pg_dump -d test_schema -h localhost -U postgres -n public > dump.sql


-- USING PGADMIN GUI : RENAME OLD SCHEMA public to old_schema


psql -h localhost -U postgres -d test_schema -f dump.sql


-- SYSTEM CATALOG SCHEMA
SHOW SEARCH_PATH;

SET SEARCH_PATH TO '$user', public, pg_catalog;


SELECT * FROM information_schema.schemata;


-- COMPARE TABLES AND COLUMNS OF TWO SCHEMAS
SELECT COALESCE(c1.table_name, c2.table_name) AS table_name,
COALESCE(c1.column_name, c2.column_name) AS column_name,
c1.column_name AS schema1,
c2.column_name AS schema2
FROM
(SELECT table_name, column_name
FROM information_schema.columns AS c
WHERE c.table_schema = 'public') AS c1
FULL JOIN
(SELECT table_name, column_name
FROM information_schema.columns AS c
WHERE c.table_schema = 'humanresources') AS c2
ON c1.table_name = c2.table_name AND c1.column_name = c2.column_name
WHERE c1.column_name IS NULL OR c2.column_name IS NULL
ORDER BY table_name, column_name;


-- SCHEMAS AND PREVILEGES
-- USING PGADMIN GUI : CREATE SCHEMA private
-- USING PGADMIN GUI : CREATE TABLE t1
SELECT * FROM private.t1;


GRANT USAGE ON SCHEMA private TO "Harsh";


GRANT SELECT ON ALL TABLES IN SCHEMA private TO "Harsh";


GRANT CREATE ON SCHEMA private TO "Harsh";

CREATE TABLE private.abc (
	id INT
);