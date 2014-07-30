include:
  - openstack.neutron.configuration

neutron-dhcp:
  pkg.installed:
    - name: neutron-dhcp-agent
    - require_in:
      - file: neutron-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: neutron-dhcp-agent
    - enable: True
    - require:
      - pkg: neutron-dhcp
    - watch:
      - file: neutron-conf
