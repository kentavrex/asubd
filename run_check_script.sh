#!/bin/bash
psql -h pg -d studs -c "SELECT COUNT(*) AS not_null_constraints FROM information_schema.columns WHERE table_schema = 's100000' AND is_nullable = 'NO';"
