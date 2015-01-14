# vi: set ft=yaml.jinja :

roles:
  controller:
    - ntp-server
    - ceph-client
    - mysql-server
    - mysql-client
  os-ctl:
    - ntp-client
    - ceph-client
    - mysql-client
  os-cp1: 
    - ntp-client
    - ceph-mon
    - ceph-osd
    - mysql-cluster
    - mysql-cluster-donor
    - mysql-client
  os-cp2:
    - ntp-client
    - ceph-mon
    - ceph-osd
    - mysql-cluster
    - mysql-client
  os-cp3:
    - ntp-client
    - ceph-mon
    - ceph-osd
    - mysql-cluster
    - mysql-client
