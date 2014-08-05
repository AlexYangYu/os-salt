include:
  - openstack.glance.configuration

glance-api:
  pkg.installed:
    - name: glance-api
    - require_in:
      - file: glance-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: glance-api
    - enable: True
