-- ADD COLUMNS
CREATE TABLE persons(
	person_id SERIAL PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL
);


ALTER TABLE persons
ADD COLUMN age INT NOT NULL;

SELECT * FROM persons;


ALTER TABLE persons
ADD COLUMN email VARCHAR(100) UNIQUE,
ADD COLUMN nationality VARCHAR(20) NOT NULL;

SELECT * FROM persons;


-- RENAME TABLE
ALTER TABLE users
RENAME TO persons;


-- RENAME COLUMN
ALTER TABLE persons
RENAME COLUMN person_age TO age;


-- DROP COLUMN
ALTER TABLE persons
DROP COLUMN age;

ALTER TABLE persons
ADD COLUMN age VARCHAR(10) NOT NULL;


-- CHANGE DATA TYPE OF COLUMN
ALTER TABLE persons
ALTER COLUMN age TYPE INT
USING age::INTEGER;

SELECT * FROM persons;

ALTER TABLE persons
ALTER COLUMN age TYPE VARCHAR(10);


-- SET DEFAULT VALUE OF COLUMN
ALTER TABLE persons
ADD COLUMN is_enable BOOLEAN;

ALTER TABLE persons
ALTER COLUMN is_enable 
SET DEFAULT FALSE;


INSERT INTO persons (first_name, last_name, nationality, age)
VALUES
('John', 'Benjamin', 'USA', 40);

SELECT * FROM persons;


-- ADD CONSTRAINTS TO COLUMN
CREATE TABLE web_links(
	link_id SERIAL PRIMARY KEY,
	link_url VARCHAR(255) NOT NULL,
	link_target VARCHAR(20)
);

INSERT INTO web_links (link_url, link_target)
VALUES
('https://www.amazon.com','_blank');

SELECT * FROM web_links;


ALTER TABLE web_links
ADD CONSTRAINT "Unique Web Url" UNIQUE (link_url);


-- SET COLUMN TO ACCEPT ONLY DEFINED ALLOWED/ACCEPTABLE VALUES
ALTER TABLE web_links
ADD COLUMN is_enable VARCHAR(2);

INSERT INTO web_links (link_url, link_target, is_enable)
VALUES
('https://www.netflix.com','_blank','Y');


ALTER TABLE web_links
ADD CHECK (is_enable IN ('Y','N'));


INSERT INTO web_links (link_url, link_target, is_enable)
VALUES
('https://www.meesho.com','_blank','N');


UPDATE web_links
SET is_enable = 'Y'
WHERE link_id = 1;

UPDATE web_links
SET is_enable = 'N'
WHERE link_id = 3;

SELECT * FROM web_links;