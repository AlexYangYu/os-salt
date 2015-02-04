# vi: set ft=yaml.jinja :

bootstrap_cinder_storage:
    salt.state:
        - tgt: 'roles:ceph-ctl'
        - tgt_type: grain
        - sls:
            - openstack.cinder.bootstrap_storage
