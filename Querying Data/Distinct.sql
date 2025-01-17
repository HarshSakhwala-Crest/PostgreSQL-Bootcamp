-- DISTINCT FOR SELECTING DISTINCT VALUES
SELECT * FROM movies;

SELECT 
movie_language 
FROM movies;

SELECT 
DISTINCT movie_language
FROM movies;

SELECT 
DISTINCT movie_language
FROM movies
ORDER BY 1;

SELECT 
DISTINCT director_id
FROM movies;

SELECT 
DISTINCT movie_language, director_id
FROM movies;

SELECT 
DISTINCT *
FROM movies
ORDER BY movie_id;