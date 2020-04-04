#!/bin/bash
 
path_to_csv='/tmp/export.csv'
echo "\copy $2 to $path_to_csv DELIMITER ',' CSV HEADER" > export_command.sql

psql -h $PGSOURCEIP -U $PGUSERID $1 < export_command.sql 
