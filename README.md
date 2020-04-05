The following settings need to be in pg_hba.conf 
===================================
```
host    all             all             0.0.0.0/0            md5
host    all             all             ::1/128               md5

host    replication     all             0.0.0.0/0      md5
host    replication     all             ::1/128         md5
```

The following environment variables must be set
================================
```
export PGUSERID=<db_user_id>
export PGPASSWORD=<source_db_password>
export PGTARGETPASSWORD=<target_db_password>
export PGSOURCEIP=<ip_address_of_db_source>
export PGTARGETIP=<ip_address_of_db_target>
```

ssh / scp access
============
```
ssh / scp must be configured to allow direct private key access between postgres DB nodes.

The private ssh  key to access the Standby node must be named 'postgres_node_private_key' and must be inside this tool's project directory in the same location as the scripts.
```

Usage
=====
Example python script:  'python_postgres_populate.py'

On the Master database node, run:

```
	> python_postgres_populate.py MASTER
```

On the Standby database node, run:

```
	> python_postgres_populate.py STANDBY
```

The version of the python script running on the Master will start populating the Master database with sample data.

The version of the python script running on the Standby database will await successful replication from the Master before starting to populate its own Standby database with its own sample data.

Leave the python scripts running on the Master & Standby and then run:
```
	> execute_replication.sh <target_host> <db_name> <table_name>
```
