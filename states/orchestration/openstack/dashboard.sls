# vi: set ft=yaml.jinja :

setup_dashboard:
    salt.state:
        - tgt: 'roles:dashboard'
        - tgt_type: grain
        - sls:
            - openstack.dashboard.apache-dashboard
