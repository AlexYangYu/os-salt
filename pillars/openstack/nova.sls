# vi: set ft=yaml.jinja :

nova:
    default:
        verbose: true
        debug: false
        api_workers: 8
        linuxnet_interface_driver: nova.network.linux_net.LinuxOVSInterfaceDriver
        firewall_driver: nova.virt.firewall.NoopFirewallDriver
        default_store: rbd
        bind_interface: em2
        ec2_api_port: 18773
        nova_api_port: 18774
        meta_api_port: 18775
        resume_guests_state_on_host_boot: true
        vcpu_pin_set: 4-$
        cpu_allocation_ratio: 4.0
        ram_allocation_ratio: 1.0
        reserved_host_memory_mb: 4096
        reserved_host_disk_mb: 10240
    database:
        mysql_user: nova
        mysql_pass: nova_pass
        mysql_db: nova
        idle_timeout: 300
        max_pool_size: 30
        max_retries: -1
        max_overflow: 60
    neutron:
        metadata_proxy_shared_secret: 123456
    vnc:
        enabled: true
        vncserver_listen: 0.0.0.0 
        vncserver_proxyclient_address: 127.0.0.1 
        novncproxy_host: 0.0.0.0
        novncproxy_port: 6080
    compute:
        compute_driver: libvirt.LibvirtDriver
        force_config_drive: true
        libvirt:
            virt_type: kvm 
            disk_cachemodes: file=default, network=none, block=none
            images_type: rbd
            inject_key: False
            inject_password: False
            inject_partition: -2
            live_migration_flag: VIR_MIGRATE_UNDEFINE_SOURCE,VIR_MIGRATE_PEER2PEER,VIR_MIGRATE_LIVE,VIR_MIGRATE_PERSIST_DEST
    rbd_store:
        conf: /etc/ceph/ceph.conf
        pool: vms
        user: cinder
