base:
  '*':
    - base.ntp
    - base.mysql-client
    - openstack.memcached
    - zabbix.agent
  'os-ctl.wx-datayes.com':
    - base.interfaces
    - base.mysql-server
    - zabbix.server
    - zabbix.web
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
  'os-cp[1-3].ws-datayes.com':
    - base.interfaces
    - openstack.nova-compute
    - openstack.neutron-network
    - openstack.neutron-compute
