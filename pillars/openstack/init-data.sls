# vi: set ft=yaml.jinja :

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
        name: cirros-0.3.3-x86_64
        url: http://apt-server/images/cirros-0.3.3-x86_64-disk.img
        format: raw 
        container_format: bare
