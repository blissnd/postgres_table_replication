 #!/bin/bash
 
 path_to_csv='/tmp/export.csv'
 echo "\copy $2 from $path_to_csv DELIMITER ',' CSV HEADER" > import_command.sql
 
 exit_condition=0
 
 while [ $exit_condition -eq 0 ]; do
	
	output=$(psql -h $PGSOURCEIP -U $PGUSERID $1 < import_command.sql 2>&1)
	
	if [[ "$output" != *"ERROR"* ]]; then
		exit_condition=1
	fi
	
	sed -i '1d' $path_to_csv
done
