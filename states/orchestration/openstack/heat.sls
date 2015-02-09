# vi: set ft=yaml.jinja :

setup_heat:
    salt.state:
        - tgt: 'roles:heat'
        - tgt_type: grain
        - sls:
            - openstack.heat.api
            - openstack.heat.api-cfn
            - openstack.heat.engine

init_heat:
    salt.state:
        - tgt: 'roles:openstack-init'
        - tgt_type: grain
        - sls:
            - openstack.heat.init
        - require:
            - salt: setup_heat
