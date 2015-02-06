# vi: set ft=yaml.jinja :

bootstrap_nova_storage:
    salt.state:
        - tgt: 'roles:ceph-ctl'
        - tgt_type: grain
        - sls:
            - openstack.nova.bootstrap_storage

setup_nova_compute:
    salt.state:
        - tgt: 'roles:nova-compute'
        - tgt_type: grain
        - sls:
            - openstack.nova.compute
        - require:
            - salt: bootstrap_nova_storage

setup_nova_api:
    salt.state:
        - tgt: 'roles:nova-api'
        - tgt_type: grain
        - sls:
            - openstack.nova.api
        - require:
            - salt: setup_nova_compute

setup_nova_cert:
    salt.state:
        - tgt: 'roles:nova-cert'
        - tgt_type: grain
        - sls:
            - openstack.nova.cert
        - require:
            - salt: setup_nova_api

setup_nova_conductor:
    salt.state:
        - tgt: 'roles:nova-conductor'
        - tgt_type: grain
        - sls:
            - openstack.nova.conductor
        - require:
            - salt: setup_nova_cert

setup_nova_consoleauth:
    salt.state:
        - tgt: 'roles:nova-consoleauth'
        - tgt_type: grain
        - sls:
            - openstack.nova.consoleauth
        - require:
            - salt: setup_nova_conductor

setup_nova_novncproxy:
    salt.state:
        - tgt: 'roles:nova-novncproxy'
        - tgt_type: grain
        - sls:
            - openstack.nova.novncproxy
        - require:
            - salt: setup_nova_consoleauth

setup_nova_scheduler:
    salt.state:
        - tgt: 'roles:nova-scheduler'
        - tgt_type: grain
        - sls:
            - openstack.nova.scheduler
        - require:
            - salt: setup_nova_novncproxy

init_nova_service:
    salt.state:
        - tgt: 'roles:openstack-init'
        - tgt_type: grain
        - sls:
            - openstack.nova.init
        - require:
            - salt: setup_nova_scheduler
