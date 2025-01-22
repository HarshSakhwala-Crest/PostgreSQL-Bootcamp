-- ENUM DATA TYPE
-- ENUM TYPE FOR CURRENCY
CREATE TYPE currency AS ENUM ('USD','EUR','GBP');

SELECT 'USD'::currency;

ALTER TYPE currency ADD VALUE 'CHF' AFTER 'EUR';

CREATE TABLE stocks (
	stock_id SERIAL PRIMARY KEY,
	stock_currency currency
);

INSERT INTO stocks (stock_currency)
VALUES
('USD'),
('CHF');

INSERT INTO stocks (stock_currency)
VALUES
('INR');

SELECT * FROM stocks;


-- ALTER AN ENUM TYPE
CREATE TYPE mycolors AS ENUM ('green','red','blue');


-- RENAME A VALUE
ALTER TYPE mycolors 
RENAME VALUE 'red' TO 'orange';


-- LIST ALL ENUM VALUES
SELECT ENUM_RANGE(NULL::mycolors);


-- ADD A VALUE
ALTER TYPE mycolors 
ADD VALUE 'red' AFTER 'green';


-- UPDATE ENUM TYPE IN PRODUCTION SERVER
CREATE TYPE status_enum AS ENUM ('queued','waiting','running','done');

CREATE TABLE jobs (
	job_id SERIAL PRIMARY KEY,
	job_status status_enum
);

INSERT INTO jobs (job_status)
VALUES
('queued'),
('waiting'),
('running'),
('done');

SELECT * FROM jobs;

UPDATE jobs
SET job_status = 'running'
WHERE job_status = 'waiting';


ALTER TYPE status_enum
RENAME TO status_enum_old;


CREATE TYPE status_enum AS ENUM ('queued','running','done');

ALTER TABLE jobs
ALTER COLUMN job_status TYPE status_enum
USING job_status::TEXT::status_enum;

DROP TYPE status_enum_old;


-- ENUM TYPE WITH DEFAULT VALUE
CREATE TYPE status AS ENUM ('pending','approved','declined');

CREATE TABLE cron_jobs (
	cron_job_id INT PRIMARY KEY,
	status status DEFAULT 'pending'
);

INSERT INTO cron_jobs (cron_job_id)
VALUES
(1),
(2);

INSERT INTO cron_jobs (cron_job_id, status)
VALUES
(3, 'approved');

SELECT * FROM cron_jobs;