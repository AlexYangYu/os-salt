base:
  '*':
    - base.mysql-client
    - openstack.memcached
    - zabbix.agent
  'controller.wx-datayes.com':
    - base.ntp-server
  'os-ctl.wx-datayes.com':
    - base.source-list
    - base.interfaces
    - base.ntp-client
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
  'os-cp[1-3].wx-datayes.com':
    - base.source-list
    - base.interfaces
    - base.ntp-client
    - openstack.nova-compute
    - openstack.neutron-network
