# vi: set ft=yaml.jinja :

setup_keystone_api_server:
    salt.state:
        - tgt: 'roles:keystone-api'
        - tgt_type: grain
        - sls:
            - openstack.keystone.api

init_keystone_service:
    salt.state:
        - tgt: 'roles:openstack-init'
        - tgt_type: grain
        - sls:
            - openstack.keystone.init
        - require:
            - salt: setup_keystone_api_server 
