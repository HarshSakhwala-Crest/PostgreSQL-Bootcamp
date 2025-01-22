-- CREATE TYPE IF NOT EXISTS USING PL/PGSQL FUNCTION

DO
$$
BEGIN
	IF NOT EXISTS (SELECT * FROM pg_type AS typ
					INNER JOIN pg_namespace AS nsp
					ON nsp.oid = typ.typnamespace
					WHERE nsp.nspname = CURRENT_SCHEMA()
							AND typ.typname = 'ai') THEN
		CREATE TYPE ai AS (
			a TEXT,
			i INTEGER
		);
	END IF;
END;
$$
LANGUAGE PLPGSQL;