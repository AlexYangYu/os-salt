roles:
  controller:
    - ntp-server
    - ceph-client
  os-ctl:
    - ntp-client
    - ceph-client
  os-cp1: 
    - ntp-client
    - ceph-mon
    - ceph-osd
  os-cp2:
    - ntp-client
    - ceph-mon
    - ceph-osd
  os-cp3:
    - ntp-client
    - ceph-mon
    - ceph-osd
