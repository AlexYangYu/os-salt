include:
  - openstack.neutron.configuration

neutron-lbaas:
  pkg.installed:
    - name: neutron-lbaas-agent
    - require_in:
      - file: neutron-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: neutron-lbaas-agent
    - enable: True
    - require:
      - pkg: neutron-lbaas
    - watch:
      - file: neutron-conf
