include:
  - openstack.heat.configuration

heat-api-cfn:
  pkg.installed:
    - name: heat-api-cfn
    - require_in:
      - file: heat-configuration
    - require:
      - cmd: update-apt-index
  service.running:
    - name: heat-api-cfn
    - enable: True
