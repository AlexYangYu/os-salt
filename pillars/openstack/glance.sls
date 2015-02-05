# vi: set ft=yaml.jinja :

glance:
    default:
        debug: false
        verbose: true 
        workers: 4
        show_image_direct_url: true
        default_store: rbd
        bind_interface: em2
        api_bind_host: 0.0.0.0
        api_bind_port: 19292
        registry_bind_host: 0.0.0.0
        registry_bind_port: 19191
    database:
        mysql_user: glance
        mysql_pass: glance_pass
        mysql_db: glance
        idle_timeout: 300
        max_pool_size: 30
        max_retries: -1
        max_overflow: 60
    paste_deploy:
        flavor: keystone
    rbd_store:
        conf: /etc/ceph/ceph.conf
        user: glance
        pool: images
        chunk_size: 8
    file_store:
        data_dir: /var/lib/glance/images/
