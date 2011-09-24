#!/usr/bin/env python

import sqlite3, json

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

conn = sqlite3.connect('Resources/main.sql')
conn.row_factory = dict_factory
c = conn.cursor()

c.execute("select * from user")
rows = {}
for row in c:
  del row['data']
  rows[row['uid']] = row

for uid, row in rows.items():
  data = json.dumps(row)
  print data
  c.execute("update user set data=? where uid=?", (data, uid))

####

c.execute("select * from node")
rows = {}
for row in c:
  del row['data']
  rows[row['nid']] = row

for nid, row in rows.items():
  row['time'] = "xx"
  data = json.dumps(row)
  print data
  c.execute("update node set data=? where nid=?", (data, nid))

conn.commit()



