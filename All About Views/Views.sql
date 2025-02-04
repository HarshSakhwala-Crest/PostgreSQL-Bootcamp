-- VIEWS
CREATE OR REPLACE VIEW view_mv AS
SELECT movie_name, movie_length, release_date
FROM movies;


CREATE OR REPLACE VIEW view_mv_dr AS
SELECT *
FROM movies AS mv
INNER JOIN directors AS dr
ON mv.director_id = dr.director_id;


CREATE OR REPLACE VIEW view_mv_dr AS
SELECT mv.movie_id, mv.movie_name, mv.movie_length, mv.movie_language, mv.age_certificate, mv.release_date, mv.director_id,
dr.first_name, dr.last_name, dr.date_of_birth, dr.nationality
FROM movies AS mv
INNER JOIN directors AS dr
ON mv.director_id = dr.director_id;


SELECT * FROM view_mv;

SELECT * FROM view_mv_dr;


-- RENAME VIEW
-- USING PGADMIN GUI : RENAME A VIEW
ALTER VIEW view_mv
RENAME TO v_mv;


--  DROP VIEW
-- USING PGADMIN GUI : DELETE A VIEW
DROP VIEW view_mv;


-- FILTER DATA
CREATE OR REPLACE VIEW view_mv_after_1997 AS
SELECT * FROM movies
WHERE release_date > '1997-12-31'
ORDER BY release_date DESC;

SELECT * FROM view_mv_after_1997
WHERE movie_language = 'English';


SELECT first_name || ' ' || last_name AS "Director Name",
nationality
FROM view_mv_dr
WHERE nationality IN ('American','Japanese')
ORDER BY nationality;


-- VIEW OF UNION
CREATE OR REPLACE VIEW view_ac_dr AS
SELECT first_name, last_name, 'Actor' AS "Role"
FROM actors
UNION
SELECT first_name, last_name, 'Director' AS "Role"
FROM directors;

SELECT * FROM view_ac_dr
WHERE first_name LIKE 'J%'
ORDER BY "Role", first_name;


-- CONNECT MULTIPLE TABLES
CREATE VIEW view_mv_dr_mr AS
SELECT mv.movie_id, mv.movie_name, mv.movie_length, mv.movie_language, mv.age_certificate, mv.release_date,
dr.director_id, dr.first_name, dr.last_name, dr.date_of_birth, dr.nationality,
mr.revenues_domestic, mr.revenues_international
FROM movies AS mv
INNER JOIN directors AS dr ON mv.director_id = dr.director_id
INNER JOIN movies_revenues AS mr ON mv.movie_id = mr.movie_id;

SELECT * FROM view_mv_dr_mr
WHERE age_certificate = '12';


-- REARRANGE COLUMNS
CREATE VIEW view_directors AS
SELECT first_name, last_name
FROM directors;

DROP VIEW view_directors;

CREATE OR REPLACE VIEW view_directors AS
SELECT last_name, first_name
FROM directors;


-- REMOVE A COLUMN
SELECT * FROM view_directors;

DROP VIEW view_directors;

CREATE OR REPLACE VIEW view_directors AS
SELECT first_name FROM directors;


-- ADD A COLUMN
SELECT * FROM view_directors;

CREATE OR REPLACE VIEW view_directors AS
SELECT first_name, last_name, nationality
FROM directors;


-- DYNAMIC VIEWS
INSERT INTO directors (first_name, last_name, nationality)
VALUES
('Christopher','Nolan','British');

SELECT * FROM directors;

SELECT * FROM view_directors;


DELETE FROM directors
WHERE first_name = 'Christopher';

SELECT * FROM directors;

SELECT * FROM view_directors;


-- UPDATABLE VIEW
-- CRUD OPERATIONS
CREATE OR REPLACE VIEW view_updatable AS
SELECT first_name, last_name
FROM directors;


INSERT INTO view_updatable	(first_name, last_name)
VALUES
('Christopher','Nolan');

SELECT * FROM view_updatable;

SELECT * FROM directors;


DELETE FROM view_updatable
WHERE first_name = 'Christopher';

SELECT * FROM view_updatable;

SELECT * FROM directors;


-- WITH CHECK OPTION
CREATE TABLE countries (
	country_id SERIAL PRIMARY KEY,
	country_code VARCHAR(4),
	city_name VARCHAR(100)
);

INSERT INTO countries (country_code, city_name)
VALUES
('US','New York'),
('US','New Jersey'),
('UK','London');

SELECT * FROM countries;


CREATE OR REPLACE VIEW view_cities_us AS
SELECT country_id, country_code, city_name
FROM countries
WHERE country_code = 'US';

SELECT * FROM view_cities_us;


INSERT INTO view_cities_us (country_code, city_name)
VALUES
('US','California');

SELECT * FROM view_cities_us;

INSERT INTO view_cities_us (country_code, city_name)
VALUES
('UK','Manchester');

SELECT * FROM view_cities_us;

SELECT * FROM countries;


CREATE OR REPLACE VIEW view_cities_us AS
SELECT country_id, country_code, city_name
FROM countries
WHERE country_code = 'US'
WITH CHECK OPTION;


INSERT INTO view_cities_us (country_code, city_name)
VALUES
('UK','Leeds');

SELECT * FROM view_cities_us;

SELECT * FROM countries;


UPDATE view_cities_us
SET country_code = 'UK'
WHERE city_name = 'New York';


INSERT INTO view_cities_us (country_code, city_name)
VALUES
('US','Chicago');

SELECT * FROM view_cities_us;


-- WITH LOCAL AND CASCADED CHECK OPTION
-- WITH LOCAL CHECK OPTION
CREATE OR REPLACE VIEW view_cities_c AS
SELECT country_id, country_code, city_name
FROM countries
WHERE city_name LIKE 'C%';

SELECT * FROM view_cities_c;


CREATE OR REPLACE VIEW view_cities_us_c AS
SELECT country_id, country_code, city_name
FROM view_cities_c
WHERE country_code = 'US'
WITH LOCAL CHECK OPTION;

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES
('US','Connecticut');

SELECT * FROM view_cities_us_c;

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES
('US','Los Angeles');

SELECT * FROM view_cities_us_c;

SELECT * FROM countries;


-- WITH CASCADED CHECK OPTION
CREATE OR REPLACE VIEW view_cities_us_c AS
SELECT country_id, country_code, city_name
FROM view_cities_c
WHERE country_code = 'US'
WITH CASCADED CHECK OPTION;

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES
('US','Boston');

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES
('US','Clear Water');

SELECT * FROM view_cities_us_c;


-- MATERIALIZED VIEW
-- WITH DATA
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_directors AS
SELECT first_name, last_name
FROM directors
WITH DATA;

SELECT * FROM mv_directors;


-- WITH NO DATA
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_directors_nodata AS
SELECT first_name, last_name
FROM directors
WITH NO DATA;

SELECT * FROM mv_directors_nodata;


REFRESH MATERIALIZED VIEW mv_directors_nodata;

SELECT * FROM mv_directors_nodata;


-- DROP MATERIALIZED VIEW
DROP MATERIALIZED VIEW mv_directors_nodata;


-- CHANGE MATERIALIZED VIEW DATA
SELECT * FROM mv_directors;

INSERT INTO mv_directors (first_name, last_name)
VALUES
('Christopher','Nolan');


INSERT INTO directors (first_name, last_name)
VALUES
('Christopher','Nolan');

SELECT * FROM mv_directors;


REFRESH MATERIALIZED VIEW mv_directors;

SELECT * FROM mv_directors;


DELETE FROM mv_directors
WHERE first_name = 'Christopher';


UPDATE mv_directors
SET first_name = 'Chris'
WHERE first_name = 'Christopher';


-- MATERIALIZED VIEW IS POPULATED OR NOT
CREATE MATERIALIZED VIEW mv_directors_nodata AS
SELECT first_name, last_name
FROM directors
WITH NO DATA;

SELECT * FROM mv_directors_nodata;


SELECT relispopulated FROM pg_class
WHERE relname = 'mv_directors_nodata';


-- REFRESH DATA
CREATE MATERIALIZED VIEW mv_directors_us AS
SELECT director_id, first_name, last_name, date_of_birth, nationality
FROM directors
WHERE nationality = 'American'
WITH NO DATA;

SELECT * FROM mv_directors_us;


REFRESH MATERIALIZED VIEW mv_directors_us;

SELECT * FROM mv_directors_us;


CREATE UNIQUE INDEX idx_u_mv_directors_us_director_id ON mv_directors_us (director_id);

REFRESH MATERIALIZED VIEW CONCURRENTLY mv_directors_us;

SELECT * FROM mv_directors_us;


-- MATERIALIZED VIEW FOR WEBSITE PAGE ANALYSIS
CREATE TABLE page_clicks (
	rec_id SERIAL PRIMARY KEY,
	page VARCHAR(200),
	click_time TIMESTAMP,
	user_id BIGINT
);

INSERT INTO page_clicks (page, click_time, user_id)
SELECT
(
	CASE (RANDOM() * 2)::INT
		WHEN 0 THEN 'klickanalytics.com'
		WHEN 1 THEN 'clickapis.com'
		WHEN 2 THEN 'google.com'
	END
) AS page,
NOW() AS click_time,
(FLOOR(RANDOM() * (111111111 - 1000000 - 1) + 1000000))::INT AS user_id
FROM GENERATE_SERIES(1, 10000) AS "Sequence";

SELECT * FROM page_clicks;


CREATE MATERIALIZED VIEW mv_page_clicks AS
SELECT DATE_TRUNC('DAY',click_time) AS "Day",
page,
COUNT(*) AS total_clicks
FROM page_clicks
GROUP BY "Day", page;

REFRESH MATERIALIZED VIEW mv_page_clicks;

SELECT * FROM mv_page_clicks;


CREATE MATERIALIZED VIEW mv_page_clicks_daily AS
SELECT click_time AS "Day",
page,
COUNT(*) AS "Count"
FROM page_clicks
WHERE click_time >= DATE_TRUNC('DAY', NOW())
AND click_time < TIMESTAMP 'TOMORROW'
GROUP BY "Day", page;

CREATE UNIQUE INDEX idx_u_mv_page_clicks_daily_day_page ON mv_page_clicks_daily ("Day", page);

REFRESH MATERIALIZED VIEW CONCURRENTLY mv_page_clicks_daily;

SELECT * FROM mv_page_clicks_daily;


-- LIST MATERIALIZED VIEWS
SELECT oid::regclass::TEXT FROM pg_class
WHERE relkind = 'm';


-- LIST MATERIALIZED VIEWS WITH NO UNIQUE INDEX
WITH matviews_with_no_unique_keys AS (
 SELECT c.oid, c.relname, c2.relname AS idx_name
 FROM pg_catalog.pg_class AS c, pg_catalog.pg_class AS c2, pg_catalog.pg_index AS i
 LEFT JOIN pg_catalog.pg_constraint AS con
 ON (
	conrelid = i.indrelid AND conrelid = i.indexrelid AND contype IN ('p','u')
 )
 WHERE
 c.relkind = 'm'
 AND c.oid = i.indrelid
 AND i.indexrelid = c2.oid
 AND indisunique
)
SELECT c.relname AS materiliazed_view_name
FROM pg_class AS c
WHERE c.relkind = 'm'
EXCEPT
SELECT mwk.relname
FROM matviews_with_no_unique_keys AS mwk;


-- QUICK QUERIES FOR MATERIALIZED VIEWS
-- WHETHER MATERIALIZED VIEW EXISTS
SELECT COUNT(*) > 0
FROM pg_catalog.pg_class AS c
JOIN pg_namespace AS n 
ON n.oid = c.relnamespace
WHERE c.relkind = 'm'
AND n.nspname = 'some_schema'
AND c.relname = 'some_mat_view';


SELECT view_definition FROM information_schema.views
WHERE table_schema = 'information_schema'
AND table_name = 'views';


-- 	LIST MATERIALIZED VIEWS
SELECT * FROM pg_matviews;


SELECT * FROM pg_matviews 
WHERE matviewname = 'view_name';