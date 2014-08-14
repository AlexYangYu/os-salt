include:
  - openstack.neutron.configuration

neutron-vpnaas:
  pkg.installed:
    - pkgs:
      - neutron-vpn-agent
      - openswan
    - require_in:
      - file: neutron-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: neutron-vpn-agent
    - enable: True
    - require:
      - pkg: neutron-vpnaas
    - watch:
      - file: neutron-conf
