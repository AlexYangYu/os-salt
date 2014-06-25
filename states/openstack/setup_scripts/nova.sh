#!/bin/bash - 

echo "Create Nova database"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "CREATE DATABASE {{ nova.database.mysql_db }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ nova.database.mysql_db }}.* TO '{{ nova.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ nova.database.mysql_pass }}';"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ nova.database.mysql_db }}.* TO '{{ nova.database.mysql_user }}'@'%' IDENTIFIED BY '{{ nova.database.mysql_pass }}';"

echo "Create Nova database schema"
nova-manage db sync

echo "Result"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "use {{ nova.database.mysql_db }}; show tables;"


export OS_SERVICE_TOKEN={{ keystone.default.admin_token }}
export OS_SERVICE_ENDPOINT={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

keystone user-create --name={{ data.nova_user.name }} --pass={{ data.nova_user.passwd }} --email={{ data.nova_user.email  }}
keystone user-role-add --user={{ data.nova_user.name }} --role=admin --tenant={{ data.service.tenant }}
keystone service-create --name=nova --type=compute --description="OpenStack Compute Service"
keystone endpoint-create \
--region={{ endpoints.region }} \
--service-id=$(keystone service-list | awk '/ compute / {print $2}') \
--publicurl={{ endpoints.nova.public.protocol }}://{{ endpoints.nova.public.host }}:{{ endpoints.nova.public.port }}/{{ endpoints.nova.public.version }}/%\(tenant_id\)s \
--internalurl={{ endpoints.nova.admin.protocol }}://{{ endpoints.nova.admin.host }}:{{ endpoints.nova.admin.port }}/{{ endpoints.nova.public.version }}/%\(tenant_id\)s \
--adminurl={{ endpoints.nova.admin.protocol }}://{{ endpoints.nova.admin.host }}:{{ endpoints.nova.admin.port }}/{{ endpoints.nova.public.version }}/%\(tenant_id\)s 


echo "Start Nova Services"
service nova-api restart
service nova-scheduler restart
service nova-conductor restart
service nova-cert restart
service nova-consoleauth restart
service nova-novncproxy restart
sleep 5

echo "Test Nova"
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
export OS_USERNAME={{ data.admin_user.name }}
export OS_PASSWORD={{ data.admin_user.passwd }}
export OS_TENANT_NAME=admin
export OS_AUTH_URL={{ endpoints.keystone.public.protocol }}://{{ endpoints.keystone.public.host }}:{{ endpoints.keystone.public.port }}/{{ endpoints.keystone.public.version }}

nova image-list
