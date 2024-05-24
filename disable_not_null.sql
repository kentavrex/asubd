DO $$
DECLARE
    schema_name TEXT := 's335100';
    not_null_count INTEGER := 0;
    r RECORD;
BEGIN
    FOR r IN
        SELECT table_name, column_name
        FROM information_schema.columns
        WHERE table_schema = schema_name AND is_nullable = 'NO'
    LOOP
        BEGIN
            EXECUTE format('ALTER TABLE %I.%I ALTER COLUMN %I DROP NOT NULL', schema_name, r.table_name, r.column_name);
            not_null_count := not_null_count + 1;
        EXCEPTION WHEN others THEN
            CONTINUE;
        END;
    END LOOP;

    RAISE NOTICE 'Схема: %, Ограничений целостности типа NOT NULL отключено: %', schema_name, not_null_count;
END $$;
