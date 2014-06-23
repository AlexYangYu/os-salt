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

sed -i 's/^bind-address\ \?=\ \?.*$/bind-address={{ mysql.bind_address }}/g' /etc/neutron/neutron.conf

service mysql restart
