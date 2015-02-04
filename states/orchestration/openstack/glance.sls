# vi: set ft=yaml.jinja :

#bootstrap_glance_storage:
#    salt.state:
#        - tgt: 'roles:ceph-ctl' 
#        - tgt_type: grain
#        - sls:
#            - openstack.glance.bootstrap_storage

setup_glance_api_server:
    salt.state:
        - tgt: 'roles:glance-api'
        - tgt_type: grain
        - sls:
            - openstack.glance.api
#        - require:
#            - salt: bootstrap_glance_storage

setup_glance_registry_server:
    salt.state:
        - tgt: 'roles:glance-registry'
        - tgt_type: grain
        - sls:
            - openstack.glance.registry
        - require:
            - salt: setup_glance_api_server

init_glance_service:
    salt.state:
        - tgt: 'roles:openstack-init'
        - tgt_type: grain
        - sls:
            - openstack.glance.init
        - require:
            - salt: setup_glance_registry_server
