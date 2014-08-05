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

sed -i 's/^bind-address\s*=\s*[0-9]*.[0-9]*.[0-9]*.[0-9]*$/bind-address={{ mysql.bind_address }}/g' /etc/mysql/my.cnf
sed -i 's/^#*max_connections\s*=\s*[0-9]*$/max_connections={{ mysql.max_connections }}/g' /etc/mysql/my.cnf

service mysql restart
sleep 5

mysqladmin -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} flush-hosts
