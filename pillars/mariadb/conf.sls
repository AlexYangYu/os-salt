# vi: set ft=yaml.jinja :

mariadb:
    admin_user: root
    admin_pass: r00t
    maintenance_pass: vZL3kMYwuHifuTRW
    source:
        apt_source: apt-server
        apt_key: http://controller.wx-datayes.com/keys/mariadb
    server:
        bind_interface: em1
        bind_address: 0.0.0.0
        port: 3306
        max_connections: 3000
        max_connect_errors: 30
        back_log: 500
        open_files_limit: 1024 
        table_cache: 1024
        binlog_cache_size: 16M
        max_binlog_size: 100M
        max_heap_table_size: 128M
        sort_buffer_size: 32M
        join_buffer_size: 32M
        thread_cache_size: 128
        query_cache_size: 128M
        query_cache_limit: 4M
        tmp_table_size: 128M
        slow_query_log: 1
        long_query_time: 5
        innodb:
            innodb_open_files: 1024
            innodb_additional_mem_pool_size: 128M
            innodb_buffer_pool_size: 12G 
            innodb_log_file_size: 16M
            innodb_flush_log_at_trx_commit: 1

mariadb_cluster:
    wsrep_cluster_name: openstack
    wsrep_provider: /usr/lib/galera/libgalera_smm.so     
    wsrep_provider_options: gcache.size=256M; gcache.page_size=128M
    wsrep_slave_threads: 4
    wsrep_sst_method: xtrabackup
    wsrep_sst_user: sst
    wsrep_sst_pass: sst_pass
