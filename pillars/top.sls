base:
  '*':
    - address
    - openstack.endpoints
  'cloud-t1.datayes.com':
    - openstack.init-data
    - openstack.message-queue
    - openstack.keystone
    - mysql
