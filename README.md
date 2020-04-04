The following settings need to be in postgresql.conf 
===================================
listen_addresses = '*'		# what IP address(es) to listen on;
shared_preload_libraries = 'pglogical'		# (change requires restart)
max_worker_processes = 8		# (change requires restart)
wal_level = logical			# minimal, replica, or logical
max_wal_senders = 8		# max number of walsender processes
max_replication_slots = 8	# max number of replication slots (change requires restart)
track_commit_timestamp = on	# collect timestamp of transaction commit (change requires restart)


The following settings need to be in pg_hba.conf 
===================================
host    all             all             0.0.0.0/0            md5
host    all             all             ::1/128                 md5

host    replication     all             0.0.0.0/0            md5
host    replication     all             ::1/128                 md5
