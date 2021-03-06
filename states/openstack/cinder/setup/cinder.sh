#!/bin/bash - 

{% set script_path = pillar['global']['script_path'] %}

echo "Create Cinder database"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "CREATE DATABASE {{ cinder.database.mysql_db }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ cinder.database.mysql_db }}.* TO '{{ cinder.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ cinder.database.mysql_pass }}';"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ cinder.database.mysql_db }}.* TO '{{ cinder.database.mysql_user }}'@'%' IDENTIFIED BY '{{ cinder.database.mysql_pass }}';"

echo "Create Cinder database schema"
cinder-manage db sync

echo "Result"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ cinder.database.mysql_user }} -p{{ cinder.database.mysql_pass }} -e "use {{ cinder.database.mysql_db }}; show tables;"

export OS_SERVICE_TOKEN={{ keystone.default.admin_token }}
export OS_SERVICE_ENDPOINT={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

keystone user-create --name={{ data.cinder_user.name }} --pass={{ data.cinder_user.passwd }} --email={{ data.cinder_user.email  }}
keystone user-role-add --user={{ data.cinder_user.name }} --role=admin --tenant={{ data.service.tenant }}

echo "Regist V1 API"
keystone service-create --name=cinder --type=volume --description="OpenStack Block Service"
keystone endpoint-create \
--region={{ endpoints.region }} \
--service-id=$(keystone service-list | awk '/ volume / {print $2}') \
--publicurl={{ endpoints.cinder_v1.public.protocol }}://{{ endpoints.cinder_v1.public.host }}:{{ endpoints.cinder_v1.public.port }}/{{ endpoints.cinder_v1.public.version }}/%\(tenant_id\)s \
--internalurl={{ endpoints.cinder_v1.admin.protocol }}://{{ endpoints.cinder_v1.admin.host }}:{{ endpoints.cinder_v1.admin.port }}/{{ endpoints.cinder_v1.public.version }}/%\(tenant_id\)s \
--adminurl={{ endpoints.cinder_v1.admin.protocol }}://{{ endpoints.cinder_v1.admin.host }}:{{ endpoints.cinder_v1.admin.port }}/{{ endpoints.cinder_v1.public.version }}/%\(tenant_id\)s

echo "Regist V2 API"
keystone service-create --name=cinderv2 --type=volumev2 --description="OpenStack Block Service V2"
keystone endpoint-create \
--region={{ endpoints.region }} \
--service-id=$(keystone service-list | awk '/ volumev2 / {print $2}') \
--publicurl={{ endpoints.cinder_v2.public.protocol }}://{{ endpoints.cinder_v2.public.host }}:{{ endpoints.cinder_v2.public.port }}/{{ endpoints.cinder_v2.public.version }}/%\(tenant_id\)s \
--internalurl={{ endpoints.cinder_v2.admin.protocol }}://{{ endpoints.cinder_v2.admin.host }}:{{ endpoints.cinder_v2.admin.port }}/{{ endpoints.cinder_v2.public.version }}/%\(tenant_id\)s \
--adminurl={{ endpoints.cinder_v2.admin.protocol }}://{{ endpoints.cinder_v2.admin.host }}:{{ endpoints.cinder_v2.admin.port }}/{{ endpoints.cinder_v2.public.version }}/%\(tenant_id\)s

echo "Start Service"
#service cinder-api restart
#service cinder-scheduler restart
#service cinder-volume restart
#service cinder-backup restart
salt -G 'roles:cinder-*' cmd.run "service cinder-api restart"
salt -G 'roles:cinder-*' cmd.run "service cinder-scheduler restart"
salt -G 'roles:cinder-*' cmd.run "service cinder-volume restart"
salt -G 'roles:cinder-*' cmd.run "service cinder-backup restart"
sleep 5

echo "Verify Cinder"
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
export OS_USERNAME={{ data.admin_user.name }}
export OS_PASSWORD={{ data.admin_user.passwd }}
export OS_TENANT_NAME=admin
export OS_AUTH_URL={{ endpoints.keystone.public.protocol }}://{{ endpoints.keystone.public.host }}:{{ endpoints.keystone.public.port }}/{{ endpoints.keystone.public.version }}

cinder create --display-name testVolume 5

mkdir -p {{ script_path }}/run
touch {{ script_path }}/run/cinder.init.lock
