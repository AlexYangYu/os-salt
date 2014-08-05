include:
  - openstack.nova.configuration

nova-api:
  pkg.installed:
    - name: nova-api
    - require_in:
      - file: nova-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: nova-api
    - enable: True
