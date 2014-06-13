base:
  '*':
    - address
    - openstack.endpoints
  'cloud-t1.datayes.com':
    - openstack.init-data
    - mysql
    - openstack.message-queue
    - openstack.keystone
    - openstack.glance
