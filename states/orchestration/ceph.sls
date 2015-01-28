# vi: set ft=yaml.jinja :

setup_mon:
    salt.state:
        - tgt: 'roles:ceph-mon'
        - tgt_type: grain
        - sls:
            - ceph.mon

setup_osd:
    salt.state:
        - tgt: 'roles:ceph-osd'
        - tgt_type: grain
        - sls:
            - ceph.osd
        - require:
            - salt: setup_mon

setup_ceph_client:
    salt.state:
        - tgt: 'roles:ceph-client'
        - tgt_type: grain
        - sls:
            - ceph.client
        - require:
            - salt: setup_osd

init_pool:
    salt.state:
        - tgt: 'roles:ceph-ctl'
        - tgt_type: grain
        - sls:
            - ceph.init
        - require:
            - salt: setup_ceph_client
