neutron:
  default:
    debug: true
    verbose: true
    core_plugin: ml2
    service_plugins: router
    auth_strategy: keystone
    allow_bulk: true
    allow_overlapping_ips: true
    agent_down_time: 15
    firewall_driver: neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
  database:
    mysql_user: neutron 
    mysql_pass: neutron_pass
    mysql_host: cloud-t1.datayes.com
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
    mechanism_drivers: openvswitch
    vxlan:
      vni_ranges: 1:10000
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
  ovs:
    tunnel_type: vxlan
    enable_tunneling: true