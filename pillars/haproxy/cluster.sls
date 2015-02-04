# vi: set ft=yaml.jinja :

ha_cluster:
    mariadb_cluster:
        role: mysql-cluster
        endpoint: vip-mysql-server
        bind_port: 3307
        conn_interface: em1
        check_user: clustercheckuser
        check_pass: clustercheckpassword!
        balance: source
    keystone:
        role: keystone-api
        endpoint: vip-keystone-api
        admin_bind_port: 35357
        public_bind_port: 5000
        balance: source
    glance_api:
        role: glance-api  
        endpoint: vip-glance-api
        bind_port: 9292
        balance: source
    glance_registry:
        role: glance-registry
        endpoint: vip-glance-registry
        bind_port: 9191
        balance: source
