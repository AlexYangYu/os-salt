init-data:
  admin_user:
    name: admin
    passwd: admin_pass
    email: admin@foo.com
  service:
    tenant: service
  glance_user:
    name: glance
    passwd: service_pass
    email: glance-admin@foo.com
  neutron_user:
    name: neutron
    passwd: service_pass
    email: neutron-admin@foo.com
  nova_user:
    name: nova
    passwd: service_pass
    email: nova-admin@foo.com
  cinder_user:
    name: cinder
    passwd: service_pass
    email: cinder-admin@foo.com
  heat_user:
    name: heat 
    passwd: heat_pass
    email: heat-admin@foo.com
  base_image:
    name: ubuntu-precise-amd64
    url: http://10.22.129.21/images/ubuntu-precise-amd64-heat.qcow2
    format: qcow2
    container_format: bare
