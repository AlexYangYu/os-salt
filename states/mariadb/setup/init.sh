#!/bin/bash - 

mysql_secure_installation << EOF
{{ mysql.admin_pass }}
n
y
y
y
y
EOF
