include:
  - openstack.nova.configuration

nova-conductor:
  pkg.installed:
    - name: nova-conductor
    - require_in:
      - file: nova-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: nova-conductor
    - enable: True
