# vi: set ft=yaml.jinja :

cinder:
    default:
        debug: false 
        verbose: true
        notification_driver: cinder.openstack.common.notifier.rpc_notifier
        auth_strategy: keystone
        default_store: rbd
    database:
        mysql_user: cinder 
        mysql_pass: cinder_pass
        mysql_host: mysql-server 
        mysql_db: cinder 
        max_pool_size: 30
        max_retries: -1
    rbd_store:
        conf: /etc/ceph/ceph.conf
        user: cinder
        pool: volumes
    backup:
        store: rbd
        pool: backups
        conf: /etc/ceph/ceph.conf
