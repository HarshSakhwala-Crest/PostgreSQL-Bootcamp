-- UPSERT - UPDATE + INSERT

/* 
INSERT INTO table_name (coulmn_list)
VALUES (values_list)
ON CONFLICT target_action;

target_action - DO NOTHING
			  - DO UPDATE SET column_name = value
				WHERE condition
*/


-- CREATE A TABLE
CREATE TABLE tags (
	id SERIAL PRIMARY KEY,
	tag TEXT UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);


-- INSERT RECORDS
INSERT INTO tags (tag)
VALUES
('Pen'),
('Pencil')
RETURNING *;


-- INSERT A RECORDS ON CONFLICT DO NOTHING
INSERT INTO tags (tag)
VALUES
('Pencil')
ON CONFLICT (tag)
DO NOTHING;

SELECT * FROM tags;


-- INSERT A RECORD ON CONFLICT DO UPDATE
INSERT INTO tags (tag)
VALUES
('Pen')
ON CONFLICT (tag)
DO UPDATE
SET tag = EXCLUDED.tag || 'box', update_date = NOW();

SELECT * FROM tags;