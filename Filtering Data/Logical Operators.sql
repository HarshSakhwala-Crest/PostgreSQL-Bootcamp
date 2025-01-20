-- AND OPERATOR
SELECT * FROM movies;

SELECT * FROM movies
WHERE movie_language = 'English';

SELECT * FROM movies
WHERE age_certificate = '18';

SELECT * FROM movies
WHERE movie_language = 'English'
AND age_certificate = '18';

SELECT * FROM movies
WHERE movie_language = 'Japanese'
AND age_certificate = '18';


-- OR OPERATOR
SELECT * FROM movies
WHERE movie_language = 'English'
OR movie_language = 'Chinese'
ORDER BY movie_language, movie_id;

SELECT * FROM movies
WHERE movie_language = 'English'
OR director_id = '10'
ORDER BY movie_language, director_id;


-- COMBINING AND, OR OPERATORS
SELECT * FROM movies
WHERE movie_language = 'English'
OR movie_language = 'Chinese'
AND age_certificate = '12'
ORDER BY movie_language;

SELECT * FROM movies
WHERE movie_language = 'English'
AND age_certificate = '12'
OR movie_language = 'Chinese'
ORDER BY movie_language;

SELECT * FROM movies
WHERE (movie_language = 'English'
OR movie_language = 'Chinese')
AND age_certificate = '12'
ORDER BY movie_language;


-- WHERE CLAUSE
SELECT * FROM movies
WHERE movie_language = 'Swedish';


-- EXECUTION ORDER OF AND, OR OPERATORS
/*
AND OPERATOR IS PROCESSED FIRST AND OR OPERATOR IS PROCESSES SECOND
UNLESS PARENTHESES ARE USED
*/


-- EXECUTION ORDER OF SELECT, FROM, WHERE AND ORDER BY
/*
FROM IS PROCESSED FIRST
THEN WHERE IS PROCESSED SECOND
THEN SELECT IS PROCESSED THIRD
THEN ORDER BY IS PROCESSED LAST
*/