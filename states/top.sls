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
