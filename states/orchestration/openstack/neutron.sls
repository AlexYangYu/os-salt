# vi: set ft=yaml.jinja :

setup_neutron_server:
    salt.state:
        - tgt: 'roles:neutron-api'
        - tgt_type: grain
        - sls:
            - openstack.neutron.api

init_neutron_service:
    salt.state:
        - tgt: 'roles:openstack-init'
        - tgt_type: grain
        - sls:
            - openstack.neutron.init
        - require:
            - salt: setup_neutron_server

setup_neutron_l2_agent:
    salt.state:
        - tgt: 'roles:nova-compute'
        - tgt_type: grain
        - sls:
            - openstack.neutron.ovs
        - require:
            - salt: init_neutron_service

setup_neutron_network:
    salt.state:
        - tgt: 'roles:neutron-network'
        - tgt_type: grain
        - sls:
            - openstack.neutron.dhcp
            - openstack.neutron.vpnaas
            - openstack.neutron.metadata
            - openstack.neutron.lbaas
        - require:
            - salt: init_neutron_service
