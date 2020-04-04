#!/bin/bash
 
mkdir -p /tmp/postgres

path_to_csv='/tmp/postgres/export.csv'
echo "\copy $2 to $path_to_csv DELIMITER ',' CSV HEADER" > /tmp/postgres/export_command.sql

psql -h $PGSOURCEIP -U $PGUSERID $1 < /tmp/postgres/export_command.sql 
