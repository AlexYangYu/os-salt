include:
  - openstack.neutron-configuration

neutron-compute-packages:
  pkg.installed:
    - pkgs:
      - neutron-common
      - neutron-plugin-ml2
      - neutron-plugin-openvswitch-agent
      - openvswitch-datapath-dkms
    - require_in:
      - file: /etc/neutron
