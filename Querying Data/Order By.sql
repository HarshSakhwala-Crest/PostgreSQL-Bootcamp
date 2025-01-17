-- ORDER BY TO SORT RECORDS BY COLUMN NAME
SELECT * FROM movies
ORDER BY release_date ASC;

SELECT * FROM movies 
ORDER BY release_date;

SELECT * FROM movies
ORDER BY release_date DESC;

SELECT * FROM movies
ORDER BY
movie_name ASC,
release_date DESC;


-- ORDER BY TO SORT RECORDS BY ALIAS COLUMN NAME
SELECT 
first_name AS "Name",
last_name AS "Surname"
FROM actors
ORDER BY "Name" DESC;


-- ORDER BY TO SORT RECORDS BY EXPRESSION
SELECT 
first_name, LENGTH(first_name)
FROM actors;

SELECT 
first_name, 
LENGTH(first_name) AS "Length"
FROM actors
ORDER BY 
"Length" DESC;

SELECT 
first_name, LENGTH(first_name)
FROM actors
ORDER BY 
LENGTH(first_name) DESC;


-- ORDER BY TO SORT RECORDS BY COLUMN NAME OR COLUMN NUMBER
SELECT * FROM actors
ORDER BY
first_name ASC,
date_of_birth DESC;

SELECT 
first_name,
last_name,
date_of_birth
FROM actors
ORDER BY 
first_name ASC,
date_of_birth DESC;

SELECT 
first_name,
last_name,
date_of_birth
FROM actors
ORDER BY 
1 ASC,
3 DESC;


-- ORDER BY TO SORT RECORDS WITH NULL VALUES
CREATE TABLE demo(
	num	INT
);

INSERT INTO demo 
VALUES
(1),
(2),
(3),
(NULL),
(NULL);

SELECT * FROM demo;

SELECT *
FROM demo
ORDER BY
num ASC;

SELECT *
FROM demo
ORDER BY
num ASC 
NULLS LAST;

SELECT *
FROM demo
ORDER BY
num DESC
NULLS FIRST;

DROP TABLE IF EXISTS demo;