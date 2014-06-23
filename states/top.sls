base:
  '*':
    - base.hosts
    - base.ntp
    - base.mysql-client
    - openstack.repo
    - openstack.memcached
  'controller.novalocal':
    - base.mysql-server
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
  'compute-[1-3].novalocal':
    - openstack.nova-compute
    - openstack.neutron-network
    - openstack.neutron-compute
