-- GROUP BY CLAUSE
-- ON SINGLE COLUMN
SELECT movie_language, COUNT(movie_language) 
FROM movies
GROUP BY movie_language;

SELECT movie_language, AVG(movie_length)
FROM movies
GROUP BY movie_language;

SELECT age_certificate, SUM(movie_length)
FROM movies
GROUP BY age_certificate;

SELECT movie_language,
MIN(movie_length),
MAX(movie_length)
FROM movies
GROUP BY movie_language;

SELECT age_certificate, AVG(movie_length)
FROM movies
WHERE age_certificate = 'PG'
GROUP BY age_certificate;


SELECT nationality, COUNT(*)
FROM directors
GROUP BY nationality
ORDER BY 2 DESC;


-- ON MULTIPLE COLUMNS
SELECT movie_language, age_certificate,
AVG(movie_length)
FROM movies
GROUP BY movie_language, age_certificate
ORDER BY movie_language, 3;

SELECT movie_language, age_certificate,
AVG(movie_length)
FROM movies
WHERE movie_length > 100
GROUP BY movie_language, age_certificate;

SELECT age_certificate, movie_language,
SUM(movie_length)
FROM movies
GROUP BY age_certificate, movie_language
ORDER BY 3 DESC;


-- HAVING CLAUSE
SELECT movie_language, SUM(movie_length)
FROM movies
GROUP BY movie_language
HAVING SUM(movie_length) > 200;


SELECT director_id, SUM(movie_length)
FROM movies
GROUP BY director_id
HAVING SUM(movie_length) > 200
ORDER BY 2 DESC;


SELECT director_id, 
SUM(movie_length) AS "Total Length"
FROM movies
GROUP BY director_id
HAVING "Total Length" > 200
ORDER BY 2 DESC;


-- ORDER OF EXECUTION OF CLAUSES
/*
FROM IS EXECUTED FIRST,
WHERE IS EXECUTED AFTER THAT,
GROUP BY IS EXECUTED AFTER THAT,
HAVING IS EXECUTED AFTER THAT,
SELECT IS EXECUTED AFTER THAT,
DISTINCT IS EXECUTED AFTER THAT,
ORDER BY IS EXECUTED AFTER THAT,
LIMIT IS EXECUTED LAST
*/


-- NULL VALUES WITH GROUP BY
CREATE TABLE employees (
	employee_id SERIAL PRIMARY KEY,
	employee_name VARCHAR(100),
	department VARCHAR(100),
	salary INT
);

INSERT INTO employees (employee_name, department, salary)
VALUES
('John','Finance', 2500),
('Mary', NULL, 3000),
('Adam', NULL, 4000),
('Bruce','Finance', 4000),
('Linda','IT', 5000),
('Megan','IT', 4000);

SELECT * FROM employees;

SELECT department, COUNT(*)
FROM employees
GROUP BY department;


SELECT COALESCE(department,'No Department'), COUNT(*)
FROM employees
GROUP BY department;