#!/bin/bash

# Usage: ssh_script <target_host> <db_name> <table_name>

mkdir -p /tmp/postgres
ssh -i ./postgres_node_private_key $1 mkdir -p /tmp/postgres

rm /tmp/postgres/export.csv

./generate_export_sql.sh $2 $3

zip -j /tmp/postgres/export.csv.zip /tmp/postgres/export.csv

ssh -i ./postgres_node_private_key $1 rm /tmp/postgres/export.csv
ssh -i ./postgres_node_private_key $1 rm /tmp/postgres/export.csv.zip

scp -i ./postgres_node_private_key /tmp/postgres/export.csv.zip $1:/tmp/postgres
scp -i ./postgres_node_private_key ./generate_import_sql.sh $1:/tmp/postgres

ssh -i ./postgres_node_private_key $1 unzip /tmp/postgres/export.csv.zip -d /tmp/postgres/

ssh -i ./postgres_node_private_key $1 PGSOURCEIP=$PGTARGETIP \
PGPASSWORD=$PGTARGETPASSWORD \
PGUSERID=$PGUSERID \
/tmp/postgres/generate_import_sql.sh $2 $3
