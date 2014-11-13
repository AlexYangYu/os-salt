base:
  '*':
    - base.source-list
    - base.interfaces
    - mysql.client
    - openstack.memcached
    - zabbix.agent
  'mgt-center.t-datayes.com':
    - base.ntp-server
    - mysql.init-mysql
    - mysql.server
    - zabbix.init-zabbix
    - zabbix.server
    - zabbix.web
  'ctl01.t-datayes.com':
    - base.ntp-client
    - init-all
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
    - openstack.cinder.api
    - openstack.cinder.scheduler
    - openstack.cinder.volume
    - openstack.dashboard.apache-dashboard
    - openstack.heat.api
    - openstack.heat.api-cfn
    - openstack.heat.engine
  'compute*':
    - base.ntp-client
    - openstack.nova.compute
    - openstack.neutron.ovs
  'net*':
    - base.ntp-client
    - openstack.neutron.ovs
    - openstack.neutron.dhcp
    - openstack.neutron.metadata
    - openstack.neutron.lbaas
    - openstack.neutron.vpnaas
