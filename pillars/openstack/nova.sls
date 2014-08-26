nova:
  default:
    verbose: true
    debug: true
    api_workers: 8
    linuxnet_interface_driver: nova.network.linux_net.LinuxOVSInterfaceDriver
    firewall_driver: nova.virt.firewall.NoopFirewallDriver
  database:
    mysql_user: nova
    mysql_pass: nova_pass
    mysql_host: mysql-server 
    mysql_db: nova
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
    virt_type: kvm 
    force_config_drive: true
