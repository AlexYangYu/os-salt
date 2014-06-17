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
  'cloud-t2.datayes.com':
    - openstack.nova-compute
  'cloud-t3.datayes.com':
    - openstack.nova-compute
