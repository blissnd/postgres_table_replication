#!/bin/bash

ssh -i ./postgres_node_private_key $1 mkdir -p /tmp/postgres

scp -i ./postgres_node_private_key /tmp/export.csv $1:/tmp/postgres
scp -i ./postgres_node_private_key ./generate_import_sql.sh $1:/tmp/postgres
scp -i ./postgres_node_private_key ./generate_export_sql.sh $1:/tmp/postgres
