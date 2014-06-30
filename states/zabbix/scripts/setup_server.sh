#!/bin/bash -

# Treat unset variables as an error
set -o nounset
set -e

echo "Create Zabbix Database"
mysql -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "CREATE DATABASE {{ db_name }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ db_name }}.* TO '{{ db_user }}'@'localhost' IDENTIFIED BY '{{ db_pass }}';"
mysql -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ db_name }}.* TO '{{ db_user }}'@'%' IDENTIFIED BY '{{ db_pass }}';"

echo "Un-Archive"
if [ -f /usr/share/zabbix-server-mysql/schema.sql.gz ]
then
    gunzip /usr/share/zabbix-server-mysql/schema.sql.gz
fi

if [ -f /usr/share/zabbix-server-mysql/images.sql.gz ]
then
    gunzip /usr/share/zabbix-server-mysql/images.sql.gz
fi

if [ -f /usr/share/zabbix-server-mysql/data.sql.gz ]
then
    gunzip /usr/share/zabbix-server-mysql/data.sql.gz
fi

echo "Create Zabbix Schema"
mysql -h{{ db_host }} -P{{ db_port }} -u{{ db_user }} -p{{ db_pass }} {{ db_name }} < /usr/share/zabbix-server-mysql/schema.sql
mysql -h{{ db_host }} -P{{ db_port }} -u{{ db_user }} -p{{ db_pass }} {{ db_name }} < /usr/share/zabbix-server-mysql/images.sql
mysql -h{{ db_host }} -P{{ db_port }} -u{{ db_user }} -p{{ db_pass }} {{ db_name }} < /usr/share/zabbix-server-mysql/data.sql

echo "Show Tables in Zabbix"
mysql -h{{ db_host }} -P{{ db_port }} -u{{ db_user }} -p{{ db_pass }} -e "use {{ db_name }}; show tables;"


sed -i 's/^START=\w*$/START="yes"/g' /etc/default/zabbix-server
service zabbix-server restart
sleep 5
