include:
  - openstack.keystone.configuration

keystone-api:
  pkg.installed:
    - name: keystone
    - require_in:
      - file: keystone-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: keystone
    - enable: True
