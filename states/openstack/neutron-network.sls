include:
  - openstack.neutron-configuration

neutron-network-packages:
  pkg.installed:
    - pkgs:
      - neutron-dhcp-agent
      - neutron-metadata-agent
