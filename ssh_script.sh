#!/bin/bash

# Usage: ssh_script <target_host> <db_name> <table_name>

mkdir -p /tmp/postgres
ssh -i ./postgres_node_private_key $1 mkdir -p /tmp/postgres

./generate_export_sql.sh $2 $3
scp -i ./postgres_node_private_key /tmp/postgres/export.csv $1:/tmp/postgres
scp -i ./postgres_node_private_key ./generate_import_sql.sh $1:/tmp/postgres

ssh -i ./postgres_node_private_key $1 export PGTARGETIP=$PGTARGETIP
ssh -i ./postgres_node_private_key $1 export PGPASSWORD=$PGPASSWORD
ssh -i ./postgres_node_private_key $1 export PGUSERID=$PGUSERID

ssh -i ./postgres_node_private_key $1 echo $PGSOURCEIP > /tmp/postgres/source_ip.txt
ssh -i ./postgres_node_private_key $1 echo $PGTARGETIP > /tmp/postgres/target_ip.txt

ssh -i ./postgres_node_private_key $1 /tmp/postgres/generate_import_sql.sh $2 $3
