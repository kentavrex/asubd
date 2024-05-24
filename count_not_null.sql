DO $$
DECLARE
    schema_name TEXT := 's335100';
    not_null_count INTEGER;
BEGIN
    -- Подсчет количества ограничений NOT NULL
    SELECT COUNT(*) INTO not_null_count
    FROM information_schema.columns
    WHERE table_schema = schema_name AND is_nullable = 'NO';

    -- Вывод информации о количестве ограничённых ограничений
    RAISE NOTICE 'Схема: %, Ограничений целостности типа NOT NULL: %', schema_name, not_null_count;
END $$;
