#!/bin/bash - 

echo "Create Heat database"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "CREATE DATABASE {{ heat.database.mysql_db }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ heat.database.mysql_db }}.* TO '{{ heat.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ heat.database.mysql_pass }}';"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ heat.database.mysql_db }}.* TO '{{ heat.database.mysql_user }}'@'%' IDENTIFIED BY '{{ heat.database.mysql_pass }}';"

echo "Create Heat database schema"
heat-manage db_sync

echo "Result"
mysql -u{{ mysql.admin_user }} -p{{ mysql.admin_pass }} -e "use {{ heat.database.mysql_db }}; show tables;"

export OS_SERVICE_TOKEN={{ keystone.default.admin_token }}
export OS_SERVICE_ENDPOINT={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

echo "Regist user and role"
keystone user-create --name={{ data.heat_user.name }} --pass={{ data.heat_user.passwd }} --email={{ data.heat_user.email  }}
keystone user-role-add --user={{ data.heat_user.name }} --role=admin --tenant={{ data.service.tenant }}
keystone role-create --name {{ heat.default.heat_stack_user_role }}

echo "Regist endpoints"
keystone service-create --name=heat --type=orchestration --description="OpenStack Orchestration Service"
keystone endpoint-create \
--region={{ endpoints.region }} \
--service-id=$(keystone service-list | awk '/ orchestration / {print $2}') \
--publicurl={{ endpoints.heat_api.public.protocol }}://{{ endpoints.heat_api.public.host }}:{{ endpoints.heat_api.public.port }}/{{ endpoints.heat_api.public.version }}/%\(tenant_id\)s \
--internalurl={{ endpoints.heat_api.admin.protocol }}://{{ endpoints.heat_api.admin.host }}:{{ endpoints.heat_api.admin.port }}/{{ endpoints.heat_api.public.version }}/%\(tenant_id\)s \
--adminurl={{ endpoints.heat_api.admin.protocol }}://{{ endpoints.heat_api.admin.host }}:{{ endpoints.heat_api.admin.port }}/{{ endpoints.heat_api.public.version }}/%\(tenant_id\)s

keystone service-create --name=heat-cfn --type=cloudformation --description="OpenStack Orchestration Cloudformation Service"
keystone endpoint-create \
--region={{ endpoints.region }} \
--service-id=$(keystone service-list | awk '/ cloudformation / {print $2}') \
--publicurl={{ endpoints.heat_cfn.public.protocol }}://{{ endpoints.heat_cfn.public.host }}:{{ endpoints.heat_cfn.public.port }}/{{ endpoints.heat_cfn.public.version }} \
--internalurl={{ endpoints.heat_cfn.admin.protocol }}://{{ endpoints.heat_cfn.admin.host }}:{{ endpoints.heat_cfn.admin.port }}/{{ endpoints.heat_cfn.public.version }} \
--adminurl={{ endpoints.heat_cfn.admin.protocol }}://{{ endpoints.heat_cfn.admin.host }}:{{ endpoints.heat_cfn.admin.port }}/{{ endpoints.heat_cfn.public.version }}

service heat-api restart
service heat-api-cfn restart
service heat-engine restart
sleep 5
