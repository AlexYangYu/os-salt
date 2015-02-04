# vi: set ft=yaml.jinja :

roles:
    controller:
        - ntp-server
        - ceph-client
        - mysql-server
        - mysql-client
        - haproxy
        - ha-master
        - openstack-init
        - keystone-api
        - glance-api
        - glance-registry
        - cinder-api
        - cinder-scheduler
        - cinder-volume
    os-ctl:
        - ntp-client
        - ceph-client
        - mysql-client
        - haproxy
        - ha-slave
        - keystone-api
        - glance-api
        - glance-registry
        - cinder-api
        - cinder-scheduler
        - cinder-volume
    os-cp1: 
        - ntp-client
        - ceph-ctl
        - ceph-mon
        - ceph-osd
        - mysql-cluster
        - mysql-cluster-donor
        - mysql-client
        - rabbitmq-ram
    os-cp2:
        - ntp-client
        - ceph-mon
        - ceph-osd
        - mysql-cluster
        - mysql-client
        - rabbitmq-ram
    os-cp3:
        - ntp-client
        - ceph-mon
        - ceph-osd
        - mysql-cluster
        - mysql-client
        - rabbitmq-disc
