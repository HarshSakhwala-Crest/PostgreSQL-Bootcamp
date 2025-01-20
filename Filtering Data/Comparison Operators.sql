-- GREATER THAN 
SELECT * FROM movies 
WHERE movie_length > 100
ORDER BY movie_length;


-- GREATER THAN AND EQUAL TO
SELECT * FROM movies 
WHERE movie_length >= 104
ORDER BY movie_length;


-- LESS THAN
SELECT * FROM movies 
WHERE movie_length < 100
ORDER BY movie_length;


-- LESS THAN AND EQUAL TO
SELECT * FROM movies 
WHERE movie_length <= 104
ORDER BY movie_length;


-- COMPARISON ON DATE TYPE COLUMN VALUES
SELECT * FROM movies;

SELECT * FROM movies
WHERE release_date > '2000-12-31'
ORDER BY release_date;


-- COMPARISON ON TEXT TYPE COLUMN VALUES
SELECT * FROM movies
WHERE movie_language > 'English'
ORDER BY movie_language;

SELECT * FROM movies
WHERE movie_language < 'English'
ORDER BY movie_language;


-- NOT EQUAL TO
SELECT * FROM movies
WHERE movie_language <> 'English';

SELECT * FROM movies
WHERE movie_language != 'English';