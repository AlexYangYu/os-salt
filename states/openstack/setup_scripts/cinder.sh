#!/bin/bash - 

echo "Create Cinder database"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "CREATE DATABASE {{ cinder.database.mysql_db }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ cinder.database.mysql_db }}.* TO '{{ cinder.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ cinder.database.mysql_pass }}';"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ cinder.database.mysql_db }}.* TO '{{ cinder.database.mysql_user }}'@'%' IDENTIFIED BY '{{ cinder.database.mysql_pass }}';"

echo "Create Cinder database schema"
cinder-manage db_sync

echo "Result"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "use {{ cinder.database.mysql_db }}; show tables;"

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
--publicurl={{ endpoints.cinder_v1.public.protocol }}://{{ endpoints.cinder_v1.public.host }}:{{ endpoints.cinder_v1.public.port }}/{{ endpoints.cinder_v1.public.version }}/%\(tenant_id\)s \
--internalurl={{ endpoints.cinder_v1.admin.protocol }}://{{ endpoints.cinder_v1.admin.host }}:{{ endpoints.cinder_v1.admin.port }}/{{ endpoints.cinder_v1.public.version }}/%\(tenant_id\)s \
--adminurl={{ endpoints.cinder_v1.admin.protocol }}://{{ endpoints.cinder_v1.admin.host }}:{{ endpoints.cinder_v1.admin.port }}/{{ endpoints.cinder_v1.public.version }}/%\(tenant_id\)s

echo "Start Service"
cd /etc/init.d/; ls cinder-* | xargs -i service {} restart; cd -
