DO $$
DECLARE
    schema_name TEXT := 's335100'; -- измените на нужную схему
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
            -- Игнорировать ошибки при попытке удалить NOT NULL из столбцов, входящих в первичные ключи
            CONTINUE;
        END;
    END LOOP;

    -- Вывод информации о количестве отключённых ограничений
    RAISE NOTICE 'Схема: %, Ограничений целостности типа NOT NULL отключено: %', schema_name, not_null_count;
END $$;
