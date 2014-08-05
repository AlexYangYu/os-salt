include:
  - openstack.glance.configuration

glance-registry:
  pkg.installed:
    - name: glance-registry
    - require_in:
      - file: glance-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: glance-registry
    - enable: True
