nodes:
  os-cp1:
    roles:
      - ceph-mon
      - ceph-osd
    devs:
      sdb:
        journal: sdb
      sdc:
        journal: sdc
      sdd:
        journal: sdd
      sde:
        journal: sde
  os-cp2:
    roles:
      - ceph-mon
      - ceph-osd
    devs:
      sdb:
        journal: sdb
      sdc:
        journal: sdc
      sdd:
        journal: sdd
      sde:
        journal: sde
  os-cp3:
    roles:
      - ceph-mon
      - ceph-osd
    devs:
      sdb:
        journal: sdb
      sdc:
        journal: sdc
      sdd:
        journal: sdd
      sde:
        journal: sde
