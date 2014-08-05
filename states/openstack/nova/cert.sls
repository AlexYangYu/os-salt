include:
  - openstack.nova.configuration

nova-cert:
  pkg.installed:
    - name: nova-cert
    - require_in:
      - file: nova-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: nova-cert
    - enable: True
