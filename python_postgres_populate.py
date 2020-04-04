#!/usr/bin/python3
 
import psycopg2
import time
import os

userid = os.getenv('PGUSERID')
password = os.getenv('PGPASSWORD')
source_ip = os.getenv('PGSOURCEIP')

conn = psycopg2.connect("dbname=ndb_test host=" + source_ip + " user=" + userid + " password=" + password)
cur = conn.cursor()

test_for_table_sql = "select * from information_schema.tables where table_name='ndb_test_table';"
cur.execute(test_for_table_sql)

if cur.rowcount == 0:
	
	sql_create_string = """CREATE TABLE ndb_test_table (
				sequence_id INTEGER NOT NULL,
				string1 VARCHAR,
				string2 VARCHAR,
				string3 VARCHAR,
				PRIMARY KEY (sequence_id))
		"""
		
	cur.execute(sql_create_string)
	conn.commit()
#

###
start_index = 0

get_max_sequence_id_sql_string = "select max(sequence_id) from ndb_test_table;"
cur.execute(get_max_sequence_id_sql_string)
try:
	start_index = cur.fetchone()[0] + 1
except:
	pass
	
while (True):
	
	time.sleep(1)
	
	sql_insert_string = "insert into ndb_test_table (sequence_id, string1, string2, string3) values ('" + str(start_index) + "', 'string1_" + str(start_index) + "', 'string2_" + str(start_index) + "', 'string3_" + str(start_index) + "');"
	cur.execute(sql_insert_string)
	conn.commit()
	
	start_index = start_index + 1
#
