base:
  '*':
    - base.hosts
    - base.ntp
    - base.mysql-client
    - openstack.memcached
    - zabbix.agent
  'controller.iaas-datayes.com':
    - base.mysql-server
    - zabbix.server
    - openstack.tools
    - openstack.message-queue
    - openstack.keystone
    - openstack.glance
    - openstack.clients
    - openstack.nova-controller
    - openstack.neutron-controller
    - openstack.dashboard
    - openstack.cinder-controller
    - openstack.cinder-volume
    - openstack.heat
  'compute-[1-4].iaas-datayes.com':
    - openstack.nova-compute
    - openstack.neutron-network
    - openstack.neutron-compute
