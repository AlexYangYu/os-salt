setup_mon:
  salt.state:
    - tgt: 'roles:ceph-mon'
    - tgt_type: grain
    - sls: ceph.mon

setup_osd:
  salt.state:
    - tgt: 'roles:ceph-osd'
    - tgt_type: grain
    - sls: ceph.osd
    - require:
      - salt: setup_mon
