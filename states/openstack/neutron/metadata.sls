include:
  - openstack.neutron.configuration

neutron-metadata:
  pkg.installed:
    - name: neutron-metadata-agent
    - require_in:
      - file: neutron-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: neutron-metadata-agent
    - enable: True
    - require:
      - pkg: neutron-metadata
    - watch:
      - file: neutron-conf
