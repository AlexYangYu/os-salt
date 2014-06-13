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
  base_image:
    name: ubuntu-precise-amd64
    url: http://cloud-t1.datayes.com/images/ubuntu-precise-amd64-heat.qcow2
    format: qcow2
    container_format: bare
