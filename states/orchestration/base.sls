# vi: set ft=yaml.jinja :

netwok_interfaces:
    salt.state:
        - tgt: '*'
        - sls:
            - base.interfaces

setup_apt_source:
    salt.state:
        - tgt: '*'
        - sls:
            - base.source-list
        - require:
            - salt: netwok_interfaces

setup_ntp_server:
    salt.state:
        - tgt: 'roles:ntp-server'
        - tgt_type: grain
        - sls:
            - base.ntp-server
        - require:
            - salt: setup_apt_source 

setup_ntp_client:
    salt.state:
        - tgt: 'roles:ntp-client'
        - tgt_type: grain 
        - sls:
            - base.ntp-client
        - require:
            - salt: setup_ntp_server

optimize_os_parameters:
    salt.state:
        - tgt: '*'
        - sls:
            - base.os_optimization
