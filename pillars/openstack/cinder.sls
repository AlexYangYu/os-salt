# vi: set ft=yaml.jinja :

cinder:
    default:
        debug: false 
        verbose: true
        notification_driver: cinder.openstack.common.notifier.rpc_notifier
        auth_strategy: keystone
        default_store: rbd
        bind_interface: em2
        api_bind_host: 0.0.0.0
        api_bind_port: 18776
    database:
        mysql_user: cinder 
        mysql_pass: cinder_pass
        mysql_host: mysql-server 
        mysql_db: cinder 
        idle_timeout: 300
        max_pool_size: 30
        max_retries: -1
    volume:
        driver: cinder.volume.drivers.rbd.RBDDriver
    rbd_store:
        conf: /etc/ceph/ceph.conf
        user: cinder
        pool: volumes
        max_clone_depth: 5
        chunk_size: 4
        secert_uuid: 457eb676-33da-42ec-9a8c-9293d545c388
    backup:
        driver: cinder.backup.drivers.ceph
        store: rbd
        pool: backups
        conf: /etc/ceph/ceph.conf
        chunk_size: 134217728
        stripe_unit: 0
        stripe_count: 0
