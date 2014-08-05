include:
  - openstack.heat.configuration

heat-engine:
  pkg.installed:
    - name: heat-engine
    - require_in:
      - file: heat-configuration
    - require:
      - cmd: update-apt-index
  service.running:
    - name: heat-engine
    - enable: True
