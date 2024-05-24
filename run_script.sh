#!/bin/bash
psql -h pg -d studs -f ~/asubd/disable_not_null.sql 2>&1