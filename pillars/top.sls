base:
  '*':
    - ntp
    - mysql
    - source
    - openstack.endpoints
    - openstack.init-data
    - openstack.message-queue
    - openstack.keystone
    - openstack.glance
    - openstack.nova
    - openstack.neutron
    - openstack.dashboard
    - openstack.cinder
    - openstack.heat
    - zabbix
