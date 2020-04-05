#!/bin/bash
 
rm /tmp/postgres/ERROR
rm /tmp/postgres/DONE

path_to_csv='/tmp/postgres/export.csv'
echo "\copy $2 from $path_to_csv DELIMITER ',' CSV HEADER" > /tmp/postgres/import_command.sql
	
output=$(psql -h $PGSOURCEIP -U $PGUSERID $1 < /tmp/postgres/import_command.sql 2>&1)

if [[ "$output" == *"ERROR"* ]]; then
	echo $output > /tmp/postgres/ERROR
else
	echo $output > /tmp/postgres/DONE
fi
