include:
  - openstack.neutron.configuration

neutron-metering:
  pkg.installed:
    - pkgs:
      - neutron-metering-agent
      - openswan
    - require_in:
      - file: neutron-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: neutron-metering-agent
    - enable: True
    - require:
      - pkg: neutron-metering
    - watch:
      - file: neutron-conf
