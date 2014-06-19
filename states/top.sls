base:
  '*':
    - base.hosts
    - base.ntp
    - openstack.repo
    - openstack.memcached
  'cloud-t1.datayes.com':
    - openstack.message-queue
    - openstack.keystone
    - openstack.glance
    - openstack.clients
    - openstack.nova-controller
    - openstack.neutron-controller
    - openstack.dashboard
  'cloud-t2.datayes.com':
    - openstack.nova-compute
    - openstack.neutron-network
    - openstack.neutron-compute
