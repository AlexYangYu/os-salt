# vi: set ft=yaml.jinja :

ha_cluster:
    mariadb_cluster:
        role: mysql-cluster
        endpoint: vip-mysql-server
        bind_port: 3307
        conn_interface: em1
        check_user: haproxy
    keystone:
        role: keystone-api
        endpoint: vip-keystone-api
        admin_bind_port: 35357
        public_bind_port: 5000
