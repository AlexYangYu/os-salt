neutron:
  default:
    debug: true
    verbose: true
    core_plugin: ml2 
    neutron_plugin_config: /etc/neutron/plugins/ml2/ml2_conf.ini
    service_plugins: router,lbaas,vpnaas
    auth_strategy: keystone
    allow_bulk: true
    allow_overlapping_ips: true
    agent_down_time: 15
    firewall_driver: neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
  database:
    mysql_user: neutron 
    mysql_pass: neutron_pass
    mysql_host: mysql-server 
    mysql_db: neutron
    max_pool_size: 30
    max_retries: -1
    max_overflow: 60
  quotas:
    quota_driver: neutron.db.quota_db.DbQuotaDriver 
    quota_items: network,subnet,port
    default_quota: -1
    quota_network: 50
    quota_subnet: 50
    quota_port: 250
    quota_security_group: -1
    quota_security_group_rule: -1
    quota_vip: -1 
    quota_pool: 10
    quota_member: -1
    quota_router: 50
    quota_floatingip: 250
    quota_network_gateway: -1
    quota_health_monitors: -1
    quota_firewall_policy: -1
    quota_packet_filter: 100
    quota_firewall_rule: -1
    quota_firewall: -1
  agent:
    report_interval: 5
  ml2:
    type_drivers: vxlan 
    tenant_network_types: vxlan 
    mechanism_drivers: openvswitch,l2population
    gre:
      tunnel_id_ranges: 1:10000
    vxlan:
      vni_ranges: 500:10000
      vxlan_group: 239.1.1.1
    securitygroup:
      enable_security_group: true
      firewall_driver: neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
  l3:
    interface_driver: neutron.agent.linux.interface.OVSInterfaceDriver
    use_namespaces: true
    external_network_bridge: br-ex
    enable_multi_host: true
    metadata_port: 8775 
  dhcp:
    interface_driver: neutron.agent.linux.interface.OVSInterfaceDriver
    use_namespaces: true
    enable_multi_host: true
    enable_isolated_metadata: false
    dhcp_domain: datayes.com
    dhcp_driver: neutron.agent.linux.dhcp.Dnsmasq
    dnsmasq_config_file: /etc/neutron/dnsmasq.conf
  ovs:
    tunnel_type: vxlan 
    enable_tunneling: true
    network_vlan_ranges: pyhsnet1
    bridge_mappings: pyhsnet1:br-ex
    tunnel_id_ranges: 500:10000
    integration_bridge: br-int
    tunnel_bridge: br-tun
    int_peer_patch_port: patch-tun
    tun_peer_patch_port: patch-int
    agent:
      polling_interval: 2
      l2_population: true 
      tunnel_types: vxlan
    securitygroup:
      enable_security_group: true
      firewall_driver: neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
  lbaas:
    debug: True
    periodic_interval: 10
    interface_driver: neutron.agent.linux.interface.OVSInterfaceDriver
    ovs_use_veth: false
    device_driver: neutron.services.loadbalancer.drivers.haproxy.namespace_driver.HaproxyNSDriver
    haproxy:
      loadbalancer_state_path: $state_path/lbaas
      user_group: nogroup
      send_gratuitous_arp: 3
  vpn:
    vpn_device_driver: neutron.services.vpn.device_drivers.ipsec.OpenSwanDriver
    ipsec_status_check_interval: 60
