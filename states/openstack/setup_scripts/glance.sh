#!/bin/bash - 

echo "Create Glance database"
rm -rf /var/lib/glance/glance.sqlite
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "CREATE DATABASE {{ glance.database.mysql_user }};" 
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ glance.database.mysql_db }}.* TO '{{ glance.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ glance.database.mysql_pass }}';"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ glance.database.mysql_db }}.* TO '{{ glance.database.mysql_user }}'@'%' IDENTIFIED BY '{{ glance.database.mysql_pass }}';"

echo "Create Glacne database schema"
glance-manage db_sync

echo "Resulte"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "use glance; show tables;"

export OS_SERVICE_TOKEN={{ keystone.default.admin_token }}
export OS_SERVICE_ENDPOINT={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

keystone user-create --name={{ data.glance_user.name }} --pass={{ data.glance_user.passwd }} --email={{ data.glance_user.email  }}
keystone user-role-add --user={{ data.glance_user.name }} --role=admin --tenant={{ data.service.tenant }}
keystone service-create --name=glance --type=image --description="OpenStack Image Service"
keystone endpoint-create \
--service-id=$(keystone service-list | awk '/ image / {print $2}') \
--publicurl={{ endpoints.glance_api.public.protocol }}://{{ endpoints.glance_api.public.host }}:{{ endpoints.glance_api.public.port }} \
--internalurl={{ endpoints.glance_api.admin.protocol }}://{{ endpoints.glance_api.admin.host }}:{{ endpoints.glance_api.admin.port }} \
--adminurl={{ endpoints.glance_api.admin.protocol }}://{{ endpoints.glance_api.admin.host }}:{{ endpoints.glance_api.admin.port }}

echo "Restart glance-* service"
service glance-registry restart
service glance-api restart

echo "Add Base Image"
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
export OS_USERNAME={{ data.admin_user.name }}
export OS_PASSWORD={{ data.admin_user.passwd }}
export OS_TENANT_NAME=admin
export OS_AUTH_URL={{ endpoints.keystone.public.protocol }}://{{ endpoints.keystone.public.host }}:{{ endpoints.keystone.public.port }}/{{ endpoints.keystone.public.version }}

glance image-create \
--name="{{ data.base_image.name }}" \
--disk-format={{ data.base_image.format }} \
--container-format={{ data.base_image.container_format }} \
--is-public=true \
--copy-from {{ data.base_image.url }}
