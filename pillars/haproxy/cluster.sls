# vi: set ft=yaml.jinja :

ha_cluster:
    mariadb_cluster:
        role: mysql-cluster
        bind_interface: em2        
        conn_interface: em1
        bind_port: 3307
        check_user: haproxy
