DO $$
DECLARE
    schema_name TEXT := 's100000';
    not_null_count INTEGER := 0;
BEGIN
    -- Отключение всех ограничений NOT NULL
    EXECUTE format('
        DO $$
        DECLARE
            r RECORD;
        BEGIN
            FOR r IN
                SELECT table_name, column_name
                FROM information_schema.columns
                WHERE table_schema = %L AND is_nullable = ''NO''
            LOOP
                EXECUTE format(''ALTER TABLE %I.%I ALTER COLUMN %I DROP NOT NULL'', schema_name, r.table_name, r.column_name);
                not_null_count := not_null_count + 1;
            END LOOP;
        END $$;
    ', schema_name);

    -- Вывод информации о количестве отключённых ограничений
    RAISE NOTICE 'Схема: %, Ограничений целостности типа NOT NULL отключено: %', schema_name, not_null_count;
END $$;
