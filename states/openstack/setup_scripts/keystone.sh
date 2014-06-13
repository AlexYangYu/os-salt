#!/bin/bash

echo "Create Keystone database"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "CREATE DATABASE {{ keystone.database.mysql_db }};" 
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ keystone.database.mysql_db }}.* TO '{{ keystone.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ keystone.database.mysql_pass }}';"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ keystone.database.mysql_db }}.* TO '{{ keystone.database.mysql_user }}'@'%' IDENTIFIED BY '{{ keystone.database.mysql_pass }}';"

echo "Create Keystone database schema"
keystone-manage db_sync

echo "Result"
mysql -u{{ mysql.admin_user }} -p {{ mysql.admin_pass }} -e "use keystone; show tables;"
