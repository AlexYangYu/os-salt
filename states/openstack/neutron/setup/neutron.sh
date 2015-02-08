#!/bin/bash - 

{% set script_path = pillar['global']['script_path'] %}

echo "Create Neutron databse" 
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "CREATE DATABASE {{ neutron.database.mysql_db }} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" 
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ neutron.database.mysql_db }}.* TO '{{ neutron.database.mysql_user }}'@'localhost' IDENTIFIED BY '{{ neutron.database.mysql_pass }}';"
mysql -h{{ mysql_host }} -P{{ mysql_port }} -u{{ mysql_admin_user }} -p{{ mysql_admin_pass }} -e "GRANT ALL PRIVILEGES ON {{ neutron.database.mysql_db }}.* TO '{{ neutron.database.mysql_user }}'@'%' IDENTIFIED BY '{{ neutron.database.mysql_pass }}';"

export OS_SERVICE_TOKEN={{ keystone.default.admin_token }}
export OS_SERVICE_ENDPOINT={{ endpoints.keystone.admin.protocol }}://{{ endpoints.keystone.admin.host }}:{{ endpoints.keystone.admin.port }}/{{ endpoints.keystone.admin.version }}

echo "Fullfill Neutron configuration"
service_tenant_id=$(keystone tenant-list | awk '/ service / {print $2}')
sed -i 's/^nova_admin_tenant_id\ \?=\ \?.*$/nova_admin_tenant_id='$service_tenant_id'/g' /etc/neutron/neutron.conf

echo "Regist service"
keystone user-create --name={{ data.neutron_user.name }} --pass={{ data.neutron_user.passwd }} --email={{ data.neutron_user.email  }}
keystone user-role-add --user={{ data.neutron_user.name }} --role=admin --tenant={{ data.service.tenant }}
keystone service-create --name=neutron --type=network --description="OpenStack Networking Service"
keystone endpoint-create \
--region={{ endpoints.region }} \
--service-id=$(keystone service-list | awk '/ network / {print $2}') \
--publicurl={{ endpoints.neutron.public.protocol }}://{{ endpoints.neutron.public.host }}:{{ endpoints.neutron.public.port }} \
--internalurl={{ endpoints.neutron.admin.protocol }}://{{ endpoints.neutron.admin.host }}:{{ endpoints.neutron.admin.port }} \
--adminurl={{ endpoints.neutron.admin.protocol }}://{{ endpoints.neutron.admin.host }}:{{ endpoints.neutron.admin.port }}

neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno

#service neutron-server restart
salt -G 'roles:nova-api' cmd.run "service nova-api restart" 
salt -G 'roles:nova-scheduler' cmd.run "service nova-scheduler restart" 
salt -G 'roles:nova-conductor' cmd.run "service nova-conductor restart" 
salt -G 'roles:neutron-api' cmd.run "service neutron-server restart"
sleep 5

mkdir -p {{ script_path }}/run
touch {{ script_path }}/run/neutron.init.lock
