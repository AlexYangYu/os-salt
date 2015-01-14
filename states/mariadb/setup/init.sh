#!/bin/bash - 

# check the mysql is running
killall -0 mysqld

if [ 0 -ne $?]
then
    exit 0
fi

mysql_secure_installation << EOF
{{ mysql.admin_pass }}
n
y
y
y
y
EOF
