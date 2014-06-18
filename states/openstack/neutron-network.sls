include:
  - openstack.neutron-configuration

neutron-network-packages:
  pkg.installed:
    - pkgs:
      - neutron-plugin-ml2
      - neutron-plugin-openvswitch-agent
      - openvswitch-datapath-dkms
      - neutron-l3-agent
      - neutron-dhcp-agent
      - neutron-lbaas-agent
      - neutron-metadata-agent
      - neutron-metering-agent

sysctl-conf:
  file.managed:
    - source: salt://base/60-ip-forwarding.conf 
    - name: /etc/sysctl.d/60-ip-forwarding.conf

sysctl-enable:
  cmd.run:
    - name: sysctl -p /etc/sysctl.d/60-ip-forwarding.conf
    - require:
      - file: /etc/sysctl.d/60-ip-forwarding.conf
