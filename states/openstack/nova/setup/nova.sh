#!/bin/bash - 

{% set script_path = pillar['global']['script_path'] %}

echo "Create Nova database"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "CREATE DATABASE {{ nova.database.mysql_db }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ nova.database.mysql_db }}.* TO '{{ nova.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ nova.database.mysql_pass }}';"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ nova.database.mysql_db }}.* TO '{{ nova.database.mysql_user }}'@'%' IDENTIFIED BY '{{ nova.database.mysql_pass }}';"

echo "Create Nova database schema"
nova-manage db sync

echo "Result"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ nova.database.mysql_user }} -p{{ nova.database.mysql_pass }} -e "use {{ nova.database.mysql_db }}; show tables;"

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
#service nova-api restart
#service nova-scheduler restart
#service nova-conductor restart
#service nova-cert restart
#service nova-consoleauth restart
#service nova-novncproxy restart
salt -G 'roles:nova-*' cmd.run "service nova-api restart"
salt -G 'roles:nova-*' cmd.run "service nova-scheduler restart"
salt -G 'roles:nova-*' cmd.run "service nova-conductor restart"
salt -G 'roles:nova-*' cmd.run "service nova-cert restart"
salt -G 'roles:nova-*' cmd.run "service nova-consoleauth restart"
salt -G 'roles:nova-*' cmd.run "service nova-novncproxy restart"
sleep 5

echo "Test Nova"
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
export OS_USERNAME={{ data.admin_user.name }}
export OS_PASSWORD={{ data.admin_user.passwd }}
export OS_TENANT_NAME=admin
export OS_AUTH_URL={{ endpoints.keystone.public.protocol }}://{{ endpoints.keystone.public.host }}:{{ endpoints.keystone.public.port }}/{{ endpoints.keystone.public.version }}

nova image-list

mkdir -p {{ script_path }}/run
touch {{ script_path }}/run/nova.init.lock
