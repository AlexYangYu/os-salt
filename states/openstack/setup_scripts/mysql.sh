#!/bin/bash - 

mysql_secure_installation << EOF

y
{{ mysql.admin_pass }}
{{ mysql.admin_pass }}
y
y
y
y
EOF

service mysql-server restart
