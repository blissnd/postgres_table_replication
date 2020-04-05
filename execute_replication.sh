#!/bin/bash

# Usage: execute_replication.sh <target_host> <db_name> <table_name> <target_node_user_id>

mkdir -p /tmp/postgres
ssh -i ./postgres_node_private_key $4@$1 mkdir -p /tmp/postgres

rm /tmp/postgres/export.csv

./generate_export_sql.sh $2 $3

zip -j /tmp/postgres/export.csv.zip /tmp/postgres/export.csv

ssh -i ./postgres_node_private_key $4@$1 rm /tmp/postgres/export.csv
ssh -i ./postgres_node_private_key $4@$1 rm /tmp/postgres/export.csv.zip

scp -i ./postgres_node_private_key /tmp/postgres/export.csv.zip $4@$1:/tmp/postgres
scp -i ./postgres_node_private_key ./generate_import_sql.sh $4@$1:/tmp/postgres

ssh -i ./postgres_node_private_key $4@$1 unzip /tmp/postgres/export.csv.zip -d /tmp/postgres/

ssh -i ./postgres_node_private_key $4@$1 PGSOURCEIP=$PGTARGETIP \
PGPASSWORD=$PGTARGETPASSWORD \
PGUSERID=$PGTARGETUSERID \
/tmp/postgres/generate_import_sql.sh $2 $3
