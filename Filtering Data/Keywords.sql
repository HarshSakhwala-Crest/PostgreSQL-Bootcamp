-- LIMIT KEYWORD
SELECT * FROM movies
ORDER BY movie_length DESC
LIMIT 5;


SELECT * FROM directors;

SELECT * FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth ASC
LIMIT 5;


SELECT * FROM actors;

SELECT * FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
LIMIT 10;


SELECT * FROM movies_revenues;

SELECT * FROM movies_revenues
ORDER BY revenues_domestic DESC
NULLS LAST
LIMIT 10;

SELECT * FROM movies_revenues
ORDER BY revenues_domestic ASC
NULLS LAST
LIMIT 10;


-- OFFSET KEYWORD
SELECT * FROM movies
ORDER BY movie_id
LIMIT 5
OFFSET 4;

SELECT * FROM movies_revenues
ORDER BY revenues_domestic DESC
NULLS LAST
LIMIT 5
OFFSET 5;


-- FETCH KEYWORD
SELECT * FROM movies
FETCH FIRST 1 ROW ONLY;

SELECT * FROM movies
ORDER BY movie_length DESC
FETCH FIRST 5 ROWS ONLY;


SELECT * FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth ASC
FETCH FIRST 5 ROWS ONLY;


SELECT * FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
FETCH FIRST 10 ROWS ONLY;


SELECT * FROM movies
ORDER BY movie_length DESC
FETCH FIRST 5 ROWS ONLY
OFFSET 5;


-- IN, NOT IN KEYWORDS
SELECT * FROM movies
WHERE movie_language IN ('English','Chinese','Japanese')
ORDER BY movie_language ASC;

SELECT * FROM movies
WHERE age_certificate IN ('12','PG')
ORDER BY age_certificate ASC;


SELECT * FROM movies
WHERE director_id NOT IN (10, 13)
ORDER BY director_id ASC;


SELECT * FROM actors
WHERE actor_id NOT IN (1, 2, 3, 4)
ORDER BY actor_id ASC;


-- BETWEEN, NOT BETWEEN KEYWORD
SELECT * FROM actors
WHERE date_of_birth BETWEEN '1991-01-01' AND '1995-12-31'
ORDER BY date_of_birth ASC;


SELECT * FROM movies
WHERE release_date BETWEEN '1998-01-01' AND '2002-12-31'
ORDER BY release_date ASC;


SELECT * FROM movies_revenues
WHERE revenues_domestic BETWEEN 100 AND 300
ORDER BY revenues_domestic DESC;


SELECT * FROM movies
WHERE movie_length NOT BETWEEN 100 AND 200
ORDER BY movie_length ASC;


-- LIKE, ILIKE KEYWORDS
SELECT 'hello' LIKE 'hello';

SELECT 'hello' LIKE 'h%';

SELECT 'hello' LIKE '%e%';

SELECT 'hello' LIKE 'hell%';

SELECT 'hello' LIKE '%ll';


SELECT 'hello' LIKE '_ello';

SELECT 'hello' LIKE '__ll_'


SELECT 'hello' LIKE '%l__';


SELECT * FROM actors
WHERE first_name LIKE 'A%'
ORDER BY first_name ASC;

SELECT * FROM actors
WHERE last_name LIKE '%a'
ORDER BY last_name ASC;

SELECT * FROM actors
WHERE first_name LIKE '_____'
ORDER BY first_name ASC;

SELECT * FROM actors
WHERE first_name LIKE '_l%'
ORDER BY first_name ASC;

SELECT * FROM actors
WHERE first_name LIKE 'tim'
ORDER BY first_name ASC;

/*
LIKE KEYWORD IS CASE-SENSITIVE
WHILE ILIKE KEYWORD IS NOT CASE-SENSITIVE
*/

SELECT * FROM actors
WHERE first_name ILIKE 'tim'
ORDER BY first_name ASC;


-- IS NULL, IS NOT NULL KEYWORDS
SELECT * FROM actors
WHERE date_of_birth IS NULL;

SELECT * FROM actors
WHERE date_of_birth IS NULL 
OR first_name IS NULL;


SELECT * FROM movies_revenues
WHERE revenues_domestic IS NULL;

SELECT * FROM movies_revenues
WHERE revenues_domestic IS NULL
OR revenues_international IS NULL;


SELECT * FROM movies_revenues
WHERE revenues_domestic IS NOT NULL;