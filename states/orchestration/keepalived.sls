# vi: set ft=yaml.jinja :

setup_master:
    salt.state:
        - tgt: 'roles:ha-master'
        - tgt_type: grain 
        - sls: keepalive.keepalived

setup_slave:
    salt.state:
        - tgt: 'roles:ha-slave'
        - tgt_type: grain 
        - sls: keepalive.keepalived
        - require:
            - salt: setup_master
