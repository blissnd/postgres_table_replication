#!/bin/bash

# Usage: create_remote_table <target_host> <target_db>

scp -i ./postgres_node_private_key ./create_remote_table.sql $1:/tmp/postgres

ssh -i ./postgres_node_private_key $1 PGSOURCEIP=$PGTARGETIP \
PGPASSWORD=$PGTARGETPASSWORD \
PGUSERID=$PGUSERID \
psql -h $PGTARGETIP -U $PGUSERID $2 < ./create_remote_table.sql 
