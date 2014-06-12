base:
  '*':
    - base.hosts
    - base.ntp
    - openstack.repo
  'cloud-t1.datayes.com':
    - openstack.message-queue
