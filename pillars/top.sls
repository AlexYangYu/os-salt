# vi: set ft=yaml.jinja :

base:
  '*':
    - global
    - mine_functions
    - roles
    - ceph.env
    - ceph.conf
    - mariadb.conf
    - haproxy.conf
    - haproxy.cluster
    - keepalive.conf 
    - rabbitmq.conf
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
    - network
