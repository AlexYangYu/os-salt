# vi: set ft=yaml.jinja :

rabbitmq:
    server:
        bind_interface: all
        bind_port: 5672 
        handshake_timeout: 10000
        vm_memory_high_watermark: 0.015
        vm_memory_high_watermark_paging_ratio: 0.75
        log_levels:
            connection: info
            mirroring: info
        default_vhost: /
        default_user: guest 
        default_pass: guest 
        default_user_tags: administrator
        default_permissions: <<".*">>, <<".*">>, <<".*">> 
        cluster_partition_handling: ignore
