mon_setup:
  salt.state:
    - tgt: 'roles:ceph-mon'
    - tgt_type: grain
    - sls: ceph.mon
