-- COUNT FUNCTION
SELECT COUNT(*) FROM movies;
53

SELECT COUNT(movie_length) FROM movies;
53


SELECT COUNT(DISTINCT(movie_language)) FROM movies;
8

SELECT COUNT(DISTINCT director_id) FROM movies;
37


SELECT COUNT(*) FROM movies
WHERE movie_language = 'Japanese';
4


-- SUM FUNCTION
SELECT * FROM movies_revenues;

SELECT SUM(revenues_domestic) FROM movies_revenues;
5719.50

SELECT SUM(revenues_domestic) FROM movies_revenues
WHERE revenues_domestic > 200;
3425.60


SELECT SUM(movie_length) FROM movies
WHERE movie_language = 'English';
4824

SELECT SUM(movie_name) FROM movies;


SELECT SUM(DISTINCT revenues_domestic)
FROM movies_revenues;
5708.40


-- MIN FUNCTION
SELECT MIN(movie_length) FROM movies;
87

SELECT MIN(release_date) FROM movies
WHERE movie_language = 'Chinese';
"1972-06-01"


SELECT MIN(movie_name) FROM movies;
"A Clockwork Orange"


-- MAX FUNCTION
SELECT MAX(movie_length) FROM movies;
168

SELECT MAX(movie_length) FROM movies
WHERE movie_language = 'English';
168

SELECT MAX(release_date) FROM movies
WHERE movie_language = 'English';
"2017-11-10"


SELECT MAX(movie_name) FROM movies;
"Way of the Dragon "


-- GREATEST FUNCTION
SELECT GREATEST(10, 20, 30);
30

SELECT GREATEST('A','B','C');
"C"

SELECT GREATEST(1,'A', 2,'B');


SELECT movie_id,
revenues_domestic,
revenues_international,
GREATEST(revenues_domestic, revenues_international) AS "Greatest",
FROM movies_revenues;


-- LEAST FUNCTION
SELECT LEAST(10, -5, 45);
-5

SELECT LEAST('A','B','C');
"A"

SELECT movie_id,
revenues_domestic,
revenues_international,
LEAST(revenues_domestic, revenues_international) AS "Least"
FROM movies_revenues;


-- AVERAGE FUNCTION
SELECT AVG(movie_length) FROM movies;
126.1320754716981132

SELECT AVG(movie_length) FROM movies
WHERE movie_language = 'English';
126.9473684210526316

SELECT AVG(DISTINCT movie_length)
FROM movies
WHERE movie_language = 'English';
127.7407407407407407


SELECT AVG(movie_name) FROM movies;


SELECT AVG(movie_length),
SUM(movie_length)
FROM movies
WHERE movie_language = 'English';
126.9473684210526316	4824


CREATE TABLE demo_avg (
	num INT
);

INSERT INTO demo_avg
VALUES
(1),
(2),
(3),
(NULL);

SELECT * FROM demo_avg;

SELECT AVG(num) FROM demo_avg;
2.0000000000000000

DROP TABLE demo_avg;


-- MATHEMATICAL OPERATORS
SELECT 2 + 10 AS "Addition";
12

SELECT 10 - 2 AS "Subtraction";
8

SELECT 11 / 2::NUMERIC(10, 2) AS "Division";
5.5000000000000000

SELECT 5 * 4 AS "Multiplication";
20

SELECT 21 % 4 AS "Modulus";
1


SELECT * FROM movies_revenues;

SELECT movie_id,
revenues_domestic,
revenues_international,
revenues_domestic + revenues_international AS "Total Revenue"
FROM movies_revenues
ORDER BY 4 DESC
NULLS LAST;

SELECT movie_id,
revenues_domestic,
revenues_international,
revenues_domestic + revenues_international AS "Total Revenue"
FROM movies_revenues
WHERE revenues_domestic + revenues_international IS NOT NULL
ORDER BY 4 DESC;