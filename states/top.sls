base:
  '*':
    - mysql.client
    - openstack.memcached
    - zabbix.agent
  'brain.bs-datayes.com':
    - base.ntp-server
    - mysql.init-mysql
    - mysql.server
    - zabbix.init-zabbix
    - zabbix.server
    - zabbix.web
  'os-ctl.bs-datayes.com':
    - init-all
    - base.source-list
    - base.interfaces
    - base.ntp-client
    - mysql.init-mysql
    - mysql.server
    - openstack.init-openstack
    - openstack.clients
    - openstack.message-queue.rabbit
    - openstack.keystone.api
    - openstack.glance.api
    - openstack.glance.registry
    - openstack.nova.api
    - openstack.nova.cert
    - openstack.nova.conductor
    - openstack.nova.consoleauth
    - openstack.nova.novncproxy
    - openstack.nova.scheduler
    - openstack.neutron.api
    - openstack.dashboard.apache-dashboard
    - openstack.heat.api
    - openstack.heat.api-cfn
    - openstack.heat.engine
  'os-cp[1-3].bs-datayes.com':
    - base.source-list
    - base.interfaces
    - base.ntp-client
    - openstack.nova.compute
    - openstack.neutron.ovs
    - openstack.neutron.dhcp
    - openstack.neutron.metadata
    - openstack.neutron.lbaas
    - openstack.neutron.vpnaas
