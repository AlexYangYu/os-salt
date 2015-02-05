# vi: set ft=yaml.jinja :

#bootstrap_cinder_storage:
#    salt.state:
#        - tgt: 'roles:ceph-ctl'
#        - tgt_type: grain
#        - sls:
#            - openstack.cinder.bootstrap_storage

setup_cinder_api:
    salt.state:
        - tgt: 'roles:cinder-api'
        - tgt_type: grain
        - sls:
            - openstack.cinder.api
#        - require:
#            - salt: bootstrap_cinder_storage

setup_cinder_scheduler:
    salt.state:
        - tgt: 'roles:cinder-scheduler'
        - tgt_type: grain
        - sls:
            - openstack.cinder.scheduler
        - require:
            - salt: setup_cinder_api

setup_cinder_volume:
    salt.state:
        - tgt: 'roles:cinder-volume'
        - tgt_type: grain
        - sls:
            - openstack.cinder.volume
        - require:
            - salt: setup_cinder_scheduler

setup_cinder_backup:
    salt.state:
        - tgt: 'roles:cinder-backup'
        - tgt_type: grain
        - sls:
            - openstack.cinder.backup
        - require:
            - salt: setup_cinder_volume

#init_cinder_service:
#    salt.state:
#        - tgt: 'roles:openstack-init'
#        - tgt_type: grain
#        - sls:
#            - openstack.cinder.init
#        - require:
#            - salt: setup_cinder_backup
