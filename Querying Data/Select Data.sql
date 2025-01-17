-- SELECTING DATA FROM A TABLE
-- SELECT ALL RECORDS FROM movies TABLE
SELECT * FROM movies;


-- SELECT ALL RECORDS FROM actors TABLE
SELECT * FROM actors;


-- SELECT SPECIFIC COLUMNS FROM A TABLE
SELECT first_name FROM actors;

SELECT first_name, last_name FROM actors;

SELECT movie_name, movie_language FROM movies;


-- ADDING ALIAS TO A COLUMN NAME
SELECT first_name AS firstname FROM actors;

SELECT first_name AS "FirstName" FROM actors;

SELECT first_name AS "First Name" FROM actors;

SELECT 
movie_name AS "Movie Name", 
movie_language AS "Language" 
FROM movies;

SELECT
movie_name "Movie Name",
movie_language "Language"
FROM movies;


-- ASSIGNING COLUMN ALIASES TO AN EXPRESSION
SELECT first_name || ' ' || last_name AS "Full Name" FROM actors;

SELECT 2 * 10;

SELECT 10 / 5;