# vi: set ft=yaml.jinja :

setup_neutron_server:
    salt.state:
        - tgt: 'roles:neutron-api'
        - tgt_type: grain
        - sls:
            - openstack.neutron.api
