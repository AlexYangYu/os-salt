#!/bin/bash

echo "Create Keystone database"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "CREATE DATABASE {{ keystone.database.mysql_db }};" 
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ keystone.database.mysql_db }}.* TO '{{ keystone.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ keystone.database.mysql_pass }}';"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ keystone.database.mysql_db }}.* TO '{{ keystone.database.mysql_user }}'@'%' IDENTIFIED BY '{{ keystone.database.mysql_pass }}';"

echo "Create Keystone database schema"
keystone-manage db_sync

echo "Result"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "use keystone; show tables;"

export OS_SERVICE_TOKEN={{ keystone.default.admin_token }}
export OS_SERVICE_ENDPOINT={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

echo "Create Admin tenant"
keystone user-create --name={{ data.admin_user.name }} --pass={{ data.admin_user.passwd }} --email={{ data.admin_user.email }}
keystone role-create --name=admin
keystone tenant-create --name=admin --description="Admin Tenant"
keystone user-role-add --user={{ data.admin_user.name }} --tenant=admin --role=admin
keystone user-role-add --user={{ data.admin_user.name }} --role=_member_ --tenant=admin

echo "Create Service tenant"
keystone tenant-create --name=service --description="Service Tenant"

echo "Create Endpoint"
keystone service-create --name=keystone --type=identity --description="OpenStack Identity"

keystone endpoint-create \
--service-id=$(keystone service-list | awk '/ identity / {print $2}') \
--publicurl={{ endpoints.keystone.public.protocol }}://{{ endpoints.keystone.public.host }}:{{ endpoints.keystone.public.port }}/{{ endpoints.keystone.public.version }} \
--internalurl={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }} \
--adminurl={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

echo "Verify Keystone setup"
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
export OS_USERNAME={{ data.admin_user.name }}
export OS_PASSWORD={{ data.admin_user.passwd }}
export OS_TENANT_NAME=admin
export OS_AUTH_URL={{ endpoints.keystone.public.protocol }}://{{ endpoints.keystone.public.host }}:{{ endpoints.keystone.public.port }}/{{ endpoints.keystone.public.version }}

keystone token-get
keystone user-list
