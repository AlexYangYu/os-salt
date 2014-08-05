include:
  - openstack.heat.configuration

heat-api:
  pkg.installed:
    - name: heat-api
    - require_in:
      - file: heat-configuration
    - require:
      - cmd: update-apt-index
  service.running:
    - name: heat-api
    - enable: True
